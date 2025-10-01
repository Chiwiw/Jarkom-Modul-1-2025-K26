# pada node Eru
# install netcat
which nc || apt update && apt install -y netcat-openbsd

# pada node melkor :
# nyalakan FTP di Melkor (port 21)
apt update
apt install -y vsftpd
service vsftpd start

# nyalain HTTP server (port 80)
apt install -y apache2
service apache2 start

# jalankan port scan dari Eru ke Melkor :
nc -vz 192.224.1.2 21 80 666