import { laboratoryApi } from "../api/laboratoryApi.js"
import { laboratoryUI } from "../ui/laboratory.ui.js";
import { toast } from '../utils/toast.js';
import { Laboratory } from "../interfaces/laboratory.js";
import { Utils } from "../utils/utils.js";
import { Modal } from "../utils/modal.js";
import { FormValidation } from "../validations/form_validations.js";

export const laboratoryEvent = {
    deleteLaboratoryName: "",   // name of the group to delete
    pendingDeleteIds:     [],   // IDs marked for deletion in update modal
    updateNewFiles:       [],   // newly chosen files in update modal

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

        // ── Open UPDATE modal ─────────────────────────────────────────
        $(document).on('click', '.show-update-modal', (e) => this.showUpdateModal(e));

        // ── Open DELETE modal ─────────────────────────────────────────
        $(document).on('click', '.show-delete-modal', (e) => this.showDeleteModal(e));

        // ── Mark existing image for deletion ──────────────────────────
        $(document).on('click', '.lab-update-img-remove', (e) => this.toggleMarkForDelete(e));

        // ── Cancel / Undo deletion mark ───────────────────────────────
        $(document).on('click', '.lab-update-img-cancel', (e) => {
            e.stopPropagation();
            this.toggleMarkForDelete(e);
        });

        // ── New file picker inside update modal ───────────────────────
        const updatePicker   = document.getElementById('labUpdateFilePicker');
        const updateDropZone = document.getElementById('labUpdateImgDropZone');

        if (updateDropZone) {
            updateDropZone.addEventListener('click', () => updatePicker && updatePicker.click());
        }
        if (updatePicker) {
            updatePicker.addEventListener('change', () => {
                Array.from(updatePicker.files).forEach(f => {
                    const dup = this.updateNewFiles.some(x => x.name === f.name && x.size === f.size);
                    if (!dup) this.updateNewFiles.push(f);
                });
                updatePicker.value = '';
                this.renderUpdateNewPreviews();
            });
        }
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
        const updateModal = document.getElementById('laboratoryModal-update');
        if (updateModal) {
            updateModal.addEventListener('hidden.bs.modal', () => {
                this.pendingDeleteIds = [];
                this.updateNewFiles   = [];
                const newGrid  = document.getElementById('labUpdateNewImgPreviewGrid');
                if (newGrid) newGrid.innerHTML = '';
                const newBadge = document.getElementById('labUpdateNewImgCountBadge');
                if (newBadge) newBadge.textContent = '0 image(s)';
            });
        }
    },

    // ─── Toggle red overlay on existing image card ────────────────────
    toggleMarkForDelete(e) {
        const btn  = e.currentTarget;
        const card = btn.closest('.img-preview-item');
        if (!card) return;

        const id      = parseInt(card.dataset.id);
        const marked  = card.dataset.marked === 'true';
        const overlay = card.querySelector('.img-delete-overlay');

        if (marked) {
            card.dataset.marked    = 'false';
            overlay.style.display  = 'none';
            card.style.opacity     = '1';
            this.pendingDeleteIds  = this.pendingDeleteIds.filter(x => x !== id);
        } else {
            card.dataset.marked    = 'true';
            overlay.style.display  = 'flex';
            card.style.opacity     = '0.5';
            if (!this.pendingDeleteIds.includes(id)) {
                this.pendingDeleteIds.push(id);
            }
        }
    },

    // ─── Render newly added file previews inside the update modal ──────
    renderUpdateNewPreviews() {
        const newGrid  = document.getElementById('labUpdateNewImgPreviewGrid');
        const newBadge = document.getElementById('labUpdateNewImgCountBadge');
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
                    <button type="button" class="img-preview-remove" title="Remove">
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

    // ─── Load and render data ─────────────────────────────────────────
    async loadData() {
        try {
            const laboratorys = await laboratoryApi.all();
            laboratoryUI.render(laboratorys.data);
        } catch (error) {
            toast.error(error?.message || "Error occurred!", "Error");
        }
    },

    // ─── CREATE ───────────────────────────────────────────────────────
    async create() {
        if (this.addValidation) {
            const result = this.addValidation.validateAll();
            if (!result.valid) {
                toast.error(Object.values(result.errors)[0]);
                return;
            }
        }

        const form       = $('#dataForm');
        const laboratory = new Laboratory();
        form.find('[name]').each(function () {
            const key = $(this).attr("name");
            laboratory.set(key, this.type === "file" ? this.files : $(this).val());
        });

        try {
            const data = await laboratoryApi.create(laboratory);
            await toast.success(data.message, "Success");
            Utils.refresh();
        } catch (error) {
            console.log(error);
            await toast.error(error?.message || "Error occurred!", "Error");
        }
    },

    // ─── UPDATE (group-aware) ─────────────────────────────────────────
    async update() {
        const form = $('#dataForm-update');

        const fields = {
            original_name:   form.find('[name="original_name"]').val(),
            laboratory_name: form.find('[name="laboratory_name"]').val(),
            category:        form.find('[name="category_update"]').val(),
            description:     form.find('[name="description_update"]').val(),
            date:            form.find('[name="date_update"]').val(),
        };

        try {
            const data = await laboratoryApi.updateByName(
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

    // ─── DELETE (group-aware) ─────────────────────────────────────────
    async delete() {
        try {
            const data = await laboratoryApi.deleteByName(this.deleteLaboratoryName);
            await toast.success(data.message);
            Utils.refresh();
        } catch (error) {
            console.log(error);
            await toast.error(error?.message || "Error occurred!");
        }
    },

    // ─── Show update modal ────────────────────────────────────────────
    showUpdateModal(e) {
        const target  = $(e.currentTarget);
        const rawJson = target.attr("data-laboratories");
        let records;
        try {
            records = JSON.parse(rawJson);
        } catch (_) {
            records = [target.data("laboratory")];
        }
        this.pendingDeleteIds = [];
        this.updateNewFiles   = [];
        laboratoryUI.fillUpdateForm(records);
        Modal.show('#laboratoryModal-update');
    },

    // ─── Show delete confirmation modal ──────────────────────────────
    showDeleteModal(e) {
        const target = $(e.currentTarget);
        this.deleteLaboratoryName = target.data("laboratory-name");
        Modal.show('#delete-modal');
    },
}