#!/bin/bash
echo "===== Run user_data file for main-srv ======="

echo '===== update =========================='
sudo  apt update 
pwd
sudo timedatectl set-timezone Europe/Kyiv

echo "===== AWS CLI install ======="
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip -y
unzip awscliv2.zip
sudo ./aws/install

echo "===== mysql install ======="
sudo apt install mysql-server -y
sudo iptables -A INPUT -p tcp --destination-port 3306 -j ACCEPT
# config file /etc/mysql/mysql.conf.d/mysqld.cnf


echo "== Install Java-JDK 19 version =="
#
# from Archive https://download.oracle.com/java/19/archive/jdk-19.0.2_linux-x64_bin.tar.gz
# from https://www.oracle.com/java/technologies/downloads/#jdk19-linux
# latest Java: https://download.oracle.com/java/19/latest/jdk-19_linux-x64_bin.tar.gz
wget https://download.oracle.com/java/19/archive/jdk-19.0.2_linux-x64_bin.tar.gz
tar -xvf jdk-19.0.2_linux-x64_bin.tar.gz
sudo mv jdk-19.0.2 /opt/
rm jdk-19.0.2_linux-x64_bin.tar.gz

echo '===== Create java_19_env.sh =========================='
cat << EOF > /etc/profile.d/java_19_env.sh
JAVA_HOME='/opt/jdk-19.0.2'
PATH="\$JAVA_HOME/bin:\$PATH"
export PATH
MYSQL_ROOT_PASSWORD=
MYSQL_ALLOW_EMPTY_PASSWORD=true
MYSQL_USER=petclinic
MYSQL_PASSWORD=petclinic
MYSQL_DATABASE=petclinic
EOF

cat << EOF > /etc/profile.d/add_port_froward.sh
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to-destination :8082
EOF
source /etc/profile.d/add_port_froward.sh
sudo iptables -t nat -L -v
source /etc/profile.d/java_19_env.sh
java --version

cat << EOF > ./petclinic_init.sql
create user 'petclinic'@'localhost' IDENTIFIED BY 'PetcliniC_567890';
GRANT ALL PRIVILEGES ON *.* TO 'petclinic'@'localhost';
flush privileges;
create database petclinic;
EOF
sudo systemctl enable mysql
sudo systemctl restart mysql
sleep 5
sudo mysql < ./petclinic_init.sql


#java -jar ~/spring-petclinic-3.0.0-SNAPSHOT.jar --spring.profiles.active=mysql --server.port=8082 --spring.datasource.url=jdbc:mysql://localhost:3306/petclinic --spring.datasource.username=petclinic --spring.datasource.password=PetcliniC_567890
#sudo mysql -u root petclinic < petclinic_backup_1.sql

echo "=== add github known_hosts ==="
sudo ssh-keyscan github.com >> /home/ubuntu/.ssh/known_hosts

echo "=== finish User_data file ======"
