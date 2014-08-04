FROM ubuntu:14.04
MAINTAINER Johannes 'fish' Ziemke <fish@freigeist.org> @discordianfish

RUN apt-get -qy update && apt-get -qy install software-properties-common
RUN add-apt-repository ppa:nginx/development
RUN apt-get -qy update && apt-get -qy install nginx haproxy ucarp openssl

RUN mkdir -p /scripts
ADD ./scripts /scripts
RUN chmod +x /scripts/run

ADD . /haproxy
WORKDIR    /haproxy
ENTRYPOINT [ "/scripts/run" ]
