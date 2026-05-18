/*<!--============================
    ACTIVITY API HANDLER
==============================-->*/
import api from "../utils/api.js"

export const activityApi = {
    async create(data){
        const form = new FormData();
        for (let i = 0; i < data.file.length; i++) {
            form.append("file", data.file[i]);
        }
        form.append("activity_name", data.activity_name);
        form.append("category", data.category);
        form.append("description", data.description);
        form.append("date", data.date);
        console.log("this is final activity data : ", data);
        const res = await api.post("/activity/create",
            form
        );
        return res.data;
    },
    async update(data){
        const form = new FormData();
        form.append("id", data.id);
        form.append("file", data.file);
        form.append("activity_name", data.activity_name);
        form.append("category", data.category);
        form.append("description", data.description);
        form.append("date", data.date);
        
        const res = await api.put("/activity/update", form);

        return res.data;
    },
    async delete(id){
        const res = await api.delete(`activity/delete`,{
            data : {id}
        })
        return res.data;
    },
    async all(){
        const res = await api.get("/activity/all");
        return res.data;
    },
}