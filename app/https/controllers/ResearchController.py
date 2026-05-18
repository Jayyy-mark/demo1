from app.models.ResearchModel import Research
from app.schemas.research import ResearchSchema
from .BaseController import BaseController
from app.helpers.utils import Utils, ResponseHelper
from flask import request

class ResearchController(BaseController):

    def __init__(self):
        super().__init__(Research, ResearchSchema())

    def create(self):

        raw_data = request.form.to_dict()

        data = []

        files = request.files.getlist("file")

        for file in files:
            filename, filepath = self.model.save_file(file)
            data.append({
                "research_name" : raw_data.get("research_name"),
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

            activity = Utils.get_by_id(self.model, data.get("id"))

            filename = activity.filename

            self.model.delete_file(filename)


            filename, filepath = self.model.save_file(file)

            data["filename"] = filename
            data["filepath"] = filepath

        try:
            Utils.update(self.model, **data)
            return ResponseHelper.success(
                "Updated successfully!",
            )
        except Exception as e:
            return ResponseHelper.error(
                str(e),
                500
            )

    def delete(self):
        data = request.get_json()
        research = Utils.get_by_id(self.model, data.get("id"))
        filename = research.filename

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







        

         
