from flask import render_template
from . import admin_bp
from app.https.auth.decorators import login_required

@admin_bp.route("/laboratory", methods=["GET"], endpoint="laboratory")
@login_required
def index():
    return render_template("admin/laboratory.html", page="Laboratory")
