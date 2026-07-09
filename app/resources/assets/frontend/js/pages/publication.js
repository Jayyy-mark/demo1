import { api } from "../utils/api.js";
import { getYear } from "../utils/helper.js";

/*===========================
    STATE
=============================*/
let allData      = [];
let filteredData = [];
let allYears     = [];          // sorted desc, e.g. [2026,2025,2024,2023,2022,2020,2018]

let currentPage = 1;
const PAGE_SIZE = 6;            // 6 cards look great in the new layout

let activeYear   = "all";
let searchQuery  = "";

// ── Year-strip sliding window ──
const MAX_VISIBLE = 5;          // max year pills shown (excluding All + ellipsis + edge)
let   yearOffset  = 0;          // index of leftmost year shown in the window

/*===========================
    ELEMENTS
=============================*/
const container    = document.querySelector("#pub-container");
const pagination   = document.querySelector("#pagination");
const yearStrip    = document.querySelector("#pub-year-filters");
const searchInput  = document.querySelector("#pub-search");
const countEl      = document.querySelector("#pub-count");

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
    allData  = await publicationApi.getAll();
    allYears = [...new Set(allData.map(r => getYear(r.date)))].sort((a, b) => b - a);

    renderYearStrip();
    applyFiltersFromURL();

    searchInput.addEventListener("input", (e) => {
        searchQuery  = e.target.value.toLowerCase().trim();
        currentPage  = 1;
        update();
    });
});

/*===========================
    YEAR FILTER STRIP
    Logic:
      - Always show "All Years" pill first
      - Show a sliding window of MAX_VISIBLE years
      - If there are more years to the RIGHT of the window → show "…" + last year
      - Clicking "…" advances the window by 1 (slides)
      - Never shows duplicate pills
=============================*/
function renderYearStrip() {
    yearStrip.innerHTML = "";

    // ── All Years pill ──
    const allBtn = _makePill("All Years", "all", activeYear === "all");
    allBtn.addEventListener("click", () => {
        activeYear  = "all";
        currentPage = 1;
        updateURL();
        update();
    });
    yearStrip.appendChild(allBtn);

    if (allYears.length === 0) return;

    // ── Determine visible window ──
    const total    = allYears.length;
    const safeOff  = Math.min(yearOffset, Math.max(0, total - MAX_VISIBLE));
    yearOffset     = safeOff;

    const windowYears = allYears.slice(safeOff, safeOff + MAX_VISIBLE);
    const hasMore     = safeOff + MAX_VISIBLE < total;         // years hidden on right
    const lastYear    = allYears[total - 1];                   // oldest year

    // ── Render window pills ──
    windowYears.forEach(year => {
        const pill = _makePill(String(year), year, activeYear == year);
        pill.addEventListener("click", () => {
            activeYear  = year;
            currentPage = 1;
            updateURL();
            update();
        });
        yearStrip.appendChild(pill);
    });

    // ── "…" pill to advance window ──
    if (hasMore) {
        const dots = document.createElement("button");
        dots.className      = "year-pill ellipsis";
        dots.textContent    = "•••";
        dots.title          = "Show more years";
        dots.addEventListener("click", () => {
            yearOffset = Math.min(yearOffset + 1, total - MAX_VISIBLE);
            renderYearStrip();             // re-render strip only (data unchanged)
            updateYearPillsActive();
        });
        yearStrip.appendChild(dots);

        // ── Last (oldest) year pill always anchored at end ──
        // Only show if not already in the window
        if (!windowYears.includes(lastYear)) {
            const lastPill = _makePill(String(lastYear), lastYear, activeYear == lastYear);
            lastPill.addEventListener("click", () => {
                activeYear  = lastYear;
                currentPage = 1;
                updateURL();
                update();
            });
            yearStrip.appendChild(lastPill);
        }
    }
}

function _makePill(label, yearVal, isActive) {
    const btn = document.createElement("button");
    btn.className      = "year-pill" + (isActive ? " active" : "");
    btn.textContent    = label;
    btn.dataset.year   = yearVal;
    return btn;
}

function updateYearPillsActive() {
    yearStrip.querySelectorAll(".year-pill:not(.ellipsis)").forEach(btn => {
        const isActive = btn.dataset.year === String(activeYear);
        btn.classList.toggle("active", isActive);
    });
}

