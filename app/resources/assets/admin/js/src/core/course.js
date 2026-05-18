//<!--=============================
//  COURSE CORE SCRIPTS
//===============================-->

import { courseEvent } from "../events/course.event.js";

$(document).ready(function(){
    courseEvent.init();

    $(`input[type=text]`).on('input',function(){
        const clearBtn = $(this).next('.clear-btn');
        if($(this).val().trim()==''){
            clearBtn.css('display', 'none');
        }else{
            clearBtn.css('display','block');
        }
    })

    $('.clear_filters').on('click', function(){
        $(this).prev(`input[type=text]`).val(null);
        $(this).css('display','none');
    });
});