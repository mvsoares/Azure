mysqlPortUP=$( { </dev/tcp/localhost/3306; } > /dev/null 2>&1 && echo 0 || echo 1)

# if mysql is not up...return
if [ $mysqlPortUP -eq 1 ] ; then
    exit 1
fi

# check for a drain
if [ ! -e /var/run/drain-mysql ] ; then
        # no drain file you can go alway - running - probe OK
        exit 0
fi

# once the drain is used - it should have been remove. So, this test prevents that.
# if the look was left there but it is expired you can add to the probe
currentDate=$(date +%s);
drainDate=$(cat /var/run/drain-mysql )
difference=$(($drainDate - currentDate))
expired=$( (( $difference <= 0 )); echo $?)

if [ $expired -eq 1 ] ; then
    #not expired yet - so this is drainning situation - you must remove from LB
    exit 1
else
    #expired the drain - keep this running - the file should have been removed
    rm -f /var/run/drain-mysql
    exit 0
fi

# just in case you came here....mysql is running...keep it on LB
exit 0