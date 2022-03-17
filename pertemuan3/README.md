# Ide Solusi: Aplikasi Pengelola Budidaya dan Jual Beli Ikan
![L](pertemuan3.drawio.svg)
## Deskripsi
Aplikasi ini dirancang untuk mempermudah dalam melakukan pengelolaan dalam pembudidayaan dan penjualan ikan. Beberapa fitur-fitur yang tersedia diantaranya:
- Membuat lapak budidaya bisnis ikan
- Mengelola data kolam 
- Pemberian makan otomatis dengan fitur "Rutin"
- Membeli dan menjual hasil panen

## Entitas dan Atribut
### Users
- \* ID
- Full name
- \* Phone number
- Date of birth
- Created at

### Cultivations
- \* ID
- \* ID User
- Name of cultivation
- Cultivation type
  - Catfish
  - Gurame
  - Nila
- Street address
- Country/Region
- Province
- Town/City
- Postcode
- Latitude
- Longitude
- Description
- Is active

### Cultivation Phones
- \* ID
- Phone Number
- Is primary

### Ponds
- \* ID
- \* ID Cultivation
- Pond name (optional)
- Length
- Width
- Number of fish (optional)
- Count units
  - per head
  - per kg
- Water temperature (optional)
- Water pH (optional)
- Is active
- Last updated

### Fish Needs
- \* ID
- Fish needs name
- Stock
- Fish needs type
  - feed
  - medicine
- Count units
  - kg
  - litre
- Prices per unit

### Provision of Fish Needs
- \* ID
- \* ID Pond
- \* ID Fish needs
- Last used date
- Amount used
- Cost used

### Routines
- \* ID
- Routine name (optional)
- Is active

### Routine actions
- \* ID
- \* ID Routine
- \* ID Fish needs
- Action Name `// Example: feeding`
- Needs used
- Repeat
  - once
  - everyday
  - weekdays
  - custom
- Custom repeat
    - monday
    - tuesday
    - wednesday
    - thursday
    - friday
    - saturday
    - sunday

### Routine Ponds
- \* ID
- \* ID Routine
- \* ID Pond

### Routine Times
- \* ID
- \* ID Routine
- Start time

### Products
- \* ID
- \* ID Cultivation
- Product name
- Picture
- Price
- Stock
- Count units
  - per head
  - per kg
- Description
- Is active

### Transactions
- \* ID
- \* ID User
- Status
  - Waiting for confirmation
  - Preparing
  - Shipping
  - Completed
  - Rejected
  - Canceled
- Date
- Total
- Description

### Transaction Details
- \* ID
- \* ID Transaction
- \* ID Product
- Product name
- Price
- Amount
- Count units
  - per head
  - per kg
- Description

## Relationships
| Entity 1                | Relationship | Entity 2                |
| ----------------------- | ------------ | ----------------------- |
| Users                   | 1 1 - 0 N    | Cultivations            |
| Cultivations            | 1 1 - 1 N    | Cultivation phones      |
| Cultivations            | 1 1 - 0 N    | Products                |
| Products                | 1 1 - 0 N    | Transaction Details     |
| Transaction Details     | N 0 - 1 1    | Transactions            |
| Transactions            | N 0 - 1 1    | Users                   |
| Cultivations            | 1 1 - 0 N    | Ponds                   |
| Ponds                   | 1 1 - 0 N    | Provision of Fish Needs |
| Provision of Fish Needs | N 0 - 1 1    | Fish Needs              |
| Fish Needs              | 1 1 - 0 N    | Routine actions         |
| Routine actions         | N 1 - 1 1    | Routine                 |
| Routine                 | 1 1 - 1 N    | Routine Times           |
| Routine                 | 1 1 - 1 N    | Routine Ponds           |
| Routine Ponds           | N 0 - 1 1    | Ponds                   |