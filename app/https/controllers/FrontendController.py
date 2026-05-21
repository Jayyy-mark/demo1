from app.models.ActivityModel import Activity
from app.models.ResearchModel import Research
from app.models.LaboratoryModel import Laboratory
from app.schemas.activity import ActivitySchema
from app.schemas.research import ResearchSchema
from app.schemas.laboratory import LaboratorySchema
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
