#!/bin/bash
echo "Executing before Drain `date`" >> /tmp/log-bkp
date -d "now + 10 minutes" +%s > /var/run/drain-mysql 
sleep 600
systemctl stop mysqld
echo "End of drain `date` " >> /tmp/log