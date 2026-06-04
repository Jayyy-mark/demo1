from . import frontend_bp
from flask import render_template

@frontend_bp.route('/academic/calendar', endpoint="academic_calendar")
def academic():
    return render_template('frontend/academic_calendar.html')