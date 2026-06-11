from app.models.VisionMissionModel import VisionMission
from app.core.database import ma


class VisionMissionSchema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model = VisionMission
        load_instance = True
        include_fk = True

    department = ma.Nested("DepartmentSchema", only=("id", "department_name"))
