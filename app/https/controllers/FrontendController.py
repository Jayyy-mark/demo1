from collections import defaultdict

from app.models.ActivityModel import Activity
from app.models.CourseModel import Course
from app.models.DepartmentModel import Department
from app.models.ResearchModel import Research
from app.models.LaboratoryModel import Laboratory
from app.models.SubjectModel import Subject
from app.schemas.academic.course import CourseSchema
from app.schemas.academic.subject import SubjectSchema
from app.schemas.research import ResearchSchema
from sqlalchemy.orm import selectinload
from flask import jsonify, request

class FrontendController:

    @staticmethod
    def allActivities():

        activities = Activity.query.all()

        grouped_activities = {}

        for activity in activities:

            key = activity.activity_name

            # create only once
            if key not in grouped_activities:

                grouped_activities[key] = {
                    "id": activity.id,
                    "activity_name": activity.activity_name,
                    "category": activity.category,
                    "date": str(activity.date),
                    "description": activity.description,
                    "images": []
                }

            if activity.filepath:
                grouped_activities[key]["images"].append({
                    "filename": activity.filename,
                    "filepath": activity.filepath.replace("\\", "/")
                })

        return jsonify({
            "activities": list(grouped_activities.values())
        })
    
    @staticmethod 
    def allResearches():
        researches = Research.query.all()
        return jsonify({
            "researches" : ResearchSchema().dump(researches, many=True)
        })
    
    @staticmethod
    def allLaboratories():

        laboratories = Laboratory.query.all()

        grouped_laboratories = {}

        for laboratory in laboratories:

            key = laboratory.laboratory_name

            # create only once
            if key not in grouped_laboratories:

                grouped_laboratories[key] = {
                    "id": laboratory.id,
                    "laboratory_name": laboratory.laboratory_name,
                    "category": laboratory.category,
                    "date": str(laboratory.date),
                    "description": laboratory.description,
                    "images": []
                }

            # append image
            grouped_laboratories[key]["images"].append({
                "filename": laboratory.filename,
                "filepath": laboratory.filepath.replace("\\", "/")
            })

        return jsonify({
            "laboratories": list(grouped_laboratories.values())
        })
    
    @staticmethod
    def lastedActivities():

        activities = Activity.query.all()

        # STEP 1: sort by date DESC (latest first)
        activities.sort(key=lambda x: x.date, reverse=True)

        grouped_activities = {}
        limited_count = 0
        LIMIT = 3

        for activity in activities:

            key = activity.activity_name

            # only allow 3 unique activities
            if key not in grouped_activities:

                if limited_count >= LIMIT:
                    continue

                grouped_activities[key] = {
                    "id": activity.id,
                    "activity_name": activity.activity_name,
                    "category": activity.category,
                    "date": str(activity.date),
                    "description": activity.description,
                    "images": []
                }

                limited_count += 1

            if activity.filepath:
                grouped_activities[key]["images"].append({
                    "filename": activity.filename,
                    "filepath": activity.filepath.replace("\\", "/")
                })

        return jsonify({
            "activities": list(grouped_activities.values())
        })

    @staticmethod
    def lastedResearches():
        researches = Research.query.order_by(Research.date.desc()).limit(3).all()

        return jsonify({
            "researches" : ResearchSchema().dump(researches, many=True)
        })

    @staticmethod
    def getActivityById():

        id = request.args.get("id", "").strip()

        if not id:
            return jsonify({
                "activity": [],
                "message": "Activity name is required."
            }), 400

        activity = Activity.query.get(id)

        activities = Activity.query.filter(Activity.activity_name == activity.activity_name).all()

        grouped_activities = {}

        for activity in activities:

            key = activity.activity_name

            # create only once
            if key not in grouped_activities:

                grouped_activities[key] = {
                    "id": activity.id,
                    "activity_name": activity.activity_name,
                    "category": activity.category,
                    "date": str(activity.date),
                    "description": activity.description,
                    "images": []
                }

            if activity.filepath:
                grouped_activities[key]["images"].append({
                    "filename": activity.filename,
                    "filepath": activity.filepath.replace("\\", "/")
                })

        return jsonify({
            "activity": list(grouped_activities.values())
        })

    @staticmethod
    def getLaboratoryById():

        id = request.args.get("id", "").strip()

        if not id:
            return jsonify({
                "laboratory": [],
                "message": "laboratory name is required."
            }), 400

        laboratory = Laboratory.query.get(id)

        activities = Laboratory.query.filter(Laboratory.laboratory_name == laboratory.laboratory_name).all()

        grouped_laboratories = {}

        for laboratory in activities:

            key = laboratory.laboratory_name

            # create only once
            if key not in grouped_laboratories:

                grouped_laboratories[key] = {
                    "id": laboratory.id,
                    "laboratory_name": laboratory.laboratory_name,
                    "category": laboratory.category,
                    "date": str(laboratory.date),
                    "description": laboratory.description,
                    "images": []
                }

            if laboratory.filepath:
                grouped_laboratories[key]["images"].append({
                    "filename": laboratory.filename,
                    "filepath": laboratory.filepath.replace("\\", "/")
                })

        return jsonify({
            "laboratory": list(grouped_laboratories.values())
        })

    @staticmethod
    def getCourseByDepartment():
        department_name = request.args.get("department_name")
        subjects = Subject.query.options(
            selectinload(Subject.department)
        ).join(Subject.department).filter(
            Department.department_name == department_name
        ).all()
        data = SubjectSchema(many=True).dump(subjects)

        grouped = defaultdict(lambda: {
            "department": None,
            "subjects": []
        })

        for item in data:
            dept_id = item["department_id"]

            if grouped[dept_id]["department"] is None:
                grouped[dept_id]["department"] = item["department"]

            grouped[dept_id]["subjects"].append(item)

        return jsonify({
            "subjects": list(grouped.values())
        })
    
    @staticmethod
    def getCourseBySemester():
        courses = Course.query.all()
        data = CourseSchema(many=True).dump(courses)

        grouped = defaultdict(lambda: {
            "year": None,
            "semesters": {}
        })

        for item in data:
            semester = item["semester"]
            year = semester["year"]

            year_id = year["id"]
            semester_id = semester["id"]

            # init year
            if grouped[year_id]["year"] is None:
                grouped[year_id]["year"] = year

            # init semester inside year
            if semester_id not in grouped[year_id]["semesters"]:
                grouped[year_id]["semesters"][semester_id] = {
                    "semester": semester,
                    "courses": []
                }

            # add course
            grouped[year_id]["semesters"][semester_id]["courses"].append(item)

        # convert dict → list
        result = []
        for year_data in grouped.values():
            year_data["semesters"] = list(year_data["semesters"].values())
            result.append(year_data)

        return jsonify({
            "subjects": result
        })