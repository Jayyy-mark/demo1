from .BaseController import BaseController
from app.models.SemesterModel import Semester   
from app.schemas.academic.semester import SemesterSchema

class SemesterController(BaseController):

    def __init__(self):
        super().__init__(Semester, SemesterSchema())