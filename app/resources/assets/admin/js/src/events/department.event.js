/*<!--==========================
    DEPARTMENT EVENTS
=============================-->*/
import { departmentAPI } from "../api/department.api.js";
import { departmentUI } from "../ui/department.ui.js";
import {toast} from "../utils/toast.js";
import { Department } from "../interfaces/department.js";
import { navigate } from "../utils/navigate.js";
import { academicHelper } from "../helpers/academic.helper.js";

import { FormValidation } from "../validations/form_validations.js";
export const departmentEvent = {
    delete_id: "",

    init(){
        this.addValidation = new FormValidation("dataForm-department");
        this.updateValidation = new FormValidation("dataForm-department-update");


        this.load();

        $("#departments-tab").on("click", async function(){
            await academicHelper.setTab("departments")
        });

        $("#save_department_btn").on("click", ()=> this.create());

        $("#update_department_btn").on("click", ()=> this.update());

        $("#btn_delete_department").on("click", ()=> this.delete());

        $(document).on("click", ".show-update-modal-department", (event) => this.showUpdateModal(event));
        
        $(document).on("click", ".show-delete-modal-department", (event) => this.showDeleteModal(event));

    },
    async load(){
        try {
            const response = await departmentAPI.all();
            departmentUI.render(response.data);
        }catch(error){
            console.log("error : ", error);
             toast.error("Failed to load departments.");
        }
    },
    async create(){
        if (this.addValidation) {
            const result = this.addValidation.validateAll();
            if (!result.valid) {
                const firstError = Object.values(result.errors)[0];
                toast.error(firstError);
                return;
            }
        }

        const form = $("#dataForm-department");
        const department = new Department();

        form.find("[name]").each(function(){
            const key = $(this).attr("name");
            const value = $(this).val();

            department.set(key, value);
        });

        try{
            const response = await departmentAPI.create(department);
            await toast.success(response.message);
            navigate.refresh();

        }catch(error){
            console.log("error : ", error);
            await toast.error(error?.message || "Failed to create department.");
        }
    },
    async update(){
        if (this.updateValidation) {
            const result = this.updateValidation.validateAll();
            if (!result.valid) {
                const firstError = Object.values(result.errors)[0];
                toast.error(firstError);
                return;
            }
        }

        const form = $("#dataForm-department-update");
        const department = new Department();
        form.find("[name]").each(function(){
            const key = $(this).attr("name");
            const value = $(this).val();
            department.set(key, value);
        });

        try{
            const response = await departmentAPI.update(department);
            await toast.success(response.message);
            navigate.refresh();
        }catch(error){
            console.log("error : ", error);
            await toast.error(error?.message || "Failed to update department.");
        }
    },
    async delete(){
        try{
            const response = await departmentAPI.delete(this.delete_id);
            await toast.success(response.message);
            navigate.refresh();
        }catch(error){
            console.log("error : ", error);
            await toast.error(error?.message || "Failed to delete department.");
        }
    },
    showUpdateModal(event){
        const data = $(event.currentTarget).data("departments");
        departmentUI.fillUpdateForm(data);
        const modal = new bootstrap.Modal($("#departmentModal-update"));
        modal.show();
    },
    showDeleteModal(event){
        this.delete_id = $(event.currentTarget).data("id");
        const modal = new bootstrap.Modal($("#delete-modal-department"));
        modal.show();
    },

};