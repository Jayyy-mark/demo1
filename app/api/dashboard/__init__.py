#<-=========================================
#        DASHBOARD API BLUEPRINT
#=========================================->

from flask import Blueprint, request, session, jsonify

dashboard_api = Blueprint('api_dashboard', __name__, url_prefix='/api/dashboard')

@dashboard_api.route('/tab', methods=['POST'])
def tab():
    data = request.get_json()
    session['active-tab'] = data.get('tab')
    return jsonify({'message' : 'saved!'}),200

#<-=========================================
#        IMPORTS API ROUTES
#=========================================->

from . import dashboard
