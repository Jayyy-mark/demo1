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
}


const researchEvent = {
    init(){
        this.load();
    },
    async load(){
        const activities = await homeApi.fetchLastedActivities();
        researchUI.renderActivities(activities);

    }
}

/*<!--==========================================
    MIAN ENTRY
=============================================*/

document.addEventListener('DOMContentLoaded', function(){
    researchEvent.init();
});
