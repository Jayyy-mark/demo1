# 📚 UCSTGO Web Portal & Management System — Technical Architecture & Code Documentation

---

## 1. Executive Summary & Tech Stack

This document provides a comprehensive technical overview of the **University of Computer Studies (Taungoo) Web Application**. The system is built with a **modular, layered Model-View-Controller (MVC)** architecture in Python (Flask) on the backend and modern ES6 JavaScript modules on the frontend.

### 🛠️ Technology Stack
* **Backend Framework:** Python 3, Flask
* **Database & ORM:** MySQL, SQLAlchemy ORM (`Flask-SQLAlchemy`), `Flask-Migrate`
* **Data Serialization & Validation:** Marshmallow (`Flask-Marshmallow`)
* **Authentication & Security:** `Flask-JWT-Extended` (HTTP-only cookies + CSRF protection), `Flask-Limiter` (Rate Limiting), `Werkzeug ProxyFix`
* **AI & Knowledge Retrieval (RAG):** Google Gemini API (`google-genai`), ChromaDB (Vector Store), LangChain Text Splitters, PyPDF
* **Frontend Presentation:** Jinja2 Template Engine, Tailwind CSS, Bootstrap 5 / Tabler UI (Admin), Vanilla ES6 Modules (Clean 4-tier JS architecture), Axios with Interceptors.

---

## 2. Directory Tree & Module Organization

```plaintext
d:\Internship\demo1\
├── wsgi.py                    # Production WSGI entry point
├── app/
│   ├── __init__.py            # Application Factory (`create_app`) & Extension Initializer
│   ├── main.py                # Development runner entry point
│   ├── core/                  # Core infrastructure (Config, DB, Context Processors, Error Handlers)
│   │   ├── config.py          # App settings, JWT, and database credentials
│   │   ├── database.py        # Singleton instances of SQLAlchemy, Marshmallow, Migrate
│   │   ├── context_processor.py# Injects dynamic assets, auth state, and global data to templates
│   │   ├── error_handler.py   # Global HTTP error interception (404, 500, etc.)
│   │   └── security.py        # CORS & security configurations
│   ├── https/
│   │   ├── controllers/       # Business logic orchestration & CRUD handlers
│   │   │   ├── BaseController.py # Abstract generic CRUD controller (Template Method Pattern)
│   │   │   ├── ActivityController.py
│   │   │   ├── BotController.py
│   │   │   ├── DashboardController.py
│   │   │   ├── FrontendController.py
│   │   │   └── ... (Department, Subject, Course, User controllers)
│   │   └── middleware/        # Request interceptors & guards
│   │       ├── auth_middleware.py     # Attaches session user to `g.user`
│   │       └── limiter_middleware.py  # Rate limiter instance
│   ├── models/                # SQLAlchemy ORM database models
│   │   ├── __init__.py        # Dynamic model autoloader
│   │   ├── ActivityModel.py
│   │   ├── UserModel.py
│   │   ├── DashboardModel.py
│   │   ├── CourseModel.py
│   │   └── ... (15+ domain entities)
│   ├── schemas/               # Marshmallow serialization schemas (DTO Pattern)
│   │   ├── activity.py
│   │   ├── dashboard.py
│   │   └── ...
│   ├── routes/                # Server-rendered HTML page routes (Jinja2 views)
│   │   ├── __init__.py        # Dynamic route blueprint autoloader
│   │   ├── admin/             # Admin panel page routes (/admin/*)
│   │   └── frontend/          # Public portal page routes (/, /about, /academic, etc.)
│   ├── api/                   # RESTful API JSON endpoints (/api/*)
│   │   ├── __init__.py        # Dynamic API blueprint autoloader
│   │   ├── auth/              # JWT login, refresh, logout
│   │   ├── dashboard/         # Statistics, topbar, rector messages
│   │   ├── chatbot.py         # AI chatbot ask & search endpoints
│   │   └── frontend.py        # Public frontend data feeds
│   ├── helpers/               # Shared business services & utility facades
│   │   ├── bot_services.py    # ChromaDB Vector RAG & Gemini AI pipeline
│   │   ├── utils.py           # Facades: `Utils` (DB operations) & `ResponseHelper` (JSON format)
│   │   └── install.py         # System installation & database setup guards
│   └── resources/
│       ├── views/             # Jinja2 HTML templates
│       │   ├── admin/         # Admin dashboard layouts, pages, and modals
│       │   └── frontend/      # Public portal layouts and landing pages
│       └── assets/            # Static assets (CSS, JS, images, media uploads, vector_db)
│           └── admin/js/src/  # 4-Tier Modular Frontend Architecture (API, UI, Events, Interfaces)
```

