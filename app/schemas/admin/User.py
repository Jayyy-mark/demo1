from app.models.UserModel import User
from app.core.database import ma
from marshmallow import validate, fields

class UserSchema(ma.SQLAlchemyAutoSchema):

    user_id = fields.String(
        required=False,
        allow_none=True,        
    )

    class Meta:
        model = User
        load_instance = False

