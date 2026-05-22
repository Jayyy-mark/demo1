import { api } from "../utils/api.js";
import { getMonthName, getDay, getYear } from "../utils/helper.js";

/*<!--===========================
    GET ACTIVITES
=============================-->*/

const publicationApi = {
    async allResearches(){
        const res = await api.get("/frontend/research/all");
        return res.data.researches;
    },
}

/*<!--====================================
    UI HAHNDLER
=======================================-->*/
const pubContainer = document.querySelector("#pub-container");
const viewMoreBtn = document.querySelector("#view-more-btn");
// const lastedresearchListContainer = document.querySelector("#laseted-research-list-container");


const publicationUI = {
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


const publicationEvent = {
    init(){
        this.load();
    },
    async load(){

        const researches = await publicationApi.allResearches();
        publicationUI.renderPublications(researches);

    }
}

/*<!--==========================================
    MIAN ENTRY
=============================================*/

document.addEventListener('DOMContentLoaded', function(){
    publicationEvent.init();
});
