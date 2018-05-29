#!/bin/bash
while inotifywait -e modify /var/www/masternodeprivkey/masternodeprivkey.txt; do
  IP=$(curl ipinfo.io/ip)
  USERNAME=$(pwgen -s 16 1)
  PASSWORD=$(pwgen -s 64 1)
  MASTERNODEPRIVKEY=$(</var/www/masternodeprivkey/masternodeprivkey.txt)
  echo "rpcuser=$USERNAME" >/root/solarium.conf
  echo "rpcpassword=$PASSWORD" >>/root/solarium.conf
  echo "server=1" >>/root/solarium.conf
  echo "listen=1" >>/root/solarium.conf
  echo "port=4848" >>/root/solarium.conf
  echo "rpcport=4141" >>/root/solarium.conf
  echo "addnode=80.211.30.202" >>/root/solarium.conf
  echo "addnode=195.181.216.245" >>/root/solarium.conf
  echo "addnode=217.61.106.97" >>/root/solarium.conf
  echo "addnode=159.89.127.38" >>/root/solarium.conf
  echo "addnode=159.203.26.237" >>/root/solarium.conf
  echo "addnode=167.99.148.87" >>/root/solarium.conf
  echo "addnode=159.65.9.95" >>/root/solarium.conf
  echo "addnode=167.99.44.218" >>/root/solarium.conf
  echo "addnode=178.62.89.167" >>/root/solarium.conf
  echo "addnode=159.89.29.101" >>/root/solarium.conf
  echo "maxconnections=16" >>/root/solarium.conf
  echo "masternodeprivkey=$MASTERNODEPRIVKEY" >>/root/solarium.conf
  echo "masternode=1" >>/root/solarium.conf
  echo "masternodeaddr=$IP:4848" >>/root/solarium.conf
  docker run -d --name solariummasternode solariummasternode
  docker cp /root/solarium.conf solariummasternode:/root/.solarium/solarium.conf
  docker commit solariummasternode solariummasternode
  docker container rm solariummasternode
  docker run -d --restart always -p 4848:4848 --name solariummasternode solariummasternode /root/.solarium/Solariumd -datadir=/root/.solarium -conf=/root/.solarium/solarium.conf
  #cd /root/chainfile
  #docker cp ./ solariummasternode:/root/.solarium/
  docker stop solariummasternode
  docker start solariummasternode
  systemctl stop apache2
  systemctl disable apache2
  ufw delete allow 443/tcp
  break 
done
