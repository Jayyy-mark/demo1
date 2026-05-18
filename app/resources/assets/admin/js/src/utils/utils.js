//static/js/app/utils/utils.js
//===================================
// Helper functions
//===================================
export const Utils ={
    toDict(form)
    {
        const data = {};
        $.each(form, (_,field)=>{
            data[field.name] = field.value;
        });
        return data;
    },
    refresh(){
        window.location.reload();
    },
    formtoDict(form){
        //change from form to dict
        const data = Object.entries(new FormData(form[0]));
        return data;
    }
}

class UseState {

    constructor(initialState = {}) {

        for (const key in initialState) {
            this[key] = initialState[key];
        }
    }

    setState(newState = {}) {

        for (const key in newState) {
            this[key] = newState[key];
        }
    }
}