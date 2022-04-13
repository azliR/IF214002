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
  UNIQUE KEY `phone` (`phone`)
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
  PRIMARY KEY (`id`)
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
  PRIMARY KEY (`category_id`,`language_code`)
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
  PRIMARY KEY (`sub_category_id`,`language_code`)
);

