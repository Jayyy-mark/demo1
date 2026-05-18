//static/js/app/building.js
//<!--======================================
// BUILDING CORE SCRIPTS
//======================================-->

import { authEvent } from "../events/auth.event.js";

$(document).ready(function(){
    authEvent.init();
});