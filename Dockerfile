FROM armv7/armhf-debian:8

ADD gogs_v0.6.15_linux_arm.zip gogs-entry.sh app.ini /opt/

RUN export DEBIAN_FRONTEND=noninteractive\
 && apt-get -q -y update\
 && apt-get -q -y upgrade\
 && apt-get clean

RUN gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4\
 && export GOSU_URL="https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture)"\
 && wget -O /usr/local/bin/gosu.asc ${GOSU_URL}.asc\
 && wget -O /usr/local/bin/gosu ${GOSU_URL}\
 && gpg --verify /usr/local/bin/gosu.asc\
 && rm /usr/local/bin/gosu.asc\
 && chmod +x /usr/local/bin/gosu

ENV LC_ALL C.UTF-8

RUN apt-get install -y git && apt-get clean

RUN unzip -e /opt/gogs_v0.6.15_linux_arm.zip -d /opt\
 && rm /opt/gogs_v0.6.15_linux_arm.zip

RUN groupadd gogs && useradd -m -g gogs gogs\
 && mkdir -p /repository && chown gogs:gogs /repository\
 && mkdir -p /data && chown gogs:gogs /data\
 && mkdir -p /static/public\
 && mkdir -p /static/templates\
 && mkdir -p /opt/gogs/custom/conf && mv /opt/app.ini /opt/gogs/custom/conf/app.ini.default && ln -sf /data/app.ini /opt/gogs/custom/conf/app.ini

VOLUME /static
VOLUME /data
VOLUME /repository
EXPOSE 3000

ENTRYPOINT ["/opt/gogs-entry.sh"]
CMD ["gogs"]
