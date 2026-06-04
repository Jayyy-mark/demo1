from flask import render_template
from . import admin_bp
from app.https.auth.decorators import login_required


@admin_bp.route("/calendar", methods=["GET"], endpoint="calendar")
@login_required
def index():
    return render_template("admin/calendar.html", page="Calendar")
