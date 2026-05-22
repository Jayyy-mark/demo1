/*<!--==========================
    SUBJECT EVENTS
=============================-->*/
import { subjectAPI } from "../api/subject.api.js";
import { subjectUI } from "../ui/subject.ui.js";
import {toast} from "../utils/toast.js";
import { Subject } from "../interfaces/academic.js";
import { navigate } from "../utils/navigate.js";
import { academicHelper } from "../helpers/academic.helper.js";

export const subjectEvent = {
    delete_id: "",

    init(){

        this.load();

        $("#subjects-tab").on("click", async function(){
            await academicHelper.setTab("subjects");
        });
        

        $("#save_subject_btn").on("click", ()=> this.create());

        $("#update_subject_btn").on("click", ()=> this.update());

        $("#btn_delete_subject").on("click", ()=> this.delete());

        $(document).on("click", ".show-update-modal-subject", (event) => this.showUpdateModal(event));
        
        $(document).on("click", ".show-delete-modal-subject", (event) => this.showDeleteModal(event));

    },
    async load(){
        try {
            const response = await subjectAPI.all();
            subjectUI.render(response.data);

            const departments = await academicHelper.getDepartments();

            subjectUI.setDepartments(departments.data, "department_name", $("#dataForm-subject-update").find("#department")[0]);
            subjectUI.setDepartments(departments.data, "department_name", $("#dataForm-subject").find("#department")[0]);

        }catch(error){
            console.log("error : ", error);
             toast.error("Failed to load subjects.");
        }
    },
    async create(){
        const form = $("#dataForm-subject");
        const subject = new Subject();

        form.find("[name]").each(function(){
            const key = $(this).attr("name");
            const value = $(this).val();

            subject.set(key, value);
        });

        try{
            const response = await subjectAPI.create(subject);
            await toast.success(response.message);
            navigate.refresh();

        }catch(error){
            console.log("error : ", error);
            await toast.error(error?.message || "Failed to create subject.");
        }
    },
    async update(){
        const form = $("#dataForm-subject-update");
        const subject = new Subject();
        form.find("[name]").each(function(){
            const key = $(this).attr("name");
            const value = $(this).val();
            subject.set(key, value);
        });

        try{
            const response = await subjectAPI.update(subject);
            await toast.success(response.message);
            navigate.refresh();
        }catch(error){
            console.log("error : ", error);
            await toast.error(error?.message || "Failed to update subject.");
        }
    },
    async delete(){
        try{
            const response = await subjectAPI.delete(this.delete_id);
            await toast.success(response.message);
            navigate.refresh();
        }catch(error){
            console.log("error : ", error);
            await toast.error(error?.message || "Failed to delete subject.");
        }
    },
    showUpdateModal(event){
        const data = $(event.currentTarget).data("subjects");
        const subject = new Subject();

        subject.set("id", data.id);
        subject.set("subject_id", data.subject_id);
        subject.set("department_name", data.department?.department_name);
        subject.set("subject_code", data.subject_code);
        subject.set("subject_name", data.subject_name);

        subjectUI.fillUpdateForm(subject);
        
        const modal = new bootstrap.Modal($("#subjectModal-update"));
        modal.show();
    },
    showDeleteModal(event){
        this.delete_id = $(event.currentTarget).data("id");
        const modal = new bootstrap.Modal($("#delete-modal-subject"));
        modal.show();
    },

};