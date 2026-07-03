export class FormValidation {
    constructor(formId) {
        this.form = document.getElementById(formId);
        if (this.form) {
            this.init();
        }
    }

    init() {
        this.form.addEventListener("submit", (e) => {
            const result = this.validateAll();

            if (!result.valid) {
                e.preventDefault();
            }
        });
        this.bindLiveValidation();
    }

    validateAll() {
        const errors = {};

        const formId = this.form.getAttribute('id') || '';
        const inputs = this.form.querySelectorAll("input[name], select[name], textarea[name]");
        
        inputs.forEach(input => {
            if (input.type === 'hidden' || input.disabled || input.readOnly) return;
            if (input.type === 'file' && formId.includes('update')) return;
            if (input.getAttribute('name') === 'description') return;

            let value = input.value;
            if (typeof value === 'string') value = value.trim();

            if (!value) {
                let labelName = input.getAttribute("name").split('_').map(word => word.charAt(0).toUpperCase() + word.slice(1)).join(' ');
                errors[input.getAttribute("name")] = `${labelName} must not be empty`;
            }
        });

        const isValid = Object.keys(errors).length === 0;

        // show errors in UI
        this.showErrors(errors);

        return {
            valid: isValid,
            errors
        };
    }

    showErrors(errors) {
        // clear old errors first
        this.clearAllErrors();

        for (const key in errors) {
            const input = this.form.querySelector(`[name="${key}"]`);

            if (!input) continue;

            input.classList.add("is-invalid");

            let feedback = input.nextElementSibling;

            if (!feedback || !feedback.classList.contains("invalid-feedback")) {
                feedback = document.createElement("div");
                feedback.className = "invalid-feedback";
                input.parentNode.appendChild(feedback);
            }

            feedback.textContent = errors[key];
        }
    }

    clearAllErrors() {
        this.form.querySelectorAll(".is-invalid").forEach(input => {
            input.classList.remove("is-invalid");
        });

        this.form.querySelectorAll(".invalid-feedback").forEach(el => {
            el.remove();
        });
    }

    showError(input, message) {
        input.classList.add("is-invalid");

        let feedback = input.nextElementSibling;

        if (!feedback || !feedback.classList.contains("invalid-feedback")) {
            feedback = document.createElement("div");
            feedback.className = "invalid-feedback";
            input.parentNode.appendChild(feedback);
        }

        feedback.textContent = message;
    }

    clearError(input) {
        input.classList.remove("is-invalid");

        const feedback = input.nextElementSibling;
        if (feedback && feedback.classList.contains("invalid-feedback")) {
            feedback.textContent = "";
        }
    }

    debounce(fn, delay = 300) {
        let timer;
        return (...args) => {
            clearTimeout(timer);
            timer = setTimeout(() => fn.apply(this, args), delay);
        };
    }

    bindLiveValidation() {
        const formId = this.form.getAttribute('id') || '';
        const inputs = this.form.querySelectorAll("input[name], select[name], textarea[name]");
        inputs.forEach(input => {
            if (input.type === 'hidden' || input.disabled || input.readOnly) return;
            if (input.getAttribute('name') === 'description') return;
            
            input.addEventListener(
                "input",
                this.debounce(() => {
                    let value = input.value;
                    if (typeof value === 'string') value = value.trim();
                    if (!value && !(input.type === 'file' && formId.includes('update'))) {
                        let labelName = input.getAttribute("name").split('_').map(word => word.charAt(0).toUpperCase() + word.slice(1)).join(' ');
                        this.showError(input, `${labelName} must not be empty`);
                    } else {
                        this.clearError(input);
                    }
                }, 300)
            );
        });
    }
}
