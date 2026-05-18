from . import install_bp

from flask import render_template

@install_bp.route("/check", methods=['GET'])
def check_system_requirement():
    return render_template("installation/system_requirements.html")