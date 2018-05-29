FROM ubuntu
MAINTAINER tnssfairchild (sfairchild@trinet-hi.com)
RUN /bin/bash -c 'apt-get -y update && apt-get -y install pwgen'
RUN /bin/bash -c 'apt install -y software-properties-common && sudo add-apt-repository ppa:bitcoin/bitcoin && sudo apt update && sudo apt upgrade -y && sudo apt install -y build-essential libtool autotools-dev automake pkg-config libssl-dev autoconf && sudo apt install -y pkg-config libssl-dev libgmp3-dev libevent-dev bsdmainutils && sudo apt install -y libevent-dev bsdmainutils libboost-all-dev libdb4.8-dev libdb4.8++-dev nano git && sudo apt install -y libminiupnpc-dev libzmq5 git curl'
RUN /bin/bash -c 'mkdir -m755 ~/.solarium'
COPY Solariumd ~/solarium/Solariumd
