#!/bin/bash
echo "===== Run user_data file for Jenkins Node 1 ======="

echo '===== update, Install openjdk 19, git, maven =========================='
sudo  apt update 

echo "===== AWS CLI install ======="
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

echo "== Install Java-JDK 19 version =="
#
# from https://www.oracle.com/java/technologies/downloads/#jdk19-linux
wget https://download.oracle.com/java/19/latest/jdk-19_linux-x64_bin.tar.gz
tar -xvf jdk-19_linux-x64_bin.tar.gz
sudo mv jdk-19.0.1 /opt/
rm jdk-19_linux-x64_bin.tar.gz

echo "======== Install Java-jdk11 ========"
sudo apt -y install openjdk-11-jre-headless  #openjdk-11-jre-headless

echo "=== Install maven ==="
# from https://maven.apache.org/download.cgi
# Binary tar.gz archive

wget https://dlcdn.apache.org/maven/maven-3/3.8.7/binaries/apache-maven-3.8.7-bin.tar.gz
tar -xvf apache-maven-3.8.7-bin.tar.gz
sudo mv apache-maven-3.8.7 /opt/
rm apache-maven-3.8.7-bin.tar.gz

echo "=== finish Java and maven install ===" 

echo 'Create java_maven.sh =========================='
cat << EOF > /etc/profile.d/java_maven.sh
JAVA_HOME='/opt/jdk-19.0.1'
PATH="\$JAVA_HOME/bin:\$PATH"
export PATH

M2_HOME='/opt/apache-maven-3.8.7'
PATH="\$M2_HOME/bin:\$PATH"
export PATH
EOF

source /etc/profile.d/java_maven.sh

java --version
mvn --version

echo "=== add github known_hosts ==="
sudo ssh-keyscan github.com >> /home/ubuntu/.ssh/known_hosts

echo "=== finish User_data file ======"
