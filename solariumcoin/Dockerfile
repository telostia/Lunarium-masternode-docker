FROM ubuntu
MAINTAINER tnssfairchild (sfairchild@trinet-hi.com)
RUN /bin/bash -c 'apt-get -y update && apt-get -y install pwgen'
RUN /bin/bash -c 'apt install -y software-properties-common && sudo add-apt-repository ppa:bitcoin/bitcoin && sudo apt update && sudo apt upgrade -y && sudo apt install -y build-essential libtool autotools-dev automake pkg-config libssl-dev autoconf && sudo apt install -y pkg-config libssl-dev libgmp3-dev libevent-dev bsdmainutils && sudo apt install -y libevent-dev bsdmainutils libboost-all-dev libdb4.8-dev libdb4.8++-dev nano git && sudo apt install -y libminiupnpc-dev libzmq5 git'
RUN /bin/bash -c 'mkdir -m755 /.solarium/solarium'
COPY Solariumd ~/solarium/Solariumd
RUN /bin/bash -c 'USERNAME=$(pwgen -s 16 1) && PASSWORD=$(pwgen -s 64 1) && \
echo "rpcuser=$USERNAME" > /.solarium/solarium.conf && \
echo "rpcpassword=$PASSWORD" >> /.solarium/solarium.conf  && \
echo "server=1" >> /.solarium/solarium.conf && \
echo "listen=1" >> /.solarium/solarium.conf && \
echo "port=4848" >> /.solarium/solarium.conf && \
echo "rpcport=4141" >> /.solarium/solarium.conf && \
echo "addnode=80.211.30.202" >> /.solarium/solarium.conf && \
echo "addnode=195.181.216.245" >> /.solarium/solarium.conf && \
echo "addnode=217.61.106.97" >> /.solarium/solarium.conf && \
echo "addnode=159.89.127.38" >> /.solarium/solarium.conf && \
echo "addnode=159.203.26.237" >> /.solarium/solarium.conf && \
echo "addnode=167.99.148.87" >> /.solarium/solarium.conf && \
echo "addnode=159.65.9.95" >> /.solarium/solarium.conf && \
echo "addnode=167.99.44.218" >> /.solarium/solarium.conf && \
echo "addnode=178.62.89.167" >> /.solarium/solarium.conf && \
echo "addnode=159.89.29.101" >> /.solarium/solarium.conf && \
echo "litemode=1" >> /.solarium/solarium.conf && \
echo "maxconnections=300" >> /.solarium/solarium.conf && \
echo "bantime=60" >> /.solarium/solarium.conf && \
echo "staking=0" >> /.solarium/solarium.conf && \
echo "masternode=0" >> /.solarium/solarium.conf'
CMD ~/solarium/Solariumd -datadir=/.solarium/solarium -conf=/.solarium/solarium.conf
