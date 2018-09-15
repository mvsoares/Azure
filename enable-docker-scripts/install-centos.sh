yum update -y --exclude=WALinuxAgent
yum install sysstat epel-release -y
yum install siege -y
curl -fsSL https://get.docker.com/ | sh
systemctl start docker
systemctl status docker
systemctl enable docker
usermod -aG docker azuretest
docker run -d -p 80:80 mvsoares/nginx-centos:v1
