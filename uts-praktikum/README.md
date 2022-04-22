# UTS Praktikum
## Soal
1. Jelaskan contoh-contoh perintah SQL beserta kegunannya !

2. Rancang solusi digital dari satu permasalahan yang ada di sekitar Anda.
   - Berdasarkan ERD yang telah dibuat, buatlah implementasi basis data dari ERD tersebut dalam bentuk tabel basis data lengkap dengan Primary Key, Foreign Key dengan menggunakan perintah CREATE TABLE bahasa SQL. Anda dapat menggunakan vendor basis data yang Anda sukai (MySQL / PostgreSQL / SQL Server / dsb.). Jika belum sempat install basis data di laptop, bisa menggunakan sqliteonline.com untuk mengecek keberhasilan pembuatan tabelnya.

## Jawaban

### Contoh Perintah SQL dan Kegunaannya
Perintah SQL dapat dikategorikan menjadi empat kategori, yaitu DDL (Data Definition Language), DML (Data Manipulation Language), DCL (Data Control Language), dan DCL (Data Control Language). Namun banyak sumber yang menambahkan satu kategori lain, yaitu TCL (Transaction Control Language). Kategori-kategori tersebut diantaranya sebagai berikut:

#### 1. DDL (Data Definition Language)
DDL atau Data Definition Language sebenarnya terdiri dari perintah-perintah SQL yang dapat digunakan untuk mendefinisikan skema database.
- `CREATE` : Perintah ini digunakan untuk membuat database atau objeknya (seperti table, index, function, views, store procedure, dan trigger).
- `DROP` : Perintah ini digunakan untuk untuk menghapus databse, tabel, field ataupun index.
- `TRUNCATE` : Ini digunakan untuk menghapus semua record dari sebuah tabel, termasuk semua ruang yang dialokasikan untuk record tersebut dihapus.
- `COMMENT` : Digunakan untuk menambahkan komentar ke kamus data.
- `RENAME` : Digunakan untuk mengganti nama objek yang ada di database.

#### 2. DQL (Data Query Language)
Statement DQL digunakan untuk menjalankan kueri (menampilkan data) dari data yang tersimpan dalam database. 
- `SELECT` : Digunakan untuk mengambil data dari database.

Walau sebenarnya perintah select merupakan bagian dari DML akan tetapi beberapa sumber membuat perintah select menjadi memiliki kategori tersendiri karena fungsi utamanya untuk mengambil / menampilkan data.

#### 3. DML (Data Manipulation Language)
Perintah SQL yang berhubungan dengan manipulasi data yang ada dalam database milik DML dan mencakup sebagian besar pernyataan SQL.
- `INSERT` : Digunakan untuk memasukkan data ke dalam tabel.
- `UPDATE` : Digunakan untuk mengupdate data yang ada di dalam tabel.
- `DELETE` : Digunakan untuk menghapus record dari tabel database.
- `LOCK`: Konkurensi kontrol tabel.
- `CALL`: Memanggil subprogram PL/SQL atau JAVA.
- `EXPLAIN PLAN`: Menjelaskan jalur akses ke data.

#### 4. DCL (Data Control Language)
DCL termasuk perintah seperti GRANT dan REVOKE yang terutama berhubungan dengan hak, izin, dan kontrol lain dari sistem database. 
- `GRANT`: Perintah ini memberi pengguna hak akses ke database.
- `REVOKE`: Perintah ini menarik hak akses pengguna yang diberikan dengan menggunakan perintah GRANT.

#### 5. TCL (Transaction Control Language)
Perintah TCL menangani transaksi dalam database. Transaksi disini adalah ketika anda menjalankan berbagai perintah DML dan TCL membantu kita untuk mengurangi resiko kesalahan transaksi.
- `COMMIT` : Melakukan transaksi.
- `ROLLBACK` : Mengembalikan transaksi jika terjadi kesalahan.
- `SAVEPOINT` : Mengatur savepoint dalam transaksi untuk melakukan rollback jika dibutuhkan.
- `SET TRANSACTION`: Menentukan karakteristik untuk transaksi.

