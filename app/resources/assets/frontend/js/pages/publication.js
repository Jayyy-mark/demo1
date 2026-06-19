import { api } from "../utils/api.js";
import { getYear } from "../utils/helper.js";

/*===========================
    STATE
=============================*/
let allData = [];
let filteredData = [];

let currentPage = 1;
const pageSize = 4;

let activeYear = "all";
let searchQuery = "";

/*===========================
    ELEMENTS
=============================*/
const container = document.querySelector("#pub-container");
const pagination = document.querySelector("#pagination");
const yearContainer = document.querySelector("#pub-year-filters");
const searchInput = document.querySelector("#pub-search");

/*===========================
    API
=============================*/
const publicationApi = {
    async getAll() {
        const res = await api.get("/frontend/research/all");
        return res.data.researches;
    }
};

/*===========================
    INIT
=============================*/
document.addEventListener("DOMContentLoaded", async () => {
    allData = await publicationApi.getAll();

    renderYearButtons();
    applyFiltersFromURL();

    searchInput.addEventListener("input", (e) => {
        searchQuery = e.target.value.toLowerCase();
        currentPage = 1;
        update();
    });
});

/*===========================
    YEAR FILTERS
=============================*/
function updateYearButtons() {
    document.querySelectorAll(".year-filter-btn").forEach(btn => {
        const isActive = btn.dataset.year === String(activeYear);

        btn.className = `
            year-filter-btn px-5 py-2 rounded-full text-sm font-medium
            transition-all duration-200 border
            ${isActive 
                ? "bg-blue-600 text-white border-blue-600 shadow-md"
                : "bg-white text-gray-600 border-gray-200 hover:bg-gray-50"
            }
        `;
    });
}
function renderYearButtons() {
    const years = [...new Set(allData.map(r => getYear(r.date)))].sort((a, b) => b - a);
    
    years.forEach(year => {
        const btn = document.createElement("button");
        btn.className = "year-filter-btn px-6 py-2 bg-gray-200 rounded-full font-bold";
        btn.innerText = year;
        btn.dataset.year = year;
        btn.classList.toggle("bg-gray-900", year === activeYear);
        btn.classList.toggle("text-white", year === activeYear);
        btn.classList.toggle("bg-gray-100", year !== activeYear);
        btn.classList.toggle("text-gray-700", year !== activeYear);
        btn.onclick = () => {
            activeYear = year;
            currentPage = 1;
            updateURL();
            update();
        };

        yearContainer.appendChild(btn);
    });

    document.querySelector('[data-year="all"]').onclick = () => {
        activeYear = "all";
        currentPage = 1;
        updateURL();
        update();
    };
}

/*===========================
    FILTER LOGIC
=============================*/
function applyFilters() {
    let data = [...allData];

    // year filter
    if (activeYear !== "all") {
        data = data.filter(r => getYear(r.date) == activeYear);
    }

    // search filter
    if (searchQuery) {
        data = data.filter(r =>
            r.research_name.toLowerCase().includes(searchQuery)
        );
    }

    filteredData = data;
}

