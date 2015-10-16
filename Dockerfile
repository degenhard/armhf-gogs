FROM zsoltm/ubuntu-armhf:14.01-16.02.2015

ADD gogs_v0.6.15_linux_arm.zip gogs-entry.sh app.ini /opt/

RUN apt-get -q -y update\
 && apt-get -q -y upgrade\
 && apt-get install -y unzip curl wget git\
 && apt-get clean

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
