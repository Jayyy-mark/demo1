from . import admin_bp
from flask import jsonify, session, render_template
from flask_jwt_extended import unset_jwt_cookies


@admin_bp.route("/auth/login", methods=["GET"], endpoint="login")
def login():
    return render_template("admin/auth/login.html")


@admin_bp.route("/auth/logout", methods=["GET"], endpoint="logout")
def logout():
    response = jsonify({"message": "Logout successful"})
    # Clear Flask session
    session.clear()

    # Clear JWT cookies
    unset_jwt_cookies(response)

    return render_template("admin/auth/login.html", response=response, status=200)
