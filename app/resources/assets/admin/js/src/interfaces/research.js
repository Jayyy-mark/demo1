export class Research{
    id=0;
    research_name="";
    category="";
    description="";
    file=[];
    date=null;

    set(key, value){
        this[key] = value;
    }
}