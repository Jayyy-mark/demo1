from app.core.database import db
import os
from werkzeug.utils import secure_filename
from flask import current_app


class Activity(db.Model):

    __tablename__ = "activities"

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)

    activity_name = db.Column(db.Text, unique=False, nullable=False)
    category = db.Column(db.String(100), unique=False, nullable=True)
    description = db.Column(db.Text, unique=False, nullable=True)
    activity_type = db.Column(
        db.String(100), unique=False, nullable=False, server_default="Activity"
    )
    filename = db.Column(db.String(225), unique=True, nullable=True)
    filepath = db.Column(db.String(225), unique=True, nullable=True)

    date = db.Column(db.Date, unique=False, nullable=False)

    @staticmethod
    def save_file(file):
        if not file or not file.filename:
            return None, None

        upload_folder = os.path.join(
            current_app.root_path, "resources", "assets", "media", "activities"
        )

        # create folder if not exists
        os.makedirs(upload_folder, exist_ok=True)

        # secure filename
        filename = secure_filename(file.filename)

        # full file path
        filepath = os.path.join(upload_folder, filename)

        # save file
        file.save(filepath)

        filepath = os.path.join("media/activities", filename)

        return filename, filepath

    @staticmethod
    def delete_file(filename):
        if not filename:
            return

        path = os.path.join(
            current_app.root_path,
            "resources",
            "assets",
            "media",
            "activities",
            filename,
        )

        if os.path.exists(path):
            os.remove(path)
