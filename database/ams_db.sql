-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 08, 2025 at 07:28 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ams_db`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `addNewProduct` (IN `pName` VARCHAR(255), IN `addName` VARCHAR(255), IN `inType` VARCHAR(255), IN `inBrand` VARCHAR(255), IN `inPrice` DOUBLE, IN `inQuant` INT, IN `inLoc` VARCHAR(255), IN `inImage` LONGBLOB, IN `inDesc` LONGTEXT)   BEGIN
    INSERT INTO products (
        product_name, 
        additional_name, 
        type, 
        brand, 
        price, 
        quantity, 
        location, 
        image, 
        description
    ) 
    VALUES (
        pName, 
        addName, 
        inType, 
        inBrand, 
        inPrice, 
        inQuant, 
        inLoc, 
        inImage, 
        inDesc
    );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteProduct` (IN `prodID` INT)   BEGIN
    DELETE FROM products WHERE product_id = prodID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getDescription` (IN `prodID` INT(50))   BEGIN
   SELECT description 
   FROM products 
   WHERE product_id = prodID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getImg` (IN `prodID` INT(50))   BEGIN
SELECT image FROM products WHERE product_id = prodID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getLowestStockProduct` ()   BEGIN
    SELECT product_name
    FROM products
    WHERE quantity < 5
    ORDER BY quantity ASC
    LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getMostSoldProduct` ()   BEGIN
    SELECT p.product_name
    FROM sales s
    JOIN products p ON s.product_id = p.product_id
    GROUP BY p.product_name
    ORDER BY SUM(s.quantity_sold) DESC
    LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getRevenueNow` ()   BEGIN
    SELECT SUM(total_sales) AS total_sales_today
    FROM invoice
    WHERE date = CURDATE();
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `recordInvoice` (IN `totalSale` DOUBLE, IN `inPayment` DOUBLE, IN `inChange` DOUBLE)   BEGIN
  INSERT INTO invoice (total_sales, customer_payment, customer_change, date, time) VALUES 
                      (totalSale, inPayment, inChange, CURRENT_DATE, CURRENT_TIME);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `recordSale` (IN `prodID` INT, IN `quantSold` INT, IN `sale` DOUBLE)   BEGIN
    INSERT INTO sales (invoice_id, product_id, `quantity_sold`, purchase_sale)
    VALUES (
        (SELECT MAX(invoice_id) FROM invoice),
        prodID,
        quantSold,
        sale
    );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateProductDetails` (IN `prodID` INT, IN `pName` VARCHAR(255), IN `addName` VARCHAR(255), IN `inType` VARCHAR(255), IN `inBrand` VARCHAR(50), IN `inPrice` DOUBLE, IN `inQuant` INT, IN `inLoc` VARCHAR(255), IN `inImage` LONGBLOB, IN `inDesc` TEXT)   BEGIN
    UPDATE products
    SET
        product_name = pName,
        additional_name = addName,
        type = inType,
        brand = inBrand,
        price = inPrice,
        quantity = inQuant,
        location = inLoc,
        image = inImage,
        description = inDesc
    WHERE product_id = prodID;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `audit_log`
--

CREATE TABLE `audit_log` (
  `id` int(11) NOT NULL,
  `table_name` varchar(50) NOT NULL,
  `action` varchar(10) NOT NULL,
  `record_id` int(11) NOT NULL,
  `column_name` varchar(50) NOT NULL,
  `old_value` text DEFAULT NULL,
  `new_value` text DEFAULT NULL,
  `changed_by` varchar(50) DEFAULT NULL,
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `audit_log`
--

INSERT INTO `audit_log` (`id`, `table_name`, `action`, `record_id`, `column_name`, `old_value`, `new_value`, `changed_by`, `changed_at`) VALUES
(1, 'invoice', 'INSERT', 0, '', NULL, 'invoice_id=275, total_sales=280, payment=500', NULL, '2025-05-07 15:34:07'),
(2, 'sales', 'INSERT', 0, '', NULL, 'sales_id=808, product_id=12, quantity_sold=1', NULL, '2025-05-07 15:34:07'),
(3, 'sales', 'INSERT', 0, '', NULL, 'sales_id=809, product_id=2, quantity_sold=1', NULL, '2025-05-07 15:34:07'),
(4, 'sales', 'INSERT', 0, '', NULL, 'sales_id=810, product_id=33, quantity_sold=4', NULL, '2025-05-07 15:34:07'),
(5, 'invoice', 'INSERT', 0, '', NULL, 'invoice_id=276, total_sales=1440, payment=8000', NULL, '2025-05-07 15:34:54'),
(6, 'sales', 'INSERT', 0, '', NULL, 'sales_id=811, product_id=121, quantity_sold=1', NULL, '2025-05-07 15:34:54'),
(7, 'sales', 'INSERT', 0, '', NULL, 'sales_id=812, product_id=118, quantity_sold=1', NULL, '2025-05-07 15:34:54'),
(8, 'sales', 'INSERT', 0, '', NULL, 'sales_id=813, product_id=106, quantity_sold=3', NULL, '2025-05-07 15:34:54'),
(9, 'invoice', 'INSERT', 0, '', NULL, 'invoice_id=277, total_sales=630, payment=700', NULL, '2025-05-08 01:45:23'),
(10, 'sales', 'INSERT', 0, '', NULL, 'sales_id=814, product_id=1, quantity_sold=7', NULL, '2025-05-08 01:45:23'),
(11, 'invoice', 'INSERT', 0, '', NULL, 'invoice_id=278, total_sales=1246, payment=1300', NULL, '2025-05-08 01:49:42'),
(12, 'sales', 'INSERT', 0, '', NULL, 'sales_id=815, product_id=32, quantity_sold=23', NULL, '2025-05-08 01:49:42'),
(13, 'sales', 'INSERT', 0, '', NULL, 'sales_id=816, product_id=6, quantity_sold=4', NULL, '2025-05-08 01:49:42'),
(14, 'sales', 'INSERT', 0, '', NULL, 'sales_id=817, product_id=4, quantity_sold=5', NULL, '2025-05-08 01:49:42'),
(15, 'invoice', 'INSERT', 0, '', NULL, 'invoice_id=279, total_sales=825, payment=900', NULL, '2025-05-08 04:02:52'),
(16, 'sales', 'INSERT', 0, '', NULL, 'sales_id=818, product_id=110, quantity_sold=15', NULL, '2025-05-08 04:02:52'),
(17, 'products', 'UPDATE', 0, '', 'product_id=110, name=Rubber Cup, price=55', 'product_id=110, name=Rubber Cup, price=55', NULL, '2025-05-08 04:02:52'),
(18, 'invoice', 'INSERT', 0, '', NULL, 'invoice_id=280, total_sales=255, payment=300', NULL, '2025-05-08 05:56:53'),
(19, 'sales', 'INSERT', 0, '', NULL, 'sales_id=819, product_id=9, quantity_sold=1', NULL, '2025-05-08 05:56:53'),
(20, 'products', 'UPDATE', 0, '', 'product_id=9, name=Diesel Engine Oil, price=255', 'product_id=9, name=Diesel Engine Oil, price=255', NULL, '2025-05-08 05:56:53'),
(21, 'products', 'UPDATE', 0, '', 'product_id=89, name=Silicon Radiator Cap, price=120', 'product_id=89, name=Silicon Radiator Cap, price=120', NULL, '2025-05-09 12:53:04'),
(22, 'products', 'UPDATE', 0, '', 'product_id=91, name=Silicon Radiator Cap, price=120', 'product_id=91, name=Silicon Radiator Cap, price=120', NULL, '2025-05-09 12:53:12'),
(23, 'products', 'UPDATE', 0, '', 'product_id=90, name=Silicon Radiator Cap, price=120', 'product_id=90, name=Silicon Radiator Cap, price=120', NULL, '2025-05-09 12:53:23'),
(24, 'products', 'UPDATE', 0, '', 'product_id=98, name=Oil Filter, price=950', 'product_id=98, name=Oil Filter, price=950', NULL, '2025-05-09 12:53:32'),
(25, 'products', 'UPDATE', 0, '', 'product_id=102, name=Oil Filter, price=520', 'product_id=102, name=Oil Filter, price=520', NULL, '2025-05-09 21:05:46'),
(26, 'products', 'UPDATE', 0, '', 'product_id=105, name=Oil Filter, price=350', 'product_id=105, name=Oil Filter, price=350', NULL, '2025-05-09 21:05:57'),
(27, 'products', 'UPDATE', 0, '', 'product_id=107, name=Fuel Filter, price=370', 'product_id=107, name=Fuel Filter, price=370', NULL, '2025-05-09 21:06:09'),
(28, 'products', 'UPDATE', 0, '', 'product_id=108, name=Fuel Filter, price=280', 'product_id=108, name=Fuel Filter, price=280', NULL, '2025-05-09 21:06:22'),
(29, 'products', 'UPDATE', 0, '', 'product_id=109, name=Fuel Filter, price=340', 'product_id=109, name=Fuel Filter, price=340', NULL, '2025-05-09 21:06:32'),
(30, 'products', 'UPDATE', 0, '', 'product_id=94, name=Oil Filter, price=240', 'product_id=94, name=Oil Filter, price=240', NULL, '2025-05-09 21:06:40'),
(31, 'products', 'UPDATE', 0, '', 'product_id=93, name=Oil Filter, price=250', 'product_id=93, name=Oil Filter, price=250', NULL, '2025-05-09 21:06:56'),
(32, 'products', 'UPDATE', 0, '', 'product_id=96, name=Oil Filter, price=290', 'product_id=96, name=Oil Filter, price=290', NULL, '2025-05-09 21:07:07'),
(33, 'products', 'UPDATE', 0, '', 'product_id=97, name=Oil Filter, price=220', 'product_id=97, name=Oil Filter, price=220', NULL, '2025-05-09 21:07:15'),
(34, 'products', 'UPDATE', 0, '', 'product_id=100, name=Oil Filter, price=340', 'product_id=100, name=Oil Filter, price=340', NULL, '2025-05-09 21:07:24'),
(35, 'products', 'UPDATE', 0, '', 'product_id=101, name=Oil Filter, price=280', 'product_id=101, name=Oil Filter, price=280', NULL, '2025-05-09 21:07:35'),
(36, 'products', 'UPDATE', 0, '', 'product_id=120, name=Spray Paint, price=120', 'product_id=120, name=Spray Paint, price=120', NULL, '2025-05-09 21:07:49'),
(37, 'invoice', 'INSERT', 0, '', NULL, 'invoice_id=281, total_sales=1120, payment=2000', NULL, '2025-05-09 21:10:23'),
(38, 'sales', 'INSERT', 0, '', NULL, 'sales_id=820, product_id=3, quantity_sold=4', NULL, '2025-05-09 21:10:23'),
(39, 'products', 'UPDATE', 0, '', 'product_id=3, name=Motor Oil, price=40', 'product_id=3, name=Motor Oil, price=40', NULL, '2025-05-09 21:10:23'),
(40, 'sales', 'INSERT', 0, '', NULL, 'sales_id=821, product_id=10, quantity_sold=3', NULL, '2025-05-09 21:10:23'),
(41, 'products', 'UPDATE', 0, '', 'product_id=10, name=Gasoline Engine Oil, price=230', 'product_id=10, name=Gasoline Engine Oil, price=230', NULL, '2025-05-09 21:10:23'),
(42, 'sales', 'INSERT', 0, '', NULL, 'sales_id=822, product_id=1, quantity_sold=3', NULL, '2025-05-09 21:10:23'),
(43, 'products', 'UPDATE', 0, '', 'product_id=1, name=Gear Oil, price=90', 'product_id=1, name=Gear Oil, price=90', NULL, '2025-05-09 21:10:23'),
(44, 'invoice', 'INSERT', 0, '', NULL, 'invoice_id=282, total_sales=2150, payment=3000', NULL, '2025-05-09 21:11:41'),
(45, 'sales', 'INSERT', 0, '', NULL, 'sales_id=823, product_id=21, quantity_sold=3', NULL, '2025-05-09 21:11:41'),
(46, 'products', 'UPDATE', 0, '', 'product_id=21, name=Transmission Fluid, price=230', 'product_id=21, name=Transmission Fluid, price=230', NULL, '2025-05-09 21:11:41'),
(47, 'sales', 'INSERT', 0, '', NULL, 'sales_id=824, product_id=35, quantity_sold=1', NULL, '2025-05-09 21:11:42'),
(48, 'products', 'UPDATE', 0, '', 'product_id=35, name=Lock Washer, price=2', 'product_id=35, name=Lock Washer, price=2', NULL, '2025-05-09 21:11:42'),
(49, 'sales', 'INSERT', 0, '', NULL, 'sales_id=825, product_id=48, quantity_sold=3', NULL, '2025-05-09 21:11:42'),
(50, 'products', 'UPDATE', 0, '', 'product_id=48, name=Bearing, price=170', 'product_id=48, name=Bearing, price=170', NULL, '2025-05-09 21:11:42'),
(51, 'sales', 'INSERT', 0, '', NULL, 'sales_id=826, product_id=70, quantity_sold=4', NULL, '2025-05-09 21:11:42'),
(52, 'products', 'UPDATE', 0, '', 'product_id=70, name=Plug-in Fuse, price=10', 'product_id=70, name=Plug-in Fuse, price=10', NULL, '2025-05-09 21:11:42'),
(53, 'sales', 'INSERT', 0, '', NULL, 'sales_id=827, product_id=90, quantity_sold=3', NULL, '2025-05-09 21:11:42'),
(54, 'products', 'UPDATE', 0, '', 'product_id=90, name=Silicon Radiator Cap, price=120', 'product_id=90, name=Silicon Radiator Cap, price=120', NULL, '2025-05-09 21:11:42'),
(55, 'invoice', 'INSERT', 0, '', NULL, 'invoice_id=283, total_sales=90, payment=900', NULL, '2025-05-09 21:12:25'),
(56, 'sales', 'INSERT', 0, '', NULL, 'sales_id=828, product_id=1, quantity_sold=1', NULL, '2025-05-09 21:12:25'),
(57, 'products', 'UPDATE', 0, '', 'product_id=1, name=Gear Oil, price=90', 'product_id=1, name=Gear Oil, price=90', NULL, '2025-05-09 21:12:25'),
(58, 'invoice', 'INSERT', 0, '', NULL, 'invoice_id=284, total_sales=660, payment=5000', NULL, '2025-05-09 21:12:56'),
(59, 'sales', 'INSERT', 0, '', NULL, 'sales_id=829, product_id=1, quantity_sold=3', NULL, '2025-05-09 21:12:56'),
(60, 'products', 'UPDATE', 0, '', 'product_id=1, name=Gear Oil, price=90', 'product_id=1, name=Gear Oil, price=90', NULL, '2025-05-09 21:12:56'),
(62, 'invoice', 'INSERT', 286, 'total_sales', NULL, '540', NULL, '2025-05-09 22:18:11'),
(63, 'invoice', 'INSERT', 286, 'discount', NULL, NULL, NULL, '2025-05-09 22:18:11'),
(64, 'invoice', 'INSERT', 286, 'customer_payment', NULL, '600', NULL, '2025-05-09 22:18:11'),
(65, 'invoice', 'INSERT', 286, 'customer_change', NULL, '60', NULL, '2025-05-09 22:18:11'),
(66, 'invoice', 'INSERT', 286, 'date', NULL, '2025-05-10', NULL, '2025-05-09 22:18:11'),
(67, 'invoice', 'INSERT', 286, 'time', NULL, '06:18:11', NULL, '2025-05-09 22:18:11'),
(68, 'invoice', 'INSERT', 287, 'total_sales', NULL, '120', NULL, '2025-05-09 22:21:41'),
(69, 'invoice', 'INSERT', 287, 'discount', NULL, NULL, NULL, '2025-05-09 22:21:41'),
(70, 'invoice', 'INSERT', 287, 'customer_payment', NULL, '200', NULL, '2025-05-09 22:21:41'),
(71, 'invoice', 'INSERT', 287, 'customer_change', NULL, '80', NULL, '2025-05-09 22:21:41'),
(72, 'invoice', 'INSERT', 287, 'date', NULL, '2025-05-10', NULL, '2025-05-09 22:21:41'),
(73, 'invoice', 'INSERT', 287, 'time', NULL, '06:21:41', NULL, '2025-05-09 22:21:41'),
(74, 'products', 'UPDATE', 2, 'quantity', '15', '12', NULL, '2025-05-09 22:21:41'),
(75, 'sales', 'INSERT', 832, 'product_id', NULL, '2', NULL, '2025-05-09 22:21:41'),
(76, 'sales', 'INSERT', 832, 'invoice_id', NULL, '287', NULL, '2025-05-09 22:21:41'),
(77, 'sales', 'INSERT', 832, 'quantity_sold', NULL, '3', NULL, '2025-05-09 22:21:41'),
(78, 'sales', 'INSERT', 832, 'purchase_sale', NULL, '120', NULL, '2025-05-09 22:21:41'),
(79, 'products', 'UPDATE', 2, 'quantity', '12', '15', NULL, '2025-05-09 22:21:56'),
(80, 'products', 'INSERT', 129, 'product_name', NULL, 'test', NULL, '2025-05-09 22:22:47'),
(81, 'products', 'INSERT', 129, 'additional_name', NULL, 'test', NULL, '2025-05-09 22:22:47'),
(82, 'products', 'INSERT', 129, 'type', NULL, 'test', NULL, '2025-05-09 22:22:47'),
(83, 'products', 'INSERT', 129, 'brand', NULL, 'test', NULL, '2025-05-09 22:22:47'),
(84, 'products', 'INSERT', 129, 'price', NULL, '19', NULL, '2025-05-09 22:22:47'),
(85, 'products', 'INSERT', 129, 'quantity', NULL, '19', NULL, '2025-05-09 22:22:47'),
(86, 'products', 'INSERT', 129, 'location', NULL, 'test', NULL, '2025-05-09 22:22:47'),
(87, 'products', 'INSERT', 129, 'image', NULL, 'BLOB inserted', NULL, '2025-05-09 22:22:47'),
(88, 'products', 'INSERT', 129, 'description', NULL, 'test test test', NULL, '2025-05-09 22:22:47'),
(89, 'products', 'DELETE', 129, 'product_name', 'test', NULL, NULL, '2025-05-09 22:22:57'),
(90, 'products', 'DELETE', 129, 'additional_name', 'test', NULL, NULL, '2025-05-09 22:22:57'),
(91, 'products', 'DELETE', 129, 'type', 'test', NULL, NULL, '2025-05-09 22:22:57'),
(92, 'products', 'DELETE', 129, 'brand', 'test', NULL, NULL, '2025-05-09 22:22:57'),
(93, 'products', 'DELETE', 129, 'price', '19', NULL, NULL, '2025-05-09 22:22:57'),
(94, 'products', 'DELETE', 129, 'quantity', '19', NULL, NULL, '2025-05-09 22:22:57'),
(95, 'products', 'DELETE', 129, 'location', 'test', NULL, NULL, '2025-05-09 22:22:57'),
(96, 'products', 'DELETE', 129, 'image', 'BLOB deleted', NULL, NULL, '2025-05-09 22:22:57'),
(97, 'products', 'DELETE', 129, 'description', 'test test test', NULL, NULL, '2025-05-09 22:22:57'),
(98, 'products', 'INSERT', 130, 'product_name', NULL, 'test', NULL, '2025-05-09 23:00:36'),
(99, 'products', 'INSERT', 130, 'additional_name', NULL, '', NULL, '2025-05-09 23:00:36'),
(100, 'products', 'INSERT', 130, 'type', NULL, '', NULL, '2025-05-09 23:00:36'),
(101, 'products', 'INSERT', 130, 'brand', NULL, '', NULL, '2025-05-09 23:00:36'),
(102, 'products', 'INSERT', 130, 'price', NULL, '90', NULL, '2025-05-09 23:00:36'),
(103, 'products', 'INSERT', 130, 'quantity', NULL, '90', NULL, '2025-05-09 23:00:36'),
(104, 'products', 'INSERT', 130, 'location', NULL, '', NULL, '2025-05-09 23:00:36'),
(105, 'products', 'INSERT', 130, 'image', NULL, 'BLOB inserted', NULL, '2025-05-09 23:00:36'),
(106, 'products', 'INSERT', 130, 'description', NULL, '', NULL, '2025-05-09 23:00:36'),
(107, 'products', 'UPDATE', 130, 'brand', '', '70s', NULL, '2025-05-09 23:00:50'),
(108, 'products', 'DELETE', 130, 'product_name', 'test', NULL, NULL, '2025-05-09 23:00:56'),
(109, 'products', 'DELETE', 130, 'additional_name', '', NULL, NULL, '2025-05-09 23:00:56'),
(110, 'products', 'DELETE', 130, 'type', '', NULL, NULL, '2025-05-09 23:00:56'),
(111, 'products', 'DELETE', 130, 'brand', '70s', NULL, NULL, '2025-05-09 23:00:56'),
(112, 'products', 'DELETE', 130, 'price', '90', NULL, NULL, '2025-05-09 23:00:56'),
(113, 'products', 'DELETE', 130, 'quantity', '90', NULL, NULL, '2025-05-09 23:00:56'),
(114, 'products', 'DELETE', 130, 'location', '', NULL, NULL, '2025-05-09 23:00:56'),
(115, 'products', 'DELETE', 130, 'image', 'BLOB deleted', NULL, NULL, '2025-05-09 23:00:56'),
(116, 'products', 'DELETE', 130, 'description', '', NULL, NULL, '2025-05-09 23:00:56'),
(117, 'invoice', 'INSERT', 288, 'total_sales', NULL, '120', NULL, '2025-05-10 05:36:00'),
(118, 'invoice', 'INSERT', 288, 'discount', NULL, NULL, NULL, '2025-05-10 05:36:00'),
(119, 'invoice', 'INSERT', 288, 'customer_payment', NULL, '150', NULL, '2025-05-10 05:36:00'),
(120, 'invoice', 'INSERT', 288, 'customer_change', NULL, '30', NULL, '2025-05-10 05:36:00'),
(121, 'invoice', 'INSERT', 288, 'date', NULL, '2025-05-10', NULL, '2025-05-10 05:36:00'),
(122, 'invoice', 'INSERT', 288, 'time', NULL, '13:36:00', NULL, '2025-05-10 05:36:00'),
(123, 'products', 'UPDATE', 2, 'quantity', '15', '12', NULL, '2025-05-10 05:36:00'),
(124, 'sales', 'INSERT', 833, 'product_id', NULL, '2', NULL, '2025-05-10 05:36:00'),
(125, 'sales', 'INSERT', 833, 'invoice_id', NULL, '288', NULL, '2025-05-10 05:36:00'),
(126, 'sales', 'INSERT', 833, 'quantity_sold', NULL, '3', NULL, '2025-05-10 05:36:00'),
(127, 'sales', 'INSERT', 833, 'purchase_sale', NULL, '120', NULL, '2025-05-10 05:36:00'),
(128, 'invoice', 'INSERT', 289, 'total_sales', NULL, '350', NULL, '2025-05-10 05:36:19'),
(129, 'invoice', 'INSERT', 289, 'discount', NULL, NULL, NULL, '2025-05-10 05:36:19'),
(130, 'invoice', 'INSERT', 289, 'customer_payment', NULL, '400', NULL, '2025-05-10 05:36:19'),
(131, 'invoice', 'INSERT', 289, 'customer_change', NULL, '50', NULL, '2025-05-10 05:36:19'),
(132, 'invoice', 'INSERT', 289, 'date', NULL, '2025-05-10', NULL, '2025-05-10 05:36:19'),
(133, 'invoice', 'INSERT', 289, 'time', NULL, '13:36:19', NULL, '2025-05-10 05:36:19'),
(134, 'products', 'UPDATE', 123, 'quantity', '250', '245', NULL, '2025-05-10 05:36:19'),
(135, 'sales', 'INSERT', 834, 'product_id', NULL, '123', NULL, '2025-05-10 05:36:19'),
(136, 'sales', 'INSERT', 834, 'invoice_id', NULL, '289', NULL, '2025-05-10 05:36:19'),
(137, 'sales', 'INSERT', 834, 'quantity_sold', NULL, '5', NULL, '2025-05-10 05:36:19'),
(138, 'sales', 'INSERT', 834, 'purchase_sale', NULL, '350', NULL, '2025-05-10 05:36:19'),
(139, 'invoice', 'INSERT', 290, 'total_sales', NULL, '980', NULL, '2025-05-10 05:51:47'),
(140, 'invoice', 'INSERT', 290, 'discount', NULL, NULL, NULL, '2025-05-10 05:51:47'),
(141, 'invoice', 'INSERT', 290, 'customer_payment', NULL, '1000', NULL, '2025-05-10 05:51:47'),
(142, 'invoice', 'INSERT', 290, 'customer_change', NULL, '20', NULL, '2025-05-10 05:51:47'),
(143, 'invoice', 'INSERT', 290, 'date', NULL, '2025-05-10', NULL, '2025-05-10 05:51:47'),
(144, 'invoice', 'INSERT', 290, 'time', NULL, '13:51:47', NULL, '2025-05-10 05:51:47'),
(145, 'products', 'UPDATE', 1, 'quantity', '13', '10', NULL, '2025-05-10 05:51:47'),
(146, 'sales', 'INSERT', 835, 'product_id', NULL, '1', NULL, '2025-05-10 05:51:47'),
(147, 'sales', 'INSERT', 835, 'invoice_id', NULL, '290', NULL, '2025-05-10 05:51:47'),
(148, 'sales', 'INSERT', 835, 'quantity_sold', NULL, '3', NULL, '2025-05-10 05:51:47'),
(149, 'sales', 'INSERT', 835, 'purchase_sale', NULL, '120', NULL, '2025-05-10 05:51:47'),
(150, 'products', 'UPDATE', 3, 'quantity', '11', '7', NULL, '2025-05-10 05:51:47'),
(151, 'sales', 'INSERT', 836, 'product_id', NULL, '3', NULL, '2025-05-10 05:51:47'),
(152, 'sales', 'INSERT', 836, 'invoice_id', NULL, '290', NULL, '2025-05-10 05:51:47'),
(153, 'sales', 'INSERT', 836, 'quantity_sold', NULL, '4', NULL, '2025-05-10 05:51:47'),
(154, 'sales', 'INSERT', 836, 'purchase_sale', NULL, '860', NULL, '2025-05-10 05:51:47'),
(155, 'products', 'UPDATE', 3, 'quantity', '7', '10', NULL, '2025-05-10 05:54:06'),
(156, 'products', 'UPDATE', 3, 'image', 'IMAGE CHANGED', 'IMAGE CHANGED', NULL, '2025-05-10 05:54:06'),
(157, 'invoice', 'INSERT', 291, 'total_sales', NULL, '250', NULL, '2025-05-17 00:40:59'),
(158, 'invoice', 'INSERT', 291, 'discount', NULL, NULL, NULL, '2025-05-17 00:40:59'),
(159, 'invoice', 'INSERT', 291, 'customer_payment', NULL, '300', NULL, '2025-05-17 00:40:59'),
(160, 'invoice', 'INSERT', 291, 'customer_change', NULL, '50', NULL, '2025-05-17 00:40:59'),
(161, 'invoice', 'INSERT', 291, 'date', NULL, '2025-05-17', NULL, '2025-05-17 00:40:59'),
(162, 'invoice', 'INSERT', 291, 'time', NULL, '08:40:59', NULL, '2025-05-17 00:40:59'),
(163, 'products', 'UPDATE', 1, 'quantity', '10', '9', NULL, '2025-05-17 00:40:59'),
(164, 'sales', 'INSERT', 837, 'product_id', NULL, '1', NULL, '2025-05-17 00:40:59'),
(165, 'sales', 'INSERT', 837, 'invoice_id', NULL, '291', NULL, '2025-05-17 00:40:59'),
(166, 'sales', 'INSERT', 837, 'quantity_sold', NULL, '1', NULL, '2025-05-17 00:40:59'),
(167, 'sales', 'INSERT', 837, 'purchase_sale', NULL, '90', NULL, '2025-05-17 00:40:59'),
(168, 'products', 'UPDATE', 2, 'quantity', '12', '11', NULL, '2025-05-17 00:40:59'),
(169, 'sales', 'INSERT', 838, 'product_id', NULL, '2', NULL, '2025-05-17 00:40:59'),
(170, 'sales', 'INSERT', 838, 'invoice_id', NULL, '291', NULL, '2025-05-17 00:40:59'),
(171, 'sales', 'INSERT', 838, 'quantity_sold', NULL, '1', NULL, '2025-05-17 00:40:59'),
(172, 'sales', 'INSERT', 838, 'purchase_sale', NULL, '40', NULL, '2025-05-17 00:40:59'),
(173, 'products', 'UPDATE', 3, 'quantity', '10', '7', NULL, '2025-05-17 00:40:59'),
(174, 'sales', 'INSERT', 839, 'product_id', NULL, '3', NULL, '2025-05-17 00:40:59'),
(175, 'sales', 'INSERT', 839, 'invoice_id', NULL, '291', NULL, '2025-05-17 00:40:59'),
(176, 'sales', 'INSERT', 839, 'quantity_sold', NULL, '3', NULL, '2025-05-17 00:40:59'),
(177, 'sales', 'INSERT', 839, 'purchase_sale', NULL, '120', NULL, '2025-05-17 00:40:59'),
(178, 'products', 'UPDATE', 3, 'image', 'IMAGE CHANGED', 'IMAGE CHANGED', NULL, '2025-05-17 00:43:07'),
(179, 'invoice', 'INSERT', 292, 'total_sales', NULL, '870', NULL, '2025-05-17 01:12:37'),
(180, 'invoice', 'INSERT', 292, 'discount', NULL, NULL, NULL, '2025-05-17 01:12:37'),
(181, 'invoice', 'INSERT', 292, 'customer_payment', NULL, '1000', NULL, '2025-05-17 01:12:37'),
(182, 'invoice', 'INSERT', 292, 'customer_change', NULL, '130', NULL, '2025-05-17 01:12:37'),
(183, 'invoice', 'INSERT', 292, 'date', NULL, '2025-05-17', NULL, '2025-05-17 01:12:37'),
(184, 'invoice', 'INSERT', 292, 'time', NULL, '09:12:37', NULL, '2025-05-17 01:12:37'),
(185, 'products', 'UPDATE', 13, 'quantity', '15', '12', NULL, '2025-05-17 01:12:37'),
(186, 'sales', 'INSERT', 840, 'product_id', NULL, '13', NULL, '2025-05-17 01:12:37'),
(187, 'sales', 'INSERT', 840, 'invoice_id', NULL, '292', NULL, '2025-05-17 01:12:37'),
(188, 'sales', 'INSERT', 840, 'quantity_sold', NULL, '3', NULL, '2025-05-17 01:12:37'),
(189, 'sales', 'INSERT', 840, 'purchase_sale', NULL, '630', NULL, '2025-05-17 01:12:37'),
(190, 'products', 'UPDATE', 5, 'quantity', '15', '13', NULL, '2025-05-17 01:12:37'),
(191, 'sales', 'INSERT', 841, 'product_id', NULL, '5', NULL, '2025-05-17 01:12:37'),
(192, 'sales', 'INSERT', 841, 'invoice_id', NULL, '292', NULL, '2025-05-17 01:12:37'),
(193, 'sales', 'INSERT', 841, 'quantity_sold', NULL, '2', NULL, '2025-05-17 01:12:37'),
(194, 'sales', 'INSERT', 841, 'purchase_sale', NULL, '200', NULL, '2025-05-17 01:12:37'),
(195, 'products', 'UPDATE', 3, 'quantity', '7', '6', NULL, '2025-05-17 01:12:37'),
(196, 'sales', 'INSERT', 842, 'product_id', NULL, '3', NULL, '2025-05-17 01:12:37'),
(197, 'sales', 'INSERT', 842, 'invoice_id', NULL, '292', NULL, '2025-05-17 01:12:37'),
(198, 'sales', 'INSERT', 842, 'quantity_sold', NULL, '1', NULL, '2025-05-17 01:12:37'),
(199, 'sales', 'INSERT', 842, 'purchase_sale', NULL, '40', NULL, '2025-05-17 01:12:37'),
(200, 'products', 'INSERT', 131, 'product_name', NULL, 'test', NULL, '2025-05-17 01:14:05'),
(201, 'products', 'INSERT', 131, 'additional_name', NULL, 'test', NULL, '2025-05-17 01:14:05'),
(202, 'products', 'INSERT', 131, 'type', NULL, 'test', NULL, '2025-05-17 01:14:05'),
(203, 'products', 'INSERT', 131, 'brand', NULL, 'test', NULL, '2025-05-17 01:14:05'),
(204, 'products', 'INSERT', 131, 'price', NULL, '10', NULL, '2025-05-17 01:14:05'),
(205, 'products', 'INSERT', 131, 'quantity', NULL, '10', NULL, '2025-05-17 01:14:05'),
(206, 'products', 'INSERT', 131, 'location', NULL, 'test', NULL, '2025-05-17 01:14:05'),
(207, 'products', 'INSERT', 131, 'image', NULL, 'BLOB inserted', NULL, '2025-05-17 01:14:05'),
(208, 'products', 'INSERT', 131, 'description', NULL, 'test test test', NULL, '2025-05-17 01:14:05'),
(209, 'products', 'UPDATE', 131, 'price', '10', '1000', NULL, '2025-05-17 01:14:24'),
(210, 'products', 'DELETE', 131, 'product_name', 'test', NULL, NULL, '2025-05-17 01:14:30'),
(211, 'products', 'DELETE', 131, 'additional_name', 'test', NULL, NULL, '2025-05-17 01:14:30'),
(212, 'products', 'DELETE', 131, 'type', 'test', NULL, NULL, '2025-05-17 01:14:30'),
(213, 'products', 'DELETE', 131, 'brand', 'test', NULL, NULL, '2025-05-17 01:14:30'),
(214, 'products', 'DELETE', 131, 'price', '1000', NULL, NULL, '2025-05-17 01:14:30'),
(215, 'products', 'DELETE', 131, 'quantity', '10', NULL, NULL, '2025-05-17 01:14:30'),
(216, 'products', 'DELETE', 131, 'location', 'test', NULL, NULL, '2025-05-17 01:14:30'),
(217, 'products', 'DELETE', 131, 'image', 'BLOB deleted', NULL, NULL, '2025-05-17 01:14:30'),
(218, 'products', 'DELETE', 131, 'description', 'test test test', NULL, NULL, '2025-05-17 01:14:30');

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE `invoice` (
  `invoice_id` int(11) NOT NULL,
  `total_sales` double NOT NULL,
  `discount` double DEFAULT NULL,
  `customer_payment` double NOT NULL,
  `customer_change` double NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `invoice`
--

INSERT INTO `invoice` (`invoice_id`, `total_sales`, `discount`, `customer_payment`, `customer_change`, `date`, `time`) VALUES
(3, 724, 0, 1000, 276, '2025-05-04', '09:04:14'),
(4, 485, 0, 500, 15, '2025-05-04', '13:10:13'),
(5, 280, 0, 600, 320, '2025-05-04', '14:23:52'),
(6, 1425.38, NULL, 1535.01, 109.63, '2025-04-04', '08:51:30'),
(7, 996.0999999999999, NULL, 1035.51, 39.41, '2025-04-04', '13:18:48'),
(8, 3111.5899999999997, NULL, 3260.96, 149.37, '2025-04-04', '15:47:16'),
(9, 4405.1900000000005, NULL, 4494.51, 89.32, '2025-04-04', '18:15:52'),
(10, 3879.7799999999997, NULL, 3977.98, 98.2, '2025-04-04', '12:11:53'),
(11, 895.2, NULL, 984.97, 89.77, '2025-04-04', '12:02:44'),
(12, 1202.85, NULL, 1226.65, 23.8, '2025-04-04', '14:56:36'),
(13, 1969.81, NULL, 2168.2, 198.39, '2025-04-04', '15:13:42'),
(14, 5695.91, NULL, 5765.23, 69.32, '2025-04-04', '09:53:22'),
(15, 457.11, NULL, 598.43, 141.32, '2025-04-04', '09:58:08'),
(16, 1873.78, NULL, 1906.57, 32.79, '2025-04-04', '10:11:16'),
(17, 2332.3100000000004, NULL, 2437.18, 104.87, '2025-04-05', '18:13:42'),
(18, 2501.2, NULL, 2602.85, 101.65, '2025-04-05', '08:24:08'),
(19, 1181.54, NULL, 1302.06, 120.52, '2025-04-05', '11:55:44'),
(20, 272.31, NULL, 334.38, 62.07, '2025-04-05', '15:35:30'),
(21, 2567.48, NULL, 2706.02, 138.54, '2025-04-05', '08:56:11'),
(22, 4498.98, NULL, 4669.09, 170.11, '2025-04-05', '12:31:33'),
(23, 265.34, NULL, 336.49, 71.15, '2025-04-05', '09:15:47'),
(24, 1716.76, NULL, 1774.65, 57.89, '2025-04-05', '18:57:00'),
(25, 1684.98, NULL, 1771.02, 86.04, '2025-04-06', '16:32:01'),
(26, 4088.07, NULL, 4147.95, 59.88, '2025-04-06', '13:43:01'),
(27, 63.33, NULL, 130.9, 67.57, '2025-04-06', '07:37:29'),
(28, 3733.3199999999997, NULL, 3880.7, 147.38, '2025-04-06', '06:49:10'),
(29, 1342.8, NULL, 1419.86, 77.06, '2025-04-06', '18:33:45'),
(30, 4067.57, NULL, 4254.54, 186.97, '2025-04-06', '10:37:27'),
(31, 1370.95, NULL, 1420.52, 49.57, '2025-04-06', '15:04:44'),
(32, 3712.6099999999997, NULL, 3854.68, 142.07, '2025-04-06', '07:05:22'),
(33, 3876.24, NULL, 4033.33, 157.09, '2025-04-06', '10:58:26'),
(34, 3088.2699999999995, NULL, 3287.31, 199.04, '2025-04-06', '17:12:50'),
(35, 470.18, NULL, 632.19, 162.01, '2025-04-07', '18:26:35'),
(36, 254.7, NULL, 380.13, 125.43, '2025-04-07', '09:22:16'),
(37, 641.36, NULL, 830.46, 189.1, '2025-04-07', '14:19:16'),
(38, 264.61, NULL, 314.2, 49.59, '2025-04-07', '11:00:12'),
(39, 4957.84, NULL, 4982.3, 24.46, '2025-04-07', '15:09:29'),
(40, 1510.08, NULL, 1613.28, 103.2, '2025-04-07', '18:10:01'),
(41, 2592.04, NULL, 2778.21, 186.17, '2025-04-07', '08:45:52'),
(42, 2240.64, NULL, 2281.37, 40.73, '2025-04-08', '17:34:34'),
(43, 1155.48, NULL, 1186.73, 31.25, '2025-04-08', '16:42:38'),
(44, 1820.25, NULL, 1968.79, 148.54, '2025-04-08', '18:28:34'),
(45, 3820.26, NULL, 3975.08, 154.82, '2025-04-08', '08:05:10'),
(46, 2265.9300000000003, NULL, 2399.1, 133.17, '2025-04-08', '18:49:51'),
(47, 1462.04, NULL, 1522.18, 60.14, '2025-04-08', '07:31:26'),
(48, 94.08, NULL, 215.5, 121.42, '2025-04-08', '07:09:13'),
(49, 1739.04, NULL, 1884.03, 144.99, '2025-04-08', '12:10:25'),
(50, 3899.5, NULL, 4040.87, 141.37, '2025-04-09', '13:07:14'),
(51, 4583.37, NULL, 4635.91, 52.54, '2025-04-09', '12:41:14'),
(52, 1741.74, NULL, 1796.78, 55.04, '2025-04-09', '09:43:19'),
(53, 1088.35, NULL, 1262.94, 174.59, '2025-04-09', '14:22:20'),
(54, 1905.92, NULL, 1957.34, 51.42, '2025-04-09', '17:23:50'),
(55, 1829.2400000000002, NULL, 2020.67, 191.43, '2025-04-09', '10:05:35'),
(56, 2851.4700000000003, NULL, 2904.17, 52.7, '2025-04-09', '11:49:52'),
(57, 281.28, NULL, 445.53, 164.25, '2025-04-09', '17:19:39'),
(58, 158.16, NULL, 220.46, 62.3, '2025-04-09', '10:19:21'),
(59, 608.76, NULL, 619.15, 10.39, '2025-04-09', '09:15:33'),
(60, 4628.93, NULL, 4773.11, 144.18, '2025-04-10', '09:46:51'),
(61, 2330.78, NULL, 2432.55, 101.77, '2025-04-10', '06:11:08'),
(62, 1355.02, NULL, 1507.45, 152.43, '2025-04-10', '13:27:45'),
(63, 3634.51, NULL, 3671.98, 37.47, '2025-04-10', '07:00:17'),
(64, 3967.8599999999997, NULL, 4144.78, 176.92, '2025-04-10', '13:58:28'),
(65, 1084.13, NULL, 1273.04, 188.91, '2025-04-10', '17:01:42'),
(66, 974.3100000000001, NULL, 1151.46, 177.15, '2025-04-10', '15:56:10'),
(67, 240.57, NULL, 251.68, 11.11, '2025-04-10', '13:14:56'),
(68, 539.52, NULL, 592.21, 52.69, '2025-04-10', '17:10:41'),
(69, 2929.81, NULL, 3024.14, 94.33, '2025-04-10', '16:10:57'),
(70, 2384.24, NULL, 2574.94, 190.7, '2025-04-10', '06:06:12'),
(71, 2926.23, NULL, 3052.94, 126.71, '2025-04-11', '09:28:28'),
(72, 714.03, NULL, 870.32, 156.29, '2025-04-11', '09:58:02'),
(73, 506.95, NULL, 582.02, 75.07, '2025-04-11', '14:30:52'),
(74, 87.51, NULL, 128.76, 41.25, '2025-04-11', '16:46:24'),
(75, 1608.42, NULL, 1661.37, 52.95, '2025-04-11', '16:11:42'),
(76, 3477.12, NULL, 3522.43, 45.31, '2025-04-11', '08:49:14'),
(77, 2517.09, NULL, 2626.13, 109.04, '2025-04-11', '10:23:49'),
(78, 4889.450000000001, NULL, 4989.89, 100.44, '2025-04-11', '08:04:42'),
(79, 2383.55, NULL, 2490.9, 107.35, '2025-04-11', '12:30:54'),
(80, 2789.94, NULL, 2882.78, 92.84, '2025-04-11', '13:03:55'),
(81, 2480.6, NULL, 2658.43, 177.83, '2025-04-11', '17:17:47'),
(82, 1092.15, NULL, 1224.66, 132.51, '2025-04-11', '06:56:00'),
(83, 3990.9999999999995, NULL, 4004.01, 13.01, '2025-04-12', '18:31:28'),
(84, 381, NULL, 570.52, 189.52, '2025-04-12', '13:30:36'),
(85, 1440.86, NULL, 1620.99, 180.13, '2025-04-12', '15:50:38'),
(86, 4014.48, NULL, 4202.21, 187.73, '2025-04-12', '09:09:29'),
(87, 4588.52, NULL, 4634.67, 46.15, '2025-04-12', '10:52:24'),
(88, 1022.59, NULL, 1186.46, 163.87, '2025-04-12', '09:38:57'),
(89, 3946.23, NULL, 4141.98, 195.75, '2025-04-12', '16:47:06'),
(90, 890.64, NULL, 1059.32, 168.68, '2025-04-12', '11:52:35'),
(91, 2589.87, NULL, 2742.59, 152.72, '2025-04-12', '07:51:10'),
(92, 3806.26, NULL, 3968.88, 162.62, '2025-04-12', '17:31:34'),
(93, 1966.57, NULL, 2017.6, 51.03, '2025-04-13', '08:27:39'),
(94, 2043.53, NULL, 2185.52, 141.99, '2025-04-13', '12:25:06'),
(95, 3279.33, NULL, 3457.45, 178.12, '2025-04-13', '10:32:03'),
(96, 1789.0900000000001, NULL, 1968.02, 178.93, '2025-04-13', '07:58:17'),
(97, 1687.22, NULL, 1710.19, 22.97, '2025-04-13', '11:37:40'),
(98, 1068.3, NULL, 1215.32, 147.02, '2025-04-14', '10:44:45'),
(99, 2634.04, NULL, 2655.63, 21.59, '2025-04-14', '10:49:09'),
(100, 3653.04, NULL, 3820.19, 167.15, '2025-04-14', '07:53:01'),
(101, 320.66, NULL, 485.33, 164.67, '2025-04-14', '06:48:25'),
(102, 2027.04, NULL, 2219.02, 191.98, '2025-04-14', '06:37:09'),
(103, 3649.7200000000003, NULL, 3837.31, 187.59, '2025-04-14', '07:30:53'),
(104, 2929.1400000000003, NULL, 2958.33, 29.19, '2025-04-14', '16:34:00'),
(105, 3487.19, NULL, 3639.56, 152.37, '2025-04-14', '06:23:23'),
(106, 4748.420000000001, NULL, 4797.79, 49.37, '2025-04-14', '12:15:58'),
(107, 1925.9700000000003, NULL, 1977.59, 51.62, '2025-04-14', '16:54:59'),
(108, 605.7399999999999, NULL, 750.28, 144.54, '2025-04-14', '07:34:44'),
(109, 4471.430000000001, NULL, 4539.17, 67.74, '2025-04-14', '16:59:27'),
(110, 4041.79, NULL, 4146.76, 104.97, '2025-04-15', '11:03:39'),
(111, 147.01, NULL, 312.3, 165.29, '2025-04-15', '12:22:42'),
(112, 2267.61, NULL, 2463.1, 195.49, '2025-04-15', '10:36:43'),
(113, 1313.5500000000002, NULL, 1452.29, 138.74, '2025-04-15', '08:36:29'),
(114, 432.04, NULL, 570.16, 138.12, '2025-04-15', '10:40:55'),
(115, 2657.8799999999997, NULL, 2831.86, 173.98, '2025-04-15', '17:45:27'),
(116, 2632.76, NULL, 2668.5, 35.74, '2025-04-16', '09:16:28'),
(117, 3809.89, NULL, 3857.61, 47.72, '2025-04-16', '18:33:12'),
(118, 442.92, NULL, 456.59, 13.67, '2025-04-16', '09:30:22'),
(119, 1488.56, NULL, 1510.98, 22.42, '2025-04-16', '13:37:02'),
(120, 535.3, NULL, 562.68, 27.38, '2025-04-16', '13:55:01'),
(121, 3644.9300000000003, NULL, 3729.78, 84.85, '2025-04-17', '14:57:56'),
(122, 47.39, NULL, 195.91, 148.52, '2025-04-17', '17:10:45'),
(123, 114.43, NULL, 127.84, 13.41, '2025-04-17', '17:34:26'),
(124, 2897.01, NULL, 2968.24, 71.23, '2025-04-17', '09:31:53'),
(125, 2249.98, NULL, 2278.57, 28.59, '2025-04-17', '09:38:16'),
(126, 2963.9700000000003, NULL, 3092.95, 128.98, '2025-04-17', '17:57:20'),
(127, 3666.0599999999995, NULL, 3720.07, 54.01, '2025-04-17', '14:30:11'),
(128, 381, NULL, 475.15, 94.15, '2025-04-17', '08:16:12'),
(129, 707.2800000000001, NULL, 749.76, 42.48, '2025-04-17', '07:55:03'),
(130, 1281.03, NULL, 1317.05, 36.02, '2025-04-17', '09:05:42'),
(131, 1754.6, NULL, 1899.64, 145.04, '2025-04-17', '09:45:05'),
(132, 3908.31, NULL, 4064.2, 155.89, '2025-04-18', '18:12:56'),
(133, 2137.58, NULL, 2206.29, 68.71, '2025-04-18', '14:44:13'),
(134, 2207.1499999999996, NULL, 2339, 131.85, '2025-04-18', '09:23:16'),
(135, 2232.05, NULL, 2275.24, 43.19, '2025-04-18', '15:44:22'),
(136, 2858.0299999999997, NULL, 3025.09, 167.06, '2025-04-18', '15:45:29'),
(137, 1975.45, NULL, 2026.72, 51.27, '2025-04-19', '10:29:47'),
(138, 2223.92, NULL, 2418.52, 194.6, '2025-04-19', '18:24:02'),
(139, 2255.24, NULL, 2438.65, 183.41, '2025-04-19', '11:30:03'),
(140, 1729.32, NULL, 1763.45, 34.13, '2025-04-19', '07:23:18'),
(141, 2791.56, NULL, 2852.91, 61.35, '2025-04-19', '16:25:22'),
(142, 1962.17, NULL, 2153.8, 191.63, '2025-04-19', '09:01:28'),
(143, 4467.26, NULL, 4646.49, 179.23, '2025-04-19', '10:14:59'),
(144, 1582.95, NULL, 1728.03, 145.08, '2025-04-19', '08:43:50'),
(145, 233.32, NULL, 268.82, 35.5, '2025-04-19', '17:06:47'),
(146, 600.87, NULL, 783.94, 183.07, '2025-04-20', '06:50:51'),
(147, 1120.2, NULL, 1253.14, 132.94, '2025-04-20', '10:59:15'),
(148, 60.22, NULL, 229.06, 168.84, '2025-04-20', '13:39:44'),
(149, 6154.969999999999, NULL, 6232.59, 77.62, '2025-04-20', '09:27:01'),
(150, 2266.33, NULL, 2324.4, 58.07, '2025-04-20', '08:42:32'),
(151, 1673.86, NULL, 1731.09, 57.23, '2025-04-20', '17:48:04'),
(152, 509.58, NULL, 545.3, 35.72, '2025-04-20', '14:21:53'),
(153, 189.20999999999998, NULL, 289.61, 100.4, '2025-04-20', '12:17:47'),
(154, 1420.01, NULL, 1450.55, 30.54, '2025-04-20', '13:23:33'),
(155, 5364.25, NULL, 5417.5, 53.25, '2025-04-21', '16:57:18'),
(156, 4665.28, NULL, 4800.52, 135.24, '2025-04-21', '13:19:48'),
(157, 63.33, NULL, 242.6, 179.27, '2025-04-21', '06:23:58'),
(158, 3617.07, NULL, 3756.19, 139.12, '2025-04-21', '10:07:09'),
(159, 1149.37, NULL, 1240.35, 90.98, '2025-04-21', '13:03:14'),
(160, 2202.6, NULL, 2354.97, 152.37, '2025-04-22', '18:28:32'),
(161, 1466.4399999999998, NULL, 1581.72, 115.28, '2025-04-22', '15:53:11'),
(162, 1541.85, NULL, 1604.95, 63.1, '2025-04-22', '11:24:58'),
(163, 116.56, NULL, 144.92, 28.36, '2025-04-22', '07:38:16'),
(164, 1018.5799999999999, NULL, 1150.54, 131.96, '2025-04-22', '18:05:49'),
(165, 2656.7200000000003, NULL, 2793.32, 136.6, '2025-04-22', '18:59:04'),
(166, 3451.44, NULL, 3620.06, 168.62, '2025-04-23', '16:36:58'),
(167, 3558.87, NULL, 3598.1, 39.23, '2025-04-23', '17:28:26'),
(168, 2210.59, NULL, 2325.29, 114.7, '2025-04-23', '16:35:50'),
(169, 3559.17, NULL, 3629.33, 70.16, '2025-04-23', '18:45:56'),
(170, 894.02, NULL, 1068.99, 174.97, '2025-04-23', '12:15:57'),
(171, 933.6499999999999, NULL, 1116.08, 182.43, '2025-04-23', '10:53:35'),
(172, 3090.47, NULL, 3150.35, 59.88, '2025-04-23', '11:21:23'),
(173, 2430.09, NULL, 2557.45, 127.36, '2025-04-23', '13:06:55'),
(174, 1869.91, NULL, 2022.92, 153.01, '2025-04-23', '18:07:58'),
(175, 2895.88, NULL, 3022.05, 126.17, '2025-04-23', '15:20:47'),
(176, 422.12, NULL, 453.89, 31.77, '2025-04-23', '12:31:37'),
(177, 6329.3, NULL, 6461.77, 132.47, '2025-04-23', '06:04:39'),
(178, 320.66, NULL, 409.17, 88.51, '2025-04-24', '16:14:50'),
(179, 1455.54, NULL, 1646.39, 190.85, '2025-04-24', '12:12:56'),
(180, 3102.8199999999997, NULL, 3258.74, 155.92, '2025-04-24', '06:19:30'),
(181, 5600.910000000001, NULL, 5763.87, 162.96, '2025-04-24', '14:53:00'),
(182, 1213.1000000000001, NULL, 1397.2, 184.1, '2025-04-24', '13:05:19'),
(183, 3314.1800000000003, NULL, 3392.77, 78.59, '2025-04-24', '08:37:27'),
(184, 2980.3099999999995, NULL, 3062.93, 82.62, '2025-04-24', '12:18:44'),
(185, 3369.74, NULL, 3459.65, 89.91, '2025-04-25', '13:34:51'),
(186, 673.75, NULL, 828.62, 154.87, '2025-04-25', '07:20:39'),
(187, 2884.09, NULL, 2995.77, 111.68, '2025-04-25', '06:52:01'),
(188, 977.46, NULL, 1084.59, 107.13, '2025-04-25', '08:33:16'),
(189, 641.36, NULL, 699.55, 58.19, '2025-04-25', '07:09:41'),
(190, 873.49, NULL, 906.26, 32.77, '2025-04-25', '14:31:39'),
(191, 844.24, NULL, 940.16, 95.92, '2025-04-25', '12:25:42'),
(192, 1370.95, NULL, 1457.16, 86.21, '2025-04-25', '08:49:03'),
(193, 1696.95, NULL, 1780.66, 83.71, '2025-04-25', '06:32:01'),
(194, 2432.16, NULL, 2550.92, 118.76, '2025-04-25', '17:06:11'),
(195, 1678.3600000000001, NULL, 1730.54, 52.18, '2025-04-25', '17:55:54'),
(196, 731.3199999999999, NULL, 916.35, 185.03, '2025-04-26', '10:23:54'),
(197, 1621.6799999999998, NULL, 1753.75, 132.07, '2025-04-26', '06:03:11'),
(198, 1725.54, NULL, 1884.22, 158.68, '2025-04-26', '13:36:07'),
(199, 672.76, NULL, 770.11, 97.35, '2025-04-26', '12:40:10'),
(200, 701.13, NULL, 791.5, 90.37, '2025-04-26', '18:01:21'),
(201, 3617.8999999999996, NULL, 3810.77, 192.87, '2025-04-26', '12:53:11'),
(202, 3569.82, NULL, 3704.25, 134.43, '2025-04-26', '16:00:51'),
(203, 718.22, NULL, 728.83, 10.61, '2025-04-27', '08:17:12'),
(204, 2175.18, NULL, 2342.75, 167.57, '2025-04-27', '14:41:15'),
(205, 2561.57, NULL, 2754.5, 192.93, '2025-04-27', '09:43:52'),
(206, 4050.2200000000003, NULL, 4070.63, 20.41, '2025-04-27', '16:17:25'),
(207, 1942.05, NULL, 2133.11, 191.06, '2025-04-27', '08:06:04'),
(208, 491.39, NULL, 621.41, 130.02, '2025-04-27', '11:39:19'),
(209, 1659.41, NULL, 1727.87, 68.46, '2025-04-27', '09:42:59'),
(210, 2240.66, NULL, 2348.11, 107.45, '2025-04-27', '14:42:07'),
(211, 1562.5500000000002, NULL, 1677.43, 114.88, '2025-04-27', '07:32:17'),
(212, 2388.3199999999997, NULL, 2489.15, 100.83, '2025-04-28', '06:24:08'),
(213, 1456.2, NULL, 1493.82, 37.62, '2025-04-28', '17:57:11'),
(214, 1224.17, NULL, 1331.27, 107.1, '2025-04-28', '15:59:51'),
(215, 3149.87, NULL, 3263.36, 113.49, '2025-04-28', '18:46:48'),
(216, 800.69, NULL, 978.98, 178.29, '2025-04-28', '07:18:41'),
(217, 2823.23, NULL, 2859.08, 35.85, '2025-04-28', '08:03:35'),
(218, 1352.28, NULL, 1364.26, 11.98, '2025-04-28', '13:35:16'),
(219, 1450.06, NULL, 1571.22, 121.16, '2025-04-28', '06:40:59'),
(220, 2225.37, NULL, 2383.53, 158.16, '2025-04-28', '11:12:11'),
(221, 3521.25, NULL, 3576.72, 55.47, '2025-04-28', '18:56:50'),
(222, 2795.1899999999996, NULL, 2841.82, 46.63, '2025-04-28', '15:09:39'),
(223, 2100.63, NULL, 2121.82, 21.19, '2025-04-28', '08:51:41'),
(224, 727.7099999999999, NULL, 880.32, 152.61, '2025-04-29', '18:53:17'),
(225, 4927.95, NULL, 5116.48, 188.53, '2025-04-29', '09:49:13'),
(226, 379.43, NULL, 479.38, 99.95, '2025-04-29', '08:32:55'),
(227, 3781.62, NULL, 3805.32, 23.7, '2025-04-29', '10:50:35'),
(228, 5334.790000000001, NULL, 5411.66, 76.87, '2025-04-29', '10:38:47'),
(229, 3369.44, NULL, 3499.51, 130.07, '2025-04-29', '15:21:36'),
(230, 1662.42, NULL, 1687.53, 25.11, '2025-04-29', '13:11:52'),
(231, 2631.15, NULL, 2680.99, 49.84, '2025-04-29', '08:17:18'),
(232, 4018.81, NULL, 4043.63, 24.82, '2025-04-30', '07:03:41'),
(233, 2351.23, NULL, 2428.67, 77.44, '2025-04-30', '10:23:44'),
(234, 3156.6099999999997, NULL, 3328.89, 172.28, '2025-04-30', '18:17:12'),
(235, 992.12, NULL, 1134.8, 142.68, '2025-04-30', '10:13:35'),
(236, 822.51, NULL, 925.9, 103.39, '2025-04-30', '12:25:35'),
(237, 3676.09, NULL, 3692.58, 16.49, '2025-04-30', '07:27:00'),
(238, 452.87, NULL, 465.29, 12.42, '2025-04-30', '12:34:20'),
(239, 1135.52, NULL, 1230.09, 94.57, '2025-04-30', '06:07:48'),
(240, 4886.29, NULL, 5059.92, 173.63, '2025-04-30', '10:12:53'),
(241, 1570.12, NULL, 1637.74, 67.62, '2025-04-30', '08:20:07'),
(242, 953.42, NULL, 1089.98, 136.56, '2025-04-30', '12:24:47'),
(243, 3511.26, NULL, 3573.45, 62.19, '2025-05-01', '09:26:31'),
(244, 788.64, NULL, 816.22, 27.58, '2025-05-01', '12:45:33'),
(245, 4433.6900000000005, NULL, 4622.65, 188.96, '2025-05-01', '13:23:20'),
(246, 2639.46, NULL, 2749.93, 110.47, '2025-05-01', '12:02:48'),
(247, 3621.7, NULL, 3668.79, 47.09, '2025-05-01', '08:43:35'),
(248, 3650.96, NULL, 3729.01, 78.05, '2025-05-01', '17:06:39'),
(249, 4094.46, NULL, 4220.33, 125.87, '2025-05-02', '10:42:02'),
(250, 1437.5, NULL, 1565.35, 127.85, '2025-05-02', '13:10:11'),
(251, 2694.91, NULL, 2849.37, 154.46, '2025-05-02', '11:09:39'),
(252, 5427.070000000001, NULL, 5527.47, 100.4, '2025-05-02', '10:42:16'),
(253, 1272.63, NULL, 1380.26, 107.63, '2025-05-02', '14:43:41'),
(254, 453.96, NULL, 633.94, 179.98, '2025-05-02', '16:54:46'),
(255, 1599.99, NULL, 1611.45, 11.46, '2025-05-02', '11:21:20'),
(256, 2319.59, NULL, 2442.08, 122.49, '2025-05-02', '07:24:04'),
(257, 2985.96, NULL, 3143.26, 157.3, '2025-05-02', '08:57:09'),
(258, 885.84, NULL, 1018.29, 132.45, '2025-05-03', '18:50:23'),
(259, 1530.72, NULL, 1627, 96.28, '2025-05-03', '15:44:14'),
(260, 1973.54, NULL, 2170.42, 196.88, '2025-05-03', '13:53:20'),
(261, 265.62, NULL, 335.12, 69.5, '2025-05-03', '17:44:59'),
(262, 3093.74, NULL, 3245.89, 152.15, '2025-05-03', '18:45:21'),
(263, 2581.48, NULL, 2591.9, 10.42, '2025-05-03', '10:46:49'),
(264, 3319.53, NULL, 3370.58, 51.05, '2025-05-03', '12:24:48'),
(265, 275.68, NULL, 461.24, 185.56, '2025-05-03', '14:45:54'),
(266, 467.05, NULL, 516.29, 49.24, '2025-05-03', '12:08:41'),
(267, 2358.7200000000003, NULL, 2394.84, 36.12, '2025-05-03', '15:57:21'),
(268, 1125.12, NULL, 1187.66, 62.54, '2025-05-03', '06:31:19'),
(269, 2419.98, NULL, 2610, 190.02, '2025-05-03', '06:42:42'),
(270, 200, NULL, 800, 600, '2025-05-05', '21:02:46'),
(271, 2500, NULL, 5000, 2500, '2025-05-05', '21:07:37'),
(272, 750, NULL, 800, 50, '2025-05-05', '21:09:01'),
(273, 450, NULL, 900, 450, '2025-05-05', '21:09:30'),
(274, 1250, NULL, 2000, 750, '2025-05-07', '20:22:42'),
(275, 280, NULL, 500, 220, '2025-05-07', '23:34:07'),
(276, 1440, NULL, 8000, 6560, '2025-05-07', '23:34:54'),
(277, 630, NULL, 700, 70, '2025-05-08', '09:45:23'),
(278, 1246, NULL, 1300, 54, '2025-05-08', '09:49:42'),
(279, 825, NULL, 900, 75, '2025-05-08', '12:02:52'),
(280, 255, NULL, 300, 45, '2025-05-08', '13:56:53'),
(281, 1120, NULL, 2000, 880, '2025-05-10', '05:10:23'),
(282, 2150, NULL, 3000, 850, '2025-05-10', '05:11:41'),
(283, 90, NULL, 900, 810, '2025-05-10', '05:12:25'),
(284, 660, NULL, 5000, 4340, '2025-05-10', '05:12:56'),
(286, 540, NULL, 600, 60, '2025-05-10', '06:18:11'),
(287, 120, NULL, 200, 80, '2025-05-10', '06:21:41'),
(288, 120, NULL, 150, 30, '2025-05-10', '13:36:00'),
(289, 350, NULL, 400, 50, '2025-05-10', '13:36:19'),
(290, 980, NULL, 1000, 20, '2025-05-10', '13:51:47'),
(291, 250, NULL, 300, 50, '2025-05-17', '08:40:59'),
(292, 870, NULL, 1000, 130, '2025-05-17', '09:12:37');

--
-- Triggers `invoice`
--
DELIMITER $$
CREATE TRIGGER `trg_invoice_after_delete` AFTER DELETE ON `invoice` FOR EACH ROW BEGIN
  INSERT INTO audit_log VALUES
    (NULL, 'invoice', 'DELETE', OLD.invoice_id, 'total_sales', OLD.total_sales, NULL, @user, NOW()),
    (NULL, 'invoice', 'DELETE', OLD.invoice_id, 'discount', OLD.discount, NULL, @user, NOW()),
    (NULL, 'invoice', 'DELETE', OLD.invoice_id, 'customer_payment', OLD.customer_payment, NULL, @user, NOW()),
    (NULL, 'invoice', 'DELETE', OLD.invoice_id, 'customer_change', OLD.customer_change, NULL, @user, NOW()),
    (NULL, 'invoice', 'DELETE', OLD.invoice_id, 'date', OLD.date, NULL, @user, NOW()),
    (NULL, 'invoice', 'DELETE', OLD.invoice_id, 'time', OLD.time, NULL, @user, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_invoice_after_insert` AFTER INSERT ON `invoice` FOR EACH ROW BEGIN
  INSERT INTO audit_log VALUES
    (NULL, 'invoice', 'INSERT', NEW.invoice_id, 'total_sales', NULL, NEW.total_sales, @user, NOW()),
    (NULL, 'invoice', 'INSERT', NEW.invoice_id, 'discount', NULL, NEW.discount, @user, NOW()),
    (NULL, 'invoice', 'INSERT', NEW.invoice_id, 'customer_payment', NULL, NEW.customer_payment, @user, NOW()),
    (NULL, 'invoice', 'INSERT', NEW.invoice_id, 'customer_change', NULL, NEW.customer_change, @user, NOW()),
    (NULL, 'invoice', 'INSERT', NEW.invoice_id, 'date', NULL, NEW.date, @user, NOW()),
    (NULL, 'invoice', 'INSERT', NEW.invoice_id, 'time', NULL, NEW.time, @user, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_invoice_after_update` AFTER UPDATE ON `invoice` FOR EACH ROW BEGIN
  IF NOT (OLD.total_sales <=> NEW.total_sales) THEN
    INSERT INTO audit_log VALUES (NULL, 'invoice', 'UPDATE', NEW.invoice_id, 'total_sales', OLD.total_sales, NEW.total_sales, @user, NOW());
  END IF;

  IF NOT (OLD.discount <=> NEW.discount) THEN
    INSERT INTO audit_log VALUES (NULL, 'invoice', 'UPDATE', NEW.invoice_id, 'discount', OLD.discount, NEW.discount, @user, NOW());
  END IF;

  IF NOT (OLD.customer_payment <=> NEW.customer_payment) THEN
    INSERT INTO audit_log VALUES (NULL, 'invoice', 'UPDATE', NEW.invoice_id, 'customer_payment', OLD.customer_payment, NEW.customer_payment, @user, NOW());
  END IF;

  IF NOT (OLD.customer_change <=> NEW.customer_change) THEN
    INSERT INTO audit_log VALUES (NULL, 'invoice', 'UPDATE', NEW.invoice_id, 'customer_change', OLD.customer_change, NEW.customer_change, @user, NOW());
  END IF;

  IF NOT (OLD.date <=> NEW.date) THEN
    INSERT INTO audit_log VALUES (NULL, 'invoice', 'UPDATE', NEW.invoice_id, 'date', OLD.date, NEW.date, @user, NOW());
  END IF;

  IF NOT (OLD.time <=> NEW.time) THEN
    INSERT INTO audit_log VALUES (NULL, 'invoice', 'UPDATE', NEW.invoice_id, 'time', OLD.time, NEW.time, @user, NOW());
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `newsales`
-- (See below for the actual view)
--
CREATE TABLE `newsales` (
`invoice_id` int(11)
,`product_name` varchar(50)
,`additional_name` varchar(50)
,`type` varchar(50)
,`brand` varchar(50)
,`price` double
,`quantity_sold` int(11)
,`purchase_sale` double
);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(50) NOT NULL,
  `additional_name` varchar(50) DEFAULT NULL,
  `type` varchar(50) NOT NULL,
  `brand` varchar(50) NOT NULL,
  `price` double NOT NULL,
  `quantity` int(11) NOT NULL,
  `location` varchar(50) NOT NULL,
  `image` longblob DEFAULT NULL,
  `description` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `additional_name`, `type`, `brand`, `price`, `quantity`, `location`, `image`, `description`) VALUES
(1, 'Gear Oil', 'Scooter Oil', '120ml', 'Petron', 90, 9, 'Shelf A1', NULL, ''),
(2, 'Motor Oil', '2T', '200ml', 'Petron', 40, 11, 'Shelf A1', NULL, '');
INSERT INTO `products` (`product_id`, `product_name`, `additional_name`, `type`, `brand`, `price`, `quantity`, `location`, `image`, `description`) VALUES
(3, 'Motor Oil', '4T', '200ml', 'Petron', 40, 6, 'Shelf A1', 0xffd8ffe000104a46494600010200000100010000ffdb004300080606070605080707070909080a0c140d0c0b0b0c1912130f141d1a1f1e1d1a1c1c20242e2720222c231c1c2837292c30313434341f27393d38323c2e333432ffdb0043010909090c0b0c180d0d1832211c213232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232323232ffc00011080400040003012200021101031101ffc4001f0000010501010101010100000000000000000102030405060708090a0bffc400b5100002010303020403050504040000017d01020300041105122131410613516107227114328191a1082342b1c11552d1f02433627282090a161718191a25262728292a3435363738393a434445464748494a535455565758595a636465666768696a737475767778797a838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae1e2e3e4e5e6e7e8e9eaf1f2f3f4f5f6f7f8f9faffc4001f0100030101010101010101010000000000000102030405060708090a0bffc400b51100020102040403040705040400010277000102031104052131061241510761711322328108144291a1b1c109233352f0156272d10a162434e125f11718191a262728292a35363738393a434445464748494a535455565758595a636465666768696a737475767778797a82838485868788898a92939495969798999aa2a3a4a5a6a7a8a9aab2b3b4b5b6b7b8b9bac2c3c4c5c6c7c8c9cad2d3d4d5d6d7d8d9dae2e3e4e5e6e7e8e9eaf2f3f4f5f6f7f8f9faffda000c03010002110311003f00f5ef4a051450014506802800a5a43c51400a6928a2800a28fc681400b451da8eb40094b498fca96800a28a4a00518a3340eb462800a5ef494b40051494b400514514000a28a4f4a005a28a2800a28a3b74a0053ed4bda90668340051819eb494b40071de8a3028a003145141e940052f7a29334007ad19a28a002968a074a00296928a002969282680168a3ad25002d14628a003a5145140052d20a28016928a2800a28a280168a28a0028eb494bd28017f95149476a005a3345140052f6a4a075a005cf5a3b5251400628a33477a005c719a4cd0294500147e141eb41340098a5cd20a280141a0d19a3ad0019a5a434b4009452d2500068c7349cd2f6a0008a28cd2f41400520a3b525003a928268cd001c51450680109a5e68e3341a00434a29297a8a0009c51d68eb462800c7bd18e73476a334007bd1da8ed403c5002d14945001474a28a0028c5033450026297bd1475a003ad1d28ed450029e9494b49400b4537269d9e2800a38f5a4a28016928068eb40074a3a9141eb49400b8e68a33450057a28a0f4a00293d3d697a5140075a5a69a5cd001da814b498a003f9d1451400b49da8a5ed4009ed473452d00068a28a00052f6a4a01e68013bd2e7a5149400b9a3345140052d149400bde8a293bd002f7a2938cd2d0014679a2941a003bd04d25140052e73d29334bd2800e828028c8a2800e9452d14009450696800a4a3bd1da80168149d296800038a3341eb450014628fe54b40051451400514946280168a28a0028c51450014514a680128a297140094b4525002d14514005145079a00052e69297340051da8a2800a28a2800a28e94a3140094529a4a0053d2928a2800c628a33475a0033f952e7d28ed49d050029e9467f3a4fc68ef400b4679a4e334bde8016939a28cd0018f5a33475a5c5002738a28a0d00252e39a0d28a004a5c5274a3340075a0d1fce92800a338a5c525002d19a38e28a005a4fad1476a003028cd2d34d002f7a5a406814005068a2800cf14668a5ed400521e28340eb4000ef41a3e8293ad003b38a43cd14b4009d28ce3ad1de81400b4633451400d030297e9451400628c52d25001d334671c521340a00ae0d2d252d00147e14519a0028ed451400668a2b94f197882e3484b682ca4d93c84bb3601c28ff1351526a11e667461b0d3c4d554a1bb3abed457937fc269af7fcfeffe38bfe147fc269af7fcfeff00e435ff000ae7fae43b1ec7fabb89eebfaf91eb23bd19af26ff0084d35eff009fdffc86bfe147fc269af7fcfeff00e38bfe147d729f60ff0057313dd7f5f23d6734b5e4bff09a6bdff3fbff0090d7fc28ff0084d35eff009fdffc86bfe147d721d83fd5cc4f75fd7c8f5aa4af27ff0084d35eff009fdffc7168ff0084d35eff009fdffc86bfe147d721d83fd5dc4f75fd7c8f591f5a2bc97fe134d7bfe7f7ff0021aff851ff0009a6bdff003fbff90d7fc28fae53ec1feae627bafebe47acd19af26ff84d35eff9fdff00c86bfe14bff09a6bdff3fbff0090d7fc28fae53ec1feaee27bafebe47ace7068ef5e4dff0009a6bdff003fbff90d7fc293fe134d7bfe7f7ff21ad1f5c8760ff57713dd7f5f23d6a8e95e4bff0009a6bdff003fbff90d7fc297fe135d7bfe7f7ff21aff00851f5ca7d83fd5dc4f75fd7c8f59e3ad15e4dff09aebdff3fbff0090d7fc293fe134d7b3ff001fbff90d7fc28fae53ec1feaee27bafebe47ad52e6b9cf07eb72eb3a649f69937dd42f8738c641e86ba3ae98494e3cc8f171142742a3a73dd051451546214519a3bd00068a297ad0007d68ed47b518e4500146702968a002928cd140075a5a4e82968012968a33400514525002fbd1da8a280168a4a33cd0014b4945002d149da8a005a28a2800cd14bde8eb4000a28a2800a4a5a2800a28a280168a31474a0028a4a5a0028028a2800a28a2800eb46297da8ef4000a28a41c1a004a5a31c71450014b48681400bd68ef49de8c9a0029693bd2f71400018a33451f85002d2679a28c73400503814b486801690d14b4001e45277a09c503939a0029690d28e940094519a0d00266978347e7450018f7a3a5277a339a00334bde8c5250029a2933450028c62928141e4d002f340c5251400bde8e28a4a00334a69074a52322800cd038a4a319a005ee6969283c5002514518a0033cd2d2500d003a909c51d29280179cd1ec4d1462800e29334bd6931c50057a28ce28cd001474fa51de9280169693d28e73400b5e3be24d47fb535db99c12630db23ff7471fe27f1af49f13ea5fd99a05cccadb6571e5c6475dc7bfe0327f0af20ae0c64f681f57c3986f8abbf45fa85157749b13a96ab6d6601c4ae0363b2f53fa66bd1bfe105d0ffe794dff007f7ffad5cd4a84aa2ba3d9c66674309251a97bb3cb28af53ff00841744ff009e537fdfdffeb51ff082e87ff3ca7ffbfbff00d6ad3ea750e3ff005870bd9fdc796515ea7ff082689ff3ca7ffbfbff00d6a3fe105d0ffe794dff007f7ffad47d4ea07fac385ecfee3cb28af54ff841343ff9e537fdfdff00eb51ff00082e87ff003ca6ff00bfbffd6a3ea7503fd61c2f67f71e57457a9ffc20ba1ffcf29bfefeff00f5a97fe104d0ff00e794ff00f7f7ff00ad47d4ea07fac385ecfee3cae8af53ff00841743ff009e53ff00dfdffeb52ffc20ba1ffcf29bfefeff00f5a8fa9d40ff005870bd9fdc795d15ea9ff082687ff3ca6ffbfbff00d6a3fe104d0ffe794dff007f7ffad47d4ea07fac385ecfee3cae8af54ff841343ff9e53ffdfdff00eb51ff00082e87ff003ca6ff00bfbffd6a3ea7503fd61c2767f71e57457a56a3e05d3469f706ce3956e15098c97ce48e718f7e95e6bd3835955a32a7b9e860b1f4b189ba7d0e8fc15a97d835f8e3770b15c8f29b3ebfc3faff003af57c62bc1d1da37574386520a91d88af6ad22fd754d26daf17199106e03b37423f3aecc1cee9c0f9ee23c372ce35d75d197a8a28aed3e6033cd1494bde800a5ed4945002e68a414bda800a281d28a0028ed47e3499a00776a4cf141a3de800f6a5a3d28a000d145140051451de800a28a3340052d252d001de8eb4519a0038a0d19a5c500252d26297b500145149400b4514500145145001de94d2514001e940a294500145140a003b529a4e28a0028cd2d25002e693a93451400514628e9400bf4a4ea68a280173c519a6e696800079a33cd2f6a4ef400b8e68346681d2800e68e869692801693ad19e297d28010f6a3228273450021a5028eb4038a000514679c52d002753494bd28a0043d28a0d1400b8a4a283400a29281466800a6d3a8c50020a5a3145001da8a28a003b51499e28079a00776a4ed4525001f5a2940a28017349451400a2933c734b9a4a004a5a4a339a00703498a4a5a0001a33476a280014b9a3da93bf1401589a0518a5e6800a29297ad001da83f5a3b5473cd1dbdbc934a7091a9663ec287a0e29b76479efc40d4bcfd421d3d1be58177b81fde3d3f4fe75c7558bfbb92fefe7ba90e5a572c7fa557af16acf9e6d9fa4e0b0eb0f878d3ecb53b6f87961beeaeb5061c44be527d4f27f4c576fa9ea769a458497b7d308a08fa93d49f403b9f6aa7e19d3ce9be1fb58180f3197cc7fa9e6bcc3e27eb6d7daf8d36373e459a8dc01e0c84649fc0607e75ea508724123e1734c47d631529f4d97c8bfa87c5bbb3391a769d0ac20f0d39259bf2e055bd17e2ba4b32c5ac59ac2ac71e7c0490bf553cfe55e57456c79e7d3b14a9344b2c6eaf1b80caca72083d0d3fbd79dfc2ad69ae74eb8d2667cbda90f164ff01ea3f03fcebd1280014d9254850bc8c1547734ec80327818ae7af2e9ae66273f203f28a00b72eb1c910c7f8b542356b907a21fc2a88e4e075a90c132aee689c2fa91401ab6faac72305957613dc74ad1079ac7d3f4ff003089a61f27f0a9ef5b1400b55751d46d74ab196f2f6658a08c6598f7f61ea7daacd7907c55d69ae75787498d9bcab55df20ec643fe03f9d005ad4be2ddc19cae99a7c6220787b86259bf01d2a7d23e2d6f9d23d5ec9238d8f335b9276fb953d7f0af2da2803e9cb7b886eede3b8b7916486450c8ea7208af27f16e9bfd9bafceaa3114dfbd4fa1ea3f039ad0f84fad1922bad1a6933b3f7d029f4e8c07e383f8d743e3dd37ed7a3a5e20fde5ab64ff00b87aff00435cf89a7cd0bf63d8c9315ec314a2f6968799577df0f3522c973a6b91f2fef63fe4c3f97eb5c0d68687a81d2f59b6bb1f755f0e3d54f07f4af3a8cf92699f5f9961beb186943aeebd4f6af5a2914820107208c823bd2d7b27e72d5b40c5141145020a2933466801d49de8a280149a05251da801718a4a5cd25002d149da8c5002834668cf028eb400b452668a00296933814a334005145140052d14940052d145001f85028e828a005a29296800a28a2800a28345002d275a31834b40075a4345140094b4b477a0028a28a00297b7149466800cd1451400514521a005a338a41eb4b400b9e6929692800a28a28017141a4cd1400669734945002d21a4a5fc680171499a5ed49400514a05068010514118a3bf140077a28ef45000697a74a4a28017349d79a28a00296928a0051d69297b52500140a28a00506933451400671484d23024605222955c31c9a007629075a5a4a005a28a05002d14514001a07bd145001f4a3bd18a28002293bd2939a2800a29296800a0d1e945002734b47d28a00addfa52d373da9d400514514001e95cb78eb51fb268a2d518092e9b691df60e4d7515e53e32d47edfe209554e62b71e5263d4753f9ff2ae7c4cf961ea7af92e1bdbe2937b47539fad4f0ee9e753d76dadf198c36f93fdd1c9acbaefbe1e586d8ae75065e58f9519f61c9fe95e750873cd23ebf33c47d5f0d29adf6475baa6a11693a55d5fcb8d90465f1d33e83f3c0af9c6e6e24bbba96e663ba595cbb9f524e4d7abfc57d58c1a55ae9687e6b97f324c1fe05e9f99fe55e475ec9f9c8515b1e19d09fc47adc5a7ac9e52b2b3bc9b73b540eb8fae2b32e6de4b4ba9ada518922728c3d0838a00d7f086ae745f13d9dd758d9bca90671f2b707fa1afa0f8ec735f3057bff82b57fed9f0ada4ec499a25f26524e4965e33f88c1a00d8be7296529070718ae7aba2bd43259caa3aedc8ae768035f4ab751119d972c4e013d85691ac9d32ed23530c8428272a49fd2b51a4445dccea147524d003a8a1595d4329054f423bd2f7a0082f6ee2b0b19ef26388a08da463ec066be6fd42f65d4750b8bc989324f2176cf6c9e9f874fc2bd73e296b1f62d023d3a36225bd7f9b1fdc5e4fe6703f3af1aa0028ad4f0ee8d26bfae5b69c84a895be7703eea8e49aa9a859c9a7ea373672e77c1234672319c1c67fad005df0d6aeda27886cefc1c2248049ee8786fd39fc2be869638af2d5e26c343321527d4115f31d7bbfc3dd5ceade13b70ec0cd6bfb87f5c0fba7f2c7e468dc716e2d3479cea166fa7ea17169267742e5327b8ec7f2aad5db7c43d37cabb83514076ca3cb938fe21d0fe55c4d78b561c9368fd270388589c3c6a7dfea7ad783b52fed0f0f4218fef2dff72df8743f97f2ae82bcc7c03a8fd975a6b463fbbba5c0ff007c723fad7a757a7879f3d347c466f86fabe2a496cf50a28a2b73cc0a4c52d14005252d140094529a4c5002d1494b40051451400514b474a0041d6969052d0002945276a506800a28a28016931c514b40094b4034b40094b50dd5cc3676d25c4efb6341926b86bff1ece8edf668a38d7b6ef98d4b9246d4b0f3abf0a3bfa3f9d7934df11f558ffe5ac23dbcb154cfc4cd5f7645ca7d3cb18a9f6b13b6394d767b2e28af186f89dad00713c67fed90a81fe25ebb2907ed057fdc40297b545ac9b10fb1edb4b9e2bc347c4bd75723ed4e7eaa0d0bf1475e4cfeff003ecc8a68f6a8a592625f63dca8af105f8a9af039f3a33f58d78fd28ff85a9ae8eb2c7ff7e97fc28f6c87fd8789f23dbe815e23ff000b4f5d639f3147b0897fc2a45f8a5ae900657fefd2d1ed512f24c4aec7b5d18c578bafc51d715b24c647a18854c3e2b6af9c1820fa98e9fb544bc9b127b0e2815e48bf15f501f7e0b7fc50ff008d4a9f15ae9b1986d7f51fd68f6b125e51895d0f57a3e95e631fc4fb873ff1ef6df8135760f88eeff7ad21fc18d1ed62672cb7111dd1e834560693e2ab3d49d627fdccadd013c1adfab4d3d8e39d3941da482929699fc54c81e051c51d28ed400514a07345001da92968a004a294518a0041de834b8eb476a004c5252f4a2800a3de8a2800a5a4fc28a00339a314528a004f7a3ad04d140062978a4a5cfb5002628a5eb48793400b494b475ed4009da8ed452f7a0038a4a5c5277a0028a28a0028a28a004a43fa53b1c521a003a52d20a5a0028a290d002d2529a0d00252e68a4ef400b451da8a004a28a5a004a5a4346680014bd2928a00af8a28cfa51da800e946297be28a00a1acdf0d3348b9bb382634f941eec7803f3af18662eeccc72c4e49f535ddfc42d47e5b6d390f5fdf3ff21fd6b83af2f173e69f2f63ee320c37b2c3fb47bcbf214024800649ed5ecfa3580d3747b6b41f7a341b8ffb4793fa9af34f08581bff00115be47eee0fdf37e1d3f5c5777e31d60689e18bcb9dd899d7ca87fdf6e3f4adb070d1c8f3f88f13794682e9ab3c7bc69aaff6c78aaf6e1589891bca8b27f8578fe79ac0a323d73ee6a4b785eeae62b78466495c2201ea4e2bb8f973d63e14e906df4bbad56451bae5bcb8ce39d8bd7f335cdfc4fd1fec3e215bf8d408af5771c7f7c70df9f07f135eb7a569e9a56956b611801608c271d091d4fe79ac1f883a47f6af852768d034f6a7cf4f5c0fbc3f2cd0078557a0fc29d605aeaf71a5c8c76dda6f8c678debfe23f9579f559d3ef64d3751b6bd84e248245907e07a5007d2c715857f666094ba0fdd31fcbdab5ad2e62beb382ee024c5346b2267ae08cd4ac030c1008f4c500731456ccba544ed94631fb0e4546ba373f34fc7b2d0056b1be6b66d8df3444fe55bc0e6aa5be9f0dbb06c1761d0b76aa3e29d5bfb13c39797c182caa9b22cf773c0ff001fc2803c77c79acff6cf8aae591f75bdbfee2223a60753f89c9ae6a9492c4963924e49f534b1c6f2c891c6a59dd82aa8ee4f005007a97c26d182c377ac4a9f331f22127d3ab11f8e07e1599f15f48fb36b36fa9c6a765da6d938e03aff0088fe55e9da0e969a36856760a30628c07f763c93f9d67f8df49fed8f0a5e42a333423cf8b8cf2bce3f119a00f00aeebe16eaff0062f11bd8bb0115ea6064ff001af23fa8fc6b84c8f5153d9de49617b05dc2d896090489cf7073401f4478834e1aae89736bfc6577467fda1c8ff0fc6bc68820e08c11d457b76997f16a9a65b5f438f2e78c48307a67b7e06bcbfc61a6ff0066f8826d83114ffbd4e3d7a8fcf35c38ca7a299f51c398ab4a541f5d518904cf6d711cf19c3c6c194fb835edd637697f6305dc67e499038fc6bc36bd1fe1f6a5e769d369ee4ef81b7a67fba7ff00affceb3c1ced2e5ee76710e1bda515556f1fc8ece90d2f6c5257a47c58bda8a28a0028a28a0028a0f34828016814514005028a062801690d2e4521fd2801d452734b4000a4a2968012968a2800cd19a28a005a4607b1a5141a00e47c7b72f169b0448dc3392c3e838af1bd575392394a01cfae6bacf88b7f729e27bc884ee238d136a6781f203d3f1af3bb8b86964667c31c60122b9e6eecfa8cb2872d3527d463dcc921cb31348b300391934c0cbb932a303afbd394a9321d8318e07a56573da5a6c695adcc071ba3c915a49756c17fd4023eb5cea3aac18dbf3eeebed53f9f88d0283bb07273d69dae4b8dcd59af6db6f30e2b367b9898e163a82570523c0e71c9a8d8aec5c0c1ee6937a1a42361ed229e831481c67351b11b460734bc6c1eb59b91add97a2bc8d060c59abb1ea76dc663c7e158df2f95d3e6cf5f6a329e41e0f99bb839ed55cc44926746b7b6ae33e5529b8b5c7fabac18a754b6650a7cc2c083ed4a661f673d77eeeb9ed5464e99ab24968dfc02aa5d456cb1168dfe6ee31549d97eceac33e66ee79ed44a46d88e08561eb4028b4f712398c6e304e3eb5ad65791ef3924563b6c17072bf27a0a7c328489b8c9c8fca9ee138f323b8d32ec8950a1390462bdab4f99ae74eb699f9678c127d4d7cef67a8bc7330418c3a81f8d7b5780b52b8d4fc3624b965668a531a90a07ca029fea6b6a4fa1f379ad069299d39a319a08e28ad8f0828a5c525002e2929475a08a003eb47d29283400bde8a4e681400034bef474a2800e0d18eb47d29314005140a314005145140051d68a01a0031451450014bd681474a004efc52f4a3341340073474a4ce297340077e2838a38cd1da80128a28a0028a28a004cd2d145001ef498a2968013b9a33c507bd277a005e9452d1400631451e949400b49de8cd14001e94b45211cd002f6a293b52fb50021a314bda8a004a0f4a0d06802b0a5e828071466800a42c154963803924d2e6b07c61a8ff67f87e6dad8967fdd263dfa9fcbf9d4ce5cb16d9b61e8bad5634d75679beb7a81d4f59b9bbe76bbe101eca381fa567d14578927cceecfd329d354e0a11d91e8fe00d3cc1a5cd7cea375c3ed53fecaff00f5f35d45d59dadec6a9756f14e8adb82ca81803eb835e28b7132a8559a4551d0072052fdaae3fe7e25ff00bf86bae9e29422a363e7f17914f135a5565537f23d78f86f43ff00a0458ffdf85ff0a75be85a45b4c9341a659c72a1cabac2a083edc578ff00da6e3fe7bcbff7f0d1f69b8ff9ef2ffdfc35a7d757639bfd5a7ff3f3f0ff00827b8d0caae85586548c11ea2bc3bed371ff003de5ff00bf86bbaf006aed2acfa6cf21661fbd88b1c923b8fe47f3aba78a53972dac72e37229e1a8baaa57b791e59e22d25b44d7ef2c0aed48e43e5fba1e57f4e3f0acbaf51f8b3a492967abc69c0fdc4ac3f35cfea2bcbabacf00f62f861ae25cf87df4fb899564b37c26f60328dc8c67d0e7f3aee3ed36ff00f3f10ffdfc5ff1af994123a123e8697737f79bf3a00fa67ed56fff003f10ff00dfc5ff001a51756fff003f10ff00dfc5ff001af997737f79bf3a37b7f79bf3a00fa685d5bffcfc43ff007f17fc6bcb7e2b6b4b3dc5a69304a8f1c63ce976303f31e00e3db9af37dedfde3f9d275a002baef871a47f6a78aa29a45261b31e7371c6ee8a3f3ae46bdb3e1968ff00d9de19fb5c8a44d7ade6723a28e17fa9a00ed3bd07078ed5cbf8e755363a30b689cacd72768c1e428ea7f90fc6bcd3ed371ff3f12ffdf67fc6b96b62553972dae7b980c9678ba5ed5cacbd0f5f3e1bd119893a458e49c9fdc2ff008527fc237a1e3fe41163ff007e17fc2bc87ed371ff003f12ff00df67fc68fb4dc7fcfc4bff007d9ff1acfebabb1dbfead3ff009f9f87fc13dbade086d61482de248a141844418007b015ce78f34efb66882e907ef2d5b77d54f07fa1fc2bcd3ed571ff003f137fdf67fc683713b020cf2907a82e79a8a98b538b8b474617219e1eac6ac6a6de4455b1e18d4bfb2f5eb7999b1139f2e4ff0074ff0081c1fc2b1e8ae48cb95a68fa0ad4955a6e9cb668f79a2b23c31a90d5341b698b6e95479727fbc3ff00ad83f8d6c0af6a32e649a3f33ad49d2a8e9cb74c3b521a296a8c84a28a5a004a5a28a0028a28a0001a28a280168c51d294500275a297349400b451c668eb40098a5a2968012814628a005a0f4a283d0d033c2fe24b0ff84ab52e79da83ff0021ad70527df6aee7e24367c53a9ffbca3ff1d5ae15fef37d6b9a7bb3ecb01a508fa09fc42853c3527f10a41d1ab0bea7712a7dcc7bd4d1825c0ef8355d4e141f7a7abb2f20f38ab4f42d6c0c7803d0535cfcab431e07d291bee8ace5218adf74507ee0a463f28a0fdc159ee50a7ee0a5ff00967f8d27f08a3f829a603d7eefbe6973f2633de9aa3e5fc69483b7f1ad62f40604fc83eb4f77cdbc6bdc647eb4c0a4a0c038cd0e87cb56ed4d90349cc94abf709f71485713107b5395730b1f422945ea068dbb7ef9bfeba2d7b6fc30e7c245bd6e5cff00e3a95e276e999dbd3cc53fa57b6fc313ff00148e3d2e1fff00414ade9ee7879cff0007e6765462968ae83e5c28a41de8a005a292819a0031e8693a75a701494005277a5028e940076a07ad2d2628003476a28f5a004a53d28e3141340066928a5a004a28a2800a2940a3a9a0007d28a5a280131e94628cd2e680128a3eb4500038a3a5046683400945145001d28a3145001da93b52d21fca80168a28e940094dcd3a8a003a8a28a2800cd19a28a0028a281400b4521a3340051451400503a5149400bd739a314519a00ad8a00a50381450015e69e3cd485ceb2b6892663b55c30cf1bcf26bd2eaabe9f6523b3bda40cc4e4968c126b2ad4dd48f2a677e5d8b8616b7b59c6f63c4b23d47e74647a8fcebdb3fb2ec3fe7cadffefd0a5fecbd3ffe7cadff00efd0ae3fa93ee7d07facb4ff0091fde789647a8fce8c8f51f9d7b68d2f4fff009f2b6ffbf4283a5e9fff003e36dff7e851f527dc3fd65a7fc8fef3c4b23d47e74647a8fcebdb7fb334fc7fc78db7fdfa147f66587fcf8db7fdfa147d49f70ff5969ff23fbcf12c8f51f9d5cd2b516d2f54b7bc461fbb7cb0cf55e847e55ec5fd97a7ff00cf95b7fdfa14dfecbb0ff9f1b6ff00bf43fc29ac1c93ba644f88a94e2e12a7a32b6b7a7c3e22f0e5c5aa9dcb7116e89b3fc5d54ff9f5af9de44686468e51b5d49520f1823ad7d3688b1c6a88a15546000381513d95a48c59ed2ddc939cb42a79fcabd05e67ca4ad7d0f99b72ff00797f3a372ff797f3afa5ff00b3ac7fe7c6d7fefc27f851fd9d63ff003e36bff7e13fc2811f346e5fef2fe746e5fef2fe75f4bff67587fcf8daff00df84ff000a069d63ff003e36bff7e13fc2803e68dcbfde5fce8dcbfde5fcebe98feceb1ff9f1b5ff00bf09fe149fd9d63ff3e36bff007e13fc2803e77d1b4d9358d5ed2c22ce67902920670bdcfe02be8f86148208e18976a46a1117d001814d8ad6de160d15bc3191c0291aa91f90a94804107bd0079278bb54fed4d7a528d9820fdd47f8753f9e6b0abd94f86f452493a5db649feeff00f5e93fe11bd13fe8176bff007c7ff5ebcf9e1272936d9f59433ec3d1a71a7183b23c6e8af64ff846f44ffa055aff00df1ffd7a3fe11bd13fe8156bff007c7ff5ea7ea52ee6dfeb250fe4678dd15ec9ff0008de89ff0040ab5ffbe3ff00af47fc235a27fd02ed7fef8ffebd1f529770ff0059287f233c6e8af64ff846b44ffa055aff00df1ffd7a5ff846b44ffa055aff00df1ffd7a3ea52ee1feb250fe5671bf0f751315f4fa7bb7cb32ef407fbc3afe95e8d59f6fa16956b3a4f069f6f1ca872aeab820d68576d184a11e567ce66389a789aeead356b8a28a4a5ad4e00e68a28a0028a28340051494a050014514500028c528a314007d68a5a28012814b477a003a502968a004f5a5a28a000507a1a290f4340cf04f88a7fe2aad57feba0fe4b5c4c9f79feb5da7c47e3c5daa0ffa683ff415ae29fab572d4ea7da60bf811f413ab0a41d1a81f78503a3573df53b4783f2d3b3c0a887dca524ed14f9b41a1cc781437dd1487ee8a0fdd159b658add0507ee8a0f4147f08a9b8c53f7052ff0fe34d3f7451fc029a632546030def5246ea1b2dd09355fa28fad19f97f1ad233132ddbca91f2ddd8d35987d8f6f19cd56c9da2909f945539a22c38b7ef734aad889c7b8a67f1d00fca69465a858d685cf9cdcff1a7f2af6bf85fcf85189e3fd25fff00414af0e849f38e7fe7a27f235ee7f0c54a7836327f8a773fa28ae9a5b9e1e73fc1f99d976a5e9c5145741f2e1da93b52d25001452d0680109a4cf14bc7ad18e2800e68a3e94b40094b484d04d001cf6a296931400b494518e68013ad14b8a3a5002528148697a1a005e69334b494009d682283475a00334bda900a502801690d2d213400669334a05262801693b0a5cf149400678a4a28c5002d2514b400514525002d2628146680024d039a28a00283c514500140a28a0028a4e94bd6800a05145001484d2f6a434006696908a314010668cf7a4a28003eb4007d0d283f9fbd790ff6acafaf5f43e23d6b55d2ee44c440611fba55cf1c7a74e79a067afd155ec032e9f6c1ee45cb0897338ff96871f7b8f5acef164f2db7853539a091a39520255d0e08391408d9ef8a08f5ae5b45bbb897e1b25dc93c8d71f6191fcd2df36769e7347c3ebab8bdf08dbcd753c934a64705e46c93cd00753da8c1f43f952fa57878d6a6306ab24de21d4a1bf8a622d208c961272783e9401edd4a2b3b409ef2e340b09b5152976f0a99411839fa7ae3069dadc8f1683a8cb1b1574b6919581e41da791401a041e983f9525790787b51b6bbb7b57d43c47ae25e34a018a342d19f986067dfbd7af5003873463dab92f88d777363e0f9a7b49a486613c403a36d3c9e99ae67c3baadcbf8cb4fb5d2b58bed4ace48775e0b81c4670738fa1c73ef401ea54b482b8cf88d7ba95969964d6525cc56cd39176f6c3e709818e7b77a00ed0f1d4515c678267b2ba9a7974ff10dedf43e580d6979f7e26c8f9bf98fc6bb2a005e71475e6bceafbc4a346f89d74b7f7b3269eb6cb88c659431453f747e34db8f15c5ac7c40d023d2afa73685cacd1e0aab1e7a8ef401e8f474a41d2b90f1beb7a85a4da6e8fa5c820bad45ca79e7f8172071efcd00762411d88a4af39d6f48d6bc25a6ff006d59f88eeeedadca99e1b9e51c120703d326bbcd32f86a5a5da5f2aed1710acbb7d32338a00b5de94823b7e62b33c452c9078735296276474b7765653820e3ad79259eb97c967a5cfa76bba8dd6af24d89ecd81640b93f9e78fccd007b752d20ce39eb5cbf8faeb56b4f0cbc9a4f9824f3144af10cbac7ce48fc71401d41c8ea3147a579ff00826eec6f7518decfc47a8cf2089bceb0bdc12c71f781ef83e95e81400b47514945002d1477a2800a293b52d001451d281ef400529a4a01e6800a514678a05002d14514000a28a280168ef45140052e28a2800ed49da9690f02803c13e260c78c752c7fb27ff1c4ae1e4fbcd9aeff00e245b4b3f8aefe5850ba10aa71ea1541fd45707347223b064618e3915c950fb4c0b4e847d08bb8a07f151dc503f8ab9d9dc281f2d2f6148a7e5c52e720505203d0507ee8a09e0507a0a8650a7ee8a0f41487a0a09e0549429fba28fe1a0fdd141fbb4d00a3eed2e3e5a01f945283c56910131c0a423e514a0f1484f029e96109fc66940f9693f88d2af41f5a20f511a317faf6ff00ae80ff00e3a6bde3e1d26df06db7fd7493f9e3fa5783c0acf390aa58ef3d07fb35effe03431f842cd4f0dba4241ea32e4ff2c57552dcf033a7fba4bcce9451da8e9462ba0f980a28e94500275a2968a0028a3b520e2800c51dc52d1400514514009f5a29690d0000d2d20e38a5a0028eb45140098a2968340099e69692968013b5147145000781d2901f6a50734719a0043cd28ed41145001de8349de97a9a004a2839c514005140a0d0014773476a4a0028a5a4a0028a28a0033ed494bd05140076a28a4ef400b8a0d19a2801334b4514005028a050014514500145141a00ad476a3a514009dc5713ac786fc4fab5a4ba7cf7ba54f6af21293cb1379d18ce4630319038aede814015749d3d74ad22d34f47675b788461cf538ef4fd46c22d4f4eb9b19c9114f194623a8cf7ab345033cfa3f0a78bad7479344b7d62c0e9cc190332379810f51f77fad75da068f1681a25be9f1b990440ee7231b989c935a5476a0400e79ae67c23e1ab8f0f8d47ed6f6f29b9b8f350a02768e7ae47bd74d4b8a004355752b67bdd2aeed2360af342d1a96e80918e6add1401c3e87a0f8b342b082c21b9d1dade36c92e8e5f04f3ce2bb71c8f7a5a4c7340183e31d0ee3c47e1c974eb59628e57911c34b9c707d81aa5a8f852e9b5ed2759d325821b9b5458ee55f21655000e303ae3239f6aeb28a005ac9d72df59996d9f46bbb78648d9bcd8ee50b24aa40c038e4631fad6ad1fca80391f0d7852f34dd7ef75ad425b313dc26c10d9a111af2093ce3d3f5aebe8a4a00e653c3772be3e9f5f69206b592dc4423392f90aa33d31dbd69754f0ddc5f78c746d6219204b7b1cf9887219baf4c0c574d450020e2b03c55e195f10dbc0f0dc1b5bfb57df6f3819c1f43ed5d0633450070b79e18f15ebd14765adeb1662c030320b58cef931eb9007f4f6aedadede2b4b58ada15db14481117d0018152d250053d5ecdf51d1ef2ce265592785a352dd0123bd53f0b68f2687e1db4d3ee0c4f3c21833c6383962782467bd6c0a3bd002d66eb56da9dcd9a0d26f23b5b94943e654dc8eb820a9f639fd2b4734b401c5e99e13d48f8b535fd565d3e392342ab1d8a300e718cb640aed00e28a2800a5ed49450014b494b400525145002d1451da800a28a2800ed4bd69294500281451450014b494b40051451400b45276a5a00292968a00f1af1a95975abc6c7fcb43cfd2bcd27964695fe76fbc7bd7b778f3c3f6e91bea626f2fcc60ac8578ce3ae7debc7afed608a4cacf1e4f403a1ae6a913eaf2cab174d2466966f5a504e7a034a4283f794fd0d000f51f9d7359dcf610f1dbf760d4870541fb3803d89e69a1b1d31f9d5a40f327caa0e3aee602b4e5451518a6788b6fe34c247f76acc904818e40ff00be8540579aca6adb1686f1e9471e94b8a31596a558518eebfad3818f1ca127eb48169eb1961c7f3ad2316160061c60c4c7fe054b9876e3c939f52d522c07a9031df914be5e7236afd4b74ad5450ac88498bb45f8eea690bd96ad790871f381c739229b2a46b10dacb91fed7268b226e8abd3a01524523ab7017fef9151e57bb55ab55864902ee6dc7a528ee293491b3a6cf2120e7d3b57b6f82486f0ea91ff003d5b3fa5794685a40baba86249234323050643debdab44d33fb2b4c8ed4b2b302598a8e326ba692d6e7cbe6f562d72adcd0c51d052d15b9e089452fa525001c514639a5a004a28a2800228a28a00293bd2d14005252d14008452d145001c5145250014b4751450020a0d2d140094668c51d2800028ce297345001fce928efd28268003d281c5275a28017ad2114a28340099c51d680334639a004ef4b463068a004347e14a46693a50014629681400945145001d28a33450018a0d1450014514500252d14500252d1de8a0028a08a3eb4015beb451d68c50014a28c51ed400739a0f147bd03a5001450296800a3af7a28a0028a4fa51400b4519a4a00294521e942fa1a005f5a33475a31400514b49400b451450019a28ed450014514a2801297145140094b451400514514005145140077a5a4cd2d001494b49400b451450014628a28016969a314bd280168a3bd2d00149452d0018a28a280168a28a0029693340a00cdd7ad96eb43bc8d80388cbf3ea39af9fbc416b0a319047821baad7d03e2097c9d02f9f38fddedfcc815f3ef88660e3683d5ab1aa7bb93deece75b6f6e9f4a4c0cd291462b864f53e96c01569e123ee5a9100cf278f6ab496f0b0ff005e07d455455d0ec8ac513b134dda33c1ab1244a9f7640df41501eb5124d1492136fbd1b7de9696a6e3e54205f734a107f78fe54528a698f950e1147de43ff7cd298e31d246ff00be69062971e82b5560e540a899f98b63d85465724d4817e6c3640ef8151b0018e338f7a99342b00519e6b574f822760bb577f5dd9391594a066b5b4873e795cfca071f5ad29dac67553e53d3fc01a5432eaa2664dc205df923bf6af5115c27c3b5c9ba7cf02303f5aef2bb29ec7c566126ebbb85145156710940a5a28012968a4ef400b494b4500251452d002514b450021a3b518a2800a28a3da800a4a5a2800a28cd14005068a4a005eb451d28c7340094138a314b40076a6f4a5cd1fca80128a28a003af5a51494bda800e94679a314940067345141a0028a3ad14005276a5a4a0028a31814bda801292968a0028a3bd06800a28e9499a005a2803ad140051476a2800eb49da97a5277a00af41a29450019a4ef4b4b814008714507d281c0e6800c62945252d00145149d4d002f41463228a2800145028a004a51452628016814628a005a292968012968a2800c514514007bd14519a00334b4525002d1451400521ed452d00145145001452d140094a29296800cd1451da800a5149403400b4bd69b4e140052d2628a003ad29eb499a28017b51450280168a29280168a4a5a00c8f13c2f37876ed514b1001207a0619af00f105bb46e0ed3f7b9c8afa58a820820104720d729abe8be15bd2e274c49dc5bb7f9159ce373d3cbf19ec1eaae7cec452715dc78a341d034d702caea62d82584acb907f0ae1cc910948218a67aae335c73a7667d4d1c542a47990e1b7bd3b0beb50f9c99eff952f9b1e7827f2a8b3375521dc9081462a332a50255a86996aa47b92d14cf393d68f353d6a6ccbe78f71f8a5c7bd47e727ad1e6a7a9a697742f691ee4bb7de9db07a8a87ce51eb4be70f435aab5839e3dc9368ee690a8a8ccc3d0d219813f74d0edd85ed22481466b5f4c8d4b0080e7bd665b08e43995822e7d6bd1bc1b17875d6459a34bbb81cec694a803f0ad61138f17898d385d2b9d77c388dd45e311f2ec519ed9c9aef2b06c359d2e245823b71669d82a8dbf98adc475750cac0a9e841e0d75c55958f8cc4c9cea39b56b8ecd145154738514514005028a2800a28a2800a28a2800a28a28013bfb5069693ad002d2669692800a5348296801b4b4502800a28a2800cd277a5a3bd001451d292800e334668a31d2800e869294d276a003b514528fd680133451d4d2f4a003a51de8ed4500277a28c668a0028a4a2800a5a0d140094514b400521a5a4a004a3a52d140052f6a4a3b5001477a4f6a5eb4001a29692802bf6e2933c52e2928017ad1de90529e680168a3b506800a28cd140051de8c504500149452d002528e6909a506800a28a2800ce296928a005a29296800a28a2800a334518e6800a297d69280168a4a5a0028e94525002d145038a0028a28a002969296800a28a001400514b8a38a00314018a3ad2d001494b450019a28a5c50037bd3a8a28017145252d00251da968a0028a2b93f1678805b46f636edf39ff0058e0f4ff0064526ec694a9ba92e5456f1378a40dd6966ff28e1e407ef7b0f6af3dd5752bc9e32b6f3794c3b0ce0d2dddd1663935913ce0739ac1c9b3e8b0b848c12d0c2bdb6ba96669241b98f520e6b3cc2e0f20d6c5cdc8e83bd522d9ace504f53d98534d6a53f28fa50108ab469315cf2d0bf608af86f4a36b7a558c52d4f3b2bd822b6c3e946c3e95671452e60f608ae10fa52856f4a9e968e663f628870fef49b1aa7a29dd95ec910794d4e1031a9a941ab8aee1eca2245665db0580fc2b5b4fb3104a1d6e2453fec7159ab215391d6adc17a5586ee95d1151e867529e9647636faa4eb184f31b03debadf0ef899ec99619897b62791dd7dc579cc5701882be95a76d73b48e6ad49a3c7c46163356b1eeb0cd1cf0acb130646190477a78af3cf0bf887ec7208276cdbb9e7fd93eb5e86a4100820823208ef5b465747cd57a2e94acc5a0d1455188514b8a280128a5a2800a4c52d14009451450014518a28010d2d14500145145002639a5e9451400945145001498e6968a003ad14514008683c62968a0028a293af1400518a39a3140077a3a51f5a3ad001cd14b49da80133452d0680128c628a5140094518e28a000fb514514000a0d18a08e280128a2968012971451400945147a5001451450057a0500518c5001d4f4a3a52d1400d14ea4c6694f02800a4a5ed4b40099c52d251fca800a3ad1de8a004a2971462800e9451d681400514b49400b4514500149eb4b4500145145001451450014b4828a005a28a280129693b52d0014518a5a0028a29280168ef451400b8a3a51f8d2d0027d2945140e2800a28a2800f6a5a4a5a0028a28ef400b451450014514d66545677601546493d8500666bdab2e9560cc0fefdc6231e9ef5e4ba85e996466662493c9ad9f136b2d7f7d24993b07ca83d05721733649e6b09cae7bf80c372c6ef7643713673cd63dddc67e553562ee700139e6b298e4d45ec8f7a953b6a19c9a4a296b26ee75241494b45438dca128a0d158c958a414514548052d029d5a4637188296940a762b754f4111e28a908a69143834036807141a435376989976da72aea093ec6b6ade7c80735cca9c568dadc1c8c9ad93b9cd569dd5ceb2cee0861835e95e10d6c5c442c266e547ee89f4feed7915bcd9c735bfa65ebdbcc9223156539047ad5c25667898dc329c7ccf6a1cd2d52d2b504d4b4f8ee548dc461c0ecddeaed741f3524e2ecc28a28a041451450014514500252d145002628a5a0d00251451400514506800a3b514500145145002514518a00296929680128a28c500145145001451494007d696928a0031ef4a78145079a004ed452d140098a4a5141e6800a4a51ef41a005ed4da5146280128a5228c500260e28c714b8a33400869296802800a2971c525001487a52d1401585140a53d2800eb487938a052d001d28eb41a3ad00141c8a5a3da80128a53482800a2968a004e694526696800a4a5a4a003140a5a3140051498a280168a292801474a28a2800a28145002d1494b400514525002d141a3140051452f6a0028a28a0028a297140063f2a5a4c52d0014514500140a296800a293a52d002d276a296800a28a2800ae6fc61aa0b3d3becc8dfbc9865b1d96ba4240192781d4d792f8ab5537ba8cd203f267083d874a993b23a70b4f9e673f7b71b89e6b1ee660aa727af4ab13cbf3124d61df5c64903bf15858fa8a0ba104b2f98e4e6a2a66ea506b39eba1e8c64878a7014d5e6acc30f99dce29c616dcbe7488c2d057157d2dd71d334c6840edc55680aac4a256998a99c019c7415113595485cb524251484d1bab0e4d47cc870a900a8d4d4d182c46064574421a07321d1c7b9b15605b8229f14446055911d6be8652abd8a460c76a81e32a4d6a143d706a1961ce78e6812acba998c39a61ab72c040c8aa4f9079a8942fa95ed13d85dd52c6f83c5562d4aae41c8eb4a1a32653b9d05aca4806b5eda7dac39ac0b43dc77e6b5626e07ad59e65695dd8f48f056ac20bcfb3c8d88e6c0e7b37635e895e19a6dcb472ab038208c1af66d26f5750d361b807e62b871e8c3ad6f07a1f3b8da5cb3e65d4bb4528a2ace1128a5a3ad002514b4940051451400514514005145140098a29690d00145145001451450014526334b400514514005252d250014714514007d28c52d21a0038145145001451d68a003b5141a4a003d694714521140052e01a28c50021e94b4628a00434673452d0027d2929475e680383400940e2971c5273400a69297349d6800ed451401c5005634b46290f1400b494b9e68c7140076a074a074a5f614005145140074a4c514b4000a2929680128a5a28010d14628a005a28ef4500145252d001494b49400b462814b40051451400514514005068a2800a28ef450014518a5a0028ed4514006297b52500d003a8a28a0028a28a000d28e9494b4005145140051452d001452d2500667886f458e8b3b83f3b8d8bf53ff00d6af17d4a7dcec73debd1bc7b79b4416c0f0aa5cfb13c0fe55e4fa84ff007bdcf5aca6cf63014fddbf7285d5c050c7358d23ee6279fc6a4b998c92119e055726b36ec7bd4e3ca84cd3d6982a58865854c55d9aa65ab7889c135a514400e073505ba8241c569469c64d53329cd8d0981d39a8a45e2af95016aa4b488527732e70012706a831e4d694e3a83d2b39fad0ce9836c8f26973c521eb4565645ea3d4d5fb704a8cfad5141c8ad2b71eb5b74266dd8b710c55a442739a8621cd5e8d72291cae4c88c46a3788f357f66454322e074a09bb32e58f359d73090322b625e3354a740453358cac6311cd254d2a90e476a84f15325666d73574f9414c7715b919054115cbd949b66c762315d15bc995c62838abab3342ddf6b6335e9fe04d437c7359b1e71bd7f91af294701866baff00095f7d9754b77270bbb69fa1e2b483d4f33170e6833d6e8a31838a5c56e7862514b8a31400945149de800a296931400514629680128a0d140051451400868a5a280128a5a280128a28a0028a28ed4005252d1d2801314514bde80128a0d28e94001a4c52d1400945145002d252d277a004ef4b452d00251d0514500140a5a280128a314500277a2968a004fc2968a28010d1da8c52e280128a5c518a00a94bc5252d001de8a28e940052e281450014518a28003451d28a00293b52d14005252d1400514518a004a3b52d14005149de96800a3b5145001451476a005a4e6968a0028a28a0028a28a0028a051400a3a51494b40051452814000e78a4c714b8e296801314b4525002d140a5a0028cd2502800a5a28140052d20a5a0028feb45213b4163d1466803cafc6779f68d5ee4e7856d83e838af36d566c0233d4d75fafdc79b732b1eacc4d707a9c9ba402b16cfa5c142c91409cd25145612773d4145598002d55854f11c30aba651ad07602b462fad6640d9e9d2afc4df950ce796e5b7200ebf955399b39cd4ace2aaccc3068125a94ee08c1ace63c93572793ad516a1ec75434430d1484d19ac6fa944a9d6b4edf900d65a568dbbfca31f8d6eb6267b1a717f3abcad8503dab36193a1ea2adacbc76c5239645ec809c6335048ddb3c5304831daa291f8a092290e41aace3afa54b2c88a0e580fa9a87cc4660030c9ed9a760e78aea52b88b209f4acf61835b32a8d8c73c5615ccf87dab1b6e27ee9e28b14b1115bb2446dae1876adeb4941c7a1e6b9437120c1c0c1abf6d767f74aee57af23be2848c6b578b5a1d62b8e0e462b63499f120c1e4735c9da5df9c8dc11803afd3ad6ee90e7cc048c7b5525638aa4db56ee7bfe9f3fdaac2de7ce4bc6a4fd71cd59ac4f0a4de76810739d8593f5ff00ebd6de2b6478535693414514532429314b4500368a75277a004a28a2800a28a28013a514b8a4c50014514500145145001494b450020a5a4a5a004cd1451400514518a0028a28a004a5a31ef462800a28a28013de968a4a005a28a3a5001494b4500145145001498a5a4a0028a0d1400829683477a002929d49400b49451401571452e683400638a31476a5a00414b8a28a0028a5a4a00434518a2800a28a334009466979a0500252d1498a005a28228a0028a28a0028a28a00051de8c52d00252d14500145068a0028a3bd02800a2969280168a28a00297b518a0e28013268e69d4500145149400bda8a3b51400528a28a003a0a28a2800a3bd14b400557bf93c9d3aea4ce36c4dfcb1562b3b5e6d9a0de9ffa678fd450ca86b2478a6b0c7731cd71178d9b835d96ae796f6ae26e0fef9feb5848faac22d0889a3349499ae66cedb8f06a54383d6a0079a901ad20c68d3b793818abab260f5fcab1e2908357166000c9ce2ada22512f34b55659b39f6a8e49c638eb55649b70c734241188d95f731a809a563f9d309a8a9236b813466928ac057245356ade4da40f4354c1a7ab63915bc1e83dcd88a5f7ab0b29ce3fad64452e09c9fcead24dd3b55b463289a3bf8e2a09d908cbf23a01ea6a312e4726a0b920e1c3952bd31d4d0b739eaa7ca3a55ff47ff561e4c701ba815046ea08dbeab4c7f9e2ddfbc76079e706a3fb522857117cca33d7a0ff001ad0e19ad4d2273131f435cfdef945b24b97ddf311d718e82b644c183000751d6b26f24709205e0ac800c543212dca255982a9181d9bd055c8137c40ee5ddb883df83ffeaacf8c33cc77aee3dfdaad5bee03f764038e78f7a66b0f7ba1b36b711c6cc3731db85231ea6ba8d3ce08c57156c4e5f3927e5e83be735d869e7914329ad0f66f02cbbb489e3cf092823f11ff00d6aeaab8bf003e60bb5ff70ff3aed2b68ec7cfd756a8c28a28a6642514b4500252114b4500368a5228e940094529a4a0028a28a00292968a004a296931400514a692800a28a2800eb451462801052d146280128a5a2800a4ef4b45002514b4940051451400518a29680128a3e94b4009494a45005001452d25001494b4500145145002514bc0a2800a31451de802b521a5a43400b451da8a0028a28a0028a28a00292968a004a3b52f6a0f4a004a28a2800a28a2801692968ed40094514b40094514b40051451400514514005145140052d1450014514500145145002e68cd2e29b400ecd029073473400b452678a5a003b514514000a5a414b4005145140052d145001597e23ff917af7fdc1ffa10ad4aa3acc267d12f63519262240fa73fd2932a1f123c2f56fe3ae267ff005adf5aee3565f9980f7ae22e576ccc3deb096c7d5615fba41451495ccceb169c0d32945116344c0d3c4840eb5006a5dd5b29157262e48e4d309a6eea696a253d0771c4d34d25158498ae14b9a6d2d485c75286a666941ab4ecc77250d8a7893150669c0d6ca4172d8980eb9a8e5b911a647249e3d8fad419a5cd5266738dd5890dca888ed2eeac70cddea00b2b280abf2b295e4fdd19cd481f0280df30269f31cef0c9ee4bba4590f0a5091ce7915565567772cc0ee6ddc54ad21edd2a33d2a5c8a8e1a0889625572c3a9a7c51052420e71453d08c1f71c54295d9a28456c8b16ac0483debaad3f8dbcf35cb5a2e6506babd31092b915a98620f5af002fc9767b6d41fad76d5cbf81eca4b7d264b8917689d86c07fba3bfe7fcaba8c56f1d8f96aeef518514514cc8292969314005252d14009452d277a004c518a5a28013b5253a9280128a5c7149400514514005252d140094518a28016908e6968a004a28a2800a28a2800ed4829451400521a5a4a0028a5a2800a4a5a2800a28a2800a28a2800a4a5a2800a4c514b40082968a2800c51451400518e6931ce696802ad141a3b5002d2519a5c5001401451cd0014518a53400deb41a294d00251476a2800a4c514b40094b451de800a4a5a4c5001477a0d18a005a4a5a4a005a28a2800a28a2801692969280168a28a0028a28a0028a28a005e3ad2519a280173c518c507f4a4c50028a5a6834ea0028a28a003bd2d1450014514a2800a28a2801690f43c67eb4b4b8a00f17f14584516a77490e155646014f619af3ad52d5e19b7302037ad7a8f8c6dda1d56f30098cc8c47fb3939c7d2bcf75099e30c15b8feeb720d63247d260a6f951cf114dab4d2c4ff007e100fac671fa5445633c8723fde1584e07a499152d3f67a329fa1a69423b1a8b31894668c1a290c28a28a18052d2515201451450014b494b40d0a2969052d68862d146297154ae02514eda7d29421ab40369a73520519e580a3f740fccc4fd05292021c1a7aa9c8e2a5f3a15fbb0ee3eac69e9792061b15131d36ad28c55c8b9a5a75839c310141eedc0aec34a820491307cd6f523815c959bcb3c83259dbf3aeab468ccd3a46df733f301deb65b9e662ea5b73dbf457f3344b36c6079431f4f5abf5574c1ff12ab53ff4c96adf415b1f38f7128a5c52502128a5a4a00292968a004a4a5c514009476a5a280128a28a00427b518a5a280131460d2d1400dfc28a5ebf4a3140094b8a4a3b500145141e2800a28a28003494b49400514b450021a28a5a004a5a28a0028ef47426948c500371452d25002e2834514009d68a5a280128a28a00334514b8c5002514b8a3b5002518e68a5a00ab498a76290d0018c5141a05002e283c51d28a00293ad19a51cd0018c5253b14dc62800a28a280128a5fc68a004a28a2800a28a2800a28a5a004a28a2800a5a4a2800a052e28a0043452d140094b4514005145140051451400529ed49450014518a2800a51452d001451450028a28a2800a5a4a5a00296928a005a5a4a51401e6be335dbac5cfb907f415e61aec48a5582e371c1c57aa78e131ab487d514fe95e61aefdd4cff007ab096e7d165efdd4730f190c403511523ad5894fef0e299deb9e723d8e44f621a5048ef52f148427a0a853074daea3379f5a379a5c2fa7eb4f58d5bfbc2aafe64a8c98cdc7d0526ef6a98c09fc32e4fbae290c047f1ad0d8f925d88b77b51bbdaa4fb3b919e3f3a4fb3bfb54b65724fb0cdc3d28dc3d29fe43fa0fce93c87f41f9d2e60e49f61bb87a5286f6a78b773e9f9d3c5a39fe24fcea93b8724d6b621dded4bb8d238546c1950fb8cd4666857abb1fa2fff005eb549984ab463bb25cd2e6ab35fdbaf3b646fc8544da9a0fbb0e7eaff00fd6ad141984b1d4a3d4bd9a4c9acd3aa3e0e1107e19feb50ff00695c1600485413ced18a7c8ce79e694d6c8d9018f404d42d3c60905c0fad68450abdb93866caf527dab9cd8727d734ac8cd6612a9f0a2e9bb4ec09ad3d3631290f2a0c13f2a9fe66b2eced7cc6cb7dd1fad6c4732dba97201c70abea6b293d6c8f430ea6e2ead57a1b31dc88646863c0661c81d8575ba0a7950f9ac305f81f4ae2346b77bad41de46c8001908fd057756b20f36345e83d2b65a7ba7918993a9cd59edd0f69d387fc4b2d7feb8a7f2ab550590c58db8f4893ff0041153d6e78a1486968a00691494e3494006290d2d21a0029314b45002518a5a280128c52d250025140e68a00074a28a28010d1e94b450026334628ef4b400d1d694d2d21e94009452e38a3ad0025141e28ed4005145140051452e28013bd2fe1498e69d400dc64d29a4cd1d6800228a33c5140051475a2800a28a2800c5140341a0028ed4502800a28c51400628eb4a28e940158d211c52d1da801052e293b52f6f6a004ed45038e28c500068ed4b41a004cfad07ad0693b500028c1a5e9466801314529a4a004a297b5250000734b45140099a29692800a28a5a004a28a5a004a28a280168a4cd2d00149451400b9a2928a005a28a2800ef46734668a005fad1da81d6971c500262968a2800a28a280168a28a002968c73450018a5a28a00296814b401c0f8e93fd3d481d625feb5e55aea653db757adf8e97fd2a13dcc43f99af2bd647c878e845613dcfa0cbbe047252afef0e6984e2a7ba1894e2ab9049ae699eec7610b5205269e1694b05acae3e5beac40a053f214726a23213c0a92388b72c68b772a2eeed1428258fca38a94200324e4d030a300519a573a230b6e2e68a4a502a0d04a5a6bc8b18e7afa5519ef09c85e055460e4615b110a4b565c96e1221d89aa135e339ebc7a55496e3b9354e5b92c702baa9d13c2c5e68de972dc973f89aacd39278aafb89ea69464f7aeb5148f06ae2e7362b48dda901cb0dd9c521ce69cb133e3038f5aa39d734986d20e323db1dea682d59d803c64f4a9a1b60ab9382d53a02245c75cd6729f63ba9e15ef33a8854a5911d309d2b9b82032c8401c7735d6430c925b614024a77e83deb19552de3233803a935cb29db4ea7a980c2f3b7296890df9208b9e156abda89750bc1b46d407a9e883d698564bf9383b6153d4ff009eb5a76bb23290c436ae7f127d4d11f77d4ef9a7897cab482fc4e8ac025b442341f228ea7a93ea6b7747ccd701b9c135ceda2bdc3f96870ab8dcc6bb0d1608add900e5bb67bd6d4da5bee7958fa6e7a4748a3daedc62da11e91aff00215276a6c6311a0ff647f2a75741e130cd25145020a0d1450021c5252f4a4a004c514b4940051451400521a5a43400514514009d28a28a0028a28a0028a28a0029314b49400628039a334b4005262968a006d14ea4e86800a5fad37a528a0039cd19a53494009de8a5a3140098a5c5140a003914bd78a4a5a004c518a0f5a3b5001476a5a28010734b8a4ef4b40094753451400b498e6968a00ab486968a00052d25140052f4a28cf14009da8a2968013141a5a6d002514bda8eb4001a3bd04d2500145145001451466800c521a5a28012968eb498a00294d25140051451400520a5a2800a28a28016928cd1400bd28a4a5a0028a28a00319a514a290f5cd002f5a28a2800a28a5a0028a28a002968145002d1451400a297b514500713e3b1892d9bd6323f5af2cd5465580eb915eb1e3a5f92d4fb37f3af2cd493e4603d6b1a9b9ede5cf4390bb1fbe3501a9af9b139c557c93cd72d43e8e0d5b41189ed4810b75a900a776ac6e5725dea08817eb4ecd3734a052368a4b442e69c05281eb51cb70918c753428dca94a30579324e14649c5569aec28c29aa735cb3f5381555e5ada147ab3ccc466292b409a59c9ea6a8cd71d8536593d6ab139aeb85348f9cc562e527642b396eb4da28ad8f39b6f71cb9f5a781e839a921b6924ed81ea6afc36c918f53eb49b47551c24ea6bb22a4768ec017381e956963541802a5200a69aca52b9e9d2c3429ec81471c54f6b034d3a0033cf4cf5a5b5b56b87c0fbbdcfa56ac312c5246a98c93584e76d8f428615d4f79ec7411b476fa74a58ff0659cfd2b94f24dcb2bcc5920ea147de7ff000ae8e5d9f6663280e106557f873ebef5ccdcdd60900e5ab18dfa6e742846317cced1eddc7cb3a46bb514281d1476a5824f28ee27f78fc0f61eb54e252f991fa0fd6ae5b59b4b7224964dbe8abd6b58249ea44e739c7dc5e8747a6dd108915ba127fbcdd49f5aecb468ca4a85db7cac7f2ae5b4f305b4400da83f535d3e892f993a045f97232c7a9e6b68eaf43cac53e48fbeeecf71030a07b0fe54b411cd15d078225252d1400868a5a4c500211494ea434009494b45002514b494005252d274a0028a28a0028a28a0029297e945002514628a0028a28a004c52d149cd002d1451400514518a004c518a5a4a005a28a2801296814845000294d2628a005a28a0d001499e6968a004e6968a2801314b45140084502968a00292968a00ab4bf5a0506800a4ed4b41a0028a28a0028a0d14005252d1400de940a5a2800a434b49da80128a3eb4628012968a4c62800a28a2800a28a2800ef499a5a4a005a4ef4668a0028a052d0014514500145252d0014b494b40051814829dda800ce28a28c718a002968a2800a51494b40051450280168a4e94a3ad002d2d25028017bd2d14500729e385cdadb1f42dfd2bc9f53cb6f02bd6fc6ea4e9d01ff6d87e95e557e81558fad6350f5f00db56389bc8f6cc73daa00b572f8133671c7afad55ed5cb5373e9e925ca84a3ad18a5240e4d606c18a567541926ab4b761785eb549e72c7935a469b672d5c6c29e91d4b92dd13c29c0aa7249d6a2321269a4f5aea8d3b23c9ad8a94deac63393d6a267c51238a80b66b48c4f2aad5d46b1cb5254b1dbc929e14e3d6aec360aa72fc9aa738c4c69616ad67a228c70bc87e51c7ad6841668832df31ab01428c018a51d2b2f68dbd0f528e0614f596ac0000605389a4a72a16206324f614d1db6e8869e6a586d9a76c0e83ab7a55c834d67c34cde5afa632dffd6ad178e282dc2228c03f89ace73e88e9a3857269cb4443020862dabc01fad3377ef55b3819a8e49d634249c0f4159b3ddb48fc1c0f4aca30723aebe229d08d91b17d7e1ad5d53ae3a8e95850c6d23658e00e493daafac2f34440e98c93e959f79be402083e5887563c6ead1452d0f19d49493a9257ec874ba8471b0098c2fddff1a5b6d4269a6c47b867d2aa476000cb73f5abd64628a75dbd7dab48a8a7a18ca78892f79f2a3a5d321660ad313f4ed5dd6818371101d323f9d71163296da4d771e1b19bb87dd97f9d6c8f36b59688f7223e66fad252b7df3f53486a8e20a4a5a4a00292968a004a4e94b41a006d145140087a514b494005252d14009452d25001451de8a0028a4a5a0038a4c52d14009452d14009451475a0028a3141a0028a28a003f9514514005145078a0028a28140051452d00263149de968340051451400514518a0028c514b4009ed460d2d1400940e9452d0056a4e6968a004a5a28ed40094734b4500251d697149d280139a2968a000d252f6a4c5001499a0f5a280139a294d25001494b45002514514005145266800a28a2800a28a2800a2834b4005145140094bde8a2800a5a4a5140052d252e38e6801334bde8c714b40051451400b45028a00281451400b45145002d28eb494a4d002d1451401cef8cc674888fa4bff00b29af26bf06472b9e31cd7af78bd776847da41fc8d793dda6d56f5359543d6cbb5d0e3353003a81d0567815a3aa7507deb1e69c20c0eb5cb35767d34671842ec924955064f5acf9ee8b719e2a19a72c739aa8f27ad5c297567918bcc1bd23b1334b9ef4dde38aac65f4a01cd74281e44b1376583201dea3793238352416934e7e54fc6b4edf4845e653b9bd2894e305a9bd1c2e2713f0ab231a382598fca0e3d4d68db6963ab824d6aac089d14014e670a38ae69576f447b187c9e9d2f7aabbb2b8b758c72401e951b903a548ee5a916da490f4da3d4d677ee74ca2be1a68ac79a7c513ca708a58fb55d8ece34e5fe73e9daaca1da9b570abe829a9ae854305396b2d0ad15801cccf8ff0065793ffd6abd0a2463112851dcf734d519e4f4a6cf7690a6c4e5fbe2a93723afd952a0aec99a45853ad56babb0a32dd7b2ff005354a5bb62d9279fe555e4667e95ac69f73cdc463fa4064d3b48c493cd2d9db3dc4c3180a392c7a0a962b26914c8e76c43ab1a1ae0332c312ed881fc5bdcd3f247059fc750d3bb92186d0c714a7663e62a3963f5ac56b90a4ec5fc4f356aec936c71ed5974b91227eb326b4d074933c879352599ff00494aae7ad58b3ff8fa4fad5c7439e7272d59d8d82f095def85d737d6ff00efaff3ae174e52c5001cf73e95def85c83a95b281c798b83ebcd6a8e1a87b61fbe7eb494a7ef1fad18a6728da296928013bd14b4940094869d48680131494a46692800a3bd14500251451400514514005252d1400945145001451450014514500145252d001cd21a5a280138a5a28a0028a28a00292968c50027b518c52d140094bd28a28012968ed477a004c514b4500145145001451d28a0028a31498a005a5a4a5a00ab476a5a4340051452d0025141a4a005a28141a004a28a28010fd68a5a4a003b5277a53499a00534ca7525002514519a0028a28a004a3bd2d21eb400514518a0028a0d140051452d0014514500028a28a005a2928cd002f7a53d290528e6801474a28a2800a28a050014b45140051451400b45145002d1494b400a0e6969053a8031fc4e9bf4197d9d4feb5e4b7e39635ec1e205dda15cf1d369fd4578e6acfb0301d6b39ab9ea6026a09c99c36b9284e9d735cccb367926b675c972580e4e6b9b68dddbe63f850a0ba955f1f29be588d925c9e2a3c339e95760b1697184fc4d6a41611c432df31fd2a655230150cbebe21dde88c9b7d3e5988c0c0fa56bdbe970c4017f99aae28e303f215208d88e7007a93584ab4a47bd85caa851d5abb1a1554614003da8240eb526d5039624fb52e42fdd503dfbd64eecf5546cac8ae43b7dd0714a2dc1fbef93e82a524939249fad1517b07b24f5902aa27dc503dfa9a424e7ad35a454192455592ec9e1052b390a7569d245a69157a9a7c40b82cdc2d568e3118f36e0e3d0556b9be69b2ab958fd2b5852b9cf5717c8af2fb8b5737c398e03f2f76ff0aa064eb8e7dcd4264a545676f6f4aeb845451e356c4ceac8722b4878e9eb5a56d6689179d39db18e9ead4b05bc76c8af70324f2b10eff5a496633306739f41d850ddf62634d415e5b95efae5a7c285d918fba83b5538d4f98a3deaecc14a74e6a08b024142b2339be6bb6c9aebfe3dc8accd9cf35a778e3c8c0ebc566162cd80093e8293308f2db5118006acd8c2cf72adc2a291b9cf414cf2d223bae0f3da35ebf8fa52c77399e30d8500fca83a538a644e518abb3b5b474545541b53d4f5635dc7845b76ab6bff005d17f9d79dd9c8cee33d3b57a1f83413abda7fd755fe75b5ac79b52a7333dc0f53f5a4a51d4d2d06636929c4536800a4a5a2801292968a006d14b8a0d00368a0d14005252d276a0028a28a0028a28a004c514b486800a5a4a5a004a28a2800a28a2800a28a5a004a29683d280129692968010d14b4500275a28a2800a28a2800a4a5a2800a28a2800a2968a004a2968a004e945145002d14514015b1451477a003b5145140051476a28010d21a5a4a0033451450014941a28010d1cd1475eb4009451de8228010d1d28a280128a294d00149451400514506800a28a28003451450002834525002d2d251400b9a28a2800a5e9494b400a29693b518e280168a414b400bd28a4a2801681450280168a28a002941c502968017140a2968028eb233a2de03d3cbcfeb5e21ad12cef8e39af71d586ed22f00ff009e4d5e2da95997918bb6067a0eb52da5b9d342339a7189e7ba8c25a4da1493e82aa269e01dd20ddec3a57517b0c7092a8a39ea4f7ac99339cf4aca53be88fa0c065b087bd3d5958205181803d053c01e99a08a057335a9edc6290f0c474e3e9475eb4dc81486451de848be64b724e9499a84dc28a864ba38f969f2b644b1108f52cb48aa324e2aac9767a2d557766392696286499b6a02692825b9c3531739be580f5df33e00249ab6cb15847ba4c34a7a0a6bcf158218e2c3cc7a9f4acb9652ec5ddb24fad5a8b6734eb2a5e72fc8927b979dc963c761e950eea80cd96dabd6af59d934c72dc0ea49ec2b649451e7aa92ad2d3512082499f0ab935a1ba1b01b46d927fcc27ff5ea292f1224315a8c0ef26393f4aa45b924e29a4e5b9a3ab0a4ad1777dcb064791cb3b1663d49a70355965503d71ed56a086e2e398a2381fc47a0fc4d5ec72bab77a6a24832bc5574cf9aaa033376039aba6de041fbe9cc8c3f822e7f36a60baf2b2b02a5ba1ebb3963f8d22652697bcec2dcdb9484b5c30881e76f563f876fc6a835d2c6b881446bddc9cb1fc69d7d70be59da0927b9ac9666639269f237b9cf2c4c62bdd2579ce4ed3f89a75a65aed33fdee6ab8abda721fb52d68958e494dc9ea76361f7857a3f82c13acd98ff00a68bfcebce2c7ef8af4bf038ceb567fefaff003a093da85140a29009494ea69a004a2969280128a5a4a0029296928010d253b14dc62800a28a2800a28a0d002514514005145140094b4514005252d21a00296928c5001452d14005252d14009452d1400514514009452d1400868a2814005252d140052d2518a0028a5a2800a28a280128a5a2800a28a2802b9a314b8a280131474a5c518a0069a29d4de94009452e28a004a4a5c504500252718a5ef46280129297f95140098e6908a5ef4a4500368a5c52500277a297141a004a28a2800a4c52d25001451d73462800a28c52d00276a2968340094b4628a0028a28a0029692968017b52d27514007d6801451de8a31400b494b450014502968012968a2801451d281ed4bdf1400b4b4d03029c2802bdfaeed3ae57d626fe55e417f1992e368e326bd8ee1736b32fac6dfcabc92e54091dcfd05673573d1c04945bb9cbea1a7a16fbedfa564c9a7463fe5a3fe95bda84a33902b1a572f9a88c4f6a38c504517b28573991ff002a16b58ff0085dff215664fad424d3f66852c6ce5b32bb59237595ff2149fd9f17fcf47fd2ac03416a7ca8c9d796ed951b4f8f3feb1ff004a61d3623ff2d1ff004ab99ab36f6c1d7cd99bcb847f11efec293b2239e52667c1a1a4e73e6baa0eac714f9e08234f26d6470a3abf193566eaf3cc5f2d17cb857a01dfeb5992cd93853f8d250beaccaae2d52568b2bc9630af595c9fc2abff006589db024931f8568c56ece416ce2af848ed906f197ed18fe66af45b1c8a33abef4dd919b6fa0dbc49e6492b803a938e7e94b716e92feee292448bfba31f37d6b43ce85be6991a46ec338514ff00ed0f2d4ac291443fd9519fccd4abdef6359c9287246565f89971787a69bf8a60beac028fd6a61e1db443fbcbd6247f0c6a1bf535349785ce599dcfb9a6f9ec7a0c56966ce472a51f31e9a7d9c207931907fbf2e18fe5d29b2db2498125ccd263a0e303f0a6e4b1f98e6a45e69a8a2258996d1d0aef66a576abbaa8f61507f65c65b26573f95691c62851cd52563094dcb732ae7498b61cc8ff0090aa1fd9317fcf47fd2ba2b81f29154597071544233468f11ff96927e95a5a7e8f1abe448f9c77c53d13a56a59a90d923ad002590db260f50706bd33c09ceb9699fefad79e795b2e8376619fc6bd13c02376b969ece3f954b19ed03a5140146290094da79a6d0025068a280128a28a004a28c504500276a0f4a31460d0021a4a71a4e3a5002514b8a3b73400da297a514009452d14009452d250014518a2800a28c52d002514b46280128a5a4a0028a28a000d1da8a2800a28a28010d1de97ad18a000f1494b45002734528a5c5001494b8a2800a28a2800a28a280128a762928021c5047a52d07a500368a5a280100e2929d4940084518a5a2801a450453a90d00348a4ed4e23ad20a006e28c53a8a006e28c52d2668012823bd2d1400d228ef4a6933400719a08e68a43400639a314034139a00292973d28a004a5a28a004a314b466800a4a5cd1400628c5252d002e314b4dcd2834000eb4b8a296800a28a280014b499a5a00314b8a4a280171451da9738a0000e69690528eb400b4a29294500248bba271eaa7f957926a6be592be9d6bd780cd7926b4313483fda3fce9337a32b1c95f74acb93eefa0ad3bce87eb58ba934915a348a180dc14b8070bf8f6a475c657631867bf1513022b264b8b8ea267c7b31a81ee67232657ffbe8d0745ec8d9cd25617daa7ff9eb21ff008155e8dded225b8ba9242c798e2ddc9f73ed49bb045391b50dba4482e2eb88ff00853bbfff005aabddde34ac19fe551f7507402b9ebad56ea690b34ee58f4f9b81ec2ab24972df33cf263d371c9a147ab30a9886df25336dcb4a703a54d05be5b006e6ac88de7604999d635e4b16e9556e7569caf9504b22a776ddcb51be888e48d25cf53567492dca5b656221a5cf2fd87d2a919dce7e6e4f535cdfdaae3fe7bc9ff7d1a3ed571ff3da4ffbeaa9452396a5794d9d16e27a934f038ae6c5d5c67fd7c9ff007d5482eae3fe7bc9ff007d5518dee744b4f1d6b9e173391feba4e9fde34f5b9b8ff9ed27fdf5401d128f9aa45ae705c4f8ff005d27e0c6a7173315c79d26eff7a981be4d2af5cd609b99c0ff005cff00f7d1a72dcce3fe5b49ff007d1a046dcb8c76355f664d663dc4e460ccf83fed545e7dc1381349ff007d5303751738abf00c551b26f3add1c9f9b183f5ad285690cb623f322cf75e4577df0fd3fe2776bfef7f4ae26cc73cf4f4aef3c04be5ebf6e9e8dfd0d2607aee28a28a4025141a280128228a0d0034f5a28a43400514525002d25145002514519a0028a4cd2e680108a3028268a000f149413450028a3149466800a3028a4a005a29296800a2933466801683467d6933400514514005028a2800a29334b400514514005145140052d252d001477a3a519a005c75a322929734006297ad3734b9a000d20a5ebcd1d05004141a31476a003b521a28a000f4a4c52d140051451400878a28a2801a4d1477a0d001494b4940052668a314005277a5a43400138a6d29a4eb4006690d2d2500029690519a0028a28a0028a28a002928a280168a28a0028a28a005a29281400ecf1480e28a3bd003b9a0526452d002f6a28a280168a4a5f6a005a4e68a2801d9c0a514d14a2801d9a5a6f7a5140122751ef5e4fe2018bc9c7a39fe75eb2bf787d6bcabc4aa1351b91d848dfce82e9ee71776320fad4165a85c5bd86a6d6b398f64d0820a865605581ca9c861ec6a6d41c450c8fe838ac6d38b3586a80ffd3173ff007d115137647a78084675e3096cc8e16d2f52b86b6bdd39adae73ccba7b6d0defb1b23f018a90f84207c18757b69093f2c331303fe67e527f1a0db848629ba4af919f61c8abeca97102891415750718a872e54a5d19e87d4d4ea54c3c1da51d9f7453b8f08cda3597f68de5a4a23ce237560f183db2c0915c8ea31dcbcc6473bc39c6ff00e9ed5dcda2345a2ebd6db8ed115bb01d8fef4f38fc6ba6f01781349f10691737daa096553334091472140b8009624753cfe95ad95ee8f16b55a8bf773d2c78c2421467ab76a90a88d77cc70076ee6bdcae7e09e8e589b4d5efe13d84aa920fe40d735acfc10d5fca7974fd52d6f1d46562914c45bd81c919fca808568d38fbbb9e4b7372f32edfba83a28aa66aede59dcd8dd4b6b770bc171131478e45c1523b62abc1034f308d475ea7d055248e59ce5377931b14324cfb63524ff2ad08f4918ccb273e8b57e185208f620e3b9f5a93d2824a6ba65b7a3e7fdea6be9395262939f46ad051c7b53c90aa598e00ea698181224b130493231d076a07b8ab177746e5c2a8c460e47bd42071e9400e5e7eb530e08f4ed51232e40c8cfd6b46cad8cd2a9707cb1c938e0fb5002db583cc37b1d887a1ee6aea69b00183bcff00c0aaf2a8e0004f6000ebec2bd0741f84dab6a36d1dcea3711e9c920cac6c85e5c7b8e029f63cd023cae7d30edcc2d9ff0065aa82a13288d431958e02004b13ec0726bde353f835e5d933e97aac93dcaae445711aa87f6057a1fad4bf06eca38e1d6a692dd56e52e23425d06f4c2b6473c8e68b8cf1fd36caeadf521a75dc32dacf23261268ca95dc400707b739aeebc61e1687c2777a7da457325cbcd03492c8e028c86000007415d7fc53f0fb5c5c68de208232d2da5d4505c11d7ca690618fd0f1f8d677c5a24f8874f1e9687ff433480e36d3ef0aeffc14a7fb7ecdc7a907fef935c05a7de15e8be05c1d62dff1ff00d04d007a9514945200a4a28a004cd26694d2500149451400945068a004a28a4cd0029a6d19cd14005141a4a005cd19a4a2800a28a4cf3400b45251400b9a334945002d14945001475a28ed400b494941e68017345251400b9a293340fad0014b49450019e6973cd368ce2801d9a293bd275a007d14da51400b4678a4e7345003b34669b476a005a33499a2801d9a3a9a6d2d3022cd19a292900bc53696928014514946680034521e73474ef400b4869334668013bd1451400668e2933499a005a4cd19a0914001a4cd19a4a005cf5a4ed4514005277a33450026696928ef400b49de8a2800a29334751400b45252d001451499a005cd145140052d252e6800a5cd37ad2d002d1d68a2801d452678a5a005a2929680168a4a5a00514a29bde97e9400ea7ad462a51c0a0051d45798f8ad36eab723fdb35e9c2bcdfc6231abdc1f7fe94174f73cd75a7c288c77e4d67e95b7c8d503741044c47d24ab1a9bf9933b7e54ff000f5abca7533b19945ba64019e9203532b5b53b70f2946a270dc679125cbf9929d898c003ae3d07a7d6acb15440490a838c93c0a8aeee9848c91019070ce79e7d00aa121691b3239623a64d0a84eb257d11e9bcc2860dc9525cd37bb352da459ed75b2bf7059c7b4e3ae265e7f5af49f85447fc22b70a3f86f64e3fe0295e63a79dba7eb07bfd8bff006ac75e8ff089b7f87750cf6bd3faa2ff00856938283e5478352b3ab27396ed98df113c79e21f0bf8a7ecfa74f0fd93c98d8c52c0180241279e0d6dfc36f1ddd78c62bd82feda28aead4236f8410aead9ec7a10456eeb5e05d07c457b25dea76d2cf2ba2a712950a17a631dead787bc29a4785eda58348b3308948691d98bbb91d324fa64d4991e6df197c2e353d4b40bab3455bcbeb8fb0331e8780549fa73f856be9bf043c3d676a166bbbd9ee4f0f2ab0504fb0c702aa78ebc4d6779e3bf0b687692a4cf67a8acd72c8d90aed850991dc0ebe99af4ad6ed6f6f743bdb5d3ae45b5e4a8562989c6c39ebc7b668038a7f82ba137ddb9d493f23fd2b99f1b7c37d2fc31a1c17b6d717924925ec16e7cdc0015c904f1df8ad1ff008403c7898f2fc4b91ff5f720fe95e77e3ed3fc5de1b7b3b7d735c96e52e58cd1a2dc33aa943c1e475c9a00f563f0434759c917fab9504ff771ff00a0d4adf05bc3532aacb3ea2cbdc0942e7f4af08b1f146bf3ea96a26d6f517533a6e0d72d83f30f7afac35824683a9904822d263907fe99b5303883f06fc15650cb23da4f23ac6c544f787a8071c0c5657c2df877e1ad43c1b67ac6a7a7477f777859b3396db180c40550081dbad7842cd34a11a49a56240396918ff5afa87e11107e19e89ede60ff00c88680229358f869a04d2427fb0ede6858a3a476aaccac3a8fba4e6bad861d2759d26378e1b6bab0b98f2b84051d4fa71c7f4af0ad3be196a3e34f106bfa8c77d058d98d527883bc65ddc8739c0047af535e9fac788b4af873a05a68d6c259eee1b60b6d115ea39f9d8e318cf381480e73c01e0fb64f19eb37128f36df48b9682d830ce5f270c7fdd5c7e26a7f881f10eff4ed5a4d1f459040d08027b9da198b1e76ae781818c9f7abff00086579f45d52595f7caf7a5e463d492a0e6bcffe20e997561e33d41a685c47732f9d0c9b4ed7520743ea0f18a00f46f867e2ad47c416d7d6fa9cbe7cd6a519262a01656cf071c718eb5a5e148d53c4fe3008a1436a31f4f531e4fea4d62fc29d0ee749d22f754d411ad92eb6945946d223504ef20f4ce4fe02aefc3ad4975abcf12ea518223b9d495e307aedda42fe98a00d8d075bb3f15e9b791ba2992dee1edae613d8ab707e840045703f15883e24b25eeb683ff436ae6746f151f077c42bfbb955e4d3eee6952e635eb8de70c07a83fa135178abc5d178afc4915edbda4b6d6cb08863f34e4c80331ddc703938ef40115afdf15e8fe031ff0013887d837fe826bcead47cc3eb5e8fe02ff90bc5f46ffd04d303d38f5a4ef41a4a401484d04d250014941a2800a4a293b5002d21cd1499a005a43484d140051494500145251400b499a28cd00145251400b45266909a005a5a6e68278a00766933ed499a33400b9a334dcd266801c4d252668cd003b34537345002e79a334945002e734a3f4a66714bbb9a00713480d2668ed4c05cd2834ce2973400ecd19a6e696801d9e696984d19a007d252668cd002d1494671400b9a09a0514011d2668a42714805cd26693ad1400ecd26734dcd2e78a00334941349400a68cd26682680006928cd2668003d68268278a4273400668cd25140051466933400b9a4268cd06800e734536973400b499a6e79a5cd002fd68cd368a005c8a5a6d1400ecd19a67f3a2801d926827f3a6e68cd00381c52e69b9a33400e06969bfce9680168cd2668cd003a8cd3452d003a9734da05003b3c52d20a32280145381a6d2d0019a5a4cd2d0039793520a62f4cd381a007579bf8f1bcbbe9fd58003f2af48af34f8864ff0069e3b6c0682a2eccf2ebdea6b52077d1ac13ca91a2b975cb3a3608a86dad85cea00bff00ab8be76f7c559b664bbd76c84dfea9ee63520ff7770a87abb1db4e4a10727bb2e4ba6ea371a725d6a5e1e9e4848cadddb208a523fda0061bea541f7ac67b0d3e605ad35589251d6daf54c2e3fe05cafeb5ec1e29f1741e17bcb549ece6992e7792f1b81b369c6003d4fb56549a9f80fc6262b7bf6b333cac142dc8f225e4f40dc67f335b46a4a2714accf34b1b1bf8f49d664b8b62a9f636c488cae84799191ca935e81f07416d0f5400138bb5e83fd815c5f833c010f88e3d7aeacefe5d3e28af5ed6040bba391073f3f209c715acbf0efc61a3bb3e977c8dce736b72d193ff00013c5294b99dc95a1a3f13fc4da9d9eab6fa5595d4b6b00844d2342db5a424f0091c803d2bc9f52f13788559e03ae6a460619d86e5f18f4eb5d3789ed3c4c97315c788e1bbf30a889269941040e8372f19ae43548b75b09318d87a9fd7fa5480df09b85f1868ce5b03edd0e493fed8afaaf5a8b509744bf8f4a9443a8946fb3b9c70f9c8ebc73d3f1af8f55f69051f90720ab720f635ec5e1df8ead6d671dbebda5cb733200bf69b69029703bb291d7e940165b58f8ad01c3457c4fbd9c67f92d713e3d5f1aeb31417dafda5c182d728aed6c23dbb8f4e0739c57ab47f1a342701bfb375200f208286b0fc6ff11748f12f8625d36d20bc8e769637532a8db85273d0fbd0078969ca7fb4adb83913276ff6857d8dab29fec1d447ad9cdffa2dabe5ab6658aea2958708eac7039c020d7b25efc62d1ee6c67b68f4bbf3e6c4f1ee2c83195233fad3607cf511c2a7d057d43f0839f867a31f4693ff00461af98e585ad5823918c70dd8d77fe1af8bda8f863c3769a358e9f6120b7ddfbd9a4625896cf4078a00e83c1be2e93c37f1175fb4bb988d26eb529964ddd229379c3fb7a1f6c7a57a8f8e7c2abe29d0cadbe05fdb0325b3f5ddc7287d8ff3c5781c367aaeb77773791e97732cb7933cf22dbdbbb2867392071d39aece1d3be255d58476e5f52b7b38630009265842a81dfbf029019de0af174be0fd5a74ba8246b39c84b9871f3c6ca70180f519208ef5ea937c4bf058895a5d6a1cf511b44c5c7fc071d6be7f9647925692491a4762599d9b7163ea49eb55745d1eff00c57e218b4eb05ccb31cef27e58d07563ec07eb401eade2bf1f5df8a619346f0ed8ddb5bc8764d2f964c928fee803ee8f5cf359fe11f0df8af53b2bcb6b0d47fb2ec56e5a3b9cbed732a8008f946e38fa815eb9a569d63e16f0f2dad980b05a4459dbf89d80c966f73d6bc434bf1ceb9a7e909a6e9c62b769a6323cc13748ef230cf5e05007a041f0fbc27e1a83fb4fc4572b786339f32f1b1106f641f78fd735e5de38d7ac7c41e2b92ef4bc8b18e28e18331f97c28e70bd8649af46f8bd2ecb2d1eca46dedb9dd89ee4285cff003af15d8629990f63401d4d8389511c77af4cf010ff0089b47fee37f2af29d124f98c67b722bd63c03ff21453e88dfca981e924d3734a4e69a690013499a29280173499a33499a0033475a4c519a00339a4a0d250019a09a43450014521a28016933484d25003b3c52669292801d9a09a6d19a005cfad14da33400ecd213499a33400b9a33914d268e9400ea4cd26714d3400fed49de9b9a33400b9a5069b9a2980ecf146734cce6826900fa4cd26734991400fc934669a28cd301dde9734ccd1ba801f45341a09a007514dcd2e6801d9a4e9499a2801d453734b9a00764d19a6e68cd0030d21a4cd19a402e78a4a4cd27a93400ea3269bc505b1400a4d213c527b66909a005068cd20349bbb500389a334dcd19f5a005cf14669b9a33400a6933466933d68014d19f5a6e6933400ecd19a6e68a005cf146692933400e3484d2519e280173cd1cd2679a4cd003b3cd2519a4cd002e68068a43d680173466929326801de94b4dcd2d003a8a6d2e680169474a6e6973400ea2933eb499a007834b4dcd2e680168a414b400e068cfbf34dcd2d003a941c9c5341ed4f4eb9c50049ed40a28a00776af37f884a7fb411bd6315e8a4e05701f1023df796e07568c0fd682a2aeec70223fb369c5ba3ce7ff1d159c1259a555855da427e4118cb13d463deb4355bb83cff002c380918083f0aa3a7ebf0691abdb5f28499a07de109201fc474a491ad596b65b23b7b2f881a56a368ba7f89ac724615e431798a4f4cb2f553f4accf17fc3cd1757d0e5d6bc3138630a33f931c9e645281cb019e5587a7e82b5c7887c07e33548f5158acefb1c194f94e0fb48386fc6afc91e8df0ebc0f78a2e8b44cb34b1f9d202f3c8eb8c2e3af6e94cc0f1bd2ad7c6ba56950ea9a345aa47a7cf99124b42590f6cb28ce3a7715d6e9ff0014fc4b65120bd5b7b938e56e6028f9faae3f957796f7a9e06f86361733c0d2fd8ace10d1a36d2ccc4700ff00c0bf4aaba7fc4ff06eb2c16e774130f9b6de5a06c1f6619a00ec228a0f12787e18efad8a437f02f990b754dc3f98ea0fd2b23e1ee951da7822da091124f3a49656dea0e72c40ebeca2b1fc4ff1334db6d365834295aef50954a44eaa424648c06c9ea7d0576da7dac7a56896b68eea896f0246cecc0007182493ef401c24fe2ff8653dd4d6f7d1d8c72c6ec8fe7e9c40c838ea1706b4a1f087807c55a499ec74dd3e7b59728b71680c6ca475c118208f7aa17bf073c31a83b4c9737d196ea63b80e33f956e59c7e1bf871e1a16cf7a96d691132319a406595cf53b7a927d850078df85fc23e47c5e6f0bdce2eec6ce591e60ff00c71aaee19c74cee5fc6bb3f8a1a27867c37e18865b4d36ded6eee6e0468e19b21402cdd4fd3f3a5f85573ff091f8c3c55e2b68b67da1d618c1eaa0f38faed519fad54f89717fc249f143c2fe1b625a0428d32e3b3b65bff1c5a00ed341f877e1b1a169e6fb48865ba36e8d2bbb364b1193c038ef5e6ff163c3f67e17d5ad2eac6d84365791ed58e31f2ac89d7f3041af5cf1b78957c29e1a97550aa4acf14488dd0ee600fe4b9fcaa9fc40d162f15f80af16d93cd916217b684724951b863eab91401c9fc1af0fd9ea7e1cbcd5b53b0b7b8fb45d79702cd107dab18e48c8ee58ff00df35b375f123c1fa36b173a5dbe95335d5b48626fb3da22aee1c601c8ef5b7e13b54f0b7c36b0f3ff77f65b0fb44fb8630c54bb67f135e09e10824d6fc5f6524a097bdbe576fa6ede6803e95d7b581a17876f75468cbfd9a1f3045bb1b8f185c8f735e49aafc5cd5efad2e2d62d3ec608e68da22db9ddc02307072067f0aed3e2cddfd9bc1861cf3737291e077032c7ff41af083d698114cb34ab1dadb44f35c4ec228a34196763c607bd7b1e9d65a7fc1df03497f7ab1dc6b97670769cef7c71183fdc5ea4f7fcaac7c2ff05dbda58dbf896f5164bdb98f75a86e90467bff00bcc3bf615a5e21f86f69e2ad65b52d6f55be9a145d90db4588e3893d33ea7b9ef480a76375736ff0566d46f252f797f6b25d4ae7bbccd8fe440af33f0859fdbbc65a3db32e54dda3383e8bc9fe55ee1abeb1a1f82bc3f6a2fe458ace35582de364f30b9519031dcf1d6bc87e18dd4173e37fb6dc5c2a0b7825b996491b6aa93c6493c756a680daf8b977e7789acedc1ff5369b88f77627f9579adec589165f5e0d747e3ad7ecb54f1a6a3756f751cd6e0a451ba1cab2aae383f5cd6049716f2c2c9e60cf6e28026d2dfcbb846f7e6bd93c0033a8e7fe99b7f4af17b2fbc2bd97e1bbef9c93d44441fd2803d2293b51494804a0d0692800a4a09a4a003341a4a0d0021272051477a4ef400b486933467b5002668cd21a4a005fad149480d002d1484d1400b49499a4cd003a8cf1484d25002f146692933400eddcd2669a4d19a0009a4cd19a426801d49de8ed499a007668cd373466801d9c5266933413400a0d04d373c52e78a602834be94dc8a338a007519a4a4cd003a8cd2668cd003a8a6e78cd00f1400ecd2934ca506801d4034da33400e2734b9cfd2999a5a008f34b9e29b49480713466928cd001484d1450019cd07a52668ed40003c52639a3a8a4cf39a007514d068ce6801d499a4cf1480e680149a4a28a004e94668a2800a3bd277a09c74a00334b49d68cd002f4a4cd1de928003474a434838a00776a5a6d1400ece28ef4dce29734001eb4b499a33c5002d1de9b9a5ed400b40e690528a00514b4da5a003834b4945003852e69a296801d4a29a0f14a2801d4b4da5a005152af0b51af26a4a00752d3452d0029049cf6ae2bc6f0b1bab6936f0b131ebe86bb5ae5bc6ab88206ff00608fd6932e0ecee78cea16d39663b339e4f22b026b2b9f99bcbe707f8857637ff7c8ac59ba914c96ee57d4fc2b2a69efa85bb0fb2a5ac321591b25a466daea0f4e0f3cf622b1aeb41d56c96096eec258d1c0689a520823ef0efc64738f4ada6b99d2da4b7599c43270c99c83ca9ce3b1f9579f6abb3eb704fa7dec725ac9f6cbb8e0479378f2c188ae1c0ea18aa81e9d69886f88bc7fad788bc2f2693a869f6a837a39b8b762b90bd8a64fb74f4ae1ade630ce9267a1e7e95daea97b15f59e9d1b25a79cd18fb45c2c41640dbc8c363031b707a565eb7e1cb7b34d59ec85da0d32748e517383e6abb1557423d7838f43401b3e10b45bff00176930b15d9f69491b278c2fcdfd2bd5be2c5f88bc1a605233797288707aa83bcff215e430f86b518f4886f04904ca6d16e9950b0658c8ce7918381d7078a822b1d52fad0490c17335b2b100e4ecce39c64f5c7a5203aef855af7f67788ce9b2b7fa36a2bb1727eeca3953f8f22aefc6ff000ab5c4763e22b58f3247fe8d7233fc27946fcf23f2af398dee2d5a2bb88bc6d1c83cb940e8e39e0fa8f4aded43c7de24beb0b9d3b53d404d6f3a98e54b881411fa020f7a2c07a87c20d11f4bf005a174db717d2bdc364f6276afe8bfad737e158e4f11fc74d6b5a099b4b3491626cfa6234fe4d5ced8fc53f1258d8c56b6d3d88b786311a0fb38e140c75cd50f0e78d356f0b8ba1a68b5dd74c1a479a1dec719c01c8e3927f1a7603b5f8ed753358e8fa5c5822491ee24191d00dabfa93f956e7c19d6a7d43c2074bbb39b8d31bcb5cb64988f29f9722bc8f5ff00135ff8a3515bdd46581a648844044bb405049e993eb4dd1b5fd53c3d74f75a55d35bcd246636200395ce7a1e28b01edbf172fa5b4f87d796f09225be74b6e0ff0009396ffc741af3ef843a61b9f1ac52edcc7636ef293fed1f957f99ae7757f11ebfe20b58ff00b56f6e6eadd1f7465e20103118e080074aaf69fda96de5ada8bc87ed6bf2794593ce033d318c8eb401e93f1a6f8b5ee91a7a9e238e49dfea4851fc8d794ccdb617278c29abd69677fabc923c7997cbc6f966970ab9e80b37af381504fa4cf73ab0d1bcf86398a492338cb2e110be3a03ce31401a737c5cf15b5a4169632dae9f6d0c6b1a25bc00b000607ccd9aca7d635dd4753b49f5ad42faeade39d1e4433f550c0900640ed4df0ff87e0d5b4b372d70f1ddbdd7936f19c6c72115f6927a139c0ed91ef5d3da43a5e9be22d6a079235fb3c8d1d9b4eeb8189304e482376de99068022f885e34b8f1b9b2861d2dacadad24775df386672c00190300600f7eb5ccff00c23777fd9735cb4d0acab6c2e4da963b9a224609e36fa1009ce39abb7ac925f5cb24be62348c43e72187ae703f90ad182ef51d6d6df4bb4b786495a1588b429879638c7cbbdb38c281db1d0668033e5d16d6da4d42cda45898456ef049202e49c6e751b4719c8f6e2a8476371bbfd5ff00e3c2bbcd27c15e70b6b8bebb464d8d2dc5b202194045655ddefb9738e9595acc16f6be21d46dacd365b4572f1c6b927001c632680336c6ce7dea0a7ea2bd73e1b45247772ef181e51efee2bce2cfef0af51f000ff4997feb91fe62803bda28a2900869bf5a7f6a8cf5a000d19a4a4a005349cd19a2801290d04d250014526693b50029a4cd1d690d00069334bd693340052678a0d2678a0028a28a0028a292800a33499a43400b499a4a4a0075252668cd0019a33cd145002e693eb4514001e28a28fa5001de8cd1450029a33d2928e94c05c9a28a0d0014b9cd251d05003a9293345002d1494a2801738a29a6971c5003ba628cd2514011519a292900ea43494b40067da8cd21349da80173484f4a3145001452668a0028cd1450014525048ed400b4868a0d000292968a004a434b486800a3d69314b9e2800a3de933f9519a003ad26297bd25002d03ad1d29280168a4a28017a514945002d2e69b9a5a005145252f4a005a28cd19a005a293345002d2d252d0028a70a6f6a5a005a5cd145003d077a7e4d461b000c52efe7a5004829d5187f6a707f6a007d733e3619b0b76ff006985749bb9e95cc78e65f2f488582e7f78475f6a068f2bbefbed58d2f5abba85f90e7f763fefaac29b5239ff00543fefaa68449274aacdd6abcbaa13c79238ff006aaabeaac33fba1ff7d5302f31c7e355758bdbf9aca1b692f6e1ed233f2c0d2128a7b1c7e26abb6a8d9ff52bff007d54171a879f134661033df774a00d7d3fc55a9189ac669bccb596d16d3ca248501395231fc439e7bf7ad88b56b3b8d22db4dd4e1ba31da3c8f6f35abaa91bc82c195810791c11835c22b157561d41c8abc7563de11ff7d7ff005a8b01d5e81ad8d2a5b84987996ae85d23740e04ea3f74f83d0834ed1358f2af2fee6eaebcbbfba87115ec89e67972160598f04f232320719ae3ff00b558e7f72bff007d527f6b1cff00a91ff7d51603b48f5244f1758de6a7a847a8428cbe64c919202e18630546719f4aa4905858ead66d75710ded889d5a75b72493186e4720724572e75623fe580ffbea93fb59bfe780ff00bee8b01e8fe2cd5b4dbeb41169cf118967dc91c6d80a9ce3e5f2d71c7b9fc6b97b39618af6de59e2f3a14951a48ffbea1812bf88e2b0d755627fd48ffbea9e3566ff009e233fef5007a1f8abc416bac4721b6b80c866df1c3e5c8a5179c0e5ca8c74e053adbc5f0c11e8f04d6925cdbd8d9ac654b0564986ff009d0f380436083d6bcf46acdff3c47b7cd522eaac7fe58aff00df54580ea34ad727d2ad65b648229639254986e7652922020329520f463587a9f896feefc4936b28c91dcb27940a8c80bb3677cf6ef54db54764602200918ceee959ec7d28b01b5a69916c446647f299f788c93b41c6338f5c77ad8d22c0eabacd8e9cb2088dd4eb17987f8727935cdaea85102884600c0f9ab5740d7b4eb5d76d67d62c1ee2c118f991c4df3138e08e9d0f38cd1603d6ac7c2da3db6b9716e74c9a092cec8963a98f323323481639171c377e9c738accfb73da78dfc6135ba2da43159dc09228c0c7cb841d3dce78ac1bff008b172dba1b0b0531086182396edf748446fbf7301c64b76cf4ae42e7c41737979717538dd35cbb3ccc1b1bcb1c9e07bd2b01eb5a878b349d2ef1e1840d437a3e5ad641b173e5ec0491cf11f38e99ae11a67b8b892790e6495cbb1f524e4d6047aa31ff009623aff7aadc3a937fcf21ff007d53b01d259fdf15ea7e001fbf98ff00d33fea2bc7acb502587ee87fdf55ebbf0e6732c93fcb8c45ebef480efe8a33ed485b1da9001a6b5296f6a69391d2801290f5a5a4a004a28a4cd0021a28269334005252d250014868a4e7bd00069283d68a0043451450014514940076a4cd04d373400b918a4a43d68a0028a28a002928a28003451477a004a5ed494b40051403c525002f4a33de8cd02800a514945002d14714500141a293bd30168a3e945002d145140074a33451de8017b51d28a314808b9a2939a28014f4a4cd145002668a5a4a005a2939a3b50018a3bd1fce8eb4005252d276a0028a283400527f3a28a0028cd1da8a004cf34bc1a4a334009cf5a28a2801334b494743400b452668c5002d25145001451450014514500145149400ea29296800ed45145002d2e69b4bf5a00775a4078f5a4e94b400a0f14e14dcd19a007e79a5069b4b9a005cd385341a5a00753874a6669c2801d5cd78e4674143e92ff4ae94573de341bbc3eded203401e21a90c135813f049ae83531f3115cfdc5005190f5aaadc135664ea6aabd501111d6999ce69e6994c029befde9d4878a00662998a938cf23f5a61a0069a28a51d3ad002a939a907a8151afde35203d4500380e99a914f38a61e4f4a781ebd0d003fa734d3d7de97bd26314084c714f1e9fae299d89a51c6280241cd48bc8a8c1a72f5a00b11f5abb0fe954a3abd00e68035acb8916bd9be1a0ff008f93ff004cc0fd6bc6ac7975af67f868b84bb3fec0fe75233bf3d29a49a71a69a40149451400521345250014d341a4a005a4eb474a4cd0014514940066909a0d25001494519a0033494521a0028a09e29b9a0009f4a4a28a003a7349de834500145145001498a28a005a4a09a280129d4da51d73400b8a282693340052d145001de8a4a514007d68a3f1a5a004c52d2668a005a293bd2d001fa52d252d001477a4a5a005cd14828c7bd00459f5a3d69334b40076a4e94b49400520e94b484e28017345251400b484d14500252d2519a005a4a3b519a00534940a5a004a414a6933400bce69a69690fad0019a28a4a000d141a2800a28a28003494639a28016928a2800a0d276eb46680168a4cd2d0019a5a4cd1400b45149400ea293345003b34669051d6801d4669b4a2801d9a514d14b9a007834e06a3cd3b3400ea514da506801e0e2b13c5cbbbc3b37b329ada1593e275cf87aebfe03fce803c2f521f39ae7a71f31ae9352072d5cedc0f98d006749ea3ad5571cd5b9475aaae7ad520206a67d6a46e339a663d698098c679a43de9dc0141c7340119e9c74a69e3eb4f34ce3ff00ad400d3498e78a3db14b9a005079a901c8a60c53bf9d003d707d6a406a35a901cf5a005ce3b7e147e3474fa0a4239a0414a39e293a903ad38673cd0038738f5a7a0e69807e55247d4d004f1f5abd0f18aa31f5abd0d03362c3ef8af68f86c3f71767fd95fe66bc62c3fd62d7b47c37ff008f6ba3fecaff005a903bb269a69693bd200a4a292800a0d069b4001a4a292801692928a002909e68278a4cd0006928a4268016928a693400b9a426933484d002e78a6e693345002e682693ad1400b49499cd19e4d002d1499a53d280128a4cd1400bde8a4a05003b3499a42696800cd2d37b528e99a005a5a43475a003b5038a292801d466928a005a0d1462800a5f4a4e94b40052d2668a00075a5a01a2800a0d140eb40100eb4bd29338a280178c52668a28003494b4500028a28a004a5a293ad002e693341349de80168a4a05002fad252d25002e293d69692800cd25146280034868a2800a2928a0028cf34b4940074345148734001a2928e9400a68a4ef41e9400b45203474a005ef4520eb4b400b45373c528a005a339a292801734b4945003a8069296801734b4da5cd003a941a6834b9a007034e06a3069c393d680241d2b37c4437681763fd91fceb44551d6c6ed16f07fd333401e17a98f998e2b9cb81fbcc76ae97541891bd2b9bb91cf4a00d6bdf093bf85b4fd56c0079658c34d119725b3d0a823823d335c74aacb2323ab2ba9c329e083e86bd3bc3d24769a5da7da2e2e1ad278592496388810023a8604fcc9d7b703383cd52d474fb5b8bb9749f126ad0bdf244a6d6f9e1f29d81e9f3676c9191c839cfb53b81e6cdde99d3eb5a5ace917ba26a0f677a9b64037291cabaf6653dc56764f714c0b09a6dec9666f56d266b619ccaa99518ebf97af4aac47193cfa5765e1df102c3a1fd896e6de2ba81f7442e1f62b60e41ddd07523a8c7519c9151789bc3aa962baee9d03259c807da62186481c9ea8ebf2b464f423a1e081c52b81c7b600c9200f7a8f20b70c0e3d0e6ba8d33c4969a7d9c303e81612cb10c7da9555657e7392595b9f7ab57fad1d46c9eea268afad61c79f617d6e81e1c9c064740b95ce0646d232323bd3b81c5e46719fc281f5e6bd034ad6341d4b4c97485496c44968f0c564e15e296e09cac865c06dd9e067d00cd7032472432b452a3249192aea460861d4517001fad3d4e4814d1c53872738a60483a5381ce453453c0fcbd6801c4e589c01ecbda908cd141a004e94e0c4f5c9c7ad37a9e94a3a8a00929c94c1fad3d0d022c4639abf0f635462e6af43e9498cd8b0ff5a2bdabe1bf16775ff01feb5e2b61feb057b5fc39ff008f0ba3eebfd6901da9e9499a09a290013484f3413486800273452669334001a3349484d0029a693475a4a0033494b4d3400b9a2909a613cd00389a4269b9a3340013499a3349400b466933cd250029f5a33c52669280168a4ed4668017345251400b45251d28016928a3bd0014514b40076a3a8a3bd1400b4a0d3738a2801d9a4a4a5a005a29296801718a28a4a005a29334b40052d1450014668a31400b4b48296802b5149d68a005a0d07a520a005a28a2800a33499eb4039a0076692928340051d6928f6a005a28eb47d280139a2941a3d680133467340e694d002521eb4b484d001494b450014514134009d6834521a0028349cd18a0028a439a3ad0028eb49fca8a0fa50014b9a6d2e68017b75a4e314514005385369475a00339a5a4fad2e6800ed4b4d0696801696928a005cd2d3696801c0d2834c14a2801f4a0d34668a00901aababe4e917600cfeecf1560545780b69f7207fcf26fe5401e15ab0fde3d73770accc1541624e0003927d2ba7d5d70ef597a42a3ebd6ab21015988c938e769c723a7d7de8033a3d7f53d3adfec90948de10f1c72329124218e594738e79ea0e32714db8961d434e8d669196d15f6c4edcfd8a43d51bd626ede9f860e8dec516b50c97b7b32da5d588db7a23877978fa2322823247dd2491c726b3a1b5b38a3fb4d96a8b2f98c606b6bb80c42518c95660c40f63ea3b530281b9bad3d869fa8c02e2d93fe5de46e029fe289c7ddf50471ea2ac5bdae9d636adac646a16fbd6286de43b4a48724f9abdf0a0918e1b23d08ad8b5d1eda4b6fb34d76f25b97dab672db319ed65c13b7783c12071c10de954d74dd0a6b46b283c4f6f18171e7e6e6d244e3695dbee4127d0727a500741a459cdace9bf6cb4d5af99416df6d2450c42341e80a90e3fdd15d07862384c538d3ed6daee47710cc4721c39da43a00a981df8cf5ae39934d923b6b0926902dba24169a8c17a819c8c921a30d85ce7e5ce3a609e734cb8d5bc4f696ed6b0de47aad85b0db244d0067500f5950fceac3d7903d6901d2ea3f0752f243369925d69ad24e57ec97b182a0ff0075083923d33d45635ef81adb408aef4d9f56305f5e4691abdd46a2dd58307d8d229386f97001eb9ac7d3bc6d0dbdf41737361733ac5b87929a849e590460fcadbb1f855cbfd7a1d7ee6dae74e65379f67fb3de58df2aaa5eaee241520eddc3763b104023d280395d63c33ab68641bdb4610b7dc9e23be371ea187153c73c5e26db0dd4d1c5ac748ee5d804bae38490f66ec1fbf43eb5b562fae69cefff0008d9bc9e0cedbad2e78cc8f6effdd743d47a38c7be0f5e82f2d75bfb425ccba499b4e6b1fb4f91716f1cd23b80331f2bb8609e7393814ee07964b04b6f33c33c6d1cb1b6d747182a476342f4e95de5f6973f8cad92e6db41b9d3b528d42a8f28882e500c00a481871d39ebd33c0ae15e3786468a44649118ab230c1523a823b53b80a0f23d29c09c5300ce2a41d79c7e14c05ce7a71498a28c9a003b53853314e07df8a043fde9ea0e6999c91522f5a18cb1174abd072715493820e6af43d47d693035ec07ce3d6bdb3e1cff00c83ae4ff00b4b5e29600f98b5ed9f0ef8d2ae0ff00b63f95481d913499a334da005a4a4cd19a000d2134521a00534dcd25213400514669a4d002e452134d2693bd0004e6928a42680169b9a28cd00146690d266801d452671466800a293345002d145140051499a2800ed450292801d9a4ef451400b452519a005a5a6e696800a5a2933400e3d2933467228a005ef475a051de8016969a0834a28016928eb45003a8a4cd14005385277a5a000d19a01c5266802b74a3349450038fad1d3bd2668a005cd25251400b4bda928ce6800a28a4ed40052d20fad1400b45251d680168cd250680168a6f7a5ed40051477a2800a29297340052514500149451f5a004c504d14500275a2823149400668cfb51450019a5cf14da5a0033452519a00514b9a6d19e6801d9a01a4a28016941a4ed499a007d19a6e78a326801f452668a007519a414b400e078a506994a0d0049da9930dd6f28f543fca97343728c3d41fe5401e1dac8c48e3d0d72f3b347207462aeadb95875041e0d759ae0c5c483dcd727743934017c4975e441addac68f32ef49a20322541c3ab2f718c91ed91fc357eef42d3f57d3ee25d1204856e2117091997f75943c952df748c956527a1c8f4aa9a2dd14f0f6a4806ef264491d71cf97bd3711e8402c41ed8a9a5d385acf7ba64ac0e91779927656f96d994644a07a762bebc7a50067e92be50786eeff004b9e28a22ac52e03bc51823838e1d01ed9c8ea08a875eb5b695a068daceecdf49e5dbea097046d6046e128c61c8c8f9b8383ce4d5d6f0ac5656763736bab6dbfb805ad6e55bfd1e53fdc071953cf423f91aafa95ddbe9da2a59dc6908b25ec73bb4648cc136e0b953fddf90118f6ed40136a1e14b258e175b5bf792da2115ddbd9c60b3483396cb9c807d4023da836f69af880691f6ad3b5db48c1896ea52259f6f1b7ccc282c0743c1c0c1cf0699a44ebacdec10ea51a9bc8236609731951200a009010410c38caf46ebc1aeb75293ec662b54b1d3e684a09657bbdcbe5c40f327ba8391c1ce78c500799c9a9a4f3c91eb5a724f2a9224923fdc5c06f5240c13fef0fc69c9e1e4d42cdeef4dbadd6c8c0486f504023cfab9254fd01cfb55cd67c5716a7a84aeda469ed61809144f195915477f301dc09fc71d3b5686b373a45ce9ba6a5ce937697ee40b7d3adeedb647111f2b6dc7cacc7a0ea4727a8a604fa1beb06396d26b8d3356b411059112f62795101e396e1954f456cfb115b3ace8178da52c9169cd0e9af202eb616db26b39f6e04eaabcb211c11938ec7a6627b1bbf0dc13e93a46956b67afb470cd38b85f35bc8639215dbef6081bce300671d2a8cdae68b1bcd149e299e181ae56e23fb0798f2439189620e7682a78c1ed8a401ac59f88649acf52d3ad61beb79b62b4a96ab334722e33b99c16038c827a723a8ae5fc636e6dfc61aaa190484dc17dc0f0770073fad6a5eeb0ba9df4f716fe3392dbcde046f0cb14617180bb81627ea473d6b0754d1afec122bab9db34170c7caba8e4de92b75383d73f514d019c3b73d29c3a6290600ed4a383c5500ff00d29b9a77d292800cf19a5e4d20eb4a2801c3a8a997ad443e9520c669302c45db357e2f5aa317ad5d87ae2901b561feb01af6cf87bc6933ff00be3f95789d87df5f5af6df87ff00f2069bfdf1fca803ad269283499a401da93341349400134946693340066909a6e7ad213400e26984d04d266800a33cd349f4a4a005cf5a4a3e9499a005a29292801d4949cd140052d25277a007514945002e79a2928cd002d1da9052d001451499a005a28a4a005a28a2800a28a280168a4a5a0028a4a5a005a5e0d251400b8c52d275a5a00051476a502800a5a4a5a0028a28a0028c5140f5a00ad9a4a3145001f4a0d149de80168a28a000fb502928a005cf6a4cd19a4a005a5ed4525002f51453474a51fad002d14526680169338fa5141a005a4a01a01a005a4e4514668017bd2514500252734b498f7a003b518a28c50034d2734e239a427de80039a4ce294d25001451de8a0028c51c7ad1400514506800ed451450014b4945002d2d2519a005a5c9a6e681400f14679a6d03ad003f34b9a66697de801e0d381fcaa3cd38751401e2fe205c5dca3fda35c8dc8e4d769e255db7f703fdb3fceb8eba1c934012787af12d757f26600c1751b41229fe2560411f520b63df15b8e43787f54b6d4adc62db645733460995863f772463a104609c9e9ebdb8a9b21c153860720fa1ae8ed757b4bab68e7bcb3b89c5b9058dacbb658477047f1444e48fee92474a00a3a66a577e1c9608e7915ac2e0fda2cee9a32c88e3204aa3838cf0cbf5e0f7e8353beb19b4bd32cf58116a5388bec772f0aa836eecc5d30c4720862415c7403a57317fe21fed4d5424564ada6154821d355b2360e005c721fbe47f2ad59ee6c74abb8acaff004f95f4a58d6dbede24dece818b7cf8f94b2b1c01c15c639a00d2d42eee74bb3834ed4aebed16abe658b5c36e710e3eeacc072a7610091861ee38aafe23d3359bad12d34dd32237567180d388ee84cef26380381b940c60e3278cf418b5a9f8863fb53cb0402d6dee26f35aeddccb6f3b150b9674e63e003c8ebdaa1b836f7b6112cf7074ebe57296d2890658751b24501255ebc1c1e7b11401c85ada2e8f6e97d7f6ecf7d21ff41b174cee39c799229fe107eeaff11f615e9fe00d12d340b9b9f10f88d6e6e75d59c2307008b77750dc93d642187d33815c66a76f7b6bae47aedf44e2eadca8beda4b6015d8b709df61c838fe161db35e8bac4c24bb305add30fb7dfb4505cc0d9c4af1aed723b0c05e7a93803a1a00b4fa83ebdab19a5b8b45990b153f6718fb264a941216048241e4f07070a40cd79c6b1e20bd4bf974e4d69ac6453becaeede663697309fbb9073b38e87a704103ad742d1b42964905c3daaddde492dccea32f1410650227e0807fc08fad6678cbc310ff00665d35b59f96b0b35dda3f9e1fe5ce668555474527773c8f9a802debd1e9cd7b0da5a5ec169aa6c06d6e2fed23769f3c64381807231c0241ae2351bdd774abe934ff00112497b1b1ded05db960ddb7c6fd54f6cafe20f4af408425be85e1cd45dacdbc948e0b7b7ba40de74db437c87aaba820827e524806b0122975afb4785f559cdddc3c66ef47bf93ef36724a13db3c823b107d2981c76a5a74504515f58c8f369b3b158ddf1be36182637c7f1007af42391dc0ce5c67ad6be809f6ab8b8d1a5257edc85101fe19d32633f9e57e8c6b2148201c633ce3d29a01dfd6933de9683c1c530105387ad20eb4aa2801e0f4fad4abdaa2038cd489eb8a405a8b935762ea2a94239157a239606901b3a78fde0af6df0171a34be9bc7f2af12d3bfd68af6ff027fc811ffeba7f4a407534c3d6949a4cd00213499a4269a5ba50038b0a613484d26680149a4278a693499e2801d9e290d21a09e9400b4da338a4278a005268a4a4a005a28a3340066928a5cd001452678e28cd002d2519e68cd002d1499a3140052e68e2901a005a3b5277a2801d494525003a928068eb400b9a2928a005efd69030dd8cf34bde9368ce6801697ad2528a0029d8a4c53a800e940a294500252e71494b400bda8a414b40051494b400668c9cd1494015e8a5e307d69314009452f4eb45002668ef40a50280128ec69714940098a4ef4ea314009452e28c668012814b498fce800e9494ec67934714000a434b450037bd2f7a5a4a000d19a5a406800a3a514868016928341e6800a3b5276a33400869314b4500368a5349de81876cd1d85145020a28a4a005a43cd07a51d6800a5a4a33eb400b9a05251400b499a293bd002e6973487d2806801d9a0114c271cd00e4d003f3934e06999a037340c9334e079151e45394ff003a00f24f14ae352b81fed9a4f0e7842dbc53e1dd436c9e46a105c010cdc90415fbac3d33dfa8a9bc5a31aadc8ff6c9addf852c05b6a80f413c648ff809a04790eb5a45fe897ad69a95b3413f519e55c7aa9e845652cb2c132cd0caf1c8bf75d0e08fc457ba6a57b6645f687e248ceb491ccac924510df10756661c7428ab9c8e715c9f883e115e45bae3c3b74b7d6e543adb48c04aaa79183d181ed9c5501c14be23d519582cd146ee36bcd15ba24ac3be5c006b3ecf51bbd3a4f32d2768c9e197aab8f4653c11f5a5bdb4b9b2b86b7bab796de653831ca85483f43d6aa918a00e8f48f13dae9f2caf269af179c0097fb3e6f24360e41d84151f86073d2afd9f89f437b893ccd3e7d284b90cd6ae268a41ff004d2161b0ff00c040fa57167d282714580f55b5bfd362b6585352d3afb4e524aa09823c7b860858e53950470543e0ff0077a525c4f0787a7b0ba03509344b39c8b5905befdc8487f2641b8105594149013c0c76af29cfae6ac5a6a77fa664d85edcdae7a88266407ea01c52b01eb37ca1d6f807710c723ddc6d8cb0b69d4798081d0a3139159b25dea361aadd7977d73a60d5e6b665b8814cb145703865201e4382183771ed9ae53c37e299ec6f0fdaae9b7b48658ee6525823b70e241fc51b8c06f4c03dabb5b6f2daf4c5a7edb664da5f4d9250b24233b8342c72b2479e541c819e08a4045e28d4f41d6fc476ba44d0cb6f756a63480c48555a47dac586cce3271c153d3a8a48749b8bff0013e91a8e9a627b78350998af9aa2410990e1f667254fcdc8abada44f2decf70b697ad752655a47b24b70c318c991199b04750b83589a8cb61e13925d4ae2f96f7c472c5e5db2c48123b44c6d0557b003a67f2eb40183188e5f89e5edf0215d5249011d022b3127e9815cd310c7701c37cd8fad6ac68fa3e9d24b3394bebc84c7145fc71c4df79dbd0b0e00eb824fa564ff009c5520147349f852f3f866931cfe34c0074a7f414d14ff00e1c5002fb66a44e9c5462a45c75a4c0b5175157a0eb5461eb57a1a406d69dfeb16bdbbc0bc684dfeff00f4af12d3c7ef16bdb3c1271a11f77fe9480e90b629a58d349a3340066909a3348680149a6e68fe7499a003391484fa51d69a4d002d1499a4cd003a8e293349400b9a4cd19a4a005cd03a52519a005cf14668cd2671400b476a4cd140052e6928a005a527f0a4a31ef400b4518a5cd00252d27e34b8e28012968a51400945145001d68ef452d001475a314b8a0051d281482945002d2d19a4a005a3340a5a004a28e6945001d68e68a33400514519a002969314668020a4cd29a001f8d001d68029692801314a3a514500079a6e39a77634da000d14b8a28013ad29e28146280138a29703341140051c514500149451f8d001452f5a4e9400527ad2d1400983487229c78a280108a4c529e9450026293a53a93bd002525388a4c503129314efc29bd6800a4a5a422800a69a76293140099a514628a00293b52f6a4278a041d78a3b8a4268cd0317340a4a050217bd19a693834034001340a0f3450316941c537a52668024069e0f7a8734f53401e65e3118d5ae38fe2ac5f0ef8aee7c2ba834a8826b5948f3a13df1d083d8d6f78cc7fc4da7fc3f9570377c13e9408f4c81eda3d3db58b19a3bdd323ba7ba95e38ffd263f311d1848bfc58dc39f4cfa541a379d63afe9d78fbd6e66bab5b2941270d0b5a02011ecc33f5ae5ad747d774636daa7872799e5fecd8ef6e95481b158b0c63f8861738adbd1fc79e1fd6f58b0bff10c6f67a95b6364f139f2243820175ec464fe754a4077f7f73e18d6afa6d1754167717511dad05ca73f7776549f6f7ae3758f83de1eb8bb5834bd525b0b8951a58ede46f39594752b939c0c8ef5b1aa687fda73dc5cac30ea1a7deeaf6571988890189536396c76fe9553c36fb3c45e1c859b0215d52d9039c61564f95467d063145b403c57c4de1ebbf0bebd73a5ddb248f0918923c85752321866b1cf535ee3f1b3c3a66b6b3d7a15e62ff46b8fa1e51bf3c8fc6bc3482320f5079a76d2e034f4a6939ff0a71a6375ed4009cd68d96b9736b00b496386f2d17eec17033e5fba30f990fd0d66f523149d483401d27fc24366e9b4c1a9c43ba47a8b15ff00c781355ffb66dad58be9da6c714e7fe5e2e2433c8beeb9e01f7c66b0d7029fe94ac04f2c924f2b4b348d24ae72cee7258fbd20e94dcf4f734f1c75a601f4341e68ef471f4a00075e29c06052014bd7de801c39ef5228e47a546383cd489cd202d45d7dab420fd6b3e1e4d6843d6901b3a77322d7b57837fe4043fdf35e2da70fde835ed3e1018d097fdf3480e8338e9484d21a4a00524d19a4cd373400ea4248a33c5349a003269a4934b9a0f4c8a004cd14832452d002e69375216c507a71400b9c8a01a4c51400efc68a6f34d248e9401251480d1400a28e948296800cd19a28eb400679a5cd2639a5a0001a5e82930314a0f1400b41a3b518a0028a5a319340094a28ed4a0500251de968a004a5fa518e6940a004c538518e68a005c77a322928c5002f6a28ed45002d25145001452d140094b451400519a4a5a00800a420e6941a3340094bf8d213e828e7d38a0032734b476a41926800c71474a75276a004ed499a500d047340001c500d183401400b9e68ea68c75a05002d27d296928012971c8a0fd2814009de97068a5a004a4a0d140051d28a280131498a7628a004a297149de80131498c53a8c503198a434fc518e2801b8e2929d8e292801a7ad3714fc7ad18a0061a08a71181498a006f6a4a751da801a6929c7a521a004a3341a4a0028a290f140013c500d27146680168a693ebd28dd400ea7ab5459e694373401e7fe3453fda92fb81fcabcfef559b785eb835e8be351fe9ec7d50579f5cff00ac3408f4bf0dea5a5ea76172963298e6167f6616d29cc856381f9fa6e24fe158dac7876cf5f8fc396096474eb8b82910b848403108e3ccb1c83b9e0329ee0d645d7858db7866db5bd32f6e17504b31793a8e079458a128c39c8ee0f6a9b4df88332ea1a741ac5bc70f93bcc9741183333c3e5a3b2fb0c723ad00615d45aef82b59b28f42d4ee644d422135a1897065058ae0a723391f8d6cff00c2cc82fb658f8c7c390dd490b1fdec60c32a1ee71d8d5d8a6b2d5fe2bf846d34fb94bbb5d36d63469220769650ccc47e38ae9fc4761a5def87bc43aadd59dbdd5dded925d425e304c47688e3c1ea0eedc78a006e9fe25f046bde159fc3a9ab496a9346d1a2ea2c7cc8c9e41dc720e0e3bf6af04d42d1ed2f258642ace8e518a1c8241c6411d41eb5e9de2cf867a6e9da259b6993caba89b9b6b29c4f2feebcc9172c49232b835caf89fc077be1cb07bf5bfb5d42ca2b9fb24b240197cb987f0e08e47b8ab52d2c071c7d48a6138abd6fa6dedf5bdddc5adacb2c368824b89147112938049ed54fcb623708dca8382429207e34011669314a597bb28fc690e09ea2801c29e3a544081d481f5352e5547ccc07a73400f1dbf3a70e99c8a62e08c8c11ec69e39c67ad002f7a39c734a69074c5001db9a70a4e7bfe94e0280140e79a95054638192702badd07c05aceb2e924b17d86d0aef69675f9b67a84ebf89c0f7a570302052d22a206676380a0649abf0f515d7ddb687a0e957561e1f91ee3509142dd5f2fcdb23ce0a86ed9ee178f735c9205f3084cedcf19a2da5c5757b1b3a77fac15ed3e11ff900a1f5635e2fa77fac5af68f0af1a147fef1a919b84d2537349de80173cd07eb49499a00766933487da8a0028a29280168a292800340a383499c1a00776a4ed4668fe7400518e6971477a006f7a519ef4bd7eb4639a000528a4c1cf14b400629692971400528e69714d02801714629451cd0000d2d0052e28012940a5c52e314009452e28e9f4a004a43eb4a452e01eb40080d28a4238e28073400b8a28a38a002968a2800a296928014d14520a005a0d145001d28a293bd002e28145140106da02f3ed4ecf4ed4500263ad2d18e68c5002628e8297bd140098a297bd140098c5141eb8a2800c628c62968ef400de94034a4518a0028c518a5c5002518a5a31cd00252e28228ed40086931c52f7a31400dc52e39a5345002518f4a5c518a004c52e28a3b50034d14ec52628189d29a69d46da006f5a08a5c52e381400c2293b53f148450030f5a4a7e28db4011f7a29c45211400d229314ea31400cc521a711cd21a006d253a92801314d3d29c693ad00368a28a0028a3b50280389f1b0c5d21f5415e77779dcd8eb838af48f1b2fef623fec7f5af37bcfbc78a047677ba71b9f0079568f398d2281ede6cf05a67093439ee33ce0f4ab9e3fb4b5bfd2aded63862f36cb54b6d3566551bf6945dcb9fc6b92b75d6b42d2f4ed690b5c696ce2e6484336c42af805c7d71835d458f896dbc5b169b0cef6f1deb6bc97062550bfba1d09381b88e99ebd2819c978abc32fe04d57ed5a3ebc92491cc620a0ec9e22573f301c118ee2a2d3be215edb422d355b64bcb526dd58a9d8fe5c2c5828edce79ab1f142e52e3c63703fb2ded6e23765794eeff4a5e02b0078f6c8eb5db784345d2f49d36f346beb2b5bbba8ac7edda899903ec95bee4633d30a3f33408c6d4bc5be1df1d6932e977b743487bad552e1ddd0ff00aa008c96e46ec71e9591f13eee6b6b0d3346d312d23f0dc449b4fb35c899a771d5df1c83cf43eb49a1782349bbf055a6bbab5c5e21d42f16dada2b654f977b95527239ff00015cc78b3c312f853c4771a4c93f9ad1059229538dca79071d8f1fa500cd5f1186f08f82ecbc2eac06a1a86dbfd508eaaa7fd5c5f80e4d7aa7c2fd324d27c19a3426d0b0d51a6bcb8729908368d80e7a67e5c7d0d7cfb7b25d5fcef717774f713bfdf9252599bb724d7556df14bc5367a84178f2dbca60b536a9198404099cf45c73c75a624d1e91e16d274ad2fc03a2cd7cba442d797f24d7125fc684b43bdb2abb875c28ae73c5765a05b7c2ad4355d374eb545d475875b29446372c5bcfdd3d40c2feb5c2f88bc6979e22d1b4ad326b6821834e0447e567e6c8c64e4d2eb7e339358f06e8be1b5b24b7874cc9f315c9321c632476eff9d219e97f0f347d1ee3c15613e95a5e9baa6ab1b3bea56976009a55e7010b0c003e5e9c1ab1e10d22d2dfc3916af63a0da8d4b56d5dd62b6b8087cb8158931a96040e14d723a6fc5dfecfd374e54d0a13a969f68d6905cf9ac14290016283a9e0543a57c59b9d3f47d26d64d22d6e2e34b95a4b79ddd87dece4951c13f31e698183e3f30ffc275ab2c56315884976b5bc4c0aa30001c1000eb5ce0ce3d6acea9a849aaead79a8ce0096ea66999474058e7155877a60398e39cf4ab9fd9d2a223ccf1428ff0074b364fe554b92a71d6bdbbc2d3787efeccc7a2597d9fecf2c314974d6d1c6ce369676ddf3383b549ebde86c0f249747bd4b496f52dae24b389434970d11445c9c632d8cf3e99ae9f40f87936a166b7dabde2e9b64577fcc406dbdb25b8527d393ec2b46d7c47378d7c496b6b2dadbc5616464bbf2f96f336709bcb125864a71f5aade36b7d775af17dee9b6d697b3c160fe446bb485e3ab9278cb1c926901ade1dd1bc3975e2c91b4d8049a7e930a334d9794cd23b603b71d1707a0c720f6ad7f15695a9dcf86752bcd4754995d2369a3b5b6554818a9036b824bb1c30e5b9f6ae67c27e14bab692eef2f35b934b114a6d6416b2e3ccc6091bfb8c9c61431cf6ab9afdde9e2c9742d25a48ed9df7c8c7734d704739e7240c80496e4e07000a00ac9656367e158f4e95675d52ec895e34037903380ff00dc5e8726b98452921438dca70715a4f791594222214b904b448d924fac8fd49f6fe559e877b97eec4938aa94f9898c794d7d37fd62d7b4f85bfe40317d4ff3af17d347ceb5ed1e1918d060fc7f9d4146c5141a4a002834521a003340a4a28017bd1499e69739a002814940a0043c529a5c518cd00039145029d400940a2968013a528a319a5a0028c6280334ea006e29471da82334007d680168c52e38c77a76da006814ec628e94ef6a004c518c53b149da801318ef4a6939fc6945001498a75250020a314b45001498a7518cd003452f4a5c518a004eb40e94ec525001c514b40140098a318a33f952d00252e3da8c500d00251f4a752500277a53d293bd2d00427a66929c69381400633494bd68340051494bd68013bd2f6a3149da800a39fc2968c5001452f4a280128a5a2800a4a5a28012969296800a4a5e9462800a31475a3140094629d498a002814628a004c514b8a28012822971450021029294d140c4a29714868010f3498a7d262801b8c52114f3486801845211c53f14841a00888e292a42b49b7b0a008c8a6e2a4229a460d0036929c4525003690d3a908a006e38a6d388cd250025283cd274a0500723e361f3407fd9af33bce18915e91e329d5e6487f89179fc6bce6f472680675de18f1258dd69569a15d2a44cb244986e565018363f31d3dea2f1278116e5ef351d2f16f34736248557e467f2d38007dd25db1e95e7d212ad904820e4115bda0f8eaf7474fb35c83756ad2c6ed93f3aed70e707be71de8119de24935db3d4ad2d75c9e469ed23cdb3b48240177672addf0c3f315d9e87f10ad24f0e6bedae98a4d4a787cb8cc5108dee576e30ce3be4f04d5759fc3de30f1e685007b89a3876a6248d44728cb48e181e739f4eb57ae7c01a76b9a84ec227d2e636f0362d4af94cf2337cfb0f4014648e0f19a00dbd32d45ff87be1dd969d1b4f650dc79f72f18dc2368d49c37a1dc7bd79b7c4bbdfb77c43d6240db963758171d005500feb9a7da685e2ad2f414d5b4bbd3f65b9b9fb3ac76d3957909728adb7a10c470735cdea7a76a5a65db41a9d95d5bdc1cb113467279e4e7bf34132bd8a2588a61639cd05d1ba302290fb53322b4c9b4e7f84f4a8b3d054f302d1fbd560718a66d17a0f07d7f4a77079a8c741cfff005a9e0d318f079fe74ff4a62f4cd381e680245c0af55d02483c3bf0b67ba69505f5e413cd146ae0b93211127ca39e1439fc6bca39db5d343abdbdb5ac086e096545056de323b72096c7e80d26049e156bfd0b534d464b18ded1e27b79a3ba7f2c491be011fde0780738aed2ebc7d797737d9edd2495d17e451ba5db8ee649381f5033ef5e7f36bc8ec5a3b512cbc625b96dd8c74c28c2fe60d52b8d4eeeec626b8729fdd1c0fc85203a4b9d604370f2c974125762d3083e77762727e73d33dfd6b1e4d5a56468add16de3230421f988f42dd6b2c76a913ad005a88e4d5e87b0aa30e7d2afc23268036b4dfbebf5af68f0cffc8060f5e7f9d78c69bf7d6bd5bc2374641776c4f1114da3d011486937a9d3d1d28a281099a43cd2d26334009cd1d69c28a004c52d2500d002d1451400514b450002971462968012968a2800eb4bda814e02801074a5c52e2945002014b8c51834ea006d029d8a4c5001d69452e318a2800a3140e2945002114839a751400dcd2d2e292800a434ec71450030f14b9cd2e3340140051452d00028a0f1450014b4945001da8ea2834b400d06968a2801719a4a5a28013b514b45004549d697b5140063b52114bc519f7a004c71411c52d2f4a006f3494fa4c50036979a314b400947d6971494005141a073400b494b45002628c629d49d680128ef4bcd281400da5a5c518a004c514bed45002514b8f6a5a006e29714b498a004a2948a31400dc514ec518a006e28239a762931400d345291498e28003d28c514bed40094d23da9d8a43d7da801b8a6919a791c521e0503232a69a7a5498e29ac38e28023eb498a502820d0030d277a7114d340094d2694d36800271499a4634dddc500707e287cebb7719ebe5230fd6b86bdfbcd5daf8c8fd9fc410cc480af16c63f9d71ba826c738e87a54a67456a568a9a3126ea6a8c9d6afcf54243cd59cc44b34904cb2c6cc9221dcaca7041f5cd749a678ff58b19775c3ade7ef0484cdcb12a8517e6ebc026b977e4d4679a00f62d1fe20f86ee934fb4b981f4e4b6b9b56e72ea522562791d09639ae934fd62d6ee677b5bb4be9ecb4c9a426d1d4b99a69492103e01202e6be77cf3d79a165746051995ba6e07068b00fbf9deeafeeae2562d24b2bbb12a149249ea0700fd2a99fa9a948ef511ebed4c06966c1f98fe74df7cff00f5a9c69b4c05029c3b734d07f9d3bbd003874a9147a8cd305483a66801d8fa6697e9480734b8ed400a3a5380a6e29ca2801e3daa543822a25eb528e08f5a902d4279c62af43d45518cf22af45f781a00ddd29774aa3debd07c01379d7baac80f04a807f3af3db77167686427e76181ed9af40f86b118ecee9dbef3e1aa2fa9dca87250739753bda4a42693354708ea4cd19a4a007673462900a514001e9452d277a0031cd2d028ebc5001d7a503a7bd2e2940e6801314a3a52914a16801319a762940a760500340f6a50053b18a2800a4c53a9083cd0018a281cf5a003400bd68c62802968012814b4b400da5a31cd2d002628a534500262814b40a003148053bb5250021a4a5ea68c50026294714bda92800a297f9525002d1494b4009f5a5a4347b5001d6968a2800a05147e340077a5c5277a5140116282294d250026334b8a3a51dc50026334a0514ec50025262971cd14009c534d38d18a006d18e29d8e2931400dc52f4a5c5277a005a074a314b9a004a7638a4a5a00293de97b51de801297a51c51f4a00414b452d002518a5ef450027414b494b400521a5a280131462968a004a2968a00423d29b8f5a7518a0068146314a7814b400d3d29314e3d29bd280136e290ad38f34868019b6936d3c8a4c501722c62908a948a8dbad00464639a6548d519ebed40c6134c269e6a26a00463c5459209e69ed5048e1680b1c778de2f3e503bec18ae16397ed1034529fde2f15def8ac86b85ff0076bcfb5185a36f3a1fbca7240acdee7b7868a9d2e4919b751b46e54f4ec7d6b3a4fbc2b645c45751e1873dc7a566dcdb326597e65f61c8aa52b9c188c14e96ab5467b70714c34f7e726984f1daace21879e94d6a77534d7a603188c74a613c53b14d614c06374a4c52f5fad18e2801314a076a3df14b8cfd6801e3da9e3ad317f954800e2801ca4fa7e94e009fe54d14f078007e74000fd6947b518c1e48fc0d00719a0078e3152a9e7daa304e054d6f13caf851c7727a54b2a31727644f11e471d7a56c59dbec22597838ce0f6aad6f0c76e379396ee4f6a1a692f1c451e447dcfad67299eb6132f77e6a85f8a537f7581fea50fe75eade06f96de7fa0af34b18962088a38af49f061c2cfee054c7734cc2dececb63b1cd28a88353c1ad4f0c78a5a6838a5cd002d28e9452f7a002940a07a52e2801314b8a752f6a0066334a077a7ed34e0b8a006814bb69f8a440c0618e4d0018a314b450014628c52e2800a4cf3834b4879a005a28c52e314000a2971450020eb4b8a3b518e28001ef4628a5a004a42714b41140080f7a5a07d28e868017ad2629693340062928e4d1400a4d25145001482968c734008052d2f6a4a0028a28a004e94b8a5cd140098f5a5c5141f6a0028ce3e949475a0061a4a5a280128c5291450014b49466800a283cd1d3eb400628a5a280129314b450014639a28a0043471d697149fca800a5c1a00e69680128c528a28012968a4c9cf1d28014521cf6a5e94b400de7bd2d147ad001450297ad00252d252d002527e34a6908f4eb4000e9464d18a5a00414b4514009452d275a0043494a47349400521a0f4a28010d37b53e9b8a00434c2326a4c5348a00888e698578a988e2a323ae68190b0a85c5596150b8c673401030aab30ab4f55a5e8686544e3fc50d996323bad71b71dc576be294fdd45201d0915c4ce793594b73d8c27c08c5bab62ae648890dd4e2a15b8ddc3f047eb5a33724d519a156c9c73eb48f4a2d495995a6b78e6c90006f515465b591071f3afb55ddac0e0534920e08e6ad368e7ad97d2a9aad1998415241183e869a4fb569b859061c06fad40d6b193c165fa7355cc79b532bab1f8752835309c8ab6f66e3eeb023f2a89ade65e884fd2ab991c72c2d68ef1657c60f3487b53de175e7cb7fca9a4377047d453b9938496e8075e69c067df14de9d7a7bd3d727a03f80345c5cac728c1a78f6a16290f011cfe1522dbcbc7c98fa9a572e34a72d931a3a52f1532d9b9fbcea3f0cd4e2dd0b6e72589ebd852e647443015e7f64a78c8381532412c9d1700f7357238951728a17e829fbc0e3bd4b99dd4b297f6d8c86cd06379dfec781568cab12e00e7b01510495bfd91ef522408304fcc7d6b36db3d3a585a54b6435165b96f989095a96f12460051c5578b01855a8b8348d26f4b1a36dd78af43f068c413bf6f94579e5af5af4cf0bc060d251987cd21ddf876ab8ee7918f7681d103c53c1a854d3d6b43c5260734fa62f029e39e6801c2969075a7014000a781405a781814008169c17d69696800028ef4bd2968013bd2e31452e680128a2945002514bde971400d029318a7d348e680014b401814a050025141e0e68a0001a5a41466801d486933d6901a005e9471494b400628347d683c0a000d369d8e28c714009da8a28ed8a0028a2973da80128a5fe7486800a0734504fe540076a2909e3a528e9400a28eb49da8ed400ea4cd19e68a004a3a528348793400dc518a294d00368ef452d0025252d140052114a28a005a4ef4bf8d2138a002969051400b494b47b50021a052d2e28013a51d683d28c5001452fb527e34005028a28003d281d28a5e280133cd2e29296800a28a5140098a3eb4a4d21a004a38a5a280128a5a28013a514b45002628a5a4a004a434ec5211400dc668c53b14845002629314ea5a006114d229f4deb400c3d7069840a908e69ac280216a85d6ac30e698cb9a0652718cd5594706b41d38aab2a7140d3b1ce6b56ff69b3923ef8cafd6bcdee32a4e72083822bd5af22e0fd2b81f10d8345219e35f95bef01d8d4491e8e0aad9f2b39997eb555f9ab121e6aab9e6a0f662885c0cd479c1e4023dea492a2279a68da3b0b889fd50fe6290c2d8cab2bfd0d349a4a2c55842ac0fcca41f7149914edc4742451bb3d87e54876199a319eb4edaa4f4146d5f4a9bb1722109dc72793eb40e2976afa5280bfddcfe345d8722ec27bd1c53c328fe05fc69e2623a2a8fa0aa4d8ec30063d149fa0a916090f24aa0ff0068ff004a6f98cc79268c9cd1a8ec4be5c63969598fa018a5de17fd5a2afbf7fcea2cf3d69c28b0587e4b1e4d482a34e4d48809a04c9e2ea2adc7c9aab0afcc2b4adadda5902aae493d05231a8d2dcd1d1ad1ef6fa38947ca4fcc7d057aa5b288e2545e8a302b99f0f697f61837381e6bf5f6f6aea211d07b56b15647cf636b7b49d96c8b6838a917ad35054ca3a0aa38455e6a40091ed488bed532a6050022afad48052814a0500029c3ad0052e3da800c52814829680168a2814005283498f6a51400b8a3a518e296801b8ce296968c500252639a7514009494a6908140070690f5a5a5a006e38a29c2938a004eb4878a7518a004cd1ba8c5262801734a477a4eb4a0f340051d683494009bb18e08a5a28fc68012969280280168a29280168e3bd1450018e29296909c5002f6a28cf1ef463bd0014a7a5277a3340051451401cd7fc275a17fcf69bfefd1a4ff0084eb43ff009ed37fdfa35e5745797f5ca87dc7fabd85eefef3d53fe13ad0ff00e7b4b8ff00ae4693fe139d0ffe7b4dff007e8d7965147d72a07fabd85eefef3d4ffe139d0ffe7b4dff007e8d2ffc273a1ffcf69bfefd1af2ba28fae540ff0057b0bddfde7a9ffc273a1ffcf697fefd1a3fe139d0ff00e7b4bff7e8d7965147d72a07fabd85eefef3d4cf8e743c7fae97fefd1a3fe139d0ff00e7b4dff7e8d7965147d72a07fabd85eefef3d53fe139d0ff00e7b4bff7e8d1ff0009ce87ff003da6ff00bf46bcae8a3eb9503fd5ec2f77f79ea9ff0009d687ff003da6ff00bf468ff84eb43ff9ed37fdfa35e57451f5ca81feaf617bbfbcf54ff84e742ff9ed37fdfa347fc275a1ff00cf79bfefd1af2ba28fae540ff57b0bddfde7aa7fc275a1ff00cf69bfefd1a3fe13ad0ffe7b4dff007e8d795d147d72a07fabd85eefef3d53fe13ad0ffe7b4dff007e8d1ff09d687ff3da6ffbf46bcae8a3eb9503fd5ec2f77f79ea9ff09d687ff3da6ffbf468ff0084eb43ff009ed37fdfa35e57451f5ca81feaf617bbfbcf54ff0084eb43ff009ed37fdfa347fc275a1ffcf697fefd1af2ba28fae540ff0057b0bddfde7aaffc275a17fcf697fefd1a3fe13ad0bfe7b4bff7e8d7955147d72a07fabd85eefef3d57fe13ad0bfe7b4bff7e8d1ff0009d685ff003da6ff00bf46bcaa8a3eb9503fd5ec2f77f79eabff0009de85ff003da6ff00bf468ff84eb43ff9ed37fdfa35e55451f5ca81feaf617bbfbcf55ff84ef42ff9ed2ffdfa347fc275a17fcf69bfefd1af2aa28fae540ff57b0bddfde7aaff00c275a17fcf697fefd1a3fe13ad0bfe7b4bff007e8d7955147d72a07fabd85eefef3d57fe13ad0bfe7b4dff007e8d1ff09d685ff3de6ffbf46bcaa8a3eb9503fd5ec2f77f79eabff09d687ff3da5ffbf468ff0084eb43ff009ed2ff00dfa35e55451f5ca81feaf617bbfbcf55ff0084eb43ff009ed37fdfa349ff0009d687ff003da5ff00bf46bcae8a3eb9503fd5ec2f77f79ea9ff0009d687ff003da6ff00bf4693fe13ad0ffe7b4dff007e8d7965147d72a07fabd85eefef3d4cf8e743ff009ed2ff00dfa347fc273a1ffcf697fefd1af2ca28fae540ff0057b0bddfde7a9ffc271a1ffcf697fefd1a43e38d0ffe7b4dff007e8d796d147d72a07fabd85eefef3d44f8df443ff2da5ffbf469a7c6da27fcf697fefd1af30a28fae540ff0057b0bddfde7a71f1ae887fe5b4bff7e8d34f8d345c7fae97fefd9af33a28fae540ff0057b0bddfde7a49f18e8a7fe5acbff7ecd42de2dd1cf4965ffbf66bcf28a3eb9503fd5ec2f77f79dbcfe23d2a50712c9ff7ecd62de5fd85c2950cc548e856b0a8a3eb950a8e43868ea9b332f74c2d331b72190f4cf1549b49bb3d117fefaae828a9fad4cec8e5d492b5d9cd368d7847dc4ffbea98744bdfee27fdf42ba8a29fd6a65ac0d33963a15eff00713fefa149fd857dfdc4ff00be85755451f5a98fea54ce57fb0afbfb89ff007d8a3fb0af7fb8bff7d0aeaa8a5f59987d4e99caff00615f7f713fefa147f615f7f713fefa15d55147d6663fa9d3395fec2befee27fdf428fec2befee2ff00df42baaa297d6661f53a672bfd857dfdc4ff00be852ff61deff713fefa15d4d14feb330fa9d3396fec3be1fc0bff007d0a77f625eff713fefaae9e8a3eb530fa9d33981a25eff713fefaa7ae8d783f857fefaae928a7f5a987d4e99ceae8f760fdd5ff00beaa45d2ae87f0ae3fdeadea297d6662fa9d333ec34a9a69c464007d49aedb4bd262b45521416f535cd0241c83823b8aea3c3da8fda9becd31ccca32a7fbc3fc6ba6862149da5b9e1e6d81a90a6ea53774b737a08b18ad18978a64309fc2aec51002bb4f936c544cd5854f6a152a555a091428029c0d039a701400bd69714629450028a281462800c52d0051400b8a5a28a00074a3bd19a2800ef4b487d68a005a29a1bd69d40052503da8eb400b4da06697a50026294d2e29b4006696931c7bd1d2801450681450025211d29d8f4a280194b9c52d235001d45140a2800c50460d19a33d6800349cd2e68a003bd141a3340094b40a280128a28a005a28fc68a00314628a3bd0014519a2803c168a28af04fd5428a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a294027a027e8280b89450411d411f51450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001453951e43844663e8aa4ff2a568a58c65e291474cb211fce8b0b995ec328a28a06145145001451450014514500145145001451450014514500145145001566c2e1ad750b79d4f2920cfd33cd56a747feb53fde1fce9c5d9a64558a941a7b58f6148f071e953aad2851b8fd4d3d457ba7e5d2dc7281520e69a053c5020a701498a51400b4668a5a002969052d0028f5a28068268016909a33476a0001a5cd252d001499e28e945003792dd38a7519f7a3bd00068a5e28e940074a2928ef8a007521a4cd1da801475a4ef40a334000a5f6a68268cd0038d2521a33400b9a0d26683d3ad002138a5a434646280169294d1400514947e3400b4527b52d002506968a004a28a3a50014b49d696800a33ed49de8a00297ad2668a00f06a28a2bc13f550aeb7c35e02bed7a25ba99fec966dcab15cb38f503d3dcd73da4daadf6b16568ff7269d11be84d7d0c02dada6234c2469f2a28ec07415d586a2a7794b647839d665530bcb4e97c4fa9c743f0bb434402592ea56fef79bb7f41515d7c2cd2a45ff0046b9b984fa960ffceb8dd43e20f882eaea468aefecd16e3b628d07ca3dc919cd4961f11f5fb49019e68eee3eeb22007f35ff00ebd69ed70f7b729c8b059b72fb45535ed7fe919de26f0c5c7866e628e69e29925c98d9383c75c8edd6b0ab67c4dafbf88f5737ad1989020448c9ced03af3f5cd6357254e5e67cbb1f4384f6dec63edfe2ea5ad3ac65d4f52b7b2847ef267083dbd4fe0327f0af4f1f0a74dc0ff004dbaff00c77fc2b2fe16e8de6dddc6af2afcb10f2a1cf727ef1fe43f3af419f5bb5b7d76db4876ff0048b88da45f6c638fc79fcabb30f461c9cd3ea7cde6d9957fac7b2c3bb72ad6dfd743c3fc49a2b681adcd624b34630d1b9eaca6b26bd73e2768bf6bd223d4e25ccb6a7e7c7743d7f23835e475cd5e9fb39b48f6f2bc5fd6b0ca6f75a3357c37a643ac6bf6b613b3ac5293928707804d7a4ffc2acd1f1ff1f175ff007dff00f5ab83f02ffc8e5a7ffbcdff00a09af65d7aea6b2f0fea1756efb268adddd1b19c10a483835d186a70941b923c6cef1588a7898d3a526aebf5397ff8559a37fcf7bbff00bec7f851ff000ab346ff009ef77ff7f3ff00ad5c37fc2c0f13ff00d04bff002047ff00c4d27fc2c0f147fd04bff2047ffc4d1ed70ffca5fd4336ff009fabef7fe4278d340b5f0f6ad15ada348c8f1072643939c91fd2b9babdaa6b17fad5c2dc6a13f9d2aaec0db02e0673d87bd51ae4a8e2e4dc763dfc242ac28c6355de4b7614514541d04f65673ea17b15a5b465e695b6aa8ff3d2bd561f865a2c3668d792dc34aa9991c4bb549ee71d8549f0fbc29fd9567fda5791e2f675f9558731a7a7d4f7fcab3fe2478a7cb43a259c9f3b0cdcb29fba3fbbf53fcbeb5dd0a51a74f9ea1f2d8ac757c662d61f0b2b25bb5f8b3cf757fecf1a9cc9a5ac82d14ed4691f717c753f4aa3455ad36c9f51d4edac90e1a790267d01ea7f2ae2f8a5a1f4aad4a9fbcf44b737bc2de0bbcf119f3d9cdbd929c1948c963e8a3fad7a0dbfc36f0f431859219666eecf29ae96d6dedf4cd3a3862511c1047803b00057906b5f10b58bdd4246b0b936b6aac4468aa3247a927b9f4af41c29508ae65767c947118ecceb4950972c57c8ea357f85d632c2cfa5cf241281909236f43edea2bcc2fac6e74dbd92d2ee231cd19c329fe63d457ad780bc5f3eba92d9df95377080c24031e62fa91ea3daaafc50d1926d322d5634025b7609211dd18e07e471f99a9ab4a1387b481d181c7e270f8afaae29defd4f27a28a2b80fa91c88d248b1a2ee7621547a93c015ef5e1fd02d745d0e0b668d19d5774ae547ccc7926bc9bc0b622ff00c5b66ac3290e666fc071fa9af56f19df9d37c277d32361da3f2d707072c71fd735dd858a8c5d467cb67b5a752bd3c2c1effae8794ea46ebc61e2d9934e843066d912818558c7f11f41dff1c576fa57c2ed3e1895b529e4b997baa1d883fa9fc6bce343d7afbc3f79f69b275f9800e8e32ae3dfff00ad5d56b3f13afaeede28f4c8bec6c57f7aed8639f45ed8f7c7e5514e74b59cf73a71987c7de3430da42d6bff009ffc03b46f0078699368d3d41f50e73fceb94f11fc34fb2db3dde8f249204196b790ee247fb27d7d8d73169e35f105a5d2cffda32ca01cb472fccac3d31dbf0af72b69bed3671cc54aef40d83db2335bc152ac9a48f2f112c7e5b38ca552e9f9dff33e6eae97c2de0ebbf124864dde45921c34d8c927d147ad54d6ec449e31bcb1b503f797663403a024f4fd6bdcb4db0834ad320b48142c50a051efea6b0a1414a4f9b647ad9a6692a1421ecbe29ebe873f6bf0ebc3b6f10592d5a76eed2c849354f54f865a4dcc4c6c1a4b497b61b72fe20ff4ae43c47e3dd56f753992c2e9edace372b188f82d8ee4f5e7d2ba5f0078c6eb54b87d33529049305df14b8c1603a838ef5ba9d094b92c7975286674297d65d47ded7fe91e6dab69377a2ea0f67791ec9179047461d883e954c29660aa0924e001debd8be24e8e97de1f37cabfbfb33b8103aa93823fafe15c6fc38d21751f111b995774566bbc67a6f3c0fea7f0ae69d0b55e45d4f6b0d9aaa9827889ef1dfd7fe09b5e1cf8669240975ad338661916e871b7fde3ebec2baaff008413c35b367f65c39f5c9cfe79ab1e2ad70787f429af15434bc244a7a163d3fc6bc77fe130f107db3ed5fdab71bf39db9f93fef9e98ae993a347dd68f1684330cc6f5633b2f56bf23aff0011fc3348a07bad159c951936ee739ff74fafb1af3620a9208208e083dabdf3c2dae8f106850de32859794954740c3ae3dabccfe23e909a778885cc49b62bc5f308038de0e1bfa1fc6b2c4518f2aa90d8eeca330aded9e1711ab5b7c8b7e02f0be97afd85d4b7f133bc728552ae578c7b5278ebc1706896f15fe9a8e2d41d932962db49e8dcf6edf956d7c28ff9065fff00d761ff00a0d7797b670dfd9cb6b7081e2954ab29ee0d6b4e8c674569a9c38accab61b3097bcdc53dba58f9ba8ad1d77479b42d5e7b09b2761ca37f7d0f43fe7be6a822348ea88a59d885551d493d0579ce2d3b33ebe1563382a917a3d4dff077874f88b5958a40df64846f9d871c765cfbff00435db789bc11a1e9be1dbdbbb6b5659a28f7237984e0d747e11d017c3fa1c50301f6993e79d87763dbe83a51e33ff914752ffae26bd18508c693bad4f8daf9a55af8e8aa726a374bd753c2ed1165bdb78dc655a45561ea09af68ff00857fe1b099fecf19c7f7cff8d78cd87fc842d7febaa7f315f471ff0055f85678484649dd1ddc4188ab4a54fd9c9abdf6f91f36dc284ba9914615646503d81351d4d79ff1fd73ff005d9fff0042350d70bdcfa583bc51ade1ad61b43d76daf33fba0db251ea87afe5d7f0af6cd7748835dd0e7b4603f78998dc7f0b750457cfb5eede08bf3a87846c5d9b2f1a189b9fee9c0fd315dd8495d3833e6b88293a7286261a35a7ea8f0c9a278269219176c91b1561e841c1a6574fe3fb15b2f175d141849c2cc3ea460ff2ae62b8e71e59347d061ab2ad4635175414514549b851451400514514005145140051451400514514005145140053a3ff005a9fef0fe74da747feb53fde1fce85b8a5f0b3db31f31fa9a55eb41fbc7ea69ca6bde3f2c7b8e029c29a29c2810b9a5149d3140a0070a5a6834b400bcd2d345283400b49476a280168a28a00296928a00334507a62928001d69d9a6d2d002e68e29290d003b20d2641a6e39eb4a7ad002d2f5a4a4a00764d25276f7a0d002d21145140051451d2801734d041ce0f4eb5cc5cfc43f0bdb6a02c5b55469bccf2f7246cd107eca6400a839f7ae53c10fe22b5f1e6b1a2df5c47696ec5b5116a4f9eceb2f0364a71c29c678eb401ea790a092401dc9aa57fab5869ba73ea379790c3668326666f971ed8ebf85735e03d4ef359f0f5fe9dab4cd3dfd8dccd6571230e5c73863f507f4ae2ec357b6b3f84b18bab382fe5d2f5536b09b963e544c243b1df1fc2a0d0077761f117c39a8ea705845753c735c1db034f6cf1a487d0330c547a3eada84ff12fc43a64f74ef656f6d04904271842d9c915e7fe2bbfba697469ef7c536bab5c41a84331b5d3add4436e99c1766193df0338aeeb4d8d93e306bd2046f2e5d36dd83e383d7bd006e78b7519b49f07eafa85abecb8b7b57789f19dac0706b99d013c73a9f86ec3538fc4560d25d402530dd69f9c139e372906b4fe26398fe1c6b580496836803dc8159ba1f80a31a058187c41e20b42f6c85920be21412a09001071d68026d0fc7b25cf8775ebcd56d238af7427912ea381f29215071b49f5c62bacd22fceaba3d9ea06ddedfed50acc227392a18640c8ebc579df8cbc3963e1cf00a787748122b6afa8430bcb236e92466604b31efc2d2f883451e0ebcd06e343d4752fb75d5f476af1cd72d224f1e3e6dca78e00e31d2803d3cd19ae46fbc7127f6edde95a268579abcb6440ba92175448c9fe1dcdd4fb56a787fc4d65e22b69de149ade7b57f2ae6dae57649037a30febd28036b1476aa167ad69da85f5dd959dd24d7166c16e15327613db3d3357e80168a4a5a00293b52d1db8a004a2929c2803c168a28af04fd5496dae24b4ba86e223892270ebf50735ef1e1ff12d86bf6492412aacd8fde42c7e643f4ee3debc0aa41e75b4aa47991483041e54e3b56f46b3a5e87979965b0c6a577692d8f72d53c13a16ad234b2da08e66eb2427613f95729a8fc29c296d3b5039ec93ae47e62b95b1f1bf8834fc04d41e541fc3300f9fc4f35e87e0df1bbf886e1ecaeed962b944de1e3276b0efc1e41aea8ca85676b6a78752866797c39e33bc57cff067946a9a4dee8d786d6fa03148391dc30f507b8aab144f34a9146bba4760aa3d49e057b1fc4ab186e3c2b2dd3a8f36d9d591bbf2c148fd7f4ae33e1be8dfda3af9bc91730d98ddcf773d3f2e4d73ce85aaa82ea7af86cd7da60a5889ab38e9f33d4741d323d0f42b6b318fdd265dbd5ba93f9d78d6b1e229aebc5efac42c7f753030ff00b8a703f3e4fe35ee5796c979672dac859525428c54e0e08c706b94ff008567e1ef4b8ffbfc6bb2b539c928c3a1f3996e368529cea622edcbf5dce8e192db5bd195f01edeea2e47a823a57826b1a6c9a3eaf73612f585c807d57a83f88c57be691a5dbe8da7a58da9730a676876dc464e719ae0be2968b94b7d6225e57f73311e87ee9fcf8fc454e269b953e67ba37c97171a38a74d3f765b7e8729e05ff91cb4ff00f79bff004135edf796915fd8cd69382629a331be0e0e08c1af10f037fc8e5a77fbedff00a09af63f104d25bf873519a1764952da46565382a429c115384fe1b2f881378b825d97e660ff00c2b6f0effcf29bfeff001a0fc37f0e804f952ffdfe35e5dff0946bdff417bcff00bf868ff849f5effa0c5e7fdfd359fb7a3fca762cb331ff009fdf8b29ea5025b6a979044311c53ba2e4e780c40aab4e9247964692462cee4b3313c927924d36b8deaf43e929a718a52dc2bb8f87de15fed4bc1aa5dc7fe89037eed4f491c7f41fceb898943cd1a1e8ceaa71e84e2be8db1b5b7b0b286dad91638a350aaa3b0ae9c2d25395df43c4cf71b2c3d254e1bcbaf918fe2ef1247e1cd20ba60dd4bf2c087d7d4fb0af34f0668b6de29d62f575369a4223129657da4b16e4935eaba9f86f48d62e45c5fdaacd22aed0598f03d0734ed2fc3ba4e8d33cda7da242eebb58a93c8aec9d294e69bd91f3f86c752c3e1650a69aa92ea79cf8e3c1fa6787b4886e6c84de63ceb19df21618c13d3f01591e008d64f19d886e803b0fa85af65d5349b1d62d960bf816689583856ec7919fd4d79eea96ba7f863c7fa2b594096f038224c1e3938cd63568a8cd4d6c77e0b32956c34f0f3bb9b4f5f91dcf899cc7e18d4997a8b67ffd04d7cf83a0afa3b53b4fed0d26ead738f3a164cfd462be759a192de7920950a491b15653d411daa71ab54cdb86a4b96a47ae8755f0e1ca78c6103a345229fa707fa57a778d115fc1faa06ed0330fa8e6bcfbe17e9d24faf4d7db4f956f115dd8e0b3638fc87eb5db7c41bd5b4f085da9237cf88947ae4f3fa66ae86941b7e673666d4f348461bab7e6787f7a28a2bce3ec4ef7e1545bb5bbd948fbb0003f16ae87e2a4a53c3b6f1838df72b9fa006b0be14b81aa6a09dcc487f5ad9f8aca4e8966dd85c01f9835e843fdd99f2389d7398dfbafc8f25a28aed3c19e08935b74bebf564d3c1caaf4337ff63efdeb8a10737647d362b154f0d4dd4a8f423f05783a6d72e52f6e90a69f1b679ff96a4761edea6bd4f5dd6ad7c3fa549753b0f946238fbbb76029bab6afa778634912cdb638d06c8a24182c7b2a8af13d7f5fbcf10ea06e6e9b0a388e207e58c7a0f7f535dd29470f1e55bb3e5e952ad9bd7f6b534a6bfaff00872df86246bff1c594f7041796e4cac7fdae4ff3af6cd559a3d22ed97a885c8ffbe4d781687782c35db1bb63848a75663ed9e7f4afa0e68d6e6cde3272b2215cfb114611de0c38821c95e9be96fc99f36024a827a91935d1f815da3f1969e57bb329fa6d358b7f652e9da84f673a1492172a41fd0fe55d4fc36d3a4bbf13add04261b54259bb6e23007d7ad71d28bf689799f438eab0fa9ce77d1a3d4fc46aafe1ad495ba1b693affba6b8bf84aabf65d4dff88ba03f91aea3c6b7c961e12bf7240678fca51ea5b8fea6b89f8537cb0ea37d62c70d322baffc0720ff003aef9c97b78a3e530b4e6f2dacd6d75f81abf15dd86956283ee99ce7f05af28af68f88fa5cba87865a4850bc96ce25c019257a1fd39af17ed9cd72e2d3f687bdc3f38bc272add367aafc28763a5dfa1fbab38c7e2b517c5a4536da63ff00107703e840ff000ad7f86fa64b61e1a134c851ee9cca01ebb7a0ae6be2b5f2cba8d8d8a9c9851a46ff0081600fe5fad6f3f770d6679541fb5ce5ca1b5dfe5634fe13ff00c836ff00febb0ffd06ba7d435f4d37c4561a7cfb562bc560ae7f85c1e07e3d3eb8ae5fe13ffc83b50ffaec3ff41aa5f15c95bcd318120857208edc8aa8cdc2829233ad878e23349d2975ff00237fe20f873fb5f48fb65ba66eed416000e5d3baff00515cb7c36f0efdb6fceaf709982dce21047de7f5fc3f99f6aed7c15e215f10688be73037707eee71ea7b37e3fe35a775358f86f459a708b0db40a5f6a0c64939c0f724feb55ece1392abd0c16331187a32c0db5bdbfaf5296ade205b4f10e99a3c0c0cd70fba5ff650038fc491f9034ff188cf84752ffae26bcb7c3ba8cfaafc42b4beb83992698923d060e00f6038af53f1873e12d4bfeb81a2153da424c788c1ac26228c3ae8dfadcf0ab1ff009085b7fd754fe62be8f3feabf0af9c2cbfe3fadbfebaaff315f47ffcb2fc2b2c16d23bb897e2a7f3fd0f9c2f7fe3fee7febb3ffe846a0a9ef88fed0bae47fae7ff00d08d4191ea3f3ae07b9f554dfb882bd6fe154a5b41ba889fb97048fc547f8579257abfc2852348be7ec6703ff1d15d184fe21e467e93c1bf54647c56876ead6137f7a1653f81af3faf45f8b0e0dee9c9dc239fd4579d54e27f8acdf266fea50bff005a851451581e9851451400514514005145140051451400514514005145140053a3ff005a9fef0fe74da747feb53fde1fce85b8a5f0b3db4fde3f534e14d3f78fd4d28af78fcb1ee3c53bb53452f5a043a969a0d3a800340a4e697bd002d2d277a33400669734d19cfb7634ea000518f7a28a005cd2514668016909da2909a693ea0d003c36451480528a0039a3bd1c9a3bd001477a2909a0075149475a0028a0d14000feb4668a31c500799dc78bbc5dff00094eb674fb1b6beb0d227104ba7a0c4cc8467cc56ee7dab6e5f11daf8cfc15ac268172cba8fd924436eff24d0c9823691d473c66b9cbdb1d49fe2f6ada5e9ba9ff0066c7aad8c5733dc226e9709c111e7804e7ad6d5c7c2fd32136b75a1de5d697aa5bb6e37c8e6479b272de603f7b3fe78a0083c35e2cf08d9780accbcf6568b690812d9ca57cc599472361e4b1619ce3bd2369de23f10ae83e2db28ed34dd6638e4492dee776c681c9da1bbe470d8f535d6ffc239a335eadfcba5d9497e304dc9817796f5e9d6b528038fb8f01adcea736a51eb17fa7cb788bfda10d83858ee180c1233cae7db9ad9d37c31a369563736569a7c2b6b72dbe68986f5738039073e95af585e2df1558f83f437d4ef95e41b82451478dd239ec33d3d49a00d1b0d234ed2a168ac2c2dad63639658620a1beb81cd5ccd78b7fc3425b7fd0b737fe060ffe228ff8684b6ebff08dcd9ffafc1ffc45007b4919041191ef474000af16ff008684b6c7fc8b737fe060ff00e22947ed096c48cf8726033ce2ec7ff11401eb77fa458ea573633ddc3e64965379f01c91b5f18cfbd52d47c3cba9789f49d5e69ff77a6ac863b7dbc191b80d9f61563c3faed8f89345b7d574f72d04c3a370c8470548f506b4b3c50079d68d7ade04d4b5bb4d5f4ed41edef2f5ef2defad6d9a7128603e56dbc823a73598f7325b695e30f176b1a6cb0c3abaa5ada584d9479540daa580e41271efc1af58dc474247d2b13c4de1c8bc4f6104125ccb6d35b5c2dcc13c7825245e8483c30f63401c478723b7f8616105b5f5ededf5f6a71acbfd956d007712ff00130c738c6073e95dc685e2ad375f7960b733417900066b4ba88c52c63b12a7a8f715cb5f5d41e18f89b26b5aeee5b2bcb08ededf502a4a4322fdf56c7ddddd69906ab6de2df8a5a6dee827cdb4d2ada55bdbf41f24bbc7cb103fc58233f8fb5007a3d1da8a31400b47d292979c500079a33494b401e0b451457827eaa5bd321b7b8d52d62bb9961b7690091dba05cf35ee977a1e8badd9c6b3dac13c4140475ea07b30af00ab963ab6a3a69cd95ecf07b239c7e5d2ba28568d34d495ee7939965d571528ce9cf95a3d4e4f85ba23bee49eed07f744808fe55bba1785b4bf0e2bb59c6de6b8c34b236588f4f615e529f103c4a8bb45fa9f768549aa37fe2ad735242973a8cc50f5443b01fcab7588a31d631d4f32595663557255abeefab3aff88fe28b7ba8468d6520930e1a7753c0c745fcf9fc2baef0568e345f0dc11b8db3ca3cd973d771edf80c0af0c4768e457538653907deb6bfe131f10e31fdab3fe959c312b9dce48e9c464f37868e1e84b44eeefd59d078dfc5da82f88e5b5d3af65861b70236f2ce373753f95737ff00095ebdff00416baffbeab26491e591a4918b3b92ccc7a927a9a6d633ad3949bb9e9d0cbe852a51838a765d8ea741f19eab6baddac97ba84d35aef0b2a3b71b4f19fc3afe15ec3aa5943abe9371672e0c73c6573e9e86be75ad84f15ebd1c6b1a6ab721140006e1d2b5a389e54d4f53cecc32775aa46a61ed168bfe12b692cbc7b696b38db2c333a37d429af6abab786f6ce5b59c6e8a5428e338c82306be793aa5fb6a1f6f3772fdb3af9d9f9ba63f971573fe129d7ffe83179ff7dfff005a9d1c4429a6ac4e6394d7c5d48d45249a497ccf55ff008577e1aff9f46ffbfadfe34bff000af3c35ff3e67fefeb7f8d794ffc253aff00fd062f3fefe527fc253aff00fd062f3fefe55fd628ff002987f65663ff003fbf166f7c41f0fe9ba0cb60ba7c3e5895642ff316ce36e3afd4d71756ef754bfd48a1bebc9ae0c79dbe63676e7ae3f2aa95c9524a526e2ac8f77074aa52a2a1565792ea28241041c11c835a3ff090eb3ff415bcff00bfcdfe359b454a935b3379d284fe3499a5ff00090eb3ff00415bcffbfcd5dd7c33d4efafb51be5bbbc9e755890a89642d8e4fad799d58b4bfbcb0666b4b99606718631b6335ad3ace324db38b1997d3ad4654e0926fad8f5cf8957b7365e1e824b5b89607372aa5a272a48dadc6457915cdedd5e48b25cdccd33a8c2b48e588fa13525d6aba85f4623bbbd9e740770591f233ebfad54a2b56f692ba232dcbd612972cecdf73d9bc15e318358b38eceee554d42350a431c79a07f10fea2b5753f09687ac5d7da6eecd1a63d5d58a96fae3ad78282548652411c820e08ad7b7f15ebd6d1848b55b8d8060066dd8fceb7862938f2d4573cdc464552355d4c2cf96ffd743dc20834dd034e290ac36b6b1824f3803dc9af21f1bf8a478875048ed89fb0db9223cf1bd8f56ff0ff00ebd60df6ada86a647db6f679f1d03bf03f0e954ea2b6279d72c5591d39764eb0f53db559734828a28ae53dc3b1f869762dfc55e51e93c2cbf88e6bb9f891666ebc23348064c12249fae3f91af21d2afdb4cd56d6f93ac12073ee3b8fcb35efd3c56face8cf1e43417509191e8c3ad7a1867cf49c0f92ce62f0f8da789e9a7e1ff00f12f0769d6daaf8a2d2d2ed37c0db99973f7b03201f6af788d5228d5102aaa8c00060015f3a4a977a46a52c41de1b981da32c87041e9c1a97fb7356ff00a095dffdfd35951aea9269ad4efccb2ba98f9c6a427eed8f74d4bc3da4eaf3acd7f6a93ba8daa598f03d866a9ffc213e1bff00a0643f99ff001af17fedbd57fe82577ff7f4d27f6d6a9ff411baff00bfa6ade2a9bd5c4e486478b82e58d6b2f99b5e3ed32cf4af10a5bd940b0c46056dab9e4e4d763e04f19c173671697a8cc23ba886d89dce048bd867d45795cf733dd49e65c4d24af8c6e76c9c5455846bb84dca2b43d5ab962af858d1aaeed753e81d53c37a36b522cb7f651cb228c07c9538fa8a9edad74cd02c0a4090dadb27cc7b0fa93dff001af09b6f10eb369188edf54ba441d1449903f3a82f354bfd471f6dbd9ee31da47c8fcaba3eb70dd4753c8590621da13abee2f5fc8e93c75e2b5d7eed2d6d09fb0c0721bfe7a37afd3d2b9bd33509f4ad460beb66c4b0b647a11dc1f622aa515c72a9294b99ee7d151c252a347d8457bbf99efba078974ff10d98782455971fbc818fcca7e9dfeb47fc225e1f379f6afeccb7f3739cede33f4e9fa57824723c52078dd91c74652411f88ad1ff00848f5bf2fcbfed6bcd98fbbe69aeb58b4d7be8f02a64152336f0f52c99ed5af78974ef0f59979e4532e3f77029f998fd3b7d6bc3753d427d57529efae5b32ccdb8fa01d80f6038aad248f2b9791d9dcf5662493f89a6d615abba9e87a996e570c126ef793ea7a9fc282069da867fe7b2ff00e8354be2c7375a691fdd7fe95e7f0dddcdb8220b8962079211cae7f2a49ae67b820cf3c92e3a6f72d8fce9bae9d2f676338e59258e78be6d3b7cac69f86b5f97c3baba5e2297888db2c60fdf5ff1ad5f17f8d5bc4b0c16f04125bdba1dceaec0976edd3b0ae4a8acd55928f25f43ba782a13aeabb8fbc8ddf061c78bf4dffae9fd0d7aff008b486f09ea201ff960d5e0a8ef1b87466561d194e08a95af6ee452af753b29ea1a5620feb5a52afc9071b6e70e3b2b789c442b295b96df8312cffe3f6dff00eba2ff00315f47ab2941c8e95f350e3a75a9bed775ff003f571ff7f9bfc68a15fd95f4bdc333cade35c5a95ade47bdb786f4277666d36d0b31c92631c9a4ff00846741ff00a0659ffdfa15e0bf6bbaff009fa9ff00efeb7f8d1f6bb9ff009f99ff00efeb7f8d6df5b8ff0029e7ff0060d7ff009fdf9ff99dafc4ad3acb4fbab05b2b68a05657dc2350b9e47a575df0daccdb784a3948c1b891e4fc33b7ff0065af1fb78ae752bc82d55e492595c220762d824fbd7d036f0dbe8da34716e0905b4206e3e8a3ad561fdfa8ea5ac8cb374f0f85a78472e695ff00afccf29f89d7627f142420ff00a8800fc58e6b8babbabea0daaeaf757cd9fdf48587b2f6fd3154ab8aacb9a6d9f4781a3ec70f0a6fa20a28a2a0ea0a28a2800a28a2800a28a2800a28a2800a28a2800a28a2800a747feb53fde1fce9b4e8ff00d6a7fbc3f9d0b714be167b711f3b7d4d28fd686fbedf534015ef1f963dc703c519e692945021734b8e69052f3400b9c75a5a4ed4bd28017345341a5cf1400b4668a0f1400b9a2928cd002d1494668014f4a69a5a28017f1a281499a005ed452034beb4009de8a5a2800a32692826801738a29074a280168a43f5a39a00cc9340b297c490ebceaff6d86036e84361429393c7735cf7c4df17dd783bc3097762b11bb9e710c664190bc124e3bf02ba5d635cd37c3fa73dfea97496d6e9fc4dd49f400724fb57ce9f13fe225bf8d9acedec6d6686d6d19db74a466427001c0e9800fe7400c6f8cfe346e97f02fd2dd6983e31f8d848ac7544201ced30260fb74ac0d1bc61aae85666d6cbec8232c5cf9b6b1c8727dd81350ebbe25d43c46d035f8b7dd00210c302c7c1f5da066803eaff000c6b3ff090785f4ed548556b9803b05e81ba11f9835f3d7c5af167fc24fe2bfb1da3b3d8d8130c40747933f330fa9e07b0aa1a27c4ed7b40f0c3e8567e47d9c870b2b2932461faed39fae3eb5c6ee6ddbb273d73401ef7a07c13d09f43b47d62e2e0ea0e81e6114e15549e76f4edd3eb5a63e07f844f496fbff0207f857ceff6dba1d2e26ffbf87fc6946a1783a5d4ff00f7f1bfc6803e891f033c247a3ea07e938ffe26b13c5df04f4eb3f0ddd5de802f24be807982391f70751f780e3ae39fc2bc4c6a77e3a5e5c0ff00b6adfe34e1ab6a40717f75ff007f9bfc6803d17e0cf8cbfb135e3a25ecbb6c6fd808f7748e6e83e99e9f5c57d1bdf35f11abbac81d5886072181e73eb5e996ff001cfc510db451341612b2205323c6db9b03193cf5a00fa3f1c515f3a7fc2f8f13ff00cfa69bff007e9bff008aa747f1e7c48ae0c963a6baf75d8e33f935007d0d2451cc8639516446eaacb907f034905bc16b188e0863863ea16340a3f215e63e18f8dda36ad711daeaf6e74c99f81296dd113ee7aafe3f9d7a9232ba2ba3064600a907208a005a2968a0028ed451400d073d88a75149401e0d451457827eaa145145001451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450015d7e85f106ff44d2d2c05b45711c64ec67720a8f4e95c8515509ca0ef166188c352c44792ac6e8d4d7f58feddd4dafdad52de47501c2364311dfeb8c0fc2b2e8a2936e4eecd29d38d3828436414514522c28a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a0028a28a00d0d1b569744d452fa08629254042f9a090a4f7e31ce3f9d6ceb1e3dd5f59d3a4b199608a29301cc4a4123d39278ae5a8ab8d49463ca9e87354c1d0a951559c6f2414514541d21451450014514500145145001451450014514500145145001451450014e8ffd6a7fbc3f9d369d1ffad4ff00787f3a16e297c2cf6e6fbedf5346683f79bea69066bde3f2c7b8f14b4838a5a0428a514da5a0070a5c0a6d2e68014d1fce928a005a5a4ed40a005ed4828a0d0029e948281de8028017b5068145000296928a005a28ed45001498a3bd1de8003eb474a5a4ef40050293d68a005a649224313cb23058d14b3313d0019269d9e6b9bf88533c1f0f75d742437d91d723b678a00f9ebc63e24d4be2178b963b647921f33c9b1b64f4cf5fa9ea4ff857a9f867e0ef87348b747f104d15f5fb005a27982471fb01904fd4fe55c3fc10b14b8f195c5db81bad2d1de3f66240cfe59fcebcfb55bcb9bcd5aea7b89e49657958b3bb124f3401f538f873e0ec0c787ec88f5da7fc69dff0ae7c1dff0042f597fdf27fc6b23e0edddc5dfc3cb56b899e5649a4452e724282302bbdfc680398ff008573e0effa176cbfef83fe347fc2b9f077fd0bd65ff7c1ff001ae9e9b2cb1c10bcb2bac71a02ccee701477249e9401ccff00c2b9f077fd0bd65ff7c9ff001a5ff8573e0e3ff32f597fdf07fc6b92f127c70d1b4d91a0d1eddf529949065276443e87ab7e95c4cff1dfc4d23e61b4d3e25f4f28b7ea4d007b1ffc2b9f077fd0bd65ff007c9ff1a3fe15cf83bfe85eb2ff00be0ff8d793e9ff001f3588a451a8695693c7fc4622636fea2bd4bc27f11740f17110d9ce60bdc64dacff002bff00c07b37e1f95004dff0ae7c1dff0042f597fdf27fc68ff8573e0eff00a17acbfef93fe35d451401cb7fc2b9f077fd0bd65ff7c9ff001a6cbf0d3c1d2c651bc3d6a01ee8194fe60d607c55f889378460834ed2f67f695d21732373e4a6719c7a939c7d335e20758f185e46fab0bcd624890e5ee55a428a7dd8702803b7f88bf089741b29759d05e596ca3e66b67f99a25fef03dd477cf23deb57e08f8da79656f0b5fcbbd4217b2663ca81c94fa6391f4352fc30f89375afdd7fc233e217170f3c6cb05c37de7e0e51fd78ce0d79c785a33a5fc55d3a0898fee35411023b80fb7f95007d5f9c7d2973451d680168a292801714b8a4a0f5a00f05a28a2bc13f550e82bb3b7f867ac5cdbc73a5d590591430cb374233fddae2dbee9fa57b2f896feeb4ef00c171673bc130484074c640207ad74508424a4e5d0f2334c4d7a52a70a0ece4ec7267e16eb607173627fe04dffc4d73facf86356d070d7b6c4444e04a877293f5edf8d48be31f112b02357b838f5da7fa57a3f853586f18f87af2d754891e48ff0077230180e08c838ec6ae30a357dd8e8ce7ad88c7e092ab59a947adb73cb743d1e6d7b544b082448e4752433e71c0f6aeb3fe1556a9ff003ff6bf937f8551f00c5e478ee3849ff57e6a7e408ad3f885adea961e2610d9df4f045f6746d91b6064b373fa0a54e14d53e69a1e2b138a963150a124938df5445ff0aaf53ff9ff00b5fc9bfc2b1b51f075de9daed9694f730bcb77f75c0385e71cd52ff849f5dffa0addff00df75565d5f519eee2ba96f267b88bfd5c8cd92bf4a894a8db4474d1a398297ef2a26add8ebff00e155ea9c7fa7dafe4dfe14bff0aab54ef7f6bf937f85731ff0946bb83ff136baff00beebd47c7f7f7761e17867b5b892194ca80ba1c1c106b68468ca2da5b1e7622ae6542ac29caa2f7df638cd47e1c5fe9da74f7925edbb24285caa86c9c7e1543c3be0bbcf1258c9756d730c4a9218cac80e7a03dbeb59b3788b58b885a19b52b978dc61959f823d2bd1fe169c786ef71dae5bff00405a9a71a552764b437c5d6c6e130ae739a72bad97430bfe155ea7ff003ff6bf937f8550d43e1c6bb650b4b1086ed5792b0b1ddf91eb5973789f5d13c806ad7580c7f8fdeba2f06f8cf556d76dac6fae5aeadee1b67ef00dca71c107eb497b093e5b3439ff0069d183aae71925adac708cac8c558156070411c8352dada5c5f5ca5bdac2f34cff00751064d75ff1334f8acfc431dcc4a17ed516f7007560704fe231f95757e1eb0b2f06f84db55bc41f6978c492b63e6e7a20fd3f1a98e1ef3716f446d573551c2c2ac23794f65e673165f0bb559e30f75736f6c48fb832e47d71c7eb497df0bf568232f6b7105ce3f839463f4cf1fad64eade36d6f55b866176f6d0e7e58613b401ee7a934ed1bc6fad69570acd74f75067e68666ce47b1ea0d55f0f7b5be667c99af2fb4e68dfb5bf0302e6da7b3b87b7b989e2990e191c608ad0f0f68927883555b08e65858a33ee6191c57a578a74cb3f167855359b2506e238bcd8d80f9980ea87f5fc6b8ef86dff00237c7ff5c1ff00a5274546a28bd532e3994ab60ea548ab4e37baecca1e25f0a5e786a487cf759a1947cb2a02067d0d6057d01a9c3a778822bdd16760644552cbfc499e55857876b1a4dce8ba9cd6374b878cf0c3a3af661ec68c451e4778ec2ca7327898fb3abf1afc57736f42f04cfae68afa925e244aa586c2849f96b95af5df87dff2234ffefcb5e4553560a308b5d4db0189a956bd684de9176415ada1787351f10dc3476518d89f7e573844fafbfb0ac9af69f87f1c69e0881adc2f9ac642c7d5f711cfe42961e9aa92b31e6b8d9e12873c376ec73a9f09a529f3eb08afe820c8fe758bacfc3dd5f4981ee10c777020cb347c301ea41fe99acdd4755f11daea2e2fef6f61ba07905ca8cfb0e847d2a79bc6dad5ce8d3e9973389a398053230c381dc6475cf4ad24e8eaacd1cd4a1992719aa91927bfa147c3da336bfac45a7acc212eacdbcaeec607a5767ff0a9a51d7574ff00bf1ffd7ac2f875ff0023a5affd7393f95697c47d42f6dbc4cb1c1777112790a76c72b28ce4f6068a71a6a973c95f5162eb62a58d587a33e55cb7dae4b71f0a6f12326df528646ec1e32a3f304d717aa6937ba35e1b5be84c520191dc30f507b8ab365e28d6b4e9d668750b86da7252472eac3d0835e85e3f8e2d4fc196da9940b2a14914f701ba8fd7f4a3929d48b70566816231784af0a788929467a5f6394f0c781dfc49a6bde2df2c016531ed31eee801cf5f7adaff00854f27fd0613fefc7ff655abf0cce3c2774475170fff00a0ad79949abea5e637fc4c6f3a9ff96edfe354d528422e51bdcca1531d89c455852a9caa2fb23a7d47e196ad690b4b693c376146760cab1fa03c7eb5c5ba3c723472294752559586083e86bb5f03f8a7535d7edac2e6ea4b8b6b8250ac8771538e083d699f132ca2b6f12a4f100bf69883b01dd81c67f2c7e551384250e781d385c4e269e27eab8969dd5d3443a5f81ffb4bc2cdadff006818f6a48de4f939fbb9ef9ef8ae62cadbed97d6f6dbf679d22a6ec671938cd7abf85ffe496cbff5c6e3f9b5797e8bff0021cb0ffaf84fe628a94e2942dd4583c5d6a92c4293f85bb796e74fe21f87773a2e96d7d05d9bc48f991445b4aafa8e4e6b8aafa26ef51b4b7bab5b1b9601af372c61870c40048fc8d79078dfc2cda06a5e75ba1fb05c12633fdc3dd7fc3dbe95788a0a3ef43639f28cd6759fb2c43d5ecfb95bc29e18ff00849ee6ea1fb5fd9bc8457cf97bf39247a8f4a4b6f0c8b8f18b681f6bdbb5dd7cff002ffbaa4f4cff005ae8be147fc84f53ff00ae31ff00e84d5ccf8aa4921f186a4f148f1b898e1918823f1151cb154a336ba9d2abd79e36ad08cac9474f27a1d7ff00c2a51ff41bff00c96ffeca8ff85498ebadff00e4b7ff00655c3586a37c752b406f6e8833c60833bf3f30f7af48f8a371341a4589866922266c131b95cfca7d2b58fb1941cb976386bbcc2957a745d6f8bc91cfebbf0e868ba35cea1fdabe7792bbbcbf236eee7d77570b53c97b772a1492eee1d0f55695883f81350572d4945bf7558f77094abd38355e7ccfd2c15d2784bc272789a69cb4cd05bc206640b9cb1e807e1cfe55cf4513cf3245129792460aaa3b93d057aa6ab2a781fc0d1d840c3edd700aee1d4b1fbcdf87f855d1827794b64736658aa94d468d1f8e4f4f2eecf34d56dadacf53b8b6b49ccf0c4fb04a401b88ea7e99cd6d7847c2b1f899ae849786dfc9db8c206ce73ef58dfd91a8fd87eddf629becbb7779db7e5c7ae6ab4734b0e7ca9648f3d76395cfe5509a52bc968744e33a9479294fde5a5f7d7a9e963e145b9381ac39ff00b643fc683f0a2d81e75771ff006c87f8d607c3cb99e4f185bac93caea637e19c91d3dcd4df126e278fc57b5269517ece9c2b903ab7a5757eebd9f3f29e1bfafac5ac37b6e97bd914fc5de128bc3315abc778d7066660415031803d0d72b4f92696500492c8f8e9b989c7e74cae39b8b778ab1f4186a7529d351ab2e67dcd3d1341bed7ef7ecd6483e519791b8541effe15ddc3f0a21118fb46acfe611d123000fccd5bf855e4ff0062de6cc79de7fcfebf7462b8df1647afd9eb9752df4b7610c8c63955d847b73c608e071daba9538429a9b57b9e254c5627118b961e9d45051fbd9afaa7c2ebeb689a5d3ef23bac0cec75d8df81ce3f9571da5588d4359b5b1918a09a611b32f24738abf6be2ed6ed6ce6b417d2490ca853129dc541ee0f5cd41e17ff0091a74aff00af94fe7594bd9ca4b951dd4d632951a8ebc93b2d1a3be3f0af4f5c6ed52719f555a63fc2bb175221d5e40fdb281bf4e2abfc55774b8d302bb0f91fa1c7a579ec577730b878ae26471d0ac8411fad6b5254a12e5e5383074b1d89a0ab2af6bf4b2367c47e11d43c38c1e7db2db39c2cc9d33e847635b1e16f0459ebfa3adecf7f240e6465d8a06383ef5d4da5cc9e22f865349a81df2f92e19c8ea57a37d7815e40b238518761c67009a99c614e4a56ba66f87ad89c5529d273e59c1d9b5d4ee7c53e03b5d034393508af659595d142b0183b980edf5ae16bd7bc6dcfc398c9ff00a61ffa12d70be05d363d4fc576c92aee8e1066607a1db8c7ea47e5456a4bda28c7a865d8d9fd4e75ab3bf2b7f81aba2fc36bbbdb55bad4ae45946c3708f6e5f1efd85693fc32d3ee236161ad16957b30561fa1aadf13f5a9db518f488a4658238c3c8aa71bd8f407d80fe75c2d8dedc69b791dd5a48629a3390578cfb1f51ed4e4e9425c9cb7228431f89a5f58f6bcb7d52b6859d6744bdd06f8da5ec615b19475e55c7a8355ac2c6e752bd8aced22324d21c2a8fe67d057aaf8ce1875ef01c5aaa20f32344b843dc038dc3f23fa0acef857a727957ba93a02f91121f4039349e1d7b5515b32a19b4bea52ad25efc5dbe6320f86963696ab2eb1abf94c7a88c85507d32dd69977f0cedee2d1a7d1b54131032164c10dff00021d3f2ae43c4babcdad6b973712b968d5d92253d1541c71573c13abcda57892d951c882e1c452a67839e871ea0d352a4e5c9cba77265431f1a3edfdafbd6bdada7a183736d35a5cc96f711b47346c55d1ba835157a07c52d3638350b3d4100067528f81d4ae083f91af3fac2ac3924e27ab82c4fd66846af70a747feb53fde1fce9b4e8ff00d6a7fbc3f9d66b73a65f0b3db8fde6fa9a050df78e3d4d15ef1f963dc752d20a5a0414b45250028a5a4a28017bd2f3482973400734b49f8d193400b45277a5a002969283400b4734828e6801693f1e68cfad140051d68cd02800ce0f4fc68cf34668a00297349450019a43ed41f4a2800c77ae5fe247fc93ad77febd8ff315d4572df11ffe49d6bbff005ec7f98a00f26f811ff230eadff5e7ff00b357965eff00c7f5c7fd746fe75ea7f023fe461d5bfebcff00f66af2cbdff8feb8ff00ae8dfce803e92f829ff24e6dff00ebe65fe62bd12bcefe0aff00c93a83febe25fe62bd12801aeca8a5d982aa82493d857cd7f12be21dd78b3537d2f4d7917498df6a2275b86e9b8fa8cf415eabf18b5e6d17c0f2c10c8527d42416e0a9e76f56fd38fc6bcffe08f84e2d4b559fc41771abc364425bab0c832919ddf80fd4fb5005df067c113710477de2792488380cb6511c301fedb76fa0e7debd262f06781f4585627d23498f8e0dd2ab31fc5f26b0be2afc4293c27691e9da6328d56e5776f233e427f7b1ea7b7d09af13d37c31e2cf1bcb25f5b5a5d5f658efb995b827d3731e7f0a00f7ad4be17f82bc4103496f630dbb6389ac1f6e3fe023e5fd2bc53c69f0fb58f01de25dc72b4d625ff71791654a3760d8fbadfcea82bf8b3e1d6b1196173a6dc7de08dca4a3e9d1857d07e1ad6f4df895e0993ed56eb8954c17901fe17c751fcc1a00c8f855f111bc5566da5ea6e3fb5ad9776fc63cf41c6eff007877fcebd24835f258fb6fc3df88980e565d3aeb048ff9691e7f9329fd6beb186649e08e68ce639143a9f504647e9401f35fc6db3b9b7f8832dc4c0f93716f1342c7a602ed23f306bd2fc31f117c1f6bf0feda39af6080db5b08a5b265f9d982e080bfc593dfdeba7f19f82b4df1ae98b6d79ba29e2c982e107cd193fcc1ee2bc824f809e205b9d91ea560d067fd6166538ff771401c9f80e09751f897a4fd850c63eda260a3f86304b1ff00c778a934cff92c30ff00d86cff00e8d35eede02f86fa7f8251ae0cbf6bd4a55daf70570157fbaa3b0f7ea6bc274bff0092c10ffd868ffe8d3401f5652d19eb4500140e7ad19a334001a3268a2803c1a8a28af04fd5446fba7e95ed7ad69175adf81adececc2999a38880c703802bc51bee9fa57b46bba9dde91e0382eeca5f2e658e101b00f503d6baf0d6e595f63c0ceb9fdad0f67f15f4fc0e217e1a78859802b6ca0f732f4fd2bb5d36c2d3e1ff00862e26bab8592773b9c8e37b630154579fb78fbc48c31fda247b88d7fc2b12fb52bdd4e6f36faea59dc742ed9c7d0741f852556953d60b52aa60b1d8ab431334a1d52ea747f0fe4697c7104adf79c4ac7ea4135df788eebc1f0ea6135c8e06bcf2c1cbc0ce76e4e3900f7cd79f7c3bff0091ced3fdc7ff00d04d6ef8ff00c3babea9e235b8b1b09278bece8bb948c6416e393ee2b4a526a8b695f53931d4a9cf318c273e55cbbdeddcbbfda1f0dbfe785b7fe023ff00f135e79aec96326b774fa6055b22c3ca0aa546303b1f7cd5dff842fc47ff004099ff0035ff001aa1a968da8e8e621a85a3db9973b3710776319e87dc563565392d636f91e96068e1e8d4bd3ace4df46d3281fba7e95ebff127fe45083febb47fc8d78fb7dd3f435ec1f127fe44f87febb47fc8d550fe1ccc334ff7bc3fabfd0f20af5af858377876f07adcb7fe80b5e4b5eb5f0b0e3c3b7a7d2e5bff00405a584fe2159fff00ba7cd1cdc9f0cf5e799d835a60b123f787d7e95bde16f87f2e8da947a9ea973096832c91c79c038ea49c74ae3e7f1bf891679146ab20018803627aff00bb5dce8b7c9e3bf085c69d79315bd41b6461c127f85b03b1ee3eb5ad2545cbdd5a9c38d79853a2bdac9723d1d96c99c678db5c835af13abdbb87b5b7db1abf66e72c47b76fc2bb3f88e19fc1d0b42098c4b196c7f7707ffad5e557d653e9f7b359dd26c9a262acbfe7b57a8f8435bb2f12f87ce85a915370b1f96558ff00ac41d08f71fd2a694f9dca32dd9ae3a82c3d3a15a96b187e5dcf26a2bb2d5fe1c6b16570df6141796e4fca4300e07b834ba3fc38d5af2e14ea0a2ced81f989605c8f40074fa9ac3d854bdac7abfda984f67ed39d5bf1fb8ec7e1f868fc0dba6e232d2b2e7fbb93fd735c47c36c7fc25f1607fcb07fe95d578d75eb2d0b421a069a544cf1888aa1ff00551e3073ee471f8e6b95f86dff0023845ff5c24fe95d526954843b1e25084a585c4e21ab29dedf89a1e2fd5ee743f8862fad8fcc912065cf0ebdd4d74dafe9769e39f0d45a8e9e41b9442d093d7dd1bfcf5ae2be24ff00c8df27fd714a8fc11e286d0351f22e18fd82e08120fee3766ff1ff00eb54fb44aa4a12d99a3c1ce584a589a1f1c52f9aec76be00468fc15731ba95759660ca7a83e95e41dcd7d172430476372f022a89559d8af462475af9d3b9a58a8f2c628d322abedaa56a96b5dafd42b7fc37e2dbff000d3b2c0166b690e5e173819f507b1ac0af498be1f69dabf876d27d36f905d08fe7941dc92377c8ea31d2b0a319b7786e8f4b31af868414312af191a76fe3cf0d6b7108354b7f24b7056e230e9ff7d7f538aa5e25f87f612e9b26a5a1928ca9e60895b7248bd7e5f438e9dab9d6f871e235976882065cf0e26e3f957a1da22783bc1022beb8591a08d893d8b124855fcf02bb23cd5135563f33e7ab3a5849c2581a976dfc37b9e73f0ebfe474b5ff00ae727f2aec7c61e07bef106b2b7b6d736f1a08826d9339c83ec2b8ef8723fe2b3b41ff004ca4fe55b5f1075dd534ef11241677f34117901b6a1c0ce4f359d371543de5a5cecc646bcb338aa0ed2e5ebf31d61f0ae6fb42b6a1a845e48396489492c3d327a7eb4ef88daeda7d8e1d0ac5d5fcb6065d8721028e17ebfe15c55c788b59ba4d936a774ca7a8f308fe58accace55a0a2e34d5ae7652cbebceb46b62a7cdcbb25b1ebbf0c177f856e573c9b971ff8ead73edf0b3552ec7edb69c9ff006bfc2b7be189c7852ec83822e1ff00f415af3f93c57af095c7f6b5cf0c7f887afd2b69ba6a9c79d5cf3b0f0c54b175feaf24b5d6e7a07873c0b6fe1abafed6d4af924785495c0da89c72493d78fa570be33d723d7bc4125c4049b78d447113fc40753f89fe55dd6857b178ebc233e997f266f210159cf5cff0bff9f435e5b7f633e9b7f359dca6d9a16dac3d7dc7b1eb515da54d282f759d1964653c5ce58995ea474b797747aaf857fe4974bff5cae3f9b579768dff0021bb0ffaf84fe62bd47c29ff0024be4ffae771fcdabcbb46ff0090d587fd7c27f31455da98603e3c57abfd4f42f8aaef145a4491b157595d9594e08200c1ad4d0354b4f1cf86a5d3f500a6e9142cc3be7b3aff009e0d657c58ff008f5d2ffdf7fe42b80d1f56b9d13538afad5be743f32e7875eea6aaa55e4acd3d998e1703f59cba0e1a4e3769fccf42f0169371a1f89f57b1b91f32431956c70ebb9b045713e2ff00f91b753ffaec6bdaf47d42cb59b28b53b50a4c89b7763e61eaa7e86bc53c5fff002376a7ff005d8ff2a311151a492d8329af3ad8e9cea2b4b96cfe563334ff00f909da7fd778ff00f4215e9df15bfe40d61ff5dfff006535e6361ff212b4ff00aef1ff00e842bd3be2b7fc816c3febbffeca6b3a3fc299d78fff007fc3fccf29a28a2b94f74ef3e19e842f752935598031dafcb183ddc8ebf80fe753f8bfc3de27d7f5e9278f4e26d63fddc00cc9f77d719ee6b98d17c59aa787eda4b7b068446efbcef8f71cfe62b4ff00e165788ffe7a5aff00df83ff00c5575c674bd9a83b9e056c363962e588a6a2fa2bf44773fd89a81f86bfd93f67ff004efb3ecf2b78eb9e99ce3f5af23d4f4abdd1eefecb7f0f9336d0db7706e0fb826bd806bf7c7e1d9d6b747f6df20c99d9f2e73e99af23d6359bbd72fbed77a50cbb427c8bb4607b5562792cadbd8cb24788f6953992e5e677ef7f2f236fe1cffc8e56dff5cdff00f41a9fe26ffc8d9ff6ec9fcdaa0f875ff2395b7fb8ff00fa09a9fe26ff00c8d83febd93f9b542ff77f99d12ff91baff09c6d14515ca7b86968baedfe8379f69b19029230e8c32ae3dc57a0e9ff00146c2e5162d56c5e22782f1fcebf975fe754bc39e13d0bc43e168916e80d4412d24887e6427f8483d474acfb8f861ad472ed866b6963cf0e58afe95d9055a0972ea8f9dc4d4cb7135251adeec9697d8ea751f08787fc4fa5b5f68fe5c53382525878563e8cbfcfbd79c78763787c5da6c522ed74bb5561e841af54f0f6971782bc39336a17887e632c8c3851c741fe7ad797e8f73f6bf1c59dd636f9d7c1f1e996cd5554b9a2ed66cc72fab3952af4d49ca093b367a8f8b3c1e7c4ef6ae2fc5b790ac3062dfbb38f71e958107c2688480cfac33a7711c014fe658ff2a6fc50bbb9b69b4d16f73345b95f3e5c8cb9e9e86b96f0cf8aaf348d6a19ee2ea79ad9be49964919be53dc64f51d6aaa4a97b4b4919e0e8e3de0d4e8d4b2d6cacbf33aff0017eb9a6e85e1d3e1cd2d94ca57ca65539f297b927d4ff5af2daf46f88be1d4755f105880d1c807da36f4e7a3ff0043f8579cd73e25cb9ecfe47a9934697d579a0eedef7ee7af78d7fe49bc7f4b7ffd096b96f860eabe29753d5addb1f815aea7c69cfc378fe96fff00a12d79a681ab3689addb5f8059636f9d47753c11fe7d2b6ad2e5ad16ce0c051956cbaad38eedb363e23232f8cae4b7478d187d36e3f9835ca0ea2bd77c57e1c8bc63676daa69171134ea98049f9645eb8cf620e7f335cc699f0d7579ef51750115bdb0397224dcc47a003f9d67568cdd4ba5a33ab039961e9e1231a92b38ab35d743aa93f73f084093826c00e7d48e3f9d45f0bdd5fc3575102372ced9fc40c550f88daf5b43a7c7a0593a93953305e88abd17eb9c1fc3deb0fe1f788a2d175492daedc25adde0173d11c7427d8f4ad9d48c6b25e563cd8e12a55cbea544b572e64bc8e4ee54a5d4eac30448c083f5356f448da5d774f8d3ef35c263f3aeefc51f0fae6f7529350d1de164b83bda276db827a907d0d4de13f034ba35f0d57589615300252356c853fde27dab05879fb4b58f5279b61de15b52f79adbadc3e2bba8b3d323fe23239fc302bcbeba6f1c788135ed7336ed9b4b75f2e33fde39e5bfcfa57335188929546d1d594d0951c24233df7fbc29d1ff00ad4ff787f3a6d3a3ff005a9fef0fe758adcf425f0b3db8e7737d4d14adf7cfd4d0335ef1f963dc3bd2e6814b4082971494b40051cd19a3bd0014bcd270296801475a31cd20f6a5e9400519cf141a00a00334b49467ad002e68c9a6d2d001d69693de968010734519a05002d1451400519ed45078a000f5a4ebcd0683cf4a004eb5cc7c47ff009273aeff00d7b1fe62ba8ae5fe247fc93ad77febd8ff0031401e4bf023fe461d5bfebcff00f66af2cbdff8feb8ff00ae8dfcebd4fe047fc8c3ab7fd79ffecd5e597bff001fd71ff5d1bf9d007d25f053fe49d41ff5f12ff315e878af3df829ff0024e6dffebe65fe62bd0f3c5007887ed0523893428bf836cadf8e40aeafe0ac689f0ee1740373dcca5bea0e3f95677c76d21af3c2d69a946326ca7c3ffb8e31fcf1543e036bf149a75ee812be278e4fb4440ff129c06c7d0ff3a00e0fe30c92bfc49d40484e1523099feeec07f9935f44f85adeced7c2ba54361b7eca2d632857a1ca824fe79af3bf8c9e02b9d6523f106950b4b75047b2e614e59d072180ee47391e9f4af37f0b7c51f10f84ecbfb3a2f2ae6d109d915c292633dc023903da803d7be35db59cbf0fa59ae153cf8678cdbb1ea189c103fe039ae53f67d926f3b5d8ce7c809130f4df923f9579ff00887c55e22f885a9db5bcea656076dbd9db21da09ef8ee7dcd7befc38f079f05f860c574cbf6eb86f3ae483c21c70b9f403bd0078efc6e8923f886ec9d5ed6266fae08fe4057bcf82a479bc11a249213bcd9440e7d9401fa0af9b3c6baa1f197c43ba96cc1649e75b6b61fde518507f1ebf8d7d4da6d92e9da5da58c78db6f02423fe02a067f4a00b58a5a6f4a5140075af94f4cff92c10ff00d868ff00e8d35f56679af94f4bff0092c10ffd868ffe8d3401f5652d26680680171cd1499a5a005a38a4eb4b401e0b451457827eaa046411eb5d1ea5e33bfd4f445d2a6b7b75854280c9bb77cbd3bd739455466e29a5d4caa50a7565194d5dad5051451526a5fd1f56b8d13528efed951a540400e091c8c76ae9ff00e1686b9ff3c2cffef96ff1ae268ad235671568b396be070f5e5cf5237676bff0b3f5cff9e167ff007c37f8d61ebfe26bdf11b5bb5e242a600c17cb047dec67393ec2b1a8a255a72566c9a597e1a8cd4e9c1268423208f5e2ba3d6bc67a96bba72d8dd476eb12b060501078fa9ae768a98cdc534ba9bd4a14ea4a339abb8ec15d0685e2fd43c3d672dada4703472397632039ce00ec7dab9fa288c9c5dd056a14eb4792a2ba1cec5dd9cf56249c55fd175abcd06fc5e593287da5595865581f5fe759d4525269dd153a709c1c24ae99a9ae6bb71afdda5d5d43024cabb4b4408dc3b673e959b1c8f148b246ec8ea72aca7041a6d143936eec29d285387b38ad0eaacfe21f882d2311b5c4770a060199327f31497bf107c4179198d6e12dd4f5f25307f335cb5157edaa5ad739bfb3b0bcdcdecd5fd0577691d9dd8b331c9663924d5ed1f57b9d13505bdb4d9e6aa951bc6460f5fe55428a84da77474ce9c6707092d197f58d5ee75cbf37b77b3cd2a17e4181815428a286db7763842308a8c55923a4b1f1c6b561a62d847246f0a2955f3172c07a66b9ba28a729ca4b56453c3d2a4dba714afb855cd3b56bfd266f36c2ea4818f50a783f51d0d53a2926d3ba2e708cd72c95d1d60f88fe2211ed33c05bfbe6219ac2d535ad47599449a85dbcc47dd53c2afd00e2a851552ab392b36614b0787a52e684127e85cd2f54bad1efd2f6cd956740402cb9183d78a7eafac5e6b9782eaf591a50bb32ab818aa1454f33b72f4357469ba9ed2def6d7ea14514523436f48f15eaba1d93da59491ac4ee5c864c9c9007f4158ac4b3127a939349453726d5999c28d3849ca2acdefe65ed2757bdd16f45dd8cbe5cbb4a9c8c820fa8a76afad5e6b972b717be534aabb772205247be3ad67d14f99db96fa0bd853f69ed7957377ea6cd9f8a757b1d28e996f728b68430d8635270d9cf3f89aca8267b79e39a220491b06538ce08e951d149ca4f7638d1a71bb8c52befe66aeafe22d535d4893519d651112531185c67e9595451436dbbb1d3a70a71e582b2f235748f126aba1a489a7dd79692105959030cfae0f4aa37b793ea1792dddcb879a53b9d800327e9505147336acde828d1a719ba918abbdd8e8e468a54910e1918329c770722b5756f136abae411c3a85c2ca91b6e50230b838c76ac8a2852695930952a72929c926d6cfb05145148d028a28a00d5ff00849356fec7fec9fb57fa16cd9e5ec1d3ebd6b2a8a29b937b910a50a77e4495f52d69da8dd69578b77652f973a82036d07af5eb4ed4f55bcd62efed57d379b36d09bb681c0fa7d6a9d14733b5ba07b2873fb4b2bf7ea14514522c92dee26b59966b79a48a55e8e8c4115bf178f3c4b0c6235d44b01c65e3563f9e2b9ca2aa339476663570d46aff001229faa2f6a3ad6a5abb86bfbc966c72158e147d074aab6f712dadcc57103ec96260c8de8474a8e8a4e4dbb971a508c7922acbb17f53d6b51d60c66fee5a631e7664018cf5e95428a286db7763842308f2c5591ad1f89b588ac058a5f3fd9826c11b0046df4e6b268a28726f714294217e4495cd4bbf11ead7da78b1b9bc692d86dfdd903b74fe5597451436dee10a70a6ad056f42ee9fabea3a5316b1bc9a0cf2423707ea3a55fb9f187882ea331c9a9cc14f0766149fcab0e8a6a724ac9912c3519cb9a504dfa0a49624924927249ef49451526c6959788357d3a311da6a3711c63a207ca8fc0d36fb5cd57525d9797f3cc9fdc66f97f2acfa2ab9e56b5cc7eaf479b9f955fd028a28a9360a747feb53fde1fce9b5359c2d737b042832d248aa3f3a6b726a34a0db3dacfdf6fa9a5148796247ad15ee9f96bdc514bf8d145020a28a5fad00149452d002d145140067b51451c50028e7b51499a3ad002d21a28a0028ef451400a28ef4838a5cfb5001451474a005cd19a4146714001a3bd2fbd250029e693a51d7a502800ae5fe23ff00c939d77febd8ff00315d4573de3bb492f7c07addbc285e56b472aa3a9239a00f1ef813ff00230eadff005e7ffb357965effc7f5c7fd746fe75e83f063558ec3c6ad6b2b2a8beb76850938cbf551f8f35c0ea11bc5a95d4722947595c32b7041c9e2803e8ff0082bff24eadff00ebe25fe62bd0ebcfbe0c44f1fc39b5de8cbba7959723a8c8e6bd06802aea9a6db6b1a5dce9d791892dee2331c83d8f71ee3ad7cb5aa69fadfc33f19ab46ed15c40fe65bce3959a33fcc11c115f57e6b1bc4de16d2fc59a61b1d520de01cc72af0f137aa9edfd680313c19f13344f165b471b4c967a90037dacad8c9f5427ef0fd6b6353f05f86f5a98cf7fa2da4b29eb2f97b58fe23ad784f893e0c788b4791a4d3146a96bd8c5c48bf553fd2b123d43c7da42fd9927d76055e021f3081f4eb401f4b58e8be1ef0b5b3cd696563a74407cf2e027e6c6bc93e267c5a86f6d26d0fc393334727c9717ab90197baa7b1ee7d3a5704746f1cf8ae6459ad757be20f06e37955ffbeb815e8fe0ef81eb04d1def89e5494af22ca2395cffb6ddfe83f3a00a1f05bc0d2cf7c9e28d421db6f0e459ab8fbefd37fd076f7fa57bc7f2a6c71470c491468a91a28555518000e800a75001d4d28f4a28340057ca7a5ff00c96087fec347ff00469afa92faf61d3ac27bdb97090c11b48ec4e000066be58f0679bacfc52d3664425a6d47ed0c0765dc589fc05007d5f477a683de945002d2f5a4a33cd002d19f6a4a5a00f06a2bbcff0085703fe8287fefc7ff006547fc2b71ff004143ff007e3ffb2af23ead57b1fa07f6de0bf9ff000670745779ff000ae07fd050ff00df8ffeca93fe15c8ff00a0a1ff00bf1ffd951f56abd83fb6f05fcff83384a2bbbff85703fe8287fefc7ff6547fc2b81ff4143ff7e3ff00b2a3ead57b07f6d60bf9ff000670945775ff000ae7fea287fefc7ff6547fc2b9ff00a899ff00bf1ffd951f56abd83fb6f05fcff83385a2bbaff85743fe8287fefc7ff6547fc2ba1ff4133ff7e3ff00b2a3ead57b07f6d60bf9ff000670b45773ff000aec7fd04cff00df8ffeca8ff85743fe8267fefc7ff6547d5aaf60fedbc17f3fe0ce1a8aeebfe15d7fd44cff00df8ffeca93fe15d8ff00a099ff00bf1ffd951f56abd83fb6f05fcff83386a2bb9ff85763fe8267fefc7ff6547fc2bb1ff4133ff7e3ff00b2a3ead57b07f6de0bf9ff000670d45773ff000aeffea267fefc7ff6547fc2bb1ff4133ff7e7ff00b2a3ead57b07f6de0bf9ff000670d45773ff000aec7fd04cff00df8ffeca8ff85763fe8267fefc7ff6547d5aaf60fedac17f3fe0ce1a8aee7fe15dff00d44cff00df8ffeca97fe15dffd44cffdf8ff00eca8fab55ec1fdb782fe7fc19c2d15dcff00c2bb1ff4133ff7e3ff00b2a3fe15dffd44cffdf8ff00eca8fab55ec1fdb782fe7fc19c3515dcff00c2bbff00a899ff00bf1ffd951ff0aec7fd04cffdf8ff00eca8fab55ec1fdb782fe7fc19c3515dcff00c2bbff00a899ff00bf1ffd951ff0aec7fd04cffdf8ff00eca8fab55ec1fdb782fe7fc19c3515dcff00c2bb1ff4133ff7e3ff00b2a5ff0085763fe8267fefc7ff006547d5aaf60fedbc17f3fe0ce168aeebfe15d8ff00a099ff00bf1ffd951ff0aebfea267fefc7ff006547d5aaf60fedbc17f3fe0ce168aeebfe15dffd44cffdf8ff00eca93fe15d8ffa099ffbf1ff00d951f56abd83fb6f05fcff0083386a2bb93f0ef1ff003133ff007e3ffb2a3fe15d8ffa099ffbf1ff00d951f56abd83fb6f05fcff0083386a2bb9ff008577ff005133ff007e3ffb2a3fe15d8ffa099ffbf1ff00d951f56abd83fb6f05fcff0083386a2bbaff0085763fe8267fefc7ff006547fc2ba1ff004143ff007e3ffb2a3ead57b07f6de0bf9ff0670b45775ff0ae87fd050ffdf8ff00eca8ff008575cffc84cffdf8ff00eca8fab55ec1fdb782fe7fc19c2d15dd7fc2ba1ff4133ff7e3ff00b2a3fe15d7fd44cffdf8ff00eca8fab55ec1fdb782fe7fc19c2d15dd7fc2baff00a899ff00bf1ffd951ff0aec7fd04cffdf8ff00eca8fab55ec1fdb582fe7fc19c2d15dd7fc2bb1ff4133ff7e7ff00b2a4ff0085763fe8267fefc7ff006547d5aaf60fedbc17f3fe0ce1a8aee7fe15dffd44cffdf8ff00eca97fe15d0ffa099ffbf1ff00d951f56abd83fb6f05fcff0083385a2bbaff008575ff005133ff007e3ffb2a4ff8577ff5133ff7e3ff00b2a3ead57b07f6de0bf9ff000670d45773ff000aeffea267fefc7ff6547fc2bbff00a899ff00bf1ffd951f56abd83fb6f05fcff83386a2bb9ff85783fe8267fefc7ff6549ff0af067fe4267fefcfff006547d5aaf60fedbc17f3fe0ce1e8aee3fe15e7fd44cffdf9ff00eca8ff0085783fe8267fefc7ff006547d5aaf60fedbc17f3fe0ce1e8aee3fe15effd44cffdf9ff00eca8ff008579ff005123ff007e7ffb2a3ead57b07f6de0bf9ff0670f4576ff00f0af47fd04cffdf9ff00ebd1ff000af47fd04cff00df9ffeca8fab55ec1fdb782fe7fc19c4515dbffc2bdffa891ffbf3ff00d951ff000af47fd04cff00df9ffeca8fab55ec1fdb582fe7fc19c4515dc7fc2bd1ff004133ff007e7ffb2a4ff857bff5123ff7e7ff00b2a3ead57b07f6de0bf9ff00067114576fff000af07fd04cff00df9ffeca97fe15e0ff00a099ff00bf3ffd951f56abd83fb6f05fcff83387a2bb7ff857bff5123ff7e7ff00b2a5ff0085783fe8267fefcfff006547d5aaf60fedbc17f3fe0ce1e8aee3fe15e0ff00a099ff00bf3ffd7a3fe15e7fd448ff00df9ffeca8fab55ec1fdb782fe7fc19c3d15dcffc2bb1ff004133ff007e3ffb2a3fe15d8ffa099ffbf1ff00d951f56abd83fb6f05fcff0083386aed3c11a13b5c2eab709b634c88011f78ff007be83f9d6be9de08d36ca412cecf76ebd048004ffbe7bfe75d30000000c01d00ae9a185717cd33c7ccf3c854a6e950ebd4334b81d68c0a05771f2e28eb452d140051477a2800c518a2945002500d2f7a062800e94119a0d140094b9a293a5002f5a4fe5474a31400b45145001451da8a005068e69297a500149de97af4a280129693a1a2800a33cd1d68cd002f5a4600a952320f041ef451401f337c48f035df83f5d3a8d8ac9fd9934be641320c790f9cec27b107a1ef5b5e1ef8a7a1dc054f176816f7170061afe28159e4c777538c9f706bdeae6d6def6d9edaea08e78241878e450cac3dc1af34d63e06f876fe6796c2e6e74e2c73b131220fa0639fd6802dc5f197c130c4b1c52dd468a30a8b6980a3d0006a4ff85d5e0cff009f9bcffc063fe35cc7fc33e5bf6f12cbff008023ff008e527fc33e41ff004334bff8023ff8e50074ff00f0babc19ff003f379ff80c7fc697fe1757837fe7eaf3ff00018ff8d72fff000cf907fd0cd2ff00e008ff00e394bff0cf907fd0cd2ffe000ffe39401d37fc2eaf067fcfcde7fe031ff1a70f8d9e0f1c0bcbe1f4b73fe35cbffc33dc1ff4334bff008023ff008e51ff000cf907fd0cd2ff00e000ff00e39401d39f8d7e0d6fbd777a7eb6e7fc68ff0085d5e0cff9f9bcff00c063fe35cc7fc33dc1ff004334bff8003ff8e51ff0cf707fd0cd2ffe000ffe39401d3ffc2ebf067fcfcde7fe031ff1a3fe175f833fe7e6f3ff00018ff8d731ff000cf707fd0cd2ff00e008ff00e3949ff0cf96ff00f4334bff008003ff008e500753ff000bafc19ff3f379ff0080c7fc6a397e37783d232cb2dec840e156db93f9b5735ff0cf907fd0cd2ffe008ffe395227ecf96a18193c493b2f70b6414ffe8668038bf1dfc52bff0018c3fd9d6b01b2d37765a20db9e53db71f4f615e87f07bc013e8703ebfaac6d15edc26c82061868a33d49f427d3b0fad745e19f859e1af0cceb751dbb5e5e2fdd9aeb0db7dd57a03efd6bb63cd0026297349477e9400b4b494b40077a5a4268a004a0d149400b9a4f6a5a28010d19cd079a00c50021eb451450025252d25002519a5a280128a28340051f851d0d19a005a4ef4668eb4000a28e9476e28014d252679f7a5a0028a3e94500252d149400ea293a51400b49de8a280168ce6928a0028ef45358e05002e7d69734c032d934fa0029693bd1400b4519a2800cd149d696800a28a3208a0028a28c500141a28a0000a28a2800a4a75250018a43c52d250025029693a50025145045001ef45141a004c504514bf5a004c514bde92800c514b474a004a2968a0031cd14b4500277a75262945002631452d06800a3bd146280168a28a005a4a296800a5ed45262800a2968a00052fe1494bc9a004a28a2800a4cfb52d140051451da800a28a2800a4a5a2800a28a2800a28a2800a29296800e451f5a28a003345149ed4007e94b49475340075a5cf34941a005a3dfb5252e7d6800cd19cd2668a007668a4147d68017ae28c5266968013bd2d068c9a003ad14b4868013ad2f6a4cd18e6801739e28a4a506800e7bd3a928a002939a5c518e6800a43da83450026314b9e28a4cd00141e051d292800a4a5c5250014038a3d28228013d693ad2d140051494b4005145275a005a4347b5068001d697d68a4a005cd14940ed400b9a3349cd2d0014519a28012971d69297a5001f4a3de8a4a005eb463da8a2800c0a5a4a08ef400507a514b40076a28a2801294714518c5001451450014b4945001451d28a0028cd028a003b7b5251450014b4941a003a9a43452d0027e34014b49d280131cf341a5a4a0008a3da968a004a2971464d0018a4ef4a692800a314b45000314b474a2800140a5c5250014734b49d6800a28a280168f5a29680128ef4b462800eb4b4638a3ad001451d28cd001476c5145001de8a28a0028a28a00283c814514005277a5a4f7a005a4a28ef400bda93de8ef8a3bd002e68a4a31400b476a414500147d28a5a002928a2800a3f9519a09a003bd140eb49400b450693b5002d1494b4005038e28eb45002d149450029a051499c5002f7a5cd37bd2d0028e9460520e39a5c9a003141e68a28001d2945145001de83ef4518a002901a0d0680128a339eb45002514507b5001494b49400668268149400b494506800a2939a5a000d203c74c527539a750014519a2800c71494b4668013ad2e28a28003da8e73413ed475a004ea6969297b7b500145252f534005277a5a3f9d00147141a3e9400734b494b40094bde928a005a3e9451400518a28a005a4e9476a2800a28a05001db8a28eb4d625470a4fb0a00751451da8013b52fe34526280168a3ad250029a4a3f4a28003f4a4a5f6a280128a5a4a005a3b51da8ebf4a004a519c518a28010514b450014628cd140077a2968cd002529a28c50018a314bd690d0003d68a320639a5a004c52e690d2d0014bde907ad2d00141e28f7a2800a0f145140051451da800a28a2800a28a2800a28ed49400a28a05140094bdfda8a4cd00145145002d2519a3ad00145029680129693068eb400514514005252f4a2801334514500264d2f6a292801734668ef40a00296928a005a327b5145002f5a423bd1450014b49d696800a33474a2800cd2d2638a5e9400751ef40f5a5a0f3401ffd9, 'used for motorcycles that have 4 stroke engines\r\n');
INSERT INTO `products` (`product_id`, `product_name`, `additional_name`, `type`, `brand`, `price`, `quantity`, `location`, `image`, `description`) VALUES
(4, 'Motor Oil', 'Havoline 2T', '200ml', 'Caltex', 40, 15, 'Shelf A1', NULL, ''),
(5, 'Break Fluid', 'DOT-3', '300ml', 'National', 100, 13, 'Shelf A1', NULL, ''),
(6, 'Break Fluid', 'DOT-3', '900ml', 'National', 250, 15, 'Shelf A1', NULL, ''),
(7, 'Break Fluid', 'DOT-3', '500ml', 'Prestone', 195, 15, 'Shelf A1', NULL, ''),
(8, 'Break Fluid', 'DOT-3', '900ml', 'Prestone', 280, 15, 'Shelf A1', NULL, ''),
(9, 'Diesel Engine Oil', 'Delo Gold', '1L', 'Caltex', 255, 14, 'Shelf A1', NULL, ''),
(10, 'Gasoline Engine Oil', 'Havoline 15W-40', '1L', 'Caltex', 230, 12, 'Shelf A1', NULL, ''),
(11, 'Motor Oil', 'Havoline 4T', '1L', 'Caltex', 230, 15, 'Shelf A1', NULL, ''),
(12, 'Radiator Coolant', 'Super Coolant', '1L', 'Petron', 220, 15, 'Shelf A1', NULL, ''),
(13, 'Gasoline Engine Oil', 'Blaze Racing', '1L', 'Petron', 210, 12, 'Shelf A1', NULL, ''),
(14, 'Diesel Engine Oil', 'Rev-X', '1L', 'Petron', 190, 15, 'Shelf A1', NULL, ''),
(15, 'Scooter Oil', 'Sprint 4T', '800ml', 'Petron', 215, 15, 'Shelf A1', NULL, ''),
(16, 'Coolant', 'Delo XLI', '1L', 'Caltex', 180, 15, 'Shelf A1', NULL, ''),
(17, 'Motor Oil', 'Sprint 4T', '1L', 'Petron', 215, 15, 'Shelf A1', NULL, ''),
(18, 'Diesel Engine Oil', 'Rev-X', '1L', 'Petron', 245, 15, 'Shelf A1', NULL, ''),
(19, 'Transmission Fluid', 'ATF', '1L', 'Petron', 250, 15, 'Shelf A1', NULL, ''),
(20, 'Motor Oil', '2T', '1L', 'Petron', 190, 15, 'Shelf A1', NULL, ''),
(21, 'Transmission Fluid', 'Dtec', '1L', 'ZIP', 230, 12, 'Shelf A1', NULL, ''),
(22, 'Motor Oil', 'Advance', '1L', 'Shell', 230, 15, 'Shelf A1', NULL, ''),
(23, 'Bolt', '', '3/8×3', '', 12, 100, 'Shelf A2', NULL, ''),
(24, 'Bolt', '', '3/8×1', '', 6, 100, 'Shelf A2', NULL, ''),
(25, 'Bolt', '', '3/8×3/4', '', 6, 100, 'Shelf A2', NULL, ''),
(26, 'Bolt', '', '3/8×12', '', 10, 100, 'Shelf A2', NULL, ''),
(27, 'Nut', '', '3/8', '', 3, 100, 'Shelf A2', NULL, ''),
(28, 'Bolt', '', '5/16×1', '', 7, 100, 'Shelf A2', NULL, ''),
(29, 'Bolt', '', '5/16×1 1/2', '', 8, 100, 'Shelf A2', NULL, ''),
(30, 'Bolt', '', '5/16×2', '', 10, 100, 'Shelf A2', NULL, ''),
(31, 'Bolt', '', '5/16×3', '', 11, 100, 'Shelf A2', NULL, ''),
(32, 'Nut', '', '5/16', '', 2, 1000, 'Shelf A2', NULL, ''),
(33, 'Bolt', '', '5/16×3/4', '', 5, 100, 'Shelf A2', NULL, ''),
(34, 'Lock Washer', '', '3/8', '', 2, 100, 'Shelf A2', NULL, ''),
(35, 'Lock Washer', '', '5/16', '', 2, 99, 'Shelf A2', NULL, ''),
(36, 'Washer', '', '5/16', '', 2, 100, 'Shelf A2', NULL, ''),
(37, 'Washer', '', '3/8', '', 2, 100, 'Shelf A2', NULL, ''),
(38, 'Washer', '', '5/18', '', 10, 100, 'Shelf A2', NULL, ''),
(39, 'Nut', '', '1/2', '', 5, 100, 'Shelf A2', NULL, ''),
(40, 'Nut', '', '1/4', '', 2, 100, 'Shelf A2', NULL, ''),
(41, 'Bolt', '', '1/4×1', '', 5, 100, 'Shelf A2', NULL, ''),
(42, 'Bolt', '', '1/2×4', '', 26, 100, 'Shelf A2', NULL, ''),
(43, 'Lock Bolt', '', '1/2×6', '', 35, 100, 'Shelf A2', NULL, ''),
(44, 'Bearing', '', '6001', 'Koyo', 120, 10, 'Shelf B1', NULL, ''),
(45, 'Bearing', '', '6002', 'Koyo', 150, 10, 'Shelf B1', NULL, ''),
(46, 'Bearing', '', '6003', 'Koyo', 150, 10, 'Shelf B1', NULL, ''),
(47, 'Bearing', '', '6004', 'Koyo', 150, 10, 'Shelf B1', NULL, ''),
(48, 'Bearing', '', '6005', 'Koyo', 170, 7, 'Shelf B1', NULL, ''),
(49, 'Bearing', '', '6200', 'Koyo', 100, 10, 'Shelf B1', NULL, ''),
(50, 'Bearing', '', '6201', 'Koyo', 120, 10, 'Shelf B2', NULL, ''),
(51, 'Bearing', '', '6202', 'Koyo', 120, 10, 'Shelf B2', NULL, ''),
(52, 'Bearing', '', '6203', 'Koyo', 140, 10, 'Shelf B2', NULL, ''),
(53, 'Bearing', '', '6204', 'Koyo', 180, 10, 'Shelf B2', NULL, ''),
(54, 'Bearing', '', '6205', 'Koyo', 180, 10, 'Shelf B2', NULL, ''),
(55, 'Bearing', '', '6301', 'Koyo', 150, 10, 'Shelf B2', NULL, ''),
(56, 'Bearing', '', '6302', 'Koyo', 150, 10, 'Shelf B2', NULL, ''),
(57, 'Bearing', '', '6300', 'Koyo', 100, 10, 'Shelf B2', NULL, ''),
(58, 'Bearing', '', '6306', 'Koyo', 320, 10, 'Shelf B2', NULL, ''),
(59, 'Bearing', '', '6305', 'Koyo', 270, 10, 'Shelf B2', NULL, ''),
(60, 'Bearing', '', '607', 'Koyo', 100, 10, 'Shelf B2', NULL, ''),
(61, 'Bearing', '', '608', 'Koyo', 100, 10, 'Shelf B2', NULL, ''),
(62, 'Knuckle Bearing', '', '32207', 'Koyo', 500, 5, 'Shelf B2', NULL, ''),
(63, 'Knuckle Bearing', '', '32210', 'Koyo', 720, 5, 'Shelf B2', NULL, ''),
(64, 'Knuckle Bearing', '', 'L212641/10', 'Koyo', 200, 5, 'Shelf B2', NULL, ''),
(65, 'Knuckle Bearing', '', 'LM48548/10', 'Koyo', 320, 5, 'Shelf B2', NULL, ''),
(66, 'Knuckle Bearing', '', '45449/10', 'Koyo', 270, 5, 'Shelf B2', NULL, ''),
(67, 'Fuel Tank cap', '', 'Black', 'Circuit', 250, 100, 'Shelf B1', NULL, ''),
(68, 'Plug-in Fuse', '', '10AMP', 'Circuit', 10, 100, 'Shelf B1', NULL, ''),
(69, 'Plug-in Fuse', '', '15AMP', 'Circuit', 10, 100, 'Shelf B1', NULL, ''),
(70, 'Plug-in Fuse', '', '20AMP', 'Circuit', 10, 96, 'Shelf B1', NULL, ''),
(71, 'Plug-in Fuse', '', '30AMP', 'Circuit', 10, 100, 'Shelf B1', NULL, ''),
(72, 'Mini Plug-in Fuse', '', '10AMP', 'Circuit', 10, 100, 'Shelf B1', NULL, ''),
(73, 'Mini Plug-in Fuse', '', '15AMP', 'Circuit', 10, 100, 'Shelf B1', NULL, ''),
(74, 'Mini Plug-in Fuse', '', '20AMP', 'Circuit', 10, 100, 'Shelf B1', NULL, ''),
(75, 'Mini Plug-in Fuse', '', '30AMP', 'Circuit', 10, 100, 'Shelf B1', NULL, ''),
(76, 'Female Terminal', '', '', 'Circuit', 5, 50, 'Shelf B1', NULL, ''),
(77, 'Eye Terminal', '', '3/16', 'Circuit', 5, 50, 'Shelf B1', NULL, ''),
(78, 'Eye Terminal', '', '5/16', 'Circuit', 10, 50, 'Shelf B1', NULL, ''),
(79, 'Ignition Switch', '', 'Diesel', 'Circuit', 460, 6, 'Shelf B1', NULL, ''),
(80, 'Ignition Switch', '', 'Gasoline', 'I.Tokyo', 380, 6, 'Shelf B1', NULL, ''),
(81, 'Priming Pump', '', '', 'DENSO', 590, 6, 'Shelf B1', NULL, ''),
(82, 'Alternator Carbon Brush', '', '37A', 'FCC', 50, 30, 'Shelf B1', NULL, ''),
(83, 'Starter Carbon Brush', '', '4K', 'FCC', 140, 30, 'Shelf B1', NULL, ''),
(84, 'Starter Carbon Brush', '', 'L300', 'FCC', 200, 30, 'Shelf B1', NULL, ''),
(85, 'Alternator Carbon Brush', '', '22A', 'FCC', 50, 30, 'Shelf B1', NULL, ''),
(86, 'Gasket Shellac', '', '', 'V-tech', 70, 50, 'Shelf B1', NULL, ''),
(87, 'Temperature Sending Unit', '', '', 'Circuit', 180, 10, 'Shelf B1', NULL, ''),
(88, 'Air-Horn Switch Relay', '', '', 'Maruzen', 450, 6, 'Shelf B1', NULL, ''),
(89, 'Silicon Radiator Cap', '', 'RC-93', 'Circuit', 120, 6, 'Shelf B1', NULL, ''),
(90, 'Silicon Radiator Cap', '', 'RC-95', 'Circuit', 120, 7, 'Shelf B1', NULL, ''),
(91, 'Silicon Radiator Cap', '', 'RC-102', 'Circuit', 120, 7, 'Shelf B1', NULL, ''),
(92, 'Heater Plug', '', '', 'Circuit', 100, 50, 'Shelf B1', NULL, ''),
(93, 'Oil Filter', '', 'C-806', 'ViC', 250, 6, 'Shelf B2', NULL, ''),
(94, 'Oil Filter', '', 'C-415', 'ViC', 240, 6, 'Shelf B2', NULL, ''),
(95, 'Oil Filter', '', 'C-106', 'ViC', 250, 4, 'Shelf B2', NULL, ''),
(96, 'Oil Filter', '', 'C-512', 'ViC', 290, 6, 'Shelf B2', NULL, ''),
(97, 'Oil Filter', '', 'C-312', 'ViC', 220, 6, 'Shelf B2', NULL, ''),
(98, 'Oil Filter', '', 'C-318', 'ViC', 950, 6, 'Shelf B2', NULL, ''),
(99, 'Oil Filter', '', 'C-207', 'ViC', 240, 3, 'Shelf B2', NULL, ''),
(100, 'Oil Filter', '', 'C-527', 'ViC', 340, 6, 'Shelf B2', NULL, ''),
(101, 'Oil Filter', '', 'C-111', 'ViC', 280, 6, 'Shelf B2', NULL, ''),
(102, 'Oil Filter', '', 'C-412', 'ViC', 520, 6, 'Shelf B2', NULL, ''),
(103, 'Oil Filter', '', 'C-707', 'ViC', 200, 6, 'Shelf B2', NULL, ''),
(104, 'Oil Filter', '', 'C-405', 'ViC', 250, 6, 'Shelf B2', NULL, ''),
(105, 'Oil Filter', '', 'C-305', 'ViC', 350, 6, 'Shelf B2', NULL, ''),
(106, 'Oil Filter', '', 'C-503', 'ViC', 400, 6, 'Shelf B2', NULL, ''),
(107, 'Fuel Filter', '', 'FC-193', 'ViC', 370, 6, 'Shelf B3', NULL, ''),
(108, 'Fuel Filter', '', 'FC-208A', 'ViC', 280, 6, 'Shelf B3', NULL, ''),
(109, 'Fuel Filter', '', 'FC-317', 'ViC', 340, 6, 'Shelf B3', NULL, ''),
(110, 'Rubber Cup', '', 'SC-80353', '', 55, 35, 'Shelf B3', NULL, ''),
(111, 'Rubber Cup', '', 'SC-80423', '', 50, 50, 'Shelf B3', NULL, ''),
(112, 'Rubber Cup', '', 'SC-30233', '', 60, 50, 'Shelf B3', NULL, ''),
(113, 'Rubber Cup', '', 'SC-47624', '', 50, 50, 'Shelf B3', NULL, ''),
(114, 'Electrical Tape', '', 'Big', 'Armok', 60, 20, 'Shelf B4', NULL, ''),
(115, 'Electrical Tape', '', 'Small', 'Armok', 30, 20, 'Shelf B4', NULL, ''),
(116, 'Spray Paint', '', 'Silver', 'Bosny', 120, 5, 'Shelf C1', NULL, ''),
(117, 'Spray Paint', '', 'Black', 'Bosny', 120, 5, 'Shelf C1', NULL, ''),
(118, 'Spray Paint', '', 'White', 'Bosny', 120, 5, 'Shelf C1', NULL, ''),
(119, 'Spray Paint', '', 'Clear', 'Bosny', 120, 5, 'Shelf C1', NULL, ''),
(120, 'Spray Paint', '', 'Blue', 'Bosny', 120, 6, 'Shelf C1', NULL, ''),
(121, 'Spray Paint', '', 'Red', 'Bosny', 120, 5, 'Shelf C1', NULL, ''),
(122, 'Spray Paint', '', 'Yellow', 'Bosny', 120, 5, 'Shelf C1', NULL, ''),
(123, 'Battery Terminal', '', '', '', 70, 245, 'Shelf B4', NULL, ''),
(124, 'Sandpaper', '', 'CC 120', 'Hippo', 20, 100, 'Shelf C5', NULL, ''),
(125, 'Sandpaper', '', 'CC 400', 'Hippo', 20, 100, 'Shelf C5', NULL, ''),
(126, 'Sandpaper', '', 'CC 1000', 'Hippo', 20, 96, 'Shelf C5', NULL, '');

--
-- Triggers `products`
--
DELIMITER $$
CREATE TRIGGER `trg_products_after_delete` AFTER DELETE ON `products` FOR EACH ROW BEGIN
  INSERT INTO audit_log VALUES
    (NULL, 'products', 'DELETE', OLD.product_id, 'product_name', OLD.product_name, NULL, @user, NOW()),
    (NULL, 'products', 'DELETE', OLD.product_id, 'additional_name', OLD.additional_name, NULL, @user, NOW()),
    (NULL, 'products', 'DELETE', OLD.product_id, 'type', OLD.type, NULL, @user, NOW()),
    (NULL, 'products', 'DELETE', OLD.product_id, 'brand', OLD.brand, NULL, @user, NOW()),
    (NULL, 'products', 'DELETE', OLD.product_id, 'price', OLD.price, NULL, @user, NOW()),
    (NULL, 'products', 'DELETE', OLD.product_id, 'quantity', OLD.quantity, NULL, @user, NOW()),
    (NULL, 'products', 'DELETE', OLD.product_id, 'location', OLD.location, NULL, @user, NOW()),
    (NULL, 'products', 'DELETE', OLD.product_id, 'image', 'BLOB deleted', NULL, @user, NOW()),
    (NULL, 'products', 'DELETE', OLD.product_id, 'description', OLD.description, NULL, @user, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_products_after_insert` AFTER INSERT ON `products` FOR EACH ROW BEGIN
  INSERT INTO audit_log VALUES
    (NULL, 'products', 'INSERT', NEW.product_id, 'product_name', NULL, NEW.product_name, @user, NOW()),
    (NULL, 'products', 'INSERT', NEW.product_id, 'additional_name', NULL, NEW.additional_name, @user, NOW()),
    (NULL, 'products', 'INSERT', NEW.product_id, 'type', NULL, NEW.type, @user, NOW()),
    (NULL, 'products', 'INSERT', NEW.product_id, 'brand', NULL, NEW.brand, @user, NOW()),
    (NULL, 'products', 'INSERT', NEW.product_id, 'price', NULL, NEW.price, @user, NOW()),
    (NULL, 'products', 'INSERT', NEW.product_id, 'quantity', NULL, NEW.quantity, @user, NOW()),
    (NULL, 'products', 'INSERT', NEW.product_id, 'location', NULL, NEW.location, @user, NOW()),
    (NULL, 'products', 'INSERT', NEW.product_id, 'image', NULL, 'BLOB inserted', @user, NOW()),
    (NULL, 'products', 'INSERT', NEW.product_id, 'description', NULL, NEW.description, @user, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_products_after_update` AFTER UPDATE ON `products` FOR EACH ROW BEGIN
  IF NOT (OLD.product_name <=> NEW.product_name) THEN
    INSERT INTO audit_log (table_name, action, record_id, column_name, old_value, new_value, changed_by)
    VALUES ('products', 'UPDATE', NEW.product_id, 'product_name', OLD.product_name, NEW.product_name, @user);
  END IF;

  IF NOT (OLD.additional_name <=> NEW.additional_name) THEN
    INSERT INTO audit_log (table_name, action, record_id, column_name, old_value, new_value, changed_by)
    VALUES ('products', 'UPDATE', NEW.product_id, 'additional_name', OLD.additional_name, NEW.additional_name, @user);
  END IF;

  IF NOT (OLD.type <=> NEW.type) THEN
    INSERT INTO audit_log (table_name, action, record_id, column_name, old_value, new_value, changed_by)
    VALUES ('products', 'UPDATE', NEW.product_id, 'type', OLD.type, NEW.type, @user);
  END IF;

  IF NOT (OLD.brand <=> NEW.brand) THEN
    INSERT INTO audit_log (table_name, action, record_id, column_name, old_value, new_value, changed_by)
    VALUES ('products', 'UPDATE', NEW.product_id, 'brand', OLD.brand, NEW.brand, @user);
  END IF;

  IF NOT (OLD.price <=> NEW.price) THEN
    INSERT INTO audit_log (table_name, action, record_id, column_name, old_value, new_value, changed_by)
    VALUES ('products', 'UPDATE', NEW.product_id, 'price', OLD.price, NEW.price, @user);
  END IF;

  IF NOT (OLD.quantity <=> NEW.quantity) THEN
    INSERT INTO audit_log (table_name, action, record_id, column_name, old_value, new_value, changed_by)
    VALUES ('products', 'UPDATE', NEW.product_id, 'quantity', OLD.quantity, NEW.quantity, @user);
  END IF;

  IF NOT (OLD.location <=> NEW.location) THEN
    INSERT INTO audit_log (table_name, action, record_id, column_name, old_value, new_value, changed_by)
    VALUES ('products', 'UPDATE', NEW.product_id, 'location', OLD.location, NEW.location, @user);
  END IF;

  IF NOT (OLD.image <=> NEW.image) THEN
    INSERT INTO audit_log (table_name, action, record_id, column_name, old_value, new_value, changed_by)
    VALUES ('products', 'UPDATE', NEW.product_id, 'image', 'IMAGE CHANGED', 'IMAGE CHANGED', @user);
  END IF;

  IF NOT (OLD.description <=> NEW.description) THEN
    INSERT INTO audit_log (table_name, action, record_id, column_name, old_value, new_value, changed_by)
    VALUES ('products', 'UPDATE', NEW.product_id, 'description', OLD.description, NEW.description, @user);
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `sales_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `quantity_sold` int(11) NOT NULL,
  `purchase_sale` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`sales_id`, `product_id`, `invoice_id`, `quantity_sold`, `purchase_sale`) VALUES
(1, 6, 3, 1, 250),
(2, 11, 3, 2, 460),
(3, 36, 3, 7, 14),
(4, 10, 4, 1, 230),
(5, 9, 4, 1, 255),
(6, 1, 5, 1, 40),
(7, 120, 5, 1, 200),
(8, 126, 5, 4, 40),
(9, 91, 6, 2, 175.02),
(10, 116, 6, 1, 359.11),
(11, 97, 6, 1, 258.28),
(12, 38, 6, 2, 316.32),
(13, 46, 6, 5, 316.65),
(14, 56, 7, 3, 457.11),
(15, 31, 7, 2, 271.78),
(16, 44, 7, 3, 267.21),
(17, 109, 8, 5, 1166.6),
(18, 39, 8, 3, 1285.92),
(19, 96, 8, 1, 422.12),
(20, 64, 8, 5, 236.95),
(21, 39, 9, 4, 1714.56),
(22, 24, 9, 3, 1077.21),
(23, 14, 9, 1, 274.19),
(24, 113, 9, 3, 1339.23),
(25, 122, 10, 2, 47.04),
(26, 40, 10, 3, 762.99),
(27, 114, 10, 4, 1708.2),
(28, 71, 10, 5, 1361.55),
(29, 72, 11, 2, 895.2),
(30, 13, 12, 5, 1202.85),
(31, 7, 13, 5, 1899.25),
(32, 122, 13, 3, 70.56),
(33, 23, 14, 3, 915.45),
(34, 32, 14, 1, 155.48),
(35, 120, 14, 3, 1236.72),
(36, 117, 14, 4, 1085.56),
(37, 29, 14, 5, 2302.7),
(38, 56, 15, 3, 457.11),
(39, 46, 16, 1, 63.33),
(40, 122, 16, 5, 117.6),
(41, 56, 16, 4, 609.48),
(42, 123, 16, 4, 941.32),
(43, 9, 16, 3, 142.05),
(44, 68, 17, 4, 746.72),
(45, 98, 17, 1, 496.12),
(46, 21, 17, 2, 837.82),
(47, 15, 17, 2, 121.16),
(48, 5, 17, 1, 130.49),
(49, 45, 18, 3, 672.12),
(50, 95, 18, 4, 1665.04),
(51, 121, 18, 1, 164.04),
(52, 27, 19, 3, 827.04),
(53, 80, 19, 1, 354.5),
(54, 71, 20, 1, 272.31),
(55, 1, 21, 5, 1820.25),
(56, 5, 21, 5, 652.45),
(57, 64, 21, 2, 94.78),
(58, 120, 22, 5, 2061.2),
(59, 67, 22, 4, 1551.4),
(60, 90, 22, 2, 90.36),
(61, 37, 22, 3, 796.02),
(62, 37, 23, 1, 265.34),
(63, 38, 24, 1, 158.16),
(64, 110, 24, 3, 221.46),
(65, 102, 24, 2, 48.58),
(66, 22, 24, 4, 1288.56),
(67, 110, 25, 3, 221.46),
(68, 105, 25, 2, 204.76),
(69, 121, 25, 2, 328.08),
(70, 83, 25, 1, 470.14),
(71, 29, 25, 1, 460.54),
(72, 19, 26, 1, 465.59),
(73, 16, 26, 2, 486.72),
(74, 99, 26, 4, 1421.2),
(75, 39, 26, 4, 1714.56),
(76, 46, 27, 1, 63.33),
(77, 63, 28, 4, 1117.28),
(78, 83, 28, 5, 2350.7),
(79, 37, 28, 1, 265.34),
(80, 72, 29, 3, 1342.8),
(81, 32, 30, 3, 466.44),
(82, 93, 30, 4, 1517.72),
(83, 118, 30, 4, 1383.4),
(84, 31, 30, 5, 679.45),
(85, 10, 30, 2, 20.56),
(86, 14, 31, 5, 1370.95),
(87, 52, 32, 4, 1668.32),
(88, 31, 32, 5, 679.45),
(89, 62, 32, 4, 1364.84),
(90, 42, 33, 4, 1771.68),
(91, 125, 33, 1, 238.01),
(92, 20, 33, 4, 1793.68),
(93, 102, 33, 3, 72.87),
(94, 5, 34, 5, 652.45),
(95, 62, 34, 2, 682.42),
(96, 9, 34, 1, 47.35),
(97, 62, 34, 5, 1706.05),
(98, 25, 35, 5, 275.05),
(99, 121, 35, 1, 164.04),
(100, 74, 35, 1, 31.09),
(101, 77, 36, 3, 254.7),
(102, 94, 37, 4, 641.36),
(103, 10, 38, 1, 10.28),
(104, 40, 38, 1, 254.33),
(105, 66, 39, 5, 1328.5),
(106, 99, 39, 2, 710.6),
(107, 33, 39, 3, 280.23),
(108, 73, 39, 1, 213.66),
(109, 58, 39, 5, 2424.85),
(110, 63, 40, 3, 837.96),
(111, 45, 40, 3, 672.12),
(112, 32, 41, 5, 777.4),
(113, 35, 41, 1, 160.33),
(114, 93, 41, 4, 1517.72),
(115, 81, 41, 1, 26.57),
(116, 25, 41, 2, 110.02),
(117, 36, 42, 3, 796.86),
(118, 67, 42, 3, 1163.55),
(119, 33, 42, 3, 280.23),
(120, 82, 43, 3, 960.96),
(121, 6, 43, 2, 194.52),
(122, 1, 44, 5, 1820.25),
(123, 111, 45, 5, 1675.25),
(124, 33, 45, 5, 467.05),
(125, 18, 45, 3, 715.68),
(126, 13, 45, 4, 962.28),
(127, 72, 46, 2, 895.2),
(128, 78, 46, 3, 1370.73),
(129, 55, 47, 5, 635),
(130, 27, 47, 3, 827.04),
(131, 122, 48, 4, 94.08),
(132, 54, 49, 4, 632.32),
(133, 70, 49, 5, 593.3),
(134, 46, 49, 4, 253.32),
(135, 69, 49, 5, 260.1),
(136, 99, 50, 1, 355.3),
(137, 21, 50, 4, 1675.64),
(138, 3, 50, 4, 63.76),
(139, 104, 50, 2, 509.58),
(140, 75, 50, 3, 1295.22),
(141, 34, 51, 5, 2383.55),
(142, 65, 51, 5, 273),
(143, 17, 51, 4, 1125.12),
(144, 94, 51, 5, 801.7),
(145, 63, 52, 2, 558.64),
(146, 28, 52, 5, 1103.4),
(147, 3, 52, 2, 31.88),
(148, 3, 52, 3, 47.82),
(149, 36, 53, 1, 265.62),
(150, 76, 53, 1, 357.14),
(151, 19, 53, 1, 465.59),
(152, 84, 54, 4, 788.64),
(153, 63, 54, 4, 1117.28),
(154, 58, 55, 2, 969.94),
(155, 54, 55, 4, 632.32),
(156, 92, 55, 1, 226.98),
(157, 35, 56, 4, 641.32),
(158, 35, 56, 4, 641.32),
(159, 38, 56, 3, 474.48),
(160, 14, 56, 3, 822.57),
(161, 31, 56, 2, 271.78),
(162, 17, 57, 1, 281.28),
(163, 38, 58, 1, 158.16),
(164, 20, 59, 1, 448.42),
(165, 94, 59, 1, 160.34),
(166, 111, 60, 4, 1340.2),
(167, 4, 60, 5, 2032),
(168, 21, 60, 3, 1256.73),
(169, 52, 61, 5, 2085.4),
(170, 41, 61, 1, 245.38),
(171, 15, 62, 1, 60.58),
(172, 29, 62, 2, 921.08),
(173, 68, 62, 2, 373.36),
(174, 79, 63, 4, 294.88),
(175, 120, 63, 4, 1648.96),
(176, 105, 63, 4, 409.52),
(177, 114, 63, 3, 1281.15),
(178, 84, 64, 2, 394.32),
(179, 34, 64, 2, 953.42),
(180, 59, 64, 2, 891.96),
(181, 26, 64, 4, 1728.16),
(182, 81, 65, 2, 53.14),
(183, 53, 65, 1, 70.61),
(184, 68, 65, 4, 746.72),
(185, 73, 65, 1, 213.66),
(186, 99, 66, 1, 355.3),
(187, 109, 66, 2, 466.64),
(188, 56, 66, 1, 152.37),
(189, 13, 67, 1, 240.57),
(190, 56, 68, 1, 152.37),
(191, 89, 68, 1, 387.15),
(192, 125, 69, 3, 714.03),
(193, 101, 69, 1, 420.43),
(194, 24, 69, 5, 1795.35),
(195, 26, 70, 5, 2160.2),
(196, 45, 70, 1, 224.04),
(197, 117, 71, 4, 1085.56),
(198, 21, 71, 4, 1675.64),
(199, 25, 71, 3, 165.03),
(200, 125, 72, 3, 714.03),
(201, 13, 73, 1, 240.57),
(202, 68, 73, 1, 186.68),
(203, 3, 73, 5, 79.7),
(204, 91, 74, 1, 87.51),
(205, 36, 75, 1, 265.62),
(206, 72, 75, 3, 1342.8),
(207, 74, 76, 3, 93.27),
(208, 11, 76, 5, 1962.65),
(209, 99, 76, 4, 1421.2),
(210, 94, 77, 1, 160.34),
(211, 84, 77, 5, 985.8),
(212, 14, 77, 5, 1370.95),
(213, 85, 78, 5, 2161.4),
(214, 123, 78, 5, 1176.65),
(215, 67, 78, 4, 1551.4),
(216, 34, 79, 5, 2383.55),
(217, 59, 80, 5, 2229.9),
(218, 68, 80, 3, 560.04),
(219, 98, 81, 5, 2480.6),
(220, 1, 82, 3, 1092.15),
(221, 120, 83, 3, 1236.72),
(222, 64, 83, 1, 47.39),
(223, 101, 83, 4, 1681.72),
(224, 11, 83, 1, 392.53),
(225, 38, 83, 4, 632.64),
(226, 55, 84, 3, 381),
(227, 99, 85, 1, 355.3),
(228, 117, 85, 4, 1085.56),
(229, 98, 86, 5, 2480.6),
(230, 97, 86, 2, 516.56),
(231, 40, 86, 4, 1017.32),
(232, 87, 87, 4, 687.44),
(233, 78, 87, 5, 2284.55),
(234, 1, 87, 4, 1456.2),
(235, 35, 87, 1, 160.33),
(236, 109, 88, 1, 233.32),
(237, 47, 88, 3, 343.29),
(238, 59, 88, 1, 445.98),
(239, 82, 89, 3, 960.96),
(240, 4, 89, 2, 812.8),
(241, 67, 89, 2, 775.7),
(242, 19, 89, 3, 1396.77),
(243, 57, 90, 2, 60.22),
(244, 50, 90, 2, 349.28),
(245, 13, 90, 2, 481.14),
(246, 68, 91, 3, 560.04),
(247, 82, 91, 4, 1281.28),
(248, 86, 91, 3, 107.19),
(249, 94, 91, 4, 641.36),
(250, 69, 92, 3, 156.06),
(251, 19, 92, 2, 931.18),
(252, 95, 92, 3, 1248.78),
(253, 88, 92, 3, 1359.03),
(254, 8, 92, 3, 111.21),
(255, 118, 93, 5, 1729.25),
(256, 70, 93, 2, 237.32),
(257, 121, 94, 2, 328.08),
(258, 31, 94, 5, 679.45),
(259, 43, 94, 4, 1036),
(260, 17, 95, 5, 1406.4),
(261, 89, 95, 1, 387.15),
(262, 115, 95, 2, 458.88),
(263, 91, 95, 3, 262.53),
(264, 104, 95, 3, 764.37),
(265, 56, 96, 3, 457.11),
(266, 48, 96, 2, 211.78),
(267, 45, 96, 5, 1120.2),
(268, 126, 97, 2, 814.02),
(269, 50, 97, 5, 873.2),
(270, 73, 98, 5, 1068.3),
(271, 24, 99, 3, 1077.21),
(272, 73, 99, 4, 854.64),
(273, 112, 99, 4, 245.28),
(274, 78, 99, 1, 456.91),
(275, 36, 100, 3, 796.86),
(276, 40, 100, 1, 254.33),
(277, 83, 100, 2, 940.28),
(278, 64, 100, 3, 142.17),
(279, 7, 100, 4, 1519.4),
(280, 35, 101, 2, 320.66),
(281, 46, 102, 5, 316.65),
(282, 5, 102, 3, 391.47),
(283, 80, 102, 1, 354.5),
(284, 119, 102, 2, 964.42),
(285, 116, 103, 4, 1436.44),
(286, 37, 103, 4, 1061.36),
(287, 80, 103, 2, 709),
(288, 42, 103, 1, 442.92),
(289, 42, 104, 5, 2214.6),
(290, 1, 104, 1, 364.05),
(291, 107, 104, 3, 350.49),
(292, 82, 105, 2, 640.64),
(293, 1, 105, 4, 1456.2),
(294, 114, 105, 3, 1281.15),
(295, 65, 105, 2, 109.2),
(296, 95, 106, 5, 2081.3),
(297, 28, 106, 1, 220.68),
(298, 111, 106, 3, 1005.15),
(299, 78, 106, 3, 1370.73),
(300, 122, 106, 3, 70.56),
(301, 14, 107, 3, 822.57),
(302, 28, 107, 5, 1103.4),
(303, 31, 108, 4, 543.56),
(304, 74, 108, 2, 62.18),
(305, 113, 109, 3, 1339.23),
(306, 55, 109, 2, 254),
(307, 99, 109, 4, 1421.2),
(308, 116, 109, 4, 1436.44),
(309, 10, 109, 2, 20.56),
(310, 39, 110, 4, 1714.56),
(311, 74, 110, 2, 62.18),
(312, 88, 110, 5, 2265.05),
(313, 10, 111, 4, 41.12),
(314, 48, 111, 1, 105.89),
(315, 87, 112, 3, 515.58),
(316, 54, 112, 2, 316.16),
(317, 87, 112, 2, 343.72),
(318, 1, 112, 3, 1092.15),
(319, 86, 113, 5, 178.65),
(320, 92, 113, 5, 1134.9),
(321, 26, 114, 1, 432.04),
(322, 62, 115, 4, 1364.84),
(323, 5, 115, 3, 391.47),
(324, 101, 115, 1, 420.43),
(325, 13, 115, 2, 481.14),
(326, 89, 116, 2, 774.3),
(327, 24, 116, 2, 718.14),
(328, 15, 116, 2, 121.16),
(329, 104, 116, 4, 1019.16),
(330, 115, 117, 4, 917.76),
(331, 93, 117, 4, 1517.72),
(332, 55, 117, 4, 508),
(333, 59, 117, 1, 445.98),
(334, 101, 117, 1, 420.43),
(335, 42, 118, 1, 442.92),
(336, 36, 119, 3, 796.86),
(337, 118, 119, 2, 691.7),
(338, 46, 120, 1, 63.33),
(339, 105, 120, 2, 204.76),
(340, 44, 120, 3, 267.21),
(341, 74, 121, 3, 93.27),
(342, 14, 121, 4, 1096.76),
(343, 11, 121, 3, 1177.59),
(344, 5, 121, 3, 391.47),
(345, 42, 121, 2, 885.84),
(346, 64, 122, 1, 47.39),
(347, 47, 123, 1, 114.43),
(348, 1, 124, 3, 1092.15),
(349, 18, 124, 4, 954.24),
(350, 57, 124, 2, 60.22),
(351, 54, 124, 5, 790.4),
(352, 106, 125, 1, 150.48),
(353, 80, 125, 3, 1063.5),
(354, 43, 125, 4, 1036),
(355, 44, 126, 5, 445.35),
(356, 60, 126, 2, 377.06),
(357, 4, 126, 2, 812.8),
(358, 42, 126, 3, 1328.76),
(359, 98, 127, 3, 1488.36),
(360, 80, 127, 4, 1418),
(361, 7, 127, 2, 759.7),
(362, 55, 128, 3, 381),
(363, 71, 129, 1, 272.31),
(364, 89, 129, 1, 387.15),
(365, 3, 129, 3, 47.82),
(366, 101, 130, 1, 420.43),
(367, 76, 130, 1, 357.14),
(368, 106, 130, 3, 451.44),
(369, 69, 130, 1, 52.02),
(370, 99, 131, 2, 710.6),
(371, 109, 131, 3, 699.96),
(372, 30, 131, 2, 344.04),
(373, 40, 132, 3, 762.99),
(374, 70, 132, 4, 474.64),
(375, 107, 132, 4, 467.32),
(376, 61, 132, 4, 466.24),
(377, 103, 132, 4, 1737.12),
(378, 53, 133, 4, 282.44),
(379, 78, 133, 2, 913.82),
(380, 123, 133, 4, 941.32),
(381, 126, 134, 3, 1221.03),
(382, 100, 134, 4, 727.84),
(383, 97, 134, 1, 258.28),
(384, 113, 135, 5, 2232.05),
(385, 35, 136, 5, 801.65),
(386, 62, 136, 5, 1706.05),
(387, 23, 136, 1, 305.15),
(388, 90, 136, 1, 45.18),
(389, 101, 137, 3, 1261.29),
(390, 53, 137, 2, 141.22),
(391, 79, 137, 5, 368.6),
(392, 12, 137, 2, 204.34),
(393, 51, 138, 2, 108.9),
(394, 56, 138, 1, 152.37),
(395, 11, 138, 5, 1962.65),
(396, 76, 139, 1, 357.14),
(397, 126, 139, 2, 814.02),
(398, 38, 139, 4, 632.64),
(399, 106, 139, 3, 451.44),
(400, 90, 140, 4, 180.72),
(401, 89, 140, 4, 1548.6),
(402, 32, 141, 2, 310.96),
(403, 98, 141, 5, 2480.6),
(404, 66, 142, 3, 797.1),
(405, 113, 142, 2, 892.82),
(406, 51, 142, 5, 272.25),
(407, 50, 143, 2, 349.28),
(408, 107, 143, 1, 116.83),
(409, 93, 143, 4, 1517.72),
(410, 24, 143, 5, 1795.35),
(411, 30, 143, 4, 688.08),
(412, 121, 144, 3, 492.12),
(413, 83, 144, 2, 940.28),
(414, 57, 144, 5, 150.55),
(415, 109, 145, 1, 233.32),
(416, 100, 146, 2, 363.92),
(417, 64, 146, 5, 236.95),
(418, 45, 147, 5, 1120.2),
(419, 57, 148, 2, 60.22),
(420, 100, 149, 5, 909.8),
(421, 96, 149, 4, 1688.48),
(422, 88, 149, 3, 1359.03),
(423, 29, 149, 1, 460.54),
(424, 103, 149, 4, 1737.12),
(425, 121, 150, 5, 820.2),
(426, 23, 150, 3, 915.45),
(427, 37, 150, 2, 530.68),
(428, 86, 151, 1, 35.73),
(429, 29, 151, 2, 921.08),
(430, 28, 151, 3, 662.04),
(431, 25, 151, 1, 55.01),
(432, 104, 152, 2, 509.58),
(433, 122, 153, 2, 47.04),
(434, 64, 153, 3, 142.17),
(435, 54, 154, 1, 158.08),
(436, 81, 154, 3, 79.71),
(437, 51, 154, 4, 217.8),
(438, 119, 154, 2, 964.42),
(439, 59, 155, 1, 445.98),
(440, 96, 155, 2, 844.24),
(441, 34, 155, 4, 1906.84),
(442, 60, 155, 3, 565.59),
(443, 82, 155, 5, 1601.6),
(444, 9, 156, 4, 189.4),
(445, 78, 156, 3, 1370.73),
(446, 52, 156, 2, 834.16),
(447, 34, 156, 3, 1430.13),
(448, 101, 156, 2, 840.86),
(449, 46, 157, 1, 63.33),
(450, 120, 158, 1, 412.24),
(451, 87, 158, 5, 859.3),
(452, 124, 158, 5, 2180.5),
(453, 25, 158, 3, 165.03),
(454, 106, 159, 3, 451.44),
(455, 6, 159, 2, 194.52),
(456, 44, 159, 1, 89.07),
(457, 55, 159, 2, 254),
(458, 94, 159, 1, 160.34),
(459, 16, 160, 5, 1216.8),
(460, 84, 160, 5, 985.8),
(461, 65, 161, 1, 54.6),
(462, 101, 161, 3, 1261.29),
(463, 57, 161, 5, 150.55),
(464, 43, 162, 3, 777),
(465, 12, 162, 5, 510.85),
(466, 55, 162, 2, 254),
(467, 61, 163, 1, 116.56),
(468, 5, 164, 3, 391.47),
(469, 64, 164, 4, 189.56),
(470, 91, 164, 5, 437.55),
(471, 14, 165, 2, 548.38),
(472, 51, 165, 4, 217.8),
(473, 27, 165, 3, 827.04),
(474, 80, 165, 3, 1063.5),
(475, 36, 166, 2, 531.24),
(476, 115, 166, 3, 688.32),
(477, 1, 166, 4, 1456.2),
(478, 72, 166, 1, 447.6),
(479, 121, 166, 2, 328.08),
(480, 3, 167, 3, 47.82),
(481, 58, 167, 4, 1939.88),
(482, 25, 167, 5, 275.05),
(483, 26, 167, 3, 1296.12),
(484, 23, 168, 2, 610.3),
(485, 12, 168, 4, 408.68),
(486, 108, 168, 3, 822.51),
(487, 110, 168, 5, 369.1),
(488, 63, 169, 4, 1117.28),
(489, 10, 169, 3, 30.84),
(490, 119, 169, 5, 2411.05),
(491, 102, 170, 4, 97.16),
(492, 36, 170, 3, 796.86),
(493, 122, 171, 5, 117.6),
(494, 92, 171, 2, 453.96),
(495, 9, 171, 3, 142.05),
(496, 25, 171, 4, 220.04),
(497, 38, 172, 5, 790.8),
(498, 67, 172, 4, 1551.4),
(499, 53, 172, 5, 353.05),
(500, 90, 172, 1, 45.18),
(501, 91, 172, 4, 350.04),
(502, 1, 173, 3, 1092.15),
(503, 59, 173, 3, 1337.94),
(504, 99, 174, 5, 1776.5),
(505, 33, 174, 1, 93.41),
(506, 105, 175, 2, 204.76),
(507, 111, 175, 2, 670.1),
(508, 8, 175, 5, 185.35),
(509, 119, 175, 3, 1446.63),
(510, 6, 175, 4, 389.04),
(511, 96, 176, 1, 422.12),
(512, 119, 177, 3, 1446.63),
(513, 21, 177, 2, 837.82),
(514, 79, 177, 2, 147.44),
(515, 19, 177, 4, 1862.36),
(516, 126, 177, 5, 2035.05),
(517, 35, 178, 2, 320.66),
(518, 42, 179, 1, 442.92),
(519, 70, 179, 1, 118.66),
(520, 49, 179, 1, 103.16),
(521, 38, 179, 5, 790.8),
(522, 62, 180, 5, 1706.05),
(523, 19, 180, 3, 1396.77),
(524, 101, 181, 4, 1681.72),
(525, 114, 181, 3, 1281.15),
(526, 103, 181, 5, 2171.4),
(527, 109, 181, 2, 466.64),
(528, 14, 182, 2, 548.38),
(529, 30, 182, 2, 344.04),
(530, 94, 182, 2, 320.68),
(531, 45, 183, 3, 672.12),
(532, 22, 183, 3, 966.42),
(533, 21, 183, 4, 1675.64),
(534, 22, 184, 1, 322.14),
(535, 86, 184, 5, 178.65),
(536, 85, 184, 4, 1729.12),
(537, 121, 184, 3, 492.12),
(538, 97, 184, 1, 258.28),
(539, 43, 185, 4, 1036),
(540, 84, 185, 4, 788.64),
(541, 108, 185, 4, 1096.68),
(542, 20, 185, 1, 448.42),
(543, 101, 186, 1, 420.43),
(544, 46, 186, 4, 253.32),
(545, 40, 187, 5, 1271.65),
(546, 100, 187, 1, 181.96),
(547, 58, 187, 2, 969.94),
(548, 29, 187, 1, 460.54),
(549, 65, 188, 1, 54.6),
(550, 15, 188, 2, 121.16),
(551, 94, 188, 5, 801.7),
(552, 94, 189, 4, 641.36),
(553, 4, 190, 1, 406.4),
(554, 49, 190, 4, 412.64),
(555, 51, 190, 1, 54.45),
(556, 96, 191, 2, 844.24),
(557, 14, 192, 5, 1370.95),
(558, 56, 193, 5, 761.85),
(559, 13, 193, 2, 481.14),
(560, 92, 193, 2, 453.96),
(561, 13, 194, 4, 962.28),
(562, 68, 194, 5, 933.4),
(563, 32, 194, 1, 155.48),
(564, 55, 194, 3, 381),
(565, 54, 195, 5, 790.4),
(566, 50, 195, 4, 698.56),
(567, 9, 195, 4, 189.4),
(568, 8, 196, 5, 185.35),
(569, 3, 196, 4, 63.76),
(570, 119, 196, 1, 482.21),
(571, 18, 197, 3, 715.68),
(572, 44, 197, 1, 89.07),
(573, 71, 197, 3, 816.93),
(574, 28, 198, 3, 662.04),
(575, 80, 198, 3, 1063.5),
(576, 11, 199, 1, 392.53),
(577, 33, 199, 3, 280.23),
(578, 60, 200, 1, 188.53),
(579, 60, 200, 2, 377.06),
(580, 90, 200, 3, 135.54),
(581, 2, 201, 2, 170.56),
(582, 94, 201, 5, 801.7),
(583, 103, 201, 5, 2171.4),
(584, 54, 201, 3, 474.24),
(585, 12, 202, 3, 306.51),
(586, 34, 202, 1, 476.71),
(587, 32, 202, 3, 466.44),
(588, 103, 202, 3, 1302.84),
(589, 40, 202, 4, 1017.32),
(590, 116, 203, 2, 718.22),
(591, 28, 204, 3, 662.04),
(592, 59, 204, 2, 891.96),
(593, 6, 204, 1, 97.26),
(594, 50, 204, 3, 523.92),
(595, 115, 205, 2, 458.88),
(596, 21, 205, 4, 1675.64),
(597, 114, 205, 1, 427.05),
(598, 82, 206, 5, 1601.6),
(599, 126, 206, 3, 1221.03),
(600, 108, 206, 1, 274.17),
(601, 34, 206, 2, 953.42),
(602, 110, 207, 4, 295.28),
(603, 37, 207, 5, 1326.7),
(604, 36, 207, 1, 265.62),
(605, 51, 207, 1, 54.45),
(606, 91, 208, 3, 262.53),
(607, 47, 208, 2, 228.86),
(608, 29, 209, 1, 460.54),
(609, 28, 209, 1, 220.68),
(610, 10, 209, 5, 51.4),
(611, 40, 209, 3, 762.99),
(612, 65, 209, 3, 163.8),
(613, 67, 210, 3, 1163.55),
(614, 126, 210, 1, 407.01),
(615, 111, 210, 2, 670.1),
(616, 122, 211, 4, 94.08),
(617, 6, 211, 2, 194.52),
(618, 104, 211, 5, 1273.95),
(619, 24, 212, 4, 1436.28),
(620, 125, 212, 4, 952.04),
(621, 1, 213, 4, 1456.2),
(622, 27, 214, 4, 1102.72),
(623, 102, 214, 5, 121.45),
(624, 119, 215, 4, 1928.84),
(625, 126, 215, 3, 1221.03),
(626, 123, 216, 3, 705.99),
(627, 9, 216, 2, 94.7),
(628, 101, 217, 5, 2102.15),
(629, 65, 217, 5, 273),
(630, 45, 217, 2, 448.08),
(631, 32, 218, 3, 466.44),
(632, 42, 218, 2, 885.84),
(633, 8, 219, 5, 185.35),
(634, 101, 219, 1, 420.43),
(635, 84, 219, 1, 197.16),
(636, 47, 219, 4, 457.72),
(637, 9, 219, 4, 189.4),
(638, 88, 220, 3, 1359.03),
(639, 118, 220, 2, 691.7),
(640, 50, 220, 1, 174.64),
(641, 107, 221, 2, 233.66),
(642, 20, 221, 4, 1793.68),
(643, 2, 221, 4, 341.12),
(644, 111, 221, 3, 1005.15),
(645, 110, 221, 2, 147.64),
(646, 30, 222, 3, 516.06),
(647, 126, 222, 1, 407.01),
(648, 110, 222, 4, 295.28),
(649, 8, 222, 4, 148.28),
(650, 76, 222, 4, 1428.56),
(651, 42, 223, 1, 442.92),
(652, 124, 223, 1, 436.1),
(653, 103, 223, 2, 868.56),
(654, 53, 223, 5, 353.05),
(655, 90, 224, 3, 135.54),
(656, 65, 224, 5, 273),
(657, 31, 224, 2, 271.78),
(658, 64, 224, 1, 47.39),
(659, 32, 225, 1, 155.48),
(660, 118, 225, 5, 1729.25),
(661, 20, 225, 4, 1793.68),
(662, 12, 225, 4, 408.68),
(663, 101, 225, 2, 840.86),
(664, 93, 226, 1, 379.43),
(665, 37, 227, 3, 796.02),
(666, 53, 227, 5, 353.05),
(667, 33, 227, 3, 280.23),
(668, 63, 227, 2, 558.64),
(669, 20, 227, 4, 1793.68),
(670, 78, 228, 5, 2284.55),
(671, 62, 228, 5, 1706.05),
(672, 85, 228, 3, 1296.84),
(673, 9, 228, 1, 47.35),
(674, 22, 229, 3, 966.42),
(675, 120, 229, 2, 824.48),
(676, 30, 229, 3, 516.06),
(677, 36, 229, 4, 1062.48),
(678, 46, 230, 5, 316.65),
(679, 22, 230, 1, 322.14),
(680, 62, 230, 3, 1023.63),
(681, 24, 231, 2, 718.14),
(682, 56, 231, 1, 152.37),
(683, 103, 231, 4, 1737.12),
(684, 122, 231, 1, 23.52),
(685, 88, 232, 4, 1812.04),
(686, 107, 232, 4, 467.32),
(687, 79, 232, 5, 368.6),
(688, 108, 232, 5, 1370.85),
(689, 33, 233, 2, 186.82),
(690, 67, 233, 5, 1939.25),
(691, 81, 233, 2, 53.14),
(692, 30, 233, 1, 172.02),
(693, 7, 234, 3, 1139.55),
(694, 54, 234, 1, 158.08),
(695, 92, 234, 2, 453.96),
(696, 51, 234, 2, 108.9),
(697, 26, 234, 3, 1296.12),
(698, 42, 235, 2, 885.84),
(699, 81, 235, 4, 106.28),
(700, 108, 236, 3, 822.51),
(701, 33, 237, 1, 93.41),
(702, 21, 237, 4, 1675.64),
(703, 86, 237, 5, 178.65),
(704, 81, 237, 2, 53.14),
(705, 111, 237, 5, 1675.25),
(706, 105, 238, 1, 102.38),
(707, 107, 238, 3, 350.49),
(708, 45, 239, 2, 448.08),
(709, 87, 239, 4, 687.44),
(710, 8, 240, 5, 185.35),
(711, 4, 240, 5, 2032),
(712, 53, 240, 5, 353.05),
(713, 111, 240, 5, 1675.25),
(714, 82, 240, 2, 640.64),
(715, 11, 241, 4, 1570.12),
(716, 34, 242, 2, 953.42),
(717, 99, 243, 2, 710.6),
(718, 123, 243, 2, 470.66),
(719, 26, 243, 5, 2160.2),
(720, 77, 243, 2, 169.8),
(721, 84, 244, 4, 788.64),
(722, 4, 245, 5, 2032),
(723, 105, 245, 3, 307.14),
(724, 21, 245, 5, 2094.55),
(725, 75, 246, 3, 1295.22),
(726, 21, 246, 3, 1256.73),
(727, 91, 246, 1, 87.51),
(728, 104, 247, 2, 509.58),
(729, 75, 247, 5, 2158.7),
(730, 34, 247, 2, 953.42),
(731, 95, 248, 4, 1665.04),
(732, 67, 248, 4, 1551.4),
(733, 14, 248, 1, 274.19),
(734, 35, 248, 1, 160.33),
(735, 34, 249, 3, 1430.13),
(736, 85, 249, 1, 432.28),
(737, 113, 249, 5, 2232.05),
(738, 72, 250, 1, 447.6),
(739, 123, 250, 4, 941.32),
(740, 102, 250, 2, 48.58),
(741, 95, 251, 2, 832.52),
(742, 116, 251, 3, 1077.33),
(743, 11, 251, 2, 785.06),
(744, 27, 252, 4, 1102.72),
(745, 116, 252, 2, 718.22),
(746, 26, 252, 5, 2160.2),
(747, 82, 252, 3, 960.96),
(748, 58, 252, 1, 484.97),
(749, 42, 253, 1, 442.92),
(750, 16, 253, 3, 730.08),
(751, 51, 253, 1, 54.45),
(752, 90, 253, 1, 45.18),
(753, 92, 254, 2, 453.96),
(754, 81, 255, 1, 26.57),
(755, 105, 255, 4, 409.52),
(756, 41, 255, 3, 736.14),
(757, 74, 255, 5, 155.45),
(758, 71, 255, 1, 272.31),
(759, 9, 256, 4, 189.4),
(760, 73, 256, 3, 640.98),
(761, 11, 256, 1, 392.53),
(762, 108, 256, 4, 1096.68),
(763, 79, 257, 2, 147.44),
(764, 93, 257, 5, 1897.15),
(765, 104, 257, 1, 254.79),
(766, 47, 257, 3, 343.29),
(767, 47, 257, 3, 343.29),
(768, 42, 258, 2, 885.84),
(769, 44, 259, 5, 445.35),
(770, 3, 259, 3, 47.82),
(771, 118, 259, 3, 1037.55),
(772, 26, 260, 2, 864.08),
(773, 26, 260, 2, 864.08),
(774, 41, 260, 1, 245.38),
(775, 36, 261, 1, 265.62),
(776, 68, 262, 3, 560.04),
(777, 119, 262, 4, 1928.84),
(778, 25, 262, 4, 220.04),
(779, 5, 262, 1, 130.49),
(780, 40, 262, 1, 254.33),
(781, 97, 263, 3, 774.84),
(782, 20, 263, 2, 896.84),
(783, 100, 263, 5, 909.8),
(784, 81, 264, 2, 53.14),
(785, 73, 264, 2, 427.32),
(786, 126, 264, 3, 1221.03),
(787, 109, 264, 5, 1166.6),
(788, 106, 264, 3, 451.44),
(789, 27, 265, 1, 275.68),
(790, 33, 266, 5, 467.05),
(791, 48, 267, 4, 423.56),
(792, 54, 267, 4, 632.32),
(793, 103, 267, 3, 1302.84),
(794, 17, 268, 4, 1125.12),
(795, 92, 269, 1, 226.98),
(796, 85, 269, 3, 1296.84),
(797, 45, 269, 4, 896.16),
(798, 1, 270, 100, 200),
(799, 11, 271, 4, 920),
(800, 64, 271, 2, 400),
(801, 3, 271, 2, 1180),
(802, 6, 272, 3, 750),
(803, 1, 273, 5, 450),
(804, 5, 274, 4, 400),
(805, 5, 274, 4, 400),
(806, 10, 274, 1, 230),
(807, 12, 274, 1, 220),
(808, 12, 275, 1, 220),
(809, 2, 275, 1, 40),
(810, 33, 275, 4, 20),
(811, 121, 276, 1, 120),
(812, 118, 276, 1, 120),
(813, 106, 276, 3, 1200),
(814, 1, 277, 7, 630),
(815, 32, 278, 23, 46),
(816, 6, 278, 4, 1000),
(817, 4, 278, 5, 200),
(818, 110, 279, 15, 825),
(819, 9, 280, 1, 255),
(820, 3, 281, 4, 160),
(821, 10, 281, 3, 690),
(822, 1, 281, 3, 270),
(823, 21, 282, 3, 690),
(824, 35, 282, 1, 30),
(825, 48, 282, 3, 210),
(826, 70, 282, 4, 560),
(827, 90, 282, 3, 660),
(828, 1, 283, 1, 90),
(829, 1, 284, 3, 660),
(832, 2, 287, 3, 120),
(833, 2, 288, 3, 120),
(834, 123, 289, 5, 350),
(835, 1, 290, 3, 120),
(836, 3, 290, 4, 860),
(837, 1, 291, 1, 90),
(838, 2, 291, 1, 40),
(839, 3, 291, 3, 120),
(840, 13, 292, 3, 630),
(841, 5, 292, 2, 200),
(842, 3, 292, 1, 40);

--
-- Triggers `sales`
--
DELIMITER $$
CREATE TRIGGER `reduce_stock` AFTER INSERT ON `sales` FOR EACH ROW BEGIN
    UPDATE products
    SET quantity = quantity - NEW.quantity_sold
    WHERE product_id = NEW.product_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_sales_after_delete` AFTER DELETE ON `sales` FOR EACH ROW BEGIN
  INSERT INTO audit_log VALUES
    (NULL, 'sales', 'DELETE', OLD.sales_id, 'product_id', OLD.product_id, NULL, @user, NOW()),
    (NULL, 'sales', 'DELETE', OLD.sales_id, 'invoice_id', OLD.invoice_id, NULL, @user, NOW()),
    (NULL, 'sales', 'DELETE', OLD.sales_id, 'quantity_sold', OLD.quantity_sold, NULL, @user, NOW()),
    (NULL, 'sales', 'DELETE', OLD.sales_id, 'purchase_sale', OLD.purchase_sale, NULL, @user, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_sales_after_insert` AFTER INSERT ON `sales` FOR EACH ROW BEGIN
  INSERT INTO audit_log VALUES
    (NULL, 'sales', 'INSERT', NEW.sales_id, 'product_id', NULL, NEW.product_id, @user, NOW()),
    (NULL, 'sales', 'INSERT', NEW.sales_id, 'invoice_id', NULL, NEW.invoice_id, @user, NOW()),
    (NULL, 'sales', 'INSERT', NEW.sales_id, 'quantity_sold', NULL, NEW.quantity_sold, @user, NOW()),
    (NULL, 'sales', 'INSERT', NEW.sales_id, 'purchase_sale', NULL, NEW.purchase_sale, @user, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_sales_after_update` AFTER UPDATE ON `sales` FOR EACH ROW BEGIN
  IF NOT (OLD.product_id <=> NEW.product_id) THEN
    INSERT INTO audit_log VALUES (NULL, 'sales', 'UPDATE', NEW.sales_id, 'product_id', OLD.product_id, NEW.product_id, @user, NOW());
  END IF;

  IF NOT (OLD.invoice_id <=> NEW.invoice_id) THEN
    INSERT INTO audit_log VALUES (NULL, 'sales', 'UPDATE', NEW.sales_id, 'invoice_id', OLD.invoice_id, NEW.invoice_id, @user, NOW());
  END IF;

  IF NOT (OLD.quantity_sold <=> NEW.quantity_sold) THEN
    INSERT INTO audit_log VALUES (NULL, 'sales', 'UPDATE', NEW.sales_id, 'quantity_sold', OLD.quantity_sold, NEW.quantity_sold, @user, NOW());
  END IF;

  IF NOT (OLD.purchase_sale <=> NEW.purchase_sale) THEN
    INSERT INTO audit_log VALUES (NULL, 'sales', 'UPDATE', NEW.sales_id, 'purchase_sale', OLD.purchase_sale, NEW.purchase_sale, @user, NOW());
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `fname` varchar(50) NOT NULL,
  `mname` varchar(50) NOT NULL,
  `surname` varchar(50) NOT NULL,
  `contact_num` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `fname`, `mname`, `surname`, `contact_num`, `email`, `password`) VALUES
(1, 'joyjeffrey', 'Joy Jeffrey', 'Laguardia', 'Abellera', '09972217095', 'joyjeffreyabellera@gmail.com', '$2a$10$MLGXu70asMoMy/QO25OjVe.AzYJFGblrzXMm//Maw81b6bGsg9Z0u'),
(2, 'jared', 'Jared Jeffrey', 'Anciado', 'Abellera', '09694465890', 'jaredabellera@gmail.com', '$2a$10$cPGxHG3RD5Y0mTkOJlvhXO4BfgIEvRyuvP6dGosI036AzM7BYXynG');

--
-- Triggers `users`
--
DELIMITER $$
CREATE TRIGGER `trg_users_after_delete` AFTER DELETE ON `users` FOR EACH ROW BEGIN
  INSERT INTO audit_log VALUES
    (NULL, 'users', 'DELETE', OLD.user_id, 'username', OLD.username, NULL, @user, NOW()),
    (NULL, 'users', 'DELETE', OLD.user_id, 'fname', OLD.fname, NULL, @user, NOW()),
    (NULL, 'users', 'DELETE', OLD.user_id, 'mname', OLD.mname, NULL, @user, NOW()),
    (NULL, 'users', 'DELETE', OLD.user_id, 'surname', OLD.surname, NULL, @user, NOW()),
    (NULL, 'users', 'DELETE', OLD.user_id, 'contact_num', OLD.contact_num, NULL, @user, NOW()),
    (NULL, 'users', 'DELETE', OLD.user_id, 'email', OLD.email, NULL, @user, NOW()),
    (NULL, 'users', 'DELETE', OLD.user_id, 'password', 'Deleted', NULL, @user, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_users_after_insert` AFTER INSERT ON `users` FOR EACH ROW BEGIN
  INSERT INTO audit_log VALUES
    (NULL, 'users', 'INSERT', NEW.user_id, 'username', NULL, NEW.username, @user, NOW()),
    (NULL, 'users', 'INSERT', NEW.user_id, 'fname', NULL, NEW.fname, @user, NOW()),
    (NULL, 'users', 'INSERT', NEW.user_id, 'mname', NULL, NEW.mname, @user, NOW()),
    (NULL, 'users', 'INSERT', NEW.user_id, 'surname', NULL, NEW.surname, @user, NOW()),
    (NULL, 'users', 'INSERT', NEW.user_id, 'contact_num', NULL, NEW.contact_num, @user, NOW()),
    (NULL, 'users', 'INSERT', NEW.user_id, 'email', NULL, NEW.email, @user, NOW()),
    (NULL, 'users', 'INSERT', NEW.user_id, 'password', NULL, 'Created', @user, NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_users_after_update` AFTER UPDATE ON `users` FOR EACH ROW BEGIN
  IF NOT (OLD.username <=> NEW.username) THEN
    INSERT INTO audit_log VALUES (NULL, 'users', 'UPDATE', NEW.user_id, 'username', OLD.username, NEW.username, @user, NOW());
  END IF;

  IF NOT (OLD.fname <=> NEW.fname) THEN
    INSERT INTO audit_log VALUES (NULL, 'users', 'UPDATE', NEW.user_id, 'fname', OLD.fname, NEW.fname, @user, NOW());
  END IF;

  IF NOT (OLD.mname <=> NEW.mname) THEN
    INSERT INTO audit_log VALUES (NULL, 'users', 'UPDATE', NEW.user_id, 'mname', OLD.mname, NEW.mname, @user, NOW());
  END IF;

  IF NOT (OLD.surname <=> NEW.surname) THEN
    INSERT INTO audit_log VALUES (NULL, 'users', 'UPDATE', NEW.user_id, 'surname', OLD.surname, NEW.surname, @user, NOW());
  END IF;

  IF NOT (OLD.contact_num <=> NEW.contact_num) THEN
    INSERT INTO audit_log VALUES (NULL, 'users', 'UPDATE', NEW.user_id, 'contact_num', OLD.contact_num, NEW.contact_num, @user, NOW());
  END IF;

  IF NOT (OLD.email <=> NEW.email) THEN
    INSERT INTO audit_log VALUES (NULL, 'users', 'UPDATE', NEW.user_id, 'email', OLD.email, NEW.email, @user, NOW());
  END IF;

  IF NOT (OLD.password <=> NEW.password) THEN
    INSERT INTO audit_log VALUES (NULL, 'users', 'UPDATE', NEW.user_id, 'password', 'Changed', 'Changed', @user, NOW());
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure for view `newsales`
--
DROP TABLE IF EXISTS `newsales`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `newsales`  AS SELECT `s`.`invoice_id` AS `invoice_id`, `p`.`product_name` AS `product_name`, `p`.`additional_name` AS `additional_name`, `p`.`type` AS `type`, `p`.`brand` AS `brand`, `p`.`price` AS `price`, `s`.`quantity_sold` AS `quantity_sold`, `s`.`purchase_sale` AS `purchase_sale` FROM (`sales` `s` join `products` `p` on(`s`.`product_id` = `p`.`product_id`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `audit_log`
--
ALTER TABLE `audit_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`invoice_id`);

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
  ADD KEY `sales_to_invoice` (`invoice_id`),
  ADD KEY `sales_to_product` (`product_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `audit_log`
--
ALTER TABLE `audit_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=219;

--
-- AUTO_INCREMENT for table `invoice`
--
ALTER TABLE `invoice`
  MODIFY `invoice_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=293;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=132;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `sales_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=843;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_to_invoice` FOREIGN KEY (`invoice_id`) REFERENCES `invoice` (`invoice_id`),
  ADD CONSTRAINT `sales_to_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
