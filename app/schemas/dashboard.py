from app.core.database import ma
from app.models.DashboardModel import Dashboard

class DashboardSchema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model = Dashboard
        load_instance = True