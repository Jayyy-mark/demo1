from flask import render_template
from . import admin_bp

@admin_bp.route("/laboratory", methods=['GET'], endpoint="laboratory")
def index():
    return render_template("admin/laboratory.html", page="Laboratory")

