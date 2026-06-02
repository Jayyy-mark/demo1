from . import frontend_bp
from flask import render_template

@frontend_bp.route('/academic_cal', endpoint="academic_cal")
def academic():
    return render_template('frontend/academic_calendar.html')