# Pada Node Melkor :
# update & install telnet server + inetd (Debian-based)
apt update
apt install -y openbsd-inetd telnetd || apt install -y inetutils-inetd telnetd

service openbsd-inetd restart || service inetutils-inetd restart || service inetd restart

# Buat user untuk login telnet (contoh 'praktikan11' / 'praktikan123')
useradd -m praktikan11 -s /bin/bash
echo "praktikan11:praktikan123" | chpasswd


# Pada Node Eru :
# nyoba koneksi telnet
telnet 192.224.1.2 23