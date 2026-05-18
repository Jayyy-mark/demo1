import api from "../utils/api.js"

export const mediaApi = {
    async create(data){
        console.log("this is data : ", data);
        const form = new FormData();
        form.append("files", data.files);
        form.append("media_type", data.media_type);
        form.append("activity_id", data.activity_id);
        form.append("research_id", data.research_id);
        form.append("laboratory_id", data.laboratory_id);
        console.log(form);
        const res = await api.post("/media/create",
            form
        );
        return res.data;
    },
    async update(data){
        const form = new FormData();
        form.append("id", data.media_id);
        form.append("files", data.files);
        form.append("media_type", data.media_type)
        form.append("activity_id", data.activity_id);
        form.append("research_id", data.research_id);
        form.append("laboratory_id", data.laboratory_id);
        const res = await api.put("/media/update", form);

        return res.data;
    },
    async delete(id){
        const res = await api.delete(`/media/delete`,{
            data : {id}
        })
        return res.data;
    },
    async all(){
        const res = await api.get("/media/all");
        return res.data;
    },
}