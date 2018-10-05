#!/bin/bash

# variable defintion 
baseName=systemd1
rg=rg-$baseName
vnet=vnet-$baseName
subnet=default
nsgName=nsg-$baseName
vmSize=Standard_B2s
adminUsername=azuretest
adminPassword=$(openssl rand -base64 12)
location=eastus
ubuntuImage=UbuntuLTS

# create group / network / nsg 
az group create -n $rg  -l $location 

az network vnet create -g $rg \
--name $vnet --address-prefix 10.10.0.0/24 \
--subnet-name $subnet --subnet-prefix 10.10.0.0/25

az network nsg create --resource-group $rg \
  --name $nsgName

az network nsg rule create --resource-group  $rg \
  --nsg-name $nsgName --name allow-ssh \
  --protocol tcp --direction inbound --priority 1000 --source-address-prefix '*' \
  --source-port-range '*' --destination-address-prefix '*' --destination-port-range 22 \
  --access allow

az network nsg rule create --resource-group  $rg \
  --nsg-name $nsgName --name allow-http \
  --protocol tcp --direction inbound --priority 1001 --source-address-prefix '*' \
  --source-port-range '*' --destination-address-prefix '*' --destination-port-range 80 \
  --access allow

imageName=$ubuntuImage
vmPrefix=$baseName
for i in {1..1}; 
do
    baseNameLoop=$vmPrefix$i
    echo -e "Initing $baseNameLoop . Image: $imageName "

    az network public-ip create --resource-group $rg \
    --name pip-$baseNameLoop --allocation-method static --idle-timeout 4

    az network nic create \
        -n nic-$baseNameLoop \
        -g $rg \
        --subnet $subnet \
        --network-security-group $nsgName \
        --vnet-name $vnet \
        --public-ip-address pip-$baseNameLoop \

    az vm create \
        -g $rg \
        --os-disk-name osdisk-$baseNameLoop \
        --name vm-$baseNameLoop \
        --nics nic-$baseNameLoop \
        --storage-sku premium_lrs \
        --size $vmSize \
        --image $imageName \
        --admin-username $adminUsername \
        --admin-password "$adminPassword" \
        --authentication-type password      
    echo -e "Vm $baseNameLoop created. Initing scripts"
    az vm extension set -g $rg --vm-name vm-$baseNameLoop --name customScript --publisher Microsoft.Azure.Extensions --settings '{"fileUris": ["https://raw.githubusercontent.com/mvsoares/Azure/master/shutdown-intercept/install-ubuntu.sh"],"commandToExecute": "bash install-ubuntu.sh"}'
  
done

echo "username: $adminUsername password: $adminPassword"