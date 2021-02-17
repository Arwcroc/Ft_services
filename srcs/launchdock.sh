#! /bin/bash

minikube addons enable dashboard
minikube addons enable metrics-server
minikube addons enable metallb
minikube start

eval $(minikube docker-env)

WORKDIR='./'
IMAGES=(
    phpmyadmin
    mysql
    nginx
    wordpress
    ftps
    influxdb
    grafana
)

for image in ${IMAGES[*]}
do 
	docker build -t ${image} ./${image}; 
	if [[ $? != 0 ]]
	then
		echo "Error"
		exit 1
	fi
done
