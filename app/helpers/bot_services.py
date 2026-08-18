import os
import uuid
import chromadb
from collections import deque
from langchain_core.documents import Document
from langchain_text_splitters import RecursiveCharacterTextSplitter
from pypdf import PdfReader
from google import genai
from google.genai import types
from flask import current_app
from pathlib import Path

#################################################
# GEMINI
#################################################

client = genai.Client()

#################################################
# CHROMA  (document RAG — persistent)
#################################################

BASE_DIR = os.path.dirname(os.path.abspath(__file__))

VECTOR_DB_PATH = os.path.join(BASE_DIR, "..", "resources", "assets", "bot", "vector_db")

os.makedirs(VECTOR_DB_PATH, exist_ok=True)

doc_client = chromadb.PersistentClient(path=VECTOR_DB_PATH)

doc_collection = doc_client.get_or_create_collection(name="documents")

#################################################
# CHAT HISTORY  (server-side, tab-scoped)
#
#   chat_histories: { session_id -> deque([msg, ...]) }
#
#   Each session keeps at most MAX_QA_PAIRS * 2
#   messages (question + answer = 2 per pair).
#   The deque drops the oldest pair automatically
#   when it overflows (maxlen=10 by default).
#
#   Session is created on first /ask and removed
#   when the browser calls /clear-history via
#   navigator.sendBeacon on tab close.
#
#   No embedding API calls are needed for history.
#################################################

MAX_QA_PAIRS = 5

chat_histories: dict = {}


def get_or_create_history(session_id: str) -> deque:
    """Return the deque for *session_id*, creating it if needed."""
    if session_id not in chat_histories:
        chat_histories[session_id] = deque(maxlen=MAX_QA_PAIRS * 2)
    return chat_histories[session_id]


def append_history(session_id: str, question: str, answer: str) -> None:
    """Append one Q/A pair to the session history."""
    history = get_or_create_history(session_id)
    history.append({"role": "user", "content": question})
    history.append({"role": "assistant", "content": answer})


def clear_history(session_id: str) -> None:
    """Remove the session history (called on tab close via /clear-history)."""
    chat_histories.pop(session_id, None)


def build_history_block(session_id: str) -> str:
    """Return a formatted conversation string for the prompt."""
    if session_id not in chat_histories:
        return ""
    lines = []
    for msg in chat_histories[session_id]:
        role = msg["role"].capitalize()
        content = msg["content"]
        lines.append(f"{role}: {content}")
    return "\n".join(lines)


# <!--==========================================
#   REMOTE AI SERVER
# ============================================-->
import requests


BOT_SERVER_URL = os.getenv("BOT_SERVER_URL", "https://bot-0s3f.onrender.com")


# =========================================================
# ASK
# =========================================================


def ask_bot(prompt: str):

    if not prompt:
        raise ValueError("Prompt cannot be empty.")

    print("[BOT] Sending prompt to bot server...", flush=True)

    response = requests.post(
        f"{BOT_SERVER_URL}/ask", json={"prompt": prompt}, timeout=180
    )

    if not response.ok:

        raise RuntimeError(f"Bot server /ask failed: " f"{response.text}")

    data = response.json()

    answer = data.get("answer")

    if not answer:

        raise RuntimeError("Bot server did not return an answer.")

    print("[BOT] Answer received", flush=True)

    return answer


# =========================================================
# DOCUMENT EMBEDDINGS
# =========================================================


def get_document_embeddings(texts):

    if not texts:
        return []

    print(f"[BOT] Requesting {len(texts)} document embeddings...", flush=True)

    response = requests.post(
        f"{BOT_SERVER_URL}/embedding/documents", json={"texts": texts}, timeout=300
    )

    if not response.ok:

        raise RuntimeError(f"Bot server embedding failed: " f"{response.text}")

    data = response.json()

    embeddings = data.get("embeddings")

    if embeddings is None:

        raise RuntimeError("Bot server did not return embeddings.")

    return embeddings


# =========================================================
# QUERY EMBEDDING  (document retrieval only — NOT used for history)
# =========================================================


