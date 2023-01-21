#!/bin/bash
echo "===== Run user_data file for dev-srv ======="

echo '===== update =========================='
sudo  apt update 
pwd

echo "===== AWS CLI install ======="
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip
unzip awscliv2.zip
sudo ./aws/install

echo "===== docker-compose install ======="
sudo apt install docker docker-compose

#echo "=== add github known_hosts ==="
#sudo ssh-keyscan github.com >> /home/ubuntu/.ssh/known_hosts

#echo '===== Create my_soft.sh =========================='
#cat << EOF > /etc/profile.d/my_soft.sh

#EOF

#source /etc/profile.d/my_soft.sh


echo "=== finish User_data file ======"
