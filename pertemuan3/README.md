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

### Fish consumptions
- \* ID
- Fish consumption name
- Stock
- Fish consumption type
  - feed
  - medicine
- Count units
  - kg
  - litre
- Prices per unit

### Provision of Fish Consumptions
- \* ID
- \* ID Pond
- \* ID Fish consumption
- Last used date
- Amount used
- Cost used

### Routine
- \* ID
- Routine name (optional)
- Is active

### Routine action
- \* ID
- \* ID Routine
- \* ID Fish consumption
- Action Name `// Example: feeding`
- Consumption used

### Routine pool
- \* ID
- \* ID Routine
- \* ID Pond

### Routine time
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

### Transaction
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