from .BaseController import BaseController
from app.models.VisionMissionModel import VisionMission
from app.schemas.vision_mission import VisionMissionSchema

class VisionMissionController(BaseController):

    def __init__(self):
        super().__init__(VisionMission, VisionMissionSchema())
