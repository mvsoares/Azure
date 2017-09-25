yum install -y httpd

systemctl enable httpd

wget --no-check-certificate -O /var/www/cgi-bin/probe.sh https://raw.githubusercontent.com/mvsoares/Azure/master/mysql-read-replica/probe.sh 
wget --no-check-certificate -O /var/www/cgi-bin/mysql-probe https://raw.githubusercontent.com/mvsoares/Azure/master/mysql-read-replica/mysql-probe 
chmod +x /var/www/cgi-bin/probe.sh
chmod +x /var/www/cgi-bin/mysql-probe

echo '#!/bin/bash
probeResult=$(bash /var/www/cgi-bin/probe.sh)

if [ $probeResult -eq 0 ] ; then
	echo "Content-Type: text/plain"
	echo
	echo This is a sample
	date' > /var/www/cgi-bin/probe.cgi
else
	echo "Content-Type: text/plain"
	echo
	echo This is a sample
	date' > /var/www/cgi-bin/probe.cgi
fi


chmod +x /var/www/cgi-bin/probe.cgi

systemctl restart httpd 

exit 0
