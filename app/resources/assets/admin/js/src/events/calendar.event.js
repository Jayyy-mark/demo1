import { calendarApi } from "../api/calendar.api.js";
import { calendarUI } from "../ui/calendar.ui.js";
import { toast } from "../utils/toast.js";
import { Modal } from "../utils/modal.js";

import { FormValidation } from "../validations/form_validations.js";
function monthOffset(date, offset) {
    return new Date(date.getFullYear(), date.getMonth() + offset, 1);
}

export const calendarEvent = {
    currentDate: new Date(),
    events: [],
    selectedId: null,

    init() {
        this.addValidation = new FormValidation("dataForm");
        this.updateValidation = new FormValidation("dataForm-update");

        this.currentDate = new Date(this.currentDate.getFullYear(), this.currentDate.getMonth(), 1);
        this.loadData();

        $("#calendar-prev").on("click", () => {
            this.currentDate = monthOffset(this.currentDate, -1);
            this.render();
        });

        $("#calendar-next").on("click", () => {
            this.currentDate = monthOffset(this.currentDate, 1);
            this.render();
        });

        $("#calendar-add-btn").on("click", () => {
            this.selectedId = null;
            calendarUI.openCreateForm();
            Modal.show("#calendarModal");
        });

        $("#calendar-save-btn").on("click", () => {
            this.save();
        });

        $("#calendar-delete-btn").on("click", () => {
            this.delete();
        });

        $(document).on("click", ".calendar-event", (e) => {
            const event = $(e.currentTarget).data("event");
            this.selectedId = event.id;
            calendarUI.openUpdateForm(event);
            Modal.show("#calendarModal");
        });
    },

    async loadData() {
        try {
            const res = await calendarApi.all();
            this.events = res.data || [];
            this.render();
        } catch (error) {
            await toast.error(error?.response?.data?.message || error?.message || "Error occured!");
        }
    },

    render() {
        calendarUI.renderMonth(this.currentDate, this.events);
    },

    async save() {
        const data = calendarUI.getFormData();
        const validationError = calendarUI.validate(data);

        if (validationError) {
            await toast.error(validationError);
            return;
        }

        try {
            const res = data.id
                ? await calendarApi.update(data)
                : await calendarApi.create(data);

            await toast.success(res.message);
            Modal.hide("#calendarModal");
            await this.loadData();
        } catch (error) {
            await toast.error(error?.response?.data?.message || error?.message || "Error occured!");
        }
    },

    async delete() {
        if (!this.selectedId) {
            return;
        }

        try {
            const res = await calendarApi.delete(this.selectedId);
            await toast.success(res.message);
            Modal.hide("#calendarModal");
            this.selectedId = null;
            await this.loadData();
        } catch (error) {
            await toast.error(error?.response?.data?.message || error?.message || "Error occured!");
        }
    }
};
