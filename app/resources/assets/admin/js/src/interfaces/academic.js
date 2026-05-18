export class Year{
    id=0;
    year_name="";
    set(key, value){
        this[key] = value;
    }
}

export class Semester{
    id=0;
    semester_name="";
    semester_term="";
    year_id="";
    set(key, value){
        this[key] = value;
    }
}

export class Subject{
    id=0;
    subject_code="";
    subject_name="";
    description="";
    department_id="";
    set(key, value){
        this[key] = value;
    }
}