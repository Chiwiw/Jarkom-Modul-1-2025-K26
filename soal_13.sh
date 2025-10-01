# Pada Node Eru :
# install & start sshd
apt update
apt install -y openssh-server

# pastikan sshd jalan
service ssh start

# buat user vardauser dengan password vardapass123
useradd -m -s /bin/bash vardauser
echo "vardauser:vardapass123" | chpasswd

# Pada Node Varda :
# login ke Eru sebagai vardauser
ssh vardauser@192.224.1.1
