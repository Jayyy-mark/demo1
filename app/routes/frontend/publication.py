from . import frontend_bp
from flask import render_template

@frontend_bp.route('/publication', endpoint='publication')
def publication():
    return render_template('frontend/publication.html')