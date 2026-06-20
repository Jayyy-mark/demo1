import { api } from "../utils/api.js";
import { getMonthName, getDay } from "../utils/helper.js";

/**/
export const activityApi = {
    async all() {
        const res = await api.get("/frontend/activity/all");
        return res.data.activities;
    },
}

/**/
const DOM = {
    container: document.querySelector("#activity-data-section-body"),
    lastedContainer: document.querySelector("#laseted-activity-list-container"), // Assuming this exists elsewhere
    search: document.querySelector("#activitySearch"),
    yearFilter: document.querySelector("#activityYearFilter"),
    pageInfo: document.querySelector("#pageInfo"),
    paginationControls: document.querySelector("#paginationControls"),
    limitSelect: document.querySelector("#itemsPerPage")
};

let state = {
    allData: [],
    filteredData: [],
    currentPage: 1,
    limit: 9
};

/**/
function getActivityImage(activity, preferredIndex = 0) {
    if (!Array.isArray(activity.images) || activity.images.length === 0) return null;
    return activity.images[preferredIndex]?.filepath || activity.images[0]?.filepath || null;
}

function getActivityUrl(activity) {
    return `/activity/${encodeURIComponent(activity.id)}`;
}

function extractYear(dateString) {
    if (!dateString) return null;
    const year = new Date(dateString).getFullYear();
    return isNaN(year) ? null : year;
}

