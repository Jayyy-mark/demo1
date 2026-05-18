from .BaseController import BaseController
from app.models.YearModel import Year   
from app.schemas.academic.year import YearSchema

class YearController(BaseController):

    def __init__(self):
        super().__init__(Year, YearSchema())