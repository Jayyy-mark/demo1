const api = {

    async request(url, options = {}) {

        const isFormData = options.body instanceof FormData;

        const config = {
            credentials: "include",
            method: options.method || "GET",
            headers: {
                ...(options.headers || {}),
            },
            ...options,
        };

        // ❗ Only set JSON header if NOT FormData
        if (!isFormData) {
            config.headers["Content-Type"] = "application/json";
        }

        // ❗ Auto stringify JSON body only
        if (options.body && !isFormData) {
            config.body = JSON.stringify(options.body);
        }

        try {

            let response = await fetch(`/api${url}`, config);

            // =========================
            // AUTO REFRESH (401 HANDLER)
            // =========================
            if (response.status === 401 && !config._retry) {

                config._retry = true;

                const refreshRes = await fetch("/api/auth/refresh", {
                    method: "POST",
                    credentials: "include",
                });

                if (refreshRes.ok) {
                    response = await fetch(`/api${url}`, config);
                } else {
                    window.location.href = "/admin/auth/login";
                    throw new Error("Session expired");
                }
            }

            // =========================
            // ERROR HANDLING
            // =========================
            if (!response.ok) {
                const err = await response.json().catch(() => ({}));
                throw err;
            }

            // If no content
            if (response.status === 204) return null;

            return await response.json();

        } catch (err) {
            console.error("API Error:", err);
            throw err;
        }
    },

    get(url, options = {}) {
        return this.request(url, {
            ...options,
            method: "GET",
        });
    },

    post(url, body, options = {}) {
        return this.request(url, {
            ...options,
            method: "POST",
            body,
        });
    },

    put(url, body, options = {}) {
        return this.request(url, {
            ...options,
            method: "PUT",
            body,
        });
    },

    delete(url, options = {}) {
        return this.request(url, {
            ...options,
            method: "DELETE",
        });
    }
};

export default api;