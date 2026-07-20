from datetime import datetime
from app.core.database import db
from werkzeug.security import generate_password_hash, check_password_hash


class User(db.Model):

    __tablename__ = "users"

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    user_id = db.Column(db.String(50), unique=True, nullable=False)
    user_name = db.Column(db.String(50), unique=True, nullable=False)
    user_email = db.Column(db.String(150), unique=True, nullable=False)
    user_password = db.Column(db.Text, nullable=False)
    user_avatar = db.Column(
        db.String(255), nullable=False, server_default="3d-avatar-1.avif"
    )

    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(
        db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow
    )

    def set_password(self, password):
        self.user_password = generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.user_password, password)

    @staticmethod
    def authenticate(email, password):
        user = User.query.filter_by(user_email=email).first()

        if user and user.check_password(password):
            return user

        return None

    @staticmethod
    def create_admin(email, password, username, role="super admin"):
        existing_users = User.query.first()

        if existing_users:
            return None

        user = User(
            user_id="USR-001", user_name=username, user_email=email, user_role=role
        )

        user.set_password(password)

        db.session.add(user)
        db.session.commit()

        return user
