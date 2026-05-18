
from flask import Request

class DashboardController:

    def summary():
        return {}
    
    def allClassrooms():
        return {}
    
    def studentCountBySemester(request : Request):
        semester = request.args.get("semester")
        return {}