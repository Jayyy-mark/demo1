from app.models.ResearchModel import Research
from app.core.database import ma

class ResearchSchema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model=Research
        load_instance=True
