apt install apache2 php libapache2-mod-php -y
apt-get update
apt-get upgrade -y
ufw allow 'Apache'
systemctl status apache2 
systemctl enable apache2 
echo '
<?php 
phpinfo(); 
?> ' >> /var/www/html/info.php

cp /bin/systemctl /bin/systemctl.original
rm /bin/systemctl

curl --insecure https://raw.githubusercontent.com/mvsoares/Azure/master/shutdown-intercept/systemctl > /bin/systemctl
curl --insecure https://raw.githubusercontent.com/mvsoares/Azure/master/shutdown-intercept/drain.sh > /sbin/drain.sh

chmod +x /bin/systemctl
chmod +x /sbin/drain.sh
