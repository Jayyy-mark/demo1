from app.core.database import db
import os
from werkzeug.utils import secure_filename
from flask import jsonify

class Utils:
    #--------------- models helpers functions -------------------
    def create(model, **kwargs):
        instance = model(**kwargs)# **kwargs for unpacking
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
            raise(e)
        return instances

    def get_all(model):
        return model.query.order_by(model.id.desc()).all()

    def get_by_id(model, id):
        return model.query.get(id)
    
    def get_by_Column(model, **kwargs):
        return model.query.filter_by(**kwargs).all()

    def update(model, id, **kwargs):
        print("function entered!");
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
    
    def generate_id(model,field,prefix,flag=False)->str:
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
    
    def save_photo(photo,name,UPLOAD_FOLDER):
        if photo:
            photo_name = secure_filename(photo.filename)
            extension = os.path.splitext(photo_name)[1]

            new_filename = f"{name}{extension}"
            filepath = os.path.join(UPLOAD_FOLDER, new_filename)
            photo.save(filepath)
            return new_filename
        else:
            return None
        
    def to_dict(list_of_objects,relationships=[], exclude=['metadata', 'query', 'registry']):
        result = []
        for obj in list_of_objects:
            obj_dict = {attr: getattr(obj, attr) for attr in dir(obj)
                        if not attr.startswith('_') and not callable(getattr(obj, attr))
                        and attr not in exclude}
            
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
        data = {k: v for k, v in data.items() if v not in (None, '')}
        return data


from flask import jsonify

class ResponseHelper:

    @staticmethod
    def success(message, data=None, status=200):
        return jsonify({
            "success": True,
            "message": message,
            "data": data
        }), status

    @staticmethod
    def error(message, status=500):
        return jsonify({
            "success": False,
            "message": message
        }), status