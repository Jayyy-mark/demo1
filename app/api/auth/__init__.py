from flask import Blueprint

auth_api = Blueprint("auth_api", __name__, url_prefix="/api/auth")

from . import login
from . import refresh