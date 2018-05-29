#!/bin/bash
while inotifywait -e modify /var/www/masternodeprivkey/masternodeprivkey.txt; do
  IP=$(curl ipinfo.io/ip)
  USERNAME=$(pwgen -s 16 1)
  PASSWORD=$(pwgen -s 64 1)
  MASTERNODEPRIVKEY=$(</var/www/masternodeprivkey/masternodeprivkey.txt)
  echo "rpcuser=$USERNAME" > /.solarium/solarium.conf
  echo "rpcpassword=$PASSWORD" >> /.solarium/solarium.conf
  echo "server=1" >> /.solarium/solarium.conf
  echo "listen=1" >> /.solarium/solarium.conf
  echo "port=4848" >> /.solarium/solarium.conf
  echo "rpcport=4141" >> /.solarium/solarium.conf
  echo "addnode=80.211.30.202" >> /.solarium/solarium.conf
  echo "addnode=195.181.216.245" >> /.solarium/solarium.conf
  echo "addnode=217.61.106.97" >> /.solarium/solarium.conf
  echo "addnode=159.89.127.38" >> /.solarium/solarium.conf
  echo "addnode=159.203.26.237" >> /.solarium/solarium.conf
  echo "addnode=167.99.148.87" >> /.solarium/solarium.conf
  echo "addnode=159.65.9.95" >> /.solarium/solarium.conf
  echo "addnode=167.99.44.218" >> /.solarium/solarium.conf
  echo "addnode=178.62.89.167" >> /.solarium/solarium.conf
  echo "addnode=159.89.29.101" >> /.solarium/solarium.conf
  echo "maxconnections=16" >> /.solarium/solarium.conf
  echo "masternodeprivkey=$MASTERNODEPRIVKEY" >> /.solarium/solarium.conf
  echo "masternode=1" >> /.solarium/solarium.conf
  echo "masternodeaddr=$IP:4848" >> /.solarium/solarium.conf
  docker run -d --name solariumcoinmasternode solariumcoinmasternode
  docker cp /.solarium/solarium.conf solariumcoinmasternode:/.solarium/solarium.conf
  docker commit solariumcoinmasternode solariumcoinmasternode
  docker container rm solariumcoinmasternode
  docker run -d --restart always -p 4848:4848 --name solariumcoinmasternode solariumcoinmasternode ~/solarium/Solariumd -datadir=/.solariumcoin -conf=/.solarium/solariumc.conf
  cd /root/chainfile
  docker cp ./ solariumcoinmasternode:~/solarium/
  docker stop solariumcoinmasternode
  docker start solariumcoinmasternode
  systemctl stop apache2
  systemctl disable apache2
  ufw delete allow 443/tcp
  break 
done
