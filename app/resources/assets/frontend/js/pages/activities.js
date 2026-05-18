import { api } from "../utils/api.js";
import { getMonthName, getDay } from "../utils/helper.js";

/*<!--===========================
    GET ACTIVITES
=============================-->*/

const activityApi = {
    async all(){
        const res = await api.get("/frontend/activity/all");
        return res.data.activities;
    }
}

/*<!--====================================
    ACTIVITY UI HAHNDLER
=======================================-->*/


const activityContainer = document.querySelector("#activity-data-section-body");
const lastedActivityListContainer = document.querySelector("#laseted-activity-list-container");

const activityUI = {
    render(activities){
        activities.forEach(activity => {
            const activityCard = `
                <a href="/activity/1" class="group block bg-white rounded-3xl overflow-hidden shadow-sm hover:shadow-2xl transition-all duration-300 hover:-translate-y-2 cursor-pointer">
                    <div class="relative h-64 overflow-hidden">
                        <img src="assets/${activity.images[1].filepath}" alt="Race" class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-105">
                        <div class="absolute inset-0 bg-black/0 group-hover:bg-black/10 transition-colors duration-300"></div>
                        <span class="absolute top-4 left-4 bg-white/90 backdrop-blur text-xs font-bold text-apple-blue uppercase tracking-wider px-3 py-1 rounded-full">${activity.category}</span>
                    </div>
                    <div class="p-8">
                        <h3 class="text-xl font-bold text-apple-dark mb-2 group-hover:text-apple-blue transition-colors">${activity.activity_name}</h3>
                        <p class="text-gray-500 text-sm leading-relaxed mb-4">${activity.description}</p>
                        <div class="flex items-center text-sm font-semibold text-apple-blue"><span>View Gallery</span></div>
                    </div>
                </a>
            `;

            activityContainer.insertAdjacentHTML("beforeend", activityCard);
        });
    },
    renderLastedActivities(activities){

        activities.forEach((a, index) => {

            const flexClass = index % 2 === 0
            ? "md:flex-row"
            : "md:flex-row-reverse";

            const BadgeClass = index % 2 === 0 
            ? "-left-6"
            : "-right-6";

            const row = `
            <div class="news-item group flex flex-col ${flexClass} gap-12 items-center">

                    <!-- Image Side -->
                    <div class="w-full md:w-1/2 relative">
                        <div class="aspect-[16/10] overflow-hidden rounded-[2rem] shadow-2xl transition-transform duration-500 group-hover:scale-[1.02]">
                            <img src="assets/${a.images[0].filepath}" alt="${a.activity_name}" class="w-full h-full object-cover">
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
                        <a href="" class="inline-flex items-center gap-3 text-apple-dark font-black hover:text-apple-blue transition-colors group/link">
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
    init(){
        this.load();
    },
    async load(){
        const activities = await activityApi.all();
        activityUI.render(activities);
        activityUI.renderLastedActivities(activities);
    }
}

/*<!--==========================================
    MIAN ENTRY
=============================================*/

document.addEventListener('DOMContentLoaded', function(){
    activityEvent.init();
});