from .BaseController import BaseController
from app.models.AcademicCalendarModel import AcademicCalendar
from app.schemas.academic_calendar import AcademicCalendarSchema
from app.helpers.utils import ResponseHelper, Utils
from datetime import datetime, date
from flask import request

class AcademicCalendarController(BaseController):
    def __init__(self):
        super().__init__(AcademicCalendar, AcademicCalendarSchema())

    allowed_statuses = {"Pending", "On Progress", "Completed"}

    def _status_for_dates(self, start_date, end_date):
        today = date.today()

        if today > end_date:
            return "Completed"

        if today >= start_date:
            return "On Progress"

        return "Pending"

    def _prepare_data(self, data):
        for field in ("start_date", "end_date"):
            if field in data and isinstance(data[field], str):
                data[field] = datetime.strptime(data[field], "%Y-%m-%d").date()

        if data.get("start_date") and data.get("end_date"):
            data["status"] = self._status_for_dates(data["start_date"], data["end_date"])
        else:
            status = data.get("status", "Pending")

            if status not in self.allowed_statuses:
                raise ValueError("Status must be Pending, On Progress, or Completed")

            data["status"] = status

        return data

    def all(self):
        data = Utils.get_all(self.model)

        if not data:
            return ResponseHelper.success("Fetched successfully", [])

        calendar_events = self.schema.dump(data, many=True)

        for event in calendar_events:
            event["status"] = self._status_for_dates(
                datetime.strptime(event["start_date"], "%Y-%m-%d").date(),
                datetime.strptime(event["end_date"], "%Y-%m-%d").date()
            )

        return ResponseHelper.success("Fetched successfully", calendar_events)

    def create(self, data=None):
        try:
            if data is None:
                data = request.get_json() or {}
            return super().create(self._prepare_data(data))
        except ValueError as e:
            return ResponseHelper.error(str(e), 400)
        except Exception as e:
            return ResponseHelper.error(str(e), 500)

    def update(self, data=None):
        try:
            if data is None:
                data = request.get_json() or {}
            return super().update(self._prepare_data(data))
        except ValueError as e:
            return ResponseHelper.error(str(e), 400)
        except Exception as e:
            return ResponseHelper.error(str(e), 500)
