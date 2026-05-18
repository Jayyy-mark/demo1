from . import frontend_bp
from flask import render_template, abort



# Mock Database of Announcements (For demonstration)
news_data = [
    {
        "id": 1,
        "title": "First Year Orientation Schedule 2024",
        "date": "Oct 12, 2024",
        "category": "Academic",
        "summary": "The orientation program for the new academic year begins next week.",
        "image": "https://picsum.photos/id/101/1920/1080",
        "content": "<p>The University of Computer Studies, Taungoo is pleased to announce the orientation schedule for the First Year B.C.Sc and B.C.Tech students for the 2024-2025 academic year.</p><p class='mt-4'>The program includes registration, campus tour, and a welcome session with the Rector. All new students are required to attend.</p>"
    },
    {
        "id": 2,
        "title": "UCSTGO Tech Fest 2024 Winners",
        "date": "Nov 05, 2024",
        "category": "Event",
        "summary": "Celebrating the winners of our annual innovation competition.",
        "image": "https://picsum.photos/id/180/1920/1080",
        "content": "<p>We are proud to announce the winners of the 2024 Tech Fest. The competition was fierce, with over 50 projects submitted. The judges were impressed by the quality and innovation displayed.</p><p class='mt-4'>1st Place: Team Alpha (AI Chatbot)<br>2nd Place: Team Beta (Campus Map)</p>"
    },
    {
        "id": 3,
        "title": "Library Digital Archive Upgrade",
        "date": "Nov 20, 2024",
        "category": "Notice",
        "summary": "New features added to the digital library portal.",
        "image": "https://picsum.photos/id/225/1920/1080",
        "content": "<p>The digital library has undergone a major upgrade. Users can now access over 10,000 new journals and research papers. The search functionality has also been improved for better accessibility.</p>"
    }
]


@frontend_bp.route('/activities')
def activities():
    return render_template('frontend/activities.html', news_list=news_data)


@frontend_bp.route('/news/<int:news_id>')
def news_detail(news_id):

    # Find the specific news item (In real app, use: NewsItem.query.get_or_404(news_id))
    news_item = next((item for item in news_data if item["id"] == news_id), None)

    if not news_item:
        return "News not found", 404

    return render_template('frontend/news_detail.html', news=news_item)


@frontend_bp.route('/activity/<int:activity_id>')
def activity_detail(activity_id):

    activities_data = {
        1: {
            "title": "2025 Inter-University Race",
            "date": "March 15, 2025",
            "description": "Our athletes competed against 10 universities, bringing home gold medals in the 100m and relay events. A day of sportsmanship and excellence.",
            "images": [
                "https://picsum.photos/seed/race1/800/600",
                "https://picsum.photos/seed/race2/800/600",
                "https://picsum.photos/seed/race3/800/600",
                "https://picsum.photos/seed/race4/800/600",
                "https://picsum.photos/seed/race5/800/600",
                "https://picsum.photos/seed/race6/800/600"
            ]
        },
        2: {
            "title": "Tech Innovation Week 2024",
            "date": "Nov 20, 2024",
            "description": "A week-long showcase of student projects, hackathons, and robotics demonstrations. Students from various departments presented cutting-edge solutions to real-world problems.",
            "images": [
                "https://picsum.photos/seed/tech1/800/600",
                "https://picsum.photos/seed/tech2/800/600",
                "https://picsum.photos/seed/tech3/800/600",
                "https://picsum.photos/seed/tech4/800/600"
            ]
        },
        3: {
            "title": "Annual Cultural Festival",
            "date": "Oct 10, 2024",
            "description": "Celebrating diversity through music, dance, and traditional food fairs. Students showcased their heritage through colorful costumes and performances.",
            "images": [
                "https://picsum.photos/seed/cult1/800/600",
                "https://picsum.photos/seed/cult2/800/600",
                "https://picsum.photos/seed/cult3/800/600",
                "https://picsum.photos/seed/cult4/800/600",
                "https://picsum.photos/seed/cult5/800/600"
            ]
        }
    }

    activity = activities_data.get(activity_id)

    if activity is None:
        abort(404)

    return render_template('frontend/activity_gallery.html', activity=activity)
