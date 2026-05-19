from flask import Blueprint

frontend_bp = Blueprint("frontend", __name__)

#<!--===========================
#   IMPORT ROUTES HERE
#============================-->

from . import home
from . import academic
from . import faculties
from . import news_activities
from . import admission
from . import research
from . import library
from . import about
from . import campus_gallery
from . import syllabus_courses