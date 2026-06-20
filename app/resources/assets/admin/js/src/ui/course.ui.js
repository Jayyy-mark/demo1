//static/js/app/ui/course.ui.js
//<!--====================================
//  COURSE UI HANDLER
//=====================================-->
import { dataTable } from "../utils/dataTable.js";

const tbody = $('#tbody');

export const courseUI = {
    render(courses) {
        tbody.empty();

        if ($.fn.DataTable.isDataTable('#dataTable')) {
            $('#dataTable').DataTable().clear().destroy();
        }

        $.each(courses, function (index, c) {
            var row = `
            <tr>
                <td class="py-3">${c.course_id}</td>
                <td class="py-3">${c.semester?.semester_name ?? 'N/A'}</td>
                <td class="py-3">${c.subject?.subject_name ?? 'N/A'}</td>
                <td class="py-3">${c.subject?.department?.department_name ?? 'N/A'}</td>
                <td class="py-3 text-start">
                    <div class="action-buttons d-flex justify-content-start ps-0">
                        <button class="btn btn-sm btn-info border rounded-5 show-update-modal"
                        data-course='${JSON.stringify(c)}'                        
                        >
                            <i class="ti ti-edit"></i>
                        </button>
                        <button class="btn btn-sm btn-danger border rounded-5 show-delete-modal"
                        data-id="${c.id}"
                        >
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
    fill(data, name, element) {
        const options = data.map(item=>({
            value:item.id,
            label: item.subject_name === "Internship"
                ? item.subject_name
                : item[name],
        }));

        new SearchableSelect(
            element,
            options
        );
    },
    fillUpdateForm(data, section){
        $.each(data, function(key, value){
            section.find(`[name=${key}]`).val(value);
        });
    },
};