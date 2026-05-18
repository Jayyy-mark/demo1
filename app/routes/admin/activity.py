from flask import render_template
from . import admin_bp

@admin_bp.route("/activity", methods=['GET'], endpoint="activity")
def index():
    return render_template("admin/activity.html", page="Activity")

