#!/bin/bash
echo "Executing post Drain `date`" >> /tmp/log-bkp
rm /var/run/drain-mysql 
systemctl start mysqld
echo "End of drain `date` " >> /tmp/log