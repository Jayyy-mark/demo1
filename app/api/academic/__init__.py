#<-=========================================
#        ACADEMIC API BLUEPRINT
#=========================================->

from flask import Blueprint, request, session, jsonify

academic_api = Blueprint('api_academic', __name__, url_prefix='/api/academic')

@academic_api.route('/tab', methods=['POST'])
def tab():
    data = request.get_json()
    session['active-tab'] = data.get('tab')
    return jsonify({'message' : 'saved!'}),200

#<-=========================================
#        IMPORTS API ROUTES
#=========================================->

from . import subject
from . import course
from . import year
from . import semester
