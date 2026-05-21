from .BaseController import BaseController
from app.models.CourseModel import Course
from app.schemas.academic.course import CourseSchema
from app.helpers.course import CourseHelper
from app.helpers.utils import Utils
from flask import request, jsonify

class CourseController(BaseController):

    def __init__(self):
        super().__init__(Course, CourseSchema())

    def getSubjects():
        return jsonify({
            "data" : CourseHelper.getSubjects() 
        }),200

    def getDepartments():

        return jsonify({
            "departments" : CourseHelper.getDepartments()
        }),200

    def generateID()->str:
        field = "course_id"
        prefix = "CSE"
        dp_id = Utils.generate_id(Course,field,prefix)
        return dp_id
    
    def create(self):
        data = request.get_json() or {}
        print(data.get("semester_id"))
        course_id = CourseHelper.checkSemester(data.get("semester_id"))

        if course_id is None:
            data["course_id"] = CourseController.generateID()
        else:
            data["course_id"] = course_id

        try:
            Utils.create(self.model, **data)
            return {
                "message" : "Course created successfully!"
            }
        except Exception as e:
            print(e)
            return {
                "error" : str(e)
            }, 500
        
    def update(self):
        
        data = request.get_json() or {}
        
        return super().update(data)