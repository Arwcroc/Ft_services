#! /bin/bash

eval $(minikube docker-env)

WORKDIR='./srcs/'
IMAGES=(
	mysql
	nginx
	wordpress
	phpmyadmin
	ftps
)

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml

kubectl create secret generic minikube-ip --from-literal=ip="$(minikube ip)"

docker build -t phpfpm ./srcs/phpfpm

for image in ${IMAGES[*]}
do 
	docker build -t ${image} ./srcs/${image}; 
	if [[ $? != 0 ]]
	then
		echo "Error"
		exit 1
	fi
	kubectl apply -k ./srcs/${image};
	if [[ $? != 0 ]]
	then
		echo "Error"
		exit 1
	fi
done

kubectl apply -k ./srcs/metallb
kubectl get svc
minikube ip
kubectl get pods -w