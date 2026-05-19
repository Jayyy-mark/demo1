//static/js/app/ui/subject.ui.js
//<!--====================================
//  SUBJECT  UI HANDLER
//=====================================-->
import { dataTable } from "../utils/dataTable.js";

const tbody = $('#tbody-subject');

export const subjectUI = {
    render(subjects) {
        tbody.empty();

        $(subjects).each(function (index, s) {
            const row = `
            <tr>
                <td class="text-start py-3">${s.id}</td>
                <td class="text-start py-3" style="width: 150px; white-space: nowrap;">${s.subject_code || 'N/A'}</td>
                <td class="text-start py-3">${s.subject_name || 'N/A'}</td>
                <td class="text-start py-3">${s.department?.department_name || 'N/A'}</td>
                <td class="py-3 text-start" style="width: 150px; white-space: nowrap;">
                    <div class="action-buttons s-flex justify-content-start ps-0">
                        <button class="btn btn-sm btn-info border rounded-5 show-update-modal-subject"
                        data-subjects='${JSON.stringify(s)}'                     
                        >
                            <i class="ti ti-edit"></i>
                        </button>
                        <button class="btn btn-sm btn-danger border rounded-5 show-delete-modal-subject"
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
        dataTable.init("#dataTable-subject");

    },
    fillUpdateForm(data) {
        const form = $("#dataForm-subject-update");
        $.each(data, function (key, value) {
            form.find(`[name=${key}]`).val(value);
        });
    },
    setDepartments(data, name, element) {

        const options = data.map(item => ({
            value: item.id,
            label: item[name],
        }));

        new SearchableSelect(
            element,
            options
        );

    },
};