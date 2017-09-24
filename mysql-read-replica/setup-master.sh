if [ -n "$1" ] ; then
	mysqlPwd="$1"
else
	mysqlPwd="AzureRocks1000##"
fi

mkdir -p /var/log/mysql/
chown mysql.mysql /var/log/mysql/

echo "server-id = 1
log_bin = /var/log/mysql/mysql-bin.log
binlog-ignore-db  = informationschema" >> /etc/my.cnf

systemctl restart mysqld


echo "GRANT REPLICATION SLAVE ON *.* TO 'slave_user'@'%' IDENTIFIED BY '$mysqlPwd';
FLUSH PRIVILEGES;" > /tmp/tmp-replication.sql 

mysql -u root -p"$mysqlPwd" < /tmp/tmp-replication.sql 

rm /tmp/tmp-replication.sql 