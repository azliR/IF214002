# Ide Solusi: Aplikasi Pengelola Budidaya dan Jual Beli Ikan
![L](pertemuan2.drawio.svg)
## Deskripsi
Aplikasi ini dirancang untuk mempermudah dalam melakukan pengelolaan dalam pembudidayaan dan penjualan ikan. Beberapa fitur-fitur yang tersedia diantaranya:
- Membuat lapak budidaya bisnis ikan
- Mengelola data kolam 
- Pemberian makan otomatis dengan fitur "Rutin"
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
- ID Pengguna
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
- Nama Kolam (optional)
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
- Jumlah saat ini
- Tipe Konsumsi Ikan
  - pakan
  - obat
- Satuan Hitungan
  - kg
  - liter
- Harga per satuan

### Pemberian Konsumsi Ikan
- ID
- ID Kolam
- ID Konsumsi Ikan
- Tanggal Pemberian
- Banyaknya digunakan
- Biaya digunakan

### Rutin
- ID
- Nama Rutin (Optional)
- Apakah Aktif

### Aksi Rutin
- ID
- ID Rutin
- ID Konsumsi Ikan
- Nama Aksi `// contoh: pemberian pakan, pemberian obat`
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
- Stok
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