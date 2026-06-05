import { api } from "../utils/api.js";


const calendarApi = {
    async all() {
        const res = await api.get("/frontend/academic/calendar");
        return res.data;
    },
}


/*<!--=============================
    CALENDAR UI HANDLER
==============================-->*/
const monthTitle = $("#calendar-title");
const calendarGrid = $("#calendar-grid");
const form = $("#calendarForm");
const modalTitle = $("#calendar-modal-title");
const deleteButton = $("#calendar-delete-btn");

const statusClassMap = {
    Pending: "status-pending",
    "On Progress": "status-on-progress",
    Completed: "status-completed"
};

function toDateKey(date) {
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, "0");
    const day = String(date.getDate()).padStart(2, "0");
    return `${year}-${month}-${day}`;
}

function parseDate(dateValue) {
    return new Date(`${dateValue}T00:00:00`);
}

function isSameMonth(date, monthDate) {
    return date.getMonth() === monthDate.getMonth() && date.getFullYear() === monthDate.getFullYear();
}

function getEventStatus(event, todayKey) {
    if (todayKey > event.end_date) {
        return "Completed";
    }

    if (todayKey >= event.start_date) {
        return "On Progress";
    }

    return "Pending";
}

function getDateDiff(startDate, endDate) {
    const millisecondsPerDay = 24 * 60 * 60 * 1000;
    return Math.round((parseDate(endDate) - parseDate(startDate)) / millisecondsPerDay);
}

function getVisibleEventSegments(event, gridStart, todayKey) {
    const segments = [];
    const visibleStartKey = toDateKey(gridStart);
    const visibleEnd = new Date(gridStart);
    visibleEnd.setDate(gridStart.getDate() + 41);
    const visibleEndKey = toDateKey(visibleEnd);

    if (event.end_date < visibleStartKey || event.start_date > visibleEndKey) {
        return segments;
    }

    const segmentStartKey = event.start_date > visibleStartKey ? event.start_date : visibleStartKey;
    const segmentEndKey = event.end_date < visibleEndKey ? event.end_date : visibleEndKey;
    let cursor = parseDate(segmentStartKey);
    const finalDate = parseDate(segmentEndKey);
    const eventWithStatus = {
        ...event,
        status: getEventStatus(event, todayKey)
    };

    while (cursor <= finalDate) {
        const weekEnd = new Date(cursor);
        weekEnd.setDate(cursor.getDate() + (6 - cursor.getDay()));

        const end = weekEnd < finalDate ? weekEnd : finalDate;
        const offset = getDateDiff(toDateKey(gridStart), toDateKey(cursor));
        const row = Math.floor(offset / 7) + 1;

        segments.push({
            event: eventWithStatus,
            row,
            startColumn: cursor.getDay() + 1,
            endColumn: end.getDay() + 2
        });

        cursor = new Date(end);
        cursor.setDate(end.getDate() + 1);
    }

    return segments;
}

