# Jarkom-Modul-1-2025-K26
| No | Nama               | NRP      |
|----|----------------    |----------|
| 1  |Hanif Mawla Faizi   |5027241064|
| 2  |Fika Arka Nuriyah   |5027241071|

## Soal 1
Untuk mengerjakan soal ini, pertama tama setelah kita buka GNS3, kita tambahkan 5 node yang bernama Eru, Melkor, Manwe, Varda, dan Ulmo.
Setelah itu, kita tambahkan 2 Swtich dan 1 Nat dan susun menjadi seperti ini :
<img width="969" height="700" alt="image" src="https://github.com/user-attachments/assets/4bf8e15a-5953-493c-9c04-2bb5f7fc4ef0" />

## Soal 2
Sebelumnya sudah kita tarik Nat. Jadi langkah berikutnya adalah konfigurasi IP dari Node Eru.
- Klik kanan Node Eru, pencet menu Configure, dan pergi ke Edit Network Configuration.
- Disitu, hapus semua text, dan paste IP config berikut:
  ```sh
  auto eth0
  iface eth0 inet dhcp
  ```
- Dengan begitu saat Node distart, kita bisa connect ke Node Eru dengan melakukan telnet di CLI Linux :
  <img width="346" height="432" alt="image" src="https://github.com/user-attachments/assets/d9c5ee18-11c1-4df7-9442-633496a0136a" />

  Disini jalankan perintah :
  ```sh
  telnet 10.15.43.32 5153
  ```
  agar bisa terhubung ke Eru.

## Soal 3
Agar setiap Client (Melkor, Manwe, Varda, dan Ulmo) bisa terhubung, satu sama lain, kita harus melakukan sedikit IP configuration kepada mereka semua.

Ubah IP Config :
- Eru :
  ```sh
  auto eth0
  iface eth0 inet dhcp
  
  auto eth1
  iface eth1 inet static
  	address [Prefix IP].1.1
  	netmask 255.255.255.0
  
  auto eth2
  iface eth2 inet static
  	address [Prefix IP].2.1
  	netmask 255.255.255.0
  ```
- Melkor :
  ```sh
  auto eth0
  iface eth0 inet static
  	address 192.224.1.2
  	netmask 255.255.255.0
  	gateway 192.224.1.1
  ```
- Manwe :
  ```sh
  auto eth0
  iface eth0 inet static
  	address 192.224.1.3
  	netmask 255.255.255.0
  	gateway 192.224.1.1
  ```
- Varda :
  ```sh
  auto eth0
  iface eth0 inet static
  	address 192.224.2.2
  	netmask 255.255.255.0
  	gateway 192.224.2.1
  ```
- Ulmo :
  ```sh
  auto eth0
  iface eth0 inet static
  	address 192.224.2.3
  	netmask 255.255.255.0
  	gateway 192.224.2.1
  ```
Dengan begini, Eru dan ke 4 Client sudah bisa berkomunikasi 1 sama lain.

## Soal 4
- agar semua node dapat mandiri dan bisa akses internet, kita perlu menambahkan sesuatu pada setiap node.
- Ketikkan `iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.224.0.0/16` pada router `Eru` Keterangan:
  **iptables:** iptables merupakan suatu tools dalam sistem operasi Linux yang berfungsi sebagai filter terhadap lalu lintas data. Dengan iptables inilah kita akan mengatur semua lalu lintas dalam komputer, baik yang masuk, keluar, maupun yang   sekadar melewati komputer kita. Untuk penjelasan lebih lanjut nanti akan dibahas pada Modul 5.
  **NAT (Network Address Translation):** Suatu metode penafsiran alamat jaringan yang digunakan untuk menghubungkan lebih dari satu komputer ke jaringan internet dengan menggunakan satu alamat IP.
  **Masquerade:** Digunakan untuk menyamarkan paket, misal mengganti alamat pengirim dengan alamat router.
  **-s (Source Address):** Spesifikasi pada source. Address bisa berupa nama jaringan, nama host, atau alamat IP.
