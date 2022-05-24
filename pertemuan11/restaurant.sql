DROP SCHEMA public CASCADE;

CREATE SCHEMA public;

CREATE TYPE discount_type_enum AS ENUM ('fixed', 'percentage');

CREATE TYPE order_status_enum AS ENUM (
    'pending',
    'preparing',
    'ready',
    'complete',
    'cancelled'
);

CREATE TYPE order_type_enum AS ENUM ('scheduled', 'now');

CREATE TYPE pickup_type_enum AS ENUM ('pickup', 'dine-in');

CREATE TYPE store_role_enum AS ENUM ('admin', 'staff');

CREATE TABLE coupons (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    inserted_by UUID NOT NULL,
    coupon_code VARCHAR(16) NOT NULL,
    name VARCHAR(64) NOT NULL,
    description VARCHAR(255),
    expiry_date TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    discount_type discount_type_enum NOT NULL,
    discount DECIMAL(11, 2) NOT NULL,
    min_total DECIMAL(11, 2) NOT NULL,
    max_discount DECIMAL(11, 2) NOT NULL,
    max_number_use_total INTEGER,
    max_number_use_customer INTEGER NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now() NOT NULL,
    all_store BOOLEAN NOT NULL,
    all_customer BOOLEAN NOT NULL,
    is_valid BOOLEAN NOT NULL,
    CONSTRAINT pk_coupons PRIMARY KEY (id)
);

CREATE TABLE coupon_customers(
    coupon_id UUID NOT NULL,
    customer_id UUID NOT NULL,
    CONSTRAINT pk_coupon_customers PRIMARY KEY (coupon_id, customer_id)
);

CREATE TABLE coupon_stores(
    coupon_id UUID NOT NULL,
    store_id UUID NOT NULL,
    CONSTRAINT pk_coupon_stores PRIMARY KEY (coupon_id, store_id)
);

CREATE TABLE customers (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    full_name VARCHAR(64) NOT NULL,
    phone VARCHAR(16) NOT NULL,
    language_code VARCHAR(2) NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now() NOT NULL,
    CONSTRAINT pk_customers PRIMARY KEY (id)
);

CREATE TABLE items (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    store_id UUID NOT NULL,
    category_id UUID NOT NULL,
    sub_category_id UUID,
    name VARCHAR(64) NOT NULL,
    picture TEXT,
    price DECIMAL(11, 2) NOT NULL,
    special_offer DECIMAL(11, 2) NOT NULL,
    description VARCHAR(255),
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT pk_items PRIMARY KEY (id)
);

CREATE TABLE item_addons (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    addon_category_id UUID NOT NULL,
    name VARCHAR(64) NOT NULL,
    price DECIMAL(11, 2) NOT NULL,
    CONSTRAINT pk_item_addons PRIMARY KEY (id)
);

CREATE TABLE item_addon_categories (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    item_id UUID NOT NULL,
    name VARCHAR(64) NOT NULL,
    description VARCHAR(255),
    is_multiple_choice BOOLEAN NOT NULL,
    CONSTRAINT pk_item_addon_categories PRIMARY KEY (id)
);

CREATE TABLE item_categories (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    name VARCHAR(64) NOT NULL,
    CONSTRAINT pk_item_categories PRIMARY KEY (id)
);

CREATE TABLE item_category_l10ns (
    category_id UUID NOT NULL,
    language_code VARCHAR(2) NOT NULL,
    name VARCHAR(64) NOT NULL,
    CONSTRAINT pk_item_category_l10ns PRIMARY KEY (category_id, language_code)
);

CREATE TABLE item_sub_categories (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    name VARCHAR(64) NOT NULL,
    CONSTRAINT pk_item_sub_categories PRIMARY KEY (id)
);

CREATE TABLE item_sub_category_l10ns (
    sub_category_id UUID NOT NULL,
    language_code VARCHAR(2) NOT NULL,
    name VARCHAR(64) NOT NULL,
    CONSTRAINT pk_item_sub_category_l10ns PRIMARY KEY (sub_category_id, language_code)
);

