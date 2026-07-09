
export const dashboardUI = {
    render(data) {
        console.log("this is data value : ",data);
        if (data == null || (Array.isArray(data) && data.length === 0)) {
            console.log("No data has been found!");
            return;
        }

        data.forEach(element => {

            console.log("this is element : ", element.attr_key);
            if(element.attr_key == "Rector's Message"){
                $("#rector-message").text(element.value);
            }
            
            if (element.attr_key == "Admission Lists") {
                $("#academic-admission-lists").html(
                    `<a href="${element.value}" target="_blank">View Admission List</a>`
                );
            }

        });
    },

    renderCalendar(events) {
        const today = new Date();
        const year = today.getFullYear();
        const month = today.getMonth(); // 0-11
        
        const monthNames = ["JANUARY", "FEBRUARY", "MARCH", "APRIL", "MAY", "JUNE", "JULY", "AUGUST", "SEPTEMBER", "OCTOBER", "NOVEMBER", "DECEMBER"];
        $("#calendar-month-year").text(`${monthNames[month]} ${year}`);
        
        const firstDay = new Date(year, month, 1).getDay();
        const daysInMonth = new Date(year, month + 1, 0).getDate();
        
        let html = '';
        // Empty slots
        for (let i = 0; i < firstDay; i++) {
            html += `<div class="calendar-day empty-day"></div>`;
        }
        
        // Days
        for (let i = 1; i <= daysInMonth; i++) {
            // Find if this day has an event
            const dayEvents = events.filter(e => {
                if (!e.start_date) return false;
                const d = new Date(e.start_date);
                return d.getFullYear() === year && d.getMonth() === month && d.getDate() === i;
            });
            
            const hasEvent = dayEvents.length > 0;
            const isToday = (i === today.getDate());
            
            let classes = "calendar-day";
            if (isToday) classes += " active";
            
            let dotHtml = hasEvent ? `<div class="calendar-event-dot"></div>` : '';
            
            // Encode events to string to attach to element
            const eventsJson = encodeURIComponent(JSON.stringify(dayEvents));
            
            html += `<div class="${classes}" data-day="${i}" data-events="${eventsJson}">
                        ${i}
                        ${dotHtml}
                     </div>`;
        }
        
        $("#calendar-days").html(html);
        
        // Setup click listener
        $("#calendar-days .calendar-day:not(.empty-day)").off("click").on("click", function() {
            // Remove active from all
            $("#calendar-days .calendar-day").removeClass("active");
            // Add active to clicked
            $(this).addClass("active");
            
            // Check events
            const dayEventsStr = decodeURIComponent($(this).attr("data-events") || "[]");
            const dayEvents = JSON.parse(dayEventsStr);
            
            if (dayEvents.length > 0) {
                const ev = dayEvents[0];
                $("#calendar-event-title").text(ev.title || "လုပ်ငန်းအစီအစဉ်များ:");
                $("#calendar-event-desc").html(ev.description || "အသေးစိတ်အချက်အလက် မရှိပါ။");
            } else {
                $("#calendar-event-title").text("လုပ်ငန်းအစီအစဉ်များ:");
                $("#calendar-event-desc").text("ပြက္ခဒိန်ရက်စွဲများကို နှိပ်၍ သတ်မှတ်ထားသော အစည်းအဝေးများအား စစ်ဆေးနိုင်ပါသည်။");
            }
        });
        
        // Trigger click on today to populate if there's an event today
        $("#calendar-days .calendar-day.active").trigger("click");
    }

}