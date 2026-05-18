const userEmail = $('#user_email');
const userPassword = $("#user_password");

export const authUi = {
    getLoginFormData(){
        const data = {
            user_email: userEmail.val(),
            user_password: userPassword.val()
        }
        return data;
    },
}