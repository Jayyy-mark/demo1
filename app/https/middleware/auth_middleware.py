from flask import g, session
from app.models.UserModel import User

def attach_user():
    g.user = None

    user_id = session.get("user_id")

    if user_id:
        g.user = User.query.get(user_id)
