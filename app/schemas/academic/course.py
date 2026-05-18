from app.core.database import ma
from app.models.CourseModel import Course
from . import SubjectSchema
from . import SemesterSchema

class CourseSchema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model = Course
        load_instance = True
        include_fk = True

    subject = ma.Nested(SubjectSchema)
    semester = ma.Nested(SemesterSchema)
