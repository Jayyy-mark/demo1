from flask import render_template
from . import admin_bp


@admin_bp.route("/research", endpoint="research")
def index():
    return render_template("admin/research.html", page="Research")

