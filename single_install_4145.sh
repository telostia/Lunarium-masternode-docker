#Create 2 docker containers, 1 for solariumcoind non master node, 1 for solariumcoind masternode
#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

ufw allow ssh/tcp
ufw limit ssh/tcp
ufw allow 4848/tcp
ufw allow 4145/tcp
ufw logging on
ufw --force enable

#build solarium source git
apt install -y software-properties-common && add-apt-repository ppa:bitcoin/bitcoin && apt update && apt upgrade -y && apt install -y build-essential libtool autotools-dev automake pkg-config libssl-dev autoconf && apt install -y pkg-config libgmp3-dev libevent-dev bsdmainutils && apt install -y libevent-dev libboost-all-dev libdb4.8-dev libdb4.8++-dev nano git && apt install -y libminiupnpc-dev libzmq5 libdb-dev libdb++-dev
cd /root
wget https://raw.githubusercontent.com/telostia/Lunarium-masternode-docker/master/solarium.tar.bz2
echo ---------------------------------------------------------------------------
echo ---------------------------------------------------------------------------
echo -e "${GREEN}                                unpacking ...${NOCOLOR}"
echo ---------------------------------------------------------------------------
echo ---------------------------------------------------------------------------
tar -xvf solarium.tar.bz2
rm solarium.tar.bz2

#building masternode
cd /root/solarium/src
rm /root/solarium/src/Dockerfile
wget git remote add origin https://raw.githubusercontent.com/telostia/Lunarium-masternode-docker/master/solariummasternode/Dockerfile
docker build -t "solariummasternode4145" .

#building the config files
echo ---------------------------------------------------------------------------
echo ---------------------------------------------------------------------------
echo -e "${GREEN}                               creating configs ...${NOCOLOR}"
echo ---------------------------------------------------------------------------
echo ---------------------------------------------------------------------------
mkdir ~/.Solarium
touch ~/.Solarium/Solarium.conf
touch ~/.Solarium/masternode.conf
IP=$(curl ipinfo.io/ip)
USERNAME=$(pwgen -s 16 1)
PASSWORD=$(pwgen -s 64 1)
MASTERNODEPRIVKEY=$(</var/www/masternodeprivkey/masternodeprivkey.txt)
echo "rpcuser=$USERNAME" >/root/Solarium.conf
echo "rpcpassword=$PASSWORD" >>/root/Solarium.conf
echo "rpcallowip=127.0.0.1" >>/root/Solarium.conf
echo "server=1" >>/root/Solarium.conf
echo "listen=1" >>/root/Solarium.conf
echo "port=4848" >>/root/Solarium.conf
echo "rpcport=4145" >>/root/Solarium.conf
echo "addnode=80.211.30.202" >>/root/Solarium.conf
echo "addnode=195.181.216.245" >>/root/Solarium.conf
echo "addnode=217.61.106.97" >>/root/Solarium.conf
echo "addnode=159.89.127.38" >>/root/Solarium.conf
echo "addnode=159.203.26.237" >>/root/Solarium.conf
echo "addnode=167.99.148.87" >>/root/Solarium.conf
echo "addnode=159.65.9.95" >>/root/Solarium.conf
echo "addnode=167.99.44.218" >>/root/Solarium.conf
echo "addnode=178.62.89.167" >>/root/Solarium.conf
echo "addnode=159.89.29.101" >>/root/Solarium.conf
echo "maxconnections=16" >>/root/Solarium.conf
echo "masternodeprivkey=$MASTERNODEPRIVKEY" >>/root/Solarium.conf
echo "masternode=1" >>/root/Solarium.conf
echo "masternodeaddr=$IP:4848" >>/root/Solarium.conf
#create masternode.conf content
#echo $1 $2 $3 $4 $5>>~/.Solarium/masternode.conf
#docker stop solariummasternode4145
docker run -d --name solariummasternode4145 solariummasternode4145
docker cp /root/Solarium.conf solariummasternode4145:/root/.Solarium/
docker cp /root/Solariumd solariummasternode4145:/root/solarium
docker commit solariummasternode4145 solariummasternode4145
docker container rm solariummasternode4145
docker run -d --restart always -p 4848:4848 --name solariummasternode4145 solariummasternode4145 /root/solarium/Solariumd -datadir=/root/.Solarium -conf=/root/.Solarium/Solarium.conf
docker start solariummasternode4145

