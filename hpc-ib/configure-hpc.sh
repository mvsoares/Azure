cat > /etc/yum.repos.d/elrepo.repo <<EOF
[elrepo]
name=ELRepo.org Community Enterprise Linux Repository - el7
baseurl=http://elrepo.org/linux/elrepo/el7/$basearch/
        http://mirrors.coreix.net/elrepo/elrepo/el7/$basearch/
        http://mirror.rackspace.com/elrepo/elrepo/el7/$basearch/
        http://repos.lax-noc.com/elrepo/elrepo/el7/$basearch/
        http://mirror.ventraip.net.au/elrepo/elrepo/el7/$basearch/
mirrorlist=http://mirrors.elrepo.org/mirrors-elrepo.el7
enabled=1
gpgcheck=0

[epel]
name=Extra Packages for Enterprise Linux 7 - $basearch
#baseurl=http://download.fedoraproject.org/pub/epel/7/$basearch
metalink=https://mirrors.fedoraproject.org/metalink?repo=epel-7&arch=$basearch
failovermethod=priority
enabled=1
gpgcheck=0
EOF

yum install  mpich-3.0 mpich-3.0-devel htop iftop -y

ln -s /usr/lib64/mpich/bin/mpiexec /usr/bin/mpiexec
ln -s /usr/lib64/mpich/bin/mpirun /usr/bin/mpirun
ln -s /usr/lib64/mpich/bin/hydra_pmi_proxy /usr/bin/hydra_pmi_proxy
ln -s /usr/lib64/mpich/bin/mpicc /usr/bin/mpicc
