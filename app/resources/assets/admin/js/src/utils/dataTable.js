// helpers/datatable.js

export class dataTable {

    static init(selector = "#dataTable") {

        // destroy existing
        if ($.fn.DataTable.isDataTable(selector)) {
            $(selector).DataTable().destroy();
        }

        return new DataTable(selector, {

            responsive: true,

            pageLength: 10,

            lengthMenu: [5, 10, 25, 50],

            dom:
                "<'row mb-3'" +
                "<'col-md-6'l>" +
                "<'col-md-6 d-flex justify-content-end align-items-center gap-2'f B>" +
                ">" +
                "<'table-responsive'tr>" +
                "<'row mt-3'" +
                "<'col-md-5'i>" +
                "<'col-md-7 text-end'p>" +
                ">",

            buttons: [
                {
                    extend: 'excelHtml5',
                    className: 'd-none'
                },
                {
                    extend: 'pdfHtml5',
                    className: 'd-none',
                    exportOptions: {
                        columns: ':not(:last-child)'
                    }
                },
                {
                    extend: 'copyHtml5',
                    className: 'd-none'
                },
                {
                    extend: 'print',
                    className: 'd-none'
                }
            ],

            initComplete: function () {

                const wrapper = $(`${selector}_wrapper`);

                wrapper.addClass(
                    'border rounded-4 overflow-hidden p-3 bg-white'
                );

                const buttonContainer = wrapper.find('.dt-buttons');

                const dropdownHtml = `
                    <div class="btn-group ms-0">
                        <a href="#" 
                           class="btn btn-sm border border-info dropdown-toggle text-info arrow-none"
                           data-bs-toggle="dropdown">

                            <i class="ti ti-file-download fs-3"></i>
                            Exports
                        </a>

                        <ul class="dropdown-menu dropdown-menu-end">

                            <li>
                                <button class="dropdown-item exportExcel">
                                    <i class="ti ti-file-x me-2 text-success"></i>
                                    Export Excel
                                </button>
                            </li>

                            <li>
                                <button class="dropdown-item exportPDF">
                                    <i class="ti ti-file-text me-2 text-danger"></i>
                                    Export PDF
                                </button>
                            </li>

                            <li>
                                <button class="dropdown-item printFile">
                                    <i class="ti ti-printer text-primary"></i>
                                    Print
                                </button>
                            </li>

                            <li>
                                <button class="dropdown-item exportCopy">
                                    <i class="ti ti-copy me-2 text-secondary"></i>
                                    Copy
                                </button>
                            </li>

                        </ul>
                    </div>
                `;

                buttonContainer.append(dropdownHtml);

                wrapper.find('.exportExcel').on('click', () => {
                    buttonContainer.find(".buttons-excel").trigger("click");
                });

                wrapper.find('.exportPDF').on('click', () => {
                    buttonContainer.find(".buttons-pdf").trigger("click");
                });

                wrapper.find('.exportCopy').on('click', () => {
                    buttonContainer.find(".buttons-copy").trigger("click");
                });

                wrapper.find('.printFile').on('click', () => {
                    buttonContainer.find(".buttons-print").trigger("click");
                });

            }
        });
    }
}