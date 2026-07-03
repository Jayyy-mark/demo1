const api = {
    async getCourseByFaculty(department_name){
        const params = new URLSearchParams({
            department_name:department_name,
        });
        const res = await fetch(`/api/frontend/course/department/subject?${params.toString()}`);
        const data = await res.json();
        return data.subjects;

    },
}


const UI = {
    renderCourseByFaculty(data) {

        const hasSubjects = Object.values(data.semesters).some(
            semester => semester.subjects.length > 0
        );

        if (!hasSubjects) {
            return; // Don't render anything
        }

        const faculty_tab = document.querySelector("#tab-faculties");

        const row = `

                <div class="pt-6 pb-4 border-b border-gray-200 mb-6">
                    <h2 class="text-2xl font-bold text-blue-800">
                        Courses
                    </h2>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6 p-5">

                    ${Object.entries(data.semesters).map(([semesterName, semesterData]) => `
                        
                        <div class="space-y-3">
                            <div class="inline-flex items-center px-3 py-2 bg-amber-400 text-white rounded-full text-xs font-bold tracking-wide uppercase">
                                ${semesterName}
                            </div>

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

                                        ${semesterData.subjects.map(subject => `
                                            <tr class="hover:bg-gray-50 transition-colors duration-150">
                                                <td class="py-3 px-4 text-base font-semibold text-gray-600">
                                                    ${subject.subject_code}
                                                </td>
                                                <td class="py-3 px-4 text-base font-semibold text-gray-600">
                                                    ${subject.subject_name}
                                                </td>
                                            </tr>
                                        `).join('')}

                                    </tbody>
                                </table>
                            </div>
                        </div>

                    `).join('')}

                </div>
        `;

        faculty_tab.insertAdjacentHTML("beforeend", row);
    }
};

const courseEvent = {
    init(){
        this.load();

    },
    async load(){
        const department_name = String(document.querySelector("#department_name").value).split("(")[0].trim();
        const departmentSubjects = await api.getCourseByFaculty(department_name);
        UI.renderCourseByFaculty(departmentSubjects);

    }
}


document.addEventListener('DOMContentLoaded', function(){
    courseEvent.init();
});