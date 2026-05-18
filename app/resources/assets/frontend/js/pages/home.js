import { api } from "../utils/api.js";
import { getMonthName, getDay, getYear } from "../utils/helper.js";

/*<!--===========================
    GET ACTIVITES
=============================-->*/

const homeApi = {
    async fetchLastedActivities(){
        const res = await api.get("/frontend/home/activity");
        return res.data.activities;
    },
    async fetchLastedPublications(){
        const res = await api.get("/frontend/home/research");
        return res.data.researches;
    }
}

/*<!--====================================
    UI HAHNDLER
=======================================-->*/
const activityContainer = document.querySelector("#activity-card-container");
const pubContainer = document.querySelector("#pub-container");

function getActivityUrl(activity) {
    return `/activity/${encodeURIComponent(activity.id)}`;
}

const researchUI = {
    renderActivities(activities){
        activities.forEach(activity => {
            const activityCard = `
                <a href="${getActivityUrl(activity)}" class="group block bg-white rounded-3xl overflow-hidden shadow-sm hover:shadow-2xl transition-all duration-300 hover:-translate-y-2 cursor-pointer">
                    <div class="relative h-64 overflow-hidden">
                        <img src="assets/${activity.images[0].filepath}" alt="Race" class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-105">
                        <div class="absolute inset-0 bg-black/0 group-hover:bg-black/10 transition-colors duration-300"></div>
                        <span class="absolute top-4 left-4 bg-white/90 backdrop-blur text-xs font-bold text-apple-blue uppercase tracking-wider px-3 py-1 rounded-full">Projects</span>
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
    renderPublications(researches){
        researches.forEach((research, index)=>{

            const card = `
                <div class="bg-white p-6 rounded-2xl border border-gray-200 hover:-translate-y-1 transition-transform duration-300 shadow-sm flex flex-col justify-between">
                    <div>
                        <span class="text-xs font-semibold text-gray-400 uppercase tracking-wider">${research.category}</span>
                        <h4 class="mt-2 text-lg font-medium text-gray-900">${research.date}</h4>
                        <p class="mt-2 text-sm text-gray-500 mb-6">${research.research_name}</p>
                    </div>
                    <!-- Download Button -->
                    <a href="assets/${research.filepath}" download class="inline-flex items-center justify-center gap-2 px-4 py-2.5 bg-slate-50 border border-slate-200 hover:bg-apple-dark hover:text-white rounded-xl text-xs font-bold text-apple-dark transition-all duration-300 group">
                        <svg class="w-4 h-4 text-slate-400 group-hover:text-white transition-colors" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M3 16.5v2.25A2.25 2.25 0 0 0 5.25 21h13.5A2.25 2.25 0 0 0 21 18.75V16.5M16.5 12 12 16.5m0 0L7.5 12m4.5 4.5V3"></path>
                        </svg>
                        DOWNLOAD PDF
                    </a>
                </div>
            `;

            pubContainer.insertAdjacentHTML("beforeend", card);
        });
    },
}


const researchEvent = {
    init(){
        this.load();
    },
    async load(){
        const activities = await homeApi.fetchLastedActivities();
        researchUI.renderActivities(activities);

        const researches = await homeApi.fetchLastedPublications();
        researchUI.renderPublications(researches);

    }
}

/*<!--==========================================
    MIAN ENTRY
=============================================*/

document.addEventListener('DOMContentLoaded', function(){
    researchEvent.init();
});
