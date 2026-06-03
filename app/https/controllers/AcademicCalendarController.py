from .BaseController import BaseController
from app.models.AcademicCalendarModel import AcademicCalendar
from app.schemas.academic_calendar import AcademicCalendarSchema

class AcademicCalendarController(BaseController):
    def __init__(self):
        super().__init__(AcademicCalendar, AcademicCalendarSchema())
  
