# UTS

## Soal

1. Basis data relasional dapat langsung dibangun menggunakan perintah SQL di sistem basis data seperti MySQL, dsb tanpa
   ada perancangan terlebih dahulu. Jelaskan apa keuntungan melakukan perancangan basis data terlebih dahulu (
   menggunakan ERD ataupun Class Diagram) !

2. Jelaskan bagaimana cara mentransformasikan proses bisnis sebuah organisasi menjadi struktur data di basis data !

3. Rancang solusi digital dari satu permasalahan yang ada di sekitar Anda.
    1. Deskripsikan solusi digital tersebut dalam satu paragraf
    2. Buat list fitur-fitur yang ada pada solusi digital tersebut
    3. Buat ERD notasi Chen dari struktur data yang mewakili fitur2 di solusi digital tersebut
    4. Buat ERD notasi Crow Foot dari struktur data logical yang mewakili fitur2 di solusi digital tersebut, lengkap
       dengan keys, tipe data, dan normalisasi hingga bentuk ke 3

## Jawaban

### Keuntungan rancangan database

Rancangan database (ERD atau Class Diagram) sangat penting dalam membangun basis data, diantaranya sebagai berikut:

1. Untuk mengumpulkan informasi kebutuhan-kebutuhan basis data yang dimaksud oleh user sebelum pembuatan database yang
   sebenenarnya. Sehingga jika terdapat kesalahan atau miss komunikasi akan lebih mudah diperbaiki.
2. Perancangan database seperti ERD atau Class Diagram bertujuan untuk memudahkan user yang bukan seorang programmer
   untuk membaca struktur database tanpa mengerti koding terlebih dahulu. Hal ini sangat menguntungkan saat
   mempresentasikan kepada industri atau klien.
3. Sebagai dokumentasi dari struktur database yang telah dibuat.

### Cara mentransformasikan proses bisnis sebuah organisasi menjadi struktur data

Untuk mentransformasikan proses bisnis sebuah organisasi menjadi struktur data di basis data dapat dimulai dengan
membangun perancangan basis data. Dari pemikiran pribadi saya, terdapat beberapa poin penting, diantaranya:

- Dalam membangun perancangan basis data ini dapat dilakukan dengan diagram ER.
- Jika terlalu sulit, dapat dimulai dari flowchart yang akan menjelaskan alur dari bisnis secara umum.
- Kemudian setelah semuanya tergambar, dapat dilakukan perancangan diagram ER dengan menentukan entitas, atribut, dan
  relasi yang ada.
- Selalu cek entitas, atribut, dan relasi yang ada pada diagram ER tersebut agar sesuai dengan desain bisnis.
- Lakukan normalisasi atau bahkan denormalisasi sehingga rancangan basis data tersebut dibuat seefisien mungkin.
- Lengkapi atribut dengan tipe data yang sesuai dan efisien.
- Setelah semuanya dirasa cukup, pembuatan database dapat dilakukan.

### Solusi digital: Aplikasi Restoran

#### Deskripsi

Terkadang kita ingin pergi ke suatu restoran atau sedang kumpul bersama teman-teman dan ingin memesan makanan bersama
disana, apa yang
pertama di benak kita? Apakah tempatnya ramai? Apakah masih tersedia meja untuk dipesan? Aplikasi restoran ini menjawab
pertanyaan-pertanyaan tersebut. Dengan aplikasi restoran pelanggan dapat melihat status restoran yang ingin dipesan
apakah ramai pembeli, apakah meja masih tersedia, apakah makanan tersedia, dan sebagainya hanya melalui aplikasi.
Pelanggan hanya perlu memesan makanan dari aplikasi dan datang ke restoran untuk mengambil pesanan hanya dengan
menunjukkan kode QR unik, tanpa perlu repot
mengantri.

#### Fitur-fitur

- Pencarian restoran terdekat dengan lokasi pelanggan.
- Melihat antrian dan status meja yang tersedia tanpa harus mengunjungi restoran terlebih dahulu.
- Mempermudah melakukan pemesanan makanan atau minuman secara langsung dari aplikasi, beserta varian yang tersedia (jika
  ada).
- Memesan secara terjadwal, pesan sekarang ambil beberapa jam kemudian.
- Mempermudah melihat daftar order, baik itu pesanan yang masih menunggu konfirmasi, dan sedang disiapkan; sampai
  pesanan yang sudah selesai, pesanan ditolak, dan pesanan dibatalkan.

#### ERD Notasi Chen

![ERD Notasi Chen](uts_erd_chen.drawio.svg)

#### ERD Notasi Crow Foot

![ERD Notasi Crow Foot](uts_erd_crowfoot.drawio.svg)
