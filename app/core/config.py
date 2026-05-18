import os
from datetime import timedelta

from urllib.parse import quote_plus #for db_user password which might incldue @, :, /, etc.. (special characters)

class Config:

    #<!--==================================
    #   APPLICATION SECURITY SETUP
    #===================================-->
    #app secret key
    SECRET_KEY = os.getenv("SECRET_KEY", "dev_secret_key") #I put fall back for debuging, development and you can remove dev_sercret_key on production server
    
    #jwt settings
    JWT_SECRET_KEY = os.getenv("JWT_SECRET_KEY")
    JWT_TOKEN_LOCATION = ["cookies"]

    #token lifespan
    JWT_ACCESS_TOKEN_EXPIRES = timedelta(minutes=15)
    JWT_REFRESH_TOKEN_EXPIRES = timedelta(hours=24)

    #security and cookie settings
    JWT_ACCESS_COOKIE_PATH = "/"
    JWT_REFRESH_COOKIE_PATH = "/api/auth/refresh"

    JWT_COOKIE_SECURE = True
    JWT_COOKIE_HTTPONLY = True 
    JWT_COOKIE_SAMESITE = "Lax"
    JWT_COOKIE_CSRF_PROTECT = True


    #<!--==================================
    #   APPLICATION DB SETUP
    #===================================-->
    
    DB_USERNAME = os.getenv("DB_USERNAME")
    DB_PASSWORD = quote_plus(os.getenv("DB_PASSWORD", ""))
    DB_NAME = os.getenv("DB_NAME")
    DB_HOST = os.getenv("DB_HOST")
    DB_PORT = os.getenv("DB_PORT")

    SQLALCHEMY_DATABASE_URI = os.getenv(
        "DATABASE_URL",
        f"mysql+pymysql://"
        f"{DB_USERNAME}"
        f":{DB_PASSWORD}"
        f"@{DB_HOST}:"
        f"{DB_PORT}/"
        f"{DB_NAME}"
    )

    SQLALCHEMY_TRACK_MODIFICATIONS = False
    





