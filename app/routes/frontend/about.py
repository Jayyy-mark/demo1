from . import frontend_bp
from flask import render_template

@frontend_bp.route('/about')
def about():
    """About Us / History / Organization Page"""
    return render_template('frontend/about.html')