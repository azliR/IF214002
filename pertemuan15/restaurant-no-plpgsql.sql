--
--
-- SELECT
--
-- Home
--
-- Get Nearby Store (Example, lat: -6.938068, lng: 107.7006738)
SELECT nearby_stores.*,
    postcodes.city,
    postcodes.state,
    postcodes.country
FROM (
        SELECT *,
            (
                6371 * acos(
                    cos(radians(-6.938068)) * cos(radians(latitude)) * cos(
                        radians(longitude) - radians(107.7006738)
                    ) + sin(radians(-6.938068)) * sin(radians(latitude))
                )
            ) AS distance
        FROM stores
    ) nearby_stores
    LEFT JOIN postcodes ON nearby_stores.postcode = postcodes.postcode
WHERE distance <= 5
ORDER BY distance
LIMIT 10;

-- Get Nearby Items with Special Offers (-6.938068, 107.7006738)
SELECT items.*,
    nearby_stores.distance
FROM (
        SELECT *,
            (
                6371 * acos(
                    cos(radians(-6.938068)) * cos(radians(latitude)) * cos(
                        radians(longitude) - radians(107.7006738)
                    ) + sin(radians(-6.938068)) * sin(radians(latitude))
                )
            ) AS distance
        FROM stores
    ) nearby_stores,
    items
WHERE nearby_stores.distance <= 5
    AND items.store_id = nearby_stores.id
    AND items.special_offer IS NOT NULL
ORDER BY distance
LIMIT 10;

--
-- Store
--
-- Get Store by Id
SELECT stores.*,
    postcodes.city,
    postcodes.state,
    postcodes.country
FROM stores
    JOIN postcodes ON stores.postcode = postcodes.postcode
WHERE stores.id = '93ab578c-46fa-42f6-b61f-ef13fe13045d';

--
-- Items
--
-- Get Item by Id
SELECT *
FROM items
WHERE id = '7b1c8c31-4a0f-4457-8c71-8f06631aa9ae';

-- Get Items by Store Id and Sub Category Id
SELECT *
FROM items
WHERE store_id = '93ab578c-46fa-42f6-b61f-ef13fe13045d'
    AND (
        CASE
            WHEN 'db126848-5a16-4723-bcb1-524695a0d286' IS NOT NULL THEN sub_category_id = 'db126848-5a16-4723-bcb1-524695a0d286'
            ELSE TRUE
        END
    )
ORDER BY (
        CASE
            WHEN special_offer IS NOT NULL THEN special_offer
            ELSE price
        END
    )
LIMIT 10 OFFSET 0;

-- Add ons
--
-- Get Addon Categories by Item ID
SELECT *
FROM item_addon_categories
WHERE item_id = '7b1c8c31-4a0f-4457-8c71-8f06631aa9ae'
ORDER BY is_multiple_choice,
    name;

-- Get Addons by Addon Category ID
SELECT *
FROM item_addons
WHERE addon_category_id IN (
        '17b3be90-d177-4e59-8582-cf6c97f94aa9',
        '17b3be90-d177-4e59-8582-cf6c97f94aa8'
    )
ORDER BY price;

-- Categories
--
-- Get Categories Have Items with language code (Example, language_code: id)
SELECT item_categories.id,
    item_category_l10ns.language_code,
    item_categories.name,
    item_category_l10ns.name AS translated_name
FROM item_categories
    LEFT JOIN item_category_l10ns ON item_categories.id = item_category_l10ns.category_id
    AND item_category_l10ns.language_code = 'id'
WHERE (
        SELECT COUNT(*)
        FROM items
        WHERE items.category_id = item_categories.id
    ) > 0
ORDER BY (
        CASE
            WHEN item_category_l10ns.name IS NOT NULL THEN item_category_l10ns.name
            ELSE item_categories.name
        END
    )
LIMIT 10 OFFSET 0;

-- Get Sub Categories Have Items with language code (Example, language_code: id)
SELECT item_sub_categories.id,
    item_sub_category_l10ns.language_code,
    item_sub_categories.name,
    item_sub_category_l10ns.name AS translated_name
FROM item_sub_categories
    LEFT JOIN item_sub_category_l10ns ON item_sub_categories.id = item_sub_category_l10ns.sub_category_id
    AND item_sub_category_l10ns.language_code = 'id'
WHERE item_sub_categories.store_id = '93ab578c-46fa-42f6-b61f-ef13fe13045d'
    AND (
        SELECT COUNT(*)
        FROM items
        WHERE items.sub_category_id = item_sub_categories.id
    ) > 0
ORDER BY (
        CASE
            WHEN item_sub_category_l10ns.name IS NOT NULL THEN item_sub_category_l10ns.name
            ELSE item_sub_categories.name
        END
    )
LIMIT 10 OFFSET 0;

--
-- Orders
--
-- Get Order by Id
SELECT *
FROM orders
WHERE id = 'd0dc6416-d1cb-4e4c-b5d0-3af7b176fb4c';

-- Get Order Detail
SELECT *
FROM order_details
WHERE order_id = 'd0dc6416-d1cb-4e4c-b5d0-3af7b176fb4c';

