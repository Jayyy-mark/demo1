from app.core.database import ma
from app.models.YearModel import Year

class YearSchema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model = Year
        load_instance = True
        include_fk = True

    