/**/
const activityUI = {
    renderCards(activities) {
        DOM.container.innerHTML = ""; // Clear existing cards

        if (activities.length === 0) {
            DOM.container.innerHTML = `<div class="col-span-full text-center py-12 text-gray-500">No activities found matching your criteria.</div>`;
            return;
        }

        activities.forEach(activity => {
            const imagePath = getActivityImage(activity, 0);
            
            // YOUR EXACT ORIGINAL CARD HTML (Unchanged)
            const activityCard = imagePath ? `
                <a href="${getActivityUrl(activity)}" class="group block bg-white rounded-[2rem] p-4 shadow-sm hover:shadow-2xl hover:shadow-blue-500/30 transition-all duration-300 border-2 border-gray-300 hover:border-blue-500 hover:-translate-y-2">
                    <div class="flex items-center justify-between px-2 pb-4 pt-1">
                        <div class="flex items-center gap-3">
                            <div class="w-10 h-10 rounded-full bg-blue-50 flex items-center justify-center text-blue-600 overflow-hidden">
                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 7h.01M7 3h5c.512 0 1.024.195 1.414.586l7 7a2 2 0 010 2.828l-7 7a2 2 0 01-2.828 0l-7-7A1.994 1.994 0 013 12V7a4 4 0 014-4z"></path></svg>
                            </div>
                            <div>
                                <p class="text-[11px] text-gray-400 font-medium tracking-wide">Category</p>
                                <p class="text-sm font-bold text-gray-900">${activity.category}</p>
                            </div>
                        </div>
                        
                        <div class="w-px h-8 bg-gray-200"></div>

                        <div class="flex items-center gap-3">
                            <div class="text-right">
                                <p class="text-[11px] text-gray-400 font-medium tracking-wide">Date</p>
                                <p class="text-sm font-bold text-gray-900">${getMonthName(activity.date)} ${getDay(activity.date)}</p>
                            </div>
                            <div class="w-10 h-10 rounded-full bg-orange-50 flex items-center justify-center text-orange-600 overflow-hidden">
                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg>
                            </div>
                        </div>
                    </div>

                    <div class="relative h-64 w-full rounded-2xl overflow-hidden mb-5">
                        <img src="/assets/${imagePath}" alt="${activity.activity_name}" class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-105">
                    </div>

                    <div class="px-2 pb-5 flex items-center">
                        <span class="text-gray-900 font-extrabold text-base truncate"><span class="text-gray-500 mr-1">Activity:</span>${activity.activity_name}</span>
                    </div>

                    <div class="flex items-center justify-end px-2 pb-1">
                        <div class="bg-gray-800 group-hover:bg-blue-600 text-white px-6 py-2.5 rounded-xl text-sm font-bold transition-colors">
                            View Gallery
                        </div>
                    </div>
                </a>
            ` : `
                <a href="${getActivityUrl(activity)}" class="group block bg-white rounded-[2rem] p-4 shadow-sm hover:shadow-2xl hover:shadow-blue-500/30 transition-all duration-300 border-2 border-gray-200 hover:border-blue-500 hover:-translate-y-2 flex flex-col h-full">
                    <div class="flex items-center justify-between px-2 pb-4 pt-1">
                        <div class="flex items-center gap-3">
                            <div class="w-10 h-10 rounded-full bg-blue-50 flex items-center justify-center text-blue-600 overflow-hidden">
                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 7h.01M7 3h5c.512 0 1.024.195 1.414.586l7 7a2 2 0 010 2.828l-7 7a2 2 0 01-2.828 0l-7-7A1.994 1.994 0 013 12V7a4 4 0 014-4z"></path></svg>
                            </div>
                            <div>
                                <p class="text-sm font-bold text-gray-900">${activity.category}</p>
                            </div>
                        </div>
                        
                        <div class="w-px h-8 bg-gray-200"></div>

                        <div class="flex items-center gap-3">
                            <div class="text-right">
                                <p class="text-sm font-bold text-gray-900">${getMonthName(activity.date)} ${getDay(activity.date)}</p>
                            </div>
                            <div class="w-10 h-10 rounded-full bg-orange-50 flex items-center justify-center text-orange-600 overflow-hidden">
                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg>
                            </div>
                        </div>
                    </div>

                    <div class="bg-gray-50 rounded-2xl p-6 mb-5 flex-grow flex flex-col justify-center border border-gray-100 group-hover:bg-blue-50/30 transition-colors h-64">
                        <h3 class="text-xl font-bold text-gray-900 mb-3 line-clamp-2">${activity.activity_name}</h3>
                        <p class="text-sm text-gray-500 line-clamp-3 leading-relaxed">${activity.description}</p>
                    </div>

                    <div class="px-2 pb-5 flex items-center">
                        <span class="text-gray-900 font-extrabold text-base truncate"><span class="text-gray-500 mr-1">Activity:</span>${activity.activity_name}</span>
                    </div>

                    <div class="flex items-center justify-between px-2 pb-1 mt-auto">
                        <div class="flex items-center gap-2 text-gray-800 font-bold text-sm hover:text-blue-600 transition-colors">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 16V4m0 0L3 8m4-4l4 4m6 0v12m0 0l4-4m-4 4l-4-4"></path></svg>
                            <span>Read Story</span>
                        </div>
                        <div class="bg-gray-800 group-hover:bg-blue-600 text-white px-6 py-2.5 rounded-xl text-sm font-bold transition-colors">
                            View Details
                        </div>
                    </div>
                </a>
            `;

            DOM.container.insertAdjacentHTML("beforeend", activityCard);
        });
    },

    renderPagination() {
        const totalPages = Math.ceil(state.filteredData.length / state.limit);
        DOM.paginationControls.innerHTML = "";
        
        if (totalPages === 0) {
            DOM.pageInfo.textContent = "Page 0 of 0";
            return;
        }

        DOM.pageInfo.textContent = `Page ${state.currentPage} of ${totalPages}`;

        // Previous Button
        const prevBtn = document.createElement("button");
        prevBtn.innerHTML = `&laquo;`; // Left double quote/arrow
        prevBtn.className = `w-8 h-8 flex items-center justify-center rounded transition-colors ${state.currentPage === 1 ? 'text-gray-300 cursor-not-allowed' : 'text-gray-600 hover:bg-gray-100'}`;
        prevBtn.onclick = () => { if (state.currentPage > 1) activityEvent.goToPage(state.currentPage - 1); };
        DOM.paginationControls.appendChild(prevBtn);

        // Smart Pagination Logic (1 2 3 ... 9 10)
        let pages = [];
        if (totalPages <= 7) {
            for (let i = 1; i <= totalPages; i++) pages.push(i);
        } else {
            if (state.currentPage <= 4) {
                pages = [1, 2, 3, 4, 5, '...', totalPages];
            } else if (state.currentPage >= totalPages - 3) {
                pages = [1, '...', totalPages - 4, totalPages - 3, totalPages - 2, totalPages - 1, totalPages];
            } else {
                pages = [1, '...', state.currentPage - 1, state.currentPage, state.currentPage + 1, '...', totalPages];
            }
        }

        // Render Page Numbers
        pages.forEach(p => {
            const btn = document.createElement("button");
            if (p === '...') {
                btn.textContent = '...';
                btn.className = "w-8 h-8 flex items-center justify-center text-gray-400 cursor-default";
            } else {
                btn.textContent = p;
                btn.className = `w-8 h-8 flex items-center justify-center rounded text-sm transition-colors ${p === state.currentPage ? 'bg-gray-800 text-white font-bold' : 'text-gray-600 hover:bg-gray-100'}`;
                btn.onclick = () => activityEvent.goToPage(p);
            }
            DOM.paginationControls.appendChild(btn);
        });

        // Next Button
        const nextBtn = document.createElement("button");
        nextBtn.innerHTML = `&raquo;`; // Right double quote/arrow
        nextBtn.className = `w-8 h-8 flex items-center justify-center rounded transition-colors ${state.currentPage === totalPages ? 'text-gray-300 cursor-not-allowed' : 'text-gray-600 hover:bg-gray-100'}`;
        nextBtn.onclick = () => { if (state.currentPage < totalPages) activityEvent.goToPage(state.currentPage + 1); };
        DOM.paginationControls.appendChild(nextBtn);
    },

    populateFilters() {
        const years = new Set();
        state.allData.forEach(item => {
            const y = extractYear(item.date);
            if (y) years.add(y);
        });

        // Sort descending (newest year first)
        Array.from(years).sort((a, b) => b - a).forEach(year => {
            const option = document.createElement("option");
            option.value = year.toString();
            option.textContent = year;
            DOM.yearFilter.appendChild(option);
        });
    }
}

