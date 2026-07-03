import { researchApi } from "../api/researchApi.js"
import { researchUI } from "../ui/research.ui.js";
import {toast} from '../utils/toast.js';
import { Research } from "../interfaces/research.js";
import { Utils } from "../utils/utils.js";
import { Modal } from "../utils/modal.js";

import { FormValidation } from "../validations/form_validations.js";
export const researchEvent = {
    deleteId:"",

    init(){
        this.addValidation = new FormValidation("dataForm");
        this.updateValidation = new FormValidation("dataForm-update");

        this.loadData();

        //<!--=========================
        //  RESEARCH CREATE EVENT 
        //==========================-->

        $("#add_btn").on('click', ()=>{
            this.create();
        });

        /*<!--=========================
          RESEARCH UPDATE EVENT 
        ===========================-->*/

        $("#update_btn").on('click', ()=>{
            this.update();
        });

        /*<!--=========================
          RESEARCH DELETE EVENT 
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
            const researchs = await researchApi.all();  
            researchUI.render(researchs.data);

        } catch (error) {
            toast.error(error?.message || "Error occured!", "Error");
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

        const form = $('#dataForm');
        const research = new Research();
        form.find('[name]').each(function(){
            const key = $(this).attr("name");
            let value;

            if($(this).attr("type") === "file"){
                value = this.files;
            }else{
                value = $(this).val();
            }

            research.set(key, value);
        });

        try
        {
            const data = await researchApi.create(research);
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
        if (this.updateValidation) {
            const result = this.updateValidation.validateAll();
            if (!result.valid) {
                const firstError = Object.values(result.errors)[0];
                toast.error(firstError);
                return;
            }
        }

        const form = $('#dataForm-update');
        const research = new Research();
        form.find('[name]').each(function(){
            const key = $(this).attr("name");
            let value;
            if(this.type=="file"){
                value = this.files[0];
            }else{
                value = $(this).val();
            }
            research.set(key, value);
        });

        try {
            const data = await researchApi.update(research);
            await toast.success(data.message, "Success");
            Utils.refresh();
        } catch (error) {
            console.log(error);
            await toast.error(error?.message || "Error occured!", "Error");
        }
    },
    async delete(){
        try {
            const data = await researchApi.delete(this.deleteId);
            await toast.success(data.message);
            Utils.refresh();
        } catch (error) {
            console.log(error);
            await toast.error(error?.message || "Error occured!");
        }
    },
    showUpdateModal(e){
        const target = $(e.currentTarget);
        const data = target.data("research");

        researchUI.fillUpdateForm(data);
        Modal.show('#researchModal-update');
    },
    showDeleteModal(e){
        const target = $(e.currentTarget);
        const id = target.data("id");
        this.deleteId = id;
        Modal.show('#delete-modal');
    }
}