/*===========================
    FILTER LOGIC
=============================*/
function applyFilters() {
    let data = [...allData];

    if (activeYear !== "all") {
        data = data.filter(r => getYear(r.date) == activeYear);
    }

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

    const start     = (currentPage - 1) * PAGE_SIZE;
    const end       = start + PAGE_SIZE;
    const pageItems = filteredData.slice(start, end);

    // results count
    if (countEl) {
        countEl.textContent = filteredData.length === 0
            ? ""
            : `Showing ${pageItems.length} of ${filteredData.length} publication${filteredData.length !== 1 ? "s" : ""}`;
    }

    if (pageItems.length === 0) {
        container.innerHTML = `
        <div class="pub-empty col-span-2">
            <svg class="w-14 h-14 text-gray-200" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
                    d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
            </svg>
            <p class="text-base font-semibold text-gray-400">No publications found</p>
            <p class="text-sm text-gray-300 mt-1">Try a different search or year filter.</p>
        </div>`;
        pagination.innerHTML = "";
        return;
    }

    pageItems.forEach((item, idx) => {
        const fp      = (item.filepath || "").replace(/\\/g, "/");
        const catName = item.category || "Research Paper";
        const desc    = item.description || "No description available.";

        container.innerHTML += `
        <div class="pub-card pub-fade" style="animation-delay: ${idx * 60}ms">
            <div class="pub-card-header">
                <span class="pub-year-tag">${getYear(item.date)}</span>
                <span class="pub-type-tag">JITES</span>
            </div>

            <h3 class="pub-card-title">${item.research_name}</h3>

            <p class="pub-card-desc">${desc}</p>

            <div class="pub-card-footer">
                <div class="pub-card-meta">
                    <svg class="w-3.5 h-3.5 text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                    </svg>
                    ${catName}
                </div>

                <button
                    class="pdf-download-btn"
                    data-filepath="${fp}">
                    <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5"
                            d="M12 10v6m0 0l-3-3m3 3l3-3M3 17v3a1 1 0 001 1h16a1 1 0 001-1v-3"/>
                    </svg>
                    Download PDF
                </button>
            </div>
        </div>`;
    });

    renderPagination();
}

/*===========================
    PAGINATION
=============================*/
function renderPagination() {
    pagination.innerHTML = "";
    const totalPages = Math.ceil(filteredData.length / PAGE_SIZE);
    if (totalPages <= 1) return;

    // Prev
    const prev = document.createElement("button");
    prev.className   = "page-nav";
    prev.disabled    = currentPage === 1;
    prev.innerHTML   = `<svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M15 19l-7-7 7-7"/></svg> Prev`;
    prev.addEventListener("click", () => goPage(currentPage - 1));
    pagination.appendChild(prev);

    // Page numbers (smart: show max 5, with ellipses)
    const pages = smartPageRange(currentPage, totalPages);
    pages.forEach(p => {
        if (p === "…") {
            const dots = document.createElement("span");
            dots.className   = "page-btn";
            dots.style.cssText = "border:none;background:transparent;color:#94a3b8;cursor:default;font-size:1rem;";
            dots.textContent = "…";
            pagination.appendChild(dots);
        } else {
            const btn = document.createElement("button");
            btn.className = "page-btn" + (p === currentPage ? " active" : "");
            btn.textContent = p;
            btn.addEventListener("click", () => goPage(p));
            pagination.appendChild(btn);
        }
    });

    // Next
    const next = document.createElement("button");
    next.className   = "page-nav";
    next.disabled    = currentPage === totalPages;
    next.innerHTML   = `Next <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M9 5l7 7-7 7"/></svg>`;
    next.addEventListener("click", () => goPage(currentPage + 1));
    pagination.appendChild(next);
}

function smartPageRange(current, total) {
    if (total <= 7) return Array.from({length: total}, (_, i) => i + 1);
    if (current <= 4) return [1, 2, 3, 4, 5, "…", total];
    if (current >= total - 3) return [1, "…", total-4, total-3, total-2, total-1, total];
    return [1, "…", current-1, current, current+1, "…", total];
}

function goPage(page) {
    currentPage = page;
    updateURL();
    update();
    window.scrollTo({ top: document.getElementById("pub-container").offsetTop - 80, behavior: "smooth" });
}

window.changePage = goPage;

/*===========================
    UPDATE PIPELINE
=============================*/
function update() {
    applyFilters();
    render();
    renderYearStrip();       // re-render strip so active pill reflects state
}

/*===========================
    URL SYNC
=============================*/
function updateURL() {
    const url = new URL(window.location);
    url.searchParams.set("page", currentPage);
    url.searchParams.set("year", activeYear);
    window.history.pushState({}, "", url);
}

function applyFiltersFromURL() {
    const params = new URLSearchParams(window.location.search);
    currentPage  = parseInt(params.get("page")) || 1;
    activeYear   = params.get("year") || "all";

    // sync yearOffset so the active year is visible
    if (activeYear !== "all") {
        const idx = allYears.indexOf(Number(activeYear));
        if (idx >= 0) {
            yearOffset = Math.max(0, Math.min(idx, allYears.length - MAX_VISIBLE));
        }
    }

    update();
}

