
from flask import Request
from .BaseController import BaseController
from app.models.DashboardModel import Dashboard
from app.schemas.dashboard import DashboardSchema

class DashboardController(BaseController):
    def __init__(self):
        super().__init__(Dashboard, DashboardSchema())

    
