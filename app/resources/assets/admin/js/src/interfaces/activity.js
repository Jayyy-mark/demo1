export class Activity{
    id=0;
    activity_name="";
    category="";
    description="";
    file=[];
    date=null;

    set(key, value){
        this[key] = value;
    }
}