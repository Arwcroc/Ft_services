FROM alpine

VOLUME [ "/sys/fs/cgroup/" ]

RUN apk update && apk upgrade
RUN apk add --no-cache nginx openrc openssl
RUN adduser -D -g 'www' www 
RUN mkdir /www
RUN chown -R www:www /www
RUN chown -R www:www /etc/nginx

RUN mkdir -p /etc/ssl/certs/ && mkdir -p /etc/ssl/private/ \
&& openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=FR/ST=75/L=Paris/O=42/CN=localhost' \
-keyout /etc/ssl/private/localhost.key -out /etc/ssl/certs/localhost.crt

RUN openrc && touch /run/openrc/softlevel
RUN rc-update add nginx default
RUN rc-service nginx restart
RUN rm /etc/nginx/conf.d/default.conf

EXPOSE 80 443 5050 5000


CMD nginx -g 'pid /tmp/nginx.pid; daemon off;'