- Selanjutnya pada setiap Node Client, Ketikkan :
  ```sh
  echo nameserver 192.168.122.1 > /etc/resolv.conf
  ```
- Dengan begitu semua client sekarang bisa akses internet.
## Soal 5
- Karena semua node disini tidak persisten, alias saat node direstart, semua perubahaan yang dilakukan pada node tidak akan tersimpan.
- Dengan begitu, setiap perubahaan yang dilakukan bisa disimpan di `/root`.
- Langkah pada nomor 4 akan kita simpan pada `/root/.bashrc`.
  Pada Eru :
   ```sh
  iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.224.0.0/16
  echo nameserver 192.168.122.1 > /etc/resolv.conf
  ```
   Pada setiap client :
   ```sh
  echo nameserver 192.168.122.1 > /etc/resolv.conf
  ```
- Jika kita sudah menaruh setiap script itu di `/root/.bashrc`, maka saat node direstart, dia akan menjalankan semua perintah didalam `/root/.bashrc` secara otomatis.

## Soal 6

### 1. masuk ke node manwe
telnet 10.15.43.32 (port manwe)

### 2. buka wireshark
capture jaringan komunikasi manwe lewat gns3

### 3. membuat file traffic
nano traffic.sh
chmod +x traffic.sh
./traffic.sh

### 4. buka wireshark
ip.src == 192.224.1.3

## Soal 7
### 1. masuk ke node Eru 
telnet 10.15.43.32 (port eru)

### 2. Setup FTP
apt update
apt install vsftpd -y

### 3. membuat folder 
```
mkdir -p /shared
```
### 4. membuat user
```
adduser melkor 
adduser ainur
```
### 5. konfigurasi FTP
nano /etc/vsftpd.conf 
``` 
isten=YES
listen_ipv6=NO
anonymous_enable=NO
chroot_local_user=YES
allow_writeable_chroot=YES
```

### 6. install 
apt install -y inetutils-ftp 
ftp localhost

### 7. ubah kepemilikan dan akses direktori
```
chown ainur:ainur shared/
chmod 700 shared/
```

### 8. tes 
- masuk ke user ainur
```
su ainur
touch /shared/test.txt
```
- masuk ek user melkor
```
su melkor
touch /shared/test.txt
```
## Soal 8

### 1. masuk ke node Ulmo
telnet 10.15.43.32 (port ulmo)

### 2. Download cuaca.zip 
```
wget --no-check-certificate "https://drive.google.com/uc?export=download&id=11ra_yTV_adsPIXeIPMSt0vrxCBZu0r33" -O cuaca.zip
unzip cuaca.zip
```
### 3. connect ke FTP Eru
```
ftp 192.168.122.207 21
```

### 4. ubah config ftp di eru
```
write_enable=YES
service vsftpd restart
```

###  5. upload file 
```
put cuaca.txt
put mendung.jpg
```

## Soal 9
### 1. masuk ke node manwe
```
apt update
apt install ftp
```

### 2. connect ftp ke eru
```
ftp 192.168.122.207 21
```

### 3. mempersiapkan file
- masuk ke node eru
```
wget --no-check-certificate "https://drive.google.com/uc?export=download&id=11ua2KgBu3MnHEIjhBnzqqv2RMEiJsILY" -O kitab_penciptaan.zip
unzip kitab_penciptaan.zip
mv kitab_penciptaan.txt /shared
chown ainur:ainur /shared
chmod 777 /shared
```

### 4. ubah config vsftpd
```
service vsftpd start
nano /etc/vsftpd.conf
chroot_local_user=NO
service vsftpd restart
```

### 5. balik ke manwe
```
ls /shared
cd /shared
get kitab_penciptaan.txt
```

### 6. setup read-only
```
nano /etc/vsftpd.conf
write_enable=NO
service vsftpd restart 
chmod 444 /shared/kitab_penciptaan.txt
```

