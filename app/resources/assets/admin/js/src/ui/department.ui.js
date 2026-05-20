//static/js/app/ui/department.ui.js
//<!--====================================
//  DEPARTMENT UI HANDLER
//=====================================-->
import { dataTable } from "../utils/dataTable.js";

const tbody = $('#tbody-department');

export const departmentUI = {
    render(departments) {
        tbody.empty();

        $(departments).each(function (index, d) {
            const row = `
            <tr>
                <td class="text-start py-3">${d.id}</td>
                <td style="width: 1%; white-space: nowrap;" class="py-1 px-3">${d.department_name}</td>
                <td class="py-3 text-start px-1">
                    <div class="action-buttons d-flex justify-content-start ps-0">
                        <button class="btn btn-sm btn-info border rounded-5 show-update-modal-department"
                        data-departments='${JSON.stringify(d)}'                     
                        >
                            <i class="ti ti-edit"></i>
                        </button>
                        <button class="btn btn-sm btn-danger border rounded-5 show-delete-modal-department"
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
        dataTable.init("#dataTable-department");

    },
    fillUpdateForm(data) {
        const form = $("#dataForm-department-update");
        $.each(data, function (key, value) {
            form.find(`[name=${key}]`).val(value);
        });
    },
};