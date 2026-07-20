//static/js/app/ui/building.api.js
//<!--====================================
//  AUTH API
//=====================================-->


//<!--====================================
//  IMPORTS 
//=====================================-->
import api from "../utils/api.js";


export const authAPI = {

    async login(form) {

        const res = await api.post("/auth/login", {
            user_email: form.user_email,
            user_password: form.user_password
        });
        return res.data;
    },
    async logout() {
        const res = await api.post("/auth/logout", {}, { withCredentials: true });
        return res.data;
    }

};