DROP SCHEMA public CASCADE;

CREATE SCHEMA public;

create type discount_type_enum as enum ('fixed', 'percentage');

create type order_status_enum as enum (
    'pending',
    'preparing',
    'ready',
    'complete',
    'cancelled'
);

create type order_type_enum as enum ('scheduled', 'now');

create type pickup_type_enum as enum ('pickup', 'dine-in');

create type store_role_enum as enum ('admin', 'staff');

create table coupons (
    id uuid not null default gen_random_uuid(),
    inserted_by uuid not null,
    coupon_code varchar(16) not null,
    name varchar(64) not null,
    description varchar(255),
    expiry_date timestamp without time zone not null,
    discount_type discount_type_enum not null,
    discount decimal(11, 2) not null,
    min_total decimal(11, 2) not null,
    max_discount decimal(11, 2) not null,
    max_number_use_total integer,
    max_number_use_customer integer not null,
    created_at timestamp without time zone default now() not null,
    all_store boolean not null,
    all_customer boolean not null,
    is_valid boolean not null,
    constraint pk_coupons primary key (id)
);

create table coupon_customers(
    coupon_id uuid not null,
    customer_id uuid not null,
    constraint pk_coupon_customers primary key (coupon_id, customer_id)
);

create table coupon_stores(
    coupon_id uuid not null,
    store_id uuid not null,
    constraint pk_coupon_stores primary key (coupon_id, store_id)
);

create table customers (
    id uuid not null default gen_random_uuid(),
    full_name varchar(64) not null,
    phone varchar(16) not null,
    language_code varchar(2) not null,
    created_at timestamp without time zone default now() not null,
    constraint pk_customers primary key (id)
);

create table items (
    id uuid not null default gen_random_uuid(),
    store_id uuid not null,
    category_id uuid not null,
    sub_category_id uuid,
    name varchar(64) not null,
    picture text,
    price decimal(11, 2) not null,
    special_offer decimal(11, 2) not null,
    description varchar(255),
    is_active boolean not null default true,
    constraint pk_items primary key (id)
);

create table item_addons (
    id uuid not null default gen_random_uuid(),
    addon_category_id uuid not null,
    name varchar(64) not null,
    price decimal(11, 2) not null,
    constraint pk_item_addons primary key (id)
);

create table item_addon_categories (
    id uuid not null default gen_random_uuid(),
    item_id uuid not null,
    name varchar(64) not null,
    description varchar(255),
    is_multiple_choice boolean not null,
    constraint pk_item_addon_categories primary key (id)
);

create table item_categories (
    id uuid not null default gen_random_uuid(),
    name varchar(64) not null,
    constraint pk_item_categories primary key (id)
);

create table item_category_l10ns (
    category_id uuid not null,
    language_code varchar(2) not null,
    name varchar(64) not null,
    constraint pk_item_category_l10ns primary key (category_id, language_code)
);

create table item_sub_categories (
    id uuid not null default gen_random_uuid(),
    name varchar(64) not null,
    constraint pk_item_sub_categories primary key (id)
);

create table item_sub_category_l10ns (
    sub_category_id uuid not null,
    language_code varchar(2) not null,
    name varchar(64) not null,
    constraint pk_item_sub_category_l10ns primary key (sub_category_id, language_code)
);

create table orders (
    id uuid not null default gen_random_uuid(),
    customer_id uuid not null,
    store_id uuid not null,
    store_account_id uuid,
    table_id uuid,
    coupon_id uuid,
    buyer varchar(64) not null,
    store_image text,
    store_banner text,
    table_price decimal(11, 2) null,
    brutto decimal(11, 2) not null,
    netto decimal(11, 2) not null,
    coupon_code varchar(16),
    coupon_name varchar(64),
    discount decimal(11, 2),
    discount_nominal decimal(11, 2) not null,
    status order_status_enum not null,
    order_type order_type_enum not null,
    scheduled_at timestamp without time zone,
    pickup_type pickup_type_enum not null,
    rating decimal(2, 1),
    comment varchar(255),
    created_at timestamp without time zone default now() not null,
    constraint pk_orders primary key (id)
);

