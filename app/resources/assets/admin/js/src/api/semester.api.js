/*<!--====================================
 SEMESTER API
=====================================-->*/

import api from "../utils/api.js";

export const semesterAPI = {
    async all(){
        const res = await api.get("/academic/semester/all");
        return res.data;
    },
    async create(data){
        const res = await api.post("/academic/semester/create", {
            semester_name:data.semester_name,
            semester_term:data.semester_term,
            year_id:data.year_id,
        });
        return res.data;
    },
    async update(data){
        const res = await api.put("/academic/semester/update", {
            id:data.id,
            semester_name:data.semester_name,
            semester_term:data.semester_term,
            year_id:data.year_id
        });
        return res.data;
    },
    async delete(id){
        const res = await api.delete("/academic/semester/delete", {
            data:{id}
        });
        return res.data;
    }
}