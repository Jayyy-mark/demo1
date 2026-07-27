import re
from flask import render_template, abort
from . import frontend_bp
from app.models.VisionMissionModel import VisionMission
from app.models.DepartmentModel import Department
from app.helpers.utils import _split_mission_en, _split_mission_mm

# ── dept_code  →  display name ──────────────────────────────────────────────
DEPT_NAMES = {
    "fcs": "Faculty of Computer Science",
    "fcst": "Faculty Of Computer Systems and Technologies",
    "fis": "Faculty Of Information Science",
    "itsm": "Department of Information Technologies Support and Maintenance",
    "fc": "Faculty Of Computing",
    "dl": "Department of Natural Language",
    "dns": "Department Of Natural Science",
    "da": "Department Of Administration",
    "df": "Department Of Finance",
    "dsa": "Department Of Student Affairs",
}


@frontend_bp.route("/faculties/<string:dept_code>", endpoint="department")
def department_detail(dept_code: str):
    dept_name = DEPT_NAMES.get(dept_code.lower())
    if not dept_name:
        abort(404)

    # ── find matching Department row by display name ─────────────────────────
    department_row = Department.query.filter_by(department_name=dept_name).first()

    vision_en = ""
    vision_mm = ""
    mission_en: list[str] = []
    mission_mm: list[str] = []

    if department_row:
        # ── fetch EN record ───────────────────────────────────────────────────
        en_record: VisionMission | None = VisionMission.query.filter_by(
            department_id=department_row.id, language="en"
        ).first()

        if en_record:
            vision_en = en_record.vision or ""
            mission_en = _split_mission_en(en_record.mission or "")

        # ── fetch MM record ───────────────────────────────────────────────────
        mm_record: VisionMission | None = VisionMission.query.filter_by(
            department_id=department_row.id, language="mm"
        ).first()

        if mm_record:
            vision_mm = mm_record.vision or ""
            mission_mm = _split_mission_mm(mm_record.mission or "")

    department = {
        "name": dept_name,
        "vision": vision_en,
        "vision_mm": vision_mm,
        "mission": mission_en,
        "mission_mm": mission_mm,
    }

    return render_template("frontend/departments.html", department=department)
