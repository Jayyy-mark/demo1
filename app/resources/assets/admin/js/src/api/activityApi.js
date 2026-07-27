/*<!--============================
    ACTIVITY API HANDLER
==============================-->*/
import api from "../utils/api.js";

export const activityApi = {
    async create(data) {
        const form = new FormData();
        for (let i = 0; i < data.file.length; i++) {
            form.append("file", data.file[i]);
        }
        form.append("activity_name", data.activity_name);
        form.append("activity_type", data.activity_type);
        form.append("category", data.category);
        form.append("description", data.description);
        form.append("date", data.date);
        console.log("this is final activity data : ", data);
        const res = await api.post("/activity/create",
            form
        );
        return res.data;
    },
    async update(data) {
        const form = new FormData();
        form.append("id", data.id);
        form.append("file", data.file);
        form.append("activity_name", data.activity_name);
        form.append("activity_type", data.activity_type);
        form.append("category", data.category);
        form.append("description", data.description);
        form.append("date", data.date);

        const res = await api.put("/activity/update", form);

        return res.data;
    },
    async delete(id) {
        const res = await api.delete(`activity/delete`, {
            data: { id }
        })
        return res.data;
    },
    async all() {
        const res = await api.get("/activity/all");
        return res.data;
    },

    async categories() {
        const res = await api.get("/activity/categories");
        return res.data;
    },

    // ─── Group-aware methods ──────────────────────────────────────
    /**
     * Update all rows sharing the same activity_name.
     * @param {object} fields       - { original_name, activity_name, category, activity_type, description, date }
     * @param {number[]} idsToDelete - IDs of image-rows to permanently delete
     * @param {File[]} newFiles      - newly selected image files to append
     */
    async updateByName(fields, idsToDelete = [], newFiles = []) {
        const form = new FormData();
        form.append("original_name",  fields.original_name);
        form.append("activity_name",  fields.activity_name);
        form.append("activity_type",  fields.activity_type);
        form.append("category",       fields.category);
        form.append("description",    fields.description);
        form.append("date",           fields.date);
        form.append("ids_to_delete",  JSON.stringify(idsToDelete));
        for (const f of newFiles) {
            form.append("new_files", f);
        }
        const res = await api.put("/activity/update-by-name", form);
        return res.data;
    },

    /**
     * Delete ALL rows for a given activity_name.
     * @param {string} activityName
     */
    async deleteByName(activityName) {
        const res = await api.delete("/activity/delete-by-name", {
            data: { activity_name: activityName }
        });
        return res.data;
    },
}