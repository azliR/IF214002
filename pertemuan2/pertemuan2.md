# Ide Solusi: Sistem Resepsionis
## Deskripsi
Aplikasi ini bertujuan untuk memudahkan dalam mencatat dan mengorganisir pemesanan meja. Aplikasi ini memiliki fitur-fitur:
- Mencatat bookingan untuk setiap meja
- Filter makanan saat memesan
- Adanya riwayat pemesanan
- Terdapat status pesanan untuk melihat jika pesanan sudah siap
## Entitas dan Atribut
### Pengguna
- ID
- ID Hak Akses
- Email
- Kata sandi
- Nama lengkap
- Alamat
- No telepon
### Hak Akses
- ID
- Nama Akses
### Barang
- ID
- ID Jenis
- Gambar
- Nama Barang
- Harga
- Stok Barang
- Deskripsi
### Jenis Barang
- ID
- Nama Jenis
### Status Pesanan
- ID
- Nama Status
### Varian Barang
- ID
- ID Barang
- Nama Varian
- Gambar
### Tipe Meja
- ID
- Nama Tipe
### Meja
- ID
- ID Tipe Meja
- ID Penjualan
- Nomor Meja
- Atas Nama
- Maks Orang
- Jumlah Orang
- Waktu Pesanan
### Penjualan
- ID
- ID Pengguna
- ID Meja
- ID Status
- Atas Nama
- Jumlah orang
- Tanggal penjualan
- Total
- Keterangan
### Detail Penjualan
- ID
- ID Penjualan
- ID Barang
- Nama Barang
- Jumlah Barang
