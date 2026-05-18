#<-=================================
#   IMPORTS
#=================================->

from flask import Blueprint, render_template, url_for, g

#<-=================================
#   DASHBOARD BLUEPRINT
#=================================->

error_bp = Blueprint("error", __name__, url_prefix="/error")


#<-=================================
#   SETUPS CONTEXT PROCESSOR
#=================================->


#<-=================================
#   ERROR ROUTES
#=================================->

@error_bp.route('/404', methods=['GET'])
def _404():
    return render_template('error/404.html')

@error_bp.route('/500', methods=['GET'])
def _500():
    return render_template('error/500.html')

@error_bp.route('/401', methods=['GET'])
def _401():
    return render_template('auth/login.html')