def get_query_embedding(text):

    if not text:
        raise ValueError("Query cannot be empty.")

    print("[BOT] Requesting query embedding...", flush=True)

    response = requests.post(
        f"{BOT_SERVER_URL}/embeddings/userQuery", json={"text": text}, timeout=60
    )

    if not response.ok:

        raise RuntimeError(f"Bot server query embedding failed: " f"{response.text}")

    data = response.json()

    embedding = data.get("embedding")

    if embedding is None:

        raise RuntimeError("Bot server did not return query embedding.")

    return embedding


def get_embedding(text: str):
    response = client.models.embed_content(
        model="gemini-embedding-001",
        contents=text,
        config=types.EmbedContentConfig(
            task_type="RETRIEVAL_DOCUMENT", output_dimensionality=768
        ),
    )

    return response.embeddings[0].values


# =========================================================
# PDF EXTRACTION
# =========================================================


def load_pdf(pdf_path: str):

    print(f"[PDF] Opening: {pdf_path}", flush=True)

    reader = PdfReader(pdf_path)

    documents = []

    total_pages = len(reader.pages)

    print(f"[PDF] Total pages: {total_pages}", flush=True)

    for page_number, page in enumerate(reader.pages, start=1):

        try:

            text = page.extract_text()

        except Exception as e:

            print(f"[PDF] Page {page_number} failed: {repr(e)}", flush=True)

            continue

        if not text:
            continue

        text = text.strip()

        if not text:
            continue

        documents.append(
            Document(
                page_content=text,
                metadata={"source": os.path.basename(pdf_path), "page": page_number},
            )
        )

    print(f"[PDF] Pages with text: {len(documents)}", flush=True)

    return documents


# def read_pdf(file_path):
#     reader = PdfReader(file_path)

#     text = ""

#     for page in reader.pages:
#         page_text = page.extract_text()

#         if page_text:
#             text += page_text + "\n"

#     return text


#################################################
# CHUNKING
#################################################


def create_chunks(documents):

    print("[CHUNKING] Starting...", flush=True)

    splitter = RecursiveCharacterTextSplitter(chunk_size=1200, chunk_overlap=250)

    chunks = splitter.split_documents(documents)

    print(f"[CHUNKING] Created {len(chunks)} chunks", flush=True)

    return chunks


# def chunk_text(text, chunk_size=800):
#     return [text[i : i + chunk_size] for i in range(0, len(text), chunk_size)]


#################################################
# INGEST DOCUMENTS
#################################################


def ingest_documents():

    folder = os.path.join(
        current_app.root_path, "resources", "assets", "bot", "knowledge"
    )

    print("📄 Building Vector Database...", flush=True)

    global doc_collection

    # -----------------------------------------------------
    # Delete old collection
    # -----------------------------------------------------

    collections = [c.name for c in doc_client.list_collections()]

    if "documents" in collections:

        doc_client.delete_collection("documents")

    doc_collection = doc_client.create_collection(name="documents")

    # -----------------------------------------------------
    # PDFs
    # -----------------------------------------------------

    for file in os.listdir(folder):

        if not file.lower().endswith(".pdf"):
            continue

        print(f"[PDF] Processing: {file}", flush=True)

        path = os.path.join(folder, file)

        documents = load_pdf(path)

        chunks = create_chunks(documents)

        if not chunks:
            continue

        # -------------------------------------------------
        # Extract text
        # -------------------------------------------------

        texts = [chunk.page_content for chunk in chunks]

        # -------------------------------------------------
        # Bot server
        # -------------------------------------------------

        embeddings = get_document_embeddings(texts)

        if len(embeddings) != len(texts):

            raise RuntimeError("Embedding count does not match " "chunk count.")

        # -------------------------------------------------
        # Chroma
        # -------------------------------------------------

        ids = [str(uuid.uuid4()) for _ in chunks]

        metadatas = [
            {"source": file, "page": chunk.metadata.get("page")} for chunk in chunks
        ]

        doc_collection.add(
            ids=ids, documents=texts, embeddings=embeddings, metadatas=metadatas
        )

        print(f"[CHROMA] Added {len(chunks)} chunks", flush=True)

    print("✅ Vector Database Updated", flush=True)


#################################################
# SEARCH DOCUMENTS (RAG)
#################################################


