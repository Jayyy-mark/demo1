//js/app/events/course.event.js
//<!--====================================
//      COURSE EVENT HANDLERS
//=====================================-->
import { courseUI } from "../ui/course.ui.js";
import {courseAPI} from "../api/course.api.js";
import { academicHelper } from "../helpers/academic.helper.js";
import { toast } from "../utils/toast.js";
import { Course } from "../interfaces/course.js";
import { navigate } from "../utils/navigate.js";
import { Modal } from "../utils/modal.js";
import { Utils } from "../utils/utils.js";


export const courseEvent = {
    deleteId:"",

    init(){

        this.loadData();

        $('#btn_add').on('click', ()=>{
            this.create();
        });


        $('#update_btn').on('click',()=>{
            this.update();
        });


        $('#btn_delete').on('click',()=>{
            this.delete();
        });


        $(document).on('click', '.show-delete-modal', (e)=>{
            this.showDeleteModal(e);
        });


        $(document).on('click', '.show-update-modal', (e)=>{
            this.showUpdateModal(e);
        });


    },
    async loadData(){
        const courses = await courseAPI.all();
        courseUI.render(courses.data);

        const semesters = await academicHelper.getSemesters();
        const subjects = await academicHelper.getSubjects();

        courseUI.fill(semesters.data, "semester_name", document.querySelector("#course_name"));
        courseUI.fill(subjects.data, "subject_code", document.querySelector("#course_subject"));
        
        const update_form = $('#dataForm-update');
        courseUI.fill(semesters.data, "semester_name", update_form.find("#semester")[0]);
        courseUI.fill(subjects.data, "subject_code", update_form.find("#subject")[0]);
        
    },
    async create(){
        const form = $('#dataForm');
        const course = new Course()
        form.find("input[name]").each(function(){
            const key = $(this).attr("name");
            const value = $(this).val();
            course.set(key, value);
        });

        try{
            const data = await courseAPI.create(course);
            await toast.success(data.message, 'Success');
            window.location.reload();
        }catch{
            toast.error(data.message, 'Error')
        }        
    },
    async update(){
        const course = new Course();
        const form = $('#dataForm-update');
        form.find("input[name]").each(function(){
            const key = $(this).attr("name");
            course.set(key, $(this).val());
        });
        
        try {
            const data = await courseAPI.update(course);
            await toast.success(data.message, "Success");
            navigate.refresh();
        } catch (error) {
            console.log(error);
            toast.error(error?.message || "Failed to update course!");
        }
    },
    async delete(){
        try {
            const data = await courseAPI.delete(this.deleteId);
            await toast.success(data.message);
            Utils.refresh();
        } catch (error) {
            console.log(error);
            await toast.error(error?.message || "Error occured!");
        }
    },
    showUpdateModal(e){

        const update_form = $('#dataForm-update');
        const target = $(e.currentTarget);
        console.log("this is event and its target : ",e);
        const data = target.data("course");
        console.log("this is course data : ",data);
        const semesters = data.semester;
        const subjects = data.subject;

        const course = new Course();
        course.set("id", data.id);
        course.set("course_id", data.course_id);

        semesters.semester_id = semesters.id;
        subjects.subject_id = subjects.id;

        courseUI.fillUpdateForm(course, update_form);
        courseUI.fillUpdateForm(semesters, $("#semester"));
        courseUI.fillUpdateForm(subjects, $("#subject"));

        Modal.show('#courseModal-update');
    },
    showDeleteModal(e){
        const target = $(e.currentTarget);
        const id = target.data("id");
        this.deleteId = id;
        Modal.show('#delete-modal');
    }
};