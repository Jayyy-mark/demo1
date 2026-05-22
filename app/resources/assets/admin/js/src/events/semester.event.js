/*<!--==========================
    SEMESTER EVENTS
=============================-->*/
import { semesterAPI } from "../api/semester.api.js";
import { semesterUI } from "../ui/semester.ui.js";
import {toast} from "../utils/toast.js";
import { Semester } from "../interfaces/academic.js";
import { navigate } from "../utils/navigate.js";
import { academicHelper } from "../helpers/academic.helper.js";

export const semesterEvent = {
    delete_id: "",

    init(){

        this.load();

        $("#semesters-tab").on("click", async function(){
            await academicHelper.setTab("semesters");
        });


        $("#save_semester_btn").on("click", ()=> this.create());

        $("#update_semester_btn").on("click", ()=> this.update());

        $("#btn_delete_semester").on("click", ()=> this.delete());

        $(document).on("click", ".show-update-modal-semester", (event) => this.showUpdateModal(event));
        
        $(document).on("click", ".show-delete-modal-semester", (event) => this.showDeleteModal(event));

    },
    async load(){
        try {
            const response = await semesterAPI.all();
            semesterUI.render(response.data);

            const years = await academicHelper.getYears();

            semesterUI.setYears(years.data, "year_name", $("#dataForm-semester-update").find("#year")[0]);
            semesterUI.setYears(years.data, "year_name", $("#dataForm-semester").find("#year")[0]);

        }catch(error){
            console.log("error : ", error);
             toast.error("Failed to load semesters.");
        }
    },
    async create(){
        const form = $("#dataForm-semester");
        const semester = new Semester();

        form.find("[name]").each(function(){
            const key = $(this).attr("name");
            const value = $(this).val();

            semester.set(key, value);
        });

        try{
            const response = await semesterAPI.create(semester);
            await toast.success(response.message);
            navigate.refresh();

        }catch(error){
            console.log("error : ", error);
            await toast.error(error?.message || "Failed to create semester.");
        }
    },
    async update(){
        const form = $("#dataForm-semester-update");
        const semester = new Semester();
        form.find("[name]").each(function(){
            const key = $(this).attr("name");
            const value = $(this).val();
            semester.set(key, value);
        });

        try{
            const response = await semesterAPI.update(semester);
            await toast.success(response.message);
            navigate.refresh();
        }catch(error){
            console.log("error : ", error);
            await toast.error(error?.message || "Failed to update semester.");
        }
    },
    async delete(){
        try{
            const response = await semesterAPI.delete(this.delete_id);
            await toast.success(response.message);
            navigate.refresh();
        }catch(error){
            console.log("error : ", error);
            await toast.error(error?.message || "Failed to delete semester.");
        }
    },
    showUpdateModal(event){
        const data = $(event.currentTarget).data("semesters");
        const semester = new Semester();

        semester.set("id", data.id);
        semester.set("semester_name", data.semester_name);
        semester.set("year_name", data.year?.year_name);
        semester.set("semester_term", data.semester_term);
        semesterUI.fillUpdateForm(semester);
        const modal = new bootstrap.Modal($("#semesterModal-update"));
        modal.show();
    },
    showDeleteModal(event){
        this.delete_id = $(event.currentTarget).data("id");
        const modal = new bootstrap.Modal($("#delete-modal-semester"));
        modal.show();
    },

};