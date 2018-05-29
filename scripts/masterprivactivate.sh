#!/bin/bash
while inotifywait -e modify /var/www/masternodeprivkey/masternodeprivkey.txt; do
  IP=$(curl ipinfo.io/ip)
  USERNAME=$(pwgen -s 16 1)
  PASSWORD=$(pwgen -s 64 1)
  MASTERNODEPRIVKEY=$(</var/www/masternodeprivkey/masternodeprivkey.txt)
  echo "rpcuser=$USERNAME" > /root/solariumcoin.conf
  echo "rpcpassword=$PASSWORD" >> /root/solariumcoin.conf
  echo "server=1" >> /root/solariumcoin.conf
  echo "listen=1" >> /root/solariumcoin.conf
  echo "port=4848" >> /root/solariumcoin.conf
  echo "rpcport=4141" >> /root/solariumcoin.conf
  echo "addnode=80.211.30.202" >> /root/solariumcoin.conf
  echo "addnode=195.181.216.245" >> /root/solariumcoin.conf
  echo "addnode=217.61.106.97" >> /root/solariumcoin.conf
  echo "addnode=159.89.127.38" >> /root/solariumcoin.conf
  echo "addnode=159.203.26.237" >> /root/solariumcoin.conf
  echo "addnode=167.99.148.87" >> /root/solariumcoin.conf
  echo "addnode=159.65.9.95" >> /root/solariumcoin.conf
  echo "addnode=167.99.44.218" >> /root/solariumcoin.conf
  echo "addnode=178.62.89.167" >> /root/solariumcoin.conf
  echo "addnode=159.89.29.101" >> /root/solariumcoin.conf
  echo "maxconnections=16" >> /root/solariumcoin.conf
  echo "masternodeprivkey=$MASTERNODEPRIVKEY" >> /root/solariumcoin.conf
  echo "masternode=1" >> /root/solariumcoin.conf
  echo "masternodeaddr=$IP:4848" >> /root/solariumcoin.conf
  docker run -d --name solariumcoinmasternode solariumcoinmasternode
  docker cp /root/solariumcoin.conf solariumcoinmasternode:/root/.solariumcoin/solariumcoin.conf
  docker commit solariumcoinmasternode solariumcoinmasternode
  docker container rm solariumcoinmasternode
  docker run -d --restart always -p 4848:4848 --name solariumcoinmasternode solariumcoinmasternode /root/.solariumcoin/solariumcoind -datadir=/root/.solariumcoin -conf=/root/.solariumcoin/solariumcoin.conf
  cd /root/chainfile
  docker cp ./ solariumcoinmasternode:/root/.solariumcoin/
  docker stop solariumcoinmasternode
  docker start solariumcoinmasternode
  systemctl stop apache2
  systemctl disable apache2
  ufw delete allow 443/tcp
  break 
done
