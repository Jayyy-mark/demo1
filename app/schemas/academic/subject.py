from app.models.SubjectModel import Subject
from app.core.database import ma
from app.schemas.department import DepartmentSchema

class SubjectSchema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model = Subject
        load_instance = True
        include_fk = True

    department = ma.Nested(DepartmentSchema)
    