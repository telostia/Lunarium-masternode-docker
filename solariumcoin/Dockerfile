FROM ubuntu
MAINTAINER tnssfairchild (sfairchild@trinet-hi.com)
RUN /bin/bash -c 'apt-get -y update && apt-get -y install pwgen'
RUN /bin/bash -c 'apt-get -y install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev libminiupnpc-dev libgmp3-dev libdb-dev libdb++-dev libgmp3-dev git'
RUN /bin/bash -c 'mkdir -m755 /root/.solariumcoin'
COPY solariumcoind /root/.solariumcoin/solariumcoind
RUN /bin/bash -c 'USERNAME=$(pwgen -s 16 1) && PASSWORD=$(pwgen -s 64 1) && \
echo "rpcuser=$USERNAME" > /root/.solariumcoin/solariumcoin.conf && \
echo "rpcpassword=$PASSWORD" >> /root/.solariumcoin/solariumcoin.conf  && \
echo "server=1" >> /root/.solariumcoin/solariumcoin.conf && \
echo "listen=1" >> /root/.solariumcoin/solariumcoin.conf && \
echo "port=4848" >> /root/.solariumcoin/solariumcoin.conf && \
echo "rpcport=4141" >> /root/.solariumcoin/solariumcoin.conf && \
echo "addnode=80.211.30.202" >> /root/solariumcoin.conf && \
  echo "addnode=195.181.216.245" >> /root/solariumcoin.conf && \
  echo "addnode=217.61.106.97" >> /root/solariumcoin.conf && \
  echo "addnode=159.89.127.38" >> /root/solariumcoin.conf && \
  echo "addnode=159.203.26.237" >> /root/solariumcoin.conf && \
  echo "addnode=167.99.148.87" >> /root/solariumcoin.conf && \
  echo "addnode=159.65.9.95" >> /root/solariumcoin.conf && \
  echo "addnode=167.99.44.218" >> /root/solariumcoin.conf && \
  echo "addnode=178.62.89.167" >> /root/solariumcoin.conf && \
  echo "addnode=159.89.29.101" >> /root/solariumcoin.conf && \
echo "litemode=1" >> /root/.solariumcoin/solariumcoin.conf && \
echo "maxconnections=300" >> /root/.solariumcoin/solariumcoin.conf && \
echo "bantime=60" >> /root/.solariumcoin/solariumcoin.conf && \
echo "staking=0" >> /root/.solariumcoin/solariumcoin.conf && \
echo "masternode=0" >> /root/.solariumcoin/solariumcoin.conf'
CMD /root/.solariumcoin/solariumcoind -datadir=/root/.solariumcoin -conf=/root/.solariumcoin/solariumcoin.conf
