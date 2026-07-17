import { activityApi } from "../api/activityApi.js"
import { activityUI } from "../ui/activity.ui.js";
import { toast } from '../utils/toast.js';
import { Activity } from "../interfaces/activity.js";
import { Utils } from "../utils/utils.js";
import { Modal } from "../utils/modal.js";
import { FormValidation } from "../validations/form_validations.js";

export const activityEvent = {
    deleteActivityName: "",   // name of the group to delete
    pendingDeleteIds:   [],   // IDs marked for deletion in the update modal
    updateNewFiles:     [],   // newly selected files in the update modal
    updateOriginalName: "",   // original name before editing (in case user renames)

    init() {
        this.addValidation    = new FormValidation("dataForm");
        this.updateValidation = new FormValidation("dataForm-update");

        this.loadData();

        // ── ADD ──────────────────────────────────────────────────────
        $("#add_btn").on('click', () => this.create());

        // ── UPDATE ───────────────────────────────────────────────────
        $("#update_btn").on('click', () => this.update());

        // ── DELETE CONFIRM ───────────────────────────────────────────
        $("#delete_btn").on('click', () => this.delete());

        // ── Open UPDATE modal (triggered from table row) ──────────────
        $(document).on('click', '.show-update-modal', (e) => this.showUpdateModal(e));

        // ── Open DELETE modal (triggered from table row) ──────────────
        $(document).on('click', '.show-delete-modal', (e) => this.showDeleteModal(e));

        // ── Mark existing image for deletion (inside update modal) ────
        $(document).on('click', '.update-img-remove', (e) => this.toggleMarkForDelete(e));

        // ── Cancel / Undo deletion mark (Cancel button inside the overlay) ──
        $(document).on('click', '.update-img-cancel', (e) => {
            // Stop propagation so the card's trash button doesn't also fire
            e.stopPropagation();
            this.toggleMarkForDelete(e);
        });

        // ── New file picker inside update modal ───────────────────────
        const updatePicker = document.getElementById('updateFilePicker');
        const updateDropZone = document.getElementById('updateImgDropZone');

        if (updateDropZone) {
            updateDropZone.addEventListener('click', () => updatePicker && updatePicker.click());
        }
        if (updatePicker) {
            updatePicker.addEventListener('change', () => {
                Array.from(updatePicker.files).forEach(f => {
                    // de-duplicate
                    const dup = this.updateNewFiles.some(x => x.name === f.name && x.size === f.size);
                    if (!dup) this.updateNewFiles.push(f);
                });
                updatePicker.value = '';
                this.renderUpdateNewPreviews();
            });
        }

        // Drag-and-drop for update modal
        if (updateDropZone) {
            updateDropZone.addEventListener('dragover', e => { e.preventDefault(); updateDropZone.classList.add('dragover'); });
            updateDropZone.addEventListener('dragleave', () => updateDropZone.classList.remove('dragover'));
            updateDropZone.addEventListener('drop', e => {
                e.preventDefault();
                updateDropZone.classList.remove('dragover');
                Array.from(e.dataTransfer.files).forEach(f => {
                    const dup = this.updateNewFiles.some(x => x.name === f.name && x.size === f.size);
                    if (!dup) this.updateNewFiles.push(f);
                });
                this.renderUpdateNewPreviews();
            });
        }

        // Reset update modal state on close
        const updateModal = document.getElementById('activityModal-update');
        if (updateModal) {
            updateModal.addEventListener('hidden.bs.modal', () => {
                this.pendingDeleteIds   = [];
                this.updateNewFiles     = [];
                this.updateOriginalName = "";
                const newGrid = document.getElementById('updateNewImgPreviewGrid');
                if (newGrid) newGrid.innerHTML = '';
                const newBadge = document.getElementById('updateNewImgCountBadge');
                if (newBadge) newBadge.textContent = '0 image(s)';
            });
        }
    },

    // ─── Toggle red overlay on an existing image card ─────────────────
    toggleMarkForDelete(e) {
        const btn  = e.currentTarget;
        const card = btn.closest('.img-preview-item');
        if (!card) return;

        const id      = parseInt(card.dataset.id);
        const marked  = card.dataset.marked === 'true';
        const overlay = card.querySelector('.img-delete-overlay');

        if (marked) {
            // Un-mark
            card.dataset.marked = 'false';
            overlay.style.display = 'none';
            card.style.opacity = '1';
            this.pendingDeleteIds = this.pendingDeleteIds.filter(x => x !== id);
        } else {
            // Mark for deletion
            card.dataset.marked = 'true';
            overlay.style.display = 'flex';
            card.style.opacity = '0.5';
            if (!this.pendingDeleteIds.includes(id)) {
                this.pendingDeleteIds.push(id);
            }
        }
    },

    // ─── Render newly added file previews inside the update modal ─────
    renderUpdateNewPreviews() {
        const newGrid  = document.getElementById('updateNewImgPreviewGrid');
        const newBadge = document.getElementById('updateNewImgCountBadge');
        if (!newGrid) return;

        newGrid.innerHTML = '';
        if (newBadge) newBadge.textContent = `${this.updateNewFiles.length} image(s)`;

        this.updateNewFiles.forEach((file, index) => {
            const reader = new FileReader();
            reader.onload = (e2) => {
                const item = document.createElement('div');
                item.className = 'img-preview-item';
                item.innerHTML = `
                    <img src="${e2.target.result}" alt="preview">
                    <div class="img-preview-name" title="${file.name}">${file.name}</div>
                    <button type="button" class="img-preview-remove" data-new-index="${index}" title="Remove">
                        <i class="ti ti-x"></i>
                    </button>`;
                item.querySelector('.img-preview-remove').addEventListener('click', () => {
                    this.updateNewFiles.splice(index, 1);
                    this.renderUpdateNewPreviews();
                });
                newGrid.appendChild(item);
            };
            reader.readAsDataURL(file);
        });
    },

    // ─── Load and render data ──────────────────────────────────────────
    async loadData() {
        try {
            const activities = await activityApi.all();
            activityUI.render(activities.data);
        } catch (error) {
            toast.error(error?.message || "Error occurred!", "Error");
        }
    },

    // ─── CREATE ────────────────────────────────────────────────────────
    async create() {
        if (this.addValidation) {
            const result = this.addValidation.validateAll();
            if (!result.valid) {
                toast.error(Object.values(result.errors)[0]);
                return;
            }
        }

        const form     = $('#dataForm');
        const activity = new Activity();
        form.find('[name]').each(function () {
            const key = $(this).attr("name");
            activity.set(key, this.type === "file" ? this.files : $(this).val());
        });

        try {
            const data = await activityApi.create(activity);
            await toast.success(data.message, "Success");
        } catch (error) {
            console.log(error);
            await toast.error(error?.message || "Error occurred!", "Error");
        }
    },

    // ─── UPDATE (group-aware) ──────────────────────────────────────────
    async update() {
        const form = $('#dataForm-update');

        const fields = {
            original_name:  form.find('[name="original_name"]').val(),
            activity_name:  form.find('[name="activity_name"]').val(),
            category:       form.find('[name="category_update"]').val(),
            activity_type:  form.find('[name="activity_type_update"]').val(),
            description:    form.find('[name="description_update"]').val(),
            date:           form.find('[name="date_update"]').val(),
        };

        try {
            const data = await activityApi.updateByName(
                fields,
                this.pendingDeleteIds,
                this.updateNewFiles
            );
            await toast.success(data.message, "Success");
            Utils.refresh();
        } catch (error) {
            console.log(error);
            await toast.error(error?.message || "Error occurred!", "Error");
        }
    },

    // ─── DELETE (group-aware) ──────────────────────────────────────────
    async delete() {
        try {
            const data = await activityApi.deleteByName(this.deleteActivityName);
            await toast.success(data.message);
            Utils.refresh();
        } catch (error) {
            console.log(error);
            await toast.error(error?.message || "Error occurred!");
        }
    },

    // ─── Show update modal ─────────────────────────────────────────────
    showUpdateModal(e) {
        const target  = $(e.currentTarget);
        const rawJson = target.attr("data-activities");
        let records;
        try {
            records = JSON.parse(rawJson);
        } catch (_) {
            records = [target.data("activity")];
        }
        this.pendingDeleteIds   = [];
        this.updateNewFiles     = [];
        this.updateOriginalName = records[0]?.activity_name || "";
        activityUI.fillUpdateForm(records);
        Modal.show('#activityModal-update');
    },

    // ─── Show delete confirmation modal ───────────────────────────────
    showDeleteModal(e) {
        const target = $(e.currentTarget);
        this.deleteActivityName = target.data("activity-name");
        Modal.show('#delete-modal');
    },
}