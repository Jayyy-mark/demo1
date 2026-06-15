from flask import Blueprint
from app.https.controllers.CollaborationController import CollaborationController
from flask_jwt_extended import jwt_required

collaboration_api = Blueprint("collaboration_api", __name__, url_prefix="/api")

@collaboration_api.route("/collaboration/all", methods=['GET'])
@jwt_required()
def allCollaborations():
    try:
        
        return CollaborationController().all()
    except Exception as e:
        return {"error": str(e)}, 500

@collaboration_api.route("/collaboration/create", methods=['POST'])
@jwt_required()
def createCollaboration():
    return CollaborationController().create()

@collaboration_api.route("/collaboration/update", methods=['PUT'])
@jwt_required()
def updateCollaboration():
    return CollaborationController().update()

@collaboration_api.route("/collaboration/delete", methods=['DELETE'])
@jwt_required()
def deleteCollaboration():
    return CollaborationController().delete()
