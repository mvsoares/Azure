vim /etc/drain.sh
#!/bin/bash
date > /var/log/info.txt
curl localhost/host.php >> /var/log/info.txt
mv /var/www/html/ok.html /var/www/html/ok1.html
for i in {1..10}; do echo "- Waiting to shutdown $i `date`" >> /var/log/drain.log; sleep 3; done;

chmod +x /etc/drain.sh

cat /etc/undrain.sh
#!/bin/bash
if [ -e /var/www/html/ok1.html ] ; then
  mv /var/www/html/ok1.html /var/www/html/ok.html
fi

chmod +x /etc/undrain.sh

vim /usr/lib/systemd/system/drain.service

[Unit]
Description=Drain service
After=httpd.service

[Service]
Type=oneshot
ExecStart=/etc/undrain.sh
ExecStop=/etc/drain.sh
RemainAfterExit=yes
TimeoutStopSec=2min

[Install]
WantedBy=default.target


systemctl enable drain.service
systemctl start drain.service
systemctl status drain.service


yum install httpd php -y
systemctl start httpd.service
systemctl enable httpd.service

echo OK > /var/www/html/ok
echo "<?php echo gethostname(); ?>" > /var/www/html/host.php
echo "<?php phpinfo(); ?>" > /var/www/html/info.php
