export class AddUserModalValidation {
    constructor(formId) {
        this.form = document.getElementById(formId);

        this.nameInput = this.form.querySelector('[name="user_name"]');
        this.emailInput = this.form.querySelector('[name="user_email"]');
        this.passwordInput = this.form.querySelector('[name="user_password"]');

        this.init();
    }

    init() {
        this.form.addEventListener("submit", (e) => {
            const isValid = this.validateAll();

            if (!isValid) {
                e.preventDefault();
            }
        });
        this.bindLiveValidation();
    }

    validateAll() {
        const errors = {};

        const name = this.nameInput.value.trim();
        const email = this.emailInput.value.trim();
        const password = this.passwordInput.value.trim();

        // NAME
        if (!name) {
            errors.user_name = "Name must not be empty";
        }

        // EMAIL
        if (!email) {
            errors.user_email = "Email must not be empty";
        }

        // PASSWORD
        if (!password) {
            errors.user_password = "Password must not be empty";
        }

        const isValid = Object.keys(errors).length === 0;

        // show errors in UI
        this.showErrors(errors);

        return {
            valid: isValid,
            errors
        };
    }

    validateName() {
        const value = this.nameInput.value.trim();

        if (value.length === 0) {
            this.clearError(this.nameInput);
            return false;
        }

        if (value.length < 3) {
            this.showError(this.nameInput, "Name must be at least 3 characters");
            return false;
        }

        this.clearError(this.nameInput);
        return true;
    }

    validateEmail() {
        const value = this.emailInput.value.trim();

        if (value.length === 0) {
            this.clearError(this.emailInput);
            return false;
        }

        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        if (!emailRegex.test(value)) {
            this.showError(this.emailInput, "Invalid email address");
            return false;
        }

        this.clearError(this.emailInput);
        return true;
    }

    validatePassword() {
        const value = this.passwordInput.value;

        if (value.length === 0) {
            this.clearError(this.passwordInput);
            return false;
        }

        if (value.length < 8) {
            this.showError(this.passwordInput, "Minimum 8 characters required");
            return false;
        }

        const strongPasswordRegex =
            /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).{8,64}$/;

        if (!strongPasswordRegex.test(value)) {
            this.showError(
                this.passwordInput,
                "Must include uppercase, lowercase, number & special character"
            );
            return false;
        }

        this.clearError(this.passwordInput);
        return true;
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

        this.nameInput.addEventListener(
            "input",
            this.debounce(() => this.validateName(), 300)
        );

        this.emailInput.addEventListener(
            "input",
            this.debounce(() => this.validateEmail(), 300)
        );

        this.passwordInput.addEventListener(
            "input",
            this.debounce(() => this.validatePassword(), 300)
        );
    }
}

export class UpdateUserModalValidation {
    constructor(formId) {
        this.form = document.getElementById(formId);

        this.nameInput = this.form.querySelector('[name="user_name"]');
        this.emailInput = this.form.querySelector('[name="user_email"]');
        this.passwordInput = this.form.querySelector('[name="user_password"]');

        this.init();
    }

    init() {
        this.form.addEventListener("submit", (e) => {
            const isValid = this.validateAll();

            if (!isValid) {
                e.preventDefault();
            }
        });
        this.bindLiveValidation();
    }

    validateAll() {
        const errors = {};

        const name = this.nameInput.value.trim();
        const email = this.emailInput.value.trim();
        const password = this.passwordInput.value.trim();

        // NAME
        if (!name) {
            errors.user_name = "Name must not be empty";
        }

        // EMAIL
        if (!email) {
            errors.user_email = "Email must not be empty";
        }

        const isValid = Object.keys(errors).length === 0;

        // show errors in UI
        this.showErrors(errors);

        return {
            valid: isValid,
            errors
        };
    }

    validateName() {
        const value = this.nameInput.value.trim();

        if (value.length === 0) {
            this.clearError(this.nameInput);
            return false;
        }

        if (value.length < 3) {
            this.showError(this.nameInput, "Name must be at least 3 characters");
            return false;
        }

        this.clearError(this.nameInput);
        return true;
    }

    validateEmail() {
        const value = this.emailInput.value.trim();

        if (value.length === 0) {
            this.clearError(this.emailInput);
            return false;
        }

        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        if (!emailRegex.test(value)) {
            this.showError(this.emailInput, "Invalid email address");
            return false;
        }

        this.clearError(this.emailInput);
        return true;
    }

    validatePassword() {
        const value = this.passwordInput.value;

        if (value.length === 0) {
            this.clearError(this.passwordInput);
            return false;
        }

        if (value.length < 8) {
            this.showError(this.passwordInput, "Minimum 8 characters required");
            return false;
        }

        const strongPasswordRegex =
            /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).{8,64}$/;

        if (!strongPasswordRegex.test(value)) {
            this.showError(
                this.passwordInput,
                "Must include uppercase, lowercase, number & special character"
            );
            return false;
        }

        this.clearError(this.passwordInput);
        return true;
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

        this.nameInput.addEventListener(
            "input",
            this.debounce(() => this.validateName(), 300)
        );

        this.emailInput.addEventListener(
            "input",
            this.debounce(() => this.validateEmail(), 300)
        );

        this.passwordInput.addEventListener(
            "input",
            this.debounce(() => this.validatePassword(), 300)
        );
    }
}


