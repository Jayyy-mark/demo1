import { api } from "../utils/api.js";
import { getMonthName, getDay } from "../utils/helper.js";

/*<!--===========================
    GET ACTIVITES
=============================-->*/

export const activityApi = {
    async all() {
        const res = await api.get("/frontend/activity/all");
        return res.data.activities;
    },
}

/*<!--====================================
    ACTIVITY UI HAHNDLER
=======================================-->*/


const activityContainer = document.querySelector("#activity-data-section-body");
const lastedActivityListContainer = document.querySelector("#laseted-activity-list-container");

function getActivityImage(activity, preferredIndex = 0) {
    if (!Array.isArray(activity.images) || activity.images.length === 0) {
        return null;
    }

    return activity.images[preferredIndex]?.filepath || activity.images[0]?.filepath || null;
}

function getActivityUrl(activity) {
    return `/activity/${encodeURIComponent(activity.id)}`;
}

const activityUI = {
    render(activities) {
        activities.forEach(activity => {
            const imagePath = getActivityImage(activity, 1);
            const activityCard = imagePath ? `
                <a href="${getActivityUrl(activity)}" class="group block bg-white rounded-[2rem] p-4 shadow-sm hover:shadow-2xl hover:shadow-blue-500/30 transition-all duration-300 border-2 border-gray-200 hover:border-blue-500 hover:-translate-y-2">
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

                    <div class="flex items-center justify-between px-2 pb-1">
                        <div class="flex items-center gap-2 text-gray-800 font-bold text-sm hover:text-blue-600 transition-colors">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 16V4m0 0L3 8m4-4l4 4m6 0v12m0 0l4-4m-4 4l-4-4"></path></svg>
                            <span>Read Story</span>
                        </div>
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

            activityContainer.insertAdjacentHTML("beforeend", activityCard);
        });
    },
    renderLastedActivities(activities) {

        activities.forEach((a, index) => {

            const flexClass = index % 2 === 0
                ? "md:flex-row"
                : "md:flex-row-reverse";

            const BadgeClass = index % 2 === 0
                ? "-left-6"
                : "-right-6";

            const imagePath = getActivityImage(a);
            const row = imagePath ? `
            <div class="news-item group flex flex-col ${flexClass} gap-12 items-center">

                    <!-- Image Side -->
                    <div class="w-full md:w-1/2 relative">
                        <div class="aspect-[16/10] overflow-hidden rounded-[2rem] shadow-2xl transition-transform duration-500 group-hover:scale-[1.02]">
                            <img src="/assets/${imagePath}" alt="${a.activity_name}" class="w-full h-full object-cover">
                        </div>
                        <!-- Date Badge -->
                        <div class="absolute -bottom-6 ${BadgeClass} bg-apple-blue text-white p-5 rounded-2xl shadow-xl min-w-[80px] text-center">
                            <span class="block text-2xl font-black leading-none">${getMonthName(a.date)}</span>
                            <span class="text-[10px] font-black opacity-80 uppercase tracking-wider">${getDay(a.date)}</span>
                        </div>
                    </div>

                    <!-- Text Side -->
                    <div class="w-full md:w-1/2 space-y-6">
                        <span class="text-apple-blue font-black text-xs tracking-[0.2em] uppercase">${a.category}</span>
                        <h3 class="text-3xl md:text-4xl font-bold text-apple-dark leading-tight line-clamp-2">${a.activity_name}</h3>
                        <p class="text-gray-500 text-lg leading-relaxed line-clamp-3">${a.description}</p>
                        <a href="${getActivityUrl(a)}" class="inline-flex items-center gap-3 text-apple-dark font-black hover:text-apple-blue transition-colors group/link">
                            CONTINUE READING
                            <span class="w-10 h-10 rounded-full border border-gray-200 flex items-center justify-center group-hover/link:bg-apple-blue group-hover/link:text-white transition-all duration-300">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3"></path></svg>
                            </span>
                        </a>
                    </div>
                </div>
            ` : `
                <div class="news-item group flex flex-col ${flexClass} gap-12 items-center">
                    <div class="w-full md:w-1/2 relative">
                        <div class="aspect-[16/10] rounded-[2rem] shadow-2xl bg-white border border-gray-100 p-8 flex flex-col justify-between transition-transform duration-500 group-hover:scale-[1.02]">
                            <span class="text-apple-blue font-black text-xs tracking-[0.2em] uppercase">${a.category}</span>
                            <h3 class="text-2xl md:text-3xl font-black text-apple-dark leading-tight line-clamp-2">${a.activity_name}</h3>
                        </div>
                        <div class="absolute -bottom-6 ${BadgeClass} bg-apple-blue text-white p-5 rounded-2xl shadow-xl min-w-[80px] text-center">
                            <span class="block text-2xl font-black leading-none">${getMonthName(a.date)}</span>
                            <span class="text-[10px] font-black opacity-80 uppercase tracking-wider">${getDay(a.date)}</span>
                        </div>
                    </div>

                    <div class="w-full md:w-1/2 space-y-6">
                        <span class="text-apple-blue font-black text-xs tracking-[0.2em] uppercase">${a.category}</span>
                        <h3 class="text-3xl md:text-4xl font-bold text-apple-dark leading-tight line-clamp-2">${a.activity_name}</h3>
                        <p class="text-gray-500 text-lg leading-relaxed line-clamp-3">${a.description}</p>
                        <a href="${getActivityUrl(a)}" class="inline-flex items-center gap-3 text-apple-dark font-black hover:text-apple-blue transition-colors group/link">
                            CONTINUE READING
                            <span class="w-10 h-10 rounded-full border border-gray-200 flex items-center justify-center group-hover/link:bg-apple-blue group-hover/link:text-white transition-all duration-300">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3"></path></svg>
                            </span>
                        </a>
                    </div>
                </div>
            `;

            lastedActivityListContainer.insertAdjacentHTML("beforeend", row);
        });
    }
}


const activityEvent = {
    init() {
        this.load();
    },
    async load() {
        const activities = await activityApi.all();
        activityUI.render(activities);
    }
}

/*<!--==========================================
    MIAN ENTRY
=============================================*/

document.addEventListener('DOMContentLoaded', function () {
    activityEvent.init();
});
