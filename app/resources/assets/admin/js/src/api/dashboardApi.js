import api from "../utils/api.js";



export const dashboardApi = {
    async summary() {
        const res = await api.get("/dashboard/all");
        return res.data;
    },
    async updateCounts(data) {
        const res = await api.put("/dashboard/counts/update", data);
        return res.data;
    },
    async create(data) {
        console.log("this is data : ", data);
        const res = await api.post("/dashboard/create", {
            attr_key: data.attr_key,
            value: data.value
        });
        return res.data;
    },
    async update(data) {
        const res = await api.put("/dashboard/update", {
            id: data.id,
            attr_key: "recot_message",
            value: "this is recot's message"
        });
        return res.data;
    },
    async delete(id) {
        const res = await api.delete("/dashboard/delete", {
            data: { id }
        });
        return res.data;
    },
    async addAdmissionList(data) {

        console.log("function entered")
        const form = new FormData();
        console.log("this is file ", data.file);
        form.append("file", data.file);

        const res = await api.post("/dashboard/admissionList/create", form);
        console.log("this is response : ", res);
        return res.data;
    },
    async editAdmssionList(data) {

        const form = new FormData();

        form.append("id", data.id);
        form.append("file", data.file);

        const res = await api.put("/dashboard/admissionList/update", form);
        return res.data;

    },
    async deleteAdmissionList(id) {

        const res = await api.delete("/dashboard/admissionList/delete", {
            data: { id }
        });

        return res.data;
    },
    async updateTopbarInfo(data) {
        const res = await api.put("/dashboard/topbar/update", {
            school_open_date: data.school_open_date,
            phone_number: data.phone_number,
            email: data.email,
        });
        return res.data;
    },

}