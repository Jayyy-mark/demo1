import { activityApi } from "../api/activityApi.js"
import { activityUI } from "../ui/activity.ui.js";
import {toast} from '../utils/toast.js';
import { Activity } from "../interfaces/activity.js";
import { Utils } from "../utils/utils.js";
import { Modal } from "../utils/modal.js";


export const activityEvent = {
    deleteId:"",

    init(){
        this.loadData();

        //<!--=========================
        //  activity CREATE EVENT 
        //==========================-->

        $("#add_btn").on('click', ()=>{
            this.create();
        });

        /*<!--=========================
          activity UPDATE EVENT 
        ===========================-->*/

        $("#update_btn").on('click', ()=>{
            this.update();
        });

        /*<!--=========================
          activity DELETE EVENT 
        ===========================-->*/
        $("#delete_btn").on('click', ()=>{
            this.delete();
        });

        $(document).on('click', '.show-update-modal', (e)=>{
            this.showUpdateModal(e);
        });

        $(document).on('click', '.show-delete-modal', (e)=>{
            this.showDeleteModal(e);
        });
    },
    async loadData(){
        try {
            const activities = await activityApi.all();  
            activityUI.render(activities.data);

        } catch (error) {
            toast.error(error?.message || "Error occured!", "Error");
        }
    },
    async create(){
        const form = $('#dataForm');
        const activity = new Activity();
        form.find('[name]').each(function () {

            const key = $(this).attr("name");
            let value;

            if ($(this).attr("type") === "file") {
                value = this.files; // ✔ correct
                               
            } else {
                value = $(this).val();
            }

            activity.set(key, value);
        });

        try
        {
            const data = await activityApi.create(activity);
            await toast.success(data.message, "Success");
            Utils.refresh();
        }
        catch(error)
        {
            console.log(error);
            await toast.error(error?.message || "Error occured!", "Error");
        }
    },
    async update(){
        const form = $('#dataForm-update');
        const activity = new Activity();
        form.find('[name]').each(function(){
            const key = $(this).attr("name");
            const value = $(this).val();

            activity.set(key, value);
        });

        try {
            const data = await activityApi.update(activity);
            await toast.success(data.message, "Success");
            Utils.refresh();
        } catch (error) {
            console.log(error);
            await toast.error(error?.message || "Error occured!", "Error");
        }
    },
    async delete(){
        try {
            const data = await activityApi.delete(this.deleteId);
            await toast.success(data.message);
            Utils.refresh();
        } catch (error) {
            console.log(error);
            await toast.error(error?.message || "Error occured!");
        }
    },
    showUpdateModal(e){
        const target = $(e.currentTarget);
        const data = target.data("activity");

        activityUI.fillUpdateForm(data);
        Modal.show('#activityModal-update');
    },
    showDeleteModal(e){
        const target = $(e.currentTarget);
        const id = target.data("id");
        this.deleteId = id;
        Modal.show('#delete-modal');
    }
}