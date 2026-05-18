from . import frontend_bp
from flask import render_template

@frontend_bp.route('/research')
def research():
    """Research and Publications Page"""
    return render_template('frontend/research.html')

@frontend_bp.route('/research/labs/<lab_name>')
def lab_details(lab_name):
    # lab_name အလိုက် မတူညီတဲ့ content တွေပြဖို့ logic ထည့်နိုင်ပါတယ်
    return render_template('frontend/lab_details.html', lab_name=lab_name)