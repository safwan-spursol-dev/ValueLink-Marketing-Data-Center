-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 21, 2025 at 10:51 AM
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
-- Database: `vmdc`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `lead_id` int(11) DEFAULT NULL,
  `lead_name` varchar(150) DEFAULT NULL,
  `lead_email` varchar(150) DEFAULT NULL,
  `lead_form` varchar(150) DEFAULT NULL,
  `lead_created_at` datetime DEFAULT NULL,
  `action_type` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `activity_logs`
--

INSERT INTO `activity_logs` (`id`, `user_id`, `lead_id`, `lead_name`, `lead_email`, `lead_form`, `lead_created_at`, `action_type`, `description`, `created_at`) VALUES
(1, 1, 2, 'Stephanie Gunter', 'sgunter@southlandcu.org', 'Event Form', '2025-12-21 02:20:21', 'Note Added', 'Added a new note: not interested...', '2025-12-21 07:19:26'),
(2, 8, 1, 'Brett Jerhoff', 'bjerhoff@cfmtg.com', 'Demo Request Form', '2025-12-21 02:20:21', 'Status Update', 'Changed status from \'Converted\' to \'In_progress\'', '2025-12-21 07:23:01'),
(3, 1, 1, 'Brett Jerhoff', 'bjerhoff@cfmtg.com', 'Demo Request Form', '2025-12-21 02:20:21', 'Status Update', 'Changed status from \'In_progress\' to \'Lost\'', '2025-12-21 07:27:33'),
(4, 8, 2, 'Stephanie Gunter', 'sgunter@southlandcu.org', 'Event Form', '2025-12-21 02:20:21', 'Status Update', 'Changed status from \'Lost\' to \'In_progress\'', '2025-12-21 07:28:11'),
(5, 8, 2, 'Stephanie Gunter', 'sgunter@southlandcu.org', 'Event Form', '2025-12-21 02:20:21', 'Note Added', 'Added a new note: baat chal rahi ha...', '2025-12-21 07:28:21'),
(6, 8, 1, 'Brett Jerhoff', 'bjerhoff@cfmtg.com', 'Demo Request Form', '2025-12-21 02:20:21', 'Status Update', 'Changed status from \'Lost\' to \'New\'', '2025-12-21 08:24:28'),
(7, 8, 1, 'Brett Jerhoff', 'bjerhoff@cfmtg.com', 'Demo Request Form', '2025-12-21 02:20:21', 'Status Update', 'Changed status from \'New\' to \'In_progress\'', '2025-12-21 08:25:09'),
(8, 8, 1, 'Brett Jerhoff', 'bjerhoff@cfmtg.com', 'Demo Request Form', '2025-12-21 02:20:21', 'Note Added', 'Added a new note: working on it!...', '2025-12-21 08:25:27');

-- --------------------------------------------------------

--
-- Table structure for table `api_logs`
--

CREATE TABLE `api_logs` (
  `id` bigint(20) NOT NULL,
  `website_id` int(11) DEFAULT NULL,
  `endpoint` varchar(255) DEFAULT NULL,
  `request_payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`request_payload`)),
  `response_status` int(11) DEFAULT NULL,
  `logged_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fluent_forms`
--

CREATE TABLE `fluent_forms` (
  `id` int(11) NOT NULL,
  `website_id` int(11) NOT NULL,
  `form_id_wp` int(11) NOT NULL,
  `form_title` varchar(150) NOT NULL,
  `fields_structure` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`fields_structure`)),
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `form_submissions`
--

CREATE TABLE `form_submissions` (
  `id` bigint(20) NOT NULL,
  `fluent_form_id` int(11) NOT NULL,
  `entry_id_wp` int(11) DEFAULT NULL,
  `submission_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`submission_data`)),
  `submitted_at` datetime DEFAULT current_timestamp(),
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `utm_source` varchar(100) DEFAULT NULL,
  `utm_medium` varchar(100) DEFAULT NULL,
  `utm_campaign` varchar(100) DEFAULT NULL,
  `status` enum('new','viewed','archived') DEFAULT 'new'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `leads`
