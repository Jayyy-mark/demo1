from app.core.database import db

class Count(db.Model):

    __tablename__ = "counts"

    id = db.Column(db.Integer, autoincrement=True, primary_key=True)
    total_student = db.Column(db.Integer,nullable=False)
    total_staff = db.Column(db.Integer, nullable=False)
    graduated_student = db.Column(db.Integer, nullable=False)
    current_student = db.Column(db.Integer, nullable=False)
    