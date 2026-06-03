from flask import jsonify, render_template, session, request, current_app, redirect, url_for
import platform, os
from app.core.database import db
from sqlalchemy import create_engine
from flask_migrate import upgrade
from app.models.UserModel import User
from app.models.SettingModel import Setting
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

        #<!--=============================================
        #   GET OS & PYTHON VERSIONS
        #=============================================-->

        os_version, isOsVersionPassed = checkOsVersion()
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
        
        isInstalled = Setting().isInstalled()

        return render_template(
            "installation/system_requirements.html", 
            data=data, 
            current_step=current_step, 
            isInstalled=isInstalled
        )


    @staticmethod
    def setupApplication():

        data = request.get_json()

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
        

        # Update the setting in the database
        setting = Setting.query.get(1)

        if not setting:
            setting = Setting(id=1, app_installed=True)
            db.session.add(setting)
        else:
            setting.app_installed = True

        db.session.commit()

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

        if Setting().isInstalled():
            restart_server()

        return redirect(url_for('admin.login'))
    