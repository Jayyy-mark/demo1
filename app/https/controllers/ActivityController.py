from app.models.ActivityModel import Activity
from app.schemas.activity import ActivitySchema
from .BaseController import BaseController
from app.helpers.utils import Utils, ResponseHelper
from flask import request

class ActivityController(BaseController):

    def __init__(self):
        super().__init__(Activity, ActivitySchema())

    def create(self):

        raw_data = request.form.to_dict()

        data = []

        files = request.files.getlist("file")

        for file in files:
            filename, filepath = self.model.save_file(file)
            data.append({
                "activity_name" : raw_data.get("activity_name"),
                "category" : raw_data.get("category"),
                "description" : raw_data.get("description"),
                "filename" : filename,
                "filepath" : filepath,
                "date" : raw_data.get("date")
            })
    
        try:
            Utils.bulk_create(self.model, data)
            return ResponseHelper.success(
                "Created successfully!",
            )
        except Exception as e:
            return ResponseHelper.error(
                str(e),
                500
            )

    def update(self):
        data = request.form.to_dict()
        file = request.files.get("file")

        if file and file.filename != "":
            print("file name is exist!")
            activity = Utils.get_by_id(self.model, data.get("id"))

            filename = activity.filename

            self.model.delete_file(filename)

            file = request.files.get("file")
            filename, filepath = self.model.save_file(file)

            data["filename"] = filename
            data["filepath"] = filepath

        try:
            print("entered!")
            Utils.update(self.model, **data)
            
            return ResponseHelper.success(
                "Updated successfully!",
            )
        except Exception as e:
            print(e)
            return ResponseHelper.error(
                str(e),
                500
            )

    def delete(self):
        data = request.get_json()
        activity = Utils.get_by_id(self.model, data.get("id"))
        filename = activity.filename

        self.model.delete_file(filename)
        
        try:
            Utils.delete(self.model, data.get("id"))
            return ResponseHelper.success(
                "Deleted successfully!",
            )
        except Exception as e:
            return ResponseHelper.error(
                str(e),
                500
            )            







        

         
