FROM ubuntu:12.04
MAINTAINER shunirr <m@s5r.jp>

# set locale
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C
ENV LC_ALL en_US.UTF-8

RUN echo "deb http://us.archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y git-core mono-complete --no-install-recommends
RUN apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* 

RUN git clone https://github.com/opentig/TwitterIrcGatewayBinary "${HOME}/TwitterIrcGateway"
RUN git clone https://github.com/opentig/tig-dlr-scripts.git     "${HOME}/TwitterIrcGateway/GlobalScripts"

EXPOSE 16668
RUN mono "${HOME}/TwitterIrcGateway/TwitterIrcGatewayCLI.exe" \
    --port=16668 \
    --bind-address=0.0.0.0 \
    --encoding=utf-8 \
    --channel-name=timeline \
    --enable-comression=true
