#<-=========================================
#        IMPORTS
#=========================================->
from . import dashboard_api
from flask import jsonify, request
from app.https.controllers.DashboardController import DashboardController
#<-=========================================
#           dashboard API
#=========================================->
@dashboard_api.route('/summary', methods=['GET'])
def summary():
    return jsonify(DashboardController.summary()),200

@dashboard_api.route('/classroom/all', methods=['GET'])
def allClassrooms():
    return jsonify(DashboardController.allClassrooms()),200

@dashboard_api.route('/student/semester/count', methods=['GET'])
def studentCountBySemester():
    return jsonify(DashboardController.studentCountBySemester(request)),200
