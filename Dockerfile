FROM ubuntu:14.04
MAINTAINER Johannes 'fish' Ziemke <fish@freigeist.org> @discordianfish

RUN echo deb http://ppa.launchpad.net/vbernat/haproxy-1.5/ubuntu trusty main >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1C61B9CD
RUN apt-get -qy update && apt-get -qy install haproxy ucarp
ADD https://raw.github.com/jpetazzo/pipework/master/pipework /sbin/
RUN chmod a+x /sbin/pipework

ADD . /haproxy
WORKDIR    /haproxy
ENTRYPOINT [ "./scripts/run" ]
