from .BaseController import BaseController
from app.models.SubjectModel import Subject   
from app.schemas.academic.subject import SubjectSchema

class SubjectController(BaseController):

    def __init__(self):
        super().__init__(Subject, SubjectSchema())