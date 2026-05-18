//static/js/app/ui/semester.ui.js
//<!--====================================
//  SEMESTER UI HANDLER
//=====================================-->
import { dataTable } from "../utils/dataTable.js";

const tbody = $('#tbody-semester');

export const semesterUI = {
    render(semesters) {
        tbody.empty();

        $(semesters).each(function (index, s) {
            const row = `
            <tr>
                <td class="text-start py-3">${s.id}</td>
                <td class="text-start py-3">${s.year?.year_name || 'N/A'}</td>
                <td class="text-start py-3">${s.semester_term || 'N/A'}</td>
                <td class="text-start py-3">${s.semester_term || 'N/A'}</td>
                <td class="py-3 text-start">
                    <div class="action-buttons s-flex justify-content-start ps-0">
                        <button class="btn btn-sm btn-info border rounded-5 show-update-modal-semester"
                        data-semesters='${JSON.stringify(s)}'                     
                        >
                            <i class="ti ti-edit"></i>
                        </button>
                        <button class="btn btn-sm btn-danger border rounded-5 show-delete-modal-semester"
                        data-id="${s.id}"
                        >
                            <i class="ti ti-trash"></i>
                        </button>
                    </div>
                </td>
            </tr>
            `;

            tbody.append(row);
        });
        dataTable.init("#dataTable-semester");

    },
    fillUpdateForm(data){
        const form = $("#dataForm-semester-update");
        $.each(data, function(key, value){
            form.find(`[name=${key}]`).val(value);
        });
    },
    setYears(data, name, element) {
        const options = data.map(item=>({
            value:item.id,
            label:item[name],
        }));

        new SearchableSelect(
            element,
            options
        );
    },
};