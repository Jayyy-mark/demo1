from . import auth_api
from flask import jsonify, session
from flask_jwt_extended import unset_jwt_cookies


@auth_api.route("/logout", methods=["POST"])
def logout():

    response = jsonify({"message": "Logout successful"})

    # Clear Flask session
    session.clear()

    # Clear JWT cookies
    unset_jwt_cookies(response)

    return response, 200
