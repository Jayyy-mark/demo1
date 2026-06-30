from flask import render_template, current_app
from . import admin_bp
from app.https.auth.decorators import login_required
import os

@admin_bp.route("/chatbot", methods=['GET'], endpoint="chatbot")
@login_required
def chatbot():

    kb_path = ""

    folder = os.path.join(
        current_app.static_folder,
        "bot",
        "knowledge"
    )

    for file in os.listdir(folder):
        if file.lower().endswith(".pdf"):
            kb_path= f"bot/knowledge/{file}"
    
    
    print("this is the file path : ", kb_path)
    return render_template("admin/chatbot.html", page="Chatbot", kb_path=kb_path)