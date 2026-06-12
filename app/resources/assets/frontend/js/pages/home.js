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
    async fetchCollaborations(){
        const res = await api.get("/frontend/collaboration/all");
        return res.data.collaborations;
    }
}

/*<!--====================================
    UI HAHNDLER
=======================================-->*/
const activityContainer = document.querySelector("#activity-card-container");

function getActivityUrl(activity) {
    return `/activity/${encodeURIComponent(activity.id)}`;
}

const homeUI = {
    renderActivities(activities) {
        activities.forEach(activity => {
            const activityCard = `
                <a href="${getActivityUrl(activity)}" class="group block bg-white rounded-3xl overflow-hidden shadow-sm hover:shadow-2xl transition-all duration-300 hover:-translate-y-2 cursor-pointer">
                    <div class="relative h-64 overflow-hidden">
                        <img src="assets/${activity.images[0].filepath}" alt="Race" class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-105">
                        <div class="absolute inset-0 bg-black/0 group-hover:bg-black/10 transition-colors duration-300"></div>
                        <span class="absolute top-4 left-4 bg-white/90 backdrop-blur text-xs font-bold text-apple-blue uppercase tracking-wider px-3 py-1 rounded-full">${activity.category}</span>
                    </div>
                    <div class="p-8">
                        <h3 class="text-xl font-bold text-apple-dark mb-2 group-hover:text-apple-blue transition-colors">${activity.activity_name}</h3>
                        <p class="text-gray-500 text-sm leading-relaxed mb-4">${activity.description}</p>
                        <div class="flex items-center text-sm font-semibold text-apple-blue"><span>View Gallery</span></div>
                    </div>
                </a>
            `;

            activityContainer.insertAdjacentHTML("beforeend", activityCard);
        });
    },
    renderCollaborations(collaborations){
        const logoContainer = document.querySelector("#logo-track");

        // Double the list to ensure infinite seamless scrolling
        const cards = collaborations.map(c => `
            <div class="logo-item flex items-center justify-center p-8 w-64 h-48 shrink-0">
                <img src="/assets/media/collaborations/${c.logo}" class="max-h-full max-w-[95%] object-contain hover:grayscale-0 transition-all duration-300">
            </div>
        `).join('');

        // Append twice for infinite loop effect
        logoContainer.insertAdjacentHTML("beforeend", cards + cards);
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
