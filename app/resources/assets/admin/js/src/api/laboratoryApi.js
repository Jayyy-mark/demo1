/*<!--============================
    LABORATORY API HANDLER
==============================-->*/
import api from "../utils/api.js"

export const laboratoryApi = {
    async create(data){
        const form = new FormData();
        for (let i = 0; i < data.file.length; i++) {
            form.append("file", data.file[i]);
        }
        form.append("laboratory_name", data.laboratory_name);
        form.append("category", data.category);
        form.append("description", data.description);
        form.append("date", data.date);

        const res = await api.post("laboratory/create",
            form
        );
        return res.data;
    },
    async update(data){
        const form = new FormData();
        form.append("id", data.id);
        form.append("file", data.file);
        form.append("laboratory_name", data.laboratory_name);
        form.append("category", data.category);
        form.append("description", data.description);
        form.append("date", data.date);
                
        const res = await api.put("laboratory/update", form);

        return res.data;
    },
    async delete(id){
        const res = await api.delete(`laboratory/delete`,{
            data : {id}
        })
        return res.data;
    },
    async all(){
        const res = await api.get("laboratory/all");
        return res.data;
    },
}