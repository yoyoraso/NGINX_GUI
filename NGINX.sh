#!/bin/bash

#sudo yum install -y pv &> /dev/null
sudo yum install -y dialog &> /dev/null


HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="NGINX-------GUI"
TITLE="NGINX"
MENU="Choose one of the following options:"

OPTIONS=( 1 "Install & Setup NGINX "
         2 "Configure As Load Balancer & Reverse Proxy"
         3 "Configure As Reverse Proxy"
         4 "Cofigure Server Blocks "
         5 "Configure TLS"
         6 "Configure HTTP" )

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
       1)
#dialog --title "Hello" --msgbox 'Installing NGINX' 6 20
yum install epel-release -y
yum install nginx –y 
systemctl disable httpd
systemctl start nginx 
systemctl enable nginx 
firewall-cmd --zone=public --permanent --add-service=http  
firewall-cmd --zone=public --permanent --add-service=https  
firewall-cmd --reload  
#| dialog --gauge "Progress" 10 40
#dialog --title "Hello" --msgbox 'Installed' 6 20



           ;;
        2)
#            echo "You chose Option 1"


echo "
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;
# Load dynamic modules. See /usr/share/doc/nginx/README.dynamic.
include /usr/share/nginx/modules/*.conf;
events {
    worker_connections 1024;
}
http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';
    access_log  /var/log/nginx/access.log  main;
    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;
    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;
upstream yahia   {
" > /etc/nginx/nginx.conf

number=$(dialog --title "Inputbox - Example" --backtitle "YAYA" --inputbox "Enter Number Of Nodes" 8 50

3>&1 1>&2 2>&3 3>&-)
for i in $(seq 1 $number)
do

ip=$(dialog --title "Inputbox - Example" --backtitle "YAYA" --inputbox "Enter Number Of Nodes" 8 50 3>&1

1>&2 2>&3 3>&-)

echo "
        server $ip;
" >> /etc/nginx/nginx.conf

done

echo "
}
server  {
listen 80;
listen [::]:80;
location / {
proxy_pass http://yahia;
}
}
}
" >> /etc/nginx/nginx.conf



            ;;
        3)
#            echo "You chose Option 2"
site_ip=$(dialog --title "Inputbox - Example" --backtitle "YAYA" --inputbox "Enter Your Site IP:PORT" 8 50 3>&1 1>&2 2>&3 3>&-)
echo "
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;
# Load dynamic modules. See /usr/share/doc/nginx/README.dynamic.
include /usr/share/nginx/modules/*.conf;
events {
    worker_connections 1024;
}
http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';
    access_log  /var/log/nginx/access.log  main;
    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;
    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;
server {
  listen 80;
  listen [::]:80;
location / {
proxy_pass http://$site_ip ;
}
}
}
" > /etc/nginx/nginx.conf

sudo setenforce 0


            ;;
        4)
#            echo "You chose Option 3"


sudo chmod -R 755 /var/www

sudo mkdir /etc/nginx/sites-available
sudo mkdir /etc/nginx/sites-enabled



echo "
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;
# Load dynamic modules. See /usr/share/doc/nginx/README.dynamic.
include /usr/share/nginx/modules/*.conf;
events {
    worker_connections 1024;
}
http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';
    access_log  /var/log/nginx/access.log  main;
    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;
    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;
    include /etc/nginx/sites-enabled/*.conf;
    server_names_hash_bucket_size 64;
server {
  listen 80;
  listen [::]:80;
location / {
}
}
}
" > /etc/nginx/nginx.conf


number=$(dialog --title "Inputbox - Example" --backtitle "YAYA" --inputbox "Enter Number Of Blocks" 8 50 3>&1 1>&2 2>&3 3>&-)
for i in $(seq 1 $number)
do
site_name=$(dialog --title "Inputbox - Example" --backtitle "YAYA" --inputbox "Enter Your $i Site Name" 8 50 3>&1 1>&2 2>&3 3>&-)
sudo mkdir -p /var/www/$site_name/html
sudo chown -R $USER:$USER /var/www/$site_name/html
            location=$(dialog --title "Inputbox - Example" --backtitle "YAYA" --inputbox "Enter Your $i Site HTML File Location" 8 50 3>&1 1>&2 2>&3 3>&-)
           cat $location >  /var/www/$site_name/html/index.html
sudo cp /etc/nginx/conf.d/default.conf /etc/nginx/sites-available/$site_name.conf
echo "
server {
    listen  80;
    server_name  $site_name www.$site_name;

    location / {
        root  /var/www/$site_name/html;
        index  index.html index.htm;
        try_files \$uri \$uri/ =404;
    }

    error_page  500 502 503 504  /50x.html;
    location = /50x.html {
        root  /usr/share/nginx/html;
    }
} " > /etc/nginx/sites-available/$site_name.conf

sudo ln -s /etc/nginx/sites-available/$site_name.conf /etc/nginx/sites-enabled/$site_name.conf

 ip=$(dialog --title "Inputbox - Example" --backtitle "YAYA" --inputbox "Enter Your Server IP" 8 50 3>&1 1>&2 2>&3 3>&-)

sudo echo "
$ip  www.$site_name 
"  >> /etc/hosts
done



sudo nginx -t
sudo systemctl restart nginx






            ;;
        5)
#           echo "You chose Option 5"
#sudo yum install certbot-nginx -y
sudo mkdir /etc/ssl/private
sudo chmod 700 /etc/ssl/private
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt

sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048


sed -i '/server {/c #' /etc/nginx/nginx.conf
sed -i '/  listen 80;/c #' /etc/nginx/nginx.conf
sed -i '/  listen \[::\]:80;/c #yaya' /etc/nginx/nginx.conf

sed -i '/#yaya/ a server {' /etc/nginx/nginx.conf
sed -i '/server {/ a listen 80;' /etc/nginx/nginx.conf
sed -i '/listen 80;/ a return 301 https://$host$request_uri;}' /etc/nginx/nginx.conf


sed -i '/return 301 https:\/\/\$host\$request_uri;}/ a server { listen 443 ssl;' /etc/nginx/nginx.conf
sed -i '/server { listen 443 ssl;/ a     ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;' /etc/nginx/nginx.conf

sed -i '/ssl_certificate \/etc\/ssl\/certs\/nginx-selfsigned.crt;/ a  ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;' /etc/nginx/nginx.conf

sed -i '/ssl_certificate_key \/etc\/ssl\/private\/nginx-selfsigned.key;/ a ssl_dhparam /etc/ssl/certs/dhparam.pem;' /etc/nginx/nginx.conf




sudo nginx -t
sudo systemctl restart nginx

            ;;
        6)
#            echo "You chose Option "


echo "
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;
# Load dynamic modules. See /usr/share/doc/nginx/README.dynamic.
include /usr/share/nginx/modules/*.conf;
events {
    worker_connections 1024;
}
http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';
    access_log  /var/log/nginx/access.log  main;
    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;
    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;
server {
  listen 80;
  listen [::]:80;
location / {
}
}
}
" > /etc/nginx/nginx.conf



            location=$(dialog --title "Inputbox - Example" --backtitle "YAYA" --inputbox "Enter Your HTML File Location" 8 50 3>&1 1>&2 2>&3 3>&-)
           cat $location >  /usr/share/nginx/html/index.html

nginx -t
sudo systemctl reload nginx

            ;;

esac

