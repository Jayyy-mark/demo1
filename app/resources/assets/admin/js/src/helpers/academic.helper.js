//js/app/helpers/academic.helper.js
//<!--==========================================
//      ACADEMIC HELPERS
//============================================-->
import api from "../utils/api.js";

export const academicHelper = {
    async getYears(){
        const res = await api.get('/academic/year/all');
        return res.data;
    },
    async setTab(tab){
        const res = await api.post('/academic/tab',{
            tab
        });
        return res.data.message;
    },
    async getDepartments(){
        const res = await api.get('/department/all');
        return res.data;
    },
    async getSemesters(){
        const res = await api.get('/academic/semester/all');
        return res.data;
    },
    async getSubjects(){
        const res = await api.get('/academic/subject/all');
        return res.data;
    },
}