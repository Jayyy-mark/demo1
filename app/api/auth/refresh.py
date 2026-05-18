from . import auth_api
from flask import jsonify
from flask_jwt_extended import create_access_token, jwt_required, get_jwt_identity, set_access_cookies

@auth_api.route("/refresh", methods=['POST'])
@jwt_required(refresh=True)
def refresh_token():
    
    try:
        current_user = get_jwt_identity()
        new_access_token = create_access_token(identity=current_user)
        
        response = jsonify({
            "message" : "Token refreshed!"
        })

        set_access_cookies(response, new_access_token)

        return response
    except Exception as e:
        print(e)
        raise(e)