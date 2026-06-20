export class Collaboration {
    id=0;
    logo="";
    organization_name="";
    collaboration_type="";
    description="";
    url="";

    set(key, value) {
        this[key] = value;
    }
}
