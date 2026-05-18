from app.core.database import db
import os
from werkzeug.utils import secure_filename
from flask import current_app

class Research(db.Model):

    __tablename__ = "researches"

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)

    research_name = db.Column(db.String(100), unique=False, nullable=False)
    category = db.Column(db.String(100), unique=False, nullable=True)
    description = db.Column(db.Text, unique=False, nullable=True    )

    filename = db.Column(db.String(225), unique=True, nullable=False)
    filepath = db.Column(db.String(225), unique=True, nullable=False)

    date = db.Column(db.Date, unique=False, nullable=False)

    @staticmethod
    def save_file(file):

        upload_folder = os.path.join(
            current_app.root_path,
            "resources",
            "assets",
            "media",
            "researches"
        )

        
        # create folder if not exists
        os.makedirs(upload_folder, exist_ok=True)

        # secure filename
        filename = secure_filename(file.filename)

        # full file path
        filepath = os.path.join(upload_folder, filename)

        # save file
        file.save(filepath)  

        filepath = os.path.join("media/researches", filename)

        return filename, filepath   

    @staticmethod
    def delete_file(filename):
        path = os.path.join(
            current_app.root_path,
            "resources",
            "assets",
            "media",
            "researches",
            filename
        )

        if os.path.exists(path):
            os.remove(path)
