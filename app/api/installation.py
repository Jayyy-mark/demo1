import subprocess
import sys

from flask import Blueprint, jsonify, request, session
from app.models.UserModel import User
from app.schemas.admin.User import UserSchema
from sqlalchemy import create_engine
from sqlalchemy.exc import OperationalError
from app.core.database import db
from app.core.database import migrate
from flask import current_app
from flask_migrate import upgrade

from app.https.controllers.InstallationController import InstallationController
import os


# ==========================================
# TEMP DB CONNECTION (INSTALLER ONLY)
# =========================================
def run_migrations():
    try:
        result = subprocess.run(
            [sys.executable, "-m", "flask", "db", "upgrade"],
            check=True,
            capture_output=True,
            text=True
        )
        print(result.stdout)
        return True
    except subprocess.CalledProcessError as e:
        print("Migration failed:", e.stderr)
        return False


# ==========================================
# BLUEPRINT
# ==========================================

installation_api = Blueprint(
    "installation_api",
    __name__,
    url_prefix="/api/installation"
)


@installation_api.route("/setup", methods=["POST"])
def setup_application():
    return InstallationController.setupApplication()


@installation_api.route("/update-step", methods=["POST"])
def update_step():
    return InstallationController.saveInstallationStep()


@installation_api.route("/finish-step", methods=["GET"], endpoint="finish")
def finish_step():
    return InstallationController.restartServer()




