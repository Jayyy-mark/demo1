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
                "value": $("#rector-message-mm").val(),
                "value_en": $("#rector-message-en").val()
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

        $("#save-topbar-info-btn").on("click", async function () {
            const form = $("#topbar-info-form");
            const data = {
                school_open_date: form.find("input[name='school_open_date']").val().trim(),
                phone_number: form.find("input[name='phone_number']").val().trim(),
                email: form.find("input[name='email']").val().trim(),
            };

            try {
                const response = await dashboardApi.updateTopbarInfo(data);
                await toast.success(response.message || "Topbar info updated successfully");
                Modal.hide("#topbarInfoModal");
                Utils.refresh();
            } catch (error) {
                console.error("Error updating topbar info:", error);
                toast.error(error.response?.data?.message || "Failed to update topbar info.");
            }
        });

        // Pre-populate modal form from display card values when modal opens
        document.getElementById("topbarInfoModal")?.addEventListener("show.bs.modal", function () {
            $("input[name='school_open_date']").val($("#topbar-card-school-open-date").val());
            $("input[name='phone_number']").val($("#topbar-card-phone").val());
            $("input[name='email']").val($("#topbar-card-email").val());
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
