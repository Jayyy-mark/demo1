from app.core.database import db

class Course(db.Model):

    __tablename__ = "courses"

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    course_id = db.Column(db.String(100), unique=False, nullable=False)
    course_name = db.Column(db.String(200), unique=False, nullable=False)
    subject_id = db.Column(db.Integer, db.ForeignKey("subjects.id", ondelete="CASCADE"), nullable=False, index=True)
    semester_id = db.Column(db.Integer, db.ForeignKey("semesters.id", ondelete="CASCADE"), nullable=False, index=True)

    subject = db.relationship("Subject", backref=db.backref("courses", cascade="all, delete-orphan"))
    semester = db.relationship("Semester", backref=db.backref("courses", cascade="all, delete-orphan"))

     