## Soal 10

```
ping -c 100 192.168.122.207
```
nanti diakhir akan ada infomasi berapa packet loss yang terjadi dan rtt nya
```
--- 192.168.122.207 ping statistics ---
100 packets transmitted, 100 received, 0% packet loss, time 112606ms
rtt min/avg/max/mdev = 0.168/0.356/0.877/0.093 ms

```
kesimpulannya krn packet loss 0 maka hal ini tidak mempengaruhi kinerja dari eru 
## Soal 11
1. Pada Node Melkor :
  - update & install telnet server + inetd (Debian-based)
     ```sh
      apt update
      apt install -y openbsd-inetd telnetd || apt install -y inetutils-inetd telnetd

     service openbsd-inetd restart || service inetutils-inetd restart || service inetd restart
      ```
  - Buat user untuk login telnet
    ```sh
    useradd -m praktikan11 -s /bin/bash
    echo "praktikan11:praktikan123" | chpasswd
    ```
  - Buka text editor untuk mengedit `/etc/inetd.conf` dengan `nano`
<img width="1128" height="635" alt="Screenshot 2025-10-01 180221" src="https://github.com/user-attachments/assets/f8b09735-0684-4740-ac4e-c1547e33c40e" />
  - Hapus bagian "off" sehingga menjadi seperti berikut
<img width="1095" height="648" alt="Screenshot 2025-10-01 180230" src="https://github.com/user-attachments/assets/7c86cf9a-9b5d-4d4a-99b1-59598d0f244a" />
  - Dengan begitu sekarang service telnet pada Melkor sudah listening :
    <img width="1098" height="111" alt="Screenshot 2025-10-01 180325" src="https://github.com/user-attachments/assets/25cb9f61-2bd4-4cdd-a9d9-a7b7195dce31" />

2. Pada GNS 3 :
   - Klik kanan pada koneksi antara Switch 1 dan Node Melkor, lalu pencet start Capture.
  <img width="422" height="309" alt="Screenshot 2025-10-01 174421" src="https://github.com/user-attachments/assets/2c52dea1-379b-4195-a8ca-7dc5ad9bcff2" />  
   - Setelah itu akan mengalihkan ke aplikasi Wireshark. 

3. Pada Node Eru :
   - Coba konekti telnet
  ```sh
  telnet 192.224.1.2 23
  ```
   - Login dengan user yang telah dibuat pada node Melkor.
<img width="448" height="142" alt="Screenshot 2025-10-01 180712" src="https://github.com/user-attachments/assets/3c34e3e2-89a4-41d3-8d08-d9cf9e5fa9f9" />

4. Cek wireshark :
  - Pada wireshark, setelah Eru login akan muncul beberapa packet
<img width="1919" height="746" alt="Screenshot 2025-10-01 180810" src="https://github.com/user-attachments/assets/05a7f3b4-8ad5-4c07-af91-13e4170b03c9" />

  - Follow tcp stream salah satu packet dan akan ditemukan username dan password yang digunakan oleh Eru untuk login
    <img width="1105" height="875" alt="Screenshot 2025-10-01 180803" src="https://github.com/user-attachments/assets/77233dc1-5f4b-482a-be66-cbcf5da6e80f" />

## Soal 12
1. Pada Node Melkor :
   - nyalakan FTP di Melkor (port 21)
    ```sh
    apt update
    apt install -y vsftpd
    service vsftpd start
    ```
   - nyalakan HTTP server (port 80)
    ```sh
    apt install -y apache2
    service apache2 start
    ```
  - Setelah dijankan bisa dicek apakah port sudah listening
    <img width="1106" height="155" alt="Screenshot 2025-10-01 183900" src="https://github.com/user-attachments/assets/cf7d1d6b-9776-4222-a07b-0b5826c910bc" />

