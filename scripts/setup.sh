#!/bin/bash
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
sudo apt-get install software-properties-common wget zip curl -y
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get install php8.1 php8.1-{cli,curl,dom,zip,exif,fileinfo,igbinary,imagick,mbstring,intl,zip,mysql} -y 
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar && sudo mv wp-cli.phar /usr/local/bin/wp
mkdir wordpress && cd wordpress && wp core download
wp core config --dbhost=${dbhost} --dbname=${dbname} --dbuser=${dbuser} --dbpass=${dbpass}
wp core install --url=${ip} --title=${title} --admin_name=${admin_name} --admin_password=${admin_password} --admin_email=${admin_email}
sudo rm -rf /var/www/html/*
sudo rsync -arv /home/ubuntu/wordpress/ /var/www/html/
sudo chown -R www-data:www-data /var/www/html
sudo a2enmod rewrite
sudo systemctl restart apache2
