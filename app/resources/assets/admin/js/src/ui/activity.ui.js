import { dataTable } from "../utils/dataTable.js";


const tbody = $('#tbody');


export const activityUI = {
    render(activities){
        tbody.empty();
        if ($.fn.DataTable.isDataTable('#dataTable')) {
            $('#dataTable').DataTable().clear().destroy();
        }

        if(activities.length == null){
            tbody.append("<tr><td colspan='4'> No data avaliable </td></tr>");
        }

        $(activities).each(function(index, a){
            let year = a.date.split("-")[0];

            const row =`
            <tr>
   
    
                <td class="py-3 text-start" style="width: 1%; white-space: nowrap;">${a.activity_name}</td>
                <td class="py-3 text-start">${a.category}</td>
                <td class="py-3 text-start" style="width: 1%; white-space: nowrap;">${activityUI.truncate(a.description)}</td>
                <td class="py-3 text-start">${a.date}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
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
    truncate(text, maxLength = 60) {
        if (!text) return "";
        return text.length > maxLength
            ? text.substring(0, maxLength) + "..."
            : text;
    },
    smartWrap(text, maxLength = 40) {
        if (!text) return "";

        let words = text.split(" ");
        let line = "";
        let result = "";

        for (let word of words) {
            if ((line + word).length > maxLength) {
                result += line + "<br>";
                line = word + " ";
            } else {
                line += word + " ";
            }
        }

        result += line;
        return result;
    }
}