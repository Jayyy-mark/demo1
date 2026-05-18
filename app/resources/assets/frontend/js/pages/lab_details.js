import { api } from "../utils/api.js";


/*<!--===================================
    GET LABORATORIES DATA
======================================-->*/

const laboratoryDetailApi = {
    async getLaboratoryById(id){
        const params = new URLSearchParams({
            id:id
        });

        const res = await api.get(`/frontend/laboratory/search?${params.toString()}`);

        return res.data.laboratory;

    }
}


const laboratoryDetailUI = {
    render(laboratory){
        const laboratoryName = document.querySelector("#laboratory_name");
        const imageContainer = document.querySelector("#image_container");
  
        laboratoryName.innerText = laboratory[0].laboratory_name;

        laboratory[0].images.forEach((image, index) => {
            const length = laboratory[0].images.length;
    
            const imgClass = (index < 1 || length < 3 ) && "col-span-2 row-span-2 ";

            const row =`
                <div class="${imgClass} relative group overflow-hidden rounded-3xl cursor-pointer" onclick="openModal('/assets/${image.filepath}')">
                    <img src="/assets/${image.filepath}" class="w-full h-full object-cover transition duration-500 group-hover:scale-110" alt="Lab Pic">
                    <div class="absolute inset-0 bg-black/20 group-hover:bg-black/0 transition-all"></div>
                </div>
            `;

            imageContainer.insertAdjacentHTML("beforeend", row);
        });

        
    }
}

const laboratoryDetailEvent = {
    init(){
        this.load();
    },
    async load(){
        const laboratory_id = document.querySelector("#laboratory_id").value;
        console.log("this is laboratory id")
        const laboratory = await laboratoryDetailApi.getLaboratoryById(laboratory_id);
        laboratoryDetailUI.render(laboratory);
    }
}

/*<!--===========================================
    MAIN ENTRY
==============================================-->*/

document.addEventListener("DOMContentLoaded", function(){
    laboratoryDetailEvent.init();
});