---

## 3. High-Level Architecture & Communication Flow

The application follows a clean **N-Tier Layered Architecture** where concerns are strictly isolated:

```
┌────────────────────────────────────────────────────────────────────────────────────────┐
│                                   CLIENT BROWSER                                       │
│    Jinja2 HTML Pages  ◄───►  ES6 Modules [interfaces/ ──► api/ ──► ui/ ──► events/]   │
└────────────────────────────────────────┬───────────────────────────────────────────────┘
                                         │ HTTP Request (HTML Page or JSON API)
                                         ▼
┌────────────────────────────────────────────────────────────────────────────────────────┐
│                              FLASK WEB APPLICATION LAYER                               │
│  1. ProxyFix & CORS                                                                    │
│  2. Middlewares (Installation Guard -> Auth Session -> Rate Limiter)                  │
│  3. Routing & API Layer (Dynamic Blueprints: app/routes/ & app/api/)                  │
└────────────────────────────────────────┬───────────────────────────────────────────────┘
                                         │ Invokes controller method
                                         ▼
┌────────────────────────────────────────────────────────────────────────────────────────┐
│                                  CONTROLLER LAYER                                      │
│  BaseController (Generic CRUD) ◄── Inherited by Domain Controllers (Activity, User...) │
│  FrontendController & DashboardController & BotController                              │
└───────────────────┬──────────────────────────────────────────────┬─────────────────────┘
                    │                                              │
         Interacts with Helpers                         Queries & Manipulates
                    │                                              │
                    ▼                                              ▼
┌───────────────────────────────────────┐      ┌─────────────────────────────────────────┐
│        SERVICE / HELPER LAYER         │      │          DATA ACCESS LAYER              │
│ - bot_services (RAG + ChromaDB + AI)  │      │ - Models (SQLAlchemy ORM Entities)      │
│ - utils (Utils Facade, ResponseHelper)│      │ - Schemas (Marshmallow DTO Serializers) │
└───────────────────────────────────────┘      └───────────────────┬─────────────────────┘
                                                                   │ SQL Queries
                                                                   ▼
                                                       ┌───────────────────────┐
                                                       │   MySQL DATABASE      │
                                                       └───────────────────────┘
```

---

## 4. Detailed Component & Module Breakdown

### 4.1. Application Bootstrapping (`app/__init__.py`)
* **Role:** Implements the **Application Factory Pattern** (`create_app()`).
* **Workflow:**
  1. Loads environment variables from `.env`.
  2. Creates the Flask instance and configures templates (`resources/views`) and static assets (`resources/assets`).
  3. Initializes extensions (`CORS`, `ProxyFix`, `Limiter`, `JWTManager`).
  4. Registers global `before_request` hooks:
     * `check_installation`: Redirects to `/install` if the database has not been initialized.
     * `attach_user`: Reads user session and attaches `g.user`.
  5. Initializes database connection via `init_db(app)`.
  6. Automatically discovers and registers all models, context processors, API blueprints, route blueprints, and error handlers.

---

### 4.2. Core Layer (`app/core/`)
* **`config.py`:** Centralizes application constants, JWT expiration and cookie policies (`SameSite="Lax"`, `HttpOnly=True`), and database connection string parsing via `quote_plus`.
* **`database.py`:** Instantiates `db = SQLAlchemy()`, `ma = Marshmallow()`, and `migrate = Migrate()` as **Singletons**, later bound to the Flask instance via `init_db(app)`.
* **`context_processor.py`:** Executes before rendering templates. Injects global asset definitions (`assets.vendor`, `assets.theme`, `assets.features`), current year, user avatars, and user names directly into all Jinja2 templates without requiring controllers to pass them manually.
* **`error_handler.py`:** Intercepts uncaught HTTP errors (404, 500) and renders branded error pages or JSON payloads.

---

### 4.3. Middleware & Security Layer (`app/https/middleware/`)
* **`auth_middleware.py` (`attach_user`):** Intercepts incoming requests, extracts `user_id` from the session, queries the `User` model, and populates Flask’s global context `g.user`.
* **`limiter_middleware.py`:** Provides rate-limiting capabilities across sensitive endpoints (e.g., login attempts, chatbot messages) to protect against DDoS and brute-force attacks.

---

