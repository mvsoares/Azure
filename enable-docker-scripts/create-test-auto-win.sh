#!/usr/bin/bash

# variable defintion 
baseName=testnw-win
rg=rg-$baseName
vnet=vnet-$baseName
subnet=default
nsgName=nsg-$baseName
vmSize=Standard_D8s_v3
adminUsername=azuretest
adminPassword=L8ytNthsJDk4fQB
location=southcentralus

# create group / network / nsg 
az group create -n $rg  -l $location 

az network vnet create -g $rg \
--name $vnet --address-prefix 10.10.0.0/24 \
--subnet-name $subnet --subnet-prefix 10.10.0.0/25

az network nsg create --resource-group $rg \
  --name $nsgName

az network nsg rule create --resource-group  $rg \
  --nsg-name $nsgName --name allow-rdp \
  --protocol tcp --direction inbound --priority 1000 --source-address-prefix '*' \
  --source-port-range '*' --destination-address-prefix '*' --destination-port-range 3389 \
  --access allow

az network nsg rule create --resource-group  $rg \
  --nsg-name $nsgName --name allow-web \
  --protocol tcp --direction inbound --priority 1001 --source-address-prefix '*' \
  --source-port-range '*' --destination-address-prefix '*' --destination-port-range 80 \
  --access allow

az network nsg rule create --resource-group  $rg \
  --nsg-name $nsgName --name allow-ssh \
  --protocol tcp --direction inbound --priority 1002 --source-address-prefix '*' \
  --source-port-range '*' --destination-address-prefix '*' --destination-port-range 22 \
  --access allow


az network nsg rule create --resource-group  $rg \
  --nsg-name $nsgName --name allow-http \
  --protocol tcp --direction inbound --priority 1001 --source-address-prefix '*' \
  --source-port-range '*' --destination-address-prefix '*' --destination-port-range 80 \
  --access allow

## bastion server 
vmPrefix=bastion1
imageName=MicrosoftWindowsServer:WindowsServerSemiAnnual:Datacenter-Core-1803-with-Containers-smalldisk:1803.0.20180815
vmSizeBastion=Standard_D4s_v3
baseNameBastion=$vmPrefix

echo -e "Creating Bastion Server: $baseNameBastion"

az network public-ip create --resource-group $rg \
    --name pip-$baseNameBastion --allocation-method static --idle-timeout 4

az network nic create \
    -n nic-$baseNameBastion \
    -g $rg \
    --subnet $subnet \
    --network-security-group $nsgName \
    --public-ip-address pip-$baseNameBastion \
    --vnet-name $vnet 

az vm create \
    -g $rg \
    --os-disk-name osdisk-$baseNameBastion \
    --name vm-$baseNameBastion \
    --nics nic-$baseNameBastion \
    --storage-sku premium_lrs \
    --size $vmSizeBastion \
    --image $imageName \
    --admin-username $adminUsername \
    --admin-password $adminPassword \
    --authentication-type password

echo -e "Bastion server $baseNameBastion created. Initing scripts ... "
