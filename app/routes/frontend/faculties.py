from flask import render_template
from . import frontend_bp

@frontend_bp.route('/faculties/<string:dept_code>')
def department_detail(dept_code):

    departments_db = {
        "fcs": {
            "name": "Faculty of Computer Science (FCS)",
            "vision": "To develop human resources who can support society by applying Computer science and technology that is capable of life-long learning and powerful problem-solving skills.",
            "vision_mm": "ကွန်ပျူတာသိပ္ပံနည်းပညာရပ်များကိုအသုံးချ၍ လူမှုအဖွဲ့အစည်းကို အကျိုးပြုနိုင်ပြီး စဉ်ဆက်မပြတ် လေ့လာနိုင်စွမ်း ရှိသော၊ နည်းပညာဆိုင်ရာပြဿနာများကို ကျွမ်းကျင်စွာ ကိုင်တွယ်ဖြေရှင်းနိုင်စွမ်းရှိသော လူ့စွမ်းအား အရင်း အမြစ်များ မွေးထုတ်ပေးရန်။ ",
            # စာသားတွေကို စာရင်း (List) ပုံစံဖြင့် စနစ်တကျ ခွဲထုတ်လိုက်ပါသည်
            "mission": [
                "To encourage the emergence of students with strong ability in self-motivation, critical thinking and problem solving to succeed in the professional field",
                "To provide the required resources for research and learning courses",
                "To develop ethically and technically innovative students who meet the industrial needs"
            ],
            "mission_mm": [
                "အသက်မွေးဝမ်းကြောင်းနယ်ပယ်တွင် အောင်မြင်ရန် လိုအပ်သောပညာရပ်များကို မိမိကိုယ်တိုင် တက်ကြွစွာ ရှာဖွေနိုင်စွမ်းရှိသော၊ ကျိုးကြောင်းဆီလျော်စွာ စဉ်းစားဆုံးဖြတ်နိုင်စွမ်းရှိသော၊ ကြုံတွေ့ရသည့် ပြဿနာများကို ကျွမ်းကျင်စွာ ဖြေရှင်းနိုင်စွမ်းရှိသော ကျောင်းသား၊ ကျောင်းသူများ ပေါ်ထွန်းလာစေရေးအတွက် တွန်းအားပေးရန်။",
                "သုတေသနနှင့် ဘာသာရပ်များ လေ့လာသင်ယူရာတွင် လိုအပ်သောအရင်းအမြစ်များကို ဖြည့်ဆည်းပေးနိုင်ရန်။",
                "နည်းပညာဆိုင်ရာကျင့်ဝတ်နှင့်အညီ တီထွင်ဖန်တီးနိုင်စွမ်းရှိသော၊ ပြင်ပလုပ်ငန်းခွင်၏ လိုအပ်ချက်များနှင့် ကိုက်ညီသော ကျောင်းသား၊ ကျောင်းသူများ မွေးထုတ်ပေးရန်။"
            ],
        },
        "fcst": {
            "name": "Faculty Of Computer Systems and Technologies (FCST)",
            "vision": "To produce outstanding computer technicians by doing teaching and research.",
            "vision_mm": "သင်ကြားရေးနှင့် သုတေသနလုပ်ငန်းများဆောင်ရွက်၍ အရည်အချင်းပြည့်ဝသော ကွန်ပျူတာနည်းပညာရှင်များ ပေါ်ထွန်းလာစေရန် မျှော်မှန်းပါသည်။",
            "mission": [
                "To create strong research environment by encouraging practical teaching",
                "To increase job opportunities collaboration with IT industry",
                "To be skillful technicians who will support contribution to the society"
            ],
            "mission_mm": [
                "လက်တွေ့သင်ကြားမှုများကို အားပေးမြှင့်တင်ရန်နှင့် တီထွင်ဖန်တီးမှု အားကောင်းသော သုတေသနပတ်ဝန်းကျင် ဖန်တီးပေးရန်။",
                "ပြင်ပလုပ်ငန်းခွင်များနှင့် ချိတ်ဆက်၍ အလုပ်အကိုင်အခွင့်အလမ်းများ တိုးမြှင့်ပေးရန်။",
                "လူမှုပတ်ဝန်းကျင်ကို အထောက်အကူပြုစေမည့် ကျွမ်းကျင်သည့်နည်းပညာရှင်များ ဖြစ်စေရန်။"
            ]
        },
        "fis": {
            "name": "Faculty Of Information Science (FIS)",
            "vision": "To develop the innovative human resources in Data Science and Information Science to meet with the local needs.",
            "vision_mm": "IT နည်းပညာကို အသုံးပြု၍ ဒေသတွင်းလိုအပ်နေသည့် သတင်းအချက်အလက် ပညာရှင်များမွေးထုတ်ပေးရန်။",
            "mission": [
                "To create positive teaching and learning environments to solve the real problems",
                "To perform the emergence of technicians who can create and analyze successfully in real environment with strong ethics"
            ],
            "mission_mm": [
                "IT နည်းပညာဆိုင်ရာ လက်တွေ့ပြဿနာများကို ဖြေရှင်းနိုင်သော စွမ်းရည်တိုးတက်စေသော သင်ကြားမှု၊ သင်ယူမှု ပတ်ဝန်းကျင်ကောင်း ဖန်တီးပေးရန်။",
                "ကျင့်ဝတ်လိုက်နာသော၊ လက်တွေ့နယ်ပယ်တွင် အောင်မြင်ပြီး တီထွင်ဖန်တီး ဆန်းစစ်နိုင်သော ပညာရှင်များ ဖြစ်ထွန်းလာစေရေး ကြိုးပမ်းဆောင်ရွက်ရန်။"
            ]
        },
        "itsm": {
            "name": "Department of Information Technology Supporting and Maintenance (ITSM)",
            "vision": "To produce innovative technicians for information technology development.",
            "vision_mm": "သတင်းအချက်အလက်နည်းပညာဖွံ့ဖြိုးတိုးတက်ရေးအတွက် တီထွင်ဖန်တီးနိုင်သော နည်းပညာရှင်များ မွေးထုတ်ပေးရန်။",
            "mission": [
                "To apply technologies fundamentally in IT industry."
            ],
            "mission_mm": [
                "သတင်းအချက်အလက်နည်းပညာ အသုံးပြုသည့် လုပ်ငန်းခွင်များတွင် အထောက်အကူဖြစ်စေနိုင်သော နည်းပညာများကို အခြေခံမှစ၍ နားလည် တတ်မြောက်ပြီး အသုံးချနိုင်စေရန်။"
            ]
        },
        "fc": {
            "name": "Faculty Of Computing (FC)",
            "vision": "To produce outstanding students who can use advanced mathematics in ICT and research",
            "mission": [
                "To help a good understanding of mathematics and develop critical thinking skill in the field of ICT and research"
            ],
            "vision_mm": "ICTဘာသာရပ်များနှင့် သုတေသနလုပ်ငန်းများတွင် အထောက်အပံ့ပေးနိုင်သော သင်္ချာဘာသာရပ်များကို ကျွမ်းကျင်ပိုင်နိုင်စွာ အသုံးချနိုင်သည့် ထူးချွန်ထက်မြက်သောကျောင်းသား/သူများ မွေးထုတ်ပေးရန်။",
            "mission_mm": [
                "သင်္ချာဘာသာရပ်ကို ကောင်းစွာနားလည်တတ်မြောက်ပြီး ICT ဆိုင်ရာဘာသာရပ်နယ်ပယ်များနှင့် သုတေသနလုပ်ငန်းများတွင် ဆက်စပ်တွက်ချက်နိုင်စွမ်းကို လေ့ကျင့်သင်ကြားပေးရန်။"
            ]
        },
        "dl": {
            "name": "Department Of Language",
            "vision": "To emerge fully-fledged computer technicians who understand and preserve Myanmar Language and Culture",
            "mission": [
                "To be able to write correctly and speak fluently in Myanmar Literacy",
                "To understand and obey Myanmar Culture and Ethics",
                "To improve constantly teaching abilities of teachers"
            ],
            "vision_mm": "မြန်မာစာပေ မြန်မာဘာသာစကားနှင့်ယဉ်ကျေးမှုကို နားလည်ထိန်းသိမ်းတတ်သော ကိုယ်ကျင့်သိက္ခာပြည့်ဝသော ကွန်ပျူတာပညာရှင်များဖြစ်လာစေရန် မျှော်မှန်းပါသည်။",
            "mission_mm": [
                "မြန်မာစာပေ အရေးအသားနှင့် ဘာသာစကားစွမ်းရည်များ စနစ်ကျမှန်ကန်စွာ ရေးသားပြောဆိုနိုင်ရန်။",
                "မြန်မာ့ယဉ်ကျေးမှုနှင့် လူမှုကျင့်ဝတ်များကို သိရှိနားလည်လိုက်နာစေရန်။",
                "သင်ကြားရေး ဆရာ ဆရာမများ၏ ဘာသာရပ်စွမ်းရည်များ အစဉ်တိုးတက်အောင် ဆောင်ရွက်ရန်။"
            ]
        },
        "dns": {
            "name": "Department Of Natural Science",
            "vision": "To be the engine of innovation for UCSTGO, facilitating cutting-edge research that addresses real-world problems through technology.",
            "mission": [
                "To foster a research culture that encourages discovery, collaboration, and the translation of theoretical knowledge into practical applications."
            ],
            "vision_mm": "ကွန်ပျူတာဘာသာရပ်များ၊ သုတေသနလုပ်ငန်းများနှင့်၊ ပြင်ပလုပ်ငန်းခွင်များကို အထောက်အပံ့ပေးနိုင်သည့် အရည်အသွေးမြင့် ရူပဗေဒဘာသာရပ် ဖြစ်စေရန်။",
            "mission_mm": [
                "အဆင့်မြင့်သင်ကြားမှုနှင့် ဒေသအကျိုးပြု သုတေသနနယ်ပယ်များတွင် အသုံးချနိုင်သောပညာရပ် ဖြစ်စေရေးအတွက် သင်ရိုးညွှန်းတမ်းများ ပြင်ဆင်ရေးဆွဲရန်။",
                "ကျောင်းသားကျောင်းသူများအတွက် သီအိုရီနှင့်လက်တွေ့ဆက်စပ်မှုကို သင်ကြားပေးရန်။",
                "သုတေသနနှင့် ဒေသအကျိုးပြုလုပ်ငန်းများတွင် အတူတကွ ပူးပေါင်းဆောင်ရွက်ရန်။"
            ]
        },
        "da": {
            "name": "Department Of Administration",
            "vision": "To support well-balanced implementation of teaching and research and to cooperate as qualified and responsible staffs",
            "mission": [
                "To support teaching and research activities in accordance with procedures and to strive to perform well-qualified staffs"
            ],
            "vision_mm": "သင်ကြားရေးနှင့်သုတေသနကို ဟန်ချက်ညီစွာ အကောင်အထည်ဖော်ဆောင်ရွက်နိုင်ရေးအတွက် ပံ့ပိုးဖြည့်ဆည်းပေးရန်နှင့် အရည်အချင်းပြည့်ဝပြီး တာဝန်သိဝန်ထမ်းကောင်းများအဖြစ် ပူးပေါင်းဆောင်ရွက်နိုင်စေရန်၊",
            "mission_mm": [
                "သင်ကြားရေးနှင့် သုတေသနလုပ်ငန်းများကို ပံ့ပိုးဖြည့်ဆည်းရာတွင် လုပ်ထုံးလုပ်နည်းများနှင့်အညီ ဆောင်ရွက်ပေးရန်နှင့် အရည်အချင်းပြည့်ဝသော ဝန်ထမ်းကောင်းဖြစ်စေရေးအတွက် ကြိုးပမ်းဆောင်ရွက်ပေးရန်၊"
            ]
        },
        "df": {
            "name": "Department Of Finance",
            "vision": "To have the financial adequacy necessary to become a developed university To spend nation’s incomes and expenditures systematically without losing according to the financial rules",
            "mission": [
                "To equip students with analytical skills and scientific reasoning capabilities necessary to support the advancement of computer science and engineering disciplines."
            ],
            "vision_mm": "ဖွံ့ဖြိုးတိုးတက်သော တက္ကသိုလ်ဖြစ်လာစေရေးအတွက် လိုအပ်သော ငွေကြေးကဏ္ဍ ပြည့်စုံလုံလောက်မှု ရှိစေရန်။နိုင်ငံတော်၏ ရငွေများ၊ သုံးငွေများအား လေလွင့်ဆုံးရှုံးမှုမရှိစေရန် ဘဏ္ဍာရေးစည်းမျဉ်းနှင့်အညီ စနစ်တကျသုံးစွဲရန်",
            "mission_mm": [
                "စီမံကိန်းစာရင်းအင်းများနှင့် ရ/သုံးဆိုင်ရာ ငွေစာရင်းများကို ပါမောက္ခချုပ်မှ လမ်းညွှန်သည့်အတိုင်း ဌာနမှူးများနှင့်အတူ ညှိနှိုင်းရေးဆွဲရန်။",
                "ဌာနအသီးသီးမှ လိုအပ်ချက်များအား ဖြည့်ဆည်းပေးရန်"
            ]
        },
        "dsa": {
            "name": "Department Of Student Affairs",
            "vision": "To have the financial adequacy necessary to become a developed university To spend nation’s incomes and expenditures systematically without losing according to the financial rules",
            "mission": [
                "To draw the statistic planning and budgets with head of departments under the rector’s guidance",
                "To fulfill the requirements of departments"
            ],
            "vision_mm": "ကွန်ပျူတာသိပ္ပံနည်းပညာရပ်များကိုအသုံးချ၍ လူမှုအဖွဲ့အစည်းကို အကျိုးပြုနိုင်ပြီး စဉ်ဆက်မပြတ် လေ့လာနိုင်စွမ်း ရှိသော၊ နည်းပညာဆိုင်ရာပြဿနာများကို ကျွမ်းကျင်စွာ ကိုင်တွယ်ဖြေရှင်းနိုင်စွမ်းရှိသော လူ့စွမ်းအား အရင်း အမြစ်များ မွေးထုတ်ပေးရန်။",
            "mission_mm": [
                "အသက်မွေးဝမ်းကြောင်းနယ်ပယ်တွင်အောင်မြင်ရန် လိုအပ်သောပညာရပ်များကို မိမိကိုယ်တိုင် တက်ကြွစွာ ရှာဖွေနိုင်စွမ်းရှိသော၊ ကျိုးကြောင်းဆီလျော်စွာ စဉ်းစားဆုံးဖြတ်နိုင်စွမ်းရှိသော၊ ကြုံတွေ့ရသည့် ပြဿနာများကို ကျွမ်းကျင်စွာ ဖြေရှင်းနိုင်စွမ်းရှိသော ကျောင်းသား၊ ကျောင်းသူများ ပေါ်ထွန်းလာစေရေးအတွက် တွန်းအားပေးရန်။",
                "သုတေသနနှင့် ဘာသာရပ်များ လေ့လာသင်ယူရာတွင် လိုအပ်သောအရင်းအမြစ်များကို ဖြည့်ဆည်းပေးနိုင်ရန်။",
                "နည်းပညာဆိုင်ရာကျင့်ဝတ်နှင့်အညီ တီထွင်ဖန်တီးနိုင်စွမ်းရှိသော၊ ပြင်ပလုပ်ငန်းလုပ်ငန်းခွင်၏ လိုအပ်ချက်များနှင့်ကိုက်ညီသော ကျောင်းသား၊ ကျောင်းသူများ မွေးထုတ်ပေးရန်။"
            ]
        },
    }

    dept_data = departments_db.get(dept_code)
    if not dept_data:
        return "Department Not Found", 404

    return render_template('frontend/departments.html', department=dept_data)