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