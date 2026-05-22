import { api } from "../utils/api.js";
import { getMonthName, getDay, getYear } from "../utils/helper.js";

/*<!--===========================
    GET ACTIVITES
=============================-->*/

const researchApi = {
    async allLaboratories(){
        const res = await api.get("/frontend/laboratory/all");
        return res.data.laboratories;
    }
}

/*<!--====================================
    UI HAHNDLER
=======================================-->*/
const laboratoryContainer = document.querySelector("#lab-card-container");

function getLaboratoryUrl(laboratory) {
    return `/research/laboratory/${encodeURIComponent(laboratory.id)}`;
}

const researchUI = {
    renderLaboratories(laboratories){
        laboratories.forEach(laboratory => {
            const laboratoryCard = `
                <div class="group flex flex-col bg-white rounded-3xl border border-slate-200 overflow-hidden shadow-sm hover:shadow-2xl transition-all duration-500">
                    <div class="h-52 overflow-hidden relative">
                        <img src="assets/${laboratory.images[0].filepath}" alt="AI Lab" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-700">
                        <div class="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent opacity-0 group-hover:opacity-100 transition-opacity"></div>
                    </div>
                    <div class="p-6 flex-grow">
                        <h3 class="text-xl font-bold text-slate-900 mb-3">${laboratory.laboratory_name}</h3>
                        <p class="text-sm text-slate-500 leading-relaxed mb-6">${laboratory.description}</p>
                        <a href="${getLaboratoryUrl(laboratory)}" class="inline-flex items-center text-blue-600 font-bold text-sm group/btn">
                            VIEW LAB DETAILS
                            <svg class="ml-2 w-4 h-4 transform group-hover/btn:translate-x-2 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 8l4 4m0 0l-4 4m4-4H3"></path></svg>
                        </a>
                    </div>
                </div>
            `;

            laboratoryContainer.insertAdjacentHTML("beforeend", laboratoryCard);
        });
    },
}


const researchEvent = {
    init(){
        this.load();
    },
    async load(){
        const laboratories = await researchApi.allLaboratories();
        researchUI.renderLaboratories(laboratories);
    }
}

/*<!--==========================================
    MIAN ENTRY
=============================================*/

document.addEventListener('DOMContentLoaded', function(){
    researchEvent.init();
});
