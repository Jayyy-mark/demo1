from .BaseController import BaseController
from app.models.UserModel import User
from app.schemas.admin import UserSchema
from app.helpers.utils import Utils
from flask import request
from werkzeug.security import generate_password_hash

class UserController(BaseController):
    def __init__(self):
        super().__init__(User, UserSchema())

    def generate_user_id(self) -> str:
        field = "user_id"
        prefix = "USR"
        user_id = Utils.generate_id(User,field,prefix)
        return user_id
    
    def create(self):
        data = request.get_json() or {}
        data['user_id'] = self.generate_user_id()
        data['user_password'] = generate_password_hash(data['user_password'])

        return super().create(data)
    
    def update(self):
        data = request.get_json() or {}
        if data.get("user_password"):
            data['user_password'] = generate_password_hash(data['user_password'])
        return super().update(data)