from dotenv import load_dotenv
load_dotenv(override=True) #important <!--===== loading enviroment variables from .env file ================-->

from flask import Flask
from flask_cors import CORS

from app.core import init_db, Config, register_error_handlers, setup_contexts

from app.routes import register_routes
from app.api import register_api
from app.models import register_models

import os
from app.https.middleware.auth_middleware import attach_user
from flask_jwt_extended import JWTManager

from app.helpers.install import check_installation



def create_app():
    try:
        # installed = os.getenv("APP_INSTALLED", "false").lower() == "true"

        app = Flask(__name__,template_folder="resources/views",static_folder="resources/assets")

        CORS(app, supports_credentials=True)
    
        # =========================
        # INSTALLATION GUARD
        # =========================

        app.before_request(check_installation)

        # =========================
        # USER AUTH MIDDLEWARE
        # =========================
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
    except Exception as e:
        print("this is error : ", str(e))
        raise(e)


#<!-- ========================================
#  HELPER FUNCTION FOR CHECKING ROUTE LIST
#========================================== -->
def route_lists(app:Flask):
    for rule in app.url_map.iter_rules():
        print(f"Endpoint: {rule.endpoint}")
        print(f"Methods: {rule.methods}")
        print(f"Route: {rule}")
        print("------")