create table order_details (
    id uuid not null default gen_random_uuid(),
    order_id uuid not null,
    item_id uuid not null,
    item_name varchar(64) not null,
    quantity integer not null,
    price decimal(11, 2) not null,
    total decimal(11, 2) not null,
    picture text,
    item_detail varchar(255),
    constraint pk_order_details primary key (id)
);

create table order_detail_addons (
    id uuid not null default gen_random_uuid(),
    order_detail_id uuid not null,
    addon_id uuid not null,
    addon_name varchar(64) not null,
    price decimal(11, 2) not null,
    constraint pk_order_detail_addons primary key (id)
);

create table postcodes (
    postcode varchar(5) not null,
    city varchar(128) not null,
    state varchar(128) not null,
    country varchar(56) not null,
    constraint pk_postcodes primary key (postcode)
);

create table reservation_tables (
    id uuid not null default gen_random_uuid(),
    store_id uuid not null,
    name varchar(64) not null,
    max_person integer not null,
    book_price decimal(11, 2) not null,
    constraint pk_reservation_tables primary key (id)
);

create table stores (
    id uuid not null default gen_random_uuid(),
    store_admin_id uuid not null,
    name varchar(64) not null,
    description varchar(255),
    image text,
    banner text,
    phone varchar(16) not null,
    street_address varchar(255) not null,
    postcode_id varchar(5) not null,
    latitude double precision not null,
    longitude double precision not null,
    rating decimal(2, 1),
    is_active boolean not null default true,
    constraint pk_stores primary key (id)
);

create table store_pickup_types (
    store_id uuid not null,
    pickup_type pickup_type_enum not null,
    constraint pk_store_pickup_types primary key (store_id, pickup_type)
);

create table store_accounts (
    id uuid not null default gen_random_uuid(),
    full_name varchar(64) not null,
    role store_role_enum not null,
    created_at timestamp without time zone default now() not null,
    constraint pk_store_accounts primary key (id)
);

create table store_admins (
    store_account_id uuid not null,
    email varchar(255) not null,
    password varchar(255) not null,
    token_reset_password varchar(255),
    token_expired_at timestamp without time zone,
    last_updated_password timestamp without time zone,
    constraint pk_store_admins primary key (store_account_id)
);

create table store_staffs (
    store_account_id uuid not null,
    store_id uuid not null,
    username varchar(36) not null,
    password varchar(255) not null,
    is_locked boolean default false not null,
    constraint pk_store_staffs primary key (store_account_id)
);

create unique index uk_coupons_on_coupon_code_is_valid on coupons(coupon_code, is_valid);

create unique index uk_customers_on_phone on customers(phone);

create unique index uk_stores_on_store_admin_id on stores(store_admin_id);

create unique index uk_stores_on_phone on stores(phone);

create unique index uk_store_admins_on_email on store_admins(email);

create unique index uk_store_staffs_on_store_id_username on store_staffs(store_id, username);

alter table coupons
add constraint fk_coupons_on_inserted_by foreign key (inserted_by) references store_admins (store_account_id);

alter table coupon_customers
add constraint fk_coupon_customers_on_coupon foreign key (coupon_id) references coupons (id);

alter table coupon_customers
add constraint fk_coupon_customers_on_customer foreign key (customer_id) references customers (id);

alter table coupon_stores
add constraint fk_coupon_stores_on_coupon foreign key (coupon_id) references coupons (id);

alter table coupon_stores
add constraint fk_coupon_stores_on_store foreign key (store_id) references stores (id);

alter table items
add constraint fk_items_on_store foreign key (store_id) references stores (id);

alter table items
add constraint fk_items_on_category foreign key (category_id) references item_categories (id);

alter table items
add constraint fk_items_on_sub_category foreign key (sub_category_id) references item_sub_categories (id);

alter table item_addons
add constraint fk_item_addons_on_addon_category foreign key (addon_category_id) references item_addon_categories (id);

