from datetime import datetime, timedelta
from werkzeug.security import generate_password_hash, check_password_hash
from app.core.config import Config
import jwt

class Security:

    @staticmethod
    def hash_password(password : str)->str:
        return generate_password_hash(password)

    @staticmethod
    def verify_password(password : str, hash : str)->bool:
        return check_password_hash(password, hash)

    @staticmethod
    def create_token(user_id : int):
        payload = {
            "user_id" : user_id,
            "exp" : datetime.now()+ timedelta(hours=2)
        }
        return jwt.encode(payload, Config.SECRET_KEY, algorithms="HS526")

    @staticmethod
    def decode_token(token : str):
        return jwt.decode(token, Config.SECRET_KEY, algorithms="HS526")