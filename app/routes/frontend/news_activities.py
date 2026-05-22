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


@frontend_bp.route('/activity', endpoint='activity')
def activities():
    return render_template('frontend/activity.html', news_list=news_data)



@frontend_bp.route('/activity/<int:id>', endpoint='activityGallery')
def activity_detail(id):
    return render_template('frontend/activity_gallery.html', activity_id=id)
