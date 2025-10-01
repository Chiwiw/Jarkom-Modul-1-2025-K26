#masuk ke manwe
apt update
apt install ftp

ftp 192.168.122.207 21
# Username : ainur
# Password : 234

#Eru
wget --no-check-certificate "https://drive.google.com/uc?export=download&id=11ua2KgBu3MnHEIjhBnzqqv2RMEiJsILY" -O kitab_penciptaan.zip
unzip kitab_penciptaan.zip
mv kitab_penciptaan.txt /shared
chown ainur:ainur /shared
chmod 755 /shared
service vsftpd start
nano /etc/vsftpd.conf
chroot_local_user=NO
service vsftpd restart

#manwe
ls /shared
cd /shared
get kitab_penciptaan.txt

#setup read only
nano /etc/vsftpd.conf
write_enable=NO
service vsftpd restart 