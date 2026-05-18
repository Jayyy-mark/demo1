
from flask import request, jsonify, Blueprint
from app.https.controllers import DepartmentController
from app.https.controllers.UserController import UserController
from flask import g
from flask_jwt_extended import jwt_required

user_api = Blueprint("api_user", __name__, url_prefix="/api/admin")


@user_api.route("/user/all", methods=['GET'])
@jwt_required()
def allUsers():
    return UserController().all()



@user_api.route("/user/create", methods=['POST'])
@jwt_required()
def createUser():
    return UserController().create()



@user_api.route("/user/update", methods=['PUT'])
@jwt_required()
def updateUser():
    return UserController().update()



@user_api.route("/user/delete", methods=['DELETE'])
@jwt_required()
def deleteUser():
    return UserController().delete()
