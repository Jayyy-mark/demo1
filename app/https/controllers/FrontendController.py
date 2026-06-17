from collections import defaultdict
from datetime import date, datetime

from app.helpers.utils import ResponseHelper
from app.models.ActivityModel import Activity
from app.models.AcademicCalendarModel import AcademicCalendar
from app.schemas.academic_calendar import AcademicCalendarSchema
from app.models.CourseModel import Course
from app.models.DepartmentModel import Department
from app.models.ResearchModel import Research
from app.models.LaboratoryModel import Laboratory
from app.models.SubjectModel import Subject
from app.models.CollaborationModel import Collaboration
from app.schemas.academic.course import CourseSchema
from app.schemas.academic.subject import SubjectSchema
from app.schemas.research import ResearchSchema
from app.schemas.collaboration import CollaborationSchema
from sqlalchemy.orm import selectinload
from flask import jsonify, request

from app.models.CountModel import Count
from app.models.DashboardModel import Dashboard

class FrontendController:

    @staticmethod
    def getHomeStats():
        counts = Count.query.first()
        rector_msg = Dashboard.query.filter_by(attr_key="Rector's Message").first()

        count_data = {
            "total_staff": counts.total_staff if counts else 0,
            "total_student": counts.total_student if counts else 0,
            "graduated_student": counts.graduated_student if counts else 0,
            "current_student": counts.current_student if counts else 0
        }

        return jsonify({
            "counts": count_data,
            "rector_message": rector_msg.value if rector_msg else "No message available."
        })
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

        result = {
            "department": department_name,
            "semesters": {
                "1st Sem": {"subjects": []},
                "2nd Sem": {"subjects": []}
            }
        }

        for subject in data:
            for course in subject.get("courses", []):

                semester_term = course["semester"]["semester_term"]

                if "1st Sem" in semester_term:
                    sem_group = "1st Sem"
                elif "2nd Sem" in semester_term:
                    sem_group = "2nd Sem"
                else:
                    continue

                result["semesters"][sem_group]["subjects"].append({
                    "id": subject["id"],
                    "subject_code": subject["subject_code"],
                    "subject_name": subject["subject_name"]
                })

        return jsonify({
            "subjects": result
        })


    @staticmethod
    def getAcademicCalendar():


        def _status_for_dates(start_date, end_date):

            today = date.today()

            if today > end_date:
                return "Completed"

            if today >= start_date:
                return "On Progress"

            return "Pending"
        
        
        data = AcademicCalendar.query.order_by(AcademicCalendar.start_date.desc()).all()

        if not data:
            return ResponseHelper.success("Fetched successfully", [])

        calendar_events = AcademicCalendarSchema(many=True).dump(data)

        for event in calendar_events:
            event["status"] = _status_for_dates(
                datetime.strptime(event["start_date"], "%Y-%m-%d").date(),
                datetime.strptime(event["end_date"], "%Y-%m-%d").date()
            )

        return ResponseHelper.success("Fetched successfully", calendar_events)

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
    
    @staticmethod
    def getCollaborations():
        
        queried_data = Collaboration.query.all()

        return jsonify({
            "collaborations" : CollaborationSchema().dump(queried_data, many=True)
        })
