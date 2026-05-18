export class Activity{
    id=0;
    activity_name="";
    category="";
    description="";
    file=[];
    data=null;

    set(key, value){
        this[key] = value;
    }
}