export class Laboratory{
    id=0;
    laboratory_name="";
    category="";
    description="";
    file=[];
    date=null;

    set(key, value){
        this[key] = value;
    }
}