-- Get Orders by Customers ID
SELECT orders.*,
    COUNT(order_details) AS total_item
FROM orders
    LEFT JOIN order_details ON orders.id = order_details.order_id
WHERE customer_id = '1c7b3156-986b-487b-8d6c-2db03806ca30'
GROUP BY orders.id
ORDER BY created_at DESC
LIMIT 10 OFFSET 0;

-- Coupons
--
-- Get Coupon by Coupon Code and Store ID
SELECT *
FROM coupons,
    coupon_stores
WHERE coupons.coupon_code = 'BREAK'
    AND coupons.is_valid = TRUE
    AND coupon_stores.coupon_id = coupons.id
    AND coupon_stores.store_id = '93ab578c-46fa-42f6-b61f-ef13fe13045d';

-- Get Coupon by Store Id
SELECT coupons.*
FROM coupons,
    coupon_stores
WHERE coupon_stores.store_id = '93ab578c-46fa-42f6-b61f-ef13fe13045d'
LIMIT 10 OFFSET 0;

-- Get Coupon by Store Id Ordered by Highest Discount (Example, total)
SELECT coupons.*
FROM coupons,
    coupon_stores
WHERE coupon_stores.store_id = '93ab578c-46fa-42f6-b61f-ef13fe13045d'
ORDER BY discount DESC
LIMIT 10 OFFSET 0;

-- Get Coupon by Customer ID Ordered by Expiry Date
SELECT coupons.*
FROM coupons,
    coupon_customers
WHERE coupon_customers.customer_id = '1c7b3156-986b-487b-8d6c-2db03806ca30'
    AND coupons.id = coupon_customers.coupon_id
ORDER BY coupons.expiry_date
LIMIT 10 OFFSET 0;

-- Reservation Table
--
-- Get reservation table by Store ID
SELECT reservation_tables.*,
    (
        SELECT COUNT(orders) AS total_person
        FROM orders,
            reservation_tables
        WHERE orders.table_id = reservation_tables.id
            AND (
                orders.order_type = 'now'
                OR (
                    orders.order_type = 'scheduled'
                    AND orders.scheduled_at >= NOW()
                )
            )
            AND (
                orders.status = 'pending'
                OR orders.status = 'preparing'
            )
            AND orders.table_person < reservation_tables.max_person
    ) AS total_person
FROM reservation_tables
WHERE reservation_tables.store_id = '93ab578c-46fa-42f6-b61f-ef13fe13045d'
ORDER BY name;

--
-- Statistics
--
-- Statistic item sales trends in a week group by item
SELECT DATE_TRUNC('day', orders.created_at) AS date,
    items.id,
    items.name,
    SUM(order_details.quantity) AS total_sales
FROM items,
    order_details,
    orders
WHERE items.id = order_details.item_id
    AND order_details.order_id = orders.id
    AND orders.status = 'complete'
    AND orders.store_id = '93ab578c-46fa-42f6-b61f-ef13fe13045d'
    AND orders.created_at >= NOW() - INTERVAL '7 days'
GROUP BY date,
    items.id
ORDER BY total_sales DESC;

-- Statistic profit in a week
SELECT DATE_TRUNC('day', orders.created_at) AS date,
    SUM(orders.netto) AS total_profit
FROM items,
    order_details,
    orders
WHERE items.id = order_details.item_id
    AND order_details.order_id = orders.id
    AND orders.status = 'complete'
    AND orders.store_id = '93ab578c-46fa-42f6-b61f-ef13fe13045d'
    AND orders.created_at >= NOW() - INTERVAL '7 days'
GROUP BY date
ORDER BY total_profit DESC;

-- Statistic item sales trends in a week
SELECT DATE_TRUNC('day', orders.created_at) AS date,
    SUM(order_details.quantity) AS total_item
FROM orders,
    order_details
WHERE orders.id = order_details.order_id
    AND orders.store_id = '93ab578c-46fa-42f6-b61f-ef13fe13045d'
    AND orders.status = 'complete'
    AND orders.created_at >= NOW() - INTERVAL '7 days'
GROUP BY date
ORDER BY date;

-- Order trends in a week
SELECT DATE_TRUNC('day', orders.created_at) AS date,
    COUNT(orders.id) AS total_order
FROM orders
WHERE orders.store_id = '93ab578c-46fa-42f6-b61f-ef13fe13045d'
    AND orders.created_at >= NOW() - INTERVAL '7 days'
GROUP BY date
ORDER BY date;

--
--
-- Busy Strore
SELECT nearby_stores.id,
    nearby_stores.name,
    nearby_stores.distance,
    (
        SELECT COUNT(orders.*) AS order_queue
        FROM orders
        WHERE orders.store_id = nearby_stores.id
            AND (
                orders.status = 'pending'
                OR orders.status = 'preparing'
            )
    )
FROM (
        SELECT *,
            (
                6371 * acos(
                    cos(radians(-6.938068)) * cos(radians(latitude)) * cos(
                        radians(longitude) - radians(107.7006738)
                    ) + sin(radians(-6.938068)) * sin(radians(latitude))
                )
            ) AS distance
        FROM stores
    ) nearby_stores
WHERE distance <= 5
ORDER BY order_queue
LIMIT 10;