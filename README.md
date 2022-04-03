# IF214002

Repository pembelajaran Basis Data.

# Aplikasi Restoran

## Deskripsi

Aplikasi ini berfokus untuk membuka peluang usaha di sebuah restoran atau drive-through. Beberapa fitur yang menjadi
poin penting aplikasi in diantaranya:

- Memudahkan dalam pemesanan pada saat ingin melakukan booking meja
- Melihat keadaan restoran apakah sedang penuh pelanggan atau kosong
- Memesan dengan cepat langsung dari aplikasi dan ambil saat itu juga atau sesuai schedule yang ditentukan tanpa lama
  menunggu

## Daftar Isi

- [Deskripsi](#deskripsi)
- [Changelog](#changelog)
  - [Pertemuan 1](#pertemuan-1)
  - [Pertemuan 2](#pertemuan-2)
  - [Pertemuan 3](#pertemuan-3)
  - [Pertemuan 4](#pertemuan-4)
  - [Pertemuan 5](#pertemuan-5)
- [Diagram](#diagram)
- [Entitas dan Atribut](#entitas-dan-atribut)
- [Relasi Entitas](#relasi-entitas)
- [Profil](#profil)

## Changelog

_⚠️ Note :  
File gambar berekstensi .svg dengan tujuan agar file menjadi ringan dan tidak pecah. Untuk bisa memperbesar, klik kanan
pada gambar dan klik buka gambar di tab baru (open image in new tab)._

### [Pertemuan 1](pertemuan1)

- ⚡ Instalasi Diagrams.net
- ⚡ Instalasi Docker
- ⚡ Instalasi DBeaver
- `CREATE`: 🆕 Membuat contoh diagram ERD

### [Pertemuan 2](pertemuan2)

- `CREATE`: 🆕 Membuat rancangan aplikasi berupa deskripsi dan atribut yang dibutuhkan
- `CREATE`: 🆕 Membuat diagram untuk rancangan aplikasi

<details>
  <summary>Hasil praktikum (klik untuk membuka)</summary>

![Diagram v0.2](pertemuan2/pertemuan2.drawio.svg)
</details>

### [Pertemuan 3](pertemuan3)

- `CREATE`: 🆕 Membuat rancangan aplikasi berupa diagram ER konseptual
- `UPDATE`: 🚀 Menambahkan cardinality dan optionality dari diagram sebelumnya

<details>
  <summary>Hasil praktikum (klik untuk membuka)</summary>

![Diagram ER Konseptual v0.3](pertemuan3/pertemuan3.drawio.svg)
</details>

### [Pertemuan 4](pertemuan4)

- `UPDATE`: 🚀 Menambahkan primary key dan composite key pada rancangan aplikasi
- `UPDATE`: 🚀 Menambahkan relasi antar entitas pada rancangan aplikasi
- `UPDATE`: 🚀 Mengubah diagram ER konseptual menjadi logical

<details>
  <summary>Hasil praktikum (klik untuk membuka)</summary>

![Diagram ER Logical v0.4](pertemuan4/pertemuan4.drawio.svg)
</details>

### [Pertemuan 5](pertemuan5)

- `UPDATE`: 🛠️ Memperbaiki beberapa optinality yang salah di beberapa entity
- `UPDATE`: ✨ Mengubah tema diagram agar terlihat lebih rapi
- `UPDATE`: ✨ Merapikan README.md
  - 🚀 Menambahkan changelog untuk setiap pertemuan
  - 🚀 Menambahkan gambar pertemuan sebelumnya untuk memudahkan perbandingan

<details>
  <summary>Hasil praktikum (klik untuk membuka)</summary>

![Diagram ER Logical v0.5](pertemuan5/pertemuan5.drawio.svg)
</details>

### [Pertemuan 6](pertemuan6)

<details>
  <summary>Hasil praktikum (klik untuk membuka)</summary>

[//]: # (Hasil praktikum: ![Diagram ER Logical v0.6]&#40;pertemuan6/pertemuan6.drawio.svg&#41;)
</details>

## Diagram

![Diagram ER Logical v0.5](/pertemuan5/pertemuan5.drawio.svg)

## Entitas dan Atribut

_Note:_  
_\* primary key_  
_\** composite key_

### Pengguna

- \* ID
- Full name
- Phone
- Language code
- Created at
- Last updated at

### Stores

- \* ID
- User ID
- Name
- Description
- Image
- Banner
- Phone
- Pickup type
- Street address
- Country
- State
- City
- Area
- Postcode
- Latitude
- Longitude
- Rating
- Is active

### Items

- \* ID
- Store ID
- Category ID
- Sub category ID
- Name
- Picture
- Price
- Special offer
- Description
- Is active

### Item Categories

- \* ID
- Name

### Item Category L10ns

- \** Category ID
- \** Langauge Code
- Name

### Item Sub Categories

- \* ID
- Name

### Item Sub Category L10ns

- \** Sub Category ID
- \** Langauge Code
- Name

### Item Addon Categories

- \* ID
- \* Item ID
- Name
- Description
- Is multiple choice

### Item Addons

- \* ID
- Addon Category ID
- Name
- Price

### Orders

- \* ID
- User ID
- Store ID
- Table ID
- Coupon ID
- Buyer
- Store image
- Store banner
- Created at
- Coupon code
- Coupon name
- Discount
- Discount nominal
- Netto
- Brutto
- Status
  - Pending
  - Preparing
  - Ready
  - Complete
  - Cancelled
- Order type
  - Scheduled
  - Now
- Scheduled at
- Pickup type
  - Dine-in
  - Pickup
- Rating
- Comment

### Order Details

- \* ID
- Order ID
- Item ID
- Item name
- Quantity
- Price
- Netto
- Picture
- Item detail

### Order Detail Addons

- \* ID
- Order detail ID
- Addon ID
- Addon name
- Quantity
- Price

### Tables

- \* ID
- Store ID
- Name
- Max person
- Total person
- Book price

### Coupons

- \* ID
- Inserted by
- Coupon code
- Name
- Description
- Expiry date
- Discount type
  - Fixed
  - Percentage
- Discount
- Min total
- Max discount
- Max number use total
- Max number use user
- Created at
- All store
- Is valid

### Coupon Users

- \** Coupon ID
- \** User ID

### Coupon Stores

- \** Coupon ID
- \** Store ID

## Relasi Entitas

|       Entitas 1       |  Relasi   |        Entitas 2        |
|:---------------------:|:---------:|:-----------------------:|
|         Users         | 1 1 - 0 1 |         Stores          |
|         Users         | 1 1 - 0 N |      Coupon Users       |
|         Users         | 1 1 - 0 N |         Coupons         |
|         Users         | 1 1 - 0 N |         Orders          |
|        Stores         | 1 1 - 0 N |         Orders          |
|        Stores         | 1 1 - 0 N |         Tables          |
|        Stores         | 1 1 - 0 N |          Items          |
|         Items         | 1 1 - 0 N |      Order Details      |
|         Items         | N 0 - 1 1 |     Item Categories     |
|         Items         | N 0 - 0 1 |   Item Sub Categories   |
|         Items         | N 0 - 1 1 |  Item Addon Categories  |
|    Item Categories    | 1 1 - 0 N |   Item Category L10ns   |
|  Item Sub Categories  | 1 1 - 0 N | Item Sub Category L10ns |
| Item Addon Categories | 1 1 - 0 N |       Item Addons       |
|      Item Addons      | 1 1 - 0 N |   Order Detail Addons   |
|     Order Details     | 1 1 - 0 N |  Order Details Addons   |
|        Tables         | 1 1 - 0 N |         Orders          |
|        Orders         | 1 1 - 0 N |      Order Details      |
|        Orders         | N 0 - 0 1 |         Coupons         |
|        Coupons        | 1 1 - 0 N |      Coupon Stores      |
|        Coupons        | 1 1 - 0 N |      Coupon Users       |

## Profil

Nama: Rizal Hadiyansah  
NIM: 1207050109  
Kelas: IF E  
Universitas: UIN Sunan Gunung Djati