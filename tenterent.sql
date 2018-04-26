-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 26, 2018 at 11:37 AM
-- Server version: 5.7.14
-- PHP Version: 5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tenterent`
--
CREATE DATABASE IF NOT EXISTS `tenterent` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `tenterent`;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL,
  `admin_name` varchar(45) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `admin_name`, `username`, `password`) VALUES
(1, 'Jan Rei Sibaen', 'JRSibaen', 'something');

-- --------------------------------------------------------

--
-- Table structure for table `client`
--

CREATE TABLE `client` (
  `client_id` int(11) NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `address1` varchar(45) NOT NULL,
  `address2` varchar(45) DEFAULT NULL,
  `email` varchar(45) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `contact_number` varchar(45) NOT NULL,
  `registered` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `client`
--

INSERT INTO `client` (`client_id`, `first_name`, `last_name`, `address1`, `address2`, `email`, `username`, `password`, `contact_number`, `registered`) VALUES
(1, 'Jan', 'Sib', 'Baguio', NULL, 'jan@yahoo.com', 'JRSib', 'something', '555', 1);

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `item_id` int(11) NOT NULL,
  `item_name` varchar(45) NOT NULL,
  `price` double NOT NULL,
  `renting_fee` double NOT NULL,
  `stock` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL,
  `item_image` blob NOT NULL,
  `item_type_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`item_id`, `item_name`, `price`, `renting_fee`, `stock`, `provider_id`, `item_image`, `item_type_id`) VALUES
(1, 'tent', 10, 30, 10, 1, '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `item_type`
--

CREATE TABLE `item_type` (
  `item_type_id` int(11) NOT NULL,
  `item_type_name` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `item_type`
--

INSERT INTO `item_type` (`item_type_id`, `item_type_name`) VALUES
(1, 'backpack');

-- --------------------------------------------------------

--
-- Table structure for table `service_provider`
--

CREATE TABLE `service_provider` (
  `provider_id` int(11) NOT NULL,
  `provider_name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `contact_number` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `service_provider`
--

INSERT INTO `service_provider` (`provider_id`, `provider_name`, `email`, `username`, `password`, `contact_number`) VALUES
(1, 'Rei', 'rei@yahoo.com', 'Rei', 'something', '553');

-- --------------------------------------------------------

--
-- Table structure for table `transaction`
--

CREATE TABLE `transaction` (
  `transactopm_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `date_rented` date NOT NULL,
  `date_due` date NOT NULL,
  `days_rented` int(11) NOT NULL,
  `amount` double NOT NULL,
  `approved` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transaction`
--

INSERT INTO `transaction` (`transactopm_id`, `item_id`, `client_id`, `date_rented`, `date_due`, `days_rented`, `amount`, `approved`) VALUES
(1, 1, 1, '2018-04-18', '2018-04-19', 1, 30, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`),
  ADD UNIQUE KEY `admin_name_UNIQUE` (`admin_name`),
  ADD UNIQUE KEY `username_UNIQUE` (`username`),
  ADD UNIQUE KEY `password_UNIQUE` (`password`);

--
-- Indexes for table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`client_id`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`),
  ADD UNIQUE KEY `username_UNIQUE` (`username`),
  ADD UNIQUE KEY `contact_number_UNIQUE` (`contact_number`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `provider_id_idx` (`provider_id`);

--
-- Indexes for table `item_type`
--
ALTER TABLE `item_type`
  ADD PRIMARY KEY (`item_type_id`);

--
-- Indexes for table `service_provider`
--
ALTER TABLE `service_provider`
  ADD PRIMARY KEY (`provider_id`),
  ADD UNIQUE KEY `provider_name_UNIQUE` (`provider_name`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`),
  ADD UNIQUE KEY `username_UNIQUE` (`username`),
  ADD UNIQUE KEY `contact_number_UNIQUE` (`contact_number`);

--
-- Indexes for table `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`transactopm_id`),
  ADD KEY `item_id_idx` (`item_id`),
  ADD KEY `client_id_idx` (`client_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `client`
--
ALTER TABLE `client`
  MODIFY `client_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `item_type`
--
ALTER TABLE `item_type`
  MODIFY `item_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `service_provider`
--
ALTER TABLE `service_provider`
  MODIFY `provider_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `items`
--
ALTER TABLE `items`
  ADD CONSTRAINT `provider_id` FOREIGN KEY (`provider_id`) REFERENCES `service_provider` (`provider_id`) ON UPDATE CASCADE;

--
-- Constraints for table `transaction`
--
ALTER TABLE `transaction`
  ADD CONSTRAINT `client_id` FOREIGN KEY (`client_id`) REFERENCES `client` (`client_id`),
  ADD CONSTRAINT `item_id` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
