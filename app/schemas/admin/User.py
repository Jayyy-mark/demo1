from app.models.UserModel import User
from app.core.database import ma

class UserSchema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model = User
        load_instance = True

