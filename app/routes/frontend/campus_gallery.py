from . import frontend_bp
from flask import render_template

@frontend_bp.route('/gallery-page', endpoint='campus_gallery')
def gallery_page():
    """Full Campus Gallery Page"""
    return render_template('frontend/campus_gallery.html')