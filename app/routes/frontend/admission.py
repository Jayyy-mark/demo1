from flask import render_template
from . import frontend_bp

@frontend_bp.route('/admission')
def admission():
    """Admission Page"""
    return render_template('frontend/admission.html')