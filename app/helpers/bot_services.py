import os
import uuid
import chromadb

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
# CHROMA
#################################################

BASE_DIR = os.path.dirname(os.path.abspath(__file__))

VECTOR_DB_PATH = os.path.join(BASE_DIR, "..", "resources", "assets", "bot", "vector_db")

os.makedirs(VECTOR_DB_PATH, exist_ok=True)

doc_client = chromadb.PersistentClient(path=VECTOR_DB_PATH)

doc_collection = doc_client.get_or_create_collection(name="documents")

#################################################
# CHAT MEMORY (IN MEMORY ONLY)
#################################################

chat_client = chromadb.Client()

chat_collection = chat_client.get_or_create_collection(name="chat_memory")

#################################################
# EMBEDDINGS
#################################################


def get_embedding(text: str):
    response = client.models.embed_content(
        model="gemini-embedding-001",
        contents=text,
        config=types.EmbedContentConfig(
            task_type="RETRIEVAL_DOCUMENT", output_dimensionality=768
        ),
    )

    return response.embeddings[0].values


#################################################
# PDF
#################################################


def read_pdf(file_path):
    reader = PdfReader(file_path)

    text = ""

    for page in reader.pages:
        page_text = page.extract_text()

        if page_text:
            text += page_text + "\n"

    return text


#################################################
# CHUNKING
#################################################


def chunk_text(text, chunk_size=800):
    return [text[i : i + chunk_size] for i in range(0, len(text), chunk_size)]


#################################################
# INGEST DOCUMENTS
#################################################


def ingest_documents():

    folder = os.path.join(
        current_app.root_path, "resources", "assets", "bot", "knowledge"
    )

    print("📄 Building Vector Database...")

    global doc_collection

    collections = [c.name for c in doc_client.list_collections()]

    if "documents" in collections:
        doc_client.delete_collection("documents")

    doc_collection = doc_client.create_collection(name="documents")

    for file in os.listdir(folder):

        if not file.endswith(".pdf"):
            continue

        print(f"Processing: {file}")

        path = os.path.join(folder, file)

        text = read_pdf(path)

        chunks = chunk_text(text)

        for chunk in chunks:

            emb = get_embedding(chunk)

            doc_collection.add(
                ids=[str(uuid.uuid4())],
                documents=[chunk],
                embeddings=[emb],
                metadatas=[{"source": file}],
            )

    print("✅ Vector Database Updated")


#################################################
# SEARCH
#################################################


def search_docs(question):

    if doc_collection.count() == 0:
        return None

    q_emb = get_embedding(question)

    results = doc_collection.query(query_embeddings=[q_emb], n_results=3)

    docs = results["documents"][0]
    distances = results["distances"][0]

    if not docs:
        return None

    if distances[0] > 1.2:
        return None

    return "\n\n".join(docs)


#################################################
# CHAT MEMORY
#################################################


def save_chat(user, bot):

    chat = f"User: {user}\nAssistant: {bot}"

    emb = get_embedding(chat)

    chat_collection.add(ids=[str(uuid.uuid4())], documents=[chat], embeddings=[emb])


def get_memory(question):

    if chat_collection.count() == 0:
        return ""

    q_emb = get_embedding(question)

    results = chat_collection.query(query_embeddings=[q_emb], n_results=5)

    return "\n".join(results["documents"][0])


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
# ASK
#################################################


def ask(question):

    context = search_docs(question)

    if context is None:
        context = "NO_RELEVANT_CONTEXT_FOUND"

    if is_university_question(question) and context == "NO_RELEVANT_CONTEXT_FOUND":
        return (
            "I'm sorry, but I don't have information "
            "about that in my knowledge base."
        )

    memory = get_memory(question)

    prompt = f"""
        You are an AI assistant for the University of Computer Studies (Taungoo).

        General questions:
        - mathematics
        - technology
        - programming
        - science
        - general knowledge

        Answer normally.

        University questions:
        - Use ONLY the Document Context.
        - Never make up university information.

        If Document Context is:

        NO_RELEVANT_CONTEXT_FOUND

        reply:

        I'm sorry, but I don't have information about that in my knowledge base.

        Conversation:
        {memory}

        Document Context:
        {context}

        Question:
        {question}

        for language for reply to user use Myanmar Language (Burmese) but for some technical terms or specific words use English.
    """

    response = client.models.generate_content(model="gemini-2.5-flash", contents=prompt)

    answer = response.text.strip()

    save_chat(question, answer)

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

