from app.core.database import db
from flask import current_app
from werkzeug.utils import secure_filename
import os


class Collaboration(db.Model):

    __tablename__ = "collabroations"

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    logo = db.Column(db.String(200), unique=False, nullable=False)
    company_name = db.Column(db.String(200), unique=False, nullable=False)
    description = db.Column(db.Text(), unique=False, nullable=True)
    url = db.Column(db.String(200), unique=False, nullable=True)

    @staticmethod
    def save_file(file):

        upload_folder = os.path.join(
            current_app.root_path, "resources", "assets", "media", "collaborations"
        )

        # create folder if not exists
        os.makedirs(upload_folder, exist_ok=True)

        # secure filename
        filename = secure_filename(file.filename)

        # full file path
        filepath = os.path.join(upload_folder, filename)

        # save file
        file.save(filepath)

        filepath = os.path.join("media/collaborations", filename)

        return filename, filepath

    @staticmethod
    def delete_file(filename):
        path = os.path.join(
            current_app.root_path,
            "resources",
            "assets",
            "media",
            "collaborations",
            filename,
        )

        if os.path.exists(path):
            os.remove(path)
