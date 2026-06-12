/*<!--========================================
    FETCH COLLABORATIONS API (DATA)
=========================================-->*/
import { api } from "../utils/api.js";

const collaborationAPI = {
    async getCollaborations(){
        const res = await api.get("/frontend/collaboration/all");
        return res.data.collaborations;
    }
};


/*<!--========================================
    COLLABORATIONS UI HANDLER
=========================================-->*/
const collaborationContainer = document.querySelector("#partners-grid");

const collaborationUI = {

    renderCollaborations(collaborations){

        collaborationContainer.innerHTML = "";

        const cards = collaborations.map( (c,index)=> `
            <div class="partner-item ${index >= 3 ? 'hidden' : ''} flex flex-col justify-between bg-white border border-gray-100 rounded-2xl p-6 shadow-sm hover:shadow-xl hover:-translate-y-1.5 transition-all duration-300 transform">
                <div>
                    <!-- Cleaned Logo Wrapper (Removed border and grayscale) -->
                    <div class="h-24 w-full bg-slate-50 rounded-xl flex items-center justify-center p-4 mb-5">
                        <img src="/assets/media/collaborations/${c.logo}" alt="${c.company_name}" class="max-h-full max-w-[85%] object-contain transition-all duration-300">
                    </div>
                    <!-- Partner Info -->
                    <h3 class="text-xl font-bold text-slate-800 mb-2 hover:text-blue-800 transition-colors">${c.company_name}</h3>
                    <p class="text-gray-600 text-sm leading-relaxed line-clamp-3">
                        ${c.description}
                    </p>
                </div>
                <!-- Action Button -->
                <div class="mt-6 pt-4 border-t border-gray-50 flex justify-between items-center">
                    <span class="text-xs font-medium text-amber-600 bg-amber-50 px-2.5 py-1 rounded-full">Industry</span>
                    <a href="${c.url}" class="text-sm font-semibold text-blue-700 hover:text-amber-500 flex items-center gap-1 group/link">
                        Visit Website
                        <svg class="w-4 h-4 transform group-hover/link:translate-x-1 transition-transform" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M14 5l7 7m0 0l-7 7m7-7H3"></path></svg>
                    </a>
                </div>
            </div>            
            
        ` ).join('');

        collaborationContainer.insertAdjacentHTML("beforeend", cards);

    }
}

/*<!--========================================
    COLLABORATIONS EVENTS HANDLER
=========================================-->*/


const collaborationEvent = {
    init(){

        this.load();

    },
    async load(){
        const collaborations =  await collaborationAPI.getCollaborations();
        console.log("this is collaboration data : ", collaborations); 
        collaborationUI.renderCollaborations(collaborations);

        this.setupPartnerButton();
    },
    setupPartnerButton() {
        const partnerBtn = document.getElementById('load-more-partners');
        const partnerItems = document.querySelectorAll('.partner-item');

        if (!partnerBtn) return;

        // hide button if not needed
        if (partnerItems.length <= 3) {
            partnerBtn.style.display = 'none';
            return;
        }

        partnerBtn.style.display = 'inline-flex';

        partnerBtn.onclick = () => {
            const hiddenItems = Array.from(partnerItems).filter(
                item => item.classList.contains('hidden')
            );

            hiddenItems.slice(0, 3).forEach(item => {
                item.classList.remove('hidden');
                item.classList.add('animate-slide-up');
            });

            const stillHidden = Array.from(partnerItems).some(
                item => item.classList.contains('hidden')
            );

            if (!stillHidden) {
                partnerBtn.style.display = 'none';
            }
        };
    }
}


document.addEventListener('DOMContentLoaded', function() {

    collaborationEvent.init();

});