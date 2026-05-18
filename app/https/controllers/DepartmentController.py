from .BaseController import BaseController
from app.models.DepartmentModel import Department   
from app.schemas.department import DepartmentSchema

class DepartmentController(BaseController):

    def __init__(self):
        super().__init__(Department, DepartmentSchema())