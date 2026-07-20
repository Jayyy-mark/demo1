//static/js/app/ui/building.event.js
//<!--====================================
//  BUILDING EVENT HANDLER
//=====================================-->
import { authAPI } from "../api/auth.api.js";
import { authUi } from "../ui/auth.ui.js";
import { navigate } from "../utils/navigate.js";
import { toast } from "../utils/toast.js";



export const authEvent = {
    init() {
        $("#signIn_btn").on('click', async function () {

            const formData = authUi.getLoginFormData();

            try {

                const response = await authAPI.login(formData);
                await toast.success(response.message, "Success");
                navigate.to("/admin/dashboard");

            } catch (error) {

                console.log(error);
                toast.error(error?.message, "Error");

            }
        });

        $("#logout-btn").on('click', async function (event) {
            event.preventDefault();
            try {
                const response = await authAPI.logout();
                await toast.success(response.message, "Success");
                navigate.to("/admin/auth/login");
            } catch (error) {
                console.log(error);
                toast.error(error?.message, "Error");
            }
        });
    },
};