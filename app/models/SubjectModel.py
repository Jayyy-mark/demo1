from app.core.database import db

class Subject(db.Model):

    __tablename__ = "subjects"

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    subject_code = db.Column(db.String(200), unique=False, nullable=True)
    subject_name = db.Column(db.String(200), unique=False, nullable=False)
    description = db.Column(db.String(200), unique=False, nullable=True)
    department_id = db.Column(db.Integer, db.ForeignKey("departments.id", ondelete="CASCADE"), nullable=True)

    department = db.relationship("Department", backref=db.backref("subjects", cascade="all, delete-orphan"))
    

    

     
