const api = {
    async getCourseByFaculty(){
        const res = await fetch("/api/frontend/course/department/subject");
        const data = await res.json();
        return data.subjects;
    },
    async getCourseBySemester(){
        const res = await fetch("api/frontend/course/semester/subject");
        const data = await res.json();
        return data.subjects;
    }
}


const UI = {
    renderCourseByFaculty(subjects){
        const faculty_tab = document.querySelector("#tab-faculties");

        subjects.forEach(element => {
            
            const row = `
                <div class="border-b border-gray-200">
                    <button onclick="toggleAccordion('${element.department?.id}')" class="w-full py-5 md:py-6 flex items-center justify-between bg-white hover:bg-gray-50/80 transition-colors text-left group">
                        <span class="font-semibold text-gray-900 text-lg md:text-xl group-hover:text-blue-600 transition-colors pr-4">${element.department?.department_name}</span>
                        <div class="w-9 h-9 rounded-full border border-gray-200 flex items-center justify-center bg-white text-gray-500 group-hover:text-blue-600 group-hover:border-blue-200 transition-all flex-shrink-0">
                            <svg id="${element.department?.id}-department" class="w-4 h-4 transform transition-transform duration-200" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M19 9l-7 7-7-7"></path></svg>
                        </div>
                    </button>

                    <div id="${element.department?.id}" class="accordion-content">
                        <div class="pb-6 pt-2 pl-2">
                            <!-- The wrapper handles the rounding, border, and background -->
                            <div class="overflow-hidden border border-gray-200 rounded-xl bg-white">
                                <table class="w-full text-left border-collapse">
                                    <thead>
                                        <tr>
                                            <th class="py-3 px-4 text-base font-medium 
                                            text-gray-600 border border-gray-300">
                                            Subject Code
                                            </th>
                                            <th class="py-3 px-4 text-base font-medium 
                                            text-gray-600 border border-gray-300">
                                            Subject Name
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody class="divide-y divide-gray-200">
                                        ${element.subjects.map(sub => `
                                            <tr class="hover:bg-gray-50 transition-colors duration-150">
                                                <td class="py-3 px-4 text-base font-medium text-gray-600 border border-gray-300">
                                                    <span>${sub.subject_code}</span>
                                                </td>
                                                <td class="py-3 px-4 font-medium text-base text-gray-600 border border-gray-300">
                                                    <span>${sub.subject_name}</span>
                                                </td>
                                            </tr>
                                        `).join('')}
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>            
            `;

            faculty_tab.insertAdjacentHTML("beforeend", row);

        });

    },
    renderCourseBySemester(subjects){
        const semester_tab = document.querySelector("#tab-semester");
        let year_count = 1;
        subjects.forEach(element => {
            
            const row = `
            <div class="border-b border-gray-200">
                <button onclick="toggleAccordion('${element.year?.id}')" class="w-full py-5 md:py-6 flex items-center justify-between bg-white transition-colors text-left group">
                    <span class="font-semibold text-gray-900 text-lg md:text-xl transition-colors pr-4">${element.year?.year_name}</span>
                    <div class="w-9 h-9 rounded-full border border-gray-200 flex items-center justify-center bg-white text-gray-500 transition-all flex-shrink-0">
                        <svg id="${element.year?.id}-semester" class="w-4 h-4 transform transition-transform duration-200" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M19 9l-7 7-7-7"></path></svg>
                    </div>
                </button>

                <!-- Inner Dashboard Layout displaying both Semesters inside one Accordion wrapper -->
                <div id="${element.year?.id}" class="accordion-content">

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">

                        ${element.semesters.map(s=>`
                            
                            <div class="space-y-3">
                                <div class="inline-flex items-center px-3 py-1 bg-blue-50 text-blue-700 rounded-full text-xs font-bold tracking-wide uppercase">
                                    ${s.semester?.semester_term}
                                </div>
                                
                                <!-- Rounded Table Card for S1 -->
                                <div class="overflow-hidden border border-gray-200 rounded-xl bg-white shadow-sm">
                                    <table class="w-full text-left border-collapse">
                                        <thead>
                                            <tr>
                                                <th class="py-3 px-4 text-base font-medium text-gray-600 border border-gray-300">
                                                    Subject Code
                                                </th>
                                                <th class="py-3 px-4 text-base font-medium text-gray-600 border border-gray-300">
                                                    Subject Name
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody class="divide-y divide-gray-200">
  
                                        ${s.courses.map(c=>`
                                            <tr class="hover:bg-gray-50 transition-colors duration-150">
                                                <td class="py-3 px-4 text-base font-medium text-gray-600 border border-gray-300">
                                                    <span>${c.subject?.subject_code}</span>
                                                </td>
                                                <td class="py-3 px-4 text-base font-medium text-gray-600 border border-gray-300">
                                                    <span>${c.subject?.subject_name}</span>
                                                </td>
                                            </tr>
                                            `).join('')
                                        }
  
                                        </tbody>
                                    </table>
                                </div>
                            </div> 
                            `).join('')
                        }

                    </div>
                </div>
            </div>            
            `;
            
            semester_tab.insertAdjacentHTML('beforeend', row);
        });
    }
};

const courseEvent = {
    init(){
        this.load();
    },
    async load(){
        const departmentSubjects = await api.getCourseByFaculty();
        console.log("this is data : ", departmentSubjects);

        UI.renderCourseByFaculty(departmentSubjects);

        const semesterSubjects = await api.getCourseBySemester();
        console.log("this is data : ", semesterSubjects);
        UI.renderCourseBySemester(semesterSubjects);
    }
}


document.addEventListener('DOMContentLoaded', function(){
    courseEvent.init();
});