CREATE TABLE orders (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    customer_id UUID NOT NULL,
    store_id UUID NOT NULL,
    store_account_id UUID,
    table_id UUID,
    coupon_id UUID,
    buyer VARCHAR(64) NOT NULL,
    store_image TEXT,
    store_banner TEXT,
    table_price DECIMAL(11, 2) NULL,
    brutto DECIMAL(11, 2) NOT NULL,
    netto DECIMAL(11, 2) NOT NULL,
    coupon_code VARCHAR(16),
    coupon_name VARCHAR(64),
    discount DECIMAL(11, 2),
    discount_nominal DECIMAL(11, 2) NOT NULL,
    status order_status_enum NOT NULL,
    order_type order_type_enum NOT NULL,
    scheduled_at TIMESTAMP WITHOUT TIME ZONE,
    pickup_type pickup_type_enum NOT NULL,
    rating DECIMAL(2, 1),
    comment VARCHAR(255),
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now() NOT NULL,
    CONSTRAINT pk_orders PRIMARY KEY (id)
);

CREATE TABLE order_details (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    order_id UUID NOT NULL,
    item_id UUID NOT NULL,
    item_name VARCHAR(64) NOT NULL,
    quantity INTEGER NOT NULL,
    price DECIMAL(11, 2) NOT NULL,
    total DECIMAL(11, 2) NOT NULL,
    picture TEXT,
    item_detail VARCHAR(255),
    CONSTRAINT pk_order_details PRIMARY KEY (id)
);

