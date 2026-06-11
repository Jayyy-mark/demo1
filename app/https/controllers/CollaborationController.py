from app.models.CollaborationModel import Collaboration
from app.schemas.collaboration import CollaborationSchema
from .BaseController import BaseController
from app.helpers.utils import Utils, ResponseHelper
from flask import request

class CollaborationController(BaseController):

    def __init__(self):
        super().__init__(Collaboration, CollaborationSchema())
    
    def create(self):
        raw_data = request.form.to_dict()
        file = request.files.get("file")
        
        data = {
            "company_name": raw_data.get("company_name"),
            "description": raw_data.get("description"),
            "url": raw_data.get("url"),
        }
        
        if file and file.filename != "":
            filename, filepath = self.model.save_file(file)
            data["logo"] = filename
        else:
            return ResponseHelper.error("Logo is required", 400)
            
        try:
            Utils.create(self.model, **data)
            return ResponseHelper.success("Created successfully!")
        except Exception as e:
            return ResponseHelper.error(str(e), 500)

    def update(self):
        data = request.form.to_dict()
        file = request.files.get("file")
        
        if file and file.filename != "":
            # Delete old file
            collaboration = Utils.get_by_id(self.model, data.get("id"))
            if collaboration and collaboration.logo:
                self.model.delete_file(collaboration.logo)
            
            # Save new file
            filename, filepath = self.model.save_file(file)
            data["logo"] = filename

        try:
            Utils.update(self.model, **data)
            return ResponseHelper.success("Updated successfully!")
        except Exception as e:
            return ResponseHelper.error(str(e), 500)

    def delete(self):
        data = request.get_json()
        collaboration = Utils.get_by_id(self.model, data.get("id"))
        
        if collaboration and collaboration.logo:
            self.model.delete_file(collaboration.logo)
        
        try:
            Utils.delete(self.model, data.get("id"))
            return ResponseHelper.success("Deleted successfully!")
        except Exception as e:
            return ResponseHelper.error(str(e), 500)
