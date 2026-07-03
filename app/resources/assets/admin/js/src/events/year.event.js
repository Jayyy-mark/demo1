/*<!--==========================
    year EVENTS
=============================-->*/
import { yearAPI } from "../api/year.api.js";
import { yearUI } from "../ui/year.ui.js";
import { toast } from "../utils/toast.js";
import { Year } from "../interfaces/academic.js";
import { navigate } from "../utils/navigate.js";
import { academicHelper } from "../helpers/academic.helper.js";

import { FormValidation } from "../validations/form_validations.js";
export const yearEvent = {
    delete_id: "",

    init() {
        this.addValidation = new FormValidation("dataForm-year");
        this.updateValidation = new FormValidation("dataForm-year-update");


        this.load();

        $("#years-tab").on("click", async function () {
            await academicHelper.setTab("years");
        });

        $("#save_year_btn").on("click", () => this.create());

        $("#update_year_btn").on("click", () => this.update());

        $("#btn_delete_year").on("click", () => this.delete());

        $(document).on("click", ".show-update-modal-year", (event) => this.showUpdateModal(event));

        $(document).on("click", ".show-delete-modal-year", (event) => this.showDeleteModal(event));

    },
    async load() {
        try {
            const response = await yearAPI.all();
            yearUI.render(response.data);
        } catch (error) {
            console.log("error : ", error);
            toast.error("Failed to load years.");
        }
    },
    async create() {
        if (this.addValidation) {
            const result = this.addValidation.validateAll();
            if (!result.valid) {
                const firstError = Object.values(result.errors)[0];
                toast.error(firstError);
                return;
            }
        }

        const form = $("#dataForm-year");
        const year = new Year();

        form.find("[name]").each(function () {
            const key = $(this).attr("name");
            const value = $(this).val();

            year.set(key, value);
        });

        try {
            const response = await yearAPI.create(year);
            await toast.success(response.message);
            navigate.refresh();

        } catch (error) {
            console.log("error : ", error);
            await toast.error(error?.message || "Failed to create year.");
        }
    },
    async update() {
        if (this.updateValidation) {
            const result = this.updateValidation.validateAll();
            if (!result.valid) {
                const firstError = Object.values(result.errors)[0];
                toast.error(firstError);
                return;
            }
        }

        const form = $("#dataForm-year-update");
        const year = new Year();
        form.find("[name]").each(function () {
            const key = $(this).attr("name");
            const value = $(this).val();
            year.set(key, value);
        });

        try {
            const response = await yearAPI.update(year);
            await toast.success(response.message);
            navigate.refresh();
        } catch (error) {
            console.log("error : ", error);
            await toast.error(error?.message || "Failed to update year.");
        }
    },
    async delete() {
        try {
            const response = await yearAPI.delete(this.delete_id);
            await toast.success(response.message);
            navigate.refresh();
        } catch (error) {
            console.log("error : ", error);
            await toast.error(error?.message || "Failed to delete year.");
        }
    },
    showUpdateModal(event) {
        const data = $(event.currentTarget).data("years");
        yearUI.fillUpdateForm(data);
        const modal = new bootstrap.Modal($("#yearModal-update"));
        modal.show();
    },
    showDeleteModal(event) {
        this.delete_id = $(event.currentTarget).data("id");
        const modal = new bootstrap.Modal($("#delete-modal-year"));
        modal.show();
    },

};