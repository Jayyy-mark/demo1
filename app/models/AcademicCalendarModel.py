from app.core.database import db
import os
from werkzeug.utils import secure_filename
from flask import current_app

class AcademicCalendar(db.Model):

    __tablename__ = "academic_calendars"

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)

    title = db.Column(db.String(100), unique=False, nullable=True)
    description = db.Column(db.Text, unique=False, nullable=True)
    status = db.Column(db.String(20), unique=False, nullable=False, server_default="Pending")
    start_date = db.Column(db.Date, unique=False, nullable=False)
    end_date = db.Column(db.Date, unique=False, nullable=False)
