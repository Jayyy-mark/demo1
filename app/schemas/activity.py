from app.models.ActivityModel import Activity
from app.core.database import ma

class ActivitySchema(ma.SQLAlchemyAutoSchema):

    class Meta:
        model=Activity
        load_instance=True
        