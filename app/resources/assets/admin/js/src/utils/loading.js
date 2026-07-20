let activeRequests = 0;

function showLoading() {
    document.getElementById("global-loader")?.classList.remove("hidden");
}

function hideLoading() {
    document.getElementById("global-loader")?.classList.add("hidden");
}

export function startLoading() {
    activeRequests++;

    if (activeRequests === 1) {
        showLoading();
    }
}

export function stopLoading() {
    activeRequests--;

    if (activeRequests <= 0) {
        activeRequests = 0;
        hideLoading();
    }
}

export function isPageLoaded() {

    let pageLoaded = false;

    window.addEventListener("load", () => {
        console.log("Page is loading!");
        pageLoaded = true;
        return pageLoaded;
    });

    return pageLoaded;
}