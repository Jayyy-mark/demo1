import { dataTable } from "../utils/dataTable.js";

const tbody = $('#tbody');

export const activityUI = {
    /**
     * Group activities by activity_name, render ONE row per unique name.
     * Store the full array for the group in data-activities.
     */
    render(activities) {
        tbody.empty();
        if ($.fn.DataTable.isDataTable('#dataTable')) {
            $('#dataTable').DataTable().clear().destroy();
        }

        if (!activities || activities.length === 0) {
            tbody.append("<tr><td colspan='7'>No data available</td></tr>");
            return;
        }

        // ── Group by activity_name ──────────────────────────────────
        const groups = {};
        activities.forEach(a => {
            const key = a.activity_name;
            if (!groups[key]) groups[key] = [];
            groups[key].push(a);
        });

        let rowIndex = 1;
        Object.entries(groups).forEach(([name, records]) => {
            const first = records[0];
            const year = first.date ? first.date.split("-")[0] : "N/A";

            // Build thumbnail strip (up to 3 shown, +N badge for more)
            const withImages = records.filter(r => r.filepath);
            let photoHtml = '';
            if (withImages.length === 0) {
                photoHtml = `<span class="text-muted small">No photo</span>`;
            } else {
                const visible = withImages.slice(0, 3);
                photoHtml = `<div class="d-flex align-items-center gap-1 flex-wrap">`;
                visible.forEach(r => {
                    photoHtml += `<img src="/assets/${r.filepath}" alt="${r.filename}"
                        style="width:36px;height:36px;object-fit:cover;border-radius:6px;border:1px solid #dee2e6;"
                        title="${r.filename}">`;
                });
                if (withImages.length > 3) {
                    photoHtml += `<span class="badge bg-secondary" style="font-size:.7rem;">+${withImages.length - 3} more</span>`;
                }
                photoHtml += `</div>`;
            }

            // Safely JSON-encode for data attribute
            const groupJson = JSON.stringify(records).replace(/'/g, "&#39;");

            const row = `
            <tr>
                <td class="py-3 text-start">${rowIndex++}</td>
                <td class="py-3 text-start fw-semibold">${name}</td>
                <td class="py-3 text-start">${first.category || ""}</td>
                <td class="py-3 text-start">${year}</td>
                <td class="py-3 text-start">${photoHtml}</td>
                <td class="py-3 text-start">
                    <div class="action-buttons d-flex justify-content-start ps-0 gap-1">
                        <button class="btn btn-sm btn-info border rounded-5 show-update-modal"
                            data-activities='${groupJson}'
                            title="Edit group">
                            <i class="ti ti-edit"></i>
                        </button>
                        <button class="btn btn-sm btn-danger border rounded-5 show-delete-modal"
                            data-activity-name="${name}"
                            title="Delete group">
                            <i class="ti ti-trash"></i>
                        </button>
                    </div>
                </td>
            </tr>`;
            tbody.append(row);
        });

        dataTable.init("#dataTable", { pageLength: 10 });
    },

    /**
     * Populate the Update modal with group data.
     * @param {Array} records - all activity rows for this group
     */
    fillUpdateForm(records) {
        const first = records[0];
        const form = $("#dataForm-update");

        // Text fields from first record
        form.find('[name="original_name"]').val(first.activity_name);
        form.find('[name="activity_name"]').val(first.activity_name);
        form.find('[name="category_update"]').val(first.category || "");
        form.find('[name="date_update"]').val(first.date || "");
        form.find('[name="description_update"]').val(first.description || "");

        // Activity type select
        const typeSelect = form.find('[name="activity_type_update"]');
        typeSelect.val(first.activity_type || "");

        // ── Render existing images in the update preview grid ──────
        const grid = document.getElementById('updateImgPreviewGrid');
        const badge = document.getElementById('updateImgCountBadge');
        const empty = document.getElementById('updateImgEmptyHint');

        grid.innerHTML = '';

        const withImages = records.filter(r => r.filepath);

        badge.textContent = `${withImages.length} image(s)`;
        empty.style.display = withImages.length === 0 ? 'block' : 'none';

        withImages.forEach(record => {
            const item = document.createElement('div');
            item.className = 'img-preview-item';
            item.dataset.id = record.id;
            item.dataset.marked = 'false';
            item.innerHTML = `
                <img src="/assets/${record.filepath}" alt="${record.filename}">
                <div class="img-preview-name" title="${record.filename}">${record.filename}</div>
                <button type="button" class="img-preview-remove update-img-remove" title="Mark for deletion">
                    <i class="ti ti-trash"></i>
                </button>
                <div class="img-delete-overlay" style="display:none;">
                    <i class="ti ti-trash" style="font-size:1.4rem;color:#fff;"></i>
                    <span style="font-size:.7rem;color:#fff;">Marked for deletion</span>
                    <button type="button" class="img-undo-btn update-img-cancel" title="Undo deletion mark">
                        <i class="ti ti-arrow-back-up" style="font-size:.75rem;"></i> Cancel
                    </button>
                </div>`;
            grid.appendChild(item);
        });
    },
}
