#<!-- =========================================
#    Imports
#========================================== -->

from . import admin_bp
from flask import render_template

#<!-- ==========================================
#    USER ROUTES
#=========================================== -->

@admin_bp.route('/users', methods=['GET'], endpoint="users")
def index():
        return render_template('admin/user.html', page="User Management")