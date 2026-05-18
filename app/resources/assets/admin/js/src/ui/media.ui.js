import { dataTable } from "../utils/dataTable.js";


const tbody = $('#tbody');


export const mediaUI = {
    render(medias){
        tbody.empty();
        if ($.fn.DataTable.isDataTable('#dataTable')) {
            $('#dataTable').DataTable().clear().destroy();
        }

        if(medias.length == null){
            tbody.append("<tr><td colspan='4'> No data avaliable </td></tr>");
        }

        $(medias).each(function(index, m){
            const row =`
            <tr>
                <td class="py-3 text-start">${m.id}</td>
                <td class="py-3 text-start">${m.filename}</td>
                <td class="py-3 text-start">${m.section?.section_name}</td>
                <td class="py-3 text-start">
                    <div class="action-buttons d-flex justify-content-start ps-0">
                        <button class="btn btn-sm btn-info border rounded-5 show-update-modal"
                        data-media='${JSON.stringify(m)}'                        
                        >
                            <i class="ti ti-edit"></i>
                        </button>
                        <button class="btn btn-sm btn-danger border rounded-5 show-delete-modal"
                        data-id="${m.id}"
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
            form.find(`input[name=${key}]`).val(value);
        });
    },
    setOptions(data, name, element){
        const options = data.map(item=>({
            value:item.id,
            label:item[name]
        }));

        new SearchableSelect(
            element,
            options
        )
    }
}