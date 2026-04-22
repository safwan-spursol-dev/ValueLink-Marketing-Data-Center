-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 18, 2026 at 10:38 PM
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
(8, 8, 1, 'Brett Jerhoff', 'bjerhoff@cfmtg.com', 'Demo Request Form', '2025-12-21 02:20:21', 'Note Added', 'Added a new note: working on it!...', '2025-12-21 08:25:27'),
(26, 1, 235, 'Anna Bartosch', 'anna@mortgagecountry.com', 'Demo Request Form', '2026-04-07 16:30:00', 'Qualification Update', 'Changed Qualification Scale to \'Qualified\'', '2026-04-08 06:45:18'),
(27, 1, 235, 'Anna Bartosch', 'anna@mortgagecountry.com', 'Demo Request Form', '2026-04-07 16:30:00', 'Status Update', 'Changed status to \'MSA Signed\'', '2026-04-08 06:45:21'),
(28, 1, 235, 'Anna Bartosch', 'anna@mortgagecountry.com', 'Demo Request Form', '2026-04-07 16:30:00', 'Status Update', 'Changed status to \'MSA Signed\'', '2026-04-08 06:45:23'),
(29, 1, 235, 'Anna Bartosch', 'anna@mortgagecountry.com', 'Demo Request Form', '2026-04-07 16:30:00', 'Status Update', 'Changed status to \'Demo Done\'', '2026-04-08 06:45:25'),
(30, 1, 235, 'Anna Bartosch', 'anna@mortgagecountry.com', 'Demo Request Form', '2026-04-07 16:30:00', 'Status Update', 'Changed status to \'MSA Signed\'', '2026-04-08 06:45:30'),
(31, 1, 235, 'Anna Bartosch', 'anna@mortgagecountry.com', 'Demo Request Form', '2026-04-07 16:30:00', 'Status Update', 'Changed status to \'Conversion - MSA Sent\'', '2026-04-08 06:59:39'),
(32, 1, 238, 'John Jacobs', 'john.j.jacobs@hud.gov', 'Demo Request Form', '2026-04-02 13:50:00', 'Status Update', 'Changed status to \'Not Qualified\'', '2026-04-08 06:59:44'),
(33, 1, 238, 'John Jacobs', 'john.j.jacobs@hud.gov', 'Demo Request Form', '2026-04-02 13:50:00', 'Status Update', 'Changed status to \'MSA Signed\'', '2026-04-08 06:59:46'),
(34, 1, 237, 'Erick Vargas', 'value305@gmail.com', 'Demo Request Form', '2026-04-02 15:03:00', 'Status Update', 'Changed status from \'New\' to \'Conversion - MSA Sent\'', '2026-04-08 07:00:22'),
(35, 1, 236, 'Elena Lakhina', 'elena@meggamarq.com', 'Demo Request Form', '2026-04-04 15:50:00', 'Status Update', 'Changed status from \'New\' to \'Not Sure of Status\'', '2026-04-08 07:00:27'),
(36, 1, 235, 'Anna Bartosch', 'anna@mortgagecountry.com', 'Demo Request Form', '2026-04-07 16:30:00', 'Status Update', 'Changed status to \'Conversion - MSA Sent\'', '2026-04-08 07:01:37'),
(37, 1, 235, 'Anna Bartosch', 'anna@mortgagecountry.com', 'Demo Request Form', '2026-04-07 16:30:00', 'Status Update', 'Changed status to \'Conversion - MSA Sent\'', '2026-04-08 07:07:42'),
(38, 1, 235, 'Anna Bartosch', 'anna@mortgagecountry.com', 'Demo Request Form', '2026-04-07 16:30:00', 'Status Update', 'Changed status to \'Not Sure of Status\'', '2026-04-08 07:07:44'),
(39, 1, 235, 'Anna Bartosch', 'anna@mortgagecountry.com', 'Demo Request Form', '2026-04-07 16:30:00', 'Status Update', 'Changed status to \'Demo Done\'', '2026-04-08 07:07:45'),
(40, 1, 235, 'Anna Bartosch', 'anna@mortgagecountry.com', 'Demo Request Form', '2026-04-07 16:30:00', 'Status Update', 'Changed status to \'New\'', '2026-04-08 07:07:47'),
(41, 1, 235, 'Anna Bartosch', 'anna@mortgagecountry.com', 'Demo Request Form', '2026-04-07 16:30:00', 'Status Update', 'Changed status to \'MSA Signed\'', '2026-04-08 07:07:50'),
(42, 1, 235, 'Anna Bartosch', 'anna@mortgagecountry.com', 'Demo Request Form', '2026-04-07 16:30:00', 'Status Update', 'Changed status to \'Conversion - MSA Sent\'', '2026-04-08 07:07:51'),
(43, 1, 235, 'Anna Bartosch', 'anna@mortgagecountry.com', 'Demo Request Form', '2026-04-07 16:30:00', 'Status Update', 'Changed status to \'Customer Already\'', '2026-04-08 07:07:53'),
(44, 1, 235, 'Anna Bartosch', 'anna@mortgagecountry.com', 'Demo Request Form', '2026-04-07 16:30:00', 'Status Update', 'Changed status to \'Conversion - MSA Sent\'', '2026-04-08 07:11:35'),
(45, 1, 236, 'Elena Lakhina', 'elena@meggamarq.com', 'Demo Request Form', '2026-04-04 15:50:00', 'Qualification Update', 'Changed Qualification Scale to \'Qualified\'', '2026-04-08 07:25:28'),
(46, 1, 236, 'Elena Lakhina', 'elena@meggamarq.com', 'Demo Request Form', '2026-04-04 15:50:00', 'Status Update', 'Changed status to \'Conversion - MSA Sent\'', '2026-04-08 07:25:33'),
(47, 1, 236, 'Elena Lakhina', 'elena@meggamarq.com', 'Demo Request Form', '2026-04-04 15:50:00', 'Status Update', 'Changed status to \'Demo Done\'', '2026-04-08 07:25:49');

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
  `status` varchar(100) DEFAULT 'new',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `qualification_scale` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `leads`
--

