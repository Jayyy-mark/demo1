//static/js/app/ui/year.ui.js
//<!--====================================
//  YEAR UI HANDLER
//=====================================-->
import { dataTable } from "../utils/dataTable.js";

const tbody = $('#tbody-year');

export const yearUI = {
    render(years) {
        tbody.empty();
        $(years).each(function (index, y) {
            const row = `
            <tr>
                <td class="text-start py-3">${y.id}</td>
                <td class="text-start py-3">${y.year_name}</td>
                <td class="py-3 text-start">
                    <div class="action-buttons y-flex justify-content-start ps-0">
                        <button class="btn btn-sm btn-info border rounded-5 show-update-modal-year"
                        data-years='${JSON.stringify(y)}'                     
                        >
                            <i class="ti ti-edit"></i>
                        </button>
                        <button class="btn btn-sm btn-danger border rounded-5 show-delete-modal-year"
                        data-id="${y.id}"
                        >
                            <i class="ti ti-trash"></i>
                        </button>
                    </div>
                </td>
            </tr>
            `;

            tbody.append(row);
        });
        dataTable.init("#dataTable-year");

    },
    fillUpdateForm(data){
        const form = $("#dataForm-year-update");
        $.each(data, function(key, value){
            form.find(`[name=${key}]`).val(value);
        });
    },
};