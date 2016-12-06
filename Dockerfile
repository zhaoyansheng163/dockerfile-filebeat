FROM 					stakater/base
LABEL         authors="Rasheed Amir <rasheed@aurorasolutions.io>, Hazim <hazim_malik@hotmail.com>"

RUN 					apt-get update && \
    					apt-get install -yq --no-install-recommends wget pwgen ca-certificates && \
    					apt-get clean && \
    					rm -rf /var/lib/apt/lists/*

ARG           FILEBEAT_VERSION=1.2.1
RUN 					curl -L -O https://download.elastic.co/beats/filebeat/filebeat_${FILEBEAT_VERSION}_amd64.deb
RUN 					dpkg -i filebeat_${FILEBEAT_VERSION}_amd64.deb

COPY 					filebeat.yml /etc/filebeat/filebeat.yml

# Make daemon service dir for filebeat and place file
RUN           mkdir -p /etc/service/filebeat
ADD           start.sh /etc/service/filebeat/run

RUN 					apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*