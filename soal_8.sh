#Download cuaca.zip di ulmo
wget --no-check-certificate "https://drive.google.com/uc?export=download&id=11ra_yTV_adsPIXeIPMSt0vrxCBZu0r33" -O cuaca.zip
unzip cuaca.zip

# Connect ke FTP Eru
ftp 192.168.122.207 (ini pake yg eth0)
# Username : ainur
# Password : (enter)

#upload file 
put cuaca.txt
put mendung.jpg
