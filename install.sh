#Create 2 docker containers, 1 for solariumcoind non master node, 1 for solariumcoind masternode
#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
#apt -y -o Acquire::ForceIPv4=true update
#apt-get -y -o "Dpkg::Options::=--force-confdef" -o "Dpkg::Options::=--force-confold" upgrade
#apt -y install apt-transport-https ca-certificates curl software-properties-common git
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
#apt-key fingerprint 0EBFCD88
#add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
#apt -y -o Acquire::ForceIPv4=true update
#apt -y install docker-ce
systemctl start docker
systemctl enable docker
docker pull ubuntu

ufw default allow outgoing
ufw default deny incoming
ufw allow ssh/tcp
ufw limit ssh/tcp
ufw allow 4848/tcp
ufw allow 4848/tcp
ufw logging on
ufw --force enable

apt -y install fail2ban
systemctl enable fail2ban
systemctl start fail2ban

#apt-get -y install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev libminiupnpc-dev libgmp3-dev libdb-dev libdb++-dev libgmp3-dev
sudo apt install -y software-properties-common && sudo add-apt-repository ppa:bitcoin/bitcoin && sudo apt update && sudo apt upgrade -y && sudo apt install -y build-essential libtool autotools-dev automake pkg-config libssl-dev autoconf && sudo apt install -y pkg-config libssl-dev libgmp3-dev libevent-dev bsdmainutils && sudo apt install -y libevent-dev bsdmainutils libboost-all-dev libdb4.8-dev libdb4.8++-dev nano git && sudo apt install -y libminiupnpc-dev libzmq5
cd /root
git clone https://github.com/solarium-community/solarium
cd solarium/src
make -f makefile.unix USE_UPNP=-1
#make -f makefile.unix
strip Solariumd
mv Solariumd ~/solarium
cd ~/solarium
rm -rf solarium

#BOOTSTRAP CHAIN FILE
apt-get -y install unzip

#COMMENT OUT SEED NODE


#cd && mkdir .Solarium && nano .Solarium/Solarium.conf
cd /root/solarium/src
rm /root/solarium/src/Dockerfile
wget git remote add origin https://raw.githubusercontent.com/telostia/Lunarium-masternode-docker/master/solariumcoinmasternode/Dockerfile
docker build -t "solariummasternode" .

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
