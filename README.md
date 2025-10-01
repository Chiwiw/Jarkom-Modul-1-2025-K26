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

## Soal 7

## Soal 8

## Soal 9

## Soal 10

## Soal 11

## Soal 12

## Soal 13

## Soal 14

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

## Soal 17

## Soal 18

## Soal 19

## Soal 20
