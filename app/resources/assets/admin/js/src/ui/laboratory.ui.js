import { dataTable } from "../utils/dataTable.js";


const tbody = $('#tbody');


export const laboratoryUI = {
    render(laboratories){
        tbody.empty();
        if ($.fn.DataTable.isDataTable('#dataTable')) {
            $('#dataTable').DataTable().clear().destroy();
        }

        if(laboratories.length == null){
            tbody.append("<tr><td colspan='4'> No data avaliable </td></tr>");
        }

        $(laboratories).each(function(index, l){
            let year = l.date.split("-")[0];


            const row =`
            <tr>
                <td class="py-3 text-start">${l.id}</td>
                <td class="py-3 text-start">${l.laboratory_name}</td>
                <td class="py-3 text-start">${l.category}</td>
                <td class="py-3 text-start">${l.description}</td>
                <td class="py-3 text-start"><a href="/assets/${l.filepath}">${l.filename}</a></td>
                <td class="py-3 text-start">${year}</td>
                <td class="py-3 text-start">
                    <div class="action-buttons d-flex justify-content-start ps-0">
                        <button class="btn btn-sm btn-info border rounded-5 show-update-modal"
                        data-laboratory='${JSON.stringify(l)}'                        
                        >
                            <i class="ti ti-edit"></i>
                        </button>
                        <button class="btn btn-sm btn-danger border rounded-5 show-delete-modal"
                        data-id="${l.id}"
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