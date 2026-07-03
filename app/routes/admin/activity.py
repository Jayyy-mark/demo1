from flask import render_template
from . import admin_bp
from app.https.auth.decorators import login_required


@admin_bp.route("/activity", methods=["GET"], endpoint="activity")
@login_required
def index():
    return render_template("admin/activity.html", page="Activity")


@admin_bp.route("/debug-ip")
def debug_ip():
    from flask import request

    return request.remote_addr
