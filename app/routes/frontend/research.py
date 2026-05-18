from . import frontend_bp
from flask import render_template

@frontend_bp.route('/research', endpoint='research')
def research():
    """Research and Publications Page"""
    return render_template('frontend/research.html')

@frontend_bp.route('/research/laboratory/<int:id>')
def lab_details(id):
    # lab_name အလိုက် မတူညီတဲ့ content တွေပြဖို့ logic ထည့်နိုင်ပါတယ်
    return render_template('frontend/lab_details.html', laboratory_id=id)