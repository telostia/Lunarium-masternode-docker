FROM quay.io/kwiksand/cryptocoin-base:latest
#MAINTAINER tnssfairchild (sfairchild@trinet-hi.com)
RUN /bin/bash -c 'apt-get -y update && apt-get -y install pwgen'
RUN /bin/bash -s 'apt-get update -y && apt-get upgrade -y && apt-get dist-upgrade -y && apt-get autoremove -y && apt-get autoclean -y'
RUN /bin/bash -c 'apt install -y software-properties-common && add-apt-repository ppa:bitcoin/bitcoin && apt update && apt upgrade -y && apt install -y build-essential libtool autotools-dev automake pkg-config libssl-dev autoconf && apt install -y pkg-config libgmp3-dev libevent-dev bsdmainutils && apt install -y libevent-dev libboost-all-dev libdb4.8-dev libdb4.8++-dev nano git && apt install -y libminiupnpc-dev libzmq5 libdb-dev libdb++-dev curl'
RUN /bin/bash -c 'mkdir -m755 /root/.Solarium'
RUN /bin/bash -c 'mkdir -m755 /root/solarium'
COPY Solariumd /root/solarium/Solariumd
COPY Solariumd /root/.Solarium/Solariumd
