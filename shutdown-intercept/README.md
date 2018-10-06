This project will create a vm and demonstrate how to intercept a shutdown command. This way you should be able to run an action before it continue. 

1. use create-vms.sh to provision your vm.

User and password will be printed in the end. You should have az-cli configured on this shell. 

Once vm is configured, systemctl will be wrapped and call script /sbin/drain.sh for reboot/poweroff/shutdown command. 

