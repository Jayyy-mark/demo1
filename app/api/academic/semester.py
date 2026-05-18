#<-=========================================
#        IMPORTS
#=========================================->
from . import academic_api
from app.https.controllers.SemesterController import SemesterController
from flask_jwt_extended import jwt_required



#<-=========================================
#           SEMESTER API
#=========================================->
@academic_api.route('/semester/all', methods=['GET'])
@jwt_required()
def allSemester():
    return SemesterController().all()


@academic_api.route('/semester/create', methods=['POST'])
@jwt_required()
def addSemester():
    return SemesterController().create()


@academic_api.route('/semester/update', methods=['PUT'])
@jwt_required()
def updateSemester():
    return SemesterController().update()


@academic_api.route('/semester/delete', methods=['DELETE'])
@jwt_required()
def deleteSemester():
    return SemesterController().delete()



