/*<!--==========================
    USER EVENTS
=============================-->*/
import { userAPI } from "../api/user.api.js";
import { userUI } from "../ui/user.ui.js";
import { toast } from "../utils/toast.js";
import { User } from "../interfaces/user.js";
import { navigate } from "../utils/navigate.js";
import { AddUserModalValidation, UpdateUserModalValidation } from "../validations/user_validations.js";

let last_triggered_modalId = null;

export const userEvent = {
    delete_id: "",

    init(){

        this.load();

        this.addUserModalValidation = new AddUserModalValidation("dataForm");
        this.updateUserModalValidation = new UpdateUserModalValidation("dataForm-update");

        $("#btn_save").on("click", ()=> this.create());

        $("#btn_update").on("click", ()=> this.update());

        $("#btn_delete").on("click", ()=> this.delete());

        $(document).on("click", ".show-update-modal", (event) => this.showUpdateModal(event));
        
        $(document).on("click", ".show-delete-modal", (event) => this.showDeleteModal(event));

        $(document).on('click', '.avatar-item', function(){
            userUI.setAvatar(this, last_triggered_modalId);
        });

        $(document).on('click', '.choose_avatar_btn', function(){

            const parentModal = $(this).closest('.modal');

            console.log("Parent modal id:", parentModal.attr('id'));
            last_triggered_modalId = parentModal.attr('id');
        });
    },
    async load(){
        try {
            const response = await userAPI.all();
            userUI.render(response.data);
        }catch(error){
            console.log("error : ", error);
             toast.error("Failed to load users.");
        }
    },
    async create(){

        const result = this.addUserModalValidation.validateAll();

        if (!result.valid) {

            const firstError = Object.values(result.errors)[0];

            toast.error(firstError);

            return;
        }

        const form = $("#dataForm");
        const user = new User();

        form.find("[name]").each(function(){
            const key = $(this).attr("name");
            const value = $(this).val();

            user.set(key, value);
        });

        try{
            const response = await userAPI.create(user);
            await toast.success(response.message);
            navigate.refresh();

        }catch(error){
            console.log("error : ", error);
            await toast.error(error?.message || "Failed to create user.");
        }
    },
    async update(){

        const result = this.updateUserModalValidation.validateAll();

        if (!result.valid) {

            const firstError = Object.values(result.errors)[0];

            toast.error(firstError);

            return;
        }

        const form = $("#dataForm-update");
        const user = new User();
        form.find("[name]").each(function(){
            const key = $(this).attr("name");
            const value = $(this).val();
            user.set(key, value);
        });

        try{
            const response = await userAPI.update(user);
            await toast.success(response.message);
            navigate.refresh();
        }catch(error){
            console.log("error : ", error);
            await toast.error(error?.message || "Failed to update user.");
        }
    },
    async delete(){
        try{
            const response = await userAPI.delete(this.delete_id);
            await toast.success(response.message);
            navigate.refresh();
        }catch(error){
            console.log("error : ", error);
            await toast.error(error?.message || "Failed to delete user.");
        }
    },
    showUpdateModal(event){
        const data = $(event.currentTarget).data("users");
        userUI.fillUpdateForm(data);
        const modal = new bootstrap.Modal($("#update-modal"));
        modal.show();
    },
    showDeleteModal(event){
        this.delete_id = $(event.currentTarget).data("id");
        const modal = new bootstrap.Modal($("#delete-modal"));
        modal.show();
    },
};    