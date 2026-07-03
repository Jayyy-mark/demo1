/*<!--====================================
    USER API
=====================================-->*/

import api from "../utils/api.js";

export const userAPI = {
    async all(){
        const res = await api.get("/admin/user/all");
        return res.data;
    },
    async create(data){
        const res = await api.post("/admin/user/create", {
            user_name:data.user_name,
            user_email:data.user_email,
            user_password:data.user_password,
            ...(data.user_avatar ? { user_avatar: data.user_avatar } : {})
        });
        return res.data;
    },
    async update(data){
        console.log("this is data : ",data);
        const res = await api.put("/admin/user/update", {
            id:data.id,
            user_id:data.user_id,
            user_name:data.user_name,
            user_email:data.user_email,
            ...(data.user_password ? { user_password: data.user_password } : {}),
            user_avatar:data.user_avatar
        });
        return res.data;
    },
    async delete(id){
        const res = await api.delete("/admin/user/delete", {
            data:{id}
        });
        return res.data;
    }
}