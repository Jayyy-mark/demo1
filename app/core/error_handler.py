from flask import render_template

def register_error_handlers(app):

    error_pages = [400, 401, 403, 404, 405, 500, 503]

    for code in error_pages:
        app.register_error_handler(code, lambda e, c=code: (
            render_template(f"error/{c}.html", error=e), c
        ))
