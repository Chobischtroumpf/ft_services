
#checking if brew is installed
which -s brew
if [[ $? != 0 ]] ; then
	echo "Installing Brew..."
	rm -rf $HOME/.brew && git clone --depth=1 https://github.com/Homebrew/brew $HOME/.brew && export PATH=$HOME/.brew/bin:$PATH && brew update && echo "export PATH=$HOME/.brew/bin:$PATH" >> ~/.zshrc &> /dev/null
fi

#checking if minikube is installed
which -s minikube
if [[ $? != 0 ]] ; then
	echo -ne "\033[1;31m+>\033[0;33m Minikube installation ...\n"
	if brew install minikube &> /dev/null
	then
		echo -ne "\033[1;32m+>\033[0;33m Minikube installed ! \n"
	else
		echo -ne "\033[1;31m+>\033[0;33m Error... During minikube installation. \n"
		return 0
	fi
fi

echo "set minikube_home"/

echo "Deleting previous cluster if there is one"
minikube delete

echo "Starting Minikube (it might take a while)"
minikube start --vm-driver=virtualbox
minikube addons enable metrics-server
minikube addons enable dashboard
minikube addons enable metallb
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml

# On first install only
echo "eval (minikube docker-env)"
eval $(minikube docker-env)

# setting up metallb and configmap
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f yaml/configMap.yaml

#building docker images
docker build -t ft_mysql ./srcs/mysql/
kubectl apply -f yaml/mysql.yaml

docker build -t ft_phpmyadmin srcs/phpmyadmin/
docker build -t ft_wordpress srcs/wordpress/
docker build -t ft_mynginx srcs/nginx/
docker build -t ft_ftps --build-arg IP=192.168.99.121 srcs/ftps/
docker build -t ft_influxdb srcs/influxdb/
docker build -t ft_grafana srcs/grafana/

## tells to wait untill mysql pod is started
kubectl exec -i $(kubectl get pods | grep mysql | cut -d" " -f1) -- mysql wordpress -u root < srcs/mysql/wordpress.sql

kubectl apply -f yaml/phpmyadmin.yaml
kubectl apply -f yaml/wordpress.yaml
kubectl apply -f yaml/nginx.yaml
kubectl apply -f yaml/ftps.yaml
kubectl apply -f yaml/influxdb.yaml
kubectl apply -f yaml/grafana.yaml



minikube ip
# docker ps -a
# minikube start --vm-driver=virtualbox
minikube dashboard & 
