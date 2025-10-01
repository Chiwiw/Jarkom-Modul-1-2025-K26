

# setup FTP 
apt update
apt install vsftpd -y
mkdir -p /shared

#add user
useradd melkor
useradd ainur

service vsftpd start

#Konfigurasi FTP
nano /etc/vsftpd.conf
listen=YES
listen_ipv6=NO
anonymous_enable=NO
chroot_local_user=YES
allow_writeable_chroot=YES

apt install -y inetutils-ftp 
ftp localhost

# Akses Ainur
chown ainur:ainur shared/
chmod 700 shared/

su ainur
touch /ftp/shared/test.txt

su melkor
touch /ftp/shared/test.txt

