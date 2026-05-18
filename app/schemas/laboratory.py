from app.core.database import ma
from app.models.LaboratoryModel import Laboratory

class LaboratorySchema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model = Laboratory
        load_instance = True