from app.core.database import ma
from app.models.SemesterModel import Semester
from .import YearSchema

class SemesterSchema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model = Semester
        load_instance = True
        include_fk = True

    year = ma.Nested(YearSchema)