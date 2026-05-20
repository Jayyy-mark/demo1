import { errorUtils } from "../error/error.utils.js";

const api = axios.create({
    // baseURL: "https://ucstgo.up.railway.app/api",
    baseURL: "http://127.0.0.1:5000/api",
    withCredentials: true
});

api.interceptors.request.use((config) => {

    const isRefreshRoute = config.url?.includes("/auth/refresh");

    const csrfToken = isRefreshRoute
        ? Cookies.get("csrf_refresh_token")
        : Cookies.get("csrf_access_token");

    if (csrfToken) {
        config.headers["X-CSRF-TOKEN"] = csrfToken;
    }

    return config;
});

/*<!--==================================================================
    INTERCEPTORS FOR HANDELING ERRORS, AUTHENTICATIONS, AUTHORIZATIONS, 
========================================================================*/
api.interceptors.response.use(
    (response)=>response,

    async (error) =>{

        const originalRequest = error.config;

        const isAuthRoute = originalRequest?.url?.includes("/auth/login");
        const isRefreshRoute = originalRequest?.url?.includes("/auth/refresh");

        const status = error.response?.status;

        if(status == 401 && originalRequest && !originalRequest._retry && !isAuthRoute && !isRefreshRoute){

            originalRequest._retry = true;
            try{
                
                await api.post("/auth/refresh");

                return api(originalRequest);

            }catch(e){
                window.location.href = "/admin/auth/login"
                return Promise.reject(e)
            }

        }

        if(status === 500){
            errorUtils._500(error.response?.data);
        }

        return Promise.reject(error)

    }
);


export default api;