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
        form.find('[name="id"]').val(data.id);
        form.find('[name="research_name"]').val(data.research_name);
        form.find('[name="category"]').val(data.category || "");
        form.find('[name="date"]').val(data.date || "");
        form.find('[name="description"]').val(data.description || "");

        // Show current file
        const currentFileContainer = document.getElementById('resUpdateCurrentFile');
        if (currentFileContainer) {
            if (data.filename) {
                currentFileContainer.innerHTML = `
                    <a href="/assets/${data.filepath}" target="_blank" class="text-decoration-none text-dark d-block">
                        <i class="ti ti-file-type-pdf text-danger d-block mb-2" style="font-size:3rem;"></i>
                        <span class="text-break fw-medium" style="font-size:0.9rem;">${data.filename}</span>
                    </a>
                `;
            } else {
                currentFileContainer.innerHTML = `<span class="text-muted">No file attached</span>`;
            }
        }
    },

    /**
     * Populate a SearchableSelect for category on a given wrapper element.
     * @param {string[]} categories  - list of existing category strings
     * @param {Element}  element     - the position-relative wrapper div
     */
    setCategories(categories, element) {
        const options = categories.map(cat => ({
            value: cat,
            label: cat,
        }));
        new SearchableSelect(element, options);
    },
}