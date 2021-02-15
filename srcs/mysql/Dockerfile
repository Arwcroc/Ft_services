FROM alpine

VOLUME [ "/sys/fs/cgroup/" ]

USER root

RUN apk update && apk upgrade
RUN apk add mysql mysql-client --no-cache

ADD ./srcs/my.cnf /etc/mysql/my.cnf
ADD ./srcs/table.sql ./table.sql
ADD ./srcs/init.sh ./init.sh

EXPOSE 3306

CMD ./init.sh