### 4.4. Routing Layer (`app/routes/` & `app/api/`)
The application cleanly separates **Page View Routes** from **REST API Endpoints**:

1. **`app/routes/` (Server-Side Page Views):**
   * Returns rendered Jinja2 templates.
   * `routes/admin/`: Admin panel views (Dashboard, Activities, Users, Academics, Calendar, Settings).
   * `routes/frontend/`: Public website views (Home, About Us, Courses, Activity Gallery, Facilities, Contact).
2. **`app/api/` (JSON REST API Endpoints):**
   * Uses `@jwt_required()` for protected admin operations.
   * Grouped into sub-modules: `auth/`, `academic/`, `dashboard/`, `activity.py`, `chatbot.py`, `frontend.py`, etc.
   * Automatically registered on startup by `app/api/__init__.py` using Python's `pkgutil` and `importlib`.

---

### 4.5. Controller Layer (`app/https/controllers/`)
* **`BaseController.py` (Template Method Pattern):**
  Defines standard CRUD operations:
  * `create(data)`: Validates and inserts records via `Utils.create`.
  * `all()`: Retrieves and serializes all records using the assigned Marshmallow schema.
  * `getById(id)`: Fetches a single entity.
  * `update(data)`: Updates attributes on the database model.
  * `delete()`: Deletes a model entity by ID.
* **Concrete Controllers (Inheritance):**
  * Controllers like `DepartmentController`, `SemesterController`, `SubjectController`, `YearController` simply inherit `BaseController(Model, Schema)` with zero duplicate code.
  * Specialized controllers like `ActivityController` and `DashboardController` extend the base functionality to handle multi-file uploads, image deletion from disk, and group-aware batch updates.
  * `FrontendController`: Aggregates complex statistics, active courses by department, upcoming academic calendar schedules, and research papers for the public UI.

---

### 4.6. Service & Helper Layer (`app/helpers/`)
* **`utils.py`:**
  * **`Utils` Class (Facade Pattern):** Encapsulates SQLAlchemy session management (`add`, `commit`, `rollback`, `filter_by`, `get`). Provides helpers such as `create_or_update()`, `bulk_create()`, `delete()`, and file upload helpers.
  * **`ResponseHelper` Class:** Standardizes API JSON envelopes:
    ```json
    { "success": true, "message": "Operation successful", "data": [...] }
    ```
* **`bot_services.py` (AI & RAG Pipeline):**
  * **Document Ingestion:** Reads knowledge PDF files using `PdfReader`, splits content into semantic chunks using `RecursiveCharacterTextSplitter`, generates vector embeddings, and stores them in **ChromaDB**.
  * **Retrieval-Augmented Generation (RAG):** When a user asks a question, it queries ChromaDB for relevant vector context, injects the context and conversation history into a bilingual prompt (Myanmar/English), and queries the Google Gemini API.

---

### 4.7. Data Models (`app/models/`) & Schemas (`app/schemas/`)
* **`app/models/` (SQLAlchemy Entities):**
  * Defines table schemas, primary/foreign keys, and model-level static methods (e.g., `Activity.save_file()`, `Activity.delete_file()`).
  * Key Entities: `User`, `Activity`, `Dashboard`, `Course`, `Department`, `Subject`, `Semester`, `AcademicCalendar`, `Laboratory`, `Research`, `Collaboration`, `Count`.
* **`app/schemas/` (Marshmallow DTOs):**
  * Serializes complex SQLAlchemy model instances into JSON dictionaries and handles nested relations (e.g., nesting Semester inside Course, Department inside Subject).

---

### 4.8. Frontend Modular Architecture (`app/resources/assets/admin/js/src/`)
The JavaScript code in the admin dashboard avoids spaghetti code by utilizing an **ES6 4-Tier Separation of Concerns**:

```
[DOM Click / Event]
       │
       ▼
1. events/*.event.js  ──► Reads Form Data & Instantiates Domain Model
       │
       ├──► 2. interfaces/*.js (Client Data Model)
       │
       ├──► 3. api/*.api.js (Axios HTTP Request with CSRF & Token Refresh Interceptors)
       │
       └──► 4. ui/*.ui.js (Updates HTML Table, Badges, Modals & Triggers Toast)
```

