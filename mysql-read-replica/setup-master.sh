if [ -n "$1" ] ; then
	mysqlPwd="$1"
else
	mysqlPwd="AzureRocks1000##"
fi

echo "server-id = 1
log_bin = /var/log/mysql/mysql-bin.log
binlog-ignore-db  = informationschema" >> /etc/my.cnf

systemctl restart mysqld


echo "GRANT REPLICATION SLAVE ON *.* TO 'slave_user'@'%' IDENTIFIED BY 'AzureRocks1000##';
FLUSH PRIVILEGES;" > /tmp/tmp-slave.sql 

mysql -u root -p"$mysqlPwd" < /tmp/tmp-slave.sql 

rm /tmp/tmp-slave.sql 