#<!-- =========================
#    Imports
#========================== -->
from flask import render_template
from . import admin_bp
from app.https.auth.decorators import login_required

#<!-- ===========================
#    SET COURSE ASSETS FILES
#=============================-->


#<!-- =========================
#       COURSE ROUTES
#========================== -->
@admin_bp.route('/courses', methods=['GET'], endpoint='courses')
def index():
    return render_template('admin/course.html', page ='Course Management')