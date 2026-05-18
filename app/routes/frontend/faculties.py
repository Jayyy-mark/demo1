from . import frontend_bp
from flask import render_template

@frontend_bp.route('/faculties/<string:dept_code>')
def department_detail(dept_code):

    #<!--====================================================================================
    #    Database of Department Information (you can update you department information here)
    #======================================================================================-->

    departments_db = {
        "cs": {
            "name": "Department of Computer Science",
            "vision": "To develop human resources who can support society by applying Computer science and technology that is capable of life-long learning and powerful problem-solving skills.",
            "mission": "To encourage the emergence of students with strong ability in self-motivation, critical thinking and problem solving to succeed in the professional field</br>To provide the required resources for research and learning courses<br>To develop ethically and technically innovative students who meet the industrial needs",
            "vision_mm": "ကွန်ပျူတာသိပ္ပံနည်းပညာရပ်များကိုအသုံးချ၍ လူမှုအဖွဲ့အစည်းကို အကျိုးပြုနိုင်ပြီး စဉ်ဆက်မပြတ် လေ့လာနိုင်စွမ်း ရှိသော၊ နည်းပညာဆိုင်ရာပြဿနာများကို ကျွမ်းကျင်စွာ ကိုင်တွယ်ဖြေရှင်းနိုင်စွမ်းရှိသော လူ့စွမ်းအား အရင်း အမြစ်များ မွေးထုတ်ပေးရန်။ ",
            "mission_mm": "အသက်မွေးဝမ်းကြောင်းနယ်ပယ်တွင်အောင်မြင်ရန် လိုအပ်သောပညာရပ်များကို မိမိကိုယ်တိုင် တက်ကြွစွာ ရှာဖွေနိုင်စွမ်းရှိသော၊ ကျိုးကြောင်းဆီလျော်စွာ စဉ်းစားဆုံးဖြတ်နိုင်စွမ်းရှိသော၊ ကြုံတွေ့ရသည့် ပြဿနာများ ကို ကျွမ်းကျင်စွာ ဖြေရှင်းနိုင်စွမ်းရှိသော ကျောင်းသား၊ ကျောင်းသူများ ပေါ်ထွန်းလာစေရေးအတွက် တွန်းအားပေးရန်။သုတေသနနှင့် ဘာသာရပ်များ လေ့လာသင်ယူရာတွင် လိုအပ်သောအရင်းအမြစ်များကို ဖြည့်ဆည်း ပေးနိုင်ရန်။နည်းပညာဆိုင်ရာကျင့်ဝတ်နှင့်အညီ တီထွင်ဖန်တီးနိုင်စွမ်းရှိသော၊ ပြင်ပလုပ်ငန်းလုပ်ငန်းခွင်၏ လိုအပ်ချက် များ နှင့်ကိုက်ညီသော ကျောင်းသား၊ ကျောင်းသူများ မွေးထုတ်ပေးရန်။",
        },
        "is": {
            "name": "Department of Information Systems",
            "vision": "To become a premier hub for Information Systems education and research, recognized for excellence in teaching and innovative applications of IT solutions.",
            "mission": "To educate and train information technology professionals capable of designing, implementing, and managing secure information systems that drive organizational success and social benefit."
        },
        "se": {
            "name": "Department of Software Engineering",
            "vision": "To be the global leader in software engineering education, advancing the state of the art in software design and development methodologies.",
            "mission": "To develop world-class software engineers capable of building high-quality, reliable, and scalable software systems for a rapidly changing technological landscape."
        },
        "nce": {
            "name": "Department of Network & Communication Engineering",
            "vision": "To empower students with cutting-edge knowledge in networking, communications, and embedded systems, preparing them to lead in the era of ubiquitous connectivity.",
            "mission": "To produce graduates who can design robust network architectures and implement efficient communication protocols to bridge the digital divide."
        },
        "csec": {
            "name": "Department of Cyber Security",
            "vision": "To create a secure cyberspace by educating the next generation of cybersecurity experts capable of protecting critical infrastructure and information assets.",
            "mission": "To advance the science and practice of cyber defense through rigorous training, innovative research, and strategic partnerships with industry leaders."
        },
        "ai": {
            "name": "Department of Artificial Intelligence",
            "vision": "To be at the forefront of the AI revolution, integrating intelligent systems into every aspect of human life to solve complex global challenges.",
            "mission": "To research and develop intelligent algorithms, machine learning models, and neural networks that mimic cognitive functions and augment human capabilities."
        },
        "es": {
            "name": "Department of Embedded Systems",
            "vision": "To drive innovation in the Internet of Things (IoT) and smart systems, creating a connected world where devices interact seamlessly and intelligently.",
            "mission": "To design and develop energy-efficient, high-performance embedded computing solutions for automotive, industrial, and consumer electronics sectors."
        },
        "rnd": {
            "name": "Department of Research & Development",
            "vision": "To be the engine of innovation for UCSTGO, facilitating cutting-edge research that addresses real-world problems through technology.",
            "mission": "To foster a research culture that encourages discovery, collaboration, and the translation of theoretical knowledge into practical applications."
        },
        "math": {
            "name": "Department of Mathematics & Physics",
            "vision": "To provide a strong foundation in mathematical sciences and physics, essential for advancing engineering and technology fields.",
            "mission": "To equip students with analytical skills and scientific reasoning capabilities necessary to support the advancement of computer science and engineering disciplines."
        }
    }

    
    dept_data = departments_db.get(dept_code) #get department data based on department code

    if not dept_data:
        return "Department Not Found", 404

    return render_template('frontend/departments.html', department=dept_data)
