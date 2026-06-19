import { api } from "../utils/api.js";
import { getMonthName, getDay, getYear } from "../utils/helper.js";

/*<!--===========================
    GET ACTIVITES
=============================-->*/

const homeApi = {
    async fetchLastedActivities() {
        const res = await api.get("/frontend/home/activity");
        return res.data.activities;
    },
    async fetchLastedPublications() {
        const res = await api.get("/frontend/home/research");
        return res.data.researches;
    },
    async fetchCollaborations() {
        const res = await api.get("/frontend/collaboration/all");
        return res.data.collaborations;
    },
    async fetchStats() {
        const res = await api.get("/frontend/home/stats");
        return res.data;
    }
}

/*<!--====================================
    UI HAHNDLER
=======================================-->*/
const activityContainer = document.querySelector("#activity-card-container");
function getActivityImage(activity, preferredIndex = 0) {
    if (!Array.isArray(activity.images) || activity.images.length === 0) {
        return null;
    }

    return activity.images[preferredIndex]?.filepath || activity.images[0]?.filepath || null;
}

function getActivityUrl(activity) {
    return `/activity/${encodeURIComponent(activity.id)}`;
}

const homeUI = {
    renderActivities(activities) {
        activities.forEach(activity => {
            const imagePath = getActivityImage(activity, 1);
            const activityCard = `
                <a href="${getActivityUrl(activity)}" class="group block bg-white rounded-[2rem] p-4 shadow-sm hover:shadow-2xl hover:shadow-blue-500/30 transition-all duration-300 border-2 border-gray-200 hover:border-blue-500 hover:-translate-y-2">
                    <div class="flex items-center justify-between px-2 pb-4 pt-1">
                        <div class="flex items-center gap-3">
                            <div class="w-10 h-10 rounded-full bg-blue-50 flex items-center justify-center text-blue-600 overflow-hidden">
                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 7h.01M7 3h5c.512 0 1.024.195 1.414.586l7 7a2 2 0 010 2.828l-7 7a2 2 0 01-2.828 0l-7-7A1.994 1.994 0 013 12V7a4 4 0 014-4z"></path></svg>
                            </div>
                            <div>
                                
                                <p class="text-sm font-bold text-gray-900">${activity.category}</p>
                            </div>
                        </div>
                        
                        <div class="w-px h-8 bg-gray-200"></div>

                        <div class="flex items-center gap-3">
                            <div class="text-right">
                                
                                <p class="text-sm font-bold text-gray-900">${getMonthName(activity.date)} ${getDay(activity.date)}</p>
                            </div>
                            <div class="w-10 h-10 rounded-full bg-orange-50 flex items-center justify-center text-orange-600 overflow-hidden">
                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg>
                            </div>
                        </div>
                    </div>

                    <div class="relative h-64 w-full rounded-2xl overflow-hidden mb-5">
                        <img src="/assets/${imagePath}" alt="${activity.activity_name}" class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-105">
                    </div>

                    <div class="px-2 pb-5 flex items-center">
                        <span class="text-gray-900 font-extrabold text-base truncate"><span class="text-gray-500 mr-1">Activity:</span>${activity.activity_name}</span>
                    </div>

                    <div class="flex items-center justify-end px-2 pb-1">
                        <div class="bg-gray-800 group-hover:bg-blue-600 text-white px-6 py-2.5 rounded-xl text-sm font-bold transition-colors">
                            View Gallery
                        </div>
                    </div>
                </a>
            `;

            activityContainer.insertAdjacentHTML("beforeend", activityCard);
        });
    },
    renderCollaborations(collaborations) {
        const logoContainer = document.querySelector("#logo-track");

        // Double the list to ensure infinite seamless scrolling
        const cards = collaborations.map(c => `
            <div class="logo-item flex items-center justify-center p-8 w-64 h-48 shrink-0">
                <img src="/assets/media/collaborations/${c.logo}" class="max-h-full max-w-[95%] object-contain hover:grayscale-0 transition-all duration-300">
            </div>
        `).join('');

        // Append twice for infinite loop effect
        logoContainer.insertAdjacentHTML("beforeend", cards + cards);
    },
    renderStats(statsData) {
        const staffStat = document.getElementById('stat-staff-members');
        const graduatedStat = document.getElementById('stat-graduated-students');
        const currentStat = document.getElementById('stat-current-students');
        const rectorMsg = document.getElementById('rector-message-text');

        if (staffStat) staffStat.setAttribute('data-target', statsData.counts.total_staff || 0);
        if (graduatedStat) graduatedStat.setAttribute('data-target', statsData.counts.graduated_student || 0);
        if (currentStat) currentStat.setAttribute('data-target', statsData.counts.current_student || 0);

        if (rectorMsg && statsData.rector_message) {
            rectorMsg.innerText = statsData.rector_message;
        }
    }
}


