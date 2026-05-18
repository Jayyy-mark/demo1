import pkgutil
import importlib
from app import models

# import submodules dynamically
for _, module_name, _ in pkgutil.iter_modules(__path__):
    module = importlib.import_module(f"app.models.{module_name}")
    # add all classes from module to this namespace
    for cls_name, cls_obj in module.__dict__.items():
        if isinstance(cls_obj, type):
            globals()[cls_name] = cls_obj

__all__ = [name for name, obj in globals().items() if isinstance(obj, type)]

def register_models():
    """
    Dynamically imports all modules in app/models so that
    SQLAlchemy sees all db.Model subclasses for migrations.
    """
    for _, module_name, _ in pkgutil.iter_modules(models.__path__):
        importlib.import_module(f"app.models.{module_name}")
