
nc 10.15.43.32 3403

# Filter untuk menampilkan username dan password pada FTP
frame contains "USER"

# filter untuk cari q.exe
ftp.request.command == "USER"  

sha256sum q.exe

#flag 
Congratulations! Here is your flag: KOMJAR25{Y0u_4r3_4_g00d_4nalyz3r_akoPJsYnS1Lo23GybtYBsLFfs}