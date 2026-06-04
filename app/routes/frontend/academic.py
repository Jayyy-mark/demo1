from . import frontend_bp
from flask import render_template

@frontend_bp.route('/academic', endpoint="academic")
def academic():
    return render_template('frontend/academic.html')


