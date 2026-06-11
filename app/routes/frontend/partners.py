from . import frontend_bp
from flask import render_template


@frontend_bp.route('/partners', endpoint='partners')
def library():
    return render_template('frontend/partners.html')