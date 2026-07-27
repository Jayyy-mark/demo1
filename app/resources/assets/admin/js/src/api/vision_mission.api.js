/*<!--====================================
 VISION MISSION API
=====================================-->*/

import api from "../utils/api.js";

export const visionMissionAPI = {
    async all() {
        const res = await api.get("/vision-mission/all");
        return res.data;
    },
    async create(data) {
        const res = await api.post("/vision-mission/create", {
            vision: data.vision,
            mission: data.mission,
            language: data.language,
            department_id: data.department_id
        });
        return res.data;
    },
    async update(data) {
        const res = await api.put("/vision-mission/update", {
            id: data.id,
            vision: data.vision,
            mission: data.mission,
            language: data.language,
            department_id: data.department_id
        });
        return res.data;
    },
    async delete(id) {
        const res = await api.delete("/vision-mission/delete", {
            data: { id }
        });
        return res.data;
    }
}
