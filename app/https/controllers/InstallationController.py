from flask import jsonify, render_template, session, request, current_app
import platform, os
from app.core.database import db
from sqlalchemy import create_engine
from flask_migrate import upgrade
from app.models.UserModel import User

from app.helpers.install import (
    checkOsVersion,
    checkPythonVersion,
    test_db_connection,
    get_uri,
    update_env,
    restart_server
)


class InstallationController:

    @staticmethod
    def checkSystemRequirements():

        info = platform.uname()

        #<!--=============================================
        #   GET OS & PYTHON VERSIONS
        #=============================================-->

        os_version, isOsVersionPassed = checkOsVersion(info)
        python_version, isPythonVersionPassed = checkPythonVersion()



        #<!--=============================================
        #   STORE THEM IN DICT FORMAT
        #==============================================-->

        data = {
            'os_version': os_version,
            'isOsVersionPassed': isOsVersionPassed,
            'python_version': python_version,
            'isPythonVersionPassed': isPythonVersionPassed
        }



        #<!--=============================================================================================
        #if current_step key exist in session it will take its value and if not it will set 1 as default
        #==============================================================================================-->

        current_step = session.get("current_step", 1)


        #<!--==============================================================================================
        #   GET APPLICATION STATUS ( CHECKING IF IT IS INSTALLED OR NOT )
        #================================================================================================-->
        
        isInstalled = os.getenv("APP_INSTALLED")

        return render_template(
            "installation/system_requirements.html", 
            data=data, 
            current_step=current_step, 
            isInstalled=isInstalled
        )


    @staticmethod
    def setupApplication():

        data = request.get_json()

        if os.getenv("APP_INSTALLED", "false") == "true":
            return jsonify({ "message" : "Application is already installed!" }), 403

        #<!--================================================================
        #   TEST DB CONNECTION ( IF FAILED RETURN DB CONNECTION ERROR )
        #=================================================================-->
        if not test_db_connection(
            data["DB_HOST"],
            data["DB_PORT"],
            data["DB_NAME"],
            data["DB_USERNAME"],
            data["DB_PASSWORD"]
        ):
            return jsonify({"error": "Database connection failed"}), 500 

        app = current_app._get_current_object()

        new_uri = get_uri(data)

        app.config['SQLALCHEMY_DATABASE_URI'] = new_uri

        with app.app_context():
            
            try:

                InstallationController.connect_new_db_engine(new_uri)

                #<!--======================================================
                #   UPGRADE(ADD) MIGRATION ON OUR DB
                #=======================================================-->

                upgrade()#flask db upgrade


            except Exception as e:

                print("CRITICAL ERROR IN SETUP: ", str(e))

                return jsonify({"error": str(e)}), 500
            
        #<!--=======================================================
        #   CREATE ADMIN USER ACCOUNT
        #========================================================-->
        
        user = User.create_admin(
            data.get("email"),
            data.get("password"),
            data.get("username"),
            role="admin"
        )


        if not user:
            return jsonify({"error": "User already exists"}), 400
        

        #<!--=======================================================
        #   UPDATE ENVIROMENT VARIABLES (.env file)
        #========================================================-->
        update_env("DB_HOST", data["DB_HOST"])
        update_env("DB_PORT", data["DB_PORT"])
        update_env("DB_NAME", data["DB_NAME"])
        update_env("DB_USERNAME", data["DB_USERNAME"])
        update_env("DB_PASSWORD", data["DB_PASSWORD"])
        update_env("APP_INSTALLED", "true")

        return jsonify({
            "message": "Installation successful",
            "username" : user.user_name,
            "email" : user.user_email,
            "db_name" : data.get("DB_NAME"),
        }), 201


           

    @staticmethod
    def saveInstallationStep():

        data = request.get_json()

        session["current_step"] = data.get("step", 1)

        return jsonify({
            "success": True,
            "current_step": session["current_step"]
        })


    @staticmethod
    def restartServer():

        isInstalled = os.getenv("APP_INSTALLED").lower() == "true"

        if isInstalled:
            restart_server()

        return jsonify({
            "message" : "Application setup is complete and server is attempting to restart!"
        })
    

    @staticmethod
    def connect_new_db_engine(new_uri):

        #<!--============================================================================
        #   REMOVE OLD DB ENGINE WHICH IS CREATED WITH OLD SQL_ALCHEMY_URI CONFIG
        #==============================================================================-->

        if hasattr(db, 'engines'):
            db.engines.clear()

        #<!--============================================================================
        #   CREATE NEW DB ENGINE
        #==============================================================================-->        

        new_engine = create_engine(new_uri, pool_pre_ping=True)
            

        #<!--===================================
        #   ADD NEW DB ENGINE ON APP CONTEXT
        #=====================================-->  

        db.engines[None] = new_engine



        #<!--===================================
        #   CONNECT OUR ADDED DB ENGINE
        #=====================================-->          

        connection = db.engine.connect()
        connection.close()
