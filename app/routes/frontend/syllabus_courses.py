from . import frontend_bp
from flask import render_template

@frontend_bp.route('/syllabus_courses', endpoint='syllabusCourses')
def syllabus_courses():
    return render_template('frontend/syllabus_courses.html')