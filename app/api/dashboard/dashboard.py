#<-=========================================
#        IMPORTS
#=========================================->
from flask_jwt_extended import jwt_required

from . import dashboard_api
from flask import jsonify, request
from app.https.controllers.DashboardController import DashboardController
from app.models.CountModel import Count
from app.core.database import db

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

@dashboard_api.route("/dashboard/counts/update", methods=['PUT'])
@jwt_required()
def updateCounts():
    data = request.get_json() or {}
    count = Count.query.first()
    
    if not count:
        count = Count(
            total_staff=data.get('total_staff', 0),
            total_student=data.get('total_student', 0),
            graduated_student=data.get('graduated_student', 0),
            current_student=data.get('current_student', 0)
        )
        db.session.add(count)
    else:
        count.total_staff = data.get('total_staff', count.total_staff)
        count.total_student = data.get('total_student', count.total_student)
        count.graduated_student = data.get('graduated_student', count.graduated_student)
        count.current_student = data.get('current_student', count.current_student)
        
    db.session.commit()
    return jsonify({"message": "Statistics updated successfully"})