2.  Pada Node Eru :
   - install netcat dengan menjalankan `which nc || apt update && apt install -y netcat-openbsd`.
   - jalankan `nc -vz 192.224.1.2 21 80 666` lalu cek hasilnya
     <img width="723" height="117" alt="Screenshot 2025-10-01 183904" src="https://github.com/user-attachments/assets/3cddc4d9-5cbb-4987-b380-fc813631e4a5" />


## Soal 13

1. Pada Node Eru :
   - Install sshd
  ```sh
  apt update
  apt install -y openssh-server
  ```
   - Nyalakan service sshd
  ```sh
  # pastikan sshd jalan
  service ssh start
  ```
  <img width="446" height="43" alt="image" src="https://github.com/user-attachments/assets/1227aaa6-be5b-4535-bb31-63dc17b56b54" />

   - buat user vardauser dengan password vardapass123
    ```sh
    useradd -m -s /bin/bash vardauser
    echo "vardauser:vardapass123" | chpasswd
    ```

2. Pada GNS3 :
   - Klik kanan pada koneksi antara Switch 2 dan Node Varda, lalu pencet start Capture.
     <img width="441" height="358" alt="Screenshot 2025-10-01 184930" src="https://github.com/user-attachments/assets/414dfac4-efad-4d30-980e-45c29fbbf15c" />
   - Setelah itu akan mengalihkan ke aplikasi Wireshark. 
    
3. Pada Node Varda :
  - login ke eru sebagai `vardauser`
    ```sh
    ssh vardauser@192.224.1.1
    ```
    <img width="930" height="346" alt="image" src="https://github.com/user-attachments/assets/743c1d80-9d78-48fc-b57d-981a34028910" />


4. Hasil :
  - Semua packet akan tertangkap oleh wireshark :
    <img width="1919" height="960" alt="image" src="https://github.com/user-attachments/assets/ffd62122-1d85-412b-87c2-b515c469761c" />
  - Follow tcp stream
    <img width="1103" height="878" alt="image" src="https://github.com/user-attachments/assets/424d840f-47ef-4916-bc1e-d9f235a81771" />
  - Semua paket yang dikirim telah dienkripsi oleh sshd

## Soal 14
saat buka file capture pertama kali, kita akan melihat berapa banyak packet yang ada, yaitu sebanyak `500358` packet.
  <img width="1686" height="818" alt="Screenshot 2025-09-30 185630" src="https://github.com/user-attachments/assets/99d03efd-d879-438a-8a42-56da054ec2b4" />
  
dengan begitu dapat menjawab soal nomor 1 :
<img width="1035" height="631" alt="Screenshot 2025-09-30 185649" src="https://github.com/user-attachments/assets/64f108e3-ca2b-4585-a46b-7488edbf2efe" />

untuk mencari kredensial yang tepat, saya memfilter kata akhir nya yang dimana mengandung kata *"Login Successfull!"*
<img width="1311" height="385" alt="Screenshot 2025-09-30 192303" src="https://github.com/user-attachments/assets/26d2d77a-ebae-4e39-8ca1-f0eaff8c18c2" />

disini kita dapat bahwa kredensial yang digunakan adalah `n1enna:y4v4nn4_k3m3nt4r1` dan ditemukan pada stream `41824`.

disini juga ditemukan service yang digunakan, yaitu `Fuzz Faster U Fool v2.1.0-dev`
<img width="1088" height="568" alt="Screenshot 2025-09-30 193210" src="https://github.com/user-attachments/assets/adebd3cf-6f36-4c22-a130-5f70e5829a44" />

dengan menyelesaikan soal nya, didapatkan flag sebagai berikut :
<img width="826" height="458" alt="image" src="https://github.com/user-attachments/assets/35167f00-ea50-4fa1-8475-a01c2c5c6ba6" />

dengan begitu, kita mendapat jawaban untuk nomor 
## Soal 15
### 1. Membuka file capture
- File yang diberikan: `hiddenmsg.pcapng`.
- Setelah dibuka di Wireshark, terlihat bahwa capture ini bukan traffic jaringan biasa, melainkan **USB traffic**.
- Hal ini terlihat dari adanya protokol `USB` dan `URB_INTERRUPT in`.

