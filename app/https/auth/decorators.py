from functools import wraps
from flask import g, redirect, url_for

def login_required(f):
    @wraps(f)
    def wrapper(*args, **kwargs):
        if not getattr(g, "user", None):
            return redirect(url_for("admin.login"))
        return f(*args, **kwargs)
    return wrapper