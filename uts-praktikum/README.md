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
Statement DQL digunakan untuk melakukan kueri pada data dalam objek skema.
- `SELECT` : Digunakan untuk mengambil data dari database.

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
Perintah TCL menangani transaksi dalam database.
- `COMMIT` : Melakukan Transaksi.
- `ROLLBACK` : Mengembalikan transaksi jika terjadi kesalahan.
- `SAVEPOINT` : Mengatur savepoint dalam transaksi.
- `SET TRANSACTION`: Menentukan karakteristik untuk transaksi.

### MySQL Query Aplikasi Restoran
```sql
CREATE TABLE `users` (
  `id` binary(16) NOT NULL,
  `phone` varchar(16) NOT NULL,
  `full_name` varchar(64) NOT NULL,
  `language_code` char(2) NOT NULL DEFAULT 'en',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone` (`phone`)
);


CREATE TABLE `stores` (
  `id` binary(16) NOT NULL,
  `user_id` binary(16) NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `image` text DEFAULT NULL,
  `banner` text DEFAULT NULL,
  `phone` varchar(16) NOT NULL,
  `pickup_type` set('pickup','dine-in') NOT NULL,
  `street_address` varchar(255) NOT NULL,
  `country` varchar(56) NOT NULL,
  `state` varchar(128) NOT NULL,
  `city` varchar(128) NOT NULL,
  `area` varchar(128) NOT NULL,
  `postcode` varchar(5) NOT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `rating` decimal(2,1) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone` (`phone`),
  KEY `fk__stores__user_id` (`user_id`),
  CONSTRAINT `fk__stores__user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE `items` (
  `id` binary(16) NOT NULL,
  `store_id` binary(16) NOT NULL,
  `category_id` binary(16) NOT NULL,
  `sub_category_id` binary(16) DEFAULT NULL,
  `name` varchar(64) NOT NULL,
  `picture` text DEFAULT NULL,
  `price` decimal(11,2) unsigned NOT NULL,
  `special_offer` decimal(11,2) unsigned NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk__items__store_id` (`store_id`),
  KEY `fk__items__category_id` (`category_id`),
  KEY `fk__items__sub_category_id` (`sub_category_id`),
  CONSTRAINT `fk__items__category_id` FOREIGN KEY (`category_id`) REFERENCES `item_categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk__items__store_id` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk__items__sub_category_id` FOREIGN KEY (`sub_category_id`) REFERENCES `item_sub_categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE `item_categories` (
  `id` binary(16) NOT NULL,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
);


CREATE TABLE `item_category_l10ns` (
  `category_id` binary(16) NOT NULL,
  `language_code` char(2) NOT NULL,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`category_id`,`language_code`),
  CONSTRAINT `fk__item_category_l10ns__category_id` FOREIGN KEY (`category_id`) REFERENCES `item_categories` (`id`)
);


CREATE TABLE `item_sub_categories` (
  `id` binary(16) NOT NULL,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
);


CREATE TABLE `item_sub_category_l10ns` (
  `sub_category_id` binary(16) NOT NULL,
  `language_code` char(2) NOT NULL,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`sub_category_id`,`language_code`),
  CONSTRAINT `fk__item_sub_category_l10ns__sub_category_id` FOREIGN KEY (`sub_category_id`) REFERENCES `item_sub_categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE `item_addon_categories` (
  `id` binary(16) NOT NULL,
  `item_id` binary(16) NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `is_multiple_choice` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk__item_addon_categories__item_id` (`item_id`),
  CONSTRAINT `fk__item_addon_categories__item_id` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE `item_addons` (
  `id` binary(16) NOT NULL,
  `addon_category_id` binary(16) NOT NULL,
  `name` varchar(64) NOT NULL,
  `price` decimal(11,2) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk__item_addons__addon_category_id` (`addon_category_id`),
  CONSTRAINT `fk__item_addons__addon_category_id` FOREIGN KEY (`addon_category_id`) REFERENCES `item_addon_categories` (`id`)
);


CREATE TABLE `orders` (
  `id` binary(16) NOT NULL,
  `user_id` binary(16) NOT NULL,
  `store_id` binary(16) NOT NULL,
  `table_id` binary(16) DEFAULT NULL,
  `coupon_id` binary(16) DEFAULT NULL,
  `buyer` varchar(64) NOT NULL,
  `store_image` text DEFAULT NULL,
  `store_banner` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `coupon_code` varchar(16) DEFAULT NULL,
  `coupon_name` varchar(64) DEFAULT NULL,
  `discount` decimal(11,2) unsigned DEFAULT NULL,
  `discount_nominal` decimal(11,2) unsigned NOT NULL,
  `netto` decimal(11,2) unsigned NOT NULL,
  `brutto` decimal(11,2) unsigned NOT NULL,
  `status` enum('pending','preparing','ready','complete','cancelled') NOT NULL,
  `order_type` enum('scheduled','now') NOT NULL,
  `scheduled_at` datetime DEFAULT NULL,
  `pickup_type` enum('dine-in','pickup') NOT NULL,
  `rating` decimal(2,1) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk__orders__user_id` (`user_id`),
  KEY `fk__orders__coupon_id` (`coupon_id`),
  KEY `fk__orders__store_id` (`store_id`),
  KEY `fk__orders__table_id` (`table_id`),
  CONSTRAINT `fk__orders__coupon_id` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk__orders__store_id` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`),
  CONSTRAINT `fk__orders__table_id` FOREIGN KEY (`table_id`) REFERENCES `tables` (`id`),
  CONSTRAINT `fk__orders__user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE `order_details` (
  `id` binary(16) NOT NULL,
  `order_id` binary(16) NOT NULL,
  `item_id` binary(16) NOT NULL,
  `item_name` varchar(64) NOT NULL,
  `quantity` tinyint(3) unsigned NOT NULL,
  `price` decimal(11,2) unsigned NOT NULL,
  `netto` decimal(11,2) unsigned NOT NULL,
  `picture` text DEFAULT NULL,
  `item_detail` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk__order_details__order_id` (`order_id`),
  KEY `fk__order_details__item_id` (`item_id`),
  CONSTRAINT `fk__order_details__item_id` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`),
  CONSTRAINT `fk__order_details__order_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE `order_detail_addons` (
  `id` binary(16) NOT NULL,
  `order_detail_id` binary(16) NOT NULL,
  `addon_id` binary(16) NOT NULL,
  `addon_name` varchar(64) NOT NULL,
  `quantity` tinyint(3) unsigned NOT NULL,
  `price` decimal(11,2) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk__order_detail_addons__addon_id` (`addon_id`),
  KEY `fk__order_detail_addons__detail_order_id` (`order_detail_id`),
  CONSTRAINT `fk__order_detail_addons__addon_id` FOREIGN KEY (`addon_id`) REFERENCES `item_addons` (`id`),
  CONSTRAINT `fk__order_detail_addons__detail_order_id` FOREIGN KEY (`order_detail_id`) REFERENCES `order_details` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE `tables` (
  `id` binary(16) NOT NULL,
  `store_id` binary(16) NOT NULL,
  `name` varchar(64) NOT NULL,
  `max_person` tinyint(3) unsigned NOT NULL,
  `total_person` tinyint(3) unsigned NOT NULL,
  `book_price` decimal(11,2) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk__tables__store_id` (`store_id`),
  CONSTRAINT `fk__tables__store_id` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE `coupons` (
  `id` binary(16) NOT NULL,
  `inserted_by` binary(16) NOT NULL,
  `coupon_code` varchar(16) NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `expiry_date` datetime NOT NULL,
  `discount_user_type` enum('all','once_fist_order','once_per_user') NOT NULL,
  `discount_type` enum('fixed','percentage') NOT NULL,
  `discount` decimal(11,2) unsigned NOT NULL,
  `min_total` decimal(11,2) unsigned NOT NULL,
  `max_discount` decimal(11,2) unsigned NOT NULL,
  `max_number_use_total` int(10) unsigned DEFAULT NULL,
  `max_number_use_user` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `all_store` tinyint(1) NOT NULL,
  `all_user` tinyint(1) NOT NULL,
  `is_valid` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `coupon_code` (`coupon_code`,`is_valid`) USING BTREE,
  KEY `fk__coupons__inserted_by` (`inserted_by`),
  CONSTRAINT `fk__coupons__inserted_by` FOREIGN KEY (`inserted_by`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE `coupon_stores` (
  `coupon_id` binary(16) NOT NULL,
  `store_id` binary(16) NOT NULL,
  PRIMARY KEY (`coupon_id`,`store_id`),
  KEY `fk__coupon_stores__store_id` (`store_id`),
  CONSTRAINT `fk__coupon_stores__coupon_id` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk__coupon_stores__store_id` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE `coupon_users` (
  `coupon_id` binary(16) NOT NULL,
  `user_id` binary(16) NOT NULL,
  PRIMARY KEY (`coupon_id`,`user_id`),
  KEY `fk__coupon_users__user_id` (`user_id`),
  CONSTRAINT `fk__coupon_users__coupon_id` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk__coupon_users__user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
);



```