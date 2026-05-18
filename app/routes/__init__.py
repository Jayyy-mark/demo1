#<-=================================
#   REGISTERS BLUTEPRINTS
#=================================->

import importlib
import pkgutil
from app import routes

def register_routes(app):
    for _, package_name, is_pkg in pkgutil.iter_modules(routes.__path__):
        if is_pkg:
            # Import the package
            module = importlib.import_module(f"app.routes.{package_name}")
            # Get the blueprint variable, assuming naming convention: {package}_bp
            bp_name = f"{package_name}_bp"
            bp = getattr(module, bp_name, None)
            if bp:
                app.register_blueprint(bp)
        else:
            module = importlib.import_module(f"app.routes.{package_name}")
            bp_name = f"{package_name}_bp"
            bp = getattr(module, bp_name, None)
            if bp:
                app.register_blueprint(bp)