alter table item_addon_categories
add constraint fk_item_addon_categories_on_item foreign key (item_id) references items (id);

alter table item_category_l10ns
add constraint fk_item_category_l10ns_on_category foreign key (category_id) references item_categories (id);

alter table item_sub_category_l10ns
add constraint fk_item_sub_category_l10ns_on_sub_category foreign key (sub_category_id) references item_sub_categories (id);

alter table orders
add constraint fk_orders_on_customer foreign key (customer_id) references customers (id);

alter table orders
add constraint fk_orders_on_store foreign key (store_id) references stores (id);

alter table orders
add constraint fk_orders_on_store_account foreign key (store_account_id) references store_accounts (id);

alter table orders
add constraint fk_orders_on_table foreign key (table_id) references reservation_tables (id);

alter table orders
add constraint fk_orders_on_coupon foreign key (coupon_id) references coupons (id);

alter table order_details
add constraint fk_order_details_on_order foreign key (order_id) references orders (id);

alter table order_details
add constraint fk_order_details_on_item foreign key (item_id) references items (id);

alter table order_detail_addons
add constraint fk_order_detail_addons_on_order_detail foreign key (order_detail_id) references order_details (id);

alter table order_detail_addons
add constraint fk_order_detail_addons_on_addon foreign key (addon_id) references item_addons (id);

alter table reservation_tables
add constraint fk_reservation_tables_on_store foreign key (store_id) references stores (id);

alter table stores
add constraint fk_stores_on_postcode foreign key (postcode_id) references postcodes (postcode);

alter table stores
add constraint fk_stores_on_store_admins foreign key (store_admin_id) references store_admins (store_account_id);

alter table store_pickup_types
add constraint fk_store_pickup_types_on_store foreign key (store_id) references stores (id);

alter table store_admins
add constraint fk_store_admins_on_store_account foreign key (store_account_id) references store_accounts (id);

alter table store_staffs
add constraint fk_store_staffs_on_store_account foreign key (store_account_id) references store_accounts (id);

alter table store_staffs
add constraint fk_store_staffs_on_store foreign key (store_id) references stores (id);

do $$
declare _store_account_id store_accounts.id %type;

_postcode postcodes.postcode %type;

_store_id stores.id %type;

_table_id reservation_tables.id %type;

_item_category_id item_categories.id %type;

_item_sub_category_id item_sub_categories.id %type;

_item_id items.id %type;

_addon_category_id item_addon_categories.id %type;

_addon_id item_addons.id %type;

_customer_id customers.id %type;

_coupon_id coupons.id %type;

_order_id orders.id %type;

_order_detail_id order_details.id %type;

begin -- insert store_accounts
insert into store_accounts (full_name, role)
values ('Rizal Hadiyansah', 'admin')
returning id into _store_account_id;

insert into store_admins (
        store_account_id,
        email,
        password,
        token_reset_password
    )
values (
        _store_account_id,
        'rizalhadiyansah@gmail.com',
        '$2a$12$q3mLZR3i86cSR90DSf1X6u1lXfGAy4KILvbxR3fQjDSJVTkSpVEyC',
        null
    );

-- insert postcodes
insert into postcodes(postcode, city, state, country)
values ('45595', 'Kuningan', 'West Java', 'Indonesia')
returning postcode into _postcode;

