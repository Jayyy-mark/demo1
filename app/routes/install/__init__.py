from flask import Blueprint

install_bp = Blueprint("install", __name__, url_prefix="/install")

from . import system_requirements