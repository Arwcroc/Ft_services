#! /bin/sh

# echo "pasv_address=$MINIKUBE_IP" >> /etc/vsftpd/vsftpd.conf
# vsftpd /etc/vsftpd/vsftpd.conf

sed -i s/IP_SERVICES/${IP_SERVICES}/g /etc/vsftpd/vsftpd.conf
vsftpd /etc/vsftpd/vsftpd.conf