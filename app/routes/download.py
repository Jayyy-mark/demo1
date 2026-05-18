from flask import send_file, Blueprint
from flask import current_app

download_bp = Blueprint("download", __name__, url_prefix="/download")

@download_bp.route("/<path:filename>")
def download(filename):
    return send_file(f"{current_app.root_path}/resources/assets/{filename}", as_attachment=True)