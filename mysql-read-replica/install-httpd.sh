yum install -y httpd

systemctl enable httpd

rm -f /var/www/cgi-bin/probe.sh
rm -f /var/www/cgi-bin/mysql-probe

wget --no-check-certificate -O /var/www/cgi-bin/probe.sh https://raw.githubusercontent.com/mvsoares/Azure/master/mysql-read-replica/probe.sh 
wget --no-check-certificate -O /var/www/cgi-bin/mysql-probe https://raw.githubusercontent.com/mvsoares/Azure/master/mysql-read-replica/mysql-probe 
chmod +x /var/www/cgi-bin/probe.sh
chmod +x /var/www/cgi-bin/mysql-probe

systemctl restart httpd 

exit 0
