#<-=================================
#   IMPORTS
#=================================->

from flask import render_template
from . import admin_bp
from app.https.auth.decorators import login_required


#<-=================================
#   DASHBOARD ROUTES
#=================================->
@admin_bp.route('/', endpoint="index")
@admin_bp.route('/dashboard', endpoint="dashboard")
@login_required  
def index():
    return render_template('admin/dashboard.html',  page='Dashboard')


