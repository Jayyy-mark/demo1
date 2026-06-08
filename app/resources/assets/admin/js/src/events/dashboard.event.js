import { dashboardApi } from "../api/dashboardApi.js";
import { toast } from "../utils/toast.js";
import { dashboardUI } from "../ui/dashboard.ui.js";
import { Utils } from "../utils/utils.js";

export const dashboardEvent = {
    init() {
        this.loadData();
        
        $("#add-rector-message-btn").on("click", async function(){
            const data = {
                "attr_key" : "Rector's Message",
                "value" : $("#rector-message-form").find("textarea").val()
            }
            console.log("this is value : ", data);

            try{
                const response = await dashboardApi.create(data);
                toast.success(response.message);
                Utils.refresh();
            }catch(error){
                console.log("Error");
                toast.error(response.message);
            }

        });

    },
    async loadData() {
        try {
            const res = await dashboardApi.summary();
            dashboardUI.render(res.data);
        } catch (error) {
            console.error("Error loading dashboard data:", error);
            toast.error("Failed to load dashboard data.");
        }
    }
}
