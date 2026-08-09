-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 17, 2026 at 08:13 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `romahkawensatu`
--

-- --------------------------------------------------------

--
-- Table structure for table `addon`
--

CREATE TABLE `addon` (
  `addon_id` int UNSIGNED NOT NULL,
  `addon_name` varchar(120) NOT NULL,
  `addon_type` varchar(50) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `selection_type` enum('toggle','quantity') NOT NULL DEFAULT 'toggle' COMMENT 'toggle = on/off switch; quantity = +/- stepper for multiples',
  `is_popular` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Set TRUE by nightly cron for top-N most-booked add-ons in last 30d',
  `max_per_booking` int UNSIGNED NOT NULL DEFAULT '1' COMMENT 'Maximum quantity allowed per booking (only used when selection_type=quantity)',
  `weekly_capacity` int UNSIGNED DEFAULT NULL COMMENT 'NULL = unlimited; else max units available per calendar week',
  `weekly_booked` int UNSIGNED NOT NULL DEFAULT '0' COMMENT 'How many units of this add-on are already booked this week (refreshed by cron)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `addon`
--

INSERT INTO `addon` (`addon_id`, `addon_name`, `addon_type`, `price`, `description`, `status`, `selection_type`, `is_popular`, `max_per_booking`, `weekly_capacity`, `weekly_booked`) VALUES
(1, 'Photographer', 'photography', '800.00', 'Professional photographer, 2 hours included', 'active', 'toggle', 1, 1, 5, 0),
(2, 'Makeup Artist', 'styling', '350.00', 'On-site makeup artist per session', 'active', 'toggle', 0, 1, 8, 0),
(3, 'Videographer', 'videography', '650.00', 'Videographer with highlight reel, 2 hours', 'active', 'toggle', 0, 1, NULL, 0),
(4, 'Hair Stylist', 'styling', '250.00', 'Professional hair styling for your session', 'active', 'toggle', 0, 1, 8, 0),
(5, 'Wardrobe Stylist', 'styling', '300.00', 'Wardrobe styling & outfit coordination', 'active', 'toggle', 0, 1, 8, 0),
(6, 'Balloon Decoration', 'decor', '400.00', 'Custom balloon arch & backdrop setup', 'active', 'toggle', 0, 1, NULL, 0),
(7, 'Flower Arrangement', 'decor', '350.00', 'Fresh flower bouquet & decorative arrangements', 'active', 'toggle', 0, 1, NULL, 0),
(8, 'Extra Lighting Set', 'equipment', '200.00', 'Additional studio lighting equipment', 'active', 'toggle', 0, 1, NULL, 0),
(9, 'Backdrop Extension', 'equipment', '250.00', 'Extra themed backdrop for variety in photos', 'active', 'toggle', 0, 1, NULL, 0),
(10, 'Drone Photography', 'digital', '500.00', 'Aerial drone shots & outdoor perspectives', 'active', 'toggle', 0, 1, NULL, 0),
(11, 'Same-Day Photo Edit', 'digital', '300.00', 'Receive edited photos on the same day', 'active', 'toggle', 0, 1, NULL, 0),
(12, 'Props Package', 'decor', '150.00', 'Curated selection of premium photo props', 'active', 'toggle', 0, 1, NULL, 0),
(13, 'Extra Hour', 'time', '120.00', 'Add an extra hour to your studio session', 'active', 'quantity', 0, 4, 20, 0);

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` int UNSIGNED NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `full_name` varchar(120) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `username`, `email`, `password_hash`, `full_name`, `phone_number`, `created_at`) VALUES
(1, 'admin', 'admin@romahkawensatu.com', '$2y$12$2IAfh8vEz3vPy/kbPOrjhuXx6BKJh4ZKu.izSd5JIvgbIMAfQmpfW', 'Studio Administrator', '012-3456789', '2026-06-23 18:56:33');

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `booking_id` int UNSIGNED NOT NULL,
  `customer_id` int UNSIGNED NOT NULL,
  `studio_id` int UNSIGNED NOT NULL,
  `booking_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `booking_status` enum('pending','confirmed','completed','cancelled') NOT NULL DEFAULT 'pending',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`booking_id`, `customer_id`, `studio_id`, `booking_date`, `start_time`, `end_time`, `total_price`, `booking_status`, `created_at`) VALUES
