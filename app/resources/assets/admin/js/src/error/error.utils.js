//==============================
// Error Handling
//===============================

export const errorUtils = {
    _404(){
        window.location.href = '/error/404';
    },
    _500(message){
        window.location.href = '/error/500';
        console.log("hello world!");
    },
    _503(message){
        console.log(message);
        window.location.href = '/error/503';
    },
    _401(message){
        console.log(message);
        window.location.replace('/admin/auth/login');
    },
    _402(message){
        console.log(message);
        window.location.href = '/error/402';
    },
    _403(message){
        console.log(message);
        window.location.href = '/error/403';
    },
    _405(message){
        console.log(message);
        window.location.href = '/error/405';
    }    

};