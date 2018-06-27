wget http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -o /tmp/epel-release-latest-7.noarch.rpm
rpm -ivh /tmp/epel-release-latest-7.noarch.rpm

yum install mpich-3.0 mpich-3.0-devel htop iftop -y

ln -s /usr/lib64/mpich/bin/mpiexec /usr/bin/mpiexec
ln -s /usr/lib64/mpich/bin/mpirun /usr/bin/mpirun
ln -s /usr/lib64/mpich/bin/hydra_pmi_proxy /usr/bin/hydra_pmi_proxy
ln -s /usr/lib64/mpich/bin/mpicc /usr/bin/mpicc

echo "Finalizado"