--

CREATE TABLE `leads` (
  `id` int(11) NOT NULL,
  `client_name` varchar(150) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `company` varchar(150) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `user_role` varchar(100) DEFAULT NULL,
  `order_volume` varchar(100) DEFAULT NULL,
  `preferred_date` varchar(100) DEFAULT NULL,
  `event_title` varchar(255) DEFAULT NULL,
  `source` varchar(100) DEFAULT 'Web API',
  `form_name` varchar(150) DEFAULT NULL,
  `submission_url` text DEFAULT NULL,
  `status` enum('new','in_progress','converted','lost') DEFAULT 'new',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `leads`
--

INSERT INTO `leads` (`id`, `client_name`, `email`, `phone`, `company`, `message`, `user_role`, `order_volume`, `preferred_date`, `event_title`, `source`, `form_name`, `submission_url`, `status`, `created_at`) VALUES
(1, 'Brett Jerhoff', 'bjerhoff@cfmtg.com', '619-847-6196', 'Cornerstone First Mortgage', 'We are a lender but creating our own amc for us. We use Reggora also.', 'Manager', '500-1000', '2025-12-01 10:00 AM', NULL, 'Value Link Software', 'Demo Request Form', NULL, 'in_progress', '2025-12-20 21:20:21'),
(2, 'Stephanie Gunter', 'sgunter@southlandcu.org', '562-274-7157', 'Southland Credit Union', 'I need the link to order tickets for the team.', NULL, NULL, '2025-11-15', 'Annual Tech Summit 2025', 'Value Link Connect', 'Event Form', NULL, 'in_progress', '2025-12-20 21:20:21'),
(3, 'Mark Hance', 'mark.hance@baseleaddata.com', NULL, 'Base Lead Data', 'Hi, Are you interested in acquiring contact details of Key Decision Makers from Insurance Agencies?', NULL, NULL, NULL, NULL, 'Value Link Software', 'Contact US form', NULL, 'new', '2025-12-20 21:20:21'),
(4, 'Jansh Brown', 'jansh@testing.com', '123-456-7890', 'Tech Solutions Ltd', 'Hello, I am writing to inquire about your enterprise solutions. We have a requirement for a custom module that integrates with our existing SAP system. Currently, we are facing issues with data synchronization and need a robust API solution. Please let me know if we can schedule a call to discuss this in detail.', 'CTO', '1000+', NULL, NULL, 'Google Ads', 'Demo Request Form', NULL, 'in_progress', '2025-12-20 21:20:21');

-- --------------------------------------------------------

--
-- Table structure for table `lead_notes`
--

CREATE TABLE `lead_notes` (
  `id` int(11) NOT NULL,
  `lead_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `note` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lead_notes`
--

INSERT INTO `lead_notes` (`id`, `lead_id`, `user_id`, `note`, `created_at`) VALUES
(1, 2, 1, 'not interested', '2025-12-21 06:55:19'),
(2, 2, 1, 'not interested', '2025-12-21 07:19:26'),
(3, 2, 8, 'baat chal rahi ha', '2025-12-21 07:28:21'),
(4, 1, 8, 'working on it!', '2025-12-21 08:25:27');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','marketing','sales') NOT NULL DEFAULT 'marketing',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `reset_token` varchar(255) DEFAULT NULL,
  `reset_token_expiry` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `image` varchar(255) DEFAULT 'default.png'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`, `is_active`, `reset_token`, `reset_token_expiry`, `created_at`, `updated_at`, `image`) VALUES
(1, 'System Admin', 'admin@vmdc.com', '$2y$10$84mc/vSvrTHrnpJhKODile/3v4cbnuuBm3Kxw9x/V6Iab3uH/H6H2', 'admin', 1, NULL, NULL, '2025-11-24 17:57:33', '2025-12-14 20:54:30', '1765727670_sir safwan.jpg'),
(4, 'Ali', 'ali@gmail.com', '$2y$10$U9Q8jEXYISC03KM1wkl7duViWpDgQBF96Suk4EBxYCNzps4ITBtAi', 'sales', 0, NULL, NULL, '2025-12-14 03:05:35', '2025-12-14 16:16:38', 'default.png'),
(8, 'Zohaib Hassan', 'zohaibking012@gmail.com', '$2y$10$dyFEOmdLR4.Os7u41D2CreTtESURWMi8dqMcSRl9Y78eK9XMvyeC6', 'sales', 1, NULL, NULL, '2025-12-14 17:25:14', '2025-12-14 23:34:59', '1765727773_z3image.jpg'),
(9, 'Kazim', 'kazimsami1234@gmail.com', '$2y$10$uCDTqUx6vhCbzZqavTzPa.XFD4q7nIjn71FMMnatk9JJjsr7MYgeK', 'admin', 1, NULL, NULL, '2025-12-14 17:29:22', '2025-12-14 17:29:22', 'default.png'),
(10, 'Syed Kazim', 'syed.kazim.2003@gmail.com', '$2y$10$T8VtUjhW1AM146ZSJeyXYuvKrSCLA7/P5jRA9Xb8IVBScBWYXmLhy', 'marketing', 0, NULL, NULL, '2025-12-14 20:36:50', '2025-12-21 01:56:53', '1765726723_468324379_871891858404633_8184602128928817367_n.jpg'),
(11, 'Sami', 'alianavtuber56@gmail.com', '$2y$10$nlsHg6s.OSP2qcG6X92N1eRH7ILuVMTdoAt7JD66OKh9gcgROLRNO', 'sales', 1, NULL, NULL, '2025-12-14 20:40:09', '2025-12-14 20:40:09', 'default.png'),
(12, 'Safwan', 'safwanshaekh55@gmail.com', '$2y$10$mviEf2uL/GtFbunzItW7Y.vAObcV7sOG4qm4CbDjBmTzVChxRxqIy', 'admin', 1, NULL, NULL, '2025-12-14 23:13:14', '2025-12-14 23:13:14', 'default.png');

-- --------------------------------------------------------

--
-- Table structure for table `websites`
--

CREATE TABLE `websites` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `url` varchar(255) NOT NULL,
  `api_key` varchar(64) NOT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `api_logs`
--
ALTER TABLE `api_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `website_id` (`website_id`);

--
-- Indexes for table `fluent_forms`
--
ALTER TABLE `fluent_forms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_fluent_forms_website_id` (`website_id`);

--
-- Indexes for table `form_submissions`
--
ALTER TABLE `form_submissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_form_submissions_form_id` (`fluent_form_id`);

--
-- Indexes for table `leads`
--
ALTER TABLE `leads`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lead_notes`
--
ALTER TABLE `lead_notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lead_id` (`lead_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `websites`
--
ALTER TABLE `websites`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `api_key` (`api_key`),
  ADD KEY `idx_websites_status` (`status`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `api_logs`
--
ALTER TABLE `api_logs`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fluent_forms`
--
ALTER TABLE `fluent_forms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `form_submissions`
--
ALTER TABLE `form_submissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `leads`
--
ALTER TABLE `leads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `lead_notes`
--
ALTER TABLE `lead_notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `websites`
--
ALTER TABLE `websites`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `activity_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `api_logs`
--
ALTER TABLE `api_logs`
  ADD CONSTRAINT `api_logs_ibfk_1` FOREIGN KEY (`website_id`) REFERENCES `websites` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `fluent_forms`
--
ALTER TABLE `fluent_forms`
  ADD CONSTRAINT `fluent_forms_ibfk_1` FOREIGN KEY (`website_id`) REFERENCES `websites` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `form_submissions`
--
ALTER TABLE `form_submissions`
  ADD CONSTRAINT `form_submissions_ibfk_1` FOREIGN KEY (`fluent_form_id`) REFERENCES `fluent_forms` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `lead_notes`
--
ALTER TABLE `lead_notes`
  ADD CONSTRAINT `lead_notes_ibfk_1` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `lead_notes_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
