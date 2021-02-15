FROM alpine

RUN apk update \
&& apk upgrade 

RUN apk add --no-cache php7-phar php7-fpm php7 curl mysql-client php7-json php7-curl php7-common php7-iconv  php7-gd \
 php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql \
 php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
&& chmod +x wp-cli.phar \
&& mv wp-cli.phar /usr/local/bin/wp

ADD ./srcs/init.sh ./init.sh

EXPOSE 9000

CMD ./init.sh