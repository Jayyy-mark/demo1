
<!--============================================================
	CREATE OR OPEN NGINX CONFIG FILE FOR WEBSITE
============================================================-->
sudo nano /etc/nginx/sites-available/ucstgoweb 

## after creating and opening config file, you need to write server setup for your website 
## Here is sample for config file

server {
    listen 80;
    server_name your-domain.com www.your-domain.com;

    location / {
        include proxy_params;
        proxy_pass http://unix:/run/myapp.sock;
    }
}

If you don't have a domain yet:

server {
    listen 80;
    server_name 103.xxx.xxx.xxx;

    location / {
        include proxy_params;
        proxy_pass http://unix:/run/myapp.sock;
    }
}




<!--==========================================
	START NGINX SERVER
===========================================-->
sudo systemctl start nginx 

<!--==========================================
	RESTART NGINX SERVER
===========================================-->
sudo systemctl restart nginx 	####you need to restart nginx server only after you make changes on nginx config file for webiste

<!--==========================================
	CHECK NGINX SERVER STATUS
===========================================-->
sudo systemctl status nginx 	####if status is unactive you need to run restart nginx server command





<!--============================================================
	CREATE or OPEN GUNICORN CONFIG FILE FOR WEBSITE
=============================================================-->
sudo nano /etc/systemd/system/ucstgoweb.service

## after creating and opening config file, you need to write server setup for your website 
## Here is sample for config file

##########################################
[Unit]
Description=Gunicorn instance for Flask app
After=network.target

[Service]
User=ubuntu
Group=www-data
WorkingDirectory=/home/ubuntu/myapp		         (directory for you web project)	
Environment="PATH=/home/ubuntu/myapp/venv/bin"		(directory for installed python folder or venv ## I do recommend for creating venv under web project and paste the folder path in here)	
ExecStart=/home/ubuntu/myapp/venv/bin/gunicorn \	(directory for installed gunicorn if you don't know, you can check via this command #### where gunicorn ### on bash)
          --workers 3 \
          --bind unix:/home/ubuntu/myapp/myapp.sock \
          app:app

[Install]
WantedBy=multi-user.target
######################################


<!--==========================================
	START GUNICORN SERVER
===========================================-->
sudo systemctl start ucstgoweb

<!--==========================================
	RESTART GUNICORN SERVER
===========================================-->
sudo systemctl restart ucstgoweb	####you need to restart gunicorn server after you make changes on gunicorn config file for website or you make changes on source code


<!--==========================================
	CHECK GUNICORN SERVER STATUS
===========================================-->
sudo systemctl status ucstgoweb		####if status is unactive you need to run restart gunicorn server command


