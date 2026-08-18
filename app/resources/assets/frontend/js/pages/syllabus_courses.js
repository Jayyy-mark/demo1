const api = {
    async getCourseBySemester() {
        const res = await fetch("/api/frontend/course/semester/subject");
        const data = await res.json();
        return data.subjects;
    }
}


const UI = {
    renderCourseBySemester(subjects) {
        const semester_tab = document.querySelector("#tab-semester");
        
        subjects.forEach(element => {
            const isFirstYear = element.year?.year_name === "First Year";

            const generateAccordion = (type) => {
                const isCS = type === "CS";
                const isCT = type === "CT";
                
                const coursesHtml = element.semesters.map(s => {
                    const filteredCourses = s.courses.filter(c => {
                        if (isFirstYear) return true;
                        if (c.subject?.subject_name === "Internship") return true;
                        
                        const code = c.subject?.subject_code || '';
                        
                        // Allow courses explicitly missing a code just in case
                        if (!code) return true;
                        
                        if (isCS) {
                            return code.startsWith("CST") || code.startsWith("CS");
                        } else if (isCT) {
                            return code.startsWith("CST") || code.startsWith("CT");
                        }
                        return true;
                    }).sort((a, b) => {
                        const codeA = a.subject?.subject_code || '';
                        const codeB = b.subject?.subject_code || '';
                        
                        // Extract the first number found in the string (e.g., "1101" from "E-1101")
                        const numA = parseInt(codeA.match(/\d+/) || [0], 10);
                        const numB = parseInt(codeB.match(/\d+/) || [0], 10);
                        
                        if (numA !== numB) {
                            return numA - numB;
                        }
                        
                        // Fallback to alphabetical sort if the numbers are identical
                        return codeA.localeCompare(codeB);
                    });

                    if (filteredCourses.length === 0) return '';

                    return `
                        <div class="space-y-3">
                            <div class="inline-flex items-center px-3 py-2 bg-amber-400 text-white rounded-full text-xs font-bold tracking-wide uppercase">
                                ${s.semester?.semester_term}
                            </div>
                            
                            <!-- Rounded Table Card -->
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

                                    ${filteredCourses.map(c => `
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
                    `;
                }).join('');

                const title = isFirstYear ? element.year?.year_name : `${element.year?.year_name} (${type})`;
                const idSuffix = isFirstYear ? 'first' : type.toLowerCase();

                return `
                <div class="px-6 mb-3 border border-gray-200 bg-white shadow-sm overflow-hidden">
                    <button class="semester-subject-btn  w-full py-5 md:py-6 flex items-center justify-between bg-white transition-colors text-left group">
                        <span class="font-bold text-blue-800 text-lg md:text-xl transition-colors pr-4">  ${title}</span>
                        <div class="w-9 h-9 rounded-full border border-gray-200 flex items-center justify-center bg-white text-gray-500 transition-all flex-shrink-0">
                            <svg id="${element.year?.id}-${idSuffix}-icon" class="w-4 h-4 transform transition-transform duration-200" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M19 9l-7 7-7-7"></path></svg>
                        </div>
                    </button>

                    <div id="${element.year?.id}-${idSuffix}" class="accordion-content">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 pb-5">
                            ${coursesHtml}
                        </div>
                    </div>
                </div>            
                `;
            };

            // Render CS card (or First Year card)
            semester_tab.insertAdjacentHTML('beforeend', generateAccordion("CS"));

            // If not First Year, render CT card as well
            if (!isFirstYear) {
                semester_tab.insertAdjacentHTML('beforeend', generateAccordion("CT"));
            }
        });
    }
};

const courseEvent = {
    init() {
        this.load();

        $(document).on('click', '.semester-subject-btn', function () {
            const content = $(this).parent().find(".accordion-content");
            content.toggleClass("open");
            const icon = $(this).find("svg");
            icon.toggleClass("rotate-180");
        });
    },
    async load() {
        const semesterSubjects = await api.getCourseBySemester();
        console.log("this is data : ", semesterSubjects);
        UI.renderCourseBySemester(semesterSubjects);
    }
}


document.addEventListener('DOMContentLoaded', function () {
    courseEvent.init();
});