def search_docs(question):

    if doc_collection.count() == 0:

        return None

    print("[RAG] Requesting query embedding...", flush=True)

    q_emb = get_query_embedding(question)

    results = doc_collection.query(query_embeddings=[q_emb], n_results=5)

    docs = results.get("documents", [[]])[0]

    distances = results.get("distances", [[]])[0]

    if not docs:
        return None

    if distances and distances[0] > 1.2:
        return None

    return "\n\n".join(docs)


#################################################
# UNIVERSITY QUESTION DETECTOR
#################################################

UNIVERSITY_KEYWORDS = [
    "ucst",
    "university",
    "taungoo",
    "office",
    "department",
    "major",
    "course",
    "admission",
    "rector",
    "dean",
    "faculty",
    "semester",
    "exam",
    "student affairs",
]


def is_university_question(question):

    q = question.lower()

    return any(keyword in q for keyword in UNIVERSITY_KEYWORDS)


#################################################
# ASK  (main entry point)
#################################################


def ask(question: str, session_id: str = None):

    # --------------------------------------------------
    # 1. Document context  (RAG — Chroma)
    # --------------------------------------------------

    context = search_docs(question)

    if context is None:
        context = "NO_RELEVANT_CONTEXT_FOUND"

    if is_university_question(question) and context == "NO_RELEVANT_CONTEXT_FOUND":

        return (
            "I'm sorry, but I don't have information "
            "about that in my knowledge base."
        )

    # --------------------------------------------------
    # 2. Conversation history  (plain dict — no API)
    # --------------------------------------------------

    history_block = build_history_block(session_id) if session_id else ""

    # --------------------------------------------------
    # 3. Build prompt
    # --------------------------------------------------

    prompt = f"""
    You are an AI assistant for
    University of Computer Studies Taungoo.

    You are helpful, friendly, concise,
    and accurate. 

    LANGUAGE AND TONE:
    - Respond primarily in Burmese (Myanmar) language.
    - Use English for technical terms, proper nouns,
    names, or specific terms when appropriate.
    - Use natural, clear, and respectful Burmese.
    - Maintain a polite and professional tone.
    - Communicate with the warm, gentle, and courteous
    style of a university assistant.
    - Avoid overly casual language.
    - Keep responses concise unless the user asks for
    detailed explanations.

    UNIVERSITY INFORMATION:

    Rector:
    Dr. Ei Ei Hlaing
    (ဒေါက်တာအိအိလှိုင်)

    Location:
    Kanyoe Village
    (ကန်ရိုးကျေးရွာ),
    Taungoo, Bago Region.

    Total Students in university for current(လက်ရှိ ကျောင်းသားအရေအတွက်):
    541
    Computer Science (CS) -major:443
    Computer Technology (CT)-major:98

    RULES:

    1. Use conversation history to understand
    references to previous messages.

    2. If the user's question is answered by
    the document context, prioritize the
    document context.

    3. Do not invent facts from the document.

    4. If the question is specifically about
    the uploaded document and the supplied
    context does not contain the answer,
    say that the available document context
    does not contain enough information.

    5. General questions about programming,
    computer science, mathematics,
    technology, AI, and science may be
    answered using general knowledge.

    6. Respond naturally to greetings and
    normal conversation.

    7. Do not include source page references.

    Conversation History:

    {history_block}

    Document Context:

    {context}

    Question:

    {question}

    For the reply language, use Myanmar Language
    (Burmese), but technical terms or specific
    words may remain in English.
    """

    # --------------------------------------------------
    # 4. Call Bot Server
    # --------------------------------------------------

    answer = ask_bot(prompt)

    # --------------------------------------------------
    # 5. Save Q/A to in-memory session history
    # --------------------------------------------------

    if session_id:
        append_history(session_id, question, answer)

    return answer


# <!--==========================================
#   EXTRACT PDF PAGES FOR SEARCHING
# ============================================-->


def extract_pdf_pages(path):
    reader = PdfReader(path)

    pages = []

    for i, page in enumerate(reader.pages):
        text = page.extract_text() or ""

        pages.append({"page": i + 1, "text": text})

    return pages


def get_knowledge_pdf_path():
    knowledge_dir = (
        Path(__file__).resolve().parent.parent
        / "resources"
        / "assets"
        / "bot"
        / "knowledge"
    )

    pdf_files = list(knowledge_dir.glob("*.pdf"))

    return str(pdf_files[0]) if pdf_files else None
