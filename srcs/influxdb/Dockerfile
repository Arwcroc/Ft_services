FROM alpine

VOLUME [ "/sys/fs/cgroup/" ]

ADD ./influx.inf ./influx.inf
ADD ./init.sh ./init.sh
ADD ./telegraf.conf ./telegraf.conf

RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories
RUN apk update && apk upgrade
RUN apk add --no-cache openrc bash
RUN openrc && touch /run/openrc/softlevel

RUN apk add influxdb
RUN apk add telegraf

EXPOSE 8086

CMD /init.sh