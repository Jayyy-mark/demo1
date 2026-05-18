from . import auth_api
from flask import request, jsonify, session
from app.models.UserModel import User
import os
from flask_jwt_extended import create_access_token, create_refresh_token, set_refresh_cookies, set_access_cookies

@auth_api.route("/login", methods=['POST'])
def login():

    try:
        data = request.get_json()
        
        email = data.get("user_email")
        password = data.get("user_password")
        
        if not email or not password:
            return jsonify({"error": "Missing credentials"}), 400

        user = User.authenticate(email, password)
        
        if not user:
            print("use not foud")
            return jsonify({"error": "Invalid credentials"}), 401

        
        session["user_id"] = user.id

        #jwt authentication section for api

        access_token = create_access_token(identity=str(user.id))
        refresh_token = create_refresh_token(identity=str(user.id))


        response = jsonify({
            "message" : "Login successful!",
        })


        set_access_cookies(response, access_token)

        set_refresh_cookies(response, refresh_token)
    except Exception as e:
        print(e)
        raise(e)

    return response