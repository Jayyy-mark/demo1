import api from "../utils/api.js";

export const calendarApi = {
    async all() {
        const res = await api.get("/academic_calendar/all");
        return res.data;
    },

    async create(data) {
        const res = await api.post("/academic_calendar/create", data);
        return res.data;
    },

    async update(data) {
        const res = await api.put("/academic_calendar/update", data);
        return res.data;
    },

    async delete(id) {
        const res = await api.delete("/academic_calendar/delete", {
            data: { id }
        });
        return res.data;
    }
};
