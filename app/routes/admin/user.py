#<!-- =========================================
#    Imports
#========================================== -->

from . import admin_bp
from flask import render_template
from app.https.auth.decorators import login_required

#<!-- ==========================================
#    USER ROUTES
#=========================================== -->

@admin_bp.route('/users', methods=['GET'], endpoint="users")
@login_required
def index():
        return render_template('admin/user.html', page="User Management")