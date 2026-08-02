from flask import Blueprint
from app.https.controllers.BotController import BotController

chatbot_api = Blueprint("chatbot_api", __name__, url_prefix="/api/chatbot/")

@chatbot_api.route("/ask", methods=["POST"])
def ask():
    return BotController.getAnswer()

@chatbot_api.route("/memory/update", methods=["PUT"])
def update_kb():
    return BotController.updateKnowledgeBase()

@chatbot_api.route("memory/search", methods=["GET"])
def search_kb():
    return BotController.searchDocument()

@chatbot_api.route("/clear-history", methods=["POST"])
def clear_history():
    return BotController.clearHistory()