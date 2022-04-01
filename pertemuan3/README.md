# Ide Solusi: Aplikasi Restoran
## Deskripsi
Aplikasi ini berfokus untuk membuka peluang usaha di sebuah restoran atau drive-through. Beberapa fitur yang menjadi poin penting aplikasi in diantaranya:
- Memudahkan dalam pemesanan pada saat ingin melakukan booking meja
- Melihat keadaan restoran apakah sedang penuh pelanggan atau kosong
- Memesan dengan cepat langsung dari aplikasi dan ambil saat itu juga atau sesuai schedule yang ditentukan tanpa lama menunggu

![L](pertemuan2.drawio.svg)

## Entitas dan Atribut
### Pengguna
- ID
- Full name
- Phone
- Language code
- Created at
- Last updated at

### Stores
- ID
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
- ID
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
- ID
- Name

### Item Category L10ns
- Category ID
- Langauge Code
- Name

### Item Sub Categories
- ID
- Name

### Item Sub Category L10ns
- Sub Category ID
- Langauge Code
- Name

### Item Addon Categories
- ID
- Item ID
- Name
- Description
- Is multiple choice

### Item Addons
- ID
- Addon Category ID
- Name
- Price

### Orders
- ID
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
- ID
- Order ID
- Item ID
- Item name
- Quantity
- Price
- Netto
- Picture
- Item detail

### Order Detail Addons
- ID
- Order detail ID
- Addon ID
- Addon name
- Quantity
- Price

### Tables
- ID
- Store ID
- Name
- Max person
- Total person
- Book price

### Coupons
- ID
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
- Coupon ID
- User ID

### Coupon Stores
- Coupon ID
- Store ID

## Relationships
| Entity 1                | Relationship | Entity 2                |
| ----------------------- | ------------ | ----------------------- |
| Users                   | 1 1 - 0 N    | Cultivations            |
| Cultivations            | 1 1 - 1 N    | Cultivation phones      |
| Cultivations            | N 0 - 1 1    | Cultivation types       |
| Cultivations types      | 1 1 - 0 N    | Cultivation types L10ns |
| Cultivations            | 1 1 - 0 N    | Products                |
| Products                | 1 1 - 0 N    | Transaction Details     |
| Transaction Details     | N 1 - 1 1    | Transactions            |
| Transactions            | N 0 - 1 1    | Users                   |
| Cultivations            | 1 1 - 0 N    | Ponds                   |
| Ponds                   | N 1 - 0 N    | Sorting                 |
| Ponds                   | 1 1 - 0 N    | Provision of Fish Needs |
| Provision of Fish Needs | N 0 - 1 1    | Fish Needs              |
| Fish Needs              | 1 1 - 0 N    | Routine actions         |
| Routine actions         | N 1 - 1 1    | Routine                 |
| Routine                 | 1 1 - 1 N    | Routine Times           |
| Routine                 | 1 1 - 1 N    | Routine Ponds           |
| Routine Ponds           | N 0 - 1 1    | Ponds                   |