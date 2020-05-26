which -s brew
if [[ $? != 0 ]] ; then
	echo "Installing Brew..."
	rm -rf $HOME/.brew && git clone --depth=1 https://github.com/Homebrew/brew $HOME/.brew && export PATH=$HOME/.brew/bin:$PATH && brew update && echo "export PATH=$HOME/.brew/bin:$PATH" >> ~/.zshrc &> /dev/null
else
	echo "Updating Brew..."
	brew update &> /dev/null
fi

if minikube &> /dev/null
then
	echo -ne "\033[1;33m+>\033[0;33m Minikube check for upgrade ... \n"
	if brew upgrade minikube &> /dev/null
	then
		echo -ne "\033[1;32m+>\033[0;33m Minikube updated ! \n"
	else
		echo -ne "\033[1;31m+>\033[0;33m Error... During minikube update. \n"
		exit 1
	fi
else
	echo -ne "\033[1;31m+>\033[0;33m Minikube installation ...\n"
	if brew install minikube &> /dev/null
	then
		echo -ne "\033[1;32m+>\033[0;33m Minikube installed ! \n"
	else
		echo -ne "\033[1;31m+>\033[0;33m Error... During minikube installation. \n"
	fi
fi

echo "Starting Minikube (it might take a while)"
minikube start --vm-driver=virtualbox

server_ip = 'minikube ip'