### PostgreSQL Query Aplikasi Restoran
```postgresql
CREATE TABLE coupons (
   id UUID NOT NULL,
   inserted_by UUID NOT NULL,
   coupon_code VARCHAR(16) NOT NULL,
   name VARCHAR(64) NOT NULL,
   description VARCHAR(255),
   expiry_date TIMESTAMP WITHOUT TIME ZONE NOT NULL,
   discount_user_type TEXT NOT NULL,
   discount_type TEXT NOT NULL,
   discount DECIMAL(11, 2) NOT NULL,
   min_total DECIMAL(11, 2) NOT NULL,
   max_discount DECIMAL(11, 2) NOT NULL,
   max_number_use_total INTEGER,
   max_number_use_user INTEGER NOT NULL,
   created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW() NOT NULL,
   all_store BOOLEAN NOT NULL,
   all_user BOOLEAN NOT NULL,
   is_valid BOOLEAN NOT NULL,
   CONSTRAINT pk_coupons PRIMARY KEY (id)
);

CREATE TABLE items (
   id UUID NOT NULL,
   store_id UUID NOT NULL,
   category_id UUID NOT NULL,
   sub_category_id UUID,
   name VARCHAR(64) NOT NULL,
   picture TEXT,
   price DECIMAL(11, 2) NOT NULL,
   special_offer DECIMAL(11, 2) NOT NULL,
   description VARCHAR(255),
   is_active BOOLEAN NOT NULL,
   CONSTRAINT pk_items PRIMARY KEY (id)
);

CREATE TABLE item_addons (
   id UUID NOT NULL,
   addon_category_id UUID NOT NULL,
   name VARCHAR(64) NOT NULL,
   price DECIMAL(11, 2) NOT NULL,
   CONSTRAINT pk_item_addons PRIMARY KEY (id)
);

CREATE TABLE item_addon_categories (
   id UUID NOT NULL,
   item_id UUID NOT NULL ,
   name VARCHAR(64) NOT NULL,
   description VARCHAR(255),
   is_multiple_choice BOOLEAN NOT NULL,
   CONSTRAINT pk_item_addon_categories PRIMARY KEY (id)
);

CREATE TABLE item_categories (
   id UUID NOT NULL,
   name VARCHAR(64) NOT NULL,
   CONSTRAINT pk_item_categories PRIMARY KEY (id)
);

CREATE TABLE item_category_l10ns (
  name VARCHAR(64) NOT NULL,
   category_id UUID NOT NULL,
   language_code VARCHAR(2) NOT NULL,
   CONSTRAINT pk_item_category_l10ns PRIMARY KEY (category_id, language_code)
);

CREATE TABLE item_sub_categories (
   id UUID NOT NULL,
   name VARCHAR(64) NOT NULL,
   CONSTRAINT pk_item_sub_categories PRIMARY KEY (id)
);

CREATE TABLE item_sub_category_l10ns (
  name VARCHAR(64) NOT NULL,
   sub_category_id UUID NOT NULL,
   language_code VARCHAR(2) NOT NULL,
   CONSTRAINT pk_item_sub_category_l10ns PRIMARY KEY (sub_category_id, language_code)
);

CREATE TABLE orders (
   id UUID NOT NULL,
   user_id UUID NOT null,
   store_id UUID NOT NULL,
   table_id UUID,
   coupon_id UUID,
   buyer VARCHAR(64) NOT NULL,
   store_image TEXT,
   store_banner TEXT,
   created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW() NOT NULL,
   coupon_code VARCHAR(16),
   coupon_name VARCHAR(64),
   discount DECIMAL(11, 2),
   discount_nominal DECIMAL(11, 2) NOT NULL,
   netto DECIMAL(11, 2) NOT NULL,
   brutto DECIMAL(11, 2) NOT NULL,
   status TEXT NOT NULL,
   order_type TEXT NOT NULL,
   scheduled_at TIMESTAMP WITHOUT TIME ZONE,
   pickup_type TEXT NOT NULL,
   rating DECIMAL(2, 1),
   comment VARCHAR(255),
   CONSTRAINT pk_orders PRIMARY KEY (id)
);

CREATE TABLE order_details (
   id UUID NOT NULL,
   order_id UUID not NULL,
   item_id UUID not NULL,
   item_name VARCHAR(64) NOT NULL,
   quantity BOOLEAN NOT NULL,
   price DECIMAL(11, 2) NOT NULL,
   netto DECIMAL(11, 2) NOT NULL,
   picture TEXT,
   item_detail VARCHAR(255),
   CONSTRAINT pk_order_details PRIMARY KEY (id)
);

CREATE TABLE order_detail_addons (
  id UUID NOT NULL,
   order_detail_id UUID not NULL,
   addon_id UUID not NULL,
   addon_name VARCHAR(64) NOT NULL,
   quantity BOOLEAN NOT NULL,
   price DECIMAL(11, 2) NOT NULL,
   CONSTRAINT pk_order_detail_addons PRIMARY KEY (id)
);

CREATE TABLE postcodes (
  postcode VARCHAR(5) NOT NULL,
   city VARCHAR(128) NOT NULL,
   state VARCHAR(128) NOT NULL,
   country VARCHAR(56) NOT NULL,
   CONSTRAINT pk_postcodes PRIMARY KEY (postcode)
);

CREATE TABLE tables (
  id UUID NOT NULL,
   store_id UUID not null,
   name VARCHAR(64) NOT NULL,
   max_person BOOLEAN NOT NULL,
   total_person BOOLEAN NOT NULL,
   book_price DECIMAL(11, 2) NOT NULL,
   CONSTRAINT pk_tables PRIMARY KEY (id)
);

CREATE TABLE roles (
  name VARCHAR(16) NOT NULL,
   CONSTRAINT pk_roles PRIMARY KEY (name)
);

CREATE TABLE stores (
  id UUID NOT NULL,
   user_id UUID not null,
   name VARCHAR(64) NOT NULL,
   description VARCHAR(255),
   image TEXT,
   banner TEXT,
   phone VARCHAR(16) NOT NULL,
   pickup_type VARCHAR(255) NOT NULL,
   street_address VARCHAR(255) NOT NULL,
   postcode_id VARCHAR(5),
   latitude DOUBLE PRECISION NOT NULL,
   longitude DOUBLE PRECISION NOT NULL,
   rating DECIMAL(2, 1),
   is_active BOOLEAN NOT NULL,
   CONSTRAINT pk_stores PRIMARY KEY (id)
);

CREATE TABLE users (
   id UUID NOT NULL,
   full_name VARCHAR(64) NOT NULL,
   phone VARCHAR(16) NOT NULL,
   language_code VARCHAR(2) NOT NULL,
   role VARCHAR(16) NOT NULL,
   created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW() NOT NULL,
   CONSTRAINT pk_users PRIMARY KEY (id)
);

CREATE UNIQUE INDEX phone ON users(phone);

ALTER TABLE users ADD CONSTRAINT FK_USERS_ON_ROLE FOREIGN KEY (role) REFERENCES roles (name);

ALTER TABLE stores ADD CONSTRAINT FK_STORES_ON_POSTCODE FOREIGN KEY (postcode_id) REFERENCES postcodes (postcode);

ALTER TABLE stores ADD CONSTRAINT FK_STORES_ON_USER FOREIGN KEY (user_id) REFERENCES users (id);

ALTER TABLE tables ADD CONSTRAINT FK_TABLES_ON_STORE FOREIGN KEY (store_id) REFERENCES stores (id);

ALTER TABLE order_detail_addons ADD CONSTRAINT FK_ORDER_DETAIL_ADDONS_ON_ADDON FOREIGN KEY (addon_id) REFERENCES item_addons (id);

ALTER TABLE order_detail_addons ADD CONSTRAINT FK_ORDER_DETAIL_ADDONS_ON_ORDER_DETAIL FOREIGN KEY (order_detail_id) REFERENCES order_details (id);

ALTER TABLE order_details ADD CONSTRAINT FK_ORDER_DETAILS_ON_ITEM FOREIGN KEY (item_id) REFERENCES items (id);

ALTER TABLE order_details ADD CONSTRAINT FK_ORDER_DETAILS_ON_ORDER FOREIGN KEY (order_id) REFERENCES orders (id);

ALTER TABLE orders ADD CONSTRAINT FK_ORDERS_ON_COUPON FOREIGN KEY (coupon_id) REFERENCES coupons (id);

ALTER TABLE orders ADD CONSTRAINT FK_ORDERS_ON_STORE FOREIGN KEY (store_id) REFERENCES stores (id);

ALTER TABLE orders ADD CONSTRAINT FK_ORDERS_ON_TABLE FOREIGN KEY (table_id) REFERENCES tables (id);

ALTER TABLE orders ADD CONSTRAINT FK_ORDERS_ON_USER FOREIGN KEY (user_id) REFERENCES users (id);

ALTER TABLE item_sub_category_l10ns ADD CONSTRAINT FK_ITEM_SUB_CATEGORY_L10NS_ON_SUB_CATEGORY FOREIGN KEY (sub_category_id) REFERENCES item_sub_categories (id);

ALTER TABLE item_category_l10ns ADD CONSTRAINT FK_ITEM_CATEGORY_L10NS_ON_CATEGORY FOREIGN KEY (category_id) REFERENCES item_categories (id);

ALTER TABLE item_addon_categories ADD CONSTRAINT FK_ITEM_ADDON_CATEGORIES_ON_ITEM FOREIGN KEY (item_id) REFERENCES items (id);

ALTER TABLE item_addons ADD CONSTRAINT FK_ITEM_ADDONS_ON_ADDON_CATEGORY FOREIGN KEY (addon_category_id) REFERENCES item_addon_categories (id);

ALTER TABLE items ADD CONSTRAINT FK_ITEMS_ON_CATEGORY FOREIGN KEY (category_id) REFERENCES item_categories (id);

ALTER TABLE items ADD CONSTRAINT FK_ITEMS_ON_STORE FOREIGN KEY (store_id) REFERENCES stores (id);

ALTER TABLE items ADD CONSTRAINT FK_ITEMS_ON_SUB_CATEGORY FOREIGN KEY (sub_category_id) REFERENCES item_sub_categories (id);

ALTER TABLE coupons ADD CONSTRAINT FK_COUPONS_ON_INSERTED_BY FOREIGN KEY (inserted_by) REFERENCES users (id);
```