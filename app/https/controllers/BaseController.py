from flask import request
from app.helpers.utils import Utils, ResponseHelper


class BaseController:

    def __init__(self, model, schema):
        self.model = model
        self.schema = schema

    def create(self, data=None):
        try:
            if data is None:
                data = request.get_json() or {}

            obj = Utils.create(self.model, **data)

            return ResponseHelper.success("Created successfully", {"id": obj.id})

        except Exception as e:
            
            return ResponseHelper.error(str(e), 500)

    def all(self):
        data = Utils.get_all(self.model)
        
        if not data:
            return ResponseHelper.success("Fetched successfully", [])

        return ResponseHelper.success("Fetched successfully", self.schema.dump(data, many=True))

    def getById(self, id):
        obj = Utils.get_by_id(self.model, id)

        if not obj:
            return ResponseHelper.error("Not found", 404)

        return ResponseHelper.success("Fetched successfully", obj)

    def update(self, data=None):
        try:
            if data is None:
                data = request.get_json() or {}
                
            print("got data : ",data)
            obj = Utils.update(self.model, **data)
            print('this is object', obj)

            if not obj:
                return ResponseHelper.error("Not found", 404)

            return ResponseHelper.success("Updated successfully")

        except Exception as e:
            print("this is error",e);
            return ResponseHelper.error(str(e), 500)

    def delete(self):
        try:
            data = request.get_json() or {}

            success = Utils.delete(self.model, data.get("id"))

            if not success:
                return ResponseHelper.error("Not found", 404)

            return ResponseHelper.success("Deleted successfully")

        except Exception as e:
            return ResponseHelper.error(str(e), 500)