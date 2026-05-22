from flask import Blueprint
from app.https.controllers.DepartmentController import DepartmentController
from flask_jwt_extended import jwt_required

department_api = Blueprint("department_api", __name__, url_prefix="/api")

@department_api.route("/department/all", methods=['GET'])
@jwt_required()
def allDepartments():
    return DepartmentController().all()

@department_api.route("/department/create", methods=['POST'])
@jwt_required()
def createDepartment():
    return DepartmentController().create()

@department_api.route("/department/update", methods=['PUT'])
@jwt_required()
def updateDepartment():
    return DepartmentController().update()


