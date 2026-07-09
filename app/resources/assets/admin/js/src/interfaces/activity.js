export class Activity {
    id = 0;
    activity_name = "";
    activity_type = "";
    category = "";
    description = "";
    file = [];
    date = null;

    set(key, value) {
        this[key] = value;
    }
}