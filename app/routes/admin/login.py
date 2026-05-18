from . import admin_bp
from flask import render_template


@admin_bp.route('/auth/login', methods=['GET'], endpoint="login")
def login():
    return render_template("admin/auth/login.html");