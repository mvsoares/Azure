!#/usr/bin/bash

# update OS
sudo yum update -y 

# enable mysql repo
wget https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm --no-check-certificate
sudo rpm -ivh mysql57-community-release-el7-11.noarch.rpm

sudo yum update

sudo yum install mysql-server


#wget https://raw.githubusercontent.com/major/MySQLTuner-perl/master/mysqltuner.pl
#perl ./mysqltuner.pl

