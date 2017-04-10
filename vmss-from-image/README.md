### Autoscale Linux with a Custom Image ###

Simple self-contained Linux autoscale example 

- Make sure all subnets already exists: for the application GTW and VMS. ILB will user VMS-subnet
- Uses a custom imageid with MD. Example:  /subscriptions/YOUR-SUB/resourceGroups/RESOURCE-GROUP/providers/Microsoft.Compute/images/IMAGE-NAME

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmvsoares%2FAzure%2Fmaster%2Fvmss-from-image%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load="https%3A%2F%2Fraw.githubusercontent.com%2Fmvsoares%2FAzure%2Fmaster%2Fvmss-from-image%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>
