
from app.models.SemesterModel import Semester
from app.models.SubjectModel import Subject
from app.schemas.department import DepartmentSchema
from app.models.CourseModel import Course
from app.models.DepartmentModel import Department
from app.schemas.academic import SubjectSchema
class CourseHelper:

    def getSubjects():
        subjects =  Subject.query.group_by(Subject.subject_name)
        return SubjectSchema().dump(subjects, many=True)
    
    def getDepartments():
        departments = Department.query.all()
        return DepartmentSchema(many=True).dump(departments)

    def getSemesterIdByName(name):
        semester = Semester.query.filter_by(semester_term=name).first()
        return semester.id
    
    def getSubjectIdByName(name):
        subject = Subject.query.filter_by(subject_name=name).first()
        return subject.id
    
    
    def normalize(name: str):
        return ' '.join(name.split()).replace("( ", "(").replace(" )", ")")

    
    def checkSemester(name):
        res = Course.query.join(Semester).filter(Semester.semester_term==name).first()
        print(res)
        if res is None:
            print("Result is None")
            return None
        else:
            print("Result is existed!")
            return res.course_id
        