from . import frontend_bp

from flask import render_template

@frontend_bp.route('/', endpoint="index")
@frontend_bp.route('/home', endpoint="home")
def index():
    return render_template('frontend/index.html')