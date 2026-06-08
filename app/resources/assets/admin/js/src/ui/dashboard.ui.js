
export const dashboardUI = {
    render(data) {
        console.log("this is data value : ",data);
        if (data == null || (Array.isArray(data) && data.length === 0)) {
            console.log("No data has been found!");
            return;
        }

        data.forEach(element => {

            console.log("this is element : ", element.attr_key);
            if(element.attr_key == "Rector's Message"){
                $("#rector-message").text(element.value);
            }

        });
    },

}