import { dataTable } from "../utils/dataTable.js";


const tbody = $('#tbody');


export const researchUI = {
    render(researchs){
        tbody.empty();
        if ($.fn.DataTable.isDataTable('#dataTable')) {
            $('#dataTable').DataTable().clear().destroy();
        }

        if(researchs.length == null){
            tbody.append("<tr><td colspan='4'> No data avaliable </td></tr>");
        }

        $(researchs).each(function(index, r){
            let year = r.date.split("-")[0];


            const row =`
            <tr>
                <td class="py-3 text-start">${r.id}</td>
                <td class="py-3 text-start">${r.research_name}</td>
                <td class="py-3 text-start">${r.category}</td>
                <td class="py-3 text-start">${r.description || "N/A"}</td>
                <td class="py-3 text-start"><a href="/assets/${r.filepath}">${r.filename}</a></td>
                <td class="py-3 text-start">${year}</td>
                <td class="py-3 text-start">
                    <div class="action-buttons d-flex justify-content-start ps-0">
                        <button class="btn btn-sm btn-info border rounded-5 show-update-modal"
                        data-research='${JSON.stringify(r)}'                        
                        >
                            <i class="ti ti-edit"></i>
                        </button>
                        <button class="btn btn-sm btn-danger border rounded-5 show-delete-modal"
                        data-id="${r.id}"
                        >
                            <i class="ti ti-trash"></i>
                        </button>
                    </div>
                </td>
            </tr>            
            `;
            tbody.append(row);
        }); 
        
        dataTable.init("#dataTable",{
            pageLength: 10
        });

    },
    fillUpdateForm(data){
        const form = $("#dataForm-update");
        $.each(data, function(key, value){
            form.find(`[name=${key}]`).val(value);
        });
    },
}