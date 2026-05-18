export class Media{
    id=0;
    media_id=0;
    files=[];
    activity_id="";
    research_id="";
    laboratory_id="";

    set(key, value){
        this[key] = value;
    }
}