#!/usr/bin/env bash
# preps simple nginx servers for static deployment of `web-static`
service nginx status
if (( $? != 0 )); then
    sudo apt-get -y update
    sudo apt-get -y install nginx
    find /var/www/html/index.html
    if (( $? != 0 )); then
        sudo mkdir -p /var/www/html/
        echo 'Holberton School' > /var/www/html/index.html
    fi
    service nginx restart
fi

sudo mkdir -p /data/web_static/shared/
find /data/web_static/releases/test/index.html
if (( $? != 0 )); then
    sudo mkdir -p /data/web_static/releases/test/
    echo "<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>" > /data/web_static/releases/test/index.html
    sudo ln -sf /data/web_static/releases/test/ /data/web_static/current
fi

sudo chown -R ubuntu:ubuntu /data/

sudo grep -q "location \/hbnb_static\/ {$" /etc/nginx/sites-available/default
if (( $? != 0 )); then
    sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bup
    sudo sed -i "0,/^\tlocation \/ {$/s/^\tlocation \/ {$/\tlocation \/hbnb_static\/ {\n\t\talias \/data\/web_static\/current\/;\n\t\tautoindex off;\n\t}\n\n\tlocation \/ {/" /etc/nginx/sites-available/default
    sudo nginx -t 
    sudo service nginx reload
fi
