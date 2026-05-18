/*<!--==========================
    DEPARTMENT EVENTS
=============================-->*/
import { departmentAPI } from "../api/department.api.js";
import { departmentUI } from "../ui/department.ui.js";
import {toast} from "../utils/toast.js";
import { Department } from "../interfaces/department.js";
import { navigate } from "../utils/navigate.js";

export const departmentEvent = {
    delete_id: "",

    init(){

        this.load();

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