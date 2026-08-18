from flask import request, jsonify, current_app
from app.helpers.bot_services import (
    ask,
    ingest_documents,
    get_knowledge_pdf_path,
    extract_pdf_pages,
    clear_history,
)

import os


class BotController:

    def getAnswer():

        data = request.get_json(silent=True) or {}
        message = data.get("message")
        sid = data.get("session_id")  # tab-scoped session id

        try:
            response = ask(message, session_id=sid)

            return jsonify({"response": response, "session_id": sid})
        except Exception as e:
            print(f"[ERROR] : {e}")
            return jsonify({"error": str(e), "session_id": sid})

    def updateKnowledgeBase():

        print("Route is entered!")

        file = request.files.get("pdf")

        if not file or file.filename == "":
            return (
                jsonify(
                    {
                        "success": False,
                        "message": "No file has been uploaded for chatbot memory",
                    }
                ),
                400,
            )

        botMemoryDir = os.path.join(
            current_app.root_path, "resources", "assets", "bot", "knowledge"
        )

        # <!--===========================================
        #   DELETING OLD CHATBOT MEMORY PDF FILE
        # ============================================-->
        BotController.deleteOldMemoryFile(botMemoryDir)

        file.save(os.path.join(botMemoryDir, file.filename))

        ingest_documents()

        return (
            jsonify(
                {"success": True, "message": "Memory has been updated successfully!"}
            ),
            200,
        )

    def deleteOldMemoryFile(dir):

        for filename in os.listdir(dir):
            file_path = os.path.join(dir, filename)

            if os.path.isfile(file_path):
                os.remove(file_path)

    def searchDocument():

        keyword = request.args.get("q", "").lower()

        results = []

        kb_path = get_knowledge_pdf_path()

        if not kb_path:
            return (
                jsonify(
                    {
                        "success": False,
                        "message": "Knowledge file has not been uploaded!",
                    }
                ),
                404,
            )

        pdf_cache = extract_pdf_pages(kb_path)
        for page in pdf_cache:
            if keyword in page["text"].lower():

                index = page["text"].lower().find(keyword)

                snippet = page["text"][max(0, index - 80) : index + 120]

                results.append({"page": page["page"], "snippet": snippet})

        return jsonify(results)

    def clearHistory():
        """
        Called by navigator.sendBeacon when the browser tab is closed.
        Removes the session's chat history from server memory.
        """
        data = request.get_json(silent=True) or {}
        sid = data.get("session_id")

        if sid:
            clear_history(sid)

        return jsonify({"ok": True}), 200
