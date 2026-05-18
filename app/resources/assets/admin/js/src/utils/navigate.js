export const navigate = {
    to(url){
        window.location.href = url;
    },
    replace(url){
        window.location.replace(url);
    },
    refresh(){
        window.location.reload();
    }
}