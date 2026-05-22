#<!-- =========================
#    Imports
#========================== -->


from flask import render_template, session
from . import admin_bp
from app.https.auth.decorators import login_required


#<!-- =========================
#    Subject ROUTES
#========================== -->

@admin_bp.route('/subject', methods=['GET'], endpoint='subject')
@login_required
def index():
    active_tab = session.get('active-tab','subjects')
    return render_template('admin/subject.html', page ='Subjects', active_tab=active_tab)