/*<!--====================================
    EVENTS HAHNDLER
=======================================-->*/
const homeEvent = {
    init() {
        this.load();
    },
    async load() {
        const activities = await homeApi.fetchLastedActivities();
        homeUI.renderActivities(activities);


        const collaborations = await homeApi.fetchCollaborations();
        homeUI.renderCollaborations(collaborations);

        const statsData = await homeApi.fetchStats();
        homeUI.renderStats(statsData);

        requestAnimationFrame(() => {
            this.initLogoSlider();
        });

    },
    initLogoSlider() {

        const track = document.getElementById("logo-track");
        if (!track) return;

        const items = track.querySelectorAll(".logo-item");
        if (items.length === 0) return;

        let index = 0;

        function getItemWidth() {
            return items[0].offsetWidth + 32;
        }

        function slide() {
            const itemWidth = getItemWidth();

            index++;

            const maxIndex = items.length - 5; // safer (show 3 visible)

            if (index > maxIndex) {
                index = 0;
                track.style.transition = "none";
                track.style.transform = "translateX(0px)";
                track.offsetHeight; // reflow
                track.style.transition = "transform 700ms ease-in-out";
            } else {
                track.style.transform = `translateX(-${index * itemWidth}px)`;
            }
        }

        return setInterval(slide, 2000);
    }
}


/*<!--===================================
    BACKGROUND GRID ANIMATION SCRIPTS
====================================-->*/

// --- 1. Scroll Animation ---
const initScrollAnimations = () => {
    const observerOptions = {
        threshold: 0.1,
        rootMargin: "0px 0px -50px 0px"
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('active');

            } else {
                entry.target.classList.remove('active');
            }

        });
    }, observerOptions);

    document.querySelectorAll('.scroll-animate').forEach(section => {
        observer.observe(section);
    });
};

// --- 2. Three.js (Tech Grid & Particles ONLY) ---
const initThreeJS = () => {
    const container = document.getElementById('canvas-container');
    if (!container) return;

    const scene = new THREE.Scene();
    scene.fog = new THREE.FogExp2(0xffffff, 0.02);

    const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
    camera.position.z = 35;
    camera.position.y = 10; // Tilted view
    camera.lookAt(0, 0, 0);

    const renderer = new THREE.WebGLRenderer({ alpha: true, antialias: true });
    renderer.setSize(window.innerWidth, window.innerHeight);
    renderer.setPixelRatio(window.devicePixelRatio);
    container.appendChild(renderer.domElement);

    // --- Tech Grid Floor ---
    const gridHelper = new THREE.GridHelper(150, 50, 0x0071e3, 0x0071e3);
    gridHelper.position.y = -20;
    gridHelper.material.opacity = 0.2;
    gridHelper.material.transparent = true;
    scene.add(gridHelper);

    // --- Floating Particles (Digital Dust) ---
    const particlesGeometry = new THREE.BufferGeometry();
    const particlesCount = 2500;
    const posArray = new Float32Array(particlesCount * 3);
    for (let i = 0; i < particlesCount * 3; i++) {
        posArray[i] = (Math.random() - 0.5) * 150;
    }
    particlesGeometry.setAttribute('position', new THREE.BufferAttribute(posArray, 3));
    const particlesMaterial = new THREE.PointsMaterial({
        size: 0.15,
        color: 0xbae6fd,
        transparent: true,
        opacity: 0.4
    });
    const particlesMesh = new THREE.Points(particlesGeometry, particlesMaterial);
    scene.add(particlesMesh);

    // --- Lighting ---
    const ambientLight = new THREE.AmbientLight(0xffffff, 0.6);
    scene.add(ambientLight);

    const pointLight = new THREE.PointLight(0x0071e3, 1, 100);
    pointLight.position.set(20, 50, 20);
    scene.add(pointLight);

    const pointLight2 = new THREE.PointLight(0x00d2ff, 0.5, 100);
    pointLight2.position.set(-20, -10, 20);
    scene.add(pointLight2);

    // --- Interaction & Animation ---
    let mouseX = 0;
    let mouseY = 0;

    document.addEventListener('mousemove', (event) => {
        mouseX = (event.clientX - window.innerWidth / 2);
        mouseY = (event.clientY - window.innerHeight / 2);
    });

    const clock = new THREE.Clock();

    const animate = () => {
        requestAnimationFrame(animate);
        const elapsedTime = clock.getElapsedTime();

        // Rotate Grid slowly
        gridHelper.rotation.y = elapsedTime * 0.02;

        // Particle flow
        particlesMesh.rotation.y = elapsedTime * 0.1;
        particlesMesh.rotation.x = elapsedTime * 0.05;

        renderer.render(scene, camera);
    };
    animate();

    window.addEventListener('resize', () => {
        camera.aspect = window.innerWidth / window.innerHeight;
        camera.updateProjectionMatrix();
        renderer.setSize(window.innerWidth, window.innerHeight);
    });
};