### 2. Menentukan perangkat Melkor
- USB device mengirimkan **descriptor** saat pertama kali dikenali.  
- Dengan filter: `usb`
  <img width="1650" height="760" alt="Screenshot 2025-09-30 202442" src="https://github.com/user-attachments/assets/0b6b35c6-b532-446d-bcb6-4ff08f4281cd" />
- lalu periksa paket `GET DESCRIPTOR Response STRING`.  
- Di dalam paket tersebut terdapat string **"USB Keyboard"**.
- Soal meminta format jawaban berupa jenis perangkat, yang berarti jawaban nomor 1 adalah : **"Keyboard"**.

### 3. Mencari apa yang ditulis Melkor
- Input dari keyboard terekam sebagai paket `URB_INTERRUPT in` dengan panjang 8 byte.  
- Bisa ditampilkan dengan filter:  `usb.data_len == 8`.
  <img width="961" height="701" alt="Screenshot 2025-09-30 203133" src="https://github.com/user-attachments/assets/842d8236-c7b0-4fce-a50b-1a082c5c35c1" />
  
- Field penting: `usbhid.data` (8 byte hex).
- Byte ke-0 = modifier (Shift, Ctrl, dll).
- Byte ke-2 = Usage ID (kode tombol).
- Mapping Usage ID berdasarkan tabel HID Keyboard Usage:
- `04` = a, `05` = b, ..., `1d` = z
- `1e`–`27` = angka
- `2c` = spasi, `28` = Enter, dll.

### 4. Ekspor dan decode
- Data diekspor ke CSV dengan command:
```bash
tshark -r hiddenmsg.pcapng -Y "usbhid.data" \
       -T fields -e frame.number -e frame.time -e usbhid.data \
       -E header=y -E separator=, > usbhid.csv
```
<img width="655" height="99" alt="Screenshot 2025-09-30 212125" src="https://github.com/user-attachments/assets/fff21dba-8434-499d-96d5-eea5cbf334f3" />

- Setelah jadi csv dengan ini hex code yang dicuri Melkor, kita bisa gunakan bantuan ChatGPT untuk memecahkan hex code tersebut :
  <img width="833" height="353" alt="image" src="https://github.com/user-attachments/assets/c7075de9-3db8-4878-a5bc-c2fa3d1e1934" />

  Inilah jawaban dari soal pertanyaan ke 2 tersebut.
  
### 5. Ubah kode Base64 jadi Plain Text
- Setelah kita dapat hasil decode nya, kita minta bantuan ChatGPT lagi untuk jadikan plain text.
  <img width="905" height="458" alt="image" src="https://github.com/user-attachments/assets/481d0d2f-daad-44b9-a004-53ab46ffd7d4" />

  ini adalah jawaban dari pertanyaan ke 3 tersebut.
- Setelah menjawab ke 3 soal yang diberik, diakhir kita mendapatkan sebuah Flag :
  <img width="826" height="181" alt="Screenshot 2025-09-30 213043" src="https://github.com/user-attachments/assets/afd3e196-e079-4450-8821-ca0df339ff81" />

## Soal 16
### 1. Membuka file capture
- File yang diberikan: `Melkorplan1`.

### 2. Membuka WSL
- akses nc
nc 10.15.43.32 3403
<img width="533" height="172" alt="image" src="https://github.com/user-attachments/assets/3e7120ec-c9a6-43ae-981c-e65a59276b1c" />

### 3. Cari Info User dan Pw di Wireshark
- pake filter `frame contains "USER"`
<img width="939" height="68" alt="image" src="https://github.com/user-attachments/assets/4841f735-1f10-4708-9cad-3a37bf508695" />

### 4. Cari dan download file q.exe, w.exe, e.exe, r.exe, t.exe
- `ftp.request.command == "USER"` nanti ada satu paket yang berbeda length nya itu file q.exe yang dicari, begtupun dengan file file lainnya
  
