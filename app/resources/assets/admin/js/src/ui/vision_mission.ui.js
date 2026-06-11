//static/js/app/ui/vision_mission.ui.js
//<!--====================================
//  VISION MISSION UI HANDLER
//=====================================-->
import { dataTable } from "../utils/dataTable.js";

const tbody = $('#tbody-vision_mission');

export const visionMissionUI = {
    render(visionMissions) {
        tbody.empty();
        console.log("this is department data : ", visionMissions);
        $(visionMissions).each(function (index, d) {

            const departmentName = d.department ? d.department.department_name : (d.department_id || 'N/A');

            const row = `
            <tr>
                <td class="text-start py-3">${d.id}</td>
                <td class="text-start py-3">${departmentName}</td>
                <td class="text-start py-3">${d.vision || 'N/A'}</td>
                <td class="text-start py-3">${d.mission || 'N/A'}</td>
                <td class="py-3 text-start px-1">
                    <div class="action-buttons d-flex justify-content-start ps-0">
                        <button class="btn btn-sm btn-info border rounded-5 show-update-modal-vision_mission"
                        data-vision_missions='${JSON.stringify(d)}'                     
                        >
                            <i class="ti ti-edit"></i>
                        </button>
                        <button class="btn btn-sm btn-danger border rounded-5 show-delete-modal-vision_mission"
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
        dataTable.init("#dataTable-vision_mission");

    },
    fillUpdateForm(data) {
        const form = $("#dataForm-vision_mission-update");
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
