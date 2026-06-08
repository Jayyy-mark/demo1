import api from "../utils/api.js";



export const dashboardApi = {
    async summary(){
        const res = await api.get("/dashboard/all");
        return res.data;
    },
    async create(data){
        const res = await api.post("/dashboard/create",{
            attr_key : data.attr_key,
            value : data.value
        });
        return res.data;    
    },
    async update(data){
        const res = await api.put("/dashboard/update",{
            id : data.id,
            attr_key : "recot_message",
            value : "this is recot's message"
        });
        return res.data;    
    },
    async delete(id){
        const res = await api.delete("/dashboard/delete",{
            data : {id}
        });
        return res.data;    
    },
}