CREATE TABLE order_detail_addons (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    order_detail_id UUID NOT NULL,
    addon_id UUID NOT NULL,
    addon_name VARCHAR(64) NOT NULL,
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

CREATE TABLE reservation_tables (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    store_id UUID NOT NULL,
    name VARCHAR(64) NOT NULL,
    max_person INTEGER NOT NULL,
    book_price DECIMAL(11, 2) NOT NULL,
    CONSTRAINT pk_reservation_tables PRIMARY KEY (id)
);

CREATE TABLE stores (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    store_admin_id UUID NOT NULL,
    name VARCHAR(64) NOT NULL,
    description VARCHAR(255),
    image TEXT,
    banner TEXT,
    phone VARCHAR(16) NOT NULL,
    street_address VARCHAR(255) NOT NULL,
    postcode_id VARCHAR(5) NOT NULL,
    latitude DOUBLE PRECISION NOT NULL,
    longitude DOUBLE PRECISION NOT NULL,
    rating DECIMAL(2, 1),
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    CONSTRAINT pk_stores PRIMARY KEY (id)
);

CREATE TABLE store_pickup_types (
    store_id UUID NOT NULL,
    pickup_type pickup_type_enum NOT NULL,
    CONSTRAINT pk_store_pickup_types PRIMARY KEY (store_id, pickup_type)
);

CREATE TABLE store_accounts (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    full_name VARCHAR(64) NOT NULL,
    role store_role_enum NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now() NOT NULL,
    CONSTRAINT pk_store_accounts PRIMARY KEY (id)
);

CREATE TABLE store_admins (
    store_account_id UUID NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    token_reset_password VARCHAR(255),
    token_expired_at TIMESTAMP WITHOUT TIME ZONE,
    last_updated_password TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT pk_store_admins PRIMARY KEY (store_account_id)
);

CREATE TABLE store_staffs (
    store_account_id UUID NOT NULL,
    store_id UUID NOT NULL,
    username VARCHAR(36) NOT NULL,
    password VARCHAR(255) NOT NULL,
    is_locked BOOLEAN DEFAULT FALSE NOT NULL,
    CONSTRAINT pk_store_staffs PRIMARY KEY (store_account_id)
);

CREATE UNIQUE INDEX uk_coupons_on_coupon_code_is_valid ON coupons(coupon_code, is_valid);

CREATE UNIQUE INDEX uk_customers_on_phone ON customers(phone);

CREATE UNIQUE INDEX uk_stores_on_store_admin_id ON stores(store_admin_id);

CREATE UNIQUE INDEX uk_stores_on_phone ON stores(phone);

CREATE UNIQUE INDEX uk_store_admins_on_email ON store_admins(email);

CREATE UNIQUE INDEX uk_store_staffs_on_store_id_username ON store_staffs(store_id, username);

ALTER TABLE coupons
ADD CONSTRAINT fk_coupons_on_inserted_by FOREIGN KEY (inserted_by) REFERENCES store_admins (store_account_id);

ALTER TABLE coupon_customers
ADD CONSTRAINT fk_coupon_customers_on_coupon FOREIGN KEY (coupon_id) REFERENCES coupons (id);

ALTER TABLE coupon_customers
ADD CONSTRAINT fk_coupon_customers_on_customer FOREIGN KEY (customer_id) REFERENCES customers (id);

ALTER TABLE coupon_stores
ADD CONSTRAINT fk_coupon_stores_on_coupon FOREIGN KEY (coupon_id) REFERENCES coupons (id);

ALTER TABLE coupon_stores
ADD CONSTRAINT fk_coupon_stores_on_store FOREIGN KEY (store_id) REFERENCES stores (id);

ALTER TABLE items
ADD CONSTRAINT fk_items_on_store FOREIGN KEY (store_id) REFERENCES stores (id);

ALTER TABLE items
ADD CONSTRAINT fk_items_on_category FOREIGN KEY (category_id) REFERENCES item_categories (id);

ALTER TABLE items
ADD CONSTRAINT fk_items_on_sub_category FOREIGN KEY (sub_category_id) REFERENCES item_sub_categories (id);

ALTER TABLE item_addons
ADD CONSTRAINT fk_item_addons_on_addon_category FOREIGN KEY (addon_category_id) REFERENCES item_addon_categories (id);

ALTER TABLE item_addon_categories
ADD CONSTRAINT fk_item_addon_categories_on_item FOREIGN KEY (item_id) REFERENCES items (id);

ALTER TABLE item_category_l10ns
ADD CONSTRAINT fk_item_category_l10ns_on_category FOREIGN KEY (category_id) REFERENCES item_categories (id);

ALTER TABLE item_sub_category_l10ns
ADD CONSTRAINT fk_item_sub_category_l10ns_on_sub_category FOREIGN KEY (sub_category_id) REFERENCES item_sub_categories (id);

ALTER TABLE orders
ADD CONSTRAINT fk_orders_on_customer FOREIGN KEY (customer_id) REFERENCES customers (id);

ALTER TABLE orders
ADD CONSTRAINT fk_orders_on_store FOREIGN KEY (store_id) REFERENCES stores (id);

ALTER TABLE orders
ADD CONSTRAINT fk_orders_on_store_account FOREIGN KEY (store_account_id) REFERENCES store_accounts (id);

ALTER TABLE orders
ADD CONSTRAINT fk_orders_on_table FOREIGN KEY (table_id) REFERENCES reservation_tables (id);

ALTER TABLE orders
ADD CONSTRAINT fk_orders_on_coupon FOREIGN KEY (coupon_id) REFERENCES coupons (id);

ALTER TABLE order_details
ADD CONSTRAINT fk_order_details_on_order FOREIGN KEY (order_id) REFERENCES orders (id);

ALTER TABLE order_details
ADD CONSTRAINT fk_order_details_on_item FOREIGN KEY (item_id) REFERENCES items (id);

ALTER TABLE order_detail_addons
ADD CONSTRAINT fk_order_detail_addons_on_order_detail FOREIGN KEY (order_detail_id) REFERENCES order_details (id);

ALTER TABLE order_detail_addons
ADD CONSTRAINT fk_order_detail_addons_on_addon FOREIGN KEY (addon_id) REFERENCES item_addons (id);

ALTER TABLE reservation_tables
ADD CONSTRAINT fk_reservation_tables_on_store FOREIGN KEY (store_id) REFERENCES stores (id);

ALTER TABLE stores
ADD CONSTRAINT fk_stores_on_postcode FOREIGN KEY (postcode_id) REFERENCES postcodes (postcode);

ALTER TABLE stores
ADD CONSTRAINT fk_stores_on_store_admins FOREIGN KEY (store_admin_id) REFERENCES store_admins (store_account_id);

ALTER TABLE store_pickup_types
ADD CONSTRAINT fk_store_pickup_types_on_store FOREIGN KEY (store_id) REFERENCES stores (id);

ALTER TABLE store_admins
ADD CONSTRAINT fk_store_admins_on_store_account FOREIGN KEY (store_account_id) REFERENCES store_accounts (id);

ALTER TABLE store_staffs
ADD CONSTRAINT fk_store_staffs_on_store_account FOREIGN KEY (store_account_id) REFERENCES store_accounts (id);

ALTER TABLE store_staffs
ADD CONSTRAINT fk_store_staffs_on_store FOREIGN KEY (store_id) REFERENCES stores (id);

DO $$
DECLARE _store_account_id store_accounts.id % TYPE;

_postcode postcodes.postcode % TYPE;

_store_id stores.id % TYPE;

_table_id reservation_tables.id % TYPE;

_item_category_id item_categories.id % TYPE;

_item_sub_category_id item_sub_categories.id % TYPE;

_item_id items.id % TYPE;

_addon_category_id item_addon_categories.id % TYPE;

_addon_id item_addons.id % TYPE;

_customer_id customers.id % TYPE;

_coupon_id coupons.id % TYPE;

_order_id orders.id % TYPE;

_order_detail_id order_details.id % TYPE;

BEGIN -- insert store_accounts
INSERT INTO store_accounts (full_name, role)
VALUES ('Rizal Hadiyansah', 'admin')
RETURNING id INTO _store_account_id;

-- insert store_admins
INSERT INTO store_admins (
        store_account_id,
        email,
        password,
        token_reset_password
    )
VALUES (
        _store_account_id,
        'rizalhadiyansah@gmail.com',
        '$2a$12$q3mLZR3i86cSR90DSf1X6u1lXfGAy4KILvbxR3fQjDSJVTkSpVEyC',
        NULL
    );

-- insert postcodes
INSERT INTO postcodes(postcode, city, state, country)
VALUES (
        '45595',
        'Kuningan',
        'West Java',
        'Indonesia'
    )
RETURNING postcode INTO _postcode;

-- insert stores
INSERT INTO stores(
        store_admin_id,
        name,
        description,
        image,
        banner,
        phone,
        street_address,
        postcode_id,
        latitude,
        longitude,
        rating
    )
VALUES (
        _store_account_id,
        'Alpha Store',
        'Alpha Store',
        'https://www.koalahero.com/wp-content/uploads/2019/10/Makanan-McDonald.jpg',
        'https://seeklogo.com/images/M/mcdonald-s-logo-255A7B5646-seeklogo.com.png',
        '08123456789',
        'Jalan Raya Kuningan',
        _postcode,
        - 6.2289,
        106.845,
        4.5
    )
RETURNING id INTO _store_id;

-- insert store_pickup_types
INSERT INTO store_pickup_types(store_id, pickup_type)
VALUES (_store_id, 'pickup');

-- insert store_pickup_types
INSERT INTO store_pickup_types(store_id, pickup_type)
VALUES (_store_id, 'dine-in');

-- insert store_staffs
INSERT INTO store_staffs (
        store_account_id,
        store_id,
        username,
        password,
        is_locked
    )
VALUES (
        _store_account_id,
        _store_id,
        'a_lpha',
        '$2a$12$q3mLZR3i86cSR90DSf1X6u1lXfGAy4KILvbxR3fQjDSJVTkSpVEyC',
        FALSE
    );

-- insert reservation_tables
INSERT INTO reservation_tables (store_id, name, max_person, book_price)
VALUES (_store_id, 'Table 1', 2, 10000)
RETURNING id INTO _table_id;

-- insert item_categories
INSERT INTO item_categories (name)
VALUES ('Burgers')
RETURNING id INTO _item_category_id;

-- insert item_category_l10ns
INSERT INTO item_category_l10ns (name, category_id, language_code)
VALUES ('Burger', _item_category_id, 'id');

-- insert item_sub_categories
INSERT INTO item_sub_categories (name)
VALUES ('Breakfasts')
RETURNING id INTO _item_sub_category_id;

-- insert item_sub_category_l10ns
INSERT INTO item_sub_category_l10ns (name, sub_category_id, language_code)
VALUES (
        'Sarapan',
        _item_sub_category_id,
        'id'
    );

-- insert items
INSERT INTO items (
        store_id,
        category_id,
        sub_category_id,
        name,
        picture,
        price,
        special_offer,
        description
    )
VALUES (
        _store_id,
        _item_category_id,
        _item_sub_category_id,
        'McDonalds Burger',
        'https://www.koalahero.com/wp-content/uploads/2019/10/Makanan-McDonald.jpg',
        10000,
        9000,
        'McDonalds Burger'
    )
RETURNING id INTO _item_id;

-- insert item_addon_categories
INSERT INTO item_addon_categories (item_id, name, description, is_multiple_choice)
VALUES (
        _item_id,
        'Add on',
        'Makin enak tambah add on',
        TRUE
    )
RETURNING id INTO _addon_category_id;

-- insert item_addons
INSERT INTO item_addons (addon_category_id, name, price)
VALUES (
        _addon_category_id,
        'Extra sauce Kari Spesial',
        5000
    )
RETURNING id INTO _addon_id;

-- insert customers
INSERT INTO customers (full_name, phone, language_code)
VALUES (
        'Rizal Hadiyansah',
        '08123456789',
        'en'
    )
RETURNING id INTO _customer_id;

-- insert coupons
INSERT INTO coupons (
        inserted_by,
        coupon_code,
        name,
        description,
        expiry_date,
        discount_type,
        discount,
        min_total,
        max_discount,
        max_number_use_total,
        max_number_use_customer,
        all_store,
        all_customer,
        is_valid
    )
VALUES (
        _store_account_id,
        'BREAK',
        'Coupon New Customer',
        'This coupon is for new customer from store Alpha Store',
        '2023-01-01',
        'percentage',
        10,
        0,
        20000,
        NULL,
        1,
        FALSE,
        FALSE,
        TRUE
    )
RETURNING id INTO _coupon_id;

-- insert coupon_customers
INSERT INTO coupon_customers (coupon_id, customer_id)
VALUES (_coupon_id, _customer_id);

-- insert coupon_stores
INSERT INTO coupon_stores (coupon_id, store_id)
VALUES (_coupon_id, _store_id);

-- insert orders
INSERT INTO orders (
        customer_id,
        store_id,
        store_account_id,
        table_id,
        coupon_id,
        buyer,
        store_image,
        store_banner,
        table_price,
        brutto,
        netto,
        coupon_code,
        coupon_name,
        discount,
        discount_nominal,
        status,
        order_type,
        scheduled_at,
        pickup_type,
        rating,
        comment
    )
VALUES (
        _customer_id,
        _store_id,
        _store_account_id,
        _table_id,
        _coupon_id,
        'Rizal Hadiyansah',
        'https://www.koalahero.com/wp-content/uploads/2019/10/Makanan-McDonald.jpg',
        'https://seeklogo.com/images/M/mcdonald-s-logo-255A7B5646-seeklogo.com.png',
        10000,
        38000,
        34200,
        'BREAK',
        'Coupon New Customer',
        10,
        3800,
        'pending',
        'scheduled',
        '2022-05-04',
        'dine-in',
        4.0,
        'Not bad'
    )
RETURNING id INTO _order_id;

-- insert order_details
INSERT INTO order_details (
        order_id,
        item_id,
        item_name,
        quantity,
        price,
        total,
        picture,
        item_detail
    )
VALUES (
        _order_id,
        _item_id,
        'McDonalds Burger',
        2,
        9000,
        28000,
        'https://www.koalahero.com/wp-content/uploads/2019/10/Makanan-McDonald.jpg',
        ''
    )
RETURNING id INTO _order_detail_id;

-- insert order_detail_addons
INSERT INTO order_detail_addons (order_detail_id, addon_id, addon_name, price)
VALUES (
        _order_detail_id,
        _addon_id,
        'Extra sauce Kari Spesial',
        5000
    );

END $$;