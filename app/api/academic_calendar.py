from flask import Blueprint
from flask_jwt_extended import jwt_required
from app.https.controllers.AcademicCalendarController import AcademicCalendarController

academic_calendar_api = Blueprint("academic_calendar_api", __name__, url_prefix="/api/academic_calendar")

@academic_calendar_api.route("/all", methods=['GET'])
@jwt_required()
def allActivities():
    return AcademicCalendarController().all()

@academic_calendar_api.route("/create", methods=['POST'])
@jwt_required()
def createActivity():
    return AcademicCalendarController().create()

@academic_calendar_api.route("/update", methods=['PUT'])
@jwt_required()
def updateActivity():
    return AcademicCalendarController().update()

@academic_calendar_api.route("/delete", methods=['DELETE'])
@jwt_required()
def deleteActivity():
    return AcademicCalendarController().delete()