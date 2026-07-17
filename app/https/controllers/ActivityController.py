from app.models.ActivityModel import Activity
from app.schemas.activity import ActivitySchema
from .BaseController import BaseController
from app.helpers.utils import Utils, ResponseHelper
from app.core.database import db
from flask import request
import json


class ActivityController(BaseController):

    def __init__(self):
        super().__init__(Activity, ActivitySchema())

    def create(self):

        raw_data = request.form.to_dict()

        data = []

        files = request.files.getlist("file")

        if files and files[0].filename != "":
            for file in files:
                filename, filepath = self.model.save_file(file)
                data.append(
                    {
                        "activity_name": raw_data.get("activity_name"),
                        "category": raw_data.get("category"),
                        "activity_type": raw_data.get("activity_type"),
                        "description": raw_data.get("description"),
                        "filename": filename,
                        "filepath": filepath,
                        "date": raw_data.get("date"),
                    }
                )
        else:
            data.append(
                {
                    "activity_name": raw_data.get("activity_name"),
                    "category": raw_data.get("category"),
                    "activity_type": raw_data.get("activity_type"),
                    "description": raw_data.get("description"),
                    "filename": None,
                    "filepath": None,
                    "date": raw_data.get("date"),
                }
            )

        try:
            Utils.bulk_create(self.model, data)
            return ResponseHelper.success(
                "Created successfully!",
            )
        except Exception as e:
            return ResponseHelper.error(str(e), 500)

    def update(self):
        data = request.form.to_dict()
        print("this is activity data : ", data)
        file = request.files.get("file")

        if file and file.filename != "":
            print("file name is exist!")
            activity = Utils.get_by_id(self.model, data.get("id"))

            if activity.filename:
                self.model.delete_file(activity.filename)

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
            return ResponseHelper.error(str(e), 500)

    def delete(self):
        data = request.get_json()
        activity = Utils.get_by_id(self.model, data.get("id"))

        if activity.filename:
            self.model.delete_file(activity.filename)

        try:
            Utils.delete(self.model, data.get("id"))
            return ResponseHelper.success(
                "Deleted successfully!",
            )
        except Exception as e:
            return ResponseHelper.error(str(e), 500)

    # ─────────────────────────────────────────────────────────────────
    #  GROUP-AWARE ENDPOINTS
    # ─────────────────────────────────────────────────────────────────

    def update_by_name(self):
        """
        Update all rows that share the same activity_name.
        Also handles:
          - ids_to_delete (JSON array): remove individual image-rows
          - new files: append as fresh rows
        """
        raw_data = request.form.to_dict()
        original_name = raw_data.get("original_name")   # the name before editing
        new_name      = raw_data.get("activity_name")
        category      = raw_data.get("category")
        activity_type = raw_data.get("activity_type")
        description   = raw_data.get("description")
        date          = raw_data.get("date")

        # IDs of existing image-rows to delete
        ids_to_delete_raw = raw_data.get("ids_to_delete", "[]")
        try:
            ids_to_delete = json.loads(ids_to_delete_raw)
        except Exception:
            ids_to_delete = []

        try:
            # 1. Delete marked rows
            for del_id in ids_to_delete:
                row = Utils.get_by_id(self.model, int(del_id))
                if row:
                    if row.filename:
                        self.model.delete_file(row.filename)
                    db.session.delete(row)
            db.session.commit()

            # 2. Update remaining rows that share original_name
            remaining = self.model.query.filter_by(activity_name=original_name).all()
            for row in remaining:
                row.activity_name = new_name
                row.category      = category
                row.activity_type = activity_type
                row.description   = description
                row.date          = date
            db.session.commit()

            # 3. Save any newly uploaded images as new rows
            new_files = request.files.getlist("new_files")
            if new_files and new_files[0].filename != "":
                new_rows = []
                for f in new_files:
                    filename, filepath = self.model.save_file(f)
                    new_rows.append(self.model(
                        activity_name = new_name,
                        category      = category,
                        activity_type = activity_type,
                        description   = description,
                        filename      = filename,
                        filepath      = filepath,
                        date          = date,
                    ))
                db.session.add_all(new_rows)
                db.session.commit()

            return ResponseHelper.success("Updated successfully!")
        except Exception as e:
            db.session.rollback()
            print(e)
            return ResponseHelper.error(str(e), 500)

    def delete_by_name(self):
        """
        Delete ALL rows that share the same activity_name.
        """
        data = request.get_json()
        activity_name = data.get("activity_name")

        try:
            rows = self.model.query.filter_by(activity_name=activity_name).all()
            for row in rows:
                if row.filename:
                    self.model.delete_file(row.filename)
                db.session.delete(row)
            db.session.commit()
            return ResponseHelper.success("Deleted successfully!")
        except Exception as e:
            db.session.rollback()
            return ResponseHelper.error(str(e), 500)
