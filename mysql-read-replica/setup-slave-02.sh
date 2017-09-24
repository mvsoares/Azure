if [ -n "$1" ] ; then
	mysqlPwd="$1"
else
	mysqlPwd="AzureRocks1000##"
fi

mkdir -p /var/log/mysql/
chown mysql.mysql /var/log/mysql/

echo "server-id = 3 
relay-log = /var/log/mysql/mysql-relay-bin.log
binlog-ignore-db  = informationschema
read-only=1" >> /etc/my.cnf

systemctl restart mysqld

echo "CHANGE MASTER TO MASTER_HOST='vm-mysql-master-rw',MASTER_USER='slave_user', MASTER_PASSWORD='$mysqlPwd', MASTER_LOG_FILE='mysql-bin.000001', MASTER_LOG_POS= 0;
START SLAVE;" > /tmp/tmp-slave.sql 

mysql -u root -p"$mysqlPwd" < /tmp/tmp-slave.sql 

rm /tmp/tmp-slave.sql 
