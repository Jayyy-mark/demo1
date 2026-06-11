/*<!--====================================
 COLLABORATION API
=====================================-->*/

import api from "../utils/api.js";

export const collaborationAPI = {
    async all(){
        const res = await api.get("/collaboration/all");
        return res.data;
    },
    async create(formData){
        const res = await api.post("/collaboration/create", formData, {
            headers: {
                "Content-Type": "multipart/form-data",
            },
        });
        return res.data;
    },
    async update(formData){
        const res = await api.put("/collaboration/update", formData, {
            headers: {
                "Content-Type": "multipart/form-data",
            },
        });
        return res.data;
    },
    async delete(id){
        const res = await api.delete("/collaboration/delete", {
            data:{id}
        });
        return res.data;
    }
}
