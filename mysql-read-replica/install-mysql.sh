# update OS
sudo yum update -y 

ok=$(rpm -qa|grep mysql-community-server |wc -l |xargs)

if [ $ok -gt 0 ] ; then
    echo "Mysql already installed. Nothing to do"
	exit 0
fi

# enable mysql repo
wget https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm --no-check-certificate
sudo rpm -ivh mysql57-community-release-el7-11.noarch.rpm

sudo yum update -y

sudo yum install mysql-server -y

sudo systemctl enable mysqld
sudo systemctl start mysqld

mysqlPwd=$(grep 'A temporary password is generated for' /var/log/mysqld.log |awk '{print $NF}')

if [ -n "$1" ] ; then
    newpw="$1"
else
    newpw="AzureRocks100!"
fi

echo "Setting new password: $newpw"

if [ ! -e ~/.my.cnf ] ; then
    echo "
[client]
user=root
password=$mysqlPwd
host=localhost" > ~/.my.cnf

mysqladmin -u root password $newpw
else
    echo "~/.my.cnf already there - nothing to do"
fi

exit 0