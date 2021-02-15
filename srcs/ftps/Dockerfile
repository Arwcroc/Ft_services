FROM alpine

VOLUME [ "/sys/fs/cgroup/" ]

USER root
ADD ./init.sh ./init.sh

RUN apk update && apk upgrade
RUN apk add --no-cache vsftpd openssl openrc

ADD ./vsftpd.conf /etc/vsftpd/vsftpd.conf

RUN mkdir -p /etc/ssl/private 
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=FR/ST=75/L=Paris/O=42/CN=localhost' -out /etc/ssl/certs/vsftpd.crt -keyout /etc/ssl/private/vsftpd.key

RUN touch /etc/vsftpd/vsftpd.userlist

RUN adduser -D tefroiss && passwd tefroiss -d 'password'
RUN echo "tefroiss" >> /etc/vsftpd/vsftpd.userlist

RUN openrc && touch /run/openrc/softlevel

RUN rc-update add vsftpd default
RUN rc-service vsftpd restart

EXPOSE 20 21 30100-30103

CMD vsftpd /etc/vsftpd/vsftpd.conf