/*===========================
    DOWNLOAD MODAL LOGIC
=============================*/

// Delegated click — works after innerHTML re-renders
document.addEventListener("click", function (e) {
    const btn = e.target.closest(".pdf-download-btn");
    if (btn) {
        const fp = (btn.getAttribute("data-filepath") || "").replace(/\\/g, "/");
        openDownloadModal(fp);
    }
});

function openDownloadModal(filepath) {
    document.getElementById("downloadFilePath").value = filepath;
    const modal = document.getElementById("downloadModal");
    const card  = document.getElementById("downloadModalCard");

    modal.classList.remove("opacity-0", "pointer-events-none");
    setTimeout(() => card.classList.remove("scale-95", "opacity-0"), 10);

    setDownloadMode("whole");
    document.getElementById("startPage").value = "";
    document.getElementById("endPage").value   = "";
}

window.closeDownloadModal = function () {
    const modal = document.getElementById("downloadModal");
    const card  = document.getElementById("downloadModalCard");
    card.classList.add("scale-95", "opacity-0");
    setTimeout(() => modal.classList.add("opacity-0", "pointer-events-none"), 250);
};

// Close on backdrop click
document.getElementById("downloadModal").addEventListener("click", function (e) {
    if (e.target === this) window.closeDownloadModal();
});

function setDownloadMode(mode) {
    const cardWhole  = document.getElementById("card-whole");
    const cardPages  = document.getElementById("card-pages");
    const rangeBox   = document.getElementById("pageRangeInputs");
    const radioWhole = document.getElementById("radio-whole");
    const radioPages = document.getElementById("radio-pages");

    if (mode === "whole") {
        radioWhole.checked = true;
        cardWhole.setAttribute("data-active", "true");
        cardPages.setAttribute("data-active", "false");
        rangeBox.style.maxHeight = "0";
        rangeBox.style.opacity   = "0";
        document.getElementById("startPage").required = false;
        document.getElementById("endPage").required   = false;
    } else {
        radioPages.checked = true;
        cardPages.setAttribute("data-active", "true");
        cardWhole.setAttribute("data-active", "false");
        rangeBox.style.maxHeight = "200px";
        rangeBox.style.opacity   = "1";
        document.getElementById("startPage").required = true;
        document.getElementById("endPage").required   = true;
    }
}

document.getElementById("card-whole").addEventListener("click", () => setDownloadMode("whole"));
document.getElementById("card-pages").addEventListener("click", () => setDownloadMode("pages"));

document.getElementById("downloadForm").addEventListener("submit", async (e) => {
    e.preventDefault();

    const filepath  = document.getElementById("downloadFilePath").value;
    const isWhole   = document.getElementById("radio-whole").checked;
    const submitBtn = document.getElementById("downloadSubmitBtn");
    const spinner   = document.getElementById("downloadSpinner");
    const btnLabel  = document.getElementById("downloadBtnLabel");

    if (isWhole) {
        const a = document.createElement("a");
        a.href = `/download/${encodeURIComponent(filepath).replace(/%2F/g, "/")}`;
        a.download = "";
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
        window.closeDownloadModal();
    } else {
        const startPage = parseInt(document.getElementById("startPage").value);
        const endPage   = parseInt(document.getElementById("endPage").value);

        if (!startPage || !endPage || startPage < 1 || endPage < startPage) {
            alert("Please enter a valid page range (Start page must be ≤ End page).");
            return;
        }

        submitBtn.disabled    = true;
        spinner.classList.remove("hidden");
        btnLabel.textContent  = "Extracting…";

        try {
            const response = await fetch("/publication/extract-pdf", {
                method:  "POST",
                headers: { "Content-Type": "application/json" },
                body:    JSON.stringify({ filepath, start_page: startPage, end_page: endPage })
            });

            if (response.ok) {
                const blob   = await response.blob();
                const url    = window.URL.createObjectURL(blob);
                const header = response.headers.get("Content-Disposition") || "";
                const match  = header.match(/filename[^;=\n]*=(['"]?)([^'"\n;]+)\1/);
                const fname  = match ? match[2].trim() : `pages_${startPage}-${endPage}.pdf`;

                const a = document.createElement("a");
                a.href = url; a.download = fname;
                document.body.appendChild(a);
                a.click();
                document.body.removeChild(a);
                window.URL.revokeObjectURL(url);
                window.closeDownloadModal();
            } else {
                let msg = "Unknown error";
                try { msg = (await response.json()).error || msg; } catch (_) {}
                alert("Download failed: " + msg);
            }
        } catch (err) {
            console.error("Extract error:", err);
            alert("Network error — could not reach server.");
        } finally {
            submitBtn.disabled   = false;
            spinner.classList.add("hidden");
            btnLabel.textContent = "Download Now";
        }
    }
});