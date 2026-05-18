from app.core.database import db

class Year(db.Model):

    __tablename__ = "years"

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    year_name = db.Column(db.String(100), unique=True, nullable=False)
    
