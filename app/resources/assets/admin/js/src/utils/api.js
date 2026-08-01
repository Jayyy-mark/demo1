import { errorUtils } from "../error/error.utils.js";
import { startLoading, stopLoading, isPageLoaded } from "./loading.js";
import { closeAllModals } from "./modal.js";



const api = axios.create({
    //baseURL: "https://ucstgo.up.railway.app/api",
    baseURL: "/api",
    withCredentials: true
});



api.interceptors.request.use((config) => {

    closeAllModals();

    if (isPageLoaded) {
        startLoading();
    }


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
    (response) => {
        stopLoading();
        return response;
    },

    async (error) => {

        const originalRequest = error.config;

        const isAuthRoute = originalRequest?.url?.includes("/auth/login");
        const isRefreshRoute = originalRequest?.url?.includes("/auth/refresh");

        const status = error.response?.status;

        if (status == 401 && originalRequest && !originalRequest._retry && !isAuthRoute && !isRefreshRoute) {

            originalRequest._retry = true;
            try {

                await api.post("/auth/refresh");
                stopLoading();
                return api(originalRequest);

            } catch (e) {
                stopLoading();
                window.location.href = "/admin/auth/login";
                return Promise.reject(e)
            }

        }

        stopLoading();

        if (status === 500) {
            errorUtils._500(error.response?.data);
        }

        return Promise.reject(error)

    }
);


export default api;