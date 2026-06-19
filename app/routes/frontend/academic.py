from app.helpers.utils import Utils
from app.models.DashboardModel import Dashboard

from . import frontend_bp
from flask import render_template

@frontend_bp.route('/academic', endpoint="academic")
def academic():
    admission = Utils.get_by_Column(Dashboard, attr_key="Admission Lists")
    return render_template('frontend/academic.html', admissionLists=admission[0].value)


