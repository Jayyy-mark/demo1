from flask import send_file, Blueprint
from flask import current_app

download_bp = Blueprint("download", __name__, url_prefix="/download")

def clean_filepath(filepath):
    filepath = filepath.replace("\\", "/")

    # remove leading /assets/
    if filepath.startswith("assets/"):
        filepath = filepath.replace("assets/", "", 1)

    return filepath.lstrip("/")

@download_bp.route("<path:filename>")
def download(filename):

    filename = clean_filepath(filename)

    return send_file(f"{current_app.root_path}/resources/assets/{filename}", as_attachment=True)