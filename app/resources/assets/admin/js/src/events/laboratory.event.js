import { laboratoryApi } from "../api/laboratoryApi.js"
import { laboratoryUI } from "../ui/laboratory.ui.js";
import {toast} from '../utils/toast.js';
import { Laboratory } from "../interfaces/laboratory.js";
import { Utils } from "../utils/utils.js";
import { Modal } from "../utils/modal.js";

export const laboratoryEvent = {
    deleteId:"",

    init(){
        this.loadData();

        //<!--=========================
        //  laboratory CREATE EVENT 
        //==========================-->

        $("#add_btn").on('click', ()=>{
            this.create();
        });

        /*<!--=========================
          laboratory UPDATE EVENT 
        ===========================-->*/

        $("#update_btn").on('click', ()=>{
            this.update();
        });

        /*<!--=========================
          laboratory DELETE EVENT 
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
            const laboratorys = await laboratoryApi.all();  
            laboratoryUI.render(laboratorys.data);

        } catch (error) {
            toast.error(error?.message || "Error occured!", "Error");
        }
    },
    async create(){
        const form = $('#dataForm');
        const laboratory = new Laboratory();
        form.find('[name]').each(function(){
            const key = $(this).attr("name");
            let value;

            if($(this).attr("type") === "file"){
                value = this.files;
            }else{
                value = $(this).val();
            }

            laboratory.set(key, value);
        });

        try
        {
            const data = await laboratoryApi.create(laboratory);
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
        const laboratory = new Laboratory();
        form.find('[name]').each(function(){
            const key = $(this).attr("name");
            let value;

            if(this.type=="file"){
                value = this.files[0];
            }else{
                value = $(this).val();
            }

            laboratory.set(key, value);
        });

        try {
            const data = await laboratoryApi.update(laboratory);
            await toast.success(data.message, "Success");
            Utils.refresh();
        } catch (error) {
            console.log(error);
            await toast.error(error?.message || "Error occured!", "Error");
        }
    },
    async delete(){
        try {
            const data = await laboratoryApi.delete(this.deleteId);
            await toast.success(data.message);
            Utils.refresh();
        } catch (error) {
            console.log(error);
            await toast.error(error?.message || "Error occured!");
        }
    },
    showUpdateModal(e){
        const target = $(e.currentTarget);
        const data = target.data("laboratory");

        laboratoryUI.fillUpdateForm(data);
        Modal.show('#laboratoryModal-update');
    },
    showDeleteModal(e){
        const target = $(e.currentTarget);
        const id = target.data("id");
        this.deleteId = id;
        Modal.show('#delete-modal');
    }
}