INSERT INTO `leads` (`id`, `client_name`, `email`, `phone`, `company`, `message`, `user_role`, `order_volume`, `preferred_date`, `event_title`, `source`, `form_name`, `submission_url`, `status`, `created_at`, `qualification_scale`) VALUES
(235, 'Anna Bartosch', 'anna@mortgagecountry.com', '3092612311', 'MortgageCountry', 'demo of system that plugs into MeridianLink Mortgage.', 'Lender', '0–99 orders / month', '2026-04-09', '', 'CSV Import', 'Demo Request Form', NULL, 'Conversion - MSA Sent', '2026-04-07 11:30:00', 'Qualified'),
(236, 'Elena Lakhina', 'elena@meggamarq.com', '6562043797', 'Megga Marq Mortgage', 'Order an appraisal ASAP', 'Lender', '0–99 orders / month', '2026-04-04', '', 'CSV Import', 'Demo Request Form', NULL, 'Demo Done', '2026-04-04 10:50:00', 'Qualified'),
(237, 'Erick Vargas', 'value305@gmail.com', '7863851325', 'Hometrust AMC', 'Information', 'AMC', '0–99 orders / month', '2026-04-02', '', 'CSV Import', 'Demo Request Form', NULL, '', '2026-04-02 10:03:00', NULL),
(238, 'John Jacobs', 'john.j.jacobs@hud.gov', '8002255342', 'HUD/FHA', 'To set up and meeting with your upper management to discuss the new 3.6 appraisal forms.', 'Lender', '5,000+ orders / month', '2026-04-02', '', 'CSV Import', 'Demo Request Form', NULL, '', '2026-04-02 08:50:00', NULL),
(239, 'Sheikh Muhammad Safwan', 'safwan.spursol@gmail.com', '03152288535', 'SpurSol', 'Test', 'Lender', '500–999 orders / month', '2026-04-23', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-04-02 01:52:00', NULL),
(240, 'Kathleen Glover', 'creatappr@aol.com', '9088109393', 'Creative Home Real Estate & Investment', 'Residential appraisals , New Jersey', 'AMC', '0–99 orders / month', '2026-04-01', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-04-01 16:19:00', NULL),
(241, 'CHRIS ALICKI', 'chris@wmimortgage.com', '3125433679', 'West Michigan Mortgage', 'pricing', 'Lender', '0–99 orders / month', '2026-03-31', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-03-31 12:29:00', NULL),
(242, 'Henry Indvik', 'henry@vontive.com', '2062377865', 'Vontive, Inc.', 'Appraisal/Vendor Management', 'Lender', '500–999 orders / month', '2026-03-31', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-03-26 12:21:00', NULL),
(243, 'Wynn', 'wynn.nguyen@legendamc.com', '(714) 315-0054', 'Legend AMC', 'Legend AMC is a new AMC and looking for the providing service softwave , can you please e mail me the instruction that I can use Valuelink .', 'AMC', '100–499 orders / month', '2026-03-24', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-03-24 10:08:00', NULL),
(244, 'Zohair', 'zohair.sheikh@valuelinksoftware.com', '\'+18885870805', 'VL', 'Final Test', 'Lender', '100–499 orders / month', '2026-03-24', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-03-24 06:06:00', NULL),
(245, 'Zohair', 'zohair.sheikh@valuelinksoftware.com', '\'+18885870805', 'VL', 'Test', 'Lender', '100–499 orders / month', '2026-03-24', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-03-24 05:58:00', NULL),
(246, 'Zohair', 'zohair.sheikh@valuelinksoftware.com', '\'+18885870805', 'VL', 'Test', 'Lender', '100–499 orders / month', '2026-03-24', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-03-24 05:42:00', NULL),
(247, 'Zohair', 'zohair.sheikh@valuelinksoftware.com', '\'+18885870805', 'VL', 'Test', 'Lender', '100–499 orders / month', '2026-03-24', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-03-24 02:38:00', NULL),
(248, 'Sheikh Muhammad Safwan', 'safwan.spursol@gmail.com', '03152288535', 'SpurSOL', 'Test', 'Lender', '0–99 orders / month', '2026-03-25', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-03-24 00:52:00', NULL),
(249, 'Zohair', 'zohair.sheikh@valuelinksoftware.com', '\'+18885870805', 'VL', 'Test', 'AMC', '100–499 orders / month', '2026-03-24', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-03-24 00:33:00', NULL),
(250, 'Bernard McCoy', 'mccoyap85@gmail.com', '16012740394', 'McCoy Appraisal', 'Appraisal Review Software', 'AMC', '0–99 orders / month', '2026-03-19', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-03-19 11:11:00', NULL),
(251, 'marc schwartzberg', 'marc@bdcapital.com', '8457055345', 'bd capital', 'software to manage orders', 'Lender', '0–99 orders / month', '2026-03-18', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-03-18 20:45:00', NULL),
(252, 'Zohair Sheikh', 'zohair.sheikh@valuelinksoftware.com', '\'+18885870805', 'VL', 'Demo req', 'AMC', '100–499 orders / month', '2026-03-18', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-03-18 01:35:00', NULL),
(253, 'Zohair Sheikh', 'zohair.sheikh@valuelinksoftware.com', '\'+18885870805', 'VL', 'Demo req', 'Lender', '100–499 orders / month', '2026-03-18', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-03-18 00:35:00', NULL),
(254, 'Zohair Sheikh', 'zohair.sheikh@valuelinksoftware.com', '\'+18885870805', 'VL', 'Demo req', 'Lender', '100–499 orders / month', '2026-03-18', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-03-18 00:24:00', NULL),
(255, 'Wynn', 'wynn.nguyen@legendamc.com', '714-315-0054', 'Legend AMC', 'Legend AMC is a new AMC and looking for the providing service softwave , can you please e mail me the instruction that I can use Valuelink .', 'AMC', '0–99 orders / month', '2026-03-17', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-03-17 16:54:00', NULL),
(256, 'Derek Bolls', 'dbolls@metriqvaluation.com', '832-721-1660', 'MetriQ Valuation, LLC', 'demo of your AMS', 'AMC', '1,000–4,999 orders / month', '2026-03-12', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-03-12 14:48:00', NULL),
(257, 'Zohair Sheikh', 'zohair.sheikh@valuelinksoftware.com', '\'+18885870805', 'VL', 'Demo req', 'AMC', '100–499 orders / month', '2026-03-10', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-03-10 05:00:00', NULL),
(258, 'Zohair Sheikh', 'zohair.sheikh@valuelinksoftware.com', '\'+18885870805', 'VL', 'Demo req', 'AMC', '100–499 orders / month', '2026-03-10', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-03-10 03:18:00', NULL),
(259, 'Zohair Sheikh', 'zohair.sheikh@valuelinksoftware.com', '\'+18885870805', 'VL', 'Demo req', 'AMC', '100–499 orders / month', '2026-03-10', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-03-10 01:30:00', NULL),
(260, 'Zohair Sheikh', 'zohair.sheikh@valuelinksoftware.com', '\'+18885870805', 'VL', 'Demo req', 'AMC', '100–499 orders / month', '2026-03-10', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-03-10 00:59:00', NULL),
(261, 'Harold Harper', 'harold.harper@tieronetitle.com', '8138981277', 'Tier 1 Title', 'information to be set up in realec to receive title orders.', 'AMC', '0–99 orders / month', '2026-03-09', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-03-09 08:09:00', NULL),
(262, 'Jodi', 'jvinci@clearmarkvaluation.com', '614-570-7895', 'Clearmark Valuation', 'How the system works and costs', 'AMC', 'Not sure / exploring options', '2026-03-09', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-03-09 08:07:00', NULL),
(263, 'Karen Kegel', 'k.appraisal@outlook.com', '8457075040', 'Foundry Valuation', 'Demo, info & pricing', 'AMC', '0–99 orders / month', '2026-03-09', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-03-09 07:31:00', NULL),
(264, 'Sofia Vanegas', 'sofia.vanegas@dalberg.com', '\'+57 3212496885', 'Dalberg', 'an appraisal management software that can be used by a bank in Panama. Could ValueLink provide that? Thank you!', 'Lender', '100–499 orders / month', '2026-03-03', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-03-03 18:09:00', NULL),
(265, 'Lisa Stremme', 'lstremme@vipmtginc.com', '602 418-4559', 'VIP Mortgage Inc', 'A demo on your system.', 'Lender', '500–999 orders / month', '2026-03-02', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-03-02 09:16:00', NULL),
(266, 'Priscilla Arzivian', 'priscillaarzivian@gmail.com', '3867957653', 'LPT Realty , llc', 'bpos', 'AMC', '0–99 orders / month', '2026-02-28', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-02-28 19:58:00', NULL),
(267, 'Matthew Wolfer', 'matthew@ledgertc.com', '5089335601', 'Ledger Trade and Capital', 'New AMC for RTL/DSCR loans', 'Lender', '0–99 orders / month', '2026-02-26', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-02-26 12:39:00', NULL),
(268, 'amita singh', 'mark2pan@yahoo.com', '\'+16462702889', 'aaa enterpries llc', 'appraiser', 'Lender', '0–99 orders / month', '2026-02-26', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-02-26 09:40:00', NULL),
(269, 'Nikki Dao', 'nikkidao@barrettfinancial.com', '4077332261', 'Barrett Financial Group LLC', 'login to order appraisal', 'Lender', '0–99 orders / month', '2026-02-23', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-02-23 18:00:00', NULL),
(270, 'Walter Graham', 'waltgraham18@gmail.com', '2672512330', 'DC Casper Real Estate', 'to complete bpos', 'AMC', '0–99 orders / month', '2026-02-15', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-02-15 18:39:00', NULL),
(271, 'Sheikh Muhammad Safwan', 'safwan.spursol@gmail.com', '03152288535', 'SpurSol', 'Test', 'Lender', '5,000+ orders / month', '2026-02-13', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-02-12 09:29:00', NULL),
(272, 'Tom Armstrong, MAI', 'tom@aandsappraisal.com', '2566846606', 'A&S Appraisal Co., LLC', 'Commercial Appraisals', 'AMC', '0–99 orders / month', '2026-02-11', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-02-11 16:26:00', NULL),
(273, 'Francis', 'frank@redfish-appraisals.com', '4095026065', 'Redfish Appraisal Services', 'I am looking to push and pull appraisals', 'AMC', '0–99 orders / month', '2026-02-10', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-02-10 12:02:00', NULL),
(274, 'EMAD RAYYAN', 'socaldirect@aol.com', '7142876900', 'So Cal Direct AMC', 'replacing my current software', 'AMC', '500–999 orders / month', '2026-02-06', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-02-06 16:54:00', NULL),
(275, 'Chris Lesnik', 'clesnik@brrrr.com', '17328040939', 'Brrrr Loans', 'Integrate into my loan portal that is self built', 'Lender', '100–499 orders / month', '2026-02-05', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-02-05 15:56:00', NULL),
(276, 'Cory Reed', 'creed@altaircapitalgroup.com', '\'+18454921877', 'Altair Capital Group', 'Consult', 'Lender', '0–99 orders / month', '2026-02-04', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-02-04 12:48:00', NULL),
(277, 'Lisa Arnold', 'larnold@unitedappraisalvaluations.com', '708-852-3710', 'United Appraisal Valuations', 'We are a startup Company looking to get started', 'AMC', '0–99 orders / month', '2026-01-29', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-01-29 22:39:00', NULL),
(278, 'Joe Quenneville', 'joe@poseidonaisystems.com', '9257879222', 'Accuity Appraisal Services', 'Complete appraisal management stack', 'AMC', '0–99 orders / month', '2026-01-30', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-01-29 16:53:00', NULL),
(279, 'Tom Kennedy', 'tom.kennedy@regions.com', '601-554-2330', 'Regions Mortgage', 'An AI based review tool', 'Lender', '1,000–4,999 orders / month', '2026-01-29', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-01-29 12:07:00', NULL),
(280, 'Kamal', 'kamal.lalwani@zenzinnovation.com', '\'+12792487434', 'Zenz Innovation', 'Want to do automated valuation for client property', 'AMC', '0–99 orders / month', '2026-01-23', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-01-23 09:35:00', NULL),
(281, 'Sanjay Sethi', 'info@realestateplusamc.com', '19255518500', 'Real Esatte Plus LLC', 'Sofftware to manage orders', 'AMC', '0–99 orders / month', '2026-01-18', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-01-18 13:24:00', NULL),
(282, 'George Lewis', 'george.lewis@cbtcares.com', '919-815-2443', 'Carter Bank & Trust', 'Looking AVM and other valuations for Home Equity Lines', 'Lender', '0–99 orders / month', '2026-01-12', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-01-12 08:40:00', NULL),
(283, 'Noelle', 'noelle.mundy@waynebank.com', '570-253-8517', 'Mundy', 'an appraisal ordering management system', 'Lender', '0–99 orders / month', '2026-01-08', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-01-08 14:16:00', NULL),
(284, 'Evan Schwartz', 'evan@ehsmgmt.net', '732-245-7380', 'EHS Appraisal Management', 'info on pricing, integration, data migration', 'AMC', '100–499 orders / month', '2026-01-06', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-01-06 13:39:00', NULL),
(285, 'Raymond Wood', 'r_wood@bellsouth.net', '9542905543', 'Raymond G. Wood', 'I have been working with Supreme lending for many years and have been an appraiser with myAMC just as long. I an trying to navigate ValueLinks new system.', 'AMC', '0–99 orders / month', '2025-12-28', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-12-28 11:48:00', NULL),
(286, 'Sanjay Sethi', 'sanjay@ekdsa.com', '19255518500', 'Real Esatte Plus LLC', 'Sofftware to manage orders', 'AMC', '0–99 orders / month', '2025-12-27', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-12-27 16:47:00', NULL),
(287, 'OLIVIA HOWELL', 'olympusamc@gmail.com', 'ncandm@gmail.com', 'Olympus Appraisal Management LLC', 'Software for AMCs - Cost', 'AMC', '0–99 orders / month', '2025-12-22', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-12-22 21:12:00', NULL),
(288, 'Sheikh Muhammad Safwan', 'muhammad.safwan@spursol.com', '03151182258', 'SpurSol', 'Testing VMDC submission', 'AMC', '0–99 orders / month', '2025-12-22', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-12-21 05:33:00', NULL),
(289, 'Safwan', 'muhammad.safwan@spursol.com', '03151182258', 'SpurSol', 'Testing VMDC submission', 'Lender', '100–499 orders / month', '2025-12-23', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-12-21 05:29:00', NULL),
(290, 'Leila', 'ltouhamy@unitedmortgage.com', '6313961815', 'United', 'info on your interface ability with Byte Enterprise.', 'Lender', '100–499 orders / month', '2025-12-17', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-12-17 13:10:00', NULL),
(291, 'Stephen Roefaro', 'sroefaro@gmail.com', '3155254657', 'Roefaro Appraisal Service', 'Appraisals', 'AMC', '0–99 orders / month', '2025-12-12', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-12-12 15:31:00', NULL),
(292, 'Heather', 'heather@valoraamc.com', '8045393163', 'Valora AMC LLC', 'Demo', 'AMC', '0–99 orders / month', '2025-12-12', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-12-11 15:57:00', NULL),
(293, 'Ekta Sethi', 'realappraisalamc@gmail.com', '‪(925) 297-5390‬', 'Real Estate Plus LLC.', 'AMC software', 'AMC', '100–499 orders / month', '2025-12-06', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-12-06 11:33:00', NULL),
(294, 'Audra', 'avanderford@emprisebank.com', '13163834494', 'Emprise Bank', 'A streamline system to work with nCino for appraisal ordering', 'AMC', '0–99 orders / month', '2025-12-02', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-12-02 14:12:00', NULL),
(295, 'James Talbot', 'james@premierlending.org', '5044733030', 'Premier Lending', 'if we fit.', 'Lender', '0–99 orders / month', '2025-11-25', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-11-25 14:40:00', NULL),
(296, 'Chinsoo Kim', 'chinsookim0516@gmail.com', '9075450326', 'hawaiiinn&suite llc', 'up a meeting', 'Lender', 'Not sure / exploring options', '2025-11-20', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-11-20 22:56:00', NULL),
(297, 'James Talbot', 'james@premierlending.org', '5044733030', 'Premier Lending', 'if we fit.', 'Lender', '0–99 orders / month', '2025-11-20', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-11-20 17:47:00', NULL),
(298, 'Yolanda Burrell', 'yolandaburrell75@gmail.com', '562 824-7373', 'Real Estate Valuation Service', 'I am looking to add more vendors in your network to my profile, so I may receive more orders.', 'AMC', '0–99 orders / month', '2025-11-19', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-11-19 13:24:00', NULL),
(299, 'Lien King', 'lien@griffinfunding.com', '6196824852', 'Griffin Funding', 'An appraisal platform to build a panel to help with efficiency, cost and turn times', 'Lender', '100–499 orders / month', '2025-11-13', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-11-13 18:32:00', NULL),
(300, 'Ana Margarete Lima dos Santos', 'ana.margarete.santos@gmail.com', '55 (21)96565-7501', 'AML dos Santos Imóveis', 'Laudos de avaliação e parecer técnico', 'AMC', '0–99 orders / month', '2025-11-08', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-11-08 07:37:00', NULL),
(301, 'Xabad', 'xabad.nadeem@valuelinksoftware.com', '\'+10000000000', 'VLS', 'testing for Encompass', 'Lender', '0–99 orders / month', '2025-11-06', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-11-05 01:18:00', NULL),
(302, 'Dawn Agee', 'dagee@mtcfederal.com', '8649083457', 'MTC Federal Credit Union', 'We are looking for a new vendor for our appraisal needs. We are current using Nations and are not happy with the turn around time and hidden fees as well as additional trip fees which are not being disclosed.', 'Lender', '0–99 orders / month', '2025-11-03', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-11-03 16:16:00', NULL),
(303, 'sdxfcg', 'fghdfgf@gmail.com', '2345678910', 'xdcfvgbhnjmk,l', 'sdxcfghjk', 'Lender', '0–99 orders / month', '2025-11-26', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-11-03 04:59:00', NULL),
(304, 'Florencia R', 'florenciaruedas@gmail.com', '6614008114', 'Sierra Appraisal Network', 'A Demo', 'AMC', '0–99 orders / month', '2025-10-28', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-27 15:21:00', NULL),
(305, 'Ron', 'ron.szukala@gmail.com', '561-459-0724', 'Lendz Financial', 'reliable tool', 'Lender', '100–499 orders / month', '2025-10-28', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-23 10:28:00', NULL),
(306, 'Timothy Bryll', 'bryllappraisal@sbcglobal.net', '4408569289', 'Bryll Appraisal Service', 'I am an Appraiser trying to establish accoun', 'Other', '0–99 orders / month', '2025-10-23', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-23 08:19:00', NULL),
(307, 'Sheikh M Safwan', 'safwan@gmail.com', '03152288535', 'SpurSol', 'Test', 'Lender', '100–499 orders / month', '2025-10-24', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-23 05:30:00', NULL),
(308, 'Kevin', 'kevin.johnson@homewoodag.com', '3183930247', 'Homewood Appraisal Group', 'appraisal work', 'Appraiser', '0–99 orders / month', '2025-10-22', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-22 08:40:00', NULL),
(309, 'Lou Rusert', 'northbay@reaa.org', '7074840608', 'Real Estate Appraisers Association', 'live demo', 'Appraiser', 'Not sure / exploring options', '2025-10-21', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-21 20:47:00', NULL),
(310, 'joanne L DeCabia', 'jdecabia@gmail.com', '9144249356', 'Residential Appraisal Service', 'reset my password', 'Appraiser', '0–99 orders / month', '2025-10-21', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-21 18:30:00', NULL),
(311, 'Kenneth Tuttle', 'ktuttle@cfl.rr.com', '407-402-3131', 'Residential Appraisal Associates', 'Registration', 'Appraiser', '0–99 orders / month', '2025-10-21', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-21 10:30:00', NULL),
(312, 'Ryan Parent', 'ryep111@gmail.com', '818-984-7926', 'SDI Appraisal Services', 'I am looking to start a new AMC and am looking for software solutions for the management of a modern AMC', 'AMC', 'Not sure / exploring options', '2025-10-21', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-21 10:17:00', NULL),
(313, 'Jeff', 'jeffeye1959@gmail.com', '540-333-2190', 'Allegheny Realty', 'Good Morning', 'Appraiser', '0–99 orders / month', '2025-10-21', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-21 07:27:00', NULL),
(314, 'Robyn Adams', 'rradams@comcast.net', '4042770212', 'Adams Residential Appraisal Services', 'orders', 'Appraiser', '0–99 orders / month', '2025-10-21', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-21 01:15:00', NULL),
(315, 'Tim Tolbert', 'appraisaladvant@mindspring.com', '408-886-0464', 'Appraisal Advantage', 'demo instructions', 'Appraiser', '0–99 orders / month', '2025-10-20', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-20 14:11:00', NULL),
(316, 'Richard Clark', 'gulfsure@aol.com', '7273237153', 'Rick Clark Appraisal Serices Inc', 'Appraisal', 'Appraiser', '0–99 orders / month', '2025-10-16', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-16 09:35:00', NULL),
(317, 'Richard Clark', 'gulfsure@aol.com', '7273237153', 'Rick Clark Appraisal Services', '1004', 'Appraiser', '0–99 orders / month', '2025-10-16', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-16 08:42:00', NULL),
(318, 'Byron Lea', 'byronlea@att.net', '9706991748', 'Byron Lea Valuation', 'Account setup', 'Appraiser', '0–99 orders / month', '2025-10-15', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-15 12:06:00', NULL),
(319, 'Kelly Palomba', 'kcresappraisals@gmail.com', '816-550-8915', 'KC-RES Appraisals', 'Appraisal Work', 'Appraiser', '0–99 orders / month', '2025-10-15', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-15 10:59:00', NULL),
(320, 'Kelly Palomba', 'kcresappraisals@gmail.com', '816-550-8915', 'KC-RES Appraisals', 'I\'m looking to be added to your appraiser rotation. I cover Missouri, Kansas and Oklahoma.', 'Appraiser', '0–99 orders / month', '2025-10-15', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-15 10:40:00', NULL),
(321, 'Timothy Bryll', 'bryllappraisal@sbcglobal.net', '4408569289', 'Bryll Appraisal Service', 'Trying to get logged into your system', 'Appraiser', '0–99 orders / month', '2025-10-15', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-15 08:55:00', NULL),
(322, 'Matt Tarter', 'orders.matt@teamtarter.com', '7655958155', 'Tarter Realty Auction & Appraisal Co', 'New appraisal orders', 'Appraiser', '0–99 orders / month', '2025-10-14', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-14 10:27:00', NULL),
(323, 'Greg Hefferan', 'ghefferan@comcast.net', '612-414-7750', 'Greg Hefferan', 'Info on how system works', 'Appraiser', '0–99 orders / month', '2025-10-13', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-13 20:28:00', NULL),
(324, 'Donna Rodgers', 'dcrodgers5178@gmail.com', '408-836-5178', 'Donna Rodgers Appraisal', 'completing 1 to 2 appraisal assignments per week', 'Appraiser', '0–99 orders / month', '2025-10-13', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-13 20:08:00', NULL),
(325, 'Matt Fernandes', 'matt.fernandes@lendinvestorscapital.com', '8058868720', 'Lend Investors Capital', 'an AMS', 'Lender', '100–499 orders / month', '2025-10-10', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-10 16:59:00', NULL),
(326, 'Robert', 'prandall01@gmail.com', '7708612986', 'Robert Randall', 'Residential appraisal orders', 'Appraiser', '0–99 orders / month', '2025-10-09', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-09 12:35:00', NULL),
(327, 'Veronica', 'veronica.vasquez@fsv.gob.sv', '\'+50377425060', 'FSV', 'My name is Verónica Vásquez, and I am reaching out on behalf of the Fondo Social para la Vivienda (FSV), a leading institution in El Salvador dedicated to promoting affordable housing access for low- and middle-income families. At FSV, we work to provide social housing solutions through financing, property development, and management, ensuring compliance with Salvadoran regulations and maximizing the social impact of our operations. Our goal is to maintain efficient and transparent processes that benefit the communities we serve. We are currently evaluating technological solutions to modernize and optimize our real estate valuation processes, ensuring accuracy, efficiency, and regulatory compliance.', 'Appraiser', 'Not sure / exploring options', '2025-10-08', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-08 15:38:00', NULL),
(328, 'Susan B Jackson', 'susancbj@bellsouth.net', '18287759432', 'Associated Appraisal Services', 'Updating my profile', 'Appraiser', '0–99 orders / month', '2025-10-08', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-08 10:56:00', NULL),
(329, 'Jeff Eye', 'jeffeye1959@gmail.com', '540-333-2190', 'Allegheny Realty', 'Appraisal Assignments', 'Appraiser', '0–99 orders / month', '2025-10-08', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-08 08:19:00', NULL),
(330, 'Mark Thomas', 'mark.thomas@lendinvestorscapital.com', '7034733092', 'Lend Investors Capital', 'An AMS Solution', 'Lender', '100–499 orders / month', '2025-10-07', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-07 16:30:00', NULL),
(331, 'Jessy Bowman', 'jbowmanappraisals@gmail.com', '937-216-4689', 'J Bowman Appraisals', 'appraisals around the Dayton & Cincinnati area. Additionally, I cover Miami county & surrounding areas.', 'Appraiser', '0–99 orders / month', '2025-10-07', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-07 09:25:00', NULL),
(332, 'Shawn Lyons', 'indappr@gmail.com', '317-440-2455', 'Indiana Appraisal Service', 'Getting set up to Connect', 'Appraiser', '0–99 orders / month', '2025-10-06', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-06 14:51:00', NULL),
(333, 'Shawn Lyons', 'indappr@gmail.com', '317-440-2455', 'Indiana Appraisal Service', 'Getting set up to Connect', 'Appraiser', '0–99 orders / month', '2025-10-06', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-06 14:34:00', NULL),
(334, 'Julia James', 'jappraisalsllc@gmail.com', '301-491-8910', 'James Appraisals LLC', 'Instructions on setting up a ValueLink Account', 'Appraiser', '0–99 orders / month', '2025-10-05', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-05 19:44:00', NULL),
(335, 'Clayton Hill', 'claytonhill24@icloud.com', '2816368115', 'otss, LLC', 'a way to streamline my appraisal process', 'Appraiser', '100–499 orders / month', '2025-10-05', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-05 08:38:00', NULL),
(336, 'Tanvi Jha', 'officemanager@ciotta-appraisals.com', '5166711400', 'Frank Ciotta Appraisals', 'Demo of Valuelink connect', 'AMC', '100–499 orders / month', '2025-10-07', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-02 09:21:00', NULL),
(337, 'MAGDALENE GREESON', 'ivaluecincy@gmail.com', '1-513-305-7083', 'MAGDALENE GREESON', 'RESIDENTIAL APPRAISAL WORK', 'Appraiser', '0–99 orders / month', '2025-10-01', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-01 15:12:00', NULL),
(338, 'Nancy Shoemaker', 'shoethree@skybest.com', '336-877-7542', 'Shoemaker Appraisal Services', 'orders in Ashe and Watauga counties, NC', 'Appraiser', '0–99 orders / month', '2025-10-01', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-01 13:57:00', NULL),
(339, 'Brenda Shea', 'sheabrenda@gmail.com', '951-264-3333', 'Brenda Shea Appraiser', 'for additional Appraisal work.', 'Appraiser', '0–99 orders / month', '2025-10-01', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-01 13:41:00', NULL),
(340, 'Ryan Lefkowitz', 'ryan@lendoor.com', '6234193484', 'Lendoor', 'an appraisal order solution', 'Lender', '100–499 orders / month', '2025-10-01', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-01 12:18:00', NULL),
(341, 'Jessy Weaver', 'appraiserjessy@gmail.com', '402-620-8563', 'TrueMark Appraisals LLC', 'Conventional orders in Northwest Iowa.', 'Appraiser', '0–99 orders / month', '2025-10-01', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-01 11:26:00', NULL),
(342, 'Nancy Shoemaker', 'shoethree@skybest.com', '336-877-7542', 'Shoemaker Appraisal Services', 'orders in Ashe and Watauga counties, NC', 'Appraiser', '0–99 orders / month', '2025-10-01', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-01 09:40:00', NULL),
(343, 'Eddie Gonzalez', 'eddie.gonzalez@churchillmortgage.com', '615-767-5222', 'Churchill Mortgage', 'Looking at middleware vendors for appraisal ordering. Also, appraisal review via AI', 'Lender', '100–499 orders / month', '2025-09-30', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-09-30 13:22:00', NULL),
(344, 'Sheikh M Safwan', 'safwan@gmail.com', '03152288535', 'SpurSol', 'Lender', 'Lender', '0–99 orders / month', '2025-09-30', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-09-30 01:07:00', NULL),
(345, 'Ryan', 'ryan@lendoor.com', '6234193484', 'Lendoor', 'an appraisal order solution', 'Lender', '0–99 orders / month', '2025-09-29', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-09-29 17:30:00', NULL),
(346, 'Tasia Willhite', 'tasiawillhite@gmail.com', '903-348-6898', 'Willhite Appraisal Company LLC', 'An account to receive orders from a current client switching to this platform for orders.', 'Appraiser', '0–99 orders / month', '2025-09-26', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-09-26 09:52:00', NULL),
(347, 'Sheikh M Safwan', 'safwan@gmail.com', '03152288535', 'SpurSol', 'Test', 'Lender', '0–99 orders / month', '2025-09-27', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-09-26 05:44:00', NULL),
(348, 'Sheikh M Safwan', 'muhammad.safwan@spursol.com', '', 'SpurSol', 'Test', '', '', '2025-09-17', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-09-15 04:41:00', NULL),
(349, 'Imported User', '', '', '', '', '', '', '', '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-08-28 10:01:00', NULL),
(465, 'Mayra Cardona', 'aryamcarzap@gmail.com', '', 'SC INMOBILIARIA', 'me podra pasar informacion precios de su sotfware ValueLink y como lo puedo adquirir', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-04-06 17:40:51', NULL),
(466, 'Shelby Chance', 'cornerstone@appraisebend.com', '', 'Cornerstone Appraisal Group, LLC', 'Is there a way to log into Appraisal Scope and update E&O for all clients?', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-04-01 14:31:40', NULL),
(467, 'Alice', 'alice.monroe@markettechstack.com', '', 'GTU', 'Hi Team,\r\n\r\nWe help businesses connect with companies that match their ICP.\r\n\r\nI was going through your website and wanted to see if companies using CoreLogic Appraisal Management, ACI, Mercury Network, Appraisal Scope, and Anow fall within your target market.\r\n\r\nHappy to share more details if this is relevant.\r\n\r\nBest,\r\nAlice Monroe\r\nBusiness Development Manager\r\n302 520 5097\r\nGTU', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-04-01 12:29:08', NULL),
(468, 'Robert Dale Brogdon', 'brogdonbob@gmail.com', '', 'Bob\'s Appraisal Service', 'Am I already signed up with you guys?\r\nBob Brogdon\r\nBob\'s Appraisal Service\r\nMemphis, TN', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-04-01 10:51:33', NULL),
(469, 'Jossy Rascon', 'jossy@ecoedgejanitorial.com', '', 'EcoEdge Janitorial', 'Hi,\r\n \r\nI was in Houston recently visiting clients and noticed a lot of businesses in the area are tightening up their cleaning standards.\r\n \r\nThat’s exactly where we help — reliable service, detailed inspections, and no headaches.\r\n \r\nWould it be worth a quick quote just to compare? No obligation at all.\r\n \r\nBest,\r\n \r\nJossy Rascon\r\nEcoEdge Janitorial\r\njossy@ecoedgejanitorial.com\r\n \r\nRespond with stop to optout.', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-03-31 18:57:35', NULL),
(470, 'Joy Cole', 'joycole346@gmail.com', '', '', 'I am trying to set up an account so I can access my appraisal orders.  I am an appraiser, not a lender nor an AMC.  HELP!', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-03-30 11:20:03', NULL),
(471, 'faye', 'ohkiki123@gmail.com', '', 'none', 'My account is showing my log on name as NA - not sure why - I am trying to log on and cannot', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-03-27 14:28:04', NULL),
(472, 'Abigail Mitchell', 'abigail.mitchell@carewareit.com', '', 'GTU', 'Hi Team, \r\nWould a list of Encompass users be useful for your campaigns? we can provide key-decision-maker contacts within these companies.\r\nLet me know and I will send over a few samples.\r\nRegards,\r\nAbigail Mitchell\r\nBusiness Development Manager\r\n302 520 5097\r\nGTU', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-03-25 10:45:55', NULL),
(473, 'Zohair', 'zohair.sheikh@valuelinksoftware.com', '', 'VL', 'Test', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-03-24 00:34:15', NULL),
(474, 'Harshit Bhootra', 'info@harshitbhootra.com', '', 'HarshitBhootra', 'Hello, team at Value Link Software,\r\nI am a UI/UX designer with 7+ years of experience. I have created website and app UI’s for\r\nvarious companies worldwide, encompassing business, membership, e-commerce, and\r\ne-learning platforms.\r\nI have an excellent Figma portfolio, which I would love to showcase to you.\r\nI have many success stories and video testimonials to share as well.\r\nI am 100% confident you will love my work once you see it. Let me know if you want me to send\r\nit.\r\nI am looking forward to a positive reply.\r\nThank You\r\nHarshit Bhootra\r\ninfo@harshitbhootra.com', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-03-22 07:51:09', NULL),
(475, 'anthony v califano', 'rangers830@aol.com', '', '', 'please delete my account', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-03-20 14:39:23', NULL),
(476, 'Peter Sutherland', 'peter.sutherland@techuserslists.pro', '', 'LeadProX', 'Hi,\r\n\r\nCame across ValueLink Software and your solutions helping lenders streamline mortgage workflows and improve loan processing.\r\n\r\nWe are a data management firm specializing in tailored lead lists to match your target market. We’ve mapped lenders using Encompass, Calyx, and MeridianLink, enriched with verified decision-maker contacts — including mortgage operations, loan officers, compliance, and IT leads — with emails and direct dials.\r\n\r\nThis dataset can support your outreach to high-fit accounts looking to automate processes, boost compliance, and accelerate loan approvals.\r\n\r\nHappy to share a small sample if helpful.', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-03-19 17:26:14', NULL),
(477, 'Miriam Diago', 'miriam.diago@gmail.com', '', 'BROKER\'S LLC.', 'I need instructions on how to sync my vendor profile with the Value Link software at https://estreetamc.spurams.com/. This is because when I receive BPO orders from https://estreetamc.spurams.com, they do not appear on the https://estreetamc.spurams.com portal.\r\n\r\nThank you very much for your attention to this matter.', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-03-19 14:15:49', NULL),
(478, 'FRANK SPARCAINO', 'franksparacinobpo@gmail.com', '', 'Keller Williams Points North', 'My eStreet account was successfully reinstated on November 26 following the ValueLink disciplinary hold. However, I have not received any broadcast orders since the reinstatement.\r\n\r\nCould you please let me know if there are any additional steps I need to complete on my end to resume receiving orders? For instance, is any additional verification, profile adjustment, or coordination with ValueLink or eStreet required?\r\n\r\nI would greatly appreciate your guidance in helping to resume the normal order flow promptly.\r\n\r\nThank you for your continued support and assistance.', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-03-19 00:17:08', NULL),
(479, 'Joseph Batrich', 'joebatrich@bellsouth.net', '', 'JNB Appraisal Services', 'Valuelink is a scam!  A complete waste of a company bilking money from appraisers and your clients.  I hope you go bankrupt.  I will never do business with Connect by Valuelink ever again and I will let any of your clients know just how shady your business practices are and how bad of a company you are, you all are scum!', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-03-16 18:15:58', NULL),
(480, 'Joseph Batrich', 'joebatrich@bellsouth.net', '', 'JNB Appraisal Services', 'Why am I getting a monthly charge for your software?', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-03-16 11:17:32', NULL),
(481, 'Leanna Rose Gonzalez', 'leanna@farmingmama.com', '', 'Faithful Foundations Realty', 'Good afternoon ,\r\nI am contacting you to expedite the onboarding process for new BPO and asset manager services. I am an experienced vendor working with ServiceLink and AssetValue, holding a QC score of 98%.\r\nI am looking to be added to your list of vendors that service Riverside & San Bernardino counties in Southern California.\r\nI look forward to hearing from you,\r\nLeanna', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-03-16 00:21:10', NULL),
(482, 'Jeffrey Jenkins', 'appraisalservicebyjenkins@yahoo.com', '', 'jenkins appraisal service', 'I am not receiving any emails from you.  I think yahoo is blocking all my emails with attachments or with a site that sends out mass mailing.  I don\'t know whats going on I missed 4 assignments from tamarisk and so I changed my email address to jjenkinsappraisalservice@gmail.com', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-03-12 12:03:19', NULL),
(483, 'Jodi Vinci', 'jvinci@clearmarkvaluation.com', '', 'Clearmark Valuation', 'I have been an appraiser for 27+ years. Recently took a position with a start-up AMC, looking for AMC software. Looking for features and costs.', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-03-10 10:48:09', NULL),
(484, 'Zohair Sheikh', 'zohair.sheikh@valuelinksoftware.com', '', 'VL', 'demo_req', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-03-10 04:38:21', NULL),
(485, 'colette harrington', 'colette.harrington@consultpartner360.com', '', 'consultpartner360.com', 'Are you interested in acquiring the attendee list for RSA Conference 2026 to support your marketing initiatives?\r\n\r\nWith RSA Conference 2026 approaching, this is the perfect opportunity to connect with key decision-makers from the event.\r\n\r\nPlease let me know if this would be of interest—I’d be happy to share the available contact count and pricing details.', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-03-09 07:23:12', NULL),
(486, 'Frank S Moody', 'frankmoody611@gmail.com', '', 'Frank S Moody Appraisals LLC', 'Good afternoon.  I have been using valuelink with the appraisal company I have been working for for several years.  I am leaving to become an independent appraiser and would like to sign on with you.  I already have a profile through the company I am leaving and don\'t know if I need to start over or just transfer what I already have.  Thank you for your help.  I look forward to hearing back from you.', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-03-05 13:04:24', NULL),
(487, 'Ed Remenapp', 'edremenapp@yahoo.com', '', 'Coldwell Banker Professionals', 'I have an order from estreet Appraisal Management. Order # 262-10475\r\n729 Applegate Dr, Marysville, MI 48040\r\nThe order is through ValueLink. \r\nNeed to know how to log in to an account.\r\nPlease Advise.\r\nEd Remenapp\r\n313-969-0021', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-02-28 11:35:15', NULL),
(488, 'EDDY MITZEL', 'legendaryappraisal@gmail.com', '', 'Legendary Appraisal', 'need help to log in', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-02-25 13:37:24', NULL),
(489, 'Larry G Wilson', 'comappraisal@comcast.net', '', 'Community Appraisal, INC', 'How do I submit a quote?', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-02-24 11:13:09', NULL),
(490, 'Spencer B. Humphrey', 'humphreyhere@pon.net', '', 'Spencer B. Humphrey & Associates', 'I have received a message that you have had trouble getting in touch with me. If it helps my phone number is: (707) 585-0987.\r\n\r\nSpencer B. Humphrey', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-02-23 18:15:32', NULL),
(491, 'timothy mustard', 'discoapp@comcast.net', '', 'discovery appraisal services', 'i need to reach help but the entire 888 587 0805 number goes directly to an automatic answering message to give me a free emergency alert system.  i cannot receive the help with cmg mortgage I need.  I\'ve received an appraisal order which I cannot properly accept, make an appointment and perform.  Help please  this is a mess and I\'ve wasted over an hour with it.\r\n\r\nTimothy I Mustard, owner of Discovery Appraisal services, 925 998 9855  Please respond', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-02-18 16:23:44', NULL),
(492, 'Alexander Harris', 'aharris@urbaninformationservices.com', '', 'Urban Information Services, Inc.', 'Please remove me from your system.  I don\'t need to pay an appraiser management company for work.  Thank you.', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-02-09 20:11:28', NULL),
(493, 'Chris Lesnik', 'clesnik@brrrr.com', '', 'Brrrr Loans', 'Hello - I submitted a form for a demo last week but was never contacted by anyone. My cell is (732) 804-0939, you can reach me there or via email. Thank you', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-02-09 08:27:21', NULL),
(494, 'Julie Peak', 'juliekpeak@gmail.com', '', 'Northwoods Real Estate Group L', 'Need help logging into E Street to accept orders for appraisals', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-02-02 12:55:48', NULL),
(495, 'Tracie Grant', 'tgrant@metrocast.net', '', 'Elite Appraisals', 'You have de-activated my account so I can sign up[ as an individual account and it says my email has already been used.  please advise.\r\n\r\nThank you.', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-02-02 06:25:11', NULL),
(496, 'Christopher D Arnt', 'chrisarntcra@gmail.com', '', 'CDA Appraisal Services', 'There is no easily accessible link on the mail valuelinsoftware page for appraisers to login to their profiles.  Please put one up by the top.', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-01-22 10:29:08', NULL),
(497, 'Valentina Martirena', 'valentina.martirena@altisource.com', '', 'Altisource Solutions', 'Hello. We are evaluating platforms to support our valuation workflow (appraisals, hybrids, BPOs, AVMs). We need customizable forms with auto‑populated fields, images/maps, and robust document handling.\r\nAutomation is key: rules‑based assignment, queues, exclusions, and vendor management controls. Reporting (SLA, productivity, financials) and integrations with tools like RealEC, ProxyPics, PPW are required. We’re in early assessment and would like a general pricing overview (per user, per volume, per module, tiered, etc.). Could I please be contacted at my email by a sales rep? Thank you.', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-01-21 09:18:08', NULL),
(498, 'GEORGE PORTER', 'gpsouthland@gmail.com', '', 'SOUTHLAND APPRAISERS AKA H & P APPRAISALS LLC', 'NO PHONE??ASK FOR QUOTE NO PLACE TO PUT FEE JUST TAKE ME OFF YOUR LIST UNTIL YOU REPLACE THE 3RD GRADER THAT DID YOUR FORMS I WORK 12 COUNTIES HAVE DONE 10,000  AND YOU WANT TO CHARGE ME 20 A MONTH YOUR NUTS AND WE ARE GONE', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-01-16 11:28:09', NULL),
(499, 'Doug Ledewitz', 'doug@pulserealty.com', '', 'Pulse Realty LLC', 'Hello - I\'m emailing to see if your company works with real estate brokers to complete BPOs or other valuations. Am looking to partner with you if possible. Thank you.', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-01-12 18:22:50', NULL),
(500, 'Ben Yau', 'benjaminyau@hotmail.com', '', 'Benjamin Yau', 'It looks like I am being double charge for your service because beside value charge me $19,95 months, lenders also deducted a fee for technology per order. would you please help me clarify this.\r\n\r\nThx\r\nBen\r\n(415)378-3711', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-01-09 19:27:25', NULL),
(501, 'Deb Daniels', 'casddaniels@comcast.net', '', 'Complete Appraisal Solutions, LLC', 'I have added my new license many times to my link... can you please check it..', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-01-09 12:10:34', NULL),
(502, 'Francis T Mccarthy', 'mccarthyappraisalsny@gmail.com', '', 'mccarthy appraisals', 'lic number  ny 045450327  its said i am already registered', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-01-08 12:01:08', NULL),
(503, 'Stacey Roberts', 'stacey@valuevirginia.com', '', 'Value Virginia Appraisal Services, LLC', 'Hello, I am a certified appraiser on your panel. I recently renewed my E&O Insurance. I\'m not sure how to update my profile with this information. Can you let me know the correct procedure or contact. Thanks!', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-01-07 12:07:13', NULL),
(504, 'Zoe Dyer', 'zoe@apexpurefacilities.com', '', 'ApexPure Facilities', 'Are you interested in a straightforward cleaning quote that meets your company\'s specific needs? Our team has earned countless awards for not only the quality of our cleaning services but also the support we offer our customers. May I give you more information? I\'d be available to provide a no-obligation cleaning estimate based on your cleaning expectations and specifications. \r\n\r\nAll the best,\r\n\r\nZoe Dyer\r\nBusiness Development Rep\r\nApexPure Facilities\r\nzoe@apexpurefacilities.com\r\n\r\nRespond with stop to optout.', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-01-06 19:17:24', NULL),
(505, 'Lois Ellis', 'lois9811@msn.com', '', 'Lois Ellis', 'I received on 08/04/2025 an email reporting that I had completed 99 orders and earned $42,950 in revenue.  is it possible to get another email reflecting total orders for all of 2025 and amount of revenue.  I would appreciate it!', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-01-06 12:41:07', NULL),
(506, 'Rick Rostkowski', 'rick@janprohoustonclean.com', '', 'Jan-Pro of Houston', 'Would it be helpful to provide you with an updated cleaning quote for your business?\r\n\r\nWe are working with several businesses in the area who say our reliability and attention to detail sets us apart.\r\n\r\nWith your permission, I can provide a site visit, strategy and cleaning quote that will take care of all your facility needs.\r\n\r\nAll the best,\r\n\r\nRick Rostkowski\r\nVP, General Manager\r\nJan-Pro of Houston\r\nrick@janprohoustonclean.com\r\n\r\nAnyone who needs somebody for commercial cleaning this is the place I recommend. They work on everything in a timely and thorough manner. They are worth every penny and dime. Take advantage. I strongly recommend! - Nathan Cervantes\r\n\r\nRespond with stop to optout', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-01-06 09:15:39', NULL),
(507, 'Lesley Piper', 'lesleypiperali@gmail.com', '', 'LA Appraisals', 'Please stop sending me a request for payment. I don\'t complete appraisals for you and I never have.', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-01-05 14:20:25', NULL),
(508, 'Mary OBrien', 'tncappraisal@comcast.net', '', 'TNC Appraisal Service, Inc', 'Im trying to log into A2U to reset Marys Password and add her Renewed License and i cant log in', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-01-05 13:54:22', NULL),
(509, 'Jeffrey Johnson', 'jcomstl@sbcglobal.net', '', 'Johnson Commercial', 'Interested in learning more about your software', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-01-03 22:30:46', NULL),
(510, 'Erick Leal', 'el478092@gmail.com', '', 'Self', 'Happy new year! My name is Erick Leal and I am trying to contact someone in regards to the job posting on Linkedin for the Sales Position. I would love to hear back from someone regarding this opportunity. Please call me at 281-919-6130. Thank you in advance for this amazing opportunity.', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-01-02 16:46:50', NULL),
(511, 'Joseph Schulte', 'schulteappraisals@hotmail.com', '', 'Schulte Appraisals', 'I have an issue with connect. I am a part time staff appraiser for Opteon USA and I also have my own company. Since connect was used my orders for Schulteappraisals are mixed up with Opteon. My client got an invoice from Opteon for an order that is not theirs. I also got a check for Opteon that has my old address on it. I need some help please I have report due and I can’t get it out with Opteons name all over it', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-28 17:03:32', NULL),
(512, 'Amelia Hughes', 'amelia@cleaneliteco.com', '', 'CleanElite Co.', 'Are you interested in a straightforward cleaning quote that meets your company\'s specific needs? Our team has earned countless awards for not only the quality of our cleaning services but also the support we offer our customers. May I give you more information? I\'d be available to provide a no-obligation cleaning estimate based on your cleaning expectations and specifications. \r\n\r\nAll the best,\r\n\r\nAmelia Hughes\r\nBusiness Development Rep\r\nCleanElite Co.\r\namelia@cleaneliteco.com\r\n\r\nRespond with stop to optout.', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-25 05:51:52', NULL);
INSERT INTO `leads` (`id`, `client_name`, `email`, `phone`, `company`, `message`, `user_role`, `order_volume`, `preferred_date`, `event_title`, `source`, `form_name`, `submission_url`, `status`, `created_at`, `qualification_scale`) VALUES
(513, 'John V LeClair', 'jvleclair53@gmail.com', '', 'JVL Real Estate Appraisal and Consulting', 'I was asked to join Connect to receive orders from Central State Appraisal Services. When I tried to sign up it said I had an account using my name and NYS Certified Residential number but not my email. I need help to find out what this is all about. Thanks.', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-23 12:53:42', NULL),
(514, 'Clint Sturgill', 'cds1macys@yahoo.com', '', '', 'I got this from the Ohio lottery for redeeming points when I went to print it out it was a digital gift card, but I cut off half the numbers. I tried scanning the QR code. It doesn’t give me what the numbers are. Are you able to help me retrieve this? I could send you the QR code and the numbers in the pictures.Thank you so', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-22 19:57:22', NULL),
(515, 'United Wholesale', 'freddie@uwm.com', '', 'United WS', 'Looking to setup a demo.', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-22 13:09:16', NULL),
(516, 'Anthony Pombal', 'anthony@retconference.com', '', 'RETCON', 'Hi there! Can you please connect me to somebody in marketing regarding the opportunity for your company to join RETCON 2026 – real estate\'s leading innovation conference? Opportunities are filling up and I’d love for you all to be able to take advantage. RETCON 2026 is taking place at the MGM Grand in Las Vegas on March 9-11 and features 2250+ executives and innovation leaders from the country\'s largest property owners, operators and developers. Over 300+ speakers and 150+ sponsors will participate. We have tracks covering multifamily, office, retail, industrial, transformation, AI, investment & asset management, and more. Is your company interested in exploring sponsorship opportunities – including speaking roles, booths, guaranteed 1-1 meetings, and curated roundtables? The event is quickly selling out, so let me know soon! I can send sample attendee snapshots. https://retconference.com/  - Thanks! Anthony.', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-21 22:29:51', NULL),
(517, 'Sheree Alexander', 'sheree_d_alexander@homedepot.com', '', 'The Home Depot', 'Leaders, \r\n\r\nThanks so much for the thoughtfulness, it does not go unnoticed and is very much appreciated!  Happy holidays to each of you and yours❤️', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-19 14:50:45', NULL),
(518, 'Bella', 'bella@aaalendings.com', '', 'AAA Capital Investment, Inc.', 'There is a login issue. Authentication code could not be sent', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-17 11:01:51', NULL),
(519, 'Matt Connors', 'mattconnors@fusaca.com', '', 'FUNERAL SHIPPING AND CONSULATE ASSISTANT LLC', 'I will like to learn about your payment solutions', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-12 15:33:07', NULL),
(520, 'Rick Rostkowski', 'rick@janprohoustonclean.com', '', 'Jan-Pro of Houston', 'Hi,\r\n \r\nI am near you and live in Houston, and work for some of your neighbors. I was hoping I could come by and offer a complimentary cleaning bid? I can also do so over email.\r\n \r\nThank you in advance for your response.\r\n \r\nWith best,\r\n\r\nRick Rostkowski\r\nVP, General Manager\r\nJan-Pro of Houston\r\nrick@janprohoustonclean.com\r\n\r\nAnyone who needs somebody for commercial cleaning this is the place I recommend. They work on everything in a timely and thorough manner. They are worth every penny and dime. Take advantage. I strongly recommend! - Nathan Cervantes\r\n\r\nRespond with stop to optout', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-12 10:18:58', NULL),
(521, 'Maureen Rucker', 'maureen.r@theprofessionalprofiles.com', '', 'The Professional Profiles', 'Wikipedia is considered to be the World’s most significant tool for reference material. The Wiki links show up on the 1st page of Google 97% of the time. With a Page on one of the most revered reference tools, you are sure to get yourself or your business noticed. So if you\'re thinking of getting a Wikipedia Page created, it\'s the best time of the year.\r\n\r\nIf you are interested in getting more information just respond back to this email.\r\n\r\nThanks,\r\n\r\nMaureen Rucker\r\nThe Professional Profiles\r\nMaureen.r@theprofessionalprofiles.com\r\n\r\nRespond with stop to optout.', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-04 10:15:57', NULL),
(522, 'Adam LoPresti', 'adamlopresti.wyo@gmail.com', '', 'Brooks Appraisals', 'I have an account with ValueLink as an appraiser, however I have been unable to log in to my account. I have requested submitted a password recovery request, but never receive an email to reset the password. The email associated with the account is likely bebrooks2@vcn.com, however I am switching to alopresti.wyo@gmail.com. Thanks for your help!', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-03 15:23:40', NULL),
(523, 'Matthew George', 'eagleappraisals@comcast.net', '', 'Eagle Appraisals, Inc', 'I received an alert to update my insurance. When I log into my account and go to my profile, there is no place to upload the insurance.', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-02 11:11:00', NULL),
(524, 'Peter Liapis', 'pjliapis@gmail.com', '', 'Peter John Liapis Enterprises', 'I am not quite sure why my account being deactivated?? My card is still good??', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-11-30 14:41:30', NULL),
(525, 'Robin Leclaire', 'robinwainleclaire@verizon.net', '', '', 'Gift card no working', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-11-26 14:10:24', NULL),
(526, 'Gregg R Brooks', 'gbs603@comcast.net', '', 'Brooks Appraisal Services LLC', 'future 3.6 trainings ?', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-11-25 15:36:02', NULL),
(527, 'Jossy Rascon', 'jossy@ecoedgejanitorial.com', '', 'EcoEdge Janitorial', 'Hi,\r\n \r\nI am local and provide service in Houston And work for others in the community. I was hoping I could come by and offer a complimentary cleaning bid? I can also do so over email.\r\n \r\nThank you in advance for your response.\r\n \r\nWith best,\r\n\r\nJossy Rascon\r\nBusiness Development Rep\r\nEcoEdge Janitorial\r\njossy@ecoedgejanitorial.com\r\n\r\nRespond with stop to optout.', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-11-24 16:08:38', NULL),
(528, 'Yolanda Burrell', 'yolandaburrell75@gmail.com', '', 'Yolanda L Burrell', 'I\'m appraiser looking to add more lenders to my profile, so I can receive more appraisal orders. Please advise. Thanks 562 824-7373', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-11-19 13:27:26', NULL),
(529, 'John Shaffer', 'skylineappraisals@hotmail.com', '', 'Skyline Appraisals, Inc.', 'My first time logging in.  I have an order from United Bank that I need to access.  I do not know how to reach my orders.  Thanks!', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-11-18 11:02:55', NULL),
(530, 'Jennifer Ferguson', 'jfvaluation@gmail.com', '', 'JF Appraisals', 'I believe I am already one of your vendors however I do not see my profile setup. Please advise.', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-11-11 14:54:46', NULL),
(531, 'Keith Nelson', 'knelson@calhounsands.com', '', 'Retail Petroleum Group, LLC', 'I was charged $19.99 and I have no idea what it\'s for.  Please remove me from your automatic billing and please refund me for this $19.99 charge that i have no idea what it\'s for.  Thank you', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-11-03 07:14:45', NULL),
(532, 'Ann Kelley', 'orders@wentworthappraisal.net', '', 'Wentworth Appraisal', 'Please remove me from your list, close my account, I no longer want to be on your platform and I want to remove my CC info from your website immediately.', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-11-02 17:12:30', NULL),
(533, 'John Noonan', 'jnoonan@cbresolutions.com', '', 'CBRES', 'We currently use Appraisal Scope and need to be able to integrate with Value Link in order to service a new client  - - NQM Funding out of FL.\r\n\r\nPlease advise what steps are need to make this work - Thank you', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-31 10:00:49', NULL),
(534, 'Jennifer C Newton', 'jennewton23@gmail.com', '', 'Newton Appraisal Service', 'Having a problem getting a new password to work.', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-22 17:52:20', NULL),
(535, 'David E Ciszek', 'dave@davidciszek.com', '', 'David Ciszek, Broker', 'I do appraisals for ESUSA. Lately, I have NOT been able to bid on an order unless I provide a credit card. NOWHERE in our industry does anyone else require I given you my credit card number. I have had my identity stolen 3 times and this requirement appears to me to be some sort of fraud attempt. Please correct if you indeed have the ability to do so. \r\nSincerely, David Ciszek, JD.', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-21 16:52:54', NULL),
(536, 'Susan Alley', 'susan@appraisalaid.com', '', 'Appraisal Aid', 'I’m reaching out because we support AMCs with USPAP compliance reviews and related compliance initiatives. I’d love to learn more about your internal compliance tools and workflow capabilities for our clients who use ValueLink.  \r\n\r\nMy goal is to better understand how our clients can fully utilize the features already available within your platform. The more value they find in your system, the stronger both of our relationships become — a true win-win for everyone involved.\r\n\r\nIf there’s someone on your team I could connect with for a brief call or overview, I’d really appreciate it.  Have a fantastic day!', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-17 09:38:52', NULL),
(537, 'Sheri Efseaff', 'sheri_efseaff@outlook.com', '', 'Sheri Efseaff', 'I am an appraiser.  I currently work with GEM Mortgage.  They asked me to set up a Valuelink account, however, I have an old one under my old email address which is Sheri_Efseaff@roadrunner.com.  I can\'t log in because I no longer have that email address and when I go to request to change the password, it sends the message to my old email address.  Is there a way to change my user name/email address so I can access my account?\r\n\r\nSincerely,\r\n\r\nSheri Efseaff\r\n714/342-0255\r\nSheri_Efseaff@outlook.com', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-14 20:10:00', NULL),
(538, 'Katie Rozman', 'katie@hdaappraisal.com', '', 'HDA Appraisal', 'My former employer is taking work in my name.  I\'ve found tow of the AMCs on your network I had worked with in the past and was able to update with them.  \r\n\r\nI\'d like to find out if there is a way for me to find out the other AMCs that my prior profile had, so that I can contact them to update my details.\r\n\r\nToday, I won a bid on the system and my prior company was able to get to my work, told the client I didn\'t work for them anymore and then requested the assignment be reassigned!  It was shocking that Chudnow Druck was able to access my account!\r\n\r\nI\'d like to determine how I can separate myself from Chudnow Druck Valuation in all ways, so there is no confusion. \r\n\r\n\r\n\r\nThanks so much!\r\n\r\nKate', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-09 19:18:33', NULL),
(539, 'Michael Stone', 'mstone@icecapgroup.com', '', 'IceCap Group', 'I’m the CTO of the IceCap Group and we’re interested in integrating with your API to order appraisals, and we’re also interested in obtaining the original XML data from appraisals that we’re ordered for us, but not by us. From our understanding, we should have access to those appraisals that were ordered for our company, but we’d like to know if there’s an option to obtain the original XML file so we can have the raw data instead of just the appraisal document. \r\n\r\nThanks', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-09 16:59:54', NULL),
(540, 'Rick Rigdon', 'rick7945@gmail.com', '', '', 'Forgot username and password', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-08 15:39:20', NULL),
(541, 'Dennis R Chaissan', 'dchaissan@gmail.com', '', 'Dennis Appraisal Services', 'The sign up link for joining Connect does not seem to work.', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-07 13:45:37', NULL),
(542, 'David Lane', 'david.lane@veloxval.com', '', 'Velox Valuations', 'Need help with several things in my profile. Thank you, David Lane 619-665-4291', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-06 18:06:50', NULL),
(543, 'Robin Leonard', 'appraisals@appraisalsva.com', '', 'Appraisal Services of Virginia', 'I am looking for an appraisal management program for our office, and I like the way Connect works for our internal staff. A huge bonus that it connects to Total, but the biggest piece I need and can\'t seem to find with any appraisal management software is the ability to link to QuickBooks Online. Is that possible with Connect, through direct integration with QBO, or with a third-party software such as Maker?', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-01 19:34:38', NULL),
(544, 'Dennis Poole', 'pooleaz@aol.com', '', 'Sierra Appraisal LLC', 'Tried to update my password and now cannot sign-in. Please update my password if possible. TY', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-09-26 17:58:49', NULL),
(545, 'Sheikh M Safwan', 'muhammad.safwan@spursol.com', '', 'SpurSol', 'Test Message', '', '', '', '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-09-06 03:48:14', NULL),
(546, 'Amy Moss', 'amoss@cortrustbank.com', '', 'CorTrust Mortgage', '', '', '', '', '', 'CSV Import', 'Events Form', NULL, 'new', '2026-03-09 10:06:00', NULL),
(547, 'Amy Moss', 'amoss@cortrustbank.com', '', 'CorTrust Mortgage, Inc.', '', '', '', '', '', 'CSV Import', 'Events Form', NULL, 'new', '2026-03-06 11:10:00', NULL),
(548, 'Sheikh M Safwan', 'muhammad.safwan@spursol.com', '', 'SpurSol', 'Test', '', '', '', '', 'CSV Import', 'Events Form', NULL, 'new', '2026-01-22 07:03:00', NULL),
(549, 'Sheikh M Safwan', 'muhammad.safwan@spursol.com', '', 'SpurSol', 'test', '', '', '', '', 'CSV Import', 'Events Form', NULL, 'new', '2026-01-08 05:04:00', NULL),
(550, 'ValueLink Software', 'marketing@valuelinksoftware.com', '', 'SpurSol', 'Testing form', '', '', '', '', 'CSV Import', 'Events Form', NULL, 'new', '2025-10-02 06:08:00', NULL),
(551, 'Jonathan Gifford', 'jgifford@inspirehomeloans.com', '', 'Inspire Home Loans', 'Interested in spending 15 minutes seeing a demo of your product.', '', '', '', '', 'CSV Import', 'Events Form', NULL, 'new', '2025-09-30 12:36:00', NULL),
(552, 'Sheikh M Safwan', 'safwan@gmail.com', '', 'SpurSol', 'Test', '', '', '', '', 'CSV Import', 'Events Form', NULL, 'new', '2025-09-29 08:19:00', NULL),
(553, 'Sheikh M Safwan', 'muhammad.safwan@spursol.com', '', 'SpurSol', 'Test Message', '', '', '', '', 'CSV Import', 'Events Form', NULL, 'new', '2025-09-11 06:02:00', NULL),
(554, 'Sheikh M Safwan', 'muhammad.safwan@spursol.com', '', 'SpurSol', 'Test 2', '', '', '', '', 'CSV Import', 'Events Form', NULL, 'new', '2025-08-20 15:49:00', NULL),
(555, 'Sheikh M Safwan', 'muhammad.safwan@spursol.com', '', 'SpurSol', 'Test on Staging', '', '', '', '', 'CSV Import', 'Events Form', NULL, 'new', '2025-08-20 15:40:00', NULL),
(556, 'Imported User', 'joxendine@harvestersfcu.com', '', '', '', '', '', '', '', 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2026-03-30 08:29:52', NULL),
(557, 'Imported User', 'cherylharrington53@gmail.com', '', '', '', '', '', '', '', 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2026-03-27 10:47:37', NULL),
(558, 'Imported User', 'canfield86@gmail.com', '', '', '', '', '', '', '', 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2026-03-06 18:30:14', NULL),
(559, 'Imported User', 'edremenapp@yahoo.com', '', '', '', '', '', '', '', 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2026-03-03 12:51:03', NULL),
(560, 'Imported User', 'mstepanovich@guardianassetmgt.com', '', '', '', '', '', '', '', 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2026-02-25 17:26:48', NULL),
(561, 'Imported User', 'leonie.tait@rpsrealsolutions.com', '', '', '', '', '', '', '', 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2026-02-12 16:25:42', NULL),
(562, 'Imported User', 'melissa.curtis@valuelinksoftware.com', '', '', '', '', '', '', '', 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2026-02-04 14:20:26', NULL),
(563, 'Imported User', 'batonrougeappraiser@gmail.com', '', '', '', '', '', '', '', 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2026-01-24 21:47:03', NULL),
(564, 'Imported User', 'peterbutcher76@gmail.com', '', '', '', '', '', '', '', 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2026-01-21 05:57:35', NULL),
(565, 'Imported User', 'fordappraisal@gmail.com', '', '', '', '', '', '', '', 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2025-12-24 13:39:22', NULL),
(566, 'Imported User', 'glehnes@bridgeamc.com', '', '', '', '', '', '', '', 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2025-12-17 11:10:14', NULL),
(567, 'Imported User', 'tjswider@creditlenders.com', '', '', '', '', '', '', '', 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2025-10-27 13:28:29', NULL),
(568, 'Imported User', 'jshives@samco-amc.com', '', '', '', '', '', '', '', 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2025-10-16 10:21:12', NULL),
(569, 'Imported User', 'j@yopmail.com', '', '', '', '', '', '', '', 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2025-10-14 14:53:14', NULL),
(570, 'Imported User', 'david.carroll@pnc.com', '', '', '', '', '', '', '', 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2025-10-13 19:36:39', NULL),
(571, 'Imported User', 'chris.hunt@valuationnexus.com', '', '', '', '', '', '', '', 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2025-10-07 13:19:38', NULL),
(572, 'Amy Moss', 'amoss@cortrustbank.com', '', 'CorTrust Mortgage', '', '', '', '', '', 'CSV Import', 'Events Form', NULL, 'new', '2026-03-09 10:06:00', NULL),
(573, 'Amy Moss', 'amoss@cortrustbank.com', '', 'CorTrust Mortgage, Inc.', '', '', '', '', '', 'CSV Import', 'Events Form', NULL, 'new', '2026-03-06 11:10:00', NULL),
(574, 'Sheikh M Safwan', 'muhammad.safwan@spursol.com', '', 'SpurSol', 'Test', '', '', '', '', 'CSV Import', 'Events Form', NULL, 'new', '2026-01-22 07:03:00', NULL),
(575, 'Sheikh M Safwan', 'muhammad.safwan@spursol.com', '', 'SpurSol', 'test', '', '', '', '', 'CSV Import', 'Events Form', NULL, 'new', '2026-01-08 05:04:00', NULL),
(576, 'ValueLink Software', 'marketing@valuelinksoftware.com', '', 'SpurSol', 'Testing form', '', '', '', '', 'CSV Import', 'Events Form', NULL, 'new', '2025-10-02 06:08:00', NULL),
(577, 'Jonathan Gifford', 'jgifford@inspirehomeloans.com', '', 'Inspire Home Loans', 'Interested in spending 15 minutes seeing a demo of your product.', '', '', '', '', 'CSV Import', 'Events Form', NULL, 'new', '2025-09-30 12:36:00', NULL),
(578, 'Sheikh M Safwan', 'safwan@gmail.com', '', 'SpurSol', 'Test', '', '', '', '', 'CSV Import', 'Events Form', NULL, 'new', '2025-09-29 08:19:00', NULL),
(579, 'Sheikh M Safwan', 'muhammad.safwan@spursol.com', '', 'SpurSol', 'Test Message', '', '', '', '', 'CSV Import', 'Events Form', NULL, 'new', '2025-09-11 06:02:00', NULL),
(580, 'Sheikh M Safwan', 'muhammad.safwan@spursol.com', '', 'SpurSol', 'Test 2', '', '', '', '', 'CSV Import', 'Events Form', NULL, 'new', '2025-08-20 15:49:00', NULL),
(581, 'Sheikh M Safwan', 'muhammad.safwan@spursol.com', '', 'SpurSol', 'Test on Staging', '', '', '', '', 'CSV Import', 'Events Form', NULL, 'new', '2025-08-20 15:40:00', NULL);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=582;

--
-- AUTO_INCREMENT for table `lead_notes`
--
ALTER TABLE `lead_notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