1. **`interfaces/`:** Defines client-side data structures (e.g., `Activity.js`).
2. **`api/`:** Handles all network communication via a shared Axios client.
3. **`ui/`:** Manages pure DOM rendering, table updates, and form pre-population.
4. **`events/`:** Binds UI event listeners (click, submit, change) and coordinates API requests with UI re-renders.
5. **`utils/api.js` (Interceptor Pattern):**
   * **Request Interceptor:** Injects CSRF tokens and displays the loading progress spinner.
   * **Response Interceptor:** Catches `401 Unauthorized` responses and automatically triggers silent token refresh via `/auth/refresh` before retrying the failed request.

---

## 5. End-to-End Execution Lifecycles

### 🔄 Lifecycle 1: Admin Creates an Activity (With File Upload)

```
1. Admin fills form and clicks "Save"
   │
   ▼
2. activity.event.js intercepts click
   ├── Validates inputs via FormValidation
   └── Sends FormData to activityApi.create(formData)
   │
   ▼
3. utils/api.js (Axios Interceptor)
   ├── Injects X-CSRF-TOKEN from cookie
   └── Starts loading indicator
   │
   ▼
4. Flask Route: POST /api/activity/create
   ├── @jwt_required() validates Access Token Cookie
   └── Forwards request to ActivityController.create()
   │
   ▼
5. ActivityController
   ├── Calls Activity.save_file(file) -> saves image to disk in resources/assets/media/activities/
   ├── Calls Utils.bulk_create(Activity, data) -> commits to MySQL DB
   └── Returns ResponseHelper.success("Created successfully!")
   │
   ▼
6. Client receives response:
   ├── toast.success() displays notification
   └── activityUI.render() refreshes the data table dynamically
```

---

### 🤖 Lifecycle 2: AI Chatbot Question & Retrieval (RAG)

```
1. User enters question on frontend widget: "When does the university semester start?"
   │
   ▼
2. Frontend sends POST to /api/frontend/chatbot/ask with { message, session_id }
   │
   ▼
3. BotController.getAnswer() calls bot_services.ask(question, session_id)
   │
   ▼
4. bot_services.py:
   ├── 1. Queries ChromaDB vector store for relevant document chunks (search_docs)
   ├── 2. Formats conversation history for session_id
   ├── 3. Constructs structured prompt (incorporating Persona, History, and Retrieved Context)
   ├── 4. Calls Gemini / Remote Bot Server
   └── 5. Saves Q&A pair to in-memory session history deque
   │
   ▼
5. Returns JSON { response: "...", session_id: "..." } to browser
   │
   ▼
6. Frontend chatbot UI appends the assistant reply bubble
```

---

## 6. Security Architecture

1. **Authentication:** Uses JSON Web Tokens (JWT) stored in secure, `HttpOnly`, `SameSite="Lax"` cookies to eliminate XSS token theft risks.
2. **CSRF Protection:** Double Submit CSRF Cookie verification. Axios reads `csrf_access_token` and injects it into the `X-CSRF-TOKEN` header on mutating requests (`POST`, `PUT`, `DELETE`).
3. **Password Hashing:** Passwords are hashed using strong cryptographic algorithms before saving to the database.
4. **SQL Injection Prevention:** 100% of database interactions leverage SQLAlchemy ORM parameterized queries.
5. **Rate Limiting:** IP and endpoint-based rate limits protect login and sensitive submission routes via Flask-Limiter.

---

## 7. Summary for Documentation

| Module / Folder | Primary Responsibility | Key Collaborators |
| :--- | :--- | :--- |
| `app/__init__.py` | Application factory, bootstrapping, lifecycle configuration | `core/`, `routes/`, `api/`, `models/` |
| `app/core/` | Global singletons (`db`, `ma`), config, security, context processors | `app/__init__.py`, Jinja2 views |
| `app/https/controllers/` | Request handling, business workflow orchestration, CRUD logic | `models/`, `schemas/`, `helpers/utils.py` |
| `app/https/middleware/` | Session extraction (`g.user`), rate limiting, request guards | Flask request pipeline |
| `app/models/` | Database entity definitions and disk file operations | SQLAlchemy, `helpers/utils.py` |
| `app/schemas/` | Serialization, filtering, and validation of database objects | Marshmallow, Controllers |
| `app/routes/` | Jinja2 template rendering for Admin and Frontend portals | Controllers, Templates |
| `app/api/` | RESTful JSON API endpoints for AJAX/Axios clients | Controllers, JWT Manager |
| `app/helpers/` | AI RAG pipeline, ChromaDB vector store, static DB utility facades | Gemini API, Controllers |
| `resources/assets/admin/js/src/` | Client-side modular UI/API/Event management | Backend REST APIs, Admin HTML |
