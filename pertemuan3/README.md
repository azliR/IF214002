# Ide Solusi: Aplikasi Pengelola Budidaya dan Jual Beli Ikan
![ER Diagram](pertemuan3.drawio.svg)
## Deskripsi
Aplikasi ini dirancang untuk mempermudah dalam melakukan pengelolaan dalam pembudidayaan dan penjualan ikan. Beberapa fitur-fitur yang tersedia diantaranya:
- Membuat lapak budidaya bisnis ikan
- Mengelola data kolam beserta sorting
- Catat pemberian makan otomatis dengan fitur "Rutin"
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
- ID User
- Name
- Type
- Street address
- Country (/region)
- State (/province)
- City (/district)
- Postcode
- Latitude
- Longitude
- Description (optional)
- Is active

### Cultivation Types
- \* ID
- Name

### Cultivation Type L10ns
- \* ID Cultivation Type
- \* Language Code
- Translation

### Cultivation Phones
- \* ID
- ID Cultivation
- Phone Number
- Is primary

### Ponds
- \* ID
- ID Cultivation
- Name (optional)
- Length
- Width
- Is active

### Sorting
- \* ID
- ID Ponds initial (auto-update to nonactive)
- ID Ponds destination (auto-update to active)
- Start time
- Fish total (optional)
- Count units
  - per head
  - per kg
- Water temperature (optional)
- Water pH (optional)

### Fish Needs
- \* ID
- Name
- Type
  - feed
  - medicine
- Stock
- Count units
  - kg
  - litre
- Price per unit

### Provision of Fish Needs
- \* ID
- ID Pond
- ID Fish needs
- Timestamp
- Amount used
- Count units
  - kg
  - litre
- Price per unit
- Cost used

### Routines
- \* ID
- Name (optional)
- Is active

### Routine actions
- \* ID
- ID Routine
- ID Fish needs
- Name `// Example: feeding`
- Needs used
- Repeat
  - once
  - everyday
  - weekdays
  - custom
- Custom repeat (optional)
    - sunday
    - monday
    - tuesday
    - wednesday
    - thursday
    - friday
    - saturday

### Routine Ponds
- \* ID
- ID Routine
- ID Pond

### Routine Times
- \* ID
- ID Routine
- Start time

### Products
- \* ID
- ID Cultivation
- Product name
- Picture URL
- Price
- Stock
- Count units
  - per head
  - per kg
- Description (optional)
- Is active

### Transactions
- \* ID
- ID User
- Status
  - Waiting for confirmation
  - Preparing
  - Shipping
  - Completed
  - Rejected
  - Canceled
- Timestamp
- Total
- Description (optional)

### Transaction Details
- \* ID
- ID Transaction
- ID Product
- Product name
- Price
- Amount
- Count units
  - per head
  - per kg
- Description (optional)

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