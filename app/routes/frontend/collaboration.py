from . import frontend_bp
from flask import render_template


@frontend_bp.route("/collaboration/company", endpoint="company")
def library():
    return render_template("frontend/collaboration_company.html")


@frontend_bp.route("/collaboration/university", endpoint="university")
def library():
    return render_template("frontend/collaboration_university.html")
