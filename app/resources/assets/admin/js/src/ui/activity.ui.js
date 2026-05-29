import { dataTable } from "../utils/dataTable.js";


const tbody = $('#tbody');


export const activityUI = {
    render(activities) {
        tbody.empty();
        if ($.fn.DataTable.isDataTable('#dataTable')) {
            $('#dataTable').DataTable().clear().destroy();
        }

        if (activities.length == null) {
            tbody.append("<tr><td colspan='4'> No data avaliable </td></tr>");
        }
        let count = 0;
        $(activities).each(function (index, a) {
            let year = a.date.split("-")[0];
            count++;
            const row = `
            <tr>
                <td class="py-3 text-start">${count}</td>
                <td class="py-3 text-start">${a.activity_name}</td>
                <td class="py-3 text-start">${a.category}</td>
                <td class="py-3 text-start">${year}</td>
                <td class="py-3 text-start">
                    <div class="action-buttons d-flex justify-content-start ps-0">
                        <button class="btn btn-sm btn-info border rounded-5 show-update-modal"
                        data-activity='${JSON.stringify(a)}'                        
                        >
                            <i class="ti ti-edit"></i>
                        </button>
                        <button class="btn btn-sm btn-danger border rounded-5 show-delete-modal"
                        data-id="${a.id}"
                        >
                            <i class="ti ti-trash"></i>
                        </button>
                        <button class="btn btn-sm btn-primary border rounded-5 show-image-modal"
                         data-images='${JSON.stringify(a.images)}'
                        >
                            <i class="ti ti-eye"></i>
                        </button>
                    </div>
                </td>
            </tr>            
            `;
            tbody.append(row);
        });

        dataTable.init("#dataTable", {
            pageLength: 10
        });

    },
    fillUpdateForm(data) {
        const form = $("#dataForm-update");
        $.each(data, function (key, value) {
            form.find(`[name=${key}]`).val(value);
        });
    },
    renderImageModal(data) {

        const row = document.querySelector("#image-modal-row");
        row.innerHTML = "";
        data.forEach(element => {
            const card = `
                <div class="col-4 col-md-4 text-center">

                    <div class="avatar-wrapper">
                        <img src="/assets/${element.filepath}" class="img-fluid avatar-item"
                        >
                        <!-- Hover Actions -->
                        <div class="avatar-overlay">

                            <button class="btn btn-sm btn-danger rounded-5 image-modal-delete-btn" data-id="${element.id}">
                                <i class="ti ti-trash"></i>
                            </button>

                        </div>
                    </div>

                </div>            
            `;
            row.insertAdjacentHTML("beforeend", card);
        });

        const addImageCard = `
            <div class="col-4 col-md-4 text-center">

                <div class="avatar-wrapper add-image-box">

                    <div class="add-content">
                        <i class="ti ti-plus fs-2"></i>
                        <div class="mt-1">Add Images</div>
                    </div>

                </div>

            </div>
        `;

        row.insertAdjacentHTML("beforeend", addImageCard);

    },
}