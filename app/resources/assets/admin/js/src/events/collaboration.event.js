/*<!--==========================
    COLLABORATION EVENTS
=============================-->*/
import { collaborationAPI } from "../api/collaboration.api.js";
import { collaborationUI } from "../ui/collaboration.ui.js";
import {toast} from "../utils/toast.js";
import { Collaboration } from "../interfaces/collaboration.js";
import { navigate } from "../utils/navigate.js";

export const collaborationEvent = {
    delete_id: "",

    init(){

        this.load();

        $("#save_collaboration_btn").on("click", (e) => {
            e.preventDefault();
            this.create();
        });

        $("#update_collaboration_btn").on("click", (e) => {
            e.preventDefault();
            this.update();
        });

        $("#btn_delete_collaboration").on("click", ()=> this.delete());

        $(document).on("click", ".show-update-modal-collaboration", (event) => this.showUpdateModal(event));
        
        $(document).on("click", ".show-delete-modal-collaboration", (event) => this.showDeleteModal(event));

    },
    async load(){
        try {
            const response = await collaborationAPI.all();
            collaborationUI.render(response.data);
        }catch(error){
            console.log("error : ", error);
             toast.error("Failed to load Collaborations.");
        }
    },
    async create(){
        const form = document.getElementById("dataForm-collaboration");
        const formData = new FormData(form);

        try{
            const response = await collaborationAPI.create(formData);
            await toast.success(response.message);
            navigate.refresh();

        }catch(error){
            console.log("error : ", error);
            await toast.error(error?.message || "Failed to create Collaboration.");
        }
    },
    async update(){
        const form = document.getElementById("dataForm-collaboration-update");
        const formData = new FormData(form);

        try{
            const response = await collaborationAPI.update(formData);
            await toast.success(response.message);
            navigate.refresh();
        }catch(error){
            console.log("error : ", error);
            await toast.error(error?.message || "Failed to update Collaboration.");
        }
    },
    async delete(){
        try{
            const response = await collaborationAPI.delete(this.delete_id);
            await toast.success(response.message);
            navigate.refresh();
        }catch(error){
            console.log("error : ", error);
            await toast.error(error?.message || "Failed to delete Collaboration.");
        }
    },
    showUpdateModal(event){
        const data = $(event.currentTarget).data("collaborations");
        const collaboration = new Collaboration();

        collaboration.set("id", data.id);
        collaboration.set("company_name", data.company_name);
        collaboration.set("description", data.description);
        collaboration.set("url", data.url);

        collaborationUI.fillUpdateForm(collaboration);
        
        const modal = new bootstrap.Modal($("#collaborationModal-update"));
        modal.show();
    },
    showDeleteModal(event){
        this.delete_id = $(event.currentTarget).data("id");
        const modal = new bootstrap.Modal($("#delete-modal-collaboration"));
        modal.show();
    },

};
