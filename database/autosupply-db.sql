-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: mysql
-- Generation Time: Nov 06, 2026 at 08:20 AM
-- Server version: 8.4.11
-- PHP Version: 8.3.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `laravel`
--

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `grade_id` bigint UNSIGNED NOT NULL,
  `table_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `record_id` bigint UNSIGNED DEFAULT NULL,
  `column_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `old_value` text COLLATE utf8mb4_unicode_ci,
  `new_value` text COLLATE utf8mb4_unicode_ci,
  `changed_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `changed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `audit_logs`
--

INSERT INTO `audit_logs` (`grade_id`, `table_name`, `action`, `record_id`, `column_name`, `old_value`, `new_value`, `changed_by`, `changed_at`, `created_at`, `updated_at`) VALUES
(1, 'products', 'INITIAL_SEED', NULL, NULL, NULL, 'Seeded initial product catalog and past transaction history', 'System', '2026-09-10 08:21:17', '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(2, 'products', 'POS_SALE', 10, 'quantity', '140', '139', 'Jared Abellera', '2026-09-10 08:22:00', '2026-09-10 08:22:00', '2026-09-10 08:22:00'),
(3, 'products', 'POS_SALE', 1, 'quantity', '45', '44', 'Jared Abellera', '2026-09-10 09:15:48', '2026-09-10 09:15:48', '2026-09-10 09:15:48'),
(4, 'products', 'POS_SALE', 10, 'quantity', '139', '138', 'Jared Abellera', '2026-09-10 09:15:48', '2026-09-10 09:15:48', '2026-09-10 09:15:48'),
(5, 'products', 'POS_SALE', 9, 'quantity', '180', '179', 'Jared Abellera', '2026-09-10 09:15:48', '2026-09-10 09:15:48', '2026-09-10 09:15:48'),
(6, 'products', 'UPDATE', 12, 'details', '{\"product_name\":\"Spark Plug\",\"brand\":\"NGK\",\"price\":\"320.00\",\"quantity\":26,\"location\":\"Shelf D-2\"}', '{\"product_name\":\"Spark Plug\",\"brand\":\"NGK\",\"price\":\"320.00\",\"quantity\":26,\"location\":\"Shelf D-2\"}', 'Jared Abellera', '2026-09-10 09:16:04', '2026-09-10 09:16:04', '2026-09-10 09:16:04'),
(7, 'products', 'UPDATE', 12, 'details', '{\"product_name\":\"Spark Plug\",\"brand\":\"NGK\",\"price\":\"320.00\",\"quantity\":26,\"location\":\"Shelf D-2\"}', '{\"product_name\":\"Spark Plug\",\"brand\":\"NGK\",\"price\":\"320.00\",\"quantity\":26,\"location\":\"Shelf D-2\"}', 'Jared Abellera', '2026-09-10 09:17:43', '2026-09-10 09:17:43', '2026-09-10 09:17:43'),
(8, 'products', 'DELETE', 125, NULL, '{\"product_name\":\"Sandpaper\",\"brand\":\"Hippo\",\"price\":\"20.00\",\"quantity\":100}', NULL, 'Jared Abellera', '2026-09-11 02:47:19', '2026-09-11 02:47:19', '2026-09-11 02:47:19'),
(9, 'products', 'DELETE', 124, NULL, '{\"product_name\":\"Sandpaper\",\"brand\":\"Hippo\",\"price\":\"20.00\",\"quantity\":100}', NULL, 'Jared Abellera', '2026-09-11 02:47:29', '2026-09-11 02:47:29', '2026-09-11 02:47:29'),
(10, 'products', 'POS_SALE', 88, 'quantity', '6', '5', 'Jared Abellera', '2026-09-11 02:59:35', '2026-09-11 02:59:35', '2026-09-11 02:59:35'),
(11, 'products', 'POS_SALE', 123, 'quantity', '245', '243', 'Jared Abellera', '2026-09-11 02:59:35', '2026-09-11 02:59:35', '2026-09-11 02:59:35'),
(12, 'products', 'POS_SALE', 85, 'quantity', '30', '28', 'Jared Abellera', '2026-09-11 02:59:35', '2026-09-11 02:59:35', '2026-09-11 02:59:35'),
(13, 'products', 'POS_SALE', 52, 'quantity', '10', '9', 'Jared Abellera', '2026-09-11 03:00:08', '2026-09-11 03:00:08', '2026-09-11 03:00:08'),
(14, 'products', 'POS_SALE', 54, 'quantity', '10', '9', 'Jared Abellera', '2026-09-11 03:00:08', '2026-09-11 03:00:08', '2026-09-11 03:00:08'),
(15, 'products', 'RESTOCK', 116, 'quantity', '5', '15', 'Jared Abellera', '2026-09-11 03:00:38', '2026-09-11 03:00:38', '2026-09-11 03:00:38'),
(16, 'products', 'RESTOCK', 117, 'quantity', '5', '15', 'Jared Abellera', '2026-09-11 03:00:41', '2026-09-11 03:00:41', '2026-09-11 03:00:41'),
(17, 'products', 'UPDATE', 126, 'details', '{\"product_name\":\"Sandpaper\",\"brand\":\"Hippo\",\"price\":\"20.00\",\"quantity\":96,\"location\":\"Shelf C5\"}', '{\"product_name\":\"Sandpaper\",\"brand\":\"Hippo\",\"price\":\"20.00\",\"quantity\":96,\"location\":\"Shelf C5\"}', 'Jared Abellera', '2026-09-11 03:06:46', '2026-09-11 03:06:46', '2026-09-11 03:06:46'),
(18, 'products', 'POS_SALE', 85, 'quantity', '28', '27', 'Jared Abellera', '2026-09-11 03:17:17', '2026-09-11 03:17:17', '2026-09-11 03:17:17'),
(19, 'products', 'POS_SALE', 44, 'quantity', '10', '9', 'Jared Abellera', '2026-09-11 03:17:17', '2026-09-11 03:17:17', '2026-09-11 03:17:17'),
(20, 'products', 'POS_SALE', 45, 'quantity', '10', '9', 'Jared Abellera', '2026-09-11 03:17:17', '2026-09-11 03:17:17', '2026-09-11 03:17:17'),
(21, 'products', 'CREATE', 127, NULL, NULL, '{\"product_name\":\"Spark Plug\",\"brand\":\"NGK\",\"price\":\"200.00\",\"quantity\":10}', 'Jared Abellera', '2026-10-18 11:43:20', '2026-10-18 11:43:20', '2026-10-18 11:43:20'),
(22, 'products', 'POS_SALE', 57, 'quantity', '10', '9', 'Jared Abellera', '2026-10-18 11:43:52', '2026-10-18 11:43:52', '2026-10-18 11:43:52'),
(23, 'products', 'POS_SALE', 58, 'quantity', '10', '9', 'Jared Abellera', '2026-10-18 11:43:52', '2026-10-18 11:43:52', '2026-10-18 11:43:52'),
(24, 'products', 'POS_SALE', 61, 'quantity', '10', '8', 'Jared Abellera', '2026-10-18 11:43:52', '2026-10-18 11:43:52', '2026-10-18 11:43:52'),
(25, 'products', 'POS_SALE', 88, 'quantity', '5', '4', 'Jared Abellera', '2026-10-18 12:28:23', '2026-10-18 12:28:23', '2026-10-18 12:28:23'),
(26, 'products', 'POS_SALE', 85, 'quantity', '27', '26', 'Jared Abellera', '2026-10-18 13:05:35', '2026-10-18 13:05:35', '2026-10-18 13:05:35'),
(27, 'products', 'POS_SALE', 47, 'quantity', '10', '1', 'Jared Abellera', '2026-10-18 13:05:35', '2026-10-18 13:05:35', '2026-10-18 13:05:35'),
(28, 'products', 'POS_SALE', 48, 'quantity', '7', '6', 'Jared Abellera', '2026-10-18 13:05:35', '2026-10-18 13:05:35', '2026-10-18 13:05:35'),
(29, 'products', 'POS_SALE', 50, 'quantity', '10', '9', 'Jared Abellera', '2026-10-18 13:27:41', '2026-10-18 13:27:41', '2026-10-18 13:27:41'),
(30, 'products', 'POS_SALE', 59, 'quantity', '10', '9', 'Jared Abellera', '2026-10-18 13:27:41', '2026-10-18 13:27:41', '2026-10-18 13:27:41'),
(31, 'products', 'POS_SALE', 60, 'quantity', '10', '8', 'Jared Abellera', '2026-10-18 13:27:41', '2026-10-18 13:27:41', '2026-10-18 13:27:41'),
(32, 'products', 'POS_SALE', 6, 'quantity', '15', '14', 'Jared Abellera', '2026-10-18 13:27:41', '2026-10-18 13:27:41', '2026-10-18 13:27:41'),
(33, 'products', 'POS_SALE', 7, 'quantity', '15', '14', 'Jared Abellera', '2026-10-18 13:27:41', '2026-10-18 13:27:41', '2026-10-18 13:27:41'),
(34, 'products', 'POS_SALE', 16, 'quantity', '15', '14', 'Jared Abellera', '2026-10-18 13:27:41', '2026-10-18 13:27:41', '2026-10-18 13:27:41'),
(35, 'products', 'POS_SALE', 82, 'quantity', '30', '24', 'Jared Abellera', '2026-11-06 02:44:47', '2026-11-06 02:44:47', '2026-11-06 02:44:47'),
(36, 'products', 'POS_SALE', 85, 'quantity', '26', '25', 'Jared Abellera', '2026-11-06 02:44:47', '2026-11-06 02:44:47', '2026-11-06 02:44:47'),
(37, 'products', 'CREATE', 128, NULL, NULL, '{\"product_name\":\"Paper\",\"brand\":\"NGK\",\"price\":\"12.00\",\"quantity\":10}', 'Jared Abellera', '2026-11-06 02:47:26', '2026-11-06 02:47:26', '2026-11-06 02:47:26'),
(38, 'products', 'DELETE', 128, NULL, '{\"product_name\":\"Paper\",\"brand\":\"NGK\",\"price\":\"12.00\",\"quantity\":10}', NULL, 'Jared Abellera', '2026-11-06 02:47:29', '2026-11-06 02:47:29', '2026-11-06 02:47:29'),
(39, 'products', 'RESTOCK', 127, 'quantity', '10', '110', 'Jared Abellera', '2026-11-06 02:47:40', '2026-11-06 02:47:40', '2026-11-06 02:47:40'),
(40, 'products', 'CREATE', 129, NULL, NULL, '{\"product_name\":\"Paper\",\"brand\":\"Hippo\",\"price\":\"100.00\",\"quantity\":100}', 'Jared Abellera', '2026-11-06 03:05:11', '2026-11-06 03:05:11', '2026-11-06 03:05:11'),
(41, 'products', 'UPDATE', 129, 'details', '{\"product_name\":\"Paper\",\"brand\":\"Hippo\",\"price\":\"100.00\",\"quantity\":100,\"location\":\"Shelf D-2\"}', '{\"product_name\":\"Paper\",\"brand\":\"Hippo\",\"price\":\"100.00\",\"quantity\":100,\"location\":\"Shelf D-2\"}', 'Jared Abellera', '2026-11-06 03:05:37', '2026-11-06 03:05:37', '2026-11-06 03:05:37');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('joy-jeffrey-auto-supply-cache-admin|192.168.65.1', 'i:1;', 1792329887),
('joy-jeffrey-auto-supply-cache-admin|192.168.65.1:timer', 'i:1792329887;', 1792329887),
('joy-jeffrey-auto-supply-cache-jared|192.168.65.1', 'i:1;', 1793951543),
('joy-jeffrey-auto-supply-cache-jared|192.168.65.1:timer', 'i:1793951543;', 1793951543),
('joy-jeffrey-auto-supply-cache-jaredjared|192.168.65.1', 'i:2;', 1789028581),
('joy-jeffrey-auto-supply-cache-jaredjared|192.168.65.1:timer', 'i:1789028581;', 1789028581),
('joy-jeffrey-auto-supply-cache-jaredjaredjared|192.168.65.1', 'i:1;', 1789028595),
('joy-jeffrey-auto-supply-cache-jaredjaredjared|192.168.65.1:timer', 'i:1789028595;', 1789028595);

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `invoice_id` bigint UNSIGNED NOT NULL,
  `invoice_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_sales` decimal(10,2) NOT NULL DEFAULT '0.00',
  `customer_payment` decimal(10,2) NOT NULL DEFAULT '0.00',
  `customer_change` decimal(10,2) NOT NULL DEFAULT '0.00',
  `date` date NOT NULL,
  `time` time NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `invoices`
--

INSERT INTO `invoices` (`invoice_id`, `invoice_number`, `total_sales`, `customer_payment`, `customer_change`, `date`, `time`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'INV-20260904-001', 560.00, 600.00, 40.00, '2026-09-04', '15:30:00', 1, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(2, 'INV-20260904-002', 840.00, 900.00, 60.00, '2026-09-04', '13:44:00', 1, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(3, 'INV-20260904-003', 365.00, 400.00, 35.00, '2026-09-04', '12:22:00', 1, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(4, 'INV-20260904-004', 995.00, 1000.00, 5.00, '2026-09-04', '16:49:00', 1, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(5, 'INV-20260905-001', 250.00, 300.00, 50.00, '2026-09-05', '12:08:00', 1, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(6, 'INV-20260905-002', 645.00, 700.00, 55.00, '2026-09-05', '11:42:00', 1, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(7, 'INV-20260905-003', 380.00, 400.00, 20.00, '2026-09-05', '11:33:00', 1, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(8, 'INV-20260906-001', 1920.00, 2000.00, 80.00, '2026-09-06', '16:58:00', 1, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(9, 'INV-20260906-002', 250.00, 300.00, 50.00, '2026-09-06', '13:54:00', 1, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(10, 'INV-20260907-001', 6390.00, 6400.00, 10.00, '2026-09-07', '11:55:00', 1, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(11, 'INV-20260907-002', 2190.00, 2200.00, 10.00, '2026-09-07', '17:57:00', 1, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(12, 'INV-20260907-003', 75.00, 100.00, 25.00, '2026-09-07', '15:19:00', 1, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(13, 'INV-20260907-004', 480.00, 500.00, 20.00, '2026-09-07', '14:38:00', 1, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(14, 'INV-20260908-001', 1835.00, 1900.00, 65.00, '2026-09-08', '17:22:00', 1, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(15, 'INV-20260908-002', 840.00, 900.00, 60.00, '2026-09-08', '14:19:00', 1, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(16, 'INV-20260908-003', 2925.00, 3000.00, 75.00, '2026-09-08', '17:32:00', 1, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(17, 'INV-20260909-001', 600.00, 600.00, 0.00, '2026-09-09', '11:35:00', 1, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(18, 'INV-20260909-002', 4060.00, 4100.00, 40.00, '2026-09-09', '14:11:00', 1, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(19, 'INV-20260910-001', 1080.00, 1500.00, 420.00, '2026-09-10', '09:15:00', 1, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(20, 'INV-20260910-002', 1050.00, 1500.00, 450.00, '2026-09-10', '11:30:00', 1, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(21, 'INV-20260910-003', 2410.00, 2500.00, 90.00, '2026-09-10', '13:45:00', 1, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(22, 'INV-20260910-004', 820.00, 1000.00, 180.00, '2026-09-10', '15:20:00', 1, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(23, 'INV-20260910-E3AA', 25.00, 1000.00, 975.00, '2026-09-10', '08:22:00', 1, '2026-09-10 08:22:00', '2026-09-10 08:22:00'),
(24, 'INV-20260910-CC90', 285.00, 285.00, 0.00, '2026-09-10', '09:15:48', 1, '2026-09-10 09:15:48', '2026-09-10 09:15:48'),
(25, 'INV-20260911-8E54', 690.00, 1000.00, 310.00, '2026-09-11', '02:59:35', 1, '2026-09-11 02:59:35', '2026-09-11 02:59:35'),
(26, 'INV-20260911-D08F', 320.00, 500.00, 180.00, '2026-09-11', '03:00:08', 1, '2026-09-11 03:00:08', '2026-09-11 03:00:08'),
(27, 'INV-20260911-A7AC', 320.00, 320.00, 0.00, '2026-09-11', '03:17:17', 1, '2026-09-11 03:17:17', '2026-09-11 03:17:17'),
(28, 'INV-20261018-487B', 620.00, 1000.00, 380.00, '2026-10-18', '11:43:52', 1, '2026-10-18 11:43:52', '2026-10-18 11:43:52'),
(29, 'INV-20261018-9581', 450.00, 1000.00, 550.00, '2026-10-18', '12:28:23', 1, '2026-10-18 12:28:23', '2026-10-18 12:28:23'),
(30, 'INV-20261018-D8B3', 1570.00, 1700.00, 130.00, '2026-10-18', '13:05:35', 1, '2026-10-18 13:05:35', '2026-10-18 13:05:35'),
(31, 'INV-20261018-2DB3', 1215.00, 2000.00, 785.00, '2026-10-18', '13:27:41', 1, '2026-10-18 13:27:41', '2026-10-18 13:27:41'),
(32, 'INV-20261106-6993', 350.00, 1000.00, 650.00, '2026-11-06', '02:44:47', 1, '2026-11-06 02:44:47', '2026-11-06 02:44:47');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` smallint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(10, '0001_01_01_000000_create_users_table', 1),
(11, '0001_01_01_000001_create_cache_table', 1),
(12, '0001_01_01_000002_create_jobs_table', 1),
(13, '2026_09_10_080426_add_autosupply_fields_to_users_table', 1),
(14, '2026_09_10_080442_create_products_table', 1),
(15, '2026_09_10_080443_create_invoices_table', 1),
(16, '2026_09_10_080444_create_sales_table', 1),
(17, '2026_09_10_080445_create_audit_logs_table', 1),
(18, '2026_09_10_081106_create_newsales_view', 1),
(19, '2026_10_18_130232_update_product_images_to_real_photos', 2);

-- --------------------------------------------------------

--
-- Stand-in structure for view `newsales`
-- (See below for the actual view)
--
CREATE TABLE `newsales` (
`sales_id` bigint unsigned
,`invoice_id` bigint unsigned
,`product_name` varchar(255)
,`additional_name` varchar(255)
,`type` varchar(255)
,`brand` varchar(255)
,`price` decimal(10,2)
,`quantity_sold` int
,`purchase_sale` decimal(10,2)
,`subtotal` decimal(10,2)
,`created_at` timestamp
);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_reset_tokens`
--

INSERT INTO `password_reset_tokens` (`email`, `token`, `created_at`) VALUES
('danah@gmail.com', '$2y$12$OgvqqadUt11gPhOmdIOU7eBh573EZ1jcnylTYCqcWy93tf7.oeyOO', '2026-11-06 02:53:24');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` bigint UNSIGNED NOT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `additional_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'General',
  `brand` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `quantity` int NOT NULL DEFAULT '0',
  `location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `additional_name`, `type`, `brand`, `price`, `quantity`, `location`, `image`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Gear Oil', 'Scooter Oil', '120ml', 'Petron', 90.00, 9, 'Shelf A1', '/images/products/gear-oil.jpeg', 'Petron Gear Oil 120ml', '2026-09-10 08:21:17', '2026-09-11 02:50:33'),
(2, 'Motor Oil', '2T', '200ml', 'Petron', 40.00, 11, 'Shelf A1', '/images/products/motor-oil.jpg', 'Petron Motor Oil 200ml', '2026-09-10 08:21:17', '2026-09-11 02:50:33'),
(3, 'Motor Oil', '4T', '200ml', 'Petron', 40.00, 6, 'Shelf A1', '/images/products/motor-oil.jpg', 'Petron Motor Oil 200ml', '2026-09-10 08:21:17', '2026-09-11 02:44:07'),
(4, 'Motor Oil', 'Havoline 2T', '200ml', 'Caltex', 40.00, 15, 'Shelf A1', '/images/products/motor-oil.jpg', 'Caltex Motor Oil 200ml', '2026-09-10 08:21:17', '2026-09-11 02:50:33'),
(5, 'Break Fluid', 'DOT-3', '300ml', 'National', 100.00, 13, 'Shelf A1', '/images/products/brakefluid.jpg', 'National Break Fluid 300ml', '2026-09-10 08:21:17', '2026-09-11 02:50:33'),
(6, 'Break Fluid', 'DOT-3', '900ml', 'National', 250.00, 14, 'Shelf A1', '/images/products/brakefluid.jpg', 'National Break Fluid 900ml', '2026-09-10 08:21:17', '2026-10-18 13:27:41'),
(7, 'Break Fluid', 'DOT-3', '500ml', 'Prestone', 195.00, 14, 'Shelf A1', '/images/products/brakefluid.jpg', 'Prestone Break Fluid 500ml', '2026-09-10 08:21:17', '2026-10-18 13:27:41'),
(8, 'Break Fluid', 'DOT-3', '900ml', 'Prestone', 280.00, 15, 'Shelf A1', '/images/products/brakefluid.jpg', 'Prestone Break Fluid 900ml', '2026-09-10 08:21:17', '2026-09-11 02:50:33'),
(9, 'Diesel Engine Oil', 'Delo Gold', '1L', 'Caltex', 255.00, 14, 'Shelf A1', '/images/products/diesel-engine-oil.jpg', 'Caltex Diesel Engine Oil 1L', '2026-09-10 08:21:17', '2026-09-11 02:50:33'),
(10, 'Gasoline Engine Oil', 'Havoline 15W-40', '1L', 'Caltex', 230.00, 12, 'Shelf A1', '/images/products/gasoline-engine-oil.png', 'Caltex Gasoline Engine Oil 1L', '2026-09-10 08:21:17', '2026-09-11 02:50:33'),
(11, 'Motor Oil', 'Havoline 4T', '1L', 'Caltex', 230.00, 15, 'Shelf A1', '/images/products/motor-oil.jpg', 'Caltex Motor Oil 1L', '2026-09-10 08:21:17', '2026-09-11 02:50:33'),
(12, 'Radiator Coolant', 'Super Coolant', '1L', 'Petron', 220.00, 15, 'Shelf A1', '/images/products/coolant.webp', 'Petron Radiator Coolant 1L', '2026-09-10 08:21:17', '2026-09-11 02:50:33'),
(13, 'Gasoline Engine Oil', 'Blaze Racing', '1L', 'Petron', 210.00, 12, 'Shelf A1', '/images/products/gasoline-engine-oil.png', 'Petron Gasoline Engine Oil 1L', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(14, 'Diesel Engine Oil', 'Rev-X', '1L', 'Petron', 190.00, 15, 'Shelf A1', '/images/products/diesel-engine-oil.jpg', 'Petron Diesel Engine Oil 1L', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(15, 'Scooter Oil', 'Sprint 4T', '800ml', 'Petron', 215.00, 15, 'Shelf A1', '/images/products/scooter-oil.jpeg', 'Petron Scooter Oil 800ml', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(16, 'Coolant', 'Delo XLI', '1L', 'Caltex', 180.00, 14, 'Shelf A1', '/images/products/coolant.webp', 'Caltex Coolant 1L', '2026-09-11 02:44:07', '2026-10-18 13:27:41'),
(17, 'Motor Oil', 'Sprint 4T', '1L', 'Petron', 215.00, 15, 'Shelf A1', '/images/products/motor-oil.jpg', 'Petron Motor Oil 1L', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(18, 'Diesel Engine Oil', 'Rev-X', '1L', 'Petron', 245.00, 15, 'Shelf A1', '/images/products/diesel-engine-oil.jpg', 'Petron Diesel Engine Oil 1L', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(19, 'Transmission Fluid', 'ATF', '1L', 'Petron', 250.00, 15, 'Shelf A1', '/images/products/transmission-fluid.webp', 'Petron Transmission Fluid 1L', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(20, 'Motor Oil', '2T', '1L', 'Petron', 190.00, 15, 'Shelf A1', '/images/products/motor-oil.jpg', 'Petron Motor Oil 1L', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(21, 'Transmission Fluid', 'Dtec', '1L', 'ZIP', 230.00, 12, 'Shelf A1', '/images/products/transmission-fluid.webp', 'ZIP Transmission Fluid 1L', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(22, 'Motor Oil', 'Advance', '1L', 'Shell', 230.00, 15, 'Shelf A1', '/images/products/motor-oil.jpg', 'Shell Motor Oil 1L', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(23, 'Bolt', '', '3/8×3', '', 12.00, 100, 'Shelf A2', '/images/products/bolt.webp', 'Bolt 3/8×3', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(24, 'Bolt', '', '3/8×1', '', 6.00, 100, 'Shelf A2', '/images/products/bolt.webp', 'Bolt 3/8×1', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(25, 'Bolt', '', '3/8×3/4', '', 6.00, 100, 'Shelf A2', '/images/products/bolt.webp', 'Bolt 3/8×3/4', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(26, 'Bolt', '', '3/8×12', '', 10.00, 100, 'Shelf A2', '/images/products/bolt.webp', 'Bolt 3/8×12', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(27, 'Nut', '', '3/8', '', 3.00, 100, 'Shelf A2', '/images/products/nut.jpeg', 'Nut 3/8', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(28, 'Bolt', '', '5/16×1', '', 7.00, 100, 'Shelf A2', '/images/products/bolt.webp', 'Bolt 5/16×1', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(29, 'Bolt', '', '5/16×1 1/2', '', 8.00, 100, 'Shelf A2', '/images/products/bolt.webp', 'Bolt 5/16×1 1/2', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(30, 'Bolt', '', '5/16×2', '', 10.00, 100, 'Shelf A2', '/images/products/bolt.webp', 'Bolt 5/16×2', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(31, 'Bolt', '', '5/16×3', '', 11.00, 100, 'Shelf A2', '/images/products/bolt.webp', 'Bolt 5/16×3', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(32, 'Nut', '', '5/16', '', 2.00, 1000, 'Shelf A2', '/images/products/nut.jpeg', 'Nut 5/16', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(33, 'Bolt', '', '5/16×3/4', '', 5.00, 100, 'Shelf A2', '/images/products/bolt.webp', 'Bolt 5/16×3/4', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(34, 'Lock Washer', '', '3/8', '', 2.00, 100, 'Shelf A2', '/images/products/washer.jpg', 'Lock Washer 3/8', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(35, 'Lock Washer', '', '5/16', '', 2.00, 99, 'Shelf A2', '/images/products/washer.jpg', 'Lock Washer 5/16', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(36, 'Washer', '', '5/16', '', 2.00, 100, 'Shelf A2', '/images/products/washer.jpg', 'Washer 5/16', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(37, 'Washer', '', '3/8', '', 2.00, 100, 'Shelf A2', '/images/products/washer.jpg', 'Washer 3/8', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(38, 'Washer', '', '5/18', '', 10.00, 100, 'Shelf A2', '/images/products/washer.jpg', 'Washer 5/18', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(39, 'Nut', '', '1/2', '', 5.00, 100, 'Shelf A2', '/images/products/nut.jpeg', 'Nut 1/2', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(40, 'Nut', '', '1/4', '', 2.00, 100, 'Shelf A2', '/images/products/nut.jpeg', 'Nut 1/4', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(41, 'Bolt', '', '1/4×1', '', 5.00, 100, 'Shelf A2', '/images/products/bolt.webp', 'Bolt 1/4×1', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(42, 'Bolt', '', '1/2×4', '', 26.00, 100, 'Shelf A2', '/images/products/bolt.webp', 'Bolt 1/2×4', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(43, 'Lock Bolt', '', '1/2×6', '', 35.00, 100, 'Shelf A2', '/images/products/bolt.webp', 'Lock Bolt 1/2×6', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(44, 'Bearing', '', '6001', 'Koyo', 120.00, 9, 'Shelf B1', '/images/products/bearing.jpg', 'Koyo Bearing 6001', '2026-09-11 02:44:07', '2026-09-11 03:17:17'),
(45, 'Bearing', '', '6002', 'Koyo', 150.00, 9, 'Shelf B1', '/images/products/bearing.jpg', 'Koyo Bearing 6002', '2026-09-11 02:44:07', '2026-09-11 03:17:17'),
(46, 'Bearing', '', '6003', 'Koyo', 150.00, 10, 'Shelf B1', '/images/products/bearing.jpg', 'Koyo Bearing 6003', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(47, 'Bearing', '', '6004', 'Koyo', 150.00, 1, 'Shelf B1', '/images/products/bearing.jpg', 'Koyo Bearing 6004', '2026-09-11 02:44:07', '2026-10-18 13:05:35'),
(48, 'Bearing', '', '6005', 'Koyo', 170.00, 6, 'Shelf B1', '/images/products/bearing.jpg', 'Koyo Bearing 6005', '2026-09-11 02:44:07', '2026-10-18 13:05:35'),
(49, 'Bearing', '', '6200', 'Koyo', 100.00, 10, 'Shelf B1', '/images/products/bearing.jpg', 'Koyo Bearing 6200', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(50, 'Bearing', '', '6201', 'Koyo', 120.00, 9, 'Shelf B2', '/images/products/bearing.jpg', 'Koyo Bearing 6201', '2026-09-11 02:44:07', '2026-10-18 13:27:41'),
(51, 'Bearing', '', '6202', 'Koyo', 120.00, 10, 'Shelf B2', '/images/products/bearing.jpg', 'Koyo Bearing 6202', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(52, 'Bearing', '', '6203', 'Koyo', 140.00, 9, 'Shelf B2', '/images/products/bearing.jpg', 'Koyo Bearing 6203', '2026-09-11 02:44:07', '2026-09-11 03:00:08'),
(53, 'Bearing', '', '6204', 'Koyo', 180.00, 10, 'Shelf B2', '/images/products/bearing.jpg', 'Koyo Bearing 6204', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(54, 'Bearing', '', '6205', 'Koyo', 180.00, 9, 'Shelf B2', '/images/products/bearing.jpg', 'Koyo Bearing 6205', '2026-09-11 02:44:07', '2026-09-11 03:00:08'),
(55, 'Bearing', '', '6301', 'Koyo', 150.00, 10, 'Shelf B2', '/images/products/bearing.jpg', 'Koyo Bearing 6301', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(56, 'Bearing', '', '6302', 'Koyo', 150.00, 10, 'Shelf B2', '/images/products/bearing.jpg', 'Koyo Bearing 6302', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(57, 'Bearing', '', '6300', 'Koyo', 100.00, 9, 'Shelf B2', '/images/products/bearing.jpg', 'Koyo Bearing 6300', '2026-09-11 02:44:07', '2026-10-18 11:43:52'),
(58, 'Bearing', '', '6306', 'Koyo', 320.00, 9, 'Shelf B2', '/images/products/bearing.jpg', 'Koyo Bearing 6306', '2026-09-11 02:44:07', '2026-10-18 11:43:52'),
(59, 'Bearing', '', '6305', 'Koyo', 270.00, 9, 'Shelf B2', '/images/products/bearing.jpg', 'Koyo Bearing 6305', '2026-09-11 02:44:07', '2026-10-18 13:27:41'),
(60, 'Bearing', '', '607', 'Koyo', 100.00, 8, 'Shelf B2', '/images/products/bearing.jpg', 'Koyo Bearing 607', '2026-09-11 02:44:07', '2026-10-18 13:27:41'),
(61, 'Bearing', '', '608', 'Koyo', 100.00, 8, 'Shelf B2', '/images/products/bearing.jpg', 'Koyo Bearing 608', '2026-09-11 02:44:07', '2026-10-18 11:43:52'),
(62, 'Knuckle Bearing', '', '32207', 'Koyo', 500.00, 5, 'Shelf B2', '/images/products/bearing.jpg', 'Koyo Knuckle Bearing 32207', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(63, 'Knuckle Bearing', '', '32210', 'Koyo', 720.00, 5, 'Shelf B2', '/images/products/bearing.jpg', 'Koyo Knuckle Bearing 32210', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(64, 'Knuckle Bearing', '', 'L212641/10', 'Koyo', 200.00, 5, 'Shelf B2', '/images/products/bearing.jpg', 'Koyo Knuckle Bearing L212641/10', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(65, 'Knuckle Bearing', '', 'LM48548/10', 'Koyo', 320.00, 5, 'Shelf B2', '/images/products/bearing.jpg', 'Koyo Knuckle Bearing LM48548/10', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(66, 'Knuckle Bearing', '', '45449/10', 'Koyo', 270.00, 5, 'Shelf B2', '/images/products/bearing.jpg', 'Koyo Knuckle Bearing 45449/10', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(67, 'Fuel Tank cap', '', 'Black', 'Circuit', 250.00, 100, 'Shelf B1', '/images/products/filter.svg', 'Circuit Fuel Tank cap Black', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(68, 'Plug-in Fuse', '', '10AMP', 'Circuit', 10.00, 100, 'Shelf B1', '/images/products/plug-in-fuse.jpeg', 'Circuit Plug-in Fuse 10AMP', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(69, 'Plug-in Fuse', '', '15AMP', 'Circuit', 10.00, 100, 'Shelf B1', '/images/products/plug-in-fuse.jpeg', 'Circuit Plug-in Fuse 15AMP', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(70, 'Plug-in Fuse', '', '20AMP', 'Circuit', 10.00, 96, 'Shelf B1', '/images/products/plug-in-fuse.jpeg', 'Circuit Plug-in Fuse 20AMP', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(71, 'Plug-in Fuse', '', '30AMP', 'Circuit', 10.00, 100, 'Shelf B1', '/images/products/plug-in-fuse.jpeg', 'Circuit Plug-in Fuse 30AMP', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(72, 'Mini Plug-in Fuse', '', '10AMP', 'Circuit', 10.00, 100, 'Shelf B1', '/images/products/plug-in-fuse.jpeg', 'Circuit Mini Plug-in Fuse 10AMP', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(73, 'Mini Plug-in Fuse', '', '15AMP', 'Circuit', 10.00, 100, 'Shelf B1', '/images/products/plug-in-fuse.jpeg', 'Circuit Mini Plug-in Fuse 15AMP', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(74, 'Mini Plug-in Fuse', '', '20AMP', 'Circuit', 10.00, 100, 'Shelf B1', '/images/products/plug-in-fuse.jpeg', 'Circuit Mini Plug-in Fuse 20AMP', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(75, 'Mini Plug-in Fuse', '', '30AMP', 'Circuit', 10.00, 100, 'Shelf B1', '/images/products/plug-in-fuse.jpeg', 'Circuit Mini Plug-in Fuse 30AMP', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(76, 'Female Terminal', '', '', 'Circuit', 5.00, 50, 'Shelf B1', '/images/products/female-terminal.webp', 'Circuit Female Terminal', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(77, 'Eye Terminal', '', '3/16', 'Circuit', 5.00, 50, 'Shelf B1', '/images/products/eye-terminal.avif', 'Circuit Eye Terminal 3/16', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(78, 'Eye Terminal', '', '5/16', 'Circuit', 10.00, 50, 'Shelf B1', '/images/products/eye-terminal.avif', 'Circuit Eye Terminal 5/16', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(79, 'Ignition Switch', '', 'Diesel', 'Circuit', 460.00, 6, 'Shelf B1', '/images/products/ignition-switch.jpeg', 'Circuit Ignition Switch Diesel', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(80, 'Ignition Switch', '', 'Gasoline', 'I.Tokyo', 380.00, 6, 'Shelf B1', '/images/products/ignition-switch.jpeg', 'I.Tokyo Ignition Switch Gasoline', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(81, 'Priming Pump', '', '', 'DENSO', 590.00, 6, 'Shelf B1', '/images/products/priming-pump.jpeg', 'DENSO Priming Pump', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(82, 'Alternator Carbon Brush', '', '37A', 'FCC', 50.00, 24, 'Shelf B1', '/images/products/alternator.jpeg', 'FCC Alternator Carbon Brush 37A', '2026-09-11 02:44:07', '2026-11-06 02:44:47'),
(83, 'Starter Carbon Brush', '', '4K', 'FCC', 140.00, 30, 'Shelf B1', '/images/products/starter-carbon-brush.jpg', 'FCC Starter Carbon Brush 4K', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(84, 'Starter Carbon Brush', '', 'L300', 'FCC', 200.00, 30, 'Shelf B1', '/images/products/starter-carbon-brush.jpg', 'FCC Starter Carbon Brush L300', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(85, 'Alternator Carbon Brush', '', '22A', 'FCC', 50.00, 25, 'Shelf B1', '/images/products/alternator.jpeg', 'FCC Alternator Carbon Brush 22A', '2026-09-11 02:44:07', '2026-11-06 02:44:47'),
(86, 'Gasket Shellac', '', '', 'V-tech', 70.00, 50, 'Shelf B1', '/images/products/gasket.jpeg', 'V-tech Gasket Shellac', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(87, 'Temperature Sending Unit', '', '', 'Circuit', 180.00, 10, 'Shelf B1', '/images/products/temperature-sending-unit.jpeg', 'Circuit Temperature Sending Unit', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(88, 'Air-Horn Switch Relay', '', '', 'Maruzen', 450.00, 4, 'Shelf B1', '/images/products/air-horn.jpg', 'Maruzen Air-Horn Switch Relay', '2026-09-11 02:44:07', '2026-10-18 12:28:23'),
(89, 'Silicon Radiator Cap', '', 'RC-93', 'Circuit', 120.00, 6, 'Shelf B1', '/images/products/silicon-radiator-cap.jpeg', 'Circuit Silicon Radiator Cap RC-93', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(90, 'Silicon Radiator Cap', '', 'RC-95', 'Circuit', 120.00, 7, 'Shelf B1', '/images/products/silicon-radiator-cap.jpeg', 'Circuit Silicon Radiator Cap RC-95', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(91, 'Silicon Radiator Cap', '', 'RC-102', 'Circuit', 120.00, 7, 'Shelf B1', '/images/products/silicon-radiator-cap.jpeg', 'Circuit Silicon Radiator Cap RC-102', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(92, 'Heater Plug', '', '', 'Circuit', 100.00, 50, 'Shelf B1', '/images/products/heater-plug.jpeg', 'Circuit Heater Plug', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(93, 'Oil Filter', '', 'C-806', 'ViC', 250.00, 6, 'Shelf B2', '/images/products/oil-filter.jpg', 'ViC Oil Filter C-806', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(94, 'Oil Filter', '', 'C-415', 'ViC', 240.00, 6, 'Shelf B2', '/images/products/oil-filter.jpg', 'ViC Oil Filter C-415', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(95, 'Oil Filter', '', 'C-106', 'ViC', 250.00, 4, 'Shelf B2', '/images/products/oil-filter.jpg', 'ViC Oil Filter C-106', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(96, 'Oil Filter', '', 'C-512', 'ViC', 290.00, 6, 'Shelf B2', '/images/products/oil-filter.jpg', 'ViC Oil Filter C-512', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(97, 'Oil Filter', '', 'C-312', 'ViC', 220.00, 6, 'Shelf B2', '/images/products/oil-filter.jpg', 'ViC Oil Filter C-312', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(98, 'Oil Filter', '', 'C-318', 'ViC', 950.00, 6, 'Shelf B2', '/images/products/oil-filter.jpg', 'ViC Oil Filter C-318', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(99, 'Oil Filter', '', 'C-207', 'ViC', 240.00, 3, 'Shelf B2', '/images/products/oil-filter.jpg', 'ViC Oil Filter C-207', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(100, 'Oil Filter', '', 'C-527', 'ViC', 340.00, 6, 'Shelf B2', '/images/products/oil-filter.jpg', 'ViC Oil Filter C-527', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(101, 'Oil Filter', '', 'C-111', 'ViC', 280.00, 6, 'Shelf B2', '/images/products/oil-filter.jpg', 'ViC Oil Filter C-111', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(102, 'Oil Filter', '', 'C-412', 'ViC', 520.00, 6, 'Shelf B2', '/images/products/oil-filter.jpg', 'ViC Oil Filter C-412', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(103, 'Oil Filter', '', 'C-707', 'ViC', 200.00, 6, 'Shelf B2', '/images/products/oil-filter.jpg', 'ViC Oil Filter C-707', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(104, 'Oil Filter', '', 'C-405', 'ViC', 250.00, 6, 'Shelf B2', '/images/products/oil-filter.jpg', 'ViC Oil Filter C-405', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(105, 'Oil Filter', '', 'C-305', 'ViC', 350.00, 6, 'Shelf B2', '/images/products/oil-filter.jpg', 'ViC Oil Filter C-305', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(106, 'Oil Filter', '', 'C-503', 'ViC', 400.00, 6, 'Shelf B2', '/images/products/oil-filter.jpg', 'ViC Oil Filter C-503', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(107, 'Fuel Filter', '', 'FC-193', 'ViC', 370.00, 6, 'Shelf B3', '/images/products/oil-filter.jpg', 'ViC Fuel Filter FC-193', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(108, 'Fuel Filter', '', 'FC-208A', 'ViC', 280.00, 6, 'Shelf B3', '/images/products/oil-filter.jpg', 'ViC Fuel Filter FC-208A', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(109, 'Fuel Filter', '', 'FC-317', 'ViC', 340.00, 6, 'Shelf B3', '/images/products/oil-filter.jpg', 'ViC Fuel Filter FC-317', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(110, 'Rubber Cup', '', 'SC-80353', '', 55.00, 35, 'Shelf B3', '/images/products/rubber-cup.webp', 'Rubber Cup SC-80353', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(111, 'Rubber Cup', '', 'SC-80423', '', 50.00, 50, 'Shelf B3', '/images/products/rubber-cup.webp', 'Rubber Cup SC-80423', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(112, 'Rubber Cup', '', 'SC-30233', '', 60.00, 50, 'Shelf B3', '/images/products/rubber-cup.webp', 'Rubber Cup SC-30233', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(113, 'Rubber Cup', '', 'SC-47624', '', 50.00, 50, 'Shelf B3', '/images/products/rubber-cup.webp', 'Rubber Cup SC-47624', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(114, 'Electrical Tape', '', 'Big', 'Armok', 60.00, 20, 'Shelf B4', '/images/products/electrical tape.jpeg', 'Armok Electrical Tape Big', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(115, 'Electrical Tape', '', 'Small', 'Armok', 30.00, 20, 'Shelf B4', '/images/products/electrical tape.jpeg', 'Armok Electrical Tape Small', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(116, 'Spray Paint', '', 'Silver', 'Bosny', 120.00, 15, 'Shelf C1', '/images/products/bosny.webp', 'Bosny Spray Paint Silver', '2026-09-11 02:44:07', '2026-09-11 03:00:38'),
(117, 'Spray Paint', '', 'Black', 'Bosny', 120.00, 15, 'Shelf C1', '/images/products/bosny.webp', 'Bosny Spray Paint Black', '2026-09-11 02:44:07', '2026-09-11 03:00:41'),
(118, 'Spray Paint', '', 'White', 'Bosny', 120.00, 5, 'Shelf C1', '/images/products/bosny.webp', 'Bosny Spray Paint White', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(119, 'Spray Paint', '', 'Clear', 'Bosny', 120.00, 5, 'Shelf C1', '/images/products/bosny.webp', 'Bosny Spray Paint Clear', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(120, 'Spray Paint', '', 'Blue', 'Bosny', 120.00, 6, 'Shelf C1', '/images/products/bosny.webp', 'Bosny Spray Paint Blue', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(121, 'Spray Paint', '', 'Red', 'Bosny', 120.00, 5, 'Shelf C1', '/images/products/bosny.webp', 'Bosny Spray Paint Red', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(122, 'Spray Paint', '', 'Yellow', 'Bosny', 120.00, 5, 'Shelf C1', '/images/products/bosny.webp', 'Bosny Spray Paint Yellow', '2026-09-11 02:44:07', '2026-09-11 02:50:33'),
(123, 'Battery Terminal', '', '', '', 70.00, 243, 'Shelf B4', '/images/products/battery-terminal.jpeg', 'Battery Terminal', '2026-09-11 02:44:07', '2026-09-11 02:59:35'),
(124, 'Sandpaper', '', 'CC 120', 'Hippo', 20.00, 100, 'Shelf C5', '/images/products/sandpaper.jpg', 'Hippo Sandpaper CC 120', '2026-09-11 02:50:33', '2026-09-11 02:50:33'),
(125, 'Sandpaper', '', 'CC 400', 'Hippo', 20.00, 100, 'Shelf C5', '/images/products/sandpaper.jpg', 'Hippo Sandpaper CC 400', '2026-09-11 02:50:33', '2026-09-11 02:50:33'),
(126, 'Sandpaper', NULL, 'CC 1000', 'Hippo', 20.00, 96, 'Shelf C5', '/images/products/sandpaper.jpg', 'Hippo Sandpaper CC 1000', '2026-09-11 02:44:07', '2026-09-11 03:06:46'),
(127, 'Spark Plug', 'Iridium IX Long Life', 'Electrical', 'NGK', 200.00, 110, 'Shelf D-2', '/images/products/spark-plug.jpg', NULL, '2026-10-18 11:43:20', '2026-11-06 02:47:40'),
(129, 'Paper', 'Iridium IX Long Life', 'Electrical', 'Hippo', 100.00, 100, 'Shelf D-2', 'storage/images/products/Q9ueWvHLNs5eGbvrWzDB6NvFRVW7K94cigWmSLdi.jpg', NULL, '2026-11-06 03:05:11', '2026-11-06 03:05:37');

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `sales_id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `invoice_id` bigint UNSIGNED NOT NULL,
  `quantity_sold` int NOT NULL,
  `purchase_sale` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`sales_id`, `product_id`, `invoice_id`, `quantity_sold`, `purchase_sale`, `subtotal`, `created_at`, `updated_at`) VALUES
(1, 7, 1, 2, 280.00, 560.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(2, 7, 2, 3, 280.00, 840.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(3, 8, 3, 3, 15.00, 45.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(4, 12, 3, 1, 320.00, 320.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(5, 8, 4, 1, 15.00, 15.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(6, 9, 4, 2, 10.00, 20.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(7, 12, 4, 3, 320.00, 960.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(8, 1, 5, 1, 250.00, 250.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(9, 6, 6, 3, 190.00, 570.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(10, 10, 6, 3, 25.00, 75.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(11, 3, 7, 1, 380.00, 380.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(12, 4, 8, 2, 480.00, 960.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(13, 5, 8, 3, 320.00, 960.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(14, 1, 9, 1, 250.00, 250.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(15, 2, 10, 3, 1650.00, 4950.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(16, 4, 10, 3, 480.00, 1440.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(17, 1, 11, 3, 250.00, 750.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(18, 4, 11, 3, 480.00, 1440.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(19, 10, 12, 3, 25.00, 75.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(20, 4, 13, 1, 480.00, 480.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(21, 4, 14, 3, 480.00, 1440.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(22, 6, 14, 2, 190.00, 380.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(23, 8, 14, 1, 15.00, 15.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(24, 7, 15, 3, 280.00, 840.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(25, 10, 16, 1, 25.00, 25.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(26, 11, 16, 2, 1450.00, 2900.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(27, 7, 17, 1, 280.00, 280.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(28, 12, 17, 1, 320.00, 320.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(29, 2, 18, 2, 1650.00, 3300.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(30, 3, 18, 2, 380.00, 760.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(31, 1, 19, 4, 250.00, 1000.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(32, 9, 19, 8, 10.00, 80.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(33, 3, 20, 2, 380.00, 760.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(34, 6, 20, 1, 190.00, 190.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(35, 10, 20, 4, 25.00, 100.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(36, 2, 21, 1, 1650.00, 1650.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(37, 4, 21, 1, 480.00, 480.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(38, 7, 21, 1, 280.00, 280.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(39, 1, 22, 2, 250.00, 500.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(40, 5, 22, 1, 320.00, 320.00, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(41, 10, 23, 1, 25.00, 25.00, '2026-09-10 08:22:00', '2026-09-10 08:22:00'),
(42, 1, 24, 1, 250.00, 250.00, '2026-09-10 09:15:48', '2026-09-10 09:15:48'),
(43, 10, 24, 1, 25.00, 25.00, '2026-09-10 09:15:48', '2026-09-10 09:15:48'),
(44, 9, 24, 1, 10.00, 10.00, '2026-09-10 09:15:48', '2026-09-10 09:15:48'),
(45, 88, 25, 1, 450.00, 450.00, '2026-09-11 02:59:35', '2026-09-11 02:59:35'),
(46, 123, 25, 2, 70.00, 140.00, '2026-09-11 02:59:35', '2026-09-11 02:59:35'),
(47, 85, 25, 2, 50.00, 100.00, '2026-09-11 02:59:35', '2026-09-11 02:59:35'),
(48, 52, 26, 1, 140.00, 140.00, '2026-09-11 03:00:08', '2026-09-11 03:00:08'),
(49, 54, 26, 1, 180.00, 180.00, '2026-09-11 03:00:08', '2026-09-11 03:00:08'),
(50, 85, 27, 1, 50.00, 50.00, '2026-09-11 03:17:17', '2026-09-11 03:17:17'),
(51, 44, 27, 1, 120.00, 120.00, '2026-09-11 03:17:17', '2026-09-11 03:17:17'),
(52, 45, 27, 1, 150.00, 150.00, '2026-09-11 03:17:17', '2026-09-11 03:17:17'),
(53, 57, 28, 1, 100.00, 100.00, '2026-10-18 11:43:52', '2026-10-18 11:43:52'),
(54, 58, 28, 1, 320.00, 320.00, '2026-10-18 11:43:52', '2026-10-18 11:43:52'),
(55, 61, 28, 2, 100.00, 200.00, '2026-10-18 11:43:52', '2026-10-18 11:43:52'),
(56, 88, 29, 1, 450.00, 450.00, '2026-10-18 12:28:23', '2026-10-18 12:28:23'),
(57, 85, 30, 1, 50.00, 50.00, '2026-10-18 13:05:35', '2026-10-18 13:05:35'),
(58, 47, 30, 9, 150.00, 1350.00, '2026-10-18 13:05:35', '2026-10-18 13:05:35'),
(59, 48, 30, 1, 170.00, 170.00, '2026-10-18 13:05:35', '2026-10-18 13:05:35'),
(60, 50, 31, 1, 120.00, 120.00, '2026-10-18 13:27:41', '2026-10-18 13:27:41'),
(61, 59, 31, 1, 270.00, 270.00, '2026-10-18 13:27:41', '2026-10-18 13:27:41'),
(62, 60, 31, 2, 100.00, 200.00, '2026-10-18 13:27:41', '2026-10-18 13:27:41'),
(63, 6, 31, 1, 250.00, 250.00, '2026-10-18 13:27:41', '2026-10-18 13:27:41'),
(64, 7, 31, 1, 195.00, 195.00, '2026-10-18 13:27:41', '2026-10-18 13:27:41'),
(65, 16, 31, 1, 180.00, 180.00, '2026-10-18 13:27:41', '2026-10-18 13:27:41'),
(66, 82, 32, 6, 50.00, 300.00, '2026-11-06 02:44:47', '2026-11-06 02:44:47'),
(67, 85, 32, 1, 50.00, 50.00, '2026-11-06 02:44:47', '2026-11-06 02:44:47');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('7OGH8l3dmePegQUCmlUDRMV7AMjNtYiidhuaqLxF', 1, '192.168.65.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJWUnBHckJwT0hMRDNoTVdaRlh6eTFLYVhQZ1htdGdIRFFWTjd2MnpwIiwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119LCJfcHJldmlvdXMiOnsidXJsIjoiaHR0cDpcL1wvbG9jYWxob3N0XC9kYXNoYm9hcmQiLCJyb3V0ZSI6ImRhc2hib2FyZCJ9LCJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI6MX0=', 1793940947),
('9znpl6fu1veFwf7eBymVfzs5Rpkaq1h7JVKVHq5P', NULL, '192.168.65.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJMd2tVRVBycDNLc2VNMVZvb3VORG9adDVCVlBOV3hlMThMaUszWnhrIiwidXJsIjp7ImludGVuZGVkIjoiaHR0cDpcL1wvbG9jYWxob3N0XC9pbnZlbnRvcnkifSwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdFwvbG9naW4iLCJyb3V0ZSI6ImxvZ2luIn0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1793951483);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `surname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_num` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'admin',
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `name`, `fname`, `mname`, `surname`, `contact_num`, `role`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'jared', 'Jared Abellera', 'Jared', 'M.', 'Abellera', '0917-123-4567', 'admin', 'jared@autosupply.test', NULL, '$2y$12$gP4a0SBsR5vpohlEHKbOs.aooEj2tioiKTAA0a.FOD2JvPP4MqCJe', 'nQ4YPh2HbazMzmKCop9zOpckIOigmxrxK4dHUDmHjKZpPCVDFkZw0yKHWwaB', '2026-09-10 08:21:16', '2026-09-10 08:21:16'),
(2, 'joycashier', 'Joy Staff', 'Joy', NULL, 'Jeffrey', '0918-987-6543', 'staff', 'cashier@autosupply.test', NULL, '$2y$12$TSEea4btt4.MUB0f/Mjbwe29LS8i2LHLJtXDjxwUdPWn/hxWbLXFi', NULL, '2026-09-10 08:21:17', '2026-09-10 08:21:17'),
(3, 'danah', 'Danah Paris', NULL, NULL, NULL, NULL, 'admin', 'danah@gmail.com', NULL, '$2y$12$1vf/q2AhDVecg5.Y8rguzebqPEDhCwI4CNtSPr8nvEnMBrrfFzOda', NULL, '2026-11-06 02:53:13', '2026-11-06 02:53:13');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`grade_id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`),
  ADD KEY `failed_jobs_connection_queue_failed_at_index` (`connection`,`queue`,`failed_at`);

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`invoice_id`),
  ADD UNIQUE KEY `invoices_invoice_number_unique` (`invoice_number`),
  ADD KEY `invoices_user_id_foreign` (`user_id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`sales_id`),
  ADD KEY `sales_product_id_foreign` (`product_id`),
  ADD KEY `sales_invoice_id_foreign` (`invoice_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_username_unique` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `grade_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `invoice_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=130;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `sales_id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

-- --------------------------------------------------------

--
-- Structure for view `newsales`
--
DROP TABLE IF EXISTS `newsales`;

CREATE ALGORITHM=UNDEFINED DEFINER=`sail`@`%` SQL SECURITY DEFINER VIEW `newsales`  AS SELECT `s`.`sales_id` AS `sales_id`, `s`.`invoice_id` AS `invoice_id`, `p`.`product_name` AS `product_name`, `p`.`additional_name` AS `additional_name`, `p`.`type` AS `type`, `p`.`brand` AS `brand`, `p`.`price` AS `price`, `s`.`quantity_sold` AS `quantity_sold`, `s`.`purchase_sale` AS `purchase_sale`, `s`.`subtotal` AS `subtotal`, `s`.`created_at` AS `created_at` FROM (`sales` `s` join `products` `p` on((`s`.`product_id` = `p`.`product_id`))) ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `invoices`
--
ALTER TABLE `invoices`
  ADD CONSTRAINT `invoices_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_invoice_id_foreign` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`invoice_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sales_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
