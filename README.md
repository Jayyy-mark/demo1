#flask database set up with migration

<!--============================================================
    RUN THIS COMMAND IF NO MIGRATION FOLDER ON YOU PROJECT ROOT
=============================================================-->
** Migration folder initialization 
** cmd (powershell) : flask db init  


<!--============================================================
    RUN THIS COMMAND AFTER MAKEING CHANGES ON YOUR DB MODELS
=============================================================-->
** Add models on database
** cmd (powershell) : flask db migrate


<!--===============================================================================
    RUN THIS COMMAND AFTER RUNNING **FLASK DB MIGRATE** TO UPDATE ON YOUR DATABASE
    ACCORDING TO MIGRATION FILE
=================================================================================-->
** STEP  : 
** cmd (powershell) : flask db upgrade


<!--===============================================================================
    RUN THIS COMMAND IF YOU WANT TO STEP BACK TO PREVIOUS MIGRATION
=================================================================================-->
** Migration folder initialization
** cmd (powershell) : flask db downgrade





<!--=========================================================
    SEVER SIDE SET UP
==========================================================-->

<!--=================================
    NIGINX COMMANDS
=================================-->

sudo apt update

sudo apt install nginx -y

**check or verify nginx : nginx -v

**open site config 


