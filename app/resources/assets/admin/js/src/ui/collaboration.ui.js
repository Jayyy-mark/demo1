//static/js/app/ui/collaboration.ui.js
//<!--====================================
//  COLLABORATION UI HANDLER
//=====================================-->
import { dataTable } from "../utils/dataTable.js";

const tbody = $('#tbody-collaboration');

export const collaborationUI = {
    render(collaborations) {
        tbody.empty();

        $(collaborations).each(function (index, d) {

            const row = `
            <tr>
                <td class="text-start py-3">${d.id}</td>
                <td class="text-start py-3">
                    <img src="/assets/media/collaborations/${d.logo}" alt="Logo" class="img-fluid" style="max-height: 50px;">
                </td>
                <td class="text-start py-3">${d.organization_name}</td>
                <td class="text-start py-3">
                    <div
                        class="description-preview show-description-modal"
                        data-description="${(d.description || '').replace(/"/g, '&quot;')}"
                    >
                        ${d.description || 'N/A'}
                    </div>
                </td>
                <td class="text-start py-3">
                    ${d.url ? `<a href="${d.url}" target="_blank">${d.url}</a>` : 'N/A'}
                </td>
                <td class="py-3 text-start px-1">
                    <div class="action-buttons d-flex justify-content-start ps-0">
                        <button class="btn btn-sm btn-info border rounded-5 show-update-modal-collaboration"
                        data-collaborations='${JSON.stringify(d)}'                     
                        >
                            <i class="ti ti-edit"></i>
                        </button>
                        <button class="btn btn-sm btn-danger border rounded-5 show-delete-modal-collaboration"
                        data-id="${d.id}"
                        >
                            <i class="ti ti-trash"></i>
                        </button>
                    </div>
                </td>
            </tr>
            `;

            tbody.append(row);
        });
        dataTable.init("#dataTable-collaboration");

    },
    fillUpdateForm(data) {
        const form = $("#dataForm-collaboration-update");
        $.each(data, function (key, value) {
            // We don't populate 'file' input because browsers do not allow setting a value for file inputs
            if (key !== "file" && key !== "logo") {
                form.find(`[name=${key}]`).val(value);
            }
        });
    },
};
