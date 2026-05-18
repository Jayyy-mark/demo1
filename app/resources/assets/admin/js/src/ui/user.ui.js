//static/js/app/ui/user.ui.js
//<!--====================================
//      USER UI HANDLER

import { dataTable } from "../utils/dataTable.js";
import { Modal } from "../utils/modal.js";

//=====================================-->
const tbody = $('#tbody');

export const userUI = {
    render(users) {
        tbody.empty();
        
        $(users).each(function (index, d) {
            const row = `
            <tr>
                <td class="rounded-start text-start py-3">${d.user_id}</td>
                <td class="text-start py-3">${d.user_name}</td>
                <td class="text-start py-3">${d.user_email}</td>
                <td class="text-start py-3">${d.user_role}</td>
                <td class="rounded-end text-start py-3">
                    <div class="action-buttons d-flex ps-0">
                        <button class="btn btn-sm btn-info show-update-modal rounded-5"
                        data-users='${JSON.stringify(d)}'>
                            <i class="ti ti-edit"></i>
                        </button>
                        <button class="btn btn-sm btn-danger show-delete-modal rounded-5"
                        data-id="${d.id}">
                            <i class="ti ti-trash"></i>
                        </button>
                    </div>
                </td>
            </tr>            
            `;

            tbody.append(row);
        });
        dataTable.init("#dataTable");
    },
    fillUpdateForm(data){
        console.log("Filling update form with data: ", data);
        const form = $("#dataForm-update");
        $.each(data, function(key, value){

            if(key === "user_password"){
                form.find(`[name=${key}]`).val("");
                return;
            }

            if(key === "user_avatar"){
                console.log("avatar: %s", value);
                form.find('#currentAvatar').attr("src", `/assets/images/avatar/${value}`);
            }

            form.find(`[name=${key}]`).val(value);
        });
    },
    setAvatar(element, modalId){
        console.log("Setting avatar with element: ", element);
        const avatarSrc = $(element).attr("src");
        $(`#${modalId}`).find("#currentAvatar").attr("src", avatarSrc);
        $(`#${modalId}`).find("#user_avatar").val(avatarSrc.split("/").pop());
        console.log($(`#${modalId}`).find("#user_avatar").val());
        $(".avatar-item").removeClass("selected");
        $(element).addClass("selected");
        Modal.hide("#avatarModal");
        Modal.show(`#${modalId}`);
    }
};