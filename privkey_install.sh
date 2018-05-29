#Create 2 docker containers, 1 for solariumcoind non master node, 1 for solariumcoind masternode
#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

#SETUP WEB SERVER FOR MASTER NODE KEY
openssl req -new -x509 -days 365 -nodes -out /etc/ssl/certs/ssl-cert-snakeoil.pem -keyout /etc/ssl/private/ssl-cert-snakeoil.key -subj "/C=AB/ST=AB/L=AB/O=IT/CN=mastertoad"
apt-get -y install apache2 php libapache2-mod-php php-mcrypt inotify-tools pwgen
systemctl start apache2
a2ensite default-ssl 
a2enmod ssl 
systemctl restart apache2 
ufw allow 443/tcp

#DOWNLOAD WEBFORM AND SCRIPT
rm -rf /var/www/html/index.html
cd /var/www/html
wget https://raw.githubusercontent.com/telostia/Lunarium-masternode-docker/master/webscript/index.html
wget https://raw.githubusercontent.com/telostia/Lunarium-masternode-docker/master/webscript/masternode.php
mkdir /var/www/masternodeprivkey
touch /var/www/masternodeprivkey/masternodeprivkey.txt
chown -R www-data.www-data /var/www/masternodeprivkey
chown -R www-data.www-data /var/www/html
cd /root
wget https://raw.githubusercontent.com/telostia/Lunarium-masternode-docker/master/scripts/masterprivactivate.sh
chmod 755 /root/masterprivactivate.sh
/root/masterprivactivate.sh &
