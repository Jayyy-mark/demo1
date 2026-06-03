from app.core.database import ma
from app.models.AcademicCalendarModel import AcademicCalendar

class AcademicCalendarSchema(ma.SQLAlchemyAutoSchema):
    class Meta:
        model = AcademicCalendar
        load_instance = True