from app.models.CollaborationModel import Collaboration
from app.core.database import ma

class CollaborationSchema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model = Collaboration
        load_instance = True
