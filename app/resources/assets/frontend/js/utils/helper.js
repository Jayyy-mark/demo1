export function getMonthName(date){
    const month = new Date(date).toLocaleString("en-US", {
        month: "short"
    }).toUpperCase();

    return month
}

export function getDay(date){
    const d = new Date(date);
    const month = d.toLocaleString("en-US", {
        month: "short"
    }).toUpperCase();

    const day = String(d.getDate()).padStart(2, "0");
    return day;
}

export function getYear(date){
    const d = new Date(date);
    return d.getFullYear();
}