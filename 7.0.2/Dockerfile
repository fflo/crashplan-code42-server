# define base image: Ubuntu Bionic
FROM ubuntu:bionic

# define package maintainer
MAINTAINER Florian Fuessl <flo@degnet.de>

# add crashplan group and user
RUN groupadd -r crashplan && useradd -r -m -d /crashplan -g crashplan crashplan

# adapt limits
RUN echo "@crashplan - nofile 1048576" > /etc/security/limits.d/crashplan.conf

# install requirements
RUN apt-get update \
        && apt-get upgrade -y \
        && apt-get install -y curl gosu \
        && apt-get -y autoremove \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

# install run executor and entrypoint
COPY run.sh /
COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /run.sh /entrypoint.sh

# download and install crashplan code42 proserver
USER crashplan
RUN set -ex ; \
        mkdir -p /tmp/code42server ; \
        cd /tmp ; \
        curl -qL https://download.code42.com/installs/proserver/7.0.2/Code42server_7.0.2_Linux.tgz | tar xvz -C /tmp/code42server --strip-components=1 ; \
        rm -f /tmp/Code42server* ; \
        cd /tmp/code42server ; \
        ./install.sh -u --accept-eula ; \
        rm -rf /tmp/code42server

# link old paths
USER root
RUN set -ex ; \
        ln -s /crashplan/proserver/server /opt/proserver ; \
        ln -s /crashplan/proserver/data /var/opt/proserver ; \
        ln -s /crashplan/proserver/log /var/log/proserver

# define expose ports and volumes
EXPOSE 4280 4282 4285 4287
VOLUME ["/crashplan/proserver/data","/crashplan/proserver/log","/crashplan/proserver/server/db"]

# run time
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/run.sh"]
