#!/bin/bash
fileToLog="/var/log/drain.txt"
echo "---------------------" >> $fileToLog

echo "Init drain `date` " >> $fileToLog

for i in {1..60}
do 
    echo "  $i waiting for drain to happend `date` " >> $fileToLog
    sleep 1; 
done

echo "End drain `date` " >> $fileToLog