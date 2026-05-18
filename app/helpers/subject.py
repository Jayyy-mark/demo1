from app.models.SubjectModel import Subject

class SubjectHelper:

    def isNameExist(name)->bool:
        subject = Subject.query.filter_by(subject_name=name).first()
        return subject is not None