(1, 10, 5, '2026-07-18', '14:00:00', '16:00:00', '1650.00', 'confirmed', '2026-07-17 07:14:40'),
(2, 10, 7, '2026-07-31', '15:00:00', '19:00:00', '1550.00', 'confirmed', '2026-07-17 07:22:41'),
(3, 10, 7, '2026-07-30', '13:00:00', '15:00:00', '960.00', 'cancelled', '2026-07-17 07:40:02'),
(4, 10, 5, '2026-07-23', '17:00:00', '19:00:00', '650.00', 'completed', '2026-07-17 07:49:58'),
(5, 10, 2, '2026-07-29', '17:00:00', '19:00:00', '850.00', 'confirmed', '2026-07-17 08:02:48'),
(6, 10, 7, '2026-07-28', '16:00:00', '20:00:00', '1080.00', 'pending', '2026-07-17 08:11:21');

-- --------------------------------------------------------

--
-- Table structure for table `booking_addon`
--

CREATE TABLE `booking_addon` (
  `booking_id` int UNSIGNED NOT NULL,
  `addon_id` int UNSIGNED NOT NULL,
  `quantity` int UNSIGNED NOT NULL DEFAULT '1',
  `price_at_booking` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `booking_addon`
--

INSERT INTO `booking_addon` (`booking_id`, `addon_id`, `quantity`, `price_at_booking`) VALUES
(1, 3, 1, '650.00'),
(1, 5, 1, '300.00'),
(1, 8, 1, '200.00'),
(1, 11, 1, '300.00'),
(2, 3, 1, '650.00'),
(2, 5, 1, '300.00'),
(3, 11, 1, '300.00'),
(3, 13, 3, '120.00'),
(4, 11, 1, '300.00'),
(4, 12, 1, '150.00'),
(5, 7, 1, '350.00'),
(5, 8, 1, '200.00'),
(6, 13, 4, '120.00');

-- --------------------------------------------------------

--
-- Table structure for table `booking_bundle_discount`
--

CREATE TABLE `booking_bundle_discount` (
  `discount_id` int UNSIGNED NOT NULL,
  `booking_id` int UNSIGNED NOT NULL,
  `bundle_id` int UNSIGNED NOT NULL,
  `discount_amount` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bundle_offer`
--

CREATE TABLE `bundle_offer` (
  `bundle_id` int UNSIGNED NOT NULL,
  `addon_id_1` int UNSIGNED NOT NULL,
  `addon_id_2` int UNSIGNED NOT NULL,
  `discount_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `is_active` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `bundle_offer`
--

INSERT INTO `bundle_offer` (`bundle_id`, `addon_id_1`, `addon_id_2`, `discount_amount`, `is_active`, `created_at`) VALUES
(1, 1, 2, '100.00', 1, '2026-07-14 00:41:54');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` int UNSIGNED NOT NULL,
  `customer_name` varchar(120) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `customer_name`, `phone_number`, `email`, `created_at`) VALUES
(1, 'Aisyah Rahman', '011-2233445', 'aisyah@example.com', '2026-06-23 18:56:33'),
(2, 'Lim Wei Jie', '012-9988776', 'weijie@example.com', '2026-06-23 18:56:33'),
(3, 'Nurul Huda', '013-5566778', 'nurul@example.com', '2026-06-23 18:56:33'),
(4, 'sakinah', '01164414463', 'nsakinah633@gmail.com', '2026-06-25 02:22:34'),
(5, 'sakinah', '01164414463', '2024219102@student.uitm.edu.my', '2026-06-30 10:09:03'),
(6, 'husna', '012-2449030', 'abc@gmail.com', '2026-07-06 02:41:23'),
(7, 'aqiliz', '017-5694504', 'walala@gmail.com', '2026-07-06 05:23:20'),
(8, 'husna', '01164414463', 'husnaazahari03@gmail.com', '2026-07-06 06:53:05'),
(9, 'sakinah', '017-5694504', 'admin@romahkawensatu.com', '2026-07-06 06:53:58'),
(10, 'HUSNA', '012-2449030', 'nazieraidrus@gmail.com', '2026-07-08 20:29:21'),
(11, 'Guest', '000-0000000', NULL, '2026-07-09 08:55:16'),
(12, 'sarah', '013-8228838', 'sarah03@gmail.com', '2026-07-09 09:16:14'),
(13, 'kinah', '011-4778276', 'sakinah@gmail.com', '2026-07-09 10:11:24');

-- --------------------------------------------------------

--
-- Table structure for table `gallery`
--

CREATE TABLE `gallery` (
  `gallery_id` int UNSIGNED NOT NULL,
  `studio_id` int UNSIGNED NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `caption` varchar(200) DEFAULT NULL,
  `sort_order` int UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `gallery`
--

INSERT INTO `gallery` (`gallery_id`, `studio_id`, `image_path`, `caption`, `sort_order`) VALUES
(3, 2, 'img/gallery/3ce6562d65a0_1783945909.jpg', 'A warm, natural setting styled with beautiful rattan details.', 1),
(4, 3, 'img/gallery/d0b8776acfe5_1783944335.jpg', 'A cozy rustic space centered around a welcoming firepit.', 1),
(5, 4, 'img/gallery/728fce6ec3b6_1783944349.jpg', 'A nostalgic café-inspired setting with vintage character.', 1),
(6, 5, 'img/gallery/298dec578049_1783944366.png', 'A relaxed creative space with layered textiles, greenery, and earthy details.', 1),
(7, 6, 'img/gallery/a23f623dabc9_1783944408.jpg', 'A classic barbershop setting with timeless vintage details.', 1),
(8, 7, 'img/gallery/566d0409b951_1783944436.png', 'A calm minimalist space with natural wood, neutral tones, and clean styling', 1),
(12, 1, 'img/gallery/b224c19eb33a_1784013794.jpg', NULL, 0),
(16, 7, 'img/gallery/1780a1177f5b_1784127592.png', '', 0),
(17, 7, 'img/gallery/82f92889821b_1784127688.png', '', 0),
(18, 7, 'img/gallery/8737bce4b8e8_1784127878.png', '', 0),
(19, 5, 'img/gallery/d8a63cb49053_1784129629.png', '', 0),
(20, 1, 'img/gallery/1240511d80a6_1784129845.png', '', 0),
(21, 1, 'img/gallery/1a0bd9415a3a_1784130030.png', '', 0),
(22, 2, 'img/gallery/49bf1f0ef10f_1784130684.png', '', 0),
(23, 3, 'img/gallery/8c337e1b0c94_1784139717.jpg', '', 0),
(24, 3, 'img/gallery/e72c91c4198e_1784139739.jpg', '', 0),
(25, 4, 'img/gallery/ea9820682e82_1784139766.jpg', '', 0),
(26, 4, 'img/gallery/dc06d0bbc697_1784139800.jpg', '', 0),
(27, 6, 'img/gallery/2f5d725126ae_1784139871.jpg', '', 0),
(28, 2, 'img/gallery/d95f0969c500_1784141067.jpg', '', 0),
(29, 2, 'img/gallery/e274b7f88814_1784141091.jpg', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `payment_id` int UNSIGNED NOT NULL,
  `booking_id` int UNSIGNED NOT NULL,
  `payment_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `amount` decimal(10,2) NOT NULL,
  `payment_method` varchar(50) NOT NULL,
  `gateway_reference` varchar(100) DEFAULT NULL,
  `receipt_path` varchar(255) DEFAULT NULL,
  `payment_status` enum('pending','paid','failed','refunded') NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`payment_id`, `booking_id`, `payment_date`, `amount`, `payment_method`, `gateway_reference`, `receipt_path`, `payment_status`) VALUES
(1, 1, '2026-07-17 07:14:40', '1650.00', 'ToyyibPay', NULL, NULL, 'paid'),
(2, 2, '2026-07-17 07:22:41', '1550.00', 'ToyyibPay', NULL, NULL, 'paid'),
(3, 3, '2026-07-17 07:40:02', '960.00', 'ToyyibPay', 'ysu03x3l', NULL, 'pending'),
(4, 4, '2026-07-17 07:49:58', '650.00', 'ToyyibPay', '71o7po4e', NULL, 'pending'),
(5, 5, '2026-07-17 08:02:48', '850.00', 'ToyyibPay', NULL, NULL, 'paid'),
(6, 6, '2026-07-17 08:11:21', '1080.00', 'ToyyibPay', '7j2e3bde', NULL, 'pending');

-- --------------------------------------------------------

--
-- Table structure for table `studio`
--

CREATE TABLE `studio` (
  `studio_id` int UNSIGNED NOT NULL,
  `studio_name` varchar(120) NOT NULL,
  `capacity` int UNSIGNED DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `hourly_rate` decimal(10,2) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `status` enum('active','inactive','maintenance') NOT NULL DEFAULT 'active',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `studio`
--

INSERT INTO `studio` (`studio_id`, `studio_name`, `capacity`, `description`, `hourly_rate`, `image`, `status`, `created_at`) VALUES
(1, 'Harry Potter Library', 8, 'Antique library, warm wood, tall shelves', '150.00', 'img/harry.jpg', 'active', '2026-06-23 18:56:33'),
(2, 'Rattan Studio', 6, 'Woven rattan, natural light, airy', '150.00', 'img/rattan.jpg', 'active', '2026-06-23 18:56:33'),
(3, 'Firepit Studio', 6, 'Cozy hearth, rustic textures', '150.00', 'img/firepit.jpg', 'active', '2026-06-23 18:56:33'),
(4, 'Retro Cafe Studio', 8, 'Vintage diner, retro signage', '180.00', 'img/retrocafe.jpg', 'active', '2026-06-23 18:56:33'),
(5, 'Bohemian Studio', 6, 'Eclectic textiles, plants, earthy tones', '100.00', 'img/bohemian.jpg', 'active', '2026-06-23 18:56:33'),
(6, 'Barber Studio', 4, 'Classic barbershop, leather & chrome', '150.00', 'img/barber.jpg', 'active', '2026-06-23 18:56:33'),
(7, 'Muji Studio', 7, 'Minimal, neutral, clean lines', '150.00', 'img/muji.jpg', 'active', '2026-06-23 18:56:33');

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_booking_details`
-- (See below for the actual view)
--
CREATE TABLE `v_booking_details` (
`booking_date` date
,`booking_id` int unsigned
,`booking_status` enum('pending','confirmed','completed','cancelled')
,`customer_name` varchar(120)
,`email` varchar(150)
,`end_time` time
,`hourly_rate` decimal(10,2)
,`payment_method` varchar(50)
,`payment_status` enum('pending','paid','failed','refunded')
,`phone_number` varchar(20)
,`start_time` time
,`studio_name` varchar(120)
,`total_price` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Structure for view `v_booking_details`
--
DROP TABLE IF EXISTS `v_booking_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_booking_details`  AS SELECT `b`.`booking_id` AS `booking_id`, `b`.`booking_date` AS `booking_date`, `b`.`start_time` AS `start_time`, `b`.`end_time` AS `end_time`, `b`.`total_price` AS `total_price`, `b`.`booking_status` AS `booking_status`, `c`.`customer_name` AS `customer_name`, `c`.`phone_number` AS `phone_number`, `c`.`email` AS `email`, `s`.`studio_name` AS `studio_name`, `s`.`hourly_rate` AS `hourly_rate`, `p`.`payment_status` AS `payment_status`, `p`.`payment_method` AS `payment_method` FROM (((`booking` `b` join `customer` `c` on((`c`.`customer_id` = `b`.`customer_id`))) join `studio` `s` on((`s`.`studio_id` = `b`.`studio_id`))) left join `payment` `p` on((`p`.`booking_id` = `b`.`booking_id`)))  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addon`
--
ALTER TABLE `addon`
  ADD PRIMARY KEY (`addon_id`);

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `idx_booking_slot` (`studio_id`,`booking_date`),
  ADD KEY `idx_booking_customer` (`customer_id`),
  ADD KEY `idx_booking_status` (`booking_status`);

--
-- Indexes for table `booking_addon`
--
ALTER TABLE `booking_addon`
  ADD PRIMARY KEY (`booking_id`,`addon_id`),
  ADD KEY `fk_ba_addon` (`addon_id`);

--
-- Indexes for table `booking_bundle_discount`
--
ALTER TABLE `booking_bundle_discount`
  ADD PRIMARY KEY (`discount_id`),
  ADD KEY `fk_bbd_bundle` (`bundle_id`),
  ADD KEY `idx_bbd_booking` (`booking_id`);

--
-- Indexes for table `bundle_offer`
--
ALTER TABLE `bundle_offer`
  ADD PRIMARY KEY (`bundle_id`),
  ADD KEY `fk_bundle_a1` (`addon_id_1`),
  ADD KEY `fk_bundle_a2` (`addon_id_2`),
  ADD KEY `idx_bundle_active` (`is_active`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`),
  ADD KEY `idx_customer_email` (`email`),
  ADD KEY `idx_customer_phone` (`phone_number`);

--
-- Indexes for table `gallery`
--
ALTER TABLE `gallery`
  ADD PRIMARY KEY (`gallery_id`),
  ADD KEY `idx_gallery_studio` (`studio_id`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `idx_payment_booking` (`booking_id`);

--
-- Indexes for table `studio`
--
ALTER TABLE `studio`
  ADD PRIMARY KEY (`studio_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addon`
--
ALTER TABLE `addon`
  MODIFY `addon_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `admin_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `booking_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `booking_bundle_discount`
--
ALTER TABLE `booking_bundle_discount`
  MODIFY `discount_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `bundle_offer`
--
ALTER TABLE `bundle_offer`
  MODIFY `bundle_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `gallery`
--
ALTER TABLE `gallery`
  MODIFY `gallery_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `payment_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `studio`
--
ALTER TABLE `studio`
  MODIFY `studio_id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `fk_booking_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_booking_studio` FOREIGN KEY (`studio_id`) REFERENCES `studio` (`studio_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `booking_addon`
--
ALTER TABLE `booking_addon`
  ADD CONSTRAINT `fk_ba_addon` FOREIGN KEY (`addon_id`) REFERENCES `addon` (`addon_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_ba_booking` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`booking_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `booking_bundle_discount`
--
ALTER TABLE `booking_bundle_discount`
  ADD CONSTRAINT `fk_bbd_booking` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`booking_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_bbd_bundle` FOREIGN KEY (`bundle_id`) REFERENCES `bundle_offer` (`bundle_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

--
-- Constraints for table `bundle_offer`
--
ALTER TABLE `bundle_offer`
  ADD CONSTRAINT `fk_bundle_a1` FOREIGN KEY (`addon_id_1`) REFERENCES `addon` (`addon_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_bundle_a2` FOREIGN KEY (`addon_id_2`) REFERENCES `addon` (`addon_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `gallery`
--
ALTER TABLE `gallery`
  ADD CONSTRAINT `fk_gallery_studio` FOREIGN KEY (`studio_id`) REFERENCES `studio` (`studio_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `fk_payment_booking` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`booking_id`) ON DELETE RESTRICT ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
