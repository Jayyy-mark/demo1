import { api } from "../utils/api.js";
import { getMonthName, getDay, getYear } from "../utils/helper.js";

/*<!--===========================
    GET ACTIVITES
=============================-->*/

const researchApi = {
    async allResearches(){
        const res = await api.get("/frontend/research/all");
        return res.data.researches;
    },
    async allLaboratories(){
        const res = await api.get("/frontend/laboratory/all");
        return res.data.laboratories;
    }
}

/*<!--====================================
    UI HAHNDLER
=======================================-->*/
const laboratoryContainer = document.querySelector("#lab-card-container");
const pubContainer = document.querySelector("#pub-container");
const viewMoreBtn = document.querySelector("#view-more-btn");
// const lastedresearchListContainer = document.querySelector("#laseted-research-list-container");

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
    renderPublications(researches){
        researches.forEach((research, index)=>{

            const hiddenClass = index > 3 ? "hidden" : "";
            const descriptionId = `publication-description-${index}`;

            const card = `
                <div class="pub-card ${hiddenClass} bg-white border border-slate-100 rounded-2xl p-7 shadow-sm hover:shadow-xl transition-all flex flex-col">
                    <div class="flex justify-between items-start mb-4">
                        <span class="px-3 py-1 bg-blue-50 text-blue-600 text-[10px] font-black rounded-lg uppercase tracking-widest">${research.category}</span>
                        <span class="text-slate-400 font-bold text-sm">${getYear(research.date)}</span>
                    </div>
                    <h3 class="text-xl font-bold text-slate-900 mb-4 h-14 line-clamp-2">${research.research_name}</h3>
                    <div class="flex-grow">
                        <p id="${descriptionId}" class="text-slate-600 text-sm leading-relaxed overflow-hidden max-h-10 transition-all duration-300">
                            This research paper focuses on optimizing YOLO-based architectures for lower-end hardware, specifically focusing on low-light surveillance imagery.
                        </p>
                        <button onclick="togglePub('${descriptionId}', this)" class="text-blue-600 text-xs font-bold mt-2 hover:underline">READ MORE</button>
                    </div>
                    <div class="mt-8 pt-5 border-t border-slate-50 flex items-center justify-between">
                        
                        <a href="assets/${research.filepath}" download class="flex items-center gap-2 text-xs font-bold bg-slate-900 text-white px-4 py-2 rounded-lg hover:bg-blue-600 transition">
                            PDF
                        </a>
                    </div>
                </div>
            `;

            pubContainer.insertAdjacentHTML("beforeend", card);
        });
        this.setupViewMore();
    },
    setupViewMore(){
        if (!viewMoreBtn) return;

        const cards = Array.from(document.querySelectorAll(".pub-card"));
        viewMoreBtn.style.display = cards.length > 4 ? "inline-block" : "none";

        viewMoreBtn.onclick = () => {
            const hiddenCards = cards.filter(card => card.classList.contains("hidden"));

            hiddenCards.slice(0, 2).forEach(card => {
                card.classList.remove("hidden");
                card.classList.add("animate-fade-in");
            });

            const hasHiddenCards = cards.some(card => card.classList.contains("hidden"));
            viewMoreBtn.style.display = hasHiddenCards ? "inline-block" : "none";
        };
    }

}


const researchEvent = {
    init(){
        this.load();
    },
    async load(){
        const laboratories = await researchApi.allLaboratories();
        researchUI.renderLaboratories(laboratories);

        const researches = await researchApi.allResearches();
        researchUI.renderPublications(researches);

    }
}

/*<!--==========================================
    MIAN ENTRY
=============================================*/

document.addEventListener('DOMContentLoaded', function(){
    researchEvent.init();
});
