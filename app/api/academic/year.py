#<-=========================================
#        IMPORTS
#=========================================->
from . import academic_api
from app.https.controllers.YearController import YearController
from flask_jwt_extended import jwt_required



#<-=========================================
#           YEAR API
#=========================================->
@academic_api.route('/year/all', methods=['GET'])
@jwt_required()
def allYear():
    return YearController().all()


@academic_api.route('/year/create', methods=['POST'])
@jwt_required()
def addYear():
    return YearController().create()


@academic_api.route('/year/update', methods=['PUT'])
@jwt_required()
def updateYear():
    return YearController().update()


@academic_api.route('/year/delete', methods=['DELETE'])
@jwt_required()
def deleteYear():
    return YearController().delete()



