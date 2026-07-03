export class Modal {

    static getElement(modal_id) {
        const el = document.querySelector(modal_id);

        if (!el) {
            throw new Error(`Modal not found: ${modal_id}`);
        }

        return el;
    }

    static show(modal_id) {
        const el = this.getElement(modal_id);

        const modal =
            bootstrap.Modal.getOrCreateInstance(el);

        modal.show();
    }

    static hide(modal_id) {
        const el = this.getElement(modal_id);

        const modal =
            bootstrap.Modal.getOrCreateInstance(el);

        modal.hide();
    }
}

export function closeAllModals() {

    document.querySelectorAll('.modal.show').forEach((modalEl) => {

        const modal = bootstrap.Modal.getInstance(modalEl);

        if (modal) {
            modal.hide();
        }

    });

    document.querySelectorAll('.modal-backdrop').forEach(backdrop => {
        backdrop.remove();
    });

    document.body.classList.remove('modal-open');
    document.body.style.removeProperty('padding-right');
}