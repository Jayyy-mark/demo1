import { dashboardApi } from "../api/dashboardApi.js";
import { calendarApi } from "../api/calendar.api.js";
import { toast } from "../utils/toast.js";
import { dashboardUI } from "../ui/dashboard.ui.js";
import { Utils } from "../utils/utils.js";
import { Modal } from "../utils/modal.js";

import { FormValidation } from "../validations/form_validations.js";
export const dashboardEvent = {
    init() {
        this.addValidation = new FormValidation("dataForm");
        this.updateValidation = new FormValidation("dataForm-update");

        this.loadData();

        $("#add-rector-message-btn").on("click", async function () {
            const data = {
                "attr_key": "Rector's Message",
                "value": $("#rector-message-form").find("textarea").val()
            }
            console.log("this is value : ", data);

            try {
                const response = await dashboardApi.create(data);
                toast.success(response.message);
                Utils.refresh();
            } catch (error) {
                console.log("Error");
                toast.error(error.message);
            }

        });


        $("#add-academic-admission-lists-btn").on("click", async function () {
            
            const data = {
                "file": $("#academic-admission-lists-form").find("input[name='academic_admission_lists']")[0].files[0]
            }

            console.log("this is value : ", data);

            try {
                const response = await dashboardApi.addAdmissionList(data);
                console.log("this is response : ", response)
                await toast.success(response.message);
                Utils.refresh();
            } catch (error) {
                console.log("Error : ",error);
                await toast.error(error.message);
            }

        });

        $("#save-counts-btn").on("click", async function () {
            const form = $("#edit-counts-form");
            const data = {
                total_staff: parseInt(form.find("input[name='total_staff']").val()) || 0,
                total_student: parseInt(form.find("input[name='total_student']").val()) || 0,
                graduated_student: parseInt(form.find("input[name='graduated_student']").val()) || 0,
                current_student: parseInt(form.find("input[name='current_student']").val()) || 0
            };

            try {
                const response = await dashboardApi.updateCounts(data);
                await toast.success(response.message || "Statistics updated successfully");
                Modal.hide("#editCountsModal");
                Utils.refresh();
            } catch (error) {
                console.error("Error updating counts:", error);
                toast.error(error.response?.data?.message || "Failed to update statistics.");
            }
        });

    },
    async loadData() {
        try {
            const res = await dashboardApi.summary();
            dashboardUI.render(res.data);
            
            // Load Calendar Events
            try {
                const calRes = await calendarApi.all();
                const events = Array.isArray(calRes) ? calRes : (calRes.data || []);
                dashboardUI.renderCalendar(events);
            } catch (calError) {
                console.error("Error loading calendar data:", calError);
                dashboardUI.renderCalendar([]);
            }
        } catch (error) {
            console.error("Error loading dashboard data:", error);
            toast.error("Failed to load dashboard data.");
        }
    }
}
