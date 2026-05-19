import os
from datetime import timedelta
from redis import Redis
from urllib.parse import quote_plus  # for db credentials which might include @, :, /, etc.


def _build_database_uri():
    database_url = os.getenv("DATABASE_URL")

    # Ignore common placeholder URLs such as mysql://user:pass@host:port/db.
    if database_url and ":port" not in database_url:
        return database_url

    db_username = os.getenv("DB_USERNAME", "root")
    db_password = quote_plus(os.getenv("DB_PASSWORD", ""))
    db_name = os.getenv("DB_NAME", "sms")
    db_host = os.getenv("DB_HOST", "localhost")
    db_port = os.getenv("DB_PORT", "3306")

    if not str(db_port).isdigit():
        db_port = "3306"

    return (
        "mysql+pymysql://"
        f"{quote_plus(db_username)}"
        f":{db_password}"
        f"@{db_host}:"
        f"{db_port}/"
        f"{db_name}"
    )

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
    #   APPLICATION SESSION SETUP
    #===================================-->
    PERMANENT_SESSION_LIFETIME = timedelta(minutes=1)
    SESSION_PERMANENT = True

    #<!--==================================
    #   APPLICATION DB SETUP
    #===================================-->
    
    DB_USERNAME = os.getenv("DB_USERNAME", "root")
    DB_PASSWORD = os.getenv("DB_PASSWORD", "")
    DB_NAME = os.getenv("DB_NAME", "sms")
    DB_HOST = os.getenv("DB_HOST", "localhost")
    DB_PORT = os.getenv("DB_PORT", "3306")

    SQLALCHEMY_DATABASE_URI = _build_database_uri()

    SQLALCHEMY_TRACK_MODIFICATIONS = False
    





