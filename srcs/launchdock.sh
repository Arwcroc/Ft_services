#! /bin/bash

eval $(minikube docker-env)

WORKDIR='./'
IMAGES=(
    phpmyadmin
    mysql
    nginx
    wordpress
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