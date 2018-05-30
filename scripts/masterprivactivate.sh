#!/bin/bash
while inotifywait -e modify /var/www/masternodeprivkey/masternodeprivkey.txt; do
  IP=$(curl ipinfo.io/ip)
  USERNAME=$(pwgen -s 16 1)
  PASSWORD=$(pwgen -s 64 1)
  MASTERNODEPRIVKEY=$(</var/www/masternodeprivkey/masternodeprivkey.txt)
  echo "rpcuser=$USERNAME" >/root/Solarium.conf
  echo "rpcpassword=$PASSWORD" >>/root/Solarium.conf
  echo "server=1" >>/root/Solarium.conf
  echo "listen=1" >>/root/Solarium.conf
  echo "port=4848" >>/root/Solarium.conf
  echo "rpcport=4141" >>/root/Solarium.conf
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
  docker run -d --name solmn solmn
  docker cp /root/Solarium.conf solmn:/root/.Solarium/
  docker cp /root/solarium/Solariumd solmn:/root/solarium
  docker commit solmn solmn
  docker container rm solmn
  docker run -d --restart always -p 4848:4848 --name solmn solmn /root/solarium/Solariumd -datadir=/root/.Solarium -conf=/root/.Solarium/Solarium.conf
  #docker stop solmn
  #docker start solmn
  systemctl stop apache2
  systemctl disable apache2
  ufw delete allow 443/tcp
  break 
done