-- insert stores
insert into stores(
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
values (
        _store_account_id,
        'Alpha Store',
        'Alpha Store',
        'https://www.koalahero.com/wp-content/uploads/2019/10/Makanan-McDonald.jpg',
        'https://seeklogo.com/images/M/mcdonald-s-logo-255A7B5646-seeklogo.com.png',
        '08123456789',
        'Jalan Raya Kuningan',
        _postcode,
        -6.2289,
        106.845,
        4.5
    )
returning id into _store_id;

-- insert store_pickup_types
insert into store_pickup_types(store_id, pickup_type)
values (_store_id, 'pickup');

-- insert store_pickup_types
insert into store_pickup_types(store_id, pickup_type)
values (_store_id, 'dine-in');

-- insert store_staffs
insert into store_staffs (
        store_account_id,
        store_id,
        username,
        password,
        is_locked
    )
values (
        _store_account_id,
        _store_id,
        'a_lpha',
        '$2a$12$q3mLZR3i86cSR90DSf1X6u1lXfGAy4KILvbxR3fQjDSJVTkSpVEyC',
        false
    );

-- insert reservation_tables
insert into reservation_tables (
        store_id,
        name,
        max_person,
        book_price
    )
values (
        _store_id,
        'Table 1',
        2,
        10000
    );

-- insert item_categories
insert into item_categories (name)
values ('Burgers')
returning id into _item_category_id;

-- insert item_category_l10ns
insert into item_category_l10ns (name, category_id, language_code)
values ('Burger', _item_category_id, 'id');

-- insert item_sub_categories
insert into item_sub_categories (name)
values ('Breakfasts')
returning id into _item_sub_category_id;

-- insert item_sub_category_l10ns
insert into item_sub_category_l10ns (name, sub_category_id, language_code)
values ('Sarapan', _item_sub_category_id, 'id');

-- insert items
insert into items (
        store_id,
        category_id,
        sub_category_id,
        name,
        picture,
        price,
        special_offer,
        description
    )
values (
        _store_id,
        _item_category_id,
        _item_sub_category_id,
        'McDonalds Burger',
        'https://www.koalahero.com/wp-content/uploads/2019/10/Makanan-McDonald.jpg',
        10000,
        9000,
        'McDonalds Burger'
    )
returning id into _item_id;

-- insert item_addon_categories
insert into item_addon_categories (
        item_id,
        name,
        description,
        is_multiple_choice
    )
values (
        _item_id,
        'Add on',
        'Makin enak tambah add on',
        true
    )
returning id into _addon_category_id;

-- insert item_addons
insert into item_addons (addon_category_id, name, price)
values (
        _addon_category_id,
        'Extra sauce Kari Spesial',
        5000
    )
returning id into _addon_id;

-- insert customers
insert into customers (
        full_name,
        phone,
        language_code
    )
values (
        'Rizal Hadiyansah',
        '08123456789',
        'en'
    )
returning id into _customer_id;

-- insert coupons
insert into coupons (
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
values (
        _store_account_id,
        'BREAK',
        'Coupon New Customer',
        'This coupon is for new customer from store Alpha Store',
        '2023-01-01',
        'percentage',
        10,
        0,
        20000,
        null,
        1,
        false,
        false,
        true
    )
returning id into _coupon_id;

-- insert coupon_customers
insert into coupon_customers (coupon_id, customer_id)
values (_coupon_id, _customer_id);

-- insert coupon_stores
insert into coupon_stores (coupon_id, store_id)
values (_coupon_id, _store_id);

-- insert orders
insert into orders (
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
values (
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
returning id into _order_id;

-- insert order_details
insert into order_details (
        order_id,
        item_id,
        item_name,
        quantity,
        price,
        total,
        picture,
        item_detail
    )
values (
        _order_id,
        _item_id,
        'McDonalds Burger',
        2,
        9000,
        28000,
        'https://www.koalahero.com/wp-content/uploads/2019/10/Makanan-McDonald.jpg',
        ''
    )
returning id into _order_detail_id;

-- insert order_detail_addons
insert into order_detail_addons (
        order_detail_id,
        addon_id,
        addon_name,
        price
    )
values (
        _order_detail_id,
        _addon_id,
        'Extra sauce Kari Spesial',
        5000
    );

end $$;

-- SELECT
-----------------------------
select *
from items i
where i.store_id = 'c3a5824a-9a85-4e76-9cc8-641b3fda4e85';

CREATE DATABASE db_name;

CREATE TABLE [IF NOT EXISTS] table_name (
    column1 datatype(length) column_contraint,
    column2 datatype(length) column_contraint,
    table_constraints
);