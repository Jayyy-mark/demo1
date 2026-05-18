/*<!--====================================
 DEPARTMENT API
=====================================-->*/

import api from "../utils/api.js";

export const departmentAPI = {
    async all(){
        const res = await api.get("/department/all");
        return res.data;
    },
    async create(data){
        const res = await api.post("/department/create", {
            department_name:data.department_name
        });
        return res.data;
    },
    async update(data){
        const res = await api.put("/department/update", {
            id:data.id,
            department_name:data.department_name
        });
        return res.data;
    },
    async delete(id){
        const res = await api.delete("/department/delete", {
            data:{id}
        });
        return res.data;
    }
}