from datetime import datetime
from app.core.database import db


class Dashboard(db.Model):
    __tablename__ = "dashboards"

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    attr_key = db.Column(db.String(100), unique=True, nullable=False)
    value = db.Column(db.Text, unique=False, nullable=False)
    file = db.Column(db.Text, unique=False, nullable=True)
