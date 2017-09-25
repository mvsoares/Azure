yum install -y nmap-ncat httpd

systemctl enable httpd

echo '#!/bin/bash
echo "Content-Type: text/plain"
echo
echo This is a sample
date' > /var/www/cgi-bin/test.cgi

chmod +x /var/www/cgi-bin/test.cgi

systemctl restart httpd 

exit 0
