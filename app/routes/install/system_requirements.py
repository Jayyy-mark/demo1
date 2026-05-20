from . import install_bp
from app.https.controllers.InstallationController import InstallationController

@install_bp.route("/", methods=['GET'], endpoint="setup")
@install_bp.route("/check", methods=['GET'])
def check_system_requirement():
    return InstallationController.checkSystemRequirements()
