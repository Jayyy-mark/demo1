/*<!--====================================
 SUBJECT API
=====================================-->*/

import api from "../utils/api.js";

export const subjectAPI = {
    async all(){
        const res = await api.get("/academic/subject/all");
        return res.data;
    },
    async create(data){
        const res = await api.post("/academic/subject/create", {
            subject_code:data.subject_code,
            subject_name:data.subject_name,
            description:data.description,
            department_id:data.department_id || null,
        });
        return res.data;
    },
    async update(data){
        const res = await api.put("/academic/subject/update", {
            id:data.id,
            subject_code:data.subject_code,
            subject_name:data.subject_name,
            description:data.description,
            department_id:data.department_id
        });
        return res.data;
    },
    async delete(id){
        const res = await api.delete("/academic/subject/delete", {
            data:{id}
        });
        return res.data;
    }
}