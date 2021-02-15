#! /bin/bash

#if [[ ! $(command -v minikube) ]]
#then
#	curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64
# 	chmod +x minikube-darwin-amd64
# 	if [[ $? != 0 ]]
# 	then
# 		exit 1
# 	fi
# 	sudo mkdir -p /usr/local/bin/
# 	sudo install minikube-darwin-amd64 /usr/local/bin/minikube
# fi
# if [[ ! $(command -v minikube) ]]
# then
# 	exit 1
# fi

# minikube delete

# if [[ ! -d ~/.minikube/machines/minikube ]]
# then
# 	minikube start --vm-driver=docker --cpus=4
# 	if [[ $? != 0 ]]
# 	then
# 		exit 1
# 	fi
# fi

eval $(minikube docker-env)

if [[ $? != 0 ]]
then
	exit 1
fi

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