/*<!--====================================
 YEAR API
=====================================-->*/

import api from "../utils/api.js";

export const yearAPI = {
    async all(){
        const res = await api.get("/academic/year/all");
        return res.data;
    },
    async create(data){
        const res = await api.post("/academic/year/create", {
            year_name:data.year_name
        });
        return res.data;
    },
    async update(data){
        const res = await api.put("/academic/year/update", {
            id:data.id,
            year_name:data.year_name
        });
        return res.data;
    },
    async delete(id){
        const res = await api.delete("/academic/year/delete", {
            data:{id}
        });
        return res.data;
    }
}