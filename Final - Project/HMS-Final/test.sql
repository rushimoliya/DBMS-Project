-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 27, 2024 at 04:01 AM
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
-- Database: `test`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointment`
--

CREATE TABLE `appointment` (
  `app_id` bigint(20) UNSIGNED NOT NULL,
  `pat_id` int(11) DEFAULT NULL,
  `doc_id` int(11) DEFAULT NULL,
  `appointment_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `department_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(20) NOT NULL,
  `head_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `doctor`
--

CREATE TABLE `doctor` (
  `doc_id` bigint(20) UNSIGNED NOT NULL,
  `doc_first_name` varchar(20) NOT NULL,
  `doc_last_name` varchar(20) NOT NULL,
  `doc_ph_no` varchar(20) NOT NULL,
  `doc_date` date DEFAULT curdate(),
  `doc_address` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `medication`
--

CREATE TABLE `medication` (
  `code` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(20) NOT NULL,
  `brand` varchar(20) NOT NULL,
  `description` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nurse`
--

CREATE TABLE `nurse` (
  `nur_id` bigint(20) UNSIGNED NOT NULL,
  `nur_first_name` varchar(20) NOT NULL,
  `nur_last_name` varchar(20) NOT NULL,
  `nur_ph_no` varchar(20) NOT NULL,
  `nur_date` date DEFAULT curdate(),
  `nur_address` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `pat_id` bigint(20) UNSIGNED NOT NULL,
  `pat_first_name` varchar(20) NOT NULL,
  `pat_last_name` varchar(20) NOT NULL,
  `pat_insurance_no` varchar(30) NOT NULL,
  `pat_ph_no` varchar(20) NOT NULL,
  `pat_date` date DEFAULT curdate(),
  `pat_address` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `prescribes`
--

CREATE TABLE `prescribes` (
  `pre_id` bigint(20) UNSIGNED NOT NULL,
  `doc_id` int(11) DEFAULT NULL,
  `pat_id` int(11) DEFAULT NULL,
  `med_code` int(11) DEFAULT NULL,
  `p_date` date NOT NULL,
  `app_id` int(11) DEFAULT NULL,
  `dose` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `procedures`
--

CREATE TABLE `procedures` (
  `code` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(20) NOT NULL,
  `cost` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

CREATE TABLE `room` (
  `room_no` bigint(20) UNSIGNED NOT NULL,
  `room_type` varchar(20) NOT NULL,
  `available` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `signup`
--

CREATE TABLE `signup` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `usertype` enum('patient','doctor','nurse') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `signup`
--

INSERT INTO `signup` (`user_id`, `email`, `username`, `password`, `usertype`) VALUES
(3, 'rushi.m@ahduni.edu.in', 'rushi.m', 'scrypt:32768:8:1$D36jcTgsPdknY0c8$21f2410534d8fb020d9844793947057332a84448a3a8d47359fbfd2d704f2b62b1f41f90ff1f63c2f160630495970d915abd89901481144fa5d0de0026617272', 'doctor'),
(4, 'simon.s@ahduni.edu.in', 'simon', 'scrypt:32768:8:1$n7ua3bh1gm0PpWko$12a78036a97c372b55c921c4e5baa519486cb0aa6370f906cc6a529659a78a797f5b756a3485d224bd50a73ae8eebe7c90d23347526b4ee61bc4791c5cfa7079', 'nurse');

-- --------------------------------------------------------

--
-- Table structure for table `undergoes`
--

CREATE TABLE `undergoes` (
  `under_id` bigint(20) UNSIGNED NOT NULL,
  `pat_id` int(11) DEFAULT NULL,
  `proc_code` int(11) DEFAULT NULL,
  `u_date` date DEFAULT NULL,
  `doc_id` int(11) DEFAULT NULL,
  `nur_id` int(11) DEFAULT NULL,
  `room_no` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointment`
--
ALTER TABLE `appointment`
  ADD PRIMARY KEY (`app_id`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`department_id`);

--
-- Indexes for table `doctor`
--
ALTER TABLE `doctor`
  ADD PRIMARY KEY (`doc_id`);

--
-- Indexes for table `medication`
--
ALTER TABLE `medication`
  ADD PRIMARY KEY (`code`);

--
-- Indexes for table `nurse`
--
ALTER TABLE `nurse`
  ADD PRIMARY KEY (`nur_id`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`pat_id`);

--
-- Indexes for table `prescribes`
--
ALTER TABLE `prescribes`
  ADD PRIMARY KEY (`pre_id`);

--
-- Indexes for table `procedures`
--
ALTER TABLE `procedures`
  ADD PRIMARY KEY (`code`);

--
-- Indexes for table `room`
--
ALTER TABLE `room`
  ADD PRIMARY KEY (`room_no`);

--
-- Indexes for table `signup`
--
ALTER TABLE `signup`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`),
  ADD UNIQUE KEY `username_UNIQUE` (`username`);

--
-- Indexes for table `undergoes`
--
ALTER TABLE `undergoes`
  ADD PRIMARY KEY (`under_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointment`
--
ALTER TABLE `appointment`
  MODIFY `app_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `department`
--
ALTER TABLE `department`
  MODIFY `department_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `doctor`
--
ALTER TABLE `doctor`
  MODIFY `doc_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `medication`
--
ALTER TABLE `medication`
  MODIFY `code` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nurse`
--
ALTER TABLE `nurse`
  MODIFY `nur_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `patient`
--
ALTER TABLE `patient`
  MODIFY `pat_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `prescribes`
--
ALTER TABLE `prescribes`
  MODIFY `pre_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `procedures`
--
ALTER TABLE `procedures`
  MODIFY `code` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `room`
--
ALTER TABLE `room`
  MODIFY `room_no` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `signup`
--
ALTER TABLE `signup`
  MODIFY `user_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `undergoes`
--
ALTER TABLE `undergoes`
  MODIFY `under_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
