from flask import render_template
from . import admin_bp
from app.https.auth.decorators import login_required

@admin_bp.route('/collaboration', methods=['GET'], endpoint='collaboration')
@login_required
def index():
    return render_template('admin/collaboration.html', page='Collaboration')
