#!/bin/bash

# sleep until instance is ready
# until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
#   sleep 1
# done

# Install nginx
apt-get update
apt-get -y install nginx

# Make sure nginx is started
service nginx start

# install docker
# sudo apt-get update && sudo apt-get upgrade -y
# sudo apt install apt-transport-https ca-certificates curl software-properties-common
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
# sudo apt-get update
# sudo apt install docker-ce -y

# # Install docker-compose
# sudo apt-get update && sudo apt-get upgrade -y
# sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# sudo chmod +x /usr/local/bin/docker-compose

# # Install git
# sudo apt-get update && sudo apt-get upgrade -y
# sudo apt-get install git -y

# Install pip3
sudo apt-get update && sudo apt-get upgrade -y
sudo apt install python3-pip -y
sudo apt-get install python3-venv -y
