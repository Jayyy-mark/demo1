# <-============================================================================
# Context Processors Set Ups (Assets folder for js, fonts, images , css files)
# =============================================================================->

from flask import Flask, url_for, g
from datetime import datetime
from app.models.UserModel import User


def setup_contexts(app: Flask):
    @app.context_processor
    def inject_assets():

        features = {
            "dataTable": {
                "css": url_for(
                    "static", filename="admin/css/plugins/dataTables.bootstrap.css"
                ),
                "scripts": [
                    url_for(
                        "static", filename="admin/js/plugins/dataTable/dataTables.js"
                    ),
                    url_for(
                        "static",
                        filename="admin/js/plugins/dataTable/dataTables.bootstrap5.js",
                    ),
                    url_for(
                        "static",
                        filename="admin/js/plugins/dataTable/dataTables.buttons.min.js",
                    ),
                    url_for(
                        "static", filename="admin/js/plugins/dataTable/jszip.min.js"
                    ),
                    url_for(
                        "static", filename="admin/js/plugins/dataTable/pdfmake.min.js"
                    ),
                    url_for(
                        "static", filename="admin/js/plugins/dataTable/vfs_fonts.js"
                    ),
                    url_for(
                        "static",
                        filename="admin/js/plugins/dataTable/buttons.html5.min.js",
                    ),
                    url_for(
                        "static",
                        filename="admin/js/plugins/dataTable/buttons.print.min.js",
                    ),
                ],
            }
        }

        vendor = {
            "css": [],
            "scripts": [
                url_for("static", filename="admin/js/lib/jquery-3.7.1.js"),
                url_for("static", filename="admin/js/lib/axios.js"),
                url_for("static", filename="admin/js/lib/js.cookie.min.js"),
            ],
            "fonts": [
                url_for("static", filename="admin/fonts/phosphor/duotone/style.css"),
                url_for("static", filename="admin/fonts/tabler-icons.min.css"),
                url_for("static", filename="admin/fonts/feather.css"),
                url_for("static", filename="admin/fonts/fontawesome.css"),
                url_for("static", filename="admin/fonts/material.css"),
            ],
        }

        theme = {
            "css": url_for("static", filename="admin/css/style-preset.css"),
            "scripts": [
                url_for("static", filename="admin/js/theme.js"),
                url_for("static", filename="admin/js/style-preset.js"),
            ],
        }

        main = {
            "css": url_for("static", filename="admin/css/style.css"),
            "scripts": [
                url_for("static", filename="admin/js/plugins/popper.min.js"),
                url_for("static", filename="admin/js/plugins/simplebar.min.js"),
                url_for("static", filename="admin/js/plugins/bootstrap.min.js"),
                url_for("static", filename="admin/js/script.js"),
                url_for("static", filename="admin/js/plugins/feather.min.js"),
            ],
            "fonts": url_for("static", filename="admin/fonts/google.font.css"),
        }

        auth = {
            "css": None,
            "scripts": url_for("static", filename="admin/js/src/core/auth.js"),
        }

        favicon = url_for("static", filename="admin/images/favicon/favicon.ico")

        logo = url_for("static", filename="admin/images/logo.png")

        assets = {
            "favicon": favicon,
            "main": main,
            "auth": auth,
            "vendor": vendor,
            "theme": theme,
            "logo": logo,
            "features": features,
        }

        g.assets = assets.copy()
        g.feature_assets = {"css": [], "scripts": []}

        title = "University of Computer Studies Taungoo"
        current_year = datetime.now().year

        def get_user_avatar(user_id):
            if user_id:
                user = User.query.get(int(user_id))
                return url_for(
                    "static", filename="admin/images/avatar/" + user.user_avatar
                )

        def get_user_name(user_id):
            if user_id:
                name = (
                    User.query.with_entities(User.user_name)
                    .filter_by(id=int(user_id))
                    .scalar()
                )
                return name
            return None

        return dict(
            assets=g.assets,
            current_year=current_year,
            title=title,
            get_user_avatar=get_user_avatar,
            get_user_name=get_user_name,
        )
