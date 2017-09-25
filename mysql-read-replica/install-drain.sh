
mkdir -p /etc/azure 
mkdir -p /opt/azure 

rm -f /etc/azure/VMSnapshotScriptPluginConfig.json
rm -f /opt/azure/post-script.sh
rm -f /opt/azure/pre-script.sh

wget --no-check-certificate -O /etc/azure/VMSnapshotScriptPluginConfig.json  https://raw.githubusercontent.com/mvsoares/Azure/master/mysql-read-replica/VMSnapshotScriptPluginConfig.json
wget --no-check-certificate -O /opt/azure/post-script.sh https://raw.githubusercontent.com/mvsoares/Azure/master/mysql-read-replica/post-script.sh
wget --no-check-certificate -O /opt/azure/pre-script.sh https://raw.githubusercontent.com/mvsoares/Azure/master/mysql-read-replica/pre-script.sh

chmod 700 /opt/azure/pre-script.sh
chmod 700 /opt/azure/post-script.sh
chmod 600 /etc/azure/VMSnapshotScriptPluginConfig.json

exit 0