from app.core.database import db
import os
from werkzeug.utils import secure_filename
from flask import jsonify
from ipaddress import ip_address, ip_network
from flask import request
import re

VPN_NETWORK = ip_network("10.254.0.0/24")


def is_vpn_user(ip):
    try:
        return ip_address(ip) in VPN_NETWORK
    except:
        return False


def _split_mission_en(text: str) -> list[str]:
    """
    Split English mission text into individual bullet points.
    Splits on 'To ' boundary (keeps 'To' on each item).
    Falls back to '.' split if no 'To' keyword is found.
    Filters out empty / whitespace-only fragments.
    """
    text = text.strip()
    # Try splitting on every occurrence of " To " (space before To)
    parts = re.split(r"(?<!\A)\bTo\b", text)
    if len(parts) > 1:
        cleaned = []
        for i, p in enumerate(parts):
            p = p.strip().rstrip(".")
            if i > 0:
                p = "To " + p  # restore the 'To' prefix we split on
            if p:
                cleaned.append(p)
        return cleaned if cleaned else [text]

    # Fall back: split on period
    parts = [p.strip() for p in text.split(".") if p.strip()]
    return parts if parts else [text]


def _split_mission_mm(text: str) -> list[str]:
    """
    Split Myanmar mission text into bullet points on '၊၊' (double myanmar comma).
    Falls back to '။' (myanmar full stop) if no double comma found.
    """
    text = text.strip()
    if "၊၊" in text:
        parts = [p.strip() for p in text.split("၊၊") if p.strip()]
        return parts if parts else [text]

    # Fall back: split on Myanmar full stop '။'
    parts = [p.strip() for p in text.split("။") if p.strip()]
    # Re-append the full stop for readability
    parts = [p + "။" if not p.endswith("။") else p for p in parts]
    return parts if parts else [text]


class Utils:
    # --------------- models helpers functions -------------------
    @staticmethod
    def create(model, **kwargs):
        instance = model(**kwargs)  # **kwargs for unpacking
        db.session.add(instance)
        db.session.commit()
        return instance

    @staticmethod
    def create_or_update(model, lookup_fields: dict, update_fields: dict):
        instance = model.query.filter_by(**lookup_fields).first()

        if instance:
            # UPDATE
            for key, value in update_fields.items():
                setattr(instance, key, value)
        else:
            # CREATE
            instance = model(**{**lookup_fields, **update_fields})
            db.session.add(instance)

        db.session.commit()
        return instance

    def bulk_create(model, list_of_dicts):
        try:
            instances = [model(**data) for data in list_of_dicts]
            db.session.add_all(instances)
            db.session.commit()
        except Exception as e:
            print(e)
            raise (e)
        return instances

    def get_all(model):
        return model.query.all()

    def get_by_id(model, id):
        return model.query.get(id)

    def get_by_Column(model, **kwargs):
        return model.query.filter_by(**kwargs).all()

    def update(model, id, **kwargs):
        print("function entered!")
        instance = model.query.get(id)
        print("this is instance : ", instance)
        if not instance:
            return None
        for key, value in kwargs.items():
            print("this is key : ", key)
            print("this is value : ", value)
            setattr(instance, key, value)
        db.session.commit()
        return instance

    def delete(model, id):
        instance = model.query.get(id)
        if not instance:
            return False
        db.session.delete(instance)
        db.session.commit()
        return True

    def generate_id(model, field, prefix, flag=False) -> str:
        last_row = model.query.order_by(model.id.desc()).first()
        if last_row:
            last_number = getattr(last_row, field, None)
            print(f"Last number is : {last_number}")
            if flag:
                return last_number
            else:
                new_number = int(last_number.split("-")[1].strip()) + 1
        else:
            new_number = 1
        return f"{prefix}-{new_number:03d}"

    def save_photo(photo, name, UPLOAD_FOLDER):
        if photo:
            photo_name = secure_filename(photo.filename)
            extension = os.path.splitext(photo_name)[1]

            new_filename = f"{name}{extension}"
            filepath = os.path.join(UPLOAD_FOLDER, new_filename)
            photo.save(filepath)
            return new_filename
        else:
            return None

    def to_dict(
        list_of_objects, relationships=[], exclude=["metadata", "query", "registry"]
    ):
        result = []
        for obj in list_of_objects:
            obj_dict = {
                attr: getattr(obj, attr)
                for attr in dir(obj)
                if not attr.startswith("_")
                and not callable(getattr(obj, attr))
                and attr not in exclude
            }

            # Handle nested relationships
            for rel in relationships:
                if rel in obj_dict and obj_dict[rel] is not None:
                    if isinstance(obj_dict[rel], list):
                        obj_dict[rel] = Utils.to_dict(obj_dict[rel])  # recursive call
                    else:
                        obj_dict[rel] = Utils.to_dict([obj_dict[rel]])[0]

            result.append(obj_dict)
        return result

    def exclude_null_value(data):
        data = {k: v for k, v in data.items() if v not in (None, "")}
        return data


from flask import jsonify


class ResponseHelper:

    @staticmethod
    def success(message, data=None, status=200):
        return jsonify({"success": True, "message": message, "data": data}), status

    @staticmethod
    def error(message, status=400):
        return jsonify({"success": False, "message": message}), status
