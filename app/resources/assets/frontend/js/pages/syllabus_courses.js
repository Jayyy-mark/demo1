const api = {
    async getCourseBySemester(){
        const res = await fetch("/api/frontend/course/semester/subject");
        const data = await res.json();
        return data.subjects;
    }
}


const UI = {
    renderCourseBySemester(subjects){
        const semester_tab = document.querySelector("#tab-semester");
        let year_count = 1;
        subjects.forEach(element => {
            
            const row = `
            <div class="px-6 mb-3 border border-gray-200 bg-white shadow-sm overflow-hidden">
                <button class="semester-subject-btn  w-full py-5 md:py-6 flex items-center justify-between bg-white transition-colors text-left group">
                    <span class="font-bold text-blue-800 text-lg md:text-xl transition-colors pr-4">  ${element.year?.year_name}${
                        element.year?.year_name !== "First Year" ? " (CS)" : ""
                    }</span>
                    <div class="w-9 h-9 rounded-full border border-gray-200 flex items-center justify-center bg-white text-gray-500 transition-all flex-shrink-0">
                        <svg id="${element.year?.id}-icon" class="w-4 h-4 transform transition-transform duration-200" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M19 9l-7 7-7-7"></path></svg>
                    </div>
                </button>

                <!-- Inner Dashboard Layout displaying both Semesters inside one Accordion wrapper -->
                <div id="${element.year?.id}" class="accordion-content">

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 pb-5">

                        ${element.semesters.map(s=>`
                            
                            <div class="space-y-3">
                                <div class="inline-flex items-center px-3 py-2 bg-amber-400 text-white rounded-full text-xs font-bold tracking-wide uppercase">
                                    ${s.semester?.semester_term}
                                </div>
                                
                                <!-- Rounded Table Card for S1 -->
                                <div class="overflow-hidden border border-gray-200 rounded-xl bg-white shadow-sm">
                                    <table class="w-full text-left border-collapse">
                                        <thead>
                                            <tr style="background-color: #1E40AF;">
                                                <th class="py-3 px-4 text-base font-medium text-white">
                                                    Subject Code
                                                </th>
                                                <th class="py-3 px-4 text-base font-medium text-white">
                                                    Subject Name
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody class="divide-y divide-gray-200">
  
                                        ${s.courses.map(c => `
                                            <tr class="hover:bg-gray-50 transition-colors duration-150">
                                                ${
                                                    c.subject?.subject_name === "Internship"
                                                    ? `
                                                        <td colspan="2" class="py-3 px-4 text-base font-semibold text-center text-gray-600">
                                                            ${c.subject.subject_name}
                                                        </td>
                                                    `
                                                    : `
                                                        <td class="py-3 px-4 text-base font-semibold text-gray-600">
                                                            <span>${c.subject?.subject_code || ''}</span>
                                                        </td>
                                                        <td class="py-3 px-4 text-base font-semibold text-gray-600">
                                                            <span>${c.subject?.subject_name || ''}</span>
                                                        </td>
                                                    `
                                                }
                                            </tr>
                                        `).join('')}
  
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

            const r= `
            <div class="px-6 mb-3 border border-gray-200 bg-white shadow-sm overflow-hidden">
                <button class="semester-subject-btn  w-full py-5 md:py-6 flex items-center justify-between bg-white transition-colors text-left group">
                    <span class="font-bold text-blue-800 text-lg md:text-xl transition-colors pr-4">  ${element.year?.year_name}${
                        element.year?.year_name !== "First Year" ? " (CT)" : ""
                    }</span>
                    <div class="w-9 h-9 rounded-full border border-gray-200 flex items-center justify-center bg-white text-gray-500 transition-all flex-shrink-0">
                        <svg id="${element.year?.id}-icon" class="w-4 h-4 transform transition-transform duration-200" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M19 9l-7 7-7-7"></path></svg>
                    </div>
                </button>

                <!-- Inner Dashboard Layout displaying both Semesters inside one Accordion wrapper -->
                <div id="${element.year?.id}" class="accordion-content">

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 pb-5">

                        ${element.semesters.map(s=>`
                            
                            <div class="space-y-3">
                                <div class="inline-flex items-center px-3 py-2 bg-amber-400 text-white rounded-full text-xs font-bold tracking-wide uppercase">
                                    ${s.semester?.semester_term}
                                </div>
                                
                                <!-- Rounded Table Card for S1 -->
                                <div class="overflow-hidden border border-gray-200 rounded-xl bg-white shadow-sm">
                                    <table class="w-full text-left border-collapse">
                                        <thead>
                                            <tr style="background-color: #1E40AF;">
                                                <th class="py-3 px-4 text-base font-medium text-white">
                                                    Subject Code
                                                </th>
                                                <th class="py-3 px-4 text-base font-medium text-white">
                                                    Subject Name
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody class="divide-y divide-gray-200">
  
                                        ${s.courses.map(c => `
                                            <tr class="hover:bg-gray-50 transition-colors duration-150">
                                                ${
                                                    c.subject?.subject_name === "Internship"
                                                    ? `
                                                        <td colspan="2" class="py-3 px-4 text-base font-semibold text-center text-gray-600">
                                                            ${c.subject.subject_name}
                                                        </td>
                                                    `
                                                    : `
                                                        <td class="py-3 px-4 text-base font-semibold text-gray-600">
                                                            <span>${c.subject?.subject_code || ''}</span>
                                                        </td>
                                                        <td class="py-3 px-4 text-base font-semibold text-gray-600">
                                                            <span>${c.subject?.subject_name || ''}</span>
                                                        </td>
                                                    `
                                                }
                                            </tr>
                                        `).join('')}
  
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

            element.year?.year_name !== "First Year" &&
                semester_tab.insertAdjacentHTML('beforeend', r);
        });
    }
};

const courseEvent = {
    init(){
        this.load();

        $(document).on('click', '.semester-subject-btn', function(){
            const content = $(this).parent().find(".accordion-content");
            content.toggleClass("open");
            const icon = $(this).find("svg");
            icon.toggleClass("rotate-180");
        });
    },
    async load(){
        const semesterSubjects = await api.getCourseBySemester();
        console.log("this is data : ", semesterSubjects);
        UI.renderCourseBySemester(semesterSubjects);
    }
}


document.addEventListener('DOMContentLoaded', function(){
    courseEvent.init();
});