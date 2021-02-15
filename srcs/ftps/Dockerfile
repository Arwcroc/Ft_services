FROM alpine

VOLUME [ "/sys/fs/cgroup/" ]

# ENV USER_NAME admin
# ENV PASSWORD admin

USER root
ADD ./init.sh ./init.sh

RUN apk update && apk upgrade
RUN apk add --no-cache vsftpd openssl

RUN sed -i "s|anonymous_enable=YES|anonymous_enable=NO|g" /etc/vsftpd/vsftpd.conf
RUN sed -i "s|#local_enable=YES|local_enable=YES|g" /etc/vsftpd/vsftpd.conf
RUN sed -i "s|#write_enable=YES|write_enable=YES|g" /etc/vsftpd/vsftpd.conf
RUN sed -i "s|#local_umask=022|local_umask=077|g" /etc/vsftpd/vsftpd.conf
# RUN sed -i "s|#local_umask=077|local_umask=077|g" /etc/vsftpd/vsftpd.conf

RUN echo "vsftpd_log_file=/proc/1/fd/1" >> /etc/vsftpd/vsftpd.conf
RUN echo "background=NO" >> /etc/vsftpd/vsftpd.conf
RUN echo "ftpd_banner=Bienvenue sur le FTP Ft_services, retire tes chaussures, mets toi a l'aise" >> /etc/vsftpd/vsftpd.conf
RUN echo "seccomp_sandbox=NO" >> /etc/vsftpd/vsftpd.conf
RUN echo "pasv_enable=YES" /etc/vsftpd/vsftpd.conf
RUN echo "pasv_address=192.168.49.2" /etc/vsftpd/vsftpd.conf
RUN echo "pasv_promiscuous=NO" /etc/vsftpd/vsftpd.conf
RUN echo "pasv_min_port=30100" /etc/vsftpd/vsftpd.conf
RUN echo "pasv_max_port=30103" /etc/vsftpd/vsftpd.conf
RUN echo "port_promiscuous=NO" /etc/vsftpd/vsftpd.conf
RUN echo "userlist_enable=YES" /etc/vsftpd/vsftpd.conf
RUN echo "userlist_file=/etc/vsftpd/vsftpd.userlist" /etc/vsftpd/vsftpd.conf
RUN echo "userlist_deny=NO" /etc/vsftpd/vsftpd.conf

RUN mkdir -p /etc/ssl/private 
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=FR/ST=75/L=Paris/O=42/CN=localhost' -out /etc/ssl/certs/vsftpd.crt -keyout /etc/ssl/private/vsftpd.key
RUN echo "ssl_enable=YES" >> /etc/vsftpd/vsftpd.conf
RUN echo "allow_anon_ssl=NO" >> /etc/vsftpd/vsftpd.conf
RUN echo "force_local_data_ssl=YES" >> /etc/vsftpd/vsftpd.conf
RUN echo "force_local_logins_ssl=YES" >> /etc/vsftpd/vsftpd.conf
RUN echo "ssl_tlsv1=NO" >> /etc/vsftpd/vsftpd.conf
RUN echo "ssl_sslv2=NO" >> /etc/vsftpd/vsftpd.conf
RUN echo "ssl_sslv3=NO" >> /etc/vsftpd/vsftpd.conf
RUN echo "require_ssl_reuse=YES" >> /etc/vsftpd/vsftpd.conf
RUN echo "ssl_ciphers=HIGH" >> /etc/vsftpd/vsftpd.conf
RUN echo "rsa_cert_file=/etc/ssl/certs/vsftpd.crt" >> /etc/vsftpd/vsftpd.conf
RUN echo "rsa_private_key_file=/etc/ssl/private/vsftpd.key" >> /etc/vsftpd/vsftpd.conf

RUN adduser -D tefroiss && passwd tefroiss -d 'password'
RUN echo "tefroiss" >> /etc/vsftpd/vsftpd.userlist

# RUN adduser -D -h /var/ftp $USER_NAME
# RUN echo $USER_NAME":"$PASSWORD | chpasswd

EXPOSE 20 21 30100-30103

CMD ["./init.sh"]

# FROM alpine

# ENV USER_NAME admin
# ENV PASSWORD admin

# RUN apk update && apk add vsftpd openssl

# RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
# -keyout /etc/ssl/private/vsftpd.key \
# -out /etc/ssl/certs/vsftpd.crt \
# -subj '/C=FR/ST=Paris/O=42/CN=localhost'

# COPY vsftpd.conf /etc/vsftpd/vsftpd.conf

# RUN adduser -D -h /var/ftp $USER_NAME
# RUN echo $USER_NAME":"$PASSWORD | chpasswd

# RUN mkdir -p /var/log/vsftpd

# EXPOSE 20 21 30100

# COPY init.sh /tmp
# RUN chmod +x /tmp/init.sh

# ENTRYPOINT sh /tmp/init.sh