// --- 3. Counter Animation ---
const initCounters = () => {
    const counters = document.querySelectorAll('.count-up');
    const speed = 200;

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const counter = entry.target;
                const updateCount = () => {
                    const target = +counter.getAttribute('data-target');
                    const count = +counter.innerText;
                    const inc = target / speed;

                    if (count < target) {
                        counter.innerText = Math.ceil(count + inc);
                        setTimeout(updateCount, 20);
                    } else {
                        counter.innerText = target;
                    }
                };
                updateCount();
                observer.unobserve(counter);
            }
        });
    }, { threshold: 0.5 });

    counters.forEach(counter => observer.observe(counter));
};



/*<!--====================
    MIAN ENTRY
======================-->*/

document.addEventListener('DOMContentLoaded', function () {


    homeEvent.init();


    /*<!--==========================
        INITIALIZE ALL ANIMATIONS
    =============================-->*/
    initThreeJS();
    initCounters();
    initScrollAnimations();


    /*<!--====================
        HOME SLIDER
    ======================-->*/
    const slides = document.querySelectorAll('.hero-slide');
    let currentSlide = 0;

    setInterval(() => {
        slides[currentSlide].classList.remove('opacity-100', 'z-10');
        slides[currentSlide].classList.add('opacity-0', 'z-0');

        currentSlide = (currentSlide + 1) % slides.length;

        slides[currentSlide].classList.remove('opacity-0', 'z-0');
        slides[currentSlide].classList.add('opacity-100', 'z-10');
    }, 6000);

    const reveals = document.querySelectorAll('.reveal');

    const revealOnScroll = () => {
        for (let i = 0; i < reveals.length; i++) {
            const windowHeight = window.innerHeight;
            const elementTop = reveals[i].getBoundingClientRect().top;
            const elementVisible = 100;

            if (elementTop < windowHeight - elementVisible) {
                reveals[i].classList.add('active');
            }
        }
    };
    window.addEventListener('scroll', revealOnScroll);
    revealOnScroll(); // Trigger once on load


    /*<!--===============================================
        REPUBLICATIONS NUMBER COUNTS ANIMATION
    ================================================-->*/
    const counters = document.querySelectorAll('.counter');
    let hasCounted = false;

    const animateCounters = () => {
        counters.forEach(counter => {
            const target = +counter.getAttribute('data-target');
            const duration = 2000; // ms
            const increment = target / (duration / 16); // 60fps
            let current = 0;

            const updateCounter = () => {
                current += increment;
                if (current < target) {
                    counter.innerText = Math.ceil(current) + (target > 3000 ? '+' : '');
                    requestAnimationFrame(updateCounter);
                } else {
                    counter.innerText = target + (target > 3000 ? '+' : '');
                }
            };
            updateCounter();
        });
    };

    // Observer to start counters when visible
    const counterSection = document.querySelector('.counter').closest('section');
    const observer = new IntersectionObserver((entries) => {
        if (entries[0].isIntersecting && !hasCounted) {
            animateCounters();
            hasCounted = true;
        }
    }, { threshold: 0.5 });

    if (counterSection) observer.observe(counterSection);




    const track = document.getElementById("logo-track");

    if (!track) return;

    const items = track.children;

    if (items.length === 0) return;

    const itemWidth = items[0].offsetWidth + 32; // 32 = gap-8

    let index = 0;

    function slide() {

        index++;

        const maxIndex = items.length - 5;
        // show 3 items at a time feel (adjust if needed)

        if (index > maxIndex) {
            index = 0;
            track.style.transition = "none";
            track.style.transform = "translateX(0px)";

            track.offsetHeight; // force reflow

            track.style.transition = "transform 700ms ease-in-out";
        } else {
            track.style.transform = `translateX(-${index * itemWidth}px)`;
        }
    }

    setInterval(slide, 2000);

});
