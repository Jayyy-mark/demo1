from app.core.database import db


class VisionMission(db.Model):

    __tablename__ = "vision_missions"

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    vision = db.Column(db.String(200), unique=False, nullable=False)
    mission = db.Column(db.String(200), unique=False, nullable=False)
    department_id = db.Column(
        db.Integer, db.ForeignKey("departments.id", ondelete="CASCADE"), nullable=True
    )

    department = db.relationship(
        "Department",
        backref=db.backref("vision_missions", cascade="all, delete-orphan"),
    )

    language = db.Column(
        db.String(20), unique=False, nullable=False, default="en", server_default="en"
    )
