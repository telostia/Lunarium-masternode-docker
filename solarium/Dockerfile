FROM ubuntu
MAINTAINER tnssfairchild (sfairchild@trinet-hi.com)
RUN /bin/bash -c 'apt-get -y update && apt-get -y install pwgen'
RUN /bin/bash -c 'apt install -y software-properties-common &&  add-apt-repository ppa:bitcoin/bitcoin &&  apt update &&  apt upgrade -y &&  apt install -y build-essential libtool autotools-dev automake pkg-config libssl-dev autoconf &&  apt install -y pkg-config libssl-dev libgmp3-dev libevent-dev bsdmainutils &&  apt install -y libevent-dev bsdmainutils libboost-all-dev libdb4.8-dev libdb4.8++-dev nano git &&  apt install -y libminiupnpc-dev libzmq5 git'
RUN /bin/bash -c 'mkdir -m755 /root/.solarium'
COPY Solariumd /root/.solarium/Solariumd
RUN /bin/bash -c 'USERNAME=$(pwgen -s 16 1) && PASSWORD=$(pwgen -s 64 1) && \
echo "rpcuser=$USERNAME" > /root/.Solarium/solarium.conf && \
echo "rpcpassword=$PASSWORD" >> /root/.Solarium/solarium.conf  && \
echo "server=1" >> /root/.Solarium/solarium.conf && \
echo "listen=1" >> /root/.Solarium/solarium.conf && \
echo "port=4848" >> /root/.Solarium/solarium.conf && \
echo "rpcport=4141" >> /root/.Solarium/solarium.conf && \
echo "addnode=80.211.30.202" >> /root/.Solarium/solarium.conf && \
echo "addnode=195.181.216.245" >> /root/.Solarium/solarium.conf && \
echo "addnode=217.61.106.97" >> /root/.Solarium/solarium.conf && \
echo "addnode=159.89.127.38" >> /root/.Solarium/solarium.conf && \
echo "addnode=159.203.26.237" >> /root/.Solarium/solarium.conf && \
echo "addnode=167.99.148.87" >> /root/.Solarium/solarium.conf && \
echo "addnode=159.65.9.95" >> /root/.Solarium/solarium.conf && \
echo "addnode=167.99.44.218" >> /root/.Solarium/solarium.conf && \
echo "addnode=178.62.89.167" >> /root/.Solarium/solarium.conf && \
echo "addnode=159.89.29.101" >> /root/.Solarium/solarium.conf && \
echo "litemode=1" >> /root/.Solarium/solarium.conf && \
echo "maxconnections=300" >> /root/.Solarium/solarium.conf && \
echo "bantime=60" >> /root/.Solarium/solarium.conf && \
echo "staking=0" >> /root/.Solarium/solarium.conf && \
echo "masternode=0" >> /root/.Solarium/solarium.conf'
CMD /root/solarium/Solariumd -datadir=/root/.Solarium -conf=/root/.Solarium/solarium.conf
