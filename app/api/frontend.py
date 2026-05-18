from flask import Blueprint
from app.https.controllers.FrontendController import FrontendController

frontend_api = Blueprint("frontend_api", __name__, url_prefix="/api/frontend")

@frontend_api.route("/activity/all", methods=['GET'])
def allActivities():
    return FrontendController.allActivities()

@frontend_api.route("/research/all", methods=['GET'])
def allResearches():
    return FrontendController.allResearches()

@frontend_api.route("/laboratory/all", methods=['GET'])
def allLaboratories():
    return FrontendController.allLaboratories()

@frontend_api.route("/home/research", methods=['GET'])
def lastedResearches():
    return FrontendController.lastedResearches()

@frontend_api.route("/home/activity", methods=['GET'])
def lastedActivities():
    return FrontendController.lastedActivities()
    