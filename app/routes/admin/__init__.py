#<-=================================
#   USER BLUTEPRINT
#=================================->

from flask import Blueprint, url_for, g

admin_bp = Blueprint('admin',__name__, url_prefix='/admin')

#<-=================================
#    SETUP CONTEXT PROCESSOR
#=================================->

@admin_bp.context_processor
def inject_assets():
        baseAssets = getattr(g, 'assets', {})
        newAssets = {
            'admin' : {
                'user':{
                    'css':None,
                    'script':url_for('static', filename='admin/js/src/core/user.js'),
                },
                'auth' : {
                    'css' : None,
                    'script' : url_for('static', filename='admin/js/src/core/auth.js')
                },
                'activity' : {
                    'css' : None,
                    'script' : url_for('static', filename='admin/js/src/core/activity.js')
                },
                'course' :{
                    'css': None,
                    'scripts' : url_for('static', filename='admin/js/src/core/course.js')
                },
                'dashboard' : {
                    'css' : url_for('static', filename='admin/css/pages/dashboard.css'),
                    'scripts' : url_for('static', filename='admin/js/src/core/dashboard.js'),

                },
                'research' : {
                    'css' : None,
                    'script' : url_for('static', filename='admin/js/src/core/research.js')
                },
                'laboratory' : {
                    'css' : None,
                    'script' : url_for('static', filename='admin/js/src/core/laboratory.js')
                },
                'academic':{
                    'css' : url_for('static', filename='admin/css/pages/academic.css'),
                    'scripts': [
                        url_for('static', filename='admin/js/src/core/subject.js'),
                        url_for('static', filename='admin/js/src/core/department.js'),
                        url_for('static', filename='admin/js/src/core/semester.js'),
                        url_for('static', filename='admin/js/src/core/year.js')
                    ]
                },
                'calendar': {
                    'css': None,
                    'script': url_for('static', filename='admin/js/src/core/calendar.js')
                },
                'vision_mission': {
                    'css': None,
                    'script': url_for('static', filename='admin/js/src/core/vision_mission.js')
                },
                'collaboration': {
                    'css': None,
                    'script': url_for('static', filename='admin/js/src/core/collaboration.js')
                },
            }
        }
        mergedAssets = {**baseAssets, **newAssets}
        return dict(assets=mergedAssets)

#<-=================================
#   IMPORT ROUTES
#=================================->

from . import user
from . import activity
from . import course
from . import dashboard
from . import login
from . import research
from . import subject
from . import laboratory
from . import calendar
from . import vision_mission
from . import collaboration