const calendarUI = {
    renderMonth(currentDate, events) {

        console.log("Rendering month:", currentDate, "with events:", events);
        const title = currentDate.toLocaleDateString("en-US", {
            month: "long",
            year: "numeric"
        });
        const todayKey = toDateKey(new Date());
        const firstDay = new Date(currentDate.getFullYear(), currentDate.getMonth(), 1);
        const gridStart = new Date(firstDay);
        gridStart.setDate(firstDay.getDate() - firstDay.getDay());

        monthTitle.text(title);
        calendarGrid.empty();

        for (let i = 0; i < 42; i++) {
            const day = new Date(gridStart);
            day.setDate(gridStart.getDate() + i);

            const dayKey = toDateKey(day);
            const dayCell = $("<div></div>").addClass("calendar-day");
            dayCell.css({
                gridColumn: (day.getDay() + 1).toString(),
                gridRow: (Math.floor(i / 7) + 1).toString()
            });

            if (!isSameMonth(day, currentDate)) {
                dayCell.addClass("is-muted");
            }
            if (dayKey === todayKey) {
                dayCell.addClass("is-today");
            }

            dayCell.append(
                $("<span></span>")
                    .addClass("calendar-day-number")
                    .text(day.getDate())
            );

            calendarGrid.append(dayCell);
        }

        const eventSegments = events
            .flatMap((event) => getVisibleEventSegments(event, gridStart, todayKey))
            .sort((a, b) => {
                const dateOrder = a.event.start_date.localeCompare(b.event.start_date);
                return dateOrder || a.event.end_date.localeCompare(b.event.end_date);
            });

        const rowSegmentCounts = {};

        eventSegments.forEach((segment) => {
            const slot = rowSegmentCounts[segment.row] || 0;
            rowSegmentCounts[segment.row] = slot + 1;

            const statusClass = statusClassMap[segment.event.status] || statusClassMap.Pending;
            const eventButton = $("<button></button>")
                .attr("type", "button")
                .addClass(`calendar-event ${statusClass}`)
                .css({
                    gridColumn: `${segment.startColumn} / ${segment.endColumn}`,
                    gridRow: segment.row.toString(),
                    "--event-slot": slot
                })
                .text(segment.event.title || "Untitled event")
                .data("event", segment.event);

            calendarGrid.append(eventButton);
        });
    },

    renderUpcomingList(events) {
        const listContainer = $("#upcoming-events-list");
        listContainer.empty();

        if (!events || events.length === 0) {
            listContainer.append('<div class="calendar-empty">No dynamic schedule configured for this month view.</div>');
            return;
        }

        events.forEach(event => {
            const statusClass = statusClassMap[event.status] || "status-pending";

            // Reformat Year-Month-Day safely to Month Day, Year syntax (e.g. Jun 04, 2026)
            const options = { month: 'short', day: '2-digit', year: 'numeric' };
            const startStr = parseDate(event.start_date).toLocaleDateString('en-US', options);
            const endStr = parseDate(event.end_date).toLocaleDateString('en-US', options);
            const dateRangeText = (event.start_date === event.end_date) ? startStr : `${startStr} - ${endStr}`;

            const cardHtml = `
                    <div class="upcoming-card ${statusClass}">
                        <div class="upcoming-card-meta">
                            <span class="status-indicator"></span>
                            <span class="upcoming-date">${dateRangeText}</span>
                        </div>
                        <h4 class="upcoming-title">${event.title || 'Untitled Academic Event'}</h4>
                        <p class="upcoming-desc">${event.description || 'No scheduling context notes declared.'}</p>
                    </div>
                `;
            listContainer.append(cardHtml);
        });
    },

    openCreateForm(defaultDate) {
        form[0].reset();
        form.find("[name=id]").val("");
        form.find("[name=status]").val("Pending");

        if (defaultDate) {
            form.find("[name=start_date]").val(defaultDate);
            form.find("[name=end_date]").val(defaultDate);
        }

        modalTitle.text("Add Calendar Event");
        deleteButton.addClass("d-none");
    },

    openUpdateForm(event) {
        form[0].reset();
        Object.entries(event).forEach(([key, value]) => {
            form.find(`[name=${key}]`).val(value);
        });
        modalTitle.text("Update Calendar Event");
        deleteButton.removeClass("d-none");
    },

    getFormData() {
        const data = {};

        form.find("[name]").each(function () {
            const key = $(this).attr("name");
            const value = $(this).val();

            if (key === "id") {
                if (value) {
                    data[key] = Number(value);
                }
                return;
            }

            data[key] = value;
        });

        return data;
    },

    validate(data) {
        if (!data.title?.trim()) {
            return "Title is required.";
        }

        if (!data.start_date || !data.end_date) {
            return "Start date and end date are required.";
        }

        if (parseDate(data.start_date) > parseDate(data.end_date)) {
            return "End date must be after the start date.";
        }

        if (!["Pending", "On Progress", "Completed"].includes(data.status)) {
            return "Please choose a valid status.";
        }

        return "";
    }
};



/*<!--=============================
    CALENDAR EVENT HANDLER
==============================-->*/
function monthOffset(date, offset) {
    return new Date(date.getFullYear(), date.getMonth() + offset, 1);
}
const calendarEvent = {
    currentDate: new Date(),
    events: [],
    selectedId: null,

    init() {
        this.currentDate = new Date(this.currentDate.getFullYear(), this.currentDate.getMonth(), 1);
        this.loadData();

        $("#calendar-prev").on("click", () => {
            this.currentDate = monthOffset(this.currentDate, -1);
            this.render();
        });

        $("#calendar-next").on("click", () => {
            this.currentDate = monthOffset(this.currentDate, 1);
            this.render();
        });
    },

    async loadData() {
        try {
            const res = await calendarApi.all();
            this.events = res.data || [];
            this.render();
        } catch (error) {
            alert("Failed to load calendar events. Please try again later.");
            console.error("Error loading calendar events:", error);
        }
    },

    render() {
        calendarUI.renderMonth(this.currentDate, this.events);

        const viewYear = this.currentDate.getFullYear();
        const viewMonth = this.currentDate.getMonth();
        const startOfViewScope = new Date(viewYear, viewMonth, 1);
        const endOfViewScope = new Date(viewYear, viewMonth + 1, 0);

        const activeScopedEvents = this.events.filter(event => {
            const eventStart = parseDate(event.start_date);
            const eventEnd = parseDate(event.end_date);
            return (eventStart <= endOfViewScope && eventEnd >= startOfViewScope);
        });

        calendarUI.renderUpcomingList(activeScopedEvents);
    },

};

/*<!--=============================
    CALENDAR SCRIPTS ENTRY POINT
==============================-->*/
$(document).ready(() => {
    calendarEvent.init();
});
