import { api } from "../utils/api.js";

const activityGalleryAPI = {
    async getByActivityName(activity_id){
        const params = new URLSearchParams({
            id: activity_id
        });
        const res = await api.get(`/frontend/activity/search?${params.toString()}`);
        return res.data.activity;
    }
}



/*<!--===============================
    ACTIVITY UI HANDLER
================================-->*/
const activityGalleryUI= {
    render(activity){
        const activityName = document.querySelector("#activity_name");
        const activityCategory = document.querySelector("#activity_category");
        const description = document.querySelector("#description");
        const activityDate = document.querySelector("#activity_date");
        const imageContainer = document.querySelector("#image-container");

        if (!activity) {
            activityName.innerText = "Activity not found";
            description.innerText = "The activity you are looking for is unavailable.";
            activityDate.innerText = "";
            imageContainer.innerHTML = "";
            return;
        }

        activityName.innerText = activity.activity_name;
        activityCategory.innerText = activity.category;
        description.innerText = activity.description;
        activityDate.innerText = activity.date;
        imageContainer.innerHTML = "";

        if (!Array.isArray(activity.images) || activity.images.length === 0) {
            imageContainer.innerHTML = `
                <div class="lg:col-span-3 bg-white rounded-3xl border border-gray-100 p-10 text-center shadow-sm">
                    <p class="text-sm font-bold text-apple-blue uppercase tracking-widest mb-3">${activity.category}</p>
                    <h2 class="text-2xl font-black text-apple-dark mb-4">${activity.activity_name}</h2>
                    <p class="text-gray-500 max-w-2xl mx-auto">${activity.description}</p>
                </div>
            `;
            return;
        }

        activity.images.forEach(image => {
            const row =`
                <div class="group relative aspect-[4/3] rounded-2xl overflow-hidden shadow-md hover:shadow-2xl transition-all duration-300">
                    <img src="/assets/${image.filepath}" alt="${activity.activity_name}" class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110 cursor-zoom-in">
                    <div class="absolute inset-0 bg-black/0 group-hover:bg-black/5 transition-colors"></div>
                </div>
            `;

            imageContainer.insertAdjacentHTML("beforeend", row);
        });
    }
}

const activityGalleryEvent = {
    init(){
        this.load();

        $("#btn_backToActivities").on("click", function(event){
            event.preventDefault();
            window.history.go(-1);
        });
    },
    async load(){

        const activity_id = document.querySelector("#activity_id").value;
        const activities = await activityGalleryAPI.getByActivityName(activity_id);
        const activity = Array.isArray(activities) ? activities[0] : activities;
        activityGalleryUI.render(activity);

    }
}



document.addEventListener("DOMContentLoaded", function(){
    activityGalleryEvent.init();
});
