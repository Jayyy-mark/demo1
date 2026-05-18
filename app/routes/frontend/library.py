from . import frontend_bp
from flask import render_template

@frontend_bp.route('/library')
def library():
    
    return render_template('frontend/library.html')