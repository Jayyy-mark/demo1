from app.models.LaboratoryModel import Laboratory
from app.schemas.laboratory import LaboratorySchema
from .BaseController import BaseController
from app.helpers.utils import Utils, ResponseHelper
from app.core.database import db
from flask import request
import json

class LaboratoryController(BaseController):

    def __init__(self):
        super().__init__(Laboratory, LaboratorySchema())

    def create(self):

        raw_data = request.form.to_dict()
        data = []
        files = request.files.getlist("file")

        for file in files:
            filename, filepath = self.model.save_file(file)
            data.append({
                "laboratory_name": raw_data.get("laboratory_name"),
                "category":        raw_data.get("category"),
                "description":     raw_data.get("description"),
                "filename":        filename,
                "filepath":        filepath,
                "date":            raw_data.get("date")
            })

        try:
            Utils.bulk_create(self.model, data)
            return ResponseHelper.success("Created successfully!")
        except Exception as e:
            return ResponseHelper.error(str(e), 500)

    def update(self):
        data = request.form.to_dict()
        file = request.files.get("file")
        if file and file.filename != "":
            laboratory = Utils.get_by_id(self.model, data.get("id"))
            self.model.delete_file(laboratory.filename)
            filename, filepath = self.model.save_file(file)
            data["filename"] = filename
            data["filepath"] = filepath

        try:
            Utils.update(self.model, **data)
            return ResponseHelper.success("Updated successfully!")
        except Exception as e:
            return ResponseHelper.error(str(e), 500)

    def delete(self):
        data = request.get_json()
        laboratory = Utils.get_by_id(self.model, data.get("id"))
        self.model.delete_file(laboratory.filename)
        try:
            Utils.delete(self.model, data.get("id"))
            return ResponseHelper.success("Deleted successfully!")
        except Exception as e:
            return ResponseHelper.error(str(e), 500)

    # ─────────────────────────────────────────────────────────────────
    #  GROUP-AWARE ENDPOINTS
    # ─────────────────────────────────────────────────────────────────

    def update_by_name(self):
        """
        Update all rows that share the same laboratory_name.
        Handles:
          - ids_to_delete (JSON array): remove individual image-rows
          - new_files: append as fresh rows
        """
        raw_data      = request.form.to_dict()
        original_name = raw_data.get("original_name")
        new_name      = raw_data.get("laboratory_name")
        category      = raw_data.get("category")
        description   = raw_data.get("description")
        date          = raw_data.get("date")

        try:
            ids_to_delete = json.loads(raw_data.get("ids_to_delete", "[]"))
        except Exception:
            ids_to_delete = []

        try:
            # 1. Delete marked rows + disk files
            for del_id in ids_to_delete:
                row = Utils.get_by_id(self.model, int(del_id))
                if row:
                    if row.filename:
                        self.model.delete_file(row.filename)
                    db.session.delete(row)
            db.session.commit()

            # 2. Update remaining rows sharing original_name
            remaining = self.model.query.filter_by(laboratory_name=original_name).all()
            for row in remaining:
                row.laboratory_name = new_name
                row.category        = category
                row.description     = description
                row.date            = date
            db.session.commit()

            # 3. Append newly uploaded images as new rows
            new_files = request.files.getlist("new_files")
            if new_files and new_files[0].filename != "":
                new_rows = []
                for f in new_files:
                    filename, filepath = self.model.save_file(f)
                    new_rows.append(self.model(
                        laboratory_name = new_name,
                        category        = category,
                        description     = description,
                        filename        = filename,
                        filepath        = filepath,
                        date            = date,
                    ))
                db.session.add_all(new_rows)
                db.session.commit()

            return ResponseHelper.success("Updated successfully!")
        except Exception as e:
            db.session.rollback()
            print(e)
            return ResponseHelper.error(str(e), 500)

    def delete_by_name(self):
        """Delete ALL rows that share the same laboratory_name."""
        data          = request.get_json()
        lab_name      = data.get("laboratory_name")

        try:
            rows = self.model.query.filter_by(laboratory_name=lab_name).all()
            for row in rows:
                if row.filename:
                    self.model.delete_file(row.filename)
                db.session.delete(row)
            db.session.commit()
            return ResponseHelper.success("Deleted successfully!")
        except Exception as e:
            db.session.rollback()
            return ResponseHelper.error(str(e), 500)








        

         
