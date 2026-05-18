from dotenv import load_dotenv
load_dotenv() #important <!--===== loading enviroment variables from .env file ================-->


from flask import Flask, app
from flask_cors import CORS

from app.core import init_db, Config, register_error_handlers, setup_contexts

from app.routes import register_routes
from app.api import register_api
from app.models import register_models

from app.https.middleware.auth_middleware import attach_user
from flask_jwt_extended import JWTManager

def create_app():

    app = Flask(__name__,template_folder="resources/views",static_folder="resources/assets")
    CORS(app, supports_credentials=True)

    app.before_request(attach_user)


    #<!-- =================================================
    #  APPLICATION CONFIGURATION (SECURITY+DATABASE) SETUP
    #====================================================== -->
    app.config.from_object(Config)
    init_db(app)
 


    #<!-- =========================
    #  JWT (JASON WEB TOKEN) SETUP
    #========================== -->
    jwt = JWTManager(app)



    #<!-- =========================
    #  APPLICATION INSFASTRUCTURE
    #========================== -->
    register_models()
    setup_contexts(app)
    register_api(app)
    register_routes(app)
    register_error_handlers(app)



    return app


#<!-- ========================================
#  HELPER FUNCTION FOR CHECKING ROUTE LIST
#========================================== -->
def route_lists(app:Flask):
    for rule in app.url_map.iter_rules():
        print(f"Endpoint: {rule.endpoint}")
        print(f"Methods: {rule.methods}")
        print(f"Route: {rule}")
        print("------")