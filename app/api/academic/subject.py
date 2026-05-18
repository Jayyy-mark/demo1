#<-=========================================
#        IMPORTS
#=========================================->
from . import academic_api
from app.https.controllers.SubjectController import SubjectController
from flask_jwt_extended import jwt_required



#<-=========================================
#           SUBJECT API
#=========================================->
@academic_api.route('/subject/all', methods=['GET'])
@jwt_required()
def allsubject():
    return SubjectController().all()


@academic_api.route('/subject/create', methods=['POST'])
@jwt_required()
def addsubject():
    return SubjectController().create()


@academic_api.route('/subject/update', methods=['PUT'])
@jwt_required()
def updatesubject():
    return SubjectController().update()


@academic_api.route('/subject/delete', methods=['DELETE'])
@jwt_required()
def deletesubject():
    return SubjectController().delete()



