/*<!--==========================
    VISION MISSION EVENTS
=============================-->*/
import { visionMissionAPI } from "../api/vision_mission.api.js";
import { visionMissionUI } from "../ui/vision_mission.ui.js";
import { toast } from "../utils/toast.js";
import { VisionMission } from "../interfaces/vision_mission.js";
import { navigate } from "../utils/navigate.js";
import { academicHelper } from "../helpers/academic.helper.js";

import { FormValidation } from "../validations/form_validations.js";
export const visionMissionEvent = {
    delete_id: "",

    init() {
        this.addValidation = new FormValidation("dataForm-vision_mission");
        this.updateValidation = new FormValidation("dataForm-vision_mission-update");


        this.load();

        $("#save_vision_mission_btn").on("click", () => this.create());

        $("#update_vision_mission_btn").on("click", () => this.update());

        $("#btn_delete_vision_mission").on("click", () => this.delete());

        $(document).on('click', '.show-vision-modal', function () {
            const vision = $(this).data('vision');
            $('#fullVision').val(vision);
            const modal = new bootstrap.Modal(document.getElementById('visionModal'));
            modal.show();
        });

        $(document).on('click', '.show-mission-modal', function () {
            const mission = $(this).data('mission');
            $('#fullMission').val(mission);
            const modal = new bootstrap.Modal(document.getElementById('missionModal'));
            modal.show();
        });

        $(document).on("click", ".show-update-modal-vision_mission", (event) => this.showUpdateModal(event));

        $(document).on("click", ".show-delete-modal-vision_mission", (event) => this.showDeleteModal(event));

    },
    async load() {
        try {
            const response = await visionMissionAPI.all();
            visionMissionUI.render(response.data);

            const departments = await academicHelper.getDepartments();

            visionMissionUI.setDepartments(departments.data, "department_name", $("#dataForm-vision_mission-update").find("#department-update")[0]);
            visionMissionUI.setDepartments(departments.data, "department_name", $("#dataForm-vision_mission").find("#department")[0]);

        } catch (error) {
            console.log("error : ", error);
            toast.error("Failed to load Vision & Mission.");
        }
    },
    async create() {
        if (this.addValidation) {
            const result = this.addValidation.validateAll();
            if (!result.valid) {
                const firstError = Object.values(result.errors)[0];
                toast.error(firstError);
                return;
            }
        }

        const form = $("#dataForm-vision_mission");
        const visionMission = new VisionMission();

        form.find("[name]").each(function () {
            const key = $(this).attr("name");
            const value = $(this).val();

            visionMission.set(key, value);
        });

        try {
            const response = await visionMissionAPI.create(visionMission);
            await toast.success(response.message);
            navigate.refresh();

        } catch (error) {
            console.log("error : ", error);
            await toast.error(error?.message || "Failed to create Vision & Mission.");
        }
    },
    async update() {
        if (this.updateValidation) {
            const result = this.updateValidation.validateAll();
            if (!result.valid) {
                const firstError = Object.values(result.errors)[0];
                toast.error(firstError);
                return;
            }
        }

        const form = $("#dataForm-vision_mission-update");
        const visionMission = new VisionMission();
        form.find("[name]").each(function () {
            const key = $(this).attr("name");
            const value = $(this).val();
            visionMission.set(key, value);
        });

        try {
            const response = await visionMissionAPI.update(visionMission);
            await toast.success(response.message);
            navigate.refresh();
        } catch (error) {
            console.log("error : ", error);
            await toast.error(error?.message || "Failed to update Vision & Mission.");
        }
    },
    async delete() {
        try {
            const response = await visionMissionAPI.delete(this.delete_id);
            await toast.success(response.message);
            navigate.refresh();
        } catch (error) {
            console.log("error : ", error);
            await toast.error(error?.message || "Failed to delete Vision & Mission.");
        }
    },
    showUpdateModal(event) {
        const data = $(event.currentTarget).data("vision_missions");
        const visionMission = new VisionMission();

        visionMission.set("id", data.id);
        visionMission.set("vision", data.vision);
        visionMission.set("mission", data.mission);
        visionMission.set("department_id", data.department_id);
        visionMission.set("language", data.language || "en");
        if (data.department) {
            visionMission.set("department_name", data.department.department_name);
        }

        visionMissionUI.fillUpdateForm(visionMission);

        const modal = new bootstrap.Modal($("#vision_missionModal-update"));
        modal.show();
    },
    showDeleteModal(event) {
        this.delete_id = $(event.currentTarget).data("id");
        const modal = new bootstrap.Modal($("#delete-modal-vision_mission"));
        modal.show();
    },

};
