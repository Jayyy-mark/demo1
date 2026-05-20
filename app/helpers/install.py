import sys, os, signal, platform
from flask import request, redirect, url_for
from sqlalchemy import create_engine
from sqlalchemy.exc import OperationalError


def check_installation():

    installed = os.getenv("APP_INSTALLED", "false").lower() == "true"

    allowed_prefixes = [
        "/api/installation",
        "/install",
        "/assets",
        "/favicon.ico"
    ]

    path = request.path

    # if NOT installed → block everything except installer
    if not installed:
        if not any(path.startswith(p) for p in allowed_prefixes):
            return redirect(url_for("install.setup"))



def checkOsVersion():
    os_name = platform.system()      # 'Windows', 'Linux'
    os_version = platform.version()  # detailed version

    status = False

    if os_name == "Windows":
        parts = os_version.split(".")
        if len(parts) >= 3:
            try:
                status = int(parts[2]) >= 10
            except:
                status = False

    return os_version, status



def checkPythonVersion():

    py_version = sys.version.split()[0]
    status = False

    if sys.version_info >= (3, 10):
        status = True

    return py_version, status


def get_uri(data):

    if data['DB_TYPE'].lower() == "mysql":
        url = (
            f"mysql+pymysql://{data['DB_USERNAME']}:{data['DB_PASSWORD']}"
            f"@{data['DB_HOST']}:{data['DB_PORT']}/{data['DB_NAME']}"
        )
    else:
        url = (
            f"postgresql+psycopg2://{data['DB_USERNAME']}:{data['DB_PASSWORD']}"
            f"@{data['DB_HOST']}:{data['DB_PORT']}/{data['DB_NAME']}"
        )        
    return url


def build_engine(data):

    url = get_uri(data)

    return create_engine(url)


def test_db_connection(host, port, db_name, user, password, db_type):
    try:
        engine = build_engine({
            "DB_HOST": host,
            "DB_PORT": port,
            "DB_NAME": db_name,
            "DB_USERNAME": user,
            "DB_PASSWORD": password,
            "DB_TYPE" : db_type
        })
        conn = engine.connect()
        conn.close()
        return True
    except OperationalError:
        return False


def update_env(key, value, file_path=".env"):
    if value is None:
        return

    try:
        with open(file_path, "r") as f:
            lines = f.readlines()
    except FileNotFoundError:
        lines = []

    found = False
    new_lines = []

    for line in lines:
        if line.startswith(f"{key}="):
            new_lines.append(f"{key}={value}\n")
            found = True
        else:
            new_lines.append(line)

    if not found:
        new_lines.append(f"{key}={value}\n")

    with open(file_path, "w") as f:
        f.writelines(new_lines)


def restart_server():

    if "gunicorn" in os.environ.get("SERVER_SOFTWARE", "").lower():
        os.kill(os.getppid(), signal.SIGHUP)
        return

    if hasattr(signal, "SIGHUP") and ("GUNICORN_CMD_ARGS" in os.environ or os.getppid() > 1):
        master_pid = os.getppid()
        os.kill(master_pid, signal.SIGHUP)
    else:
        for entry_file in ['main.py', 'run.py', 'app.py', 'app/main.py', 'app/run.py', 'app/app.py']:
            file_path = os.path.join(os.getcwd(), entry_file)
            if os.path.exists(file_path):
                os.utime(file_path, None)
                break

