#<-=========================================
#        IMPORTS
#=========================================->
from flask_jwt_extended import jwt_required

from . import dashboard_api
from flask import jsonify, request
from app.https.controllers.DashboardController import DashboardController
#<-=========================================
#           dashboard API
#=========================================->
@dashboard_api.route("/dashboard/all", methods=['GET'])
@jwt_required()
def allAttrKeys():
    return DashboardController().all()

@dashboard_api.route("/dashboard/create", methods=['POST'])
@jwt_required()
def createAttrKey():
    return DashboardController().create()

@dashboard_api.route("/dashboard/update", methods=['PUT'])
@jwt_required()
def updateAttrKey():
    return DashboardController().update()

@dashboard_api.route("/dashboard/delete", methods=['DELETE'])
@jwt_required()
def deleteAttrKey():
    return DashboardController().delete()
