from flask import Blueprint
from app.https.controllers.VisionMissionController import VisionMissionController
from flask_jwt_extended import jwt_required

vision_mission_api = Blueprint("vision_mission_api", __name__, url_prefix="/api")

@vision_mission_api.route("/vision-mission/all", methods=['GET'])
@jwt_required()
def allVisionMissions():
    return VisionMissionController().all()

@vision_mission_api.route("/vision-mission/create", methods=['POST'])
@jwt_required()
def createVisionMission():
    return VisionMissionController().create()

@vision_mission_api.route("/vision-mission/update", methods=['PUT'])
@jwt_required()
def updateVisionMission():
    return VisionMissionController().update()

@vision_mission_api.route("/vision-mission/delete", methods=['DELETE'])
@jwt_required()
def deleteVisionMission():
    return VisionMissionController().delete()
