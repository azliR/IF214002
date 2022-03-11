# Ide Solusi: Aplikasi Pengelola Budidaya dan Jual Beli Ikan
## Deskripsi
Aplikasi ini dirancang untuk mempermudah dalam melakukan pengelolaan dalam pembudidayaan dan penjualan ikan. Beberapa fitur-fitur yang tersedia diantaranya:
- Membuat lapak budidaya bisnis ikan
- Mengelola data kolam beserta pemberian pakan dengan fitur "Rutin"
- Membeli dan menjual hasil panen
  

## Entitas dan Atribut
### Pengguna
- ID
- Nama Lengkap
- Nomor Telepon
- Tanggal Lahir
- Dibuat Pada

### Budidaya
- ID
- Nama Budidaya
- Jenis Budidaya
  - Lele
  - Gurame
  - Nila
- Alamat Budidaya
- Kota / Kabupaten
- Kecamatan
- Desa / Kelurahan
- Latitude
- Longitude

### Kolam
- ID
- ID Budidaya
- Panjang Kolam
- Lebar Kolam
- Jumlah Ikan (optional)
- Satuan Hitungan
  - per ekor
  - per kg
- Suhu Air (optional)
- PH Air (optional)
- Apakah Aktif
- Terakhir Diperbarui

### Konsumsi Ikan
- ID
- Nama Konsumsi Ikan
- Jumlah Konsumsi Ikan Saat Ini
- Tipe Konsumsi Ikan 
  - pakan
  - obat
- Satuan Hitungan
  - kg
  - liter
- Harga (per kg, per liter)

### Pemberian Konsumsi Ikan
- ID
- ID Kolam
- ID Konsumsi Ikan
- Tanggal Pemberian Konsumsi Ikan
- Konsumsi Ikan yang Digunakan
- Biaya digunakan

### Rutin
- ID
- Nama Rutin (Optional)
- Apakah Aktif

### Aksi Rutin
- ID
- ID Rutin
- ID Konsumsi Ikan
- Nama Aksi `// contoh: pemberian pakan`
- Konsumsi yang Digunakan

### Kolam Rutin
- ID
- ID Rutin
- ID Kolam

### Waktu Rutin
- ID
- ID Rutin
- Waktu Mulai

### Katalog
- ID
- ID Budidaya
- Nama Barang
- Gambar
- Harga
- Stok Barang
- Satuan Hitungan 
  - per ekor
  - per kg
- Apakah Aktif
- Deskripsi

### Transaksi
- ID
- ID Pengguna
- Status
  - Menunggu konfirmasi
  - Sedang disiapkan
  - Sedang dikirim
  - Transaksi selesai
  - Transaksi ditolak
  - Transaksi dibatalkan
- Tanggal Transaksi
- Total
- Keterangan

### Detail Transaksi
- ID
- ID Transaksi
- ID Katalog
- Nama Barang
- Harga
- Jumlah Barang
- Satuan Hitungan 
  - per ekor
  - per kg
- Deskripsi