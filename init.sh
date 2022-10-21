#!/bin/bash

grep_os=`grep -w '^NAME' /etc/os-release`
grep_version=`grep -w '^VERSION' /etc/os-release`

function init_setting_ubuntu(){
  echo "===== update ubuntu ====="
  sudo apt update -y

  echo " ===== check docker version ====="
  sudo apt install docker docker.io -y

  echo "=================================="
  echo "===== docker-compose install ====="
  echo "=================================="
  sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose

  echo "===== check docker-compose version ====="
  docker-compose --version

  sudo service docker start
  sudo usermod -a -G docker ubuntu
  newgrp docker

  echo "===== finished ====="
}

function init_setting_amazon_linux(){
  echo "===== update Amazon Linux ====="
  sudo yum update -y

  echo "=========================="
  echo "===== install docker ====="
  echo "=========================="
  sudo amazon-linux-extras install docker


  echo "===== install docker-compose ====="
  sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose


  sudo service docker start
  sudo usermod -a -G docker ec2-user
  newgrp docker

  echo "===== finished ====="
}


if [[ "${grep_os}" == *"Ubuntu"* ]]; then
  echo "checked your os. your os is Ubuntu!!"
  os_name="Ubuntu"
  init_setting_ubuntu
elif [[ "${grep_os}" == *"Amazon Linux"* ]]; then
  echo "checked your os. your os is Amazon Linux!!"
  os_name="Linux"
  init_setting_amazon_linux
fi


