from app.models.DepartmentModel import Department
from app.core.database import ma

class DepartmentSchema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model = Department
        load_instance = True
