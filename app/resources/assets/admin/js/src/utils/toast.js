export const toast = (() => {
    const toastEl = document.getElementById("erpToast");
    const iconBox = document.getElementById("toastIcon");
    const icon = document.getElementById("toastIconSymbol");
    const progress = toastEl.querySelector(".toast-progress");
    const titleEl = document.getElementById("toastTitle");
    const messageEl = document.getElementById("toastMessage");

    function reset() {
        iconBox.className = "toast-icon";
        icon.className = "ti fs-1";
    }

    function show({ type, title = "", message = "" }) {
        return new Promise((resolve) => {
            reset();

            const config = {
                success: {
                    bg: "bg-success-subtle",
                    color: "text-success",
                    icon: "ti-check",
                    progress: "#28a745"
                },
                error: {
                    bg: "bg-danger-subtle",
                    color: "text-danger",
                    icon: "ti-x",
                    progress: "#dc3545"
                }
            };

            const c = config[type];

            iconBox.classList.add(c.bg, c.color);
            icon.classList.add(c.icon);
            progress.style.background = c.progress;

            titleEl.innerText = title;
            messageEl.innerText = message;

            // restart animation
            progress.style.animation = "none";
            progress.offsetHeight;
            progress.style.animation = "toast-progress 2.0s linear forwards";

            const bsToast = new bootstrap.Toast(toastEl);
            bsToast.show();

            const onEnd = () => {
                bsToast.hide();
                resolve(); // 🔥 notify caller
            };

            progress.addEventListener("animationend", onEnd, { once: true });
        });
    }

    return {
        success: (msg, title = "Success") =>
            show({ type: "success", title, message: msg }),

        error: (msg, title = "Error") =>
            show({ type: "error", title, message: msg })
    };
})();