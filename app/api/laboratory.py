from flask import Blueprint
from app.https.controllers.LaboratoryController import LaboratoryController
from flask_jwt_extended import jwt_required

laboratory_api = Blueprint("laboratory_api", __name__, url_prefix="/api")

@laboratory_api.route("/laboratory/all", methods=['GET'])
@jwt_required()
def allLaboratories():
    return LaboratoryController().all()

@laboratory_api.route("/laboratory/create", methods=['POST'])
@jwt_required()
def createLaboratory():
    return LaboratoryController().create()

@laboratory_api.route("/laboratory/update", methods=['PUT'])
@jwt_required()
def updateLaboratory():
    return LaboratoryController().update()

@laboratory_api.route("/laboratory/delete", methods=['DELETE'])
@jwt_required()
def deleteLaboratory():
    return LaboratoryController().delete()

# ─── Group-aware endpoints ────────────────────────────────────────
@laboratory_api.route("/laboratory/update-by-name", methods=['PUT'])
@jwt_required()
def updateLaboratoryByName():
    return LaboratoryController().update_by_name()

@laboratory_api.route("/laboratory/delete-by-name", methods=['DELETE'])
@jwt_required()
def deleteLaboratoryByName():
    return LaboratoryController().delete_by_name()
