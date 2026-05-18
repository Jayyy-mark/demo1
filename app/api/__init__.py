import importlib
import pkgutil
from app import api

def register_api(app):
    for _, package_name, is_pkg in pkgutil.iter_modules(api.__path__):
        if is_pkg:
            # Import the package
            module = importlib.import_module(f"app.api.{package_name}")
            # Get the blueprint variable, assuming naming convention: {package}_bp
            bp_name = f"{package_name}_api"
            bp = getattr(module, bp_name, None)
            if bp:
                app.register_blueprint(bp)
        else:
            module = importlib.import_module(f"app.api.{package_name}")

            bp_name = f"{package_name}_api"
            bp = getattr(module, bp_name, None)
            if bp:
                app.register_blueprint(bp)