#/bin/bash

#Install docker CE
sudo apt-get update -yqq

sudo apt-get install -yqq \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
    maven

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update -yqq

sudo apt-get install docker-ce -yqq

#Add current user to docker group to run commands without sudo
sudo usermod -a -G docker `whoami`

echo "VM Initialized"

echo "Please logout & login again!"
