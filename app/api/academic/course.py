# <-=========================================
#        IMPORTS
# =========================================->
from . import academic_api
from app.https.controllers.CourseController import CourseController
from flask_jwt_extended import jwt_required


# <-=========================================
#           COURSE API
# =========================================->
@academic_api.route("/course/all", methods=["GET"])
@jwt_required()
def allCourse():
    return CourseController().all()


@academic_api.route("/course/create", methods=["POST"])
@jwt_required()
def addCourse():
    return CourseController().create()


@academic_api.route("/course/update", methods=["PUT"])
@jwt_required()
def updateCourse():
    return CourseController().update()


@academic_api.route("/course/delete", methods=["DELETE"])
@jwt_required()
def deleteCourse():
    return CourseController().delete()


# <-=========================================
#           HELPER API
# =========================================-->
@academic_api.route("/course/subject", methods=["GET"])
@jwt_required()
def allSubjects():
    return CourseController.getSubjects()


@academic_api.route("/course/department/all", methods=["GET"])
@jwt_required()
def allDepartments():
    return CourseController.getDepartments()
