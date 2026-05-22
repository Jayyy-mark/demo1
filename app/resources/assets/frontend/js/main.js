//<!-- Mobile Menu Script -->
const menuBtn = document.getElementById("menu-btn");
const drawer = document.getElementById("mobile-menu");
const overlay = document.getElementById("overlay");

const mainView = document.getElementById("mainView");
const homeView = document.getElementById("homeView");
const academicView = document.getElementById("academicView");
const facultiesView = document.getElementById("facultiesView");
const admissionView = document.getElementById("admissionView");
const backBtn = document.getElementById("backBtn");
const subViews = {
    home: homeView,
    academic: academicView,
    faculties: facultiesView,
    admission: admissionView
};

function openDrawer() {
    drawer.classList.remove("translate-x-full");
    overlay.classList.remove("hidden");
    document.body.classList.add("overflow-hidden");
    menuBtn.setAttribute("aria-expanded", "true");
    showMain();
}

function closeDrawer() {
    drawer.classList.add("translate-x-full");
    overlay.classList.add("hidden");
    document.body.classList.remove("overflow-hidden");
    menuBtn.setAttribute("aria-expanded", "false");
}

function showMain() {
    mainView.classList.add("is-active");
    mainView.setAttribute("aria-hidden", "false");
    Object.values(subViews).forEach(function (view) {
        view.classList.remove("is-active");
        view.setAttribute("aria-hidden", "true");
    });
    backBtn.classList.add("hidden");
}

function openSub(type) {
    if (!subViews[type]) {
        return;
    }

    mainView.classList.remove("is-active");
    mainView.setAttribute("aria-hidden", "true");
    Object.keys(subViews).forEach(function (key) {
        const isActive = key === type;
        subViews[key].classList.toggle("is-active", isActive);
        subViews[key].setAttribute("aria-hidden", String(!isActive));
    });
    backBtn.classList.remove("hidden");
}

menuBtn.addEventListener("click", openDrawer);

drawer.querySelectorAll("a").forEach(function (link) {
    link.addEventListener("click", closeDrawer);
});

document.addEventListener("keydown", function (event) {
    if (event.key === "Escape") {
        closeDrawer();
    }
});

window.addEventListener("resize", function () {
    if (window.innerWidth >= 1024) {
        closeDrawer();
    }
});


function openModal(src) {
    console.log("this is src : ", src);
    document.getElementById('modalImg').src = src;
    document.getElementById('imageModal').classList.remove('hidden');
    document.body.style.overflow = 'hidden'; // Stop scrolling
}
function closeModal() {
    document.getElementById('imageModal').classList.add('hidden');
    document.body.style.overflow = 'auto'; // Enable scrolling
}