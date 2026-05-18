from app.core.database import db

class Semester(db.Model):

    __tablename__ = "semesters"

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    semester_name = db.Column(db.String(100), unique=True, nullable=False)
    semester_term = db.Column(db.String(100), unique=True, nullable=False)
    year_id = db.Column(db.Integer, db.ForeignKey("years.id", ondelete="CASCADE"), nullable=True)

    year = db.relationship("Year", backref=db.backref("semesters", cascade="all, delete-orphan"))