/**/
const activityEvent = {
    async init() {
        if(!DOM.container) return; // Guard clause if elements don't exist

        const data = await activityApi.all();
        state.allData = data;
        
        activityUI.populateFilters();
        this.applyFilters();
        this.bindEvents();
    },

    bindEvents() {
        DOM.search.addEventListener('input', () => this.applyFilters());
        DOM.yearFilter.addEventListener('change', () => this.applyFilters());
        DOM.limitSelect.addEventListener('change', (e) => {
            state.limit = parseInt(e.target.value);
            this.applyFilters();
        });
    },

    applyFilters() {
        const searchTerm = DOM.search.value.toLowerCase().trim();
        const selectedYear = DOM.yearFilter.value;

        state.filteredData = state.allData.filter(item => {
            // Search text matches title or category
            const matchText = item.activity_name?.toLowerCase().includes(searchTerm) || 
                              item.category?.toLowerCase().includes(searchTerm) ||
                              item.description?.toLowerCase().includes(searchTerm);
            
            // Year match
            const itemYear = extractYear(item.date)?.toString();
            const matchYear = selectedYear === 'all' || itemYear === selectedYear;

            return matchText && matchYear;
        });

        state.currentPage = 1; // Reset to first page when filtering
        this.updateView();
    },

    goToPage(pageNumber) {
        state.currentPage = pageNumber;
        this.updateView();
        
        // Optional: Smooth scroll back to top of activities section
        document.getElementById('campus-activities').scrollIntoView({ behavior: 'smooth', block: 'start' });
    },

    updateView() {
        // Calculate pagination slice
        const startIndex = (state.currentPage - 1) * state.limit;
        const endIndex = startIndex + state.limit;
        const paginatedData = state.filteredData.slice(startIndex, endIndex);

        // Render
        activityUI.renderCards(paginatedData);
        activityUI.renderPagination();
    }
}

/*

/*<!--==========================================
    MIAN ENTRY
=============================================*/

document.addEventListener('DOMContentLoaded', function () {
    activityEvent.init();
});
