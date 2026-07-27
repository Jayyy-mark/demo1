/*<!--============================
    RESEARCH API HANDLER
==============================-->*/
import api from "../utils/api.js"

export const researchApi = {
    async create(data){
        const form = new FormData();
        for (let i = 0; i < data.file.length; i++) {
            form.append("file", data.file[i]);
        }
        form.append("research_name", data.research_name);
        form.append("category", data.category);
        form.append("description", data.description);
        form.append("date", data.date);

        const res = await api.post("research/create",
            form
        );
        return res.data;
    },
    async update(data){
        const form = new FormData();
        form.append("id", data.id);
        form.append("file", data.file);
        form.append("research_name", data.research_name);
        form.append("category", data.category);
        form.append("description", data.description);
        form.append("date", data.date);
                
        const res = await api.put("research/update", form);

        return res.data;
    },
    async delete(id){
        const res = await api.delete(`research/delete`,{
            data : {id}
        })
        return res.data;
    },
    async all(){
        const res = await api.get("research/all");
        return res.data;
    },

    async categories() {
        const res = await api.get("/research/categories");
        return res.data;
    },
}