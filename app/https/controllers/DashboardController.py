import os
from flask import request, current_app
from werkzeug.utils import secure_filename
from .BaseController import BaseController
from app.models.DashboardModel import Dashboard
from app.schemas.dashboard import DashboardSchema
from app.helpers.utils import Utils, ResponseHelper


class DashboardController(BaseController):
    def __init__(self):
        super().__init__(Dashboard, DashboardSchema())
        self.upload_folder = os.path.join(
            current_app.root_path, "resources", "assets", "media", "admission"
        )

    # <!--==========================================
    #   ACADEMIC ADMISSION LIST SECTION
    # ===========================================-->

    # <!--===================
    #   SAVE FILE
    # ===================-->
    def save_file(self, file):

        filename = secure_filename(file.filename)
        os.makedirs(self.upload_folder, exist_ok=True)
        file_path = os.path.join(self.upload_folder, filename)

        file.save(file_path)

        file_path = os.path.join("/assets/media/admission/", filename)

        return file_path

    # <!--=================
    #   DELETE FILE
    # ===================-->
    def deleteFile(self, filepath):

        # remove leading slashes (VERY IMPORTANT)
        filepath = filepath.lstrip("/\\")

        path = os.path.join(current_app.root_path, "resources", filepath)

        print("this is the path to delete:", path)

        if os.path.exists(path):
            os.remove(path)
            print("file deleted!")
        else:
            print("file not found!")

    def checkAdmissionList(self):
        admission = Utils.get_by_Column(self.model, attr_key="Admission Lists")
        return admission

    def addRectorMessage(self):
        try:
            data = request.get_json()
            print("this is data : ", data)
            Utils.create_or_update(
                Dashboard,
                lookup_fields={"attr_key": "Rector's Message"},
                update_fields={"value": data["value"]},
            )

            return ResponseHelper.success(
                "Rector's Message Added Successfully!",
            )

        except Exception as e:
            return ResponseHelper.error(str(e), 400)

    def addAdmissionLists(self):

        admission = self.checkAdmissionList()

        if admission:
            print(
                "Admission Lists already exists, deleting the old file... :",
                admission[0].value,
            )
            self.deleteFile(admission[0].value)

        filePath = ""
        file = request.files.get("file")
        if file:
            filePath = self.save_file(file)
            print("file has been saved , path is : ", filePath)

        try:

            Utils.create_or_update(
                Dashboard,
                lookup_fields={"attr_key": "Admission Lists"},
                update_fields={"value": filePath},
            )

            return ResponseHelper.success(
                "Uploaded Successfully!",
            )

        except Exception as e:
            print(str(e))
            return ResponseHelper.error(str(e), 400)

    def editAdmissionLists(self):

        data = []

        id = request.json.get("id")

        file = request.files.get("academic_admission_lists")

        if file:
            filePath = self.save_file(file)

        data.append({"key": "Admission Lists", "value": filePath})

        try:

            Utils.update(self.model, id, data)
            return ResponseHelper.success(
                "Uploaded Successfully!",
            )

        except Exception as e:
            return ResponseHelper.error(str(e), 400)

    def deleteAdmissionLists(self):

        id = request.json.get("id")

        # <!--================================================
        #   DELETE FILE BEFORE DELETING RECORD ON DATABASE
        # =================================================-->
        admission = Utils.get_by_id(self.model, id)
        self.deleteFile(admission.value)

        # <!--================================================
        #   CALL PARENT CLASS TO DELETE RECORD
        # =================================================-->
        super().delete()
