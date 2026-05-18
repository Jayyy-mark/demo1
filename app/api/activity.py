from flask import Blueprint
from app.https.controllers.ActivityController import ActivityController
from flask_jwt_extended import jwt_required

activity_api = Blueprint("activity_api", __name__, url_prefix="/api")

@activity_api.route("/activity/all", methods=['GET'])
@jwt_required()
def allActivities():
    return ActivityController().all()

@activity_api.route("/activity/create", methods=['POST'])
@jwt_required()
def createActivity():
    return ActivityController().create()

@activity_api.route("/activity/update", methods=['PUT'])
@jwt_required()
def updateActivity():
    return ActivityController().update()

@activity_api.route("/activity/delete", methods=['DELETE'])
@jwt_required()
def deleteActivity():
    return ActivityController().delete()