/*===========================
    RENDER CARDS
=============================*/
function render() {
    container.innerHTML = "";

    const start = (currentPage - 1) * pageSize;
    const end = start + pageSize;

    const pageItems = filteredData.slice(start, end);

    if (pageItems.length === 0) {
        container.innerHTML = `
            <p class="text-center text-gray-500 col-span-2">No publications found</p>
        `;
        pagination.innerHTML = "";
        return;
    }

    pageItems.forEach(item => {
        console.log("this is item", item);
        container.innerHTML += `
        <div class="group relative bg-white/70 backdrop-blur-xl
                    border border-gray-100/60 rounded-3xl p-6
                    shadow-sm hover:shadow-xl transition-all duration-300
                    hover:-translate-y-1 overflow-hidden">

            <!-- Soft gradient glow background -->
            <div class="absolute inset-0 bg-gradient-to-br from-blue-50/40 to-transparent opacity-0 group-hover:opacity-100 transition"></div>

            <!-- Top Row -->
            <div class="relative flex items-center justify-between mb-4">

                <span class="text-xs font-medium px-3 py-1 rounded-full
                            bg-blue-100/70 text-blue-700">
                    ${getYear(item.date)}
                </span>

                <!-- File type badge (optional but nice UX) -->
                <span class="text-[10px] px-2 py-1 rounded-full
                            bg-gray-100 text-gray-500 uppercase tracking-wide">
                    pdf
                </span>

            </div>

            <!-- Title -->
            <h3 class="relative text-lg font-semibold text-gray-900
                    leading-snug group-hover:text-blue-600 transition">
                ${item.research_name}
            </h3>

            <!-- Description -->
            <p class="relative mt-2 text-sm text-gray-500 leading-relaxed line-clamp-3">
                ${item.description ?? ""}
            </p>

            <!-- Bottom Action Row -->
            <div class="relative mt-6 flex items-center justify-between">

                <!-- subtle metadata (optional future use) -->
                <div class="text-xs text-gray-400">
                    Research Paper
                </div>

                <!-- Download Button -->
                <a href="/assets/${item.filepath}" download
                class="inline-flex items-center gap-2 px-4 py-2 rounded-full
                        bg-blue-600 text-white text-sm font-medium
                        shadow-sm hover:bg-blue-700 active:scale-95
                        transition-all duration-200">

                    <!-- PDF Icon -->
                    <svg xmlns="http://www.w3.org/2000/svg"
                        class="w-4 h-4"
                        viewBox="0 0 24 24"
                        fill="currentColor">

                        <path d="M6 2h9l5 5v15a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2z"/>
                        <path d="M8 13h8v2H8zm0 4h6v2H8z" fill="white"/>
                    </svg>

                    PDF
                </a>

            </div>

        </div>
        `;
    });

    renderPagination();
}

/*===========================
    PAGINATION UI
=============================*/
function renderPagination() {
    pagination.innerHTML = "";

    const totalPages = Math.ceil(filteredData.length / pageSize);
    if (totalPages <= 1) return;

    // Prev
    pagination.innerHTML += `
        <button ${currentPage === 1 ? "disabled" : ""}
            onclick="changePage(${currentPage - 1})"
            class="px-4 py-2 rounded-full text-sm
                bg-white border border-gray-200 shadow-sm
                hover:bg-gray-50 transition">
            ‹ Prev
        </button>
    `;

    // Pages
    for (let i = 1; i <= totalPages; i++) {
        pagination.innerHTML += `
            <button onclick="changePage(${i})"
                class="w-10 h-10 rounded-full text-sm border transition
                ${i === currentPage
                    ? "bg-blue-600 text-white border-blue-600 shadow-md"
                    : "bg-white text-gray-600 border-gray-200 hover:bg-gray-50"
                }">
                ${i}
            </button>
        `;
    }

    // Next
    pagination.innerHTML += `
        <button ${currentPage === totalPages ? "disabled" : ""}
            onclick="changePage(${currentPage + 1})"
            class="px-4 py-2 rounded-full text-sm bg-white border border-gray-200 shadow-sm hover:bg-gray-50">
            Next
        </button>
    `;
}

/*===========================
    PAGE CHANGE
=============================*/
window.changePage = function (page) {
    currentPage = page;
    updateURL();
    update();
};

/*===========================
    UPDATE PIPELINE
=============================*/
function update() {
    applyFilters();
    render();
    updateYearButtons();
}

/*===========================
    URL SYNC (?page= & ?year=)
=============================*/
function updateURL() {
    const url = new URL(window.location);

    url.searchParams.set("page", currentPage);
    url.searchParams.set("year", activeYear);

    window.history.pushState({}, "", url);
}

function applyFiltersFromURL() {
    const params = new URLSearchParams(window.location.search);

    currentPage = parseInt(params.get("page")) || 1;
    activeYear = params.get("year") || "all";

    update();
}