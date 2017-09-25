yum install -y httpd

setenforce 0
sed -i -e s/"SELINUX=enforcing"/"SELINUX=disabled"/g /etc/selinux/config

systemctl enable httpd

rm -f /var/www/cgi-bin/mysql-probe

wget --no-check-certificate -O /var/www/cgi-bin/mysql-probe https://raw.githubusercontent.com/mvsoares/Azure/master/mysql-read-replica/mysql-probe 
chmod +x /var/www/cgi-bin/mysql-probe
chown apache.apache /var/www/cgi-bin/mysql-probe

systemctl restart httpd 

exit 0