### 5. cari sha256 dari semua paket 
<img width="663" height="302" alt="image" src="https://github.com/user-attachments/assets/a81b0334-1660-454e-9c00-56638059ec44" />

### 6. jawab semua pertanyaan yang diberikan 
<img width="916" height="691" alt="image" src="https://github.com/user-attachments/assets/aab9f582-ae78-4293-8957-6262840ceee8" />

## Soal 17
### 1. Membuka file capture
- File yang diberikan: `Melkorplan2`.

### 2. Membuka WSL
- akses nc 10.15.43.32 3404
<img width="449" height="182" alt="image" src="https://github.com/user-attachments/assets/e65b9376-bbb5-4b4e-a1c0-8a7cfcc794c7" />

### 3. Cari Info file di Wireshark
- export http object
<img width="690" height="170" alt="image" src="https://github.com/user-attachments/assets/86788b5c-ca53-4cae-bfec-ea9961263afc" />

### 4. Jawab pertanyaan 
<img width="844" height="553" alt="image" src="https://github.com/user-attachments/assets/810507ba-12d9-43eb-a049-769ccb20d669" />


## Soal 18
### 1. Membuka file capture
- File yang diberikan: `Melkorplan3`.

### 2. Membuka WSL
- akses nc 10.15.43.32 3405
<img width="507" height="207" alt="image" src="https://github.com/user-attachments/assets/65d9732a-4c38-44ca-972a-ba13a3b6e173" />

### 3. Cari Info file di Wireshark
- export smb object / frame contains ".exe"
<img width="842" height="275" alt="image" src="https://github.com/user-attachments/assets/d6a2e296-7e9c-439b-af5b-bbaf6a52bfcf" />

### 4. Jawab pertanyaan 
<img width="908" height="533" alt="image" src="https://github.com/user-attachments/assets/e9298b75-cff4-44c6-be8b-f27ae4ce488c" />

## Soal 19
### 1. Membuka file capture
- File yang diberikan: `Melkorplan4`.

### 2. Membuka WSL
- akses nc 10.15.43.32 3406
<img width="410" height="181" alt="image" src="https://github.com/user-attachments/assets/3dae54f2-5073-4c03-98cb-beae078bc17e" />

### 3. Cari Info file di Wireshark
- smtp -> follow stream tcp
<img width="915" height="828" alt="image" src="https://github.com/user-attachments/assets/788c479c-4b2e-47f9-8d2d-7631e64de060" />

### 4. Jawab pertanyaan 
<img width="864" height="468" alt="image" src="https://github.com/user-attachments/assets/f1a94745-188b-40d9-90bc-3d4b4253005f" />

## Soal 20
### 1. Membuka file capture
- File yang diberikan: `Melkorplan5`.

### 2. Membuka WSL
- akses nc 10.15.43.32 3407
<img width="412" height="199" alt="image" src="https://github.com/user-attachments/assets/af41eb10-2c39-48a0-b3bd-6bacb4be75ab" />

### 3. Cari Info file di Wireshark
- dari wireshark bisa diidentifikasi protocol yang dipake adalah TLS
<img width="911" height="89" alt="image" src="https://github.com/user-attachments/assets/f311e0e6-b905-4c52-8fc9-78b06c574c2e" />
- untuk mencari file malicious kita perlu men-setting wireshark, pergi ke preference, ke protocol, lalu cari TLS dan masukin keylogs yangs uda di berikan dr gdrive soal, lalu kita scrol di nomor 165 terdapat file yang mencurigakan
<img width="755" height="331" alt="image" src="https://github.com/user-attachments/assets/8c86df17-aa21-4f68-a260-97c4302e114c" />

### 4. Jawab pertanyaan 
<img width="858" height="325" alt="image" src="https://github.com/user-attachments/assets/543e3fda-5d02-4bd4-8658-457d86f27560" />
