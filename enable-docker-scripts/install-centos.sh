yum update -y --exclude=WALinuxAgent
yum install sysstat epel-release -y
curl -fsSL https://get.docker.com/ | sh
systemctl start docker
systemctl status docker
systemctl enable docker
usermod -aG docker azuretest
docker run -d -p 80:80 mvsoares/nginx-centos:v2

wget http://dl.fedoraproject.org/pub/epel/6/x86_64/Packages/s/siege-3.0.8-1.el6.x86_64.rpm > /tmp/siege-3.0.8-1.el6.x86_64.rpm
rpm -ivh /tmp/siege-3.0.8-1.el6.x86_64.rpm
