/*<!--===============================
    CHATBOT API
==================================-->*/
import  api  from "../utils/api.js";

export const chatBotAPi = {
    async sendMessage(userMessage){
        const res = await api.post("/chatbot/ask", {
            "message" : userMessage
        });
        return res.data;
    },
    async updateKB(form){
        const res = await api.put("/chatbot/memory/update",form);
        return res.data;
    }
}