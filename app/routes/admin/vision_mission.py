from flask import render_template
from . import admin_bp
from app.https.auth.decorators import login_required

@admin_bp.route('/vision-mission', methods=['GET'], endpoint='vision_mission')
@login_required
def index():
    return render_template('admin/vision_mission.html', page='Vision & Mission')
