#!/bin/bash
echo "===== Run user_data file for dev-srv ======="

echo '===== update =========================='
sudo  apt update 
pwd
sudo timedatectl set-timezone Europe/Kyiv

echo "===== AWS CLI install ======="
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip -y
unzip awscliv2.zip
sudo ./aws/install

echo "===== docker-compose install ======="
sudo apt install docker docker-compose -y
sudo usermod -aG docker $USER

echo "===== python3-pip install ======="
sudo apt install python3-pip -y
#python3 -m pip install boto3  #this installs in playbook
#python3 -m pip install botocore

#echo '===== Create my_soft.sh =========================='
#cat << EOF > /etc/profile.d/my_soft.sh

#EOF

#source /etc/profile.d/my_soft.sh


echo "=== finish User_data file ======"
