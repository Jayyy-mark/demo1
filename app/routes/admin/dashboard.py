#<-=================================
#   IMPORTS
#=================================->

from flask import render_template
from . import admin_bp
from app.https.auth.decorators import login_required
from app.models.CountModel import Count
from app.models.AcademicCalendarModel import AcademicCalendar


#<-=================================
#   DASHBOARD ROUTES
#=================================->
@admin_bp.route('/', endpoint="index")
@admin_bp.route('/dashboard', endpoint="dashboard")
@login_required
def index():
    counts = Count.query.first()
    academic_tasks = AcademicCalendar.query.order_by(AcademicCalendar.start_date.desc()).all()
    return render_template('admin/dashboard.html',  page='Dashboard', counts=counts, academic_tasks=academic_tasks)

