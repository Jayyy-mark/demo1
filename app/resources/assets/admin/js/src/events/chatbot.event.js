/*<!--====================================
    CHATBOT EVENTS HANDLER
========================================-->*/
import { chatBotAPi } from "../api/chatBot.api.js";
import { toast } from "../utils/toast.js";
import { Utils } from "../utils/utils.js";



export const chatbotEvent = {
    init(){

        /*<!--==============================
            UPDATE KB EVNET
        ===============================-->*/
        $("#btnUploadKnowledge").on("click", ()=>{
            this.updateKnowledgeBase();
        });

    },
    async updateKnowledgeBase(){
        const form = new FormData(
            document.querySelector("#knowledgeForm")
        );

        try {

            const data = await chatBotAPi.updateKB(form);
            await toast.success(data.message);
            Utils.refresh();

        } catch (error) {

            console.log("Error : ", error);
            await toast.error( 
                error?.message || "Failed to update KB" 
            );

        }
    }
}