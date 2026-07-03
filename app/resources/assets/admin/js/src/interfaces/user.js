export class User {
    id=0;
    user_id="";
    user_name="";
    user_email="";
    user_password="";
    user_avatar="";

    set(key, value){
        this[key] = value;
    }
}