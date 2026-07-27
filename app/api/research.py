from flask import Blueprint
from app.https.controllers.ResearchController import ResearchController, get_categories
from flask_jwt_extended import jwt_required

research_api = Blueprint("research_api", __name__, url_prefix="/api")

@research_api.route("/research/all", methods=['GET'])
@jwt_required()
def allResearchs():
    return ResearchController().all()

@research_api.route("/research/create", methods=['POST'])
@jwt_required()
def createResearch():
    return ResearchController().create()

@research_api.route("/research/update", methods=['PUT'])
@jwt_required()
def updateResearch():
    return ResearchController().update()

@research_api.route("/research/delete", methods=['DELETE'])
@jwt_required()
def deleteResearch():
    return ResearchController().delete()

@research_api.route("/research/categories", methods=['GET'])
@jwt_required()
def researchCategories():
    return get_categories()
