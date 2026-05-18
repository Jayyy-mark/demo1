
//<!--====================================
//  COURSE API HANDLER
//=====================================-->


//<!--====================================
//  IMPORTS 
//=====================================-->
import { Utils } from "../utils/utils.js";
import api from "../utils/api.js";

const BaseURL = "/academic/course";
const allURL = BaseURL + "/all";
const addURL = BaseURL + "/create";
const updateURL = BaseURL + "/update";
const deleteURL = BaseURL + "/delete";

export const courseAPI = {
    async all(){
        const res = await api.get(allURL);
        return res.data;
    },
    async create(course){
        console.log(course);
        const res = await api.post(addURL, {
            course_name:course.course_name,
            semester_id:course.semester_id,
            subject_id:course.subject_id,
        });// send json
        return res.data;

    },
    async update(course){

        const res = await api.put(updateURL, {
            id:course.id,
            course_id:course.course_id,
            course_name:course.course_name,
            semester_id:course.semester_id,
            subject_id:course.subject_id,
        });
        return res.data;

    },
    async delete(id){
        const res = await api.delete(deleteURL, {
            data:{id}
        })
        return res.data;
    }
};