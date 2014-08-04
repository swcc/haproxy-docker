FROM ubuntu:14.04
MAINTAINER Johannes 'fish' Ziemke <fish@freigeist.org> @discordianfish

RUN apt-get -qy update && apt-get -qy install software-properties-common
RUN add-apt-repository ppa:nginx/development
RUN add-apt-repository ppa:vbernat/haproxy-1.5
RUN apt-get -qy update && apt-get -qy install nginx haproxy ucarp openssl

ADD . /haproxy
RUN chmod +x /haproxy/scripts/ucarp
RUN chmod +x /haproxy/scripts/run

WORKDIR    /haproxy
ENTRYPOINT [ "./scripts/run" ]
