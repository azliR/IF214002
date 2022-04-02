# Ide Solusi: Aplikasi Restoran

## Changelog

Lihat di [halaman utama](../README.md)

## Deskripsi

Aplikasi ini berfokus untuk membuka peluang usaha di sebuah restoran atau drive-through. Beberapa fitur yang menjadi
poin penting aplikasi in diantaranya:

- Memudahkan dalam pemesanan pada saat ingin melakukan booking meja
- Melihat keadaan restoran apakah sedang penuh pelanggan atau kosong
- Memesan dengan cepat langsung dari aplikasi dan ambil saat itu juga atau sesuai schedule yang ditentukan tanpa lama
  menunggu

## Diagram

Diagram pertemuan ini:
![Diagram ER Logical v0.5](pertemuan5.drawio.svg)

<details>
<summary>Lihat diagram pertemuan sebelumnya</summary>

![Diagram ER Logical v0.4](../pertemuan4/pertemuan4.drawio.svg)
</details>

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