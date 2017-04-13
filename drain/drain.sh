#!/bin/bash
date > /var/log/info.txt
curl localhost/host.php >> /var/log/info.txt
mv /var/www/html/ok.html /var/www/html/ok1.html
for i in {1..10}; do echo "- Waiting to shutdown $i `date`" >> /var/log/drain.log; sleep 3; done;

