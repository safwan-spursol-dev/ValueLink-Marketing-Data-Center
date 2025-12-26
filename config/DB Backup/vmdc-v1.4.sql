-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 26, 2025 at 09:49 PM
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
(9, 1, 6, 'kazim', 'kazim@gmail.com', NULL, '2025-12-23 20:31:29', 'Deleted', 'Permanently deleted the lead.', '2025-12-23 20:08:06'),
(10, 1, 5, 'kazim', 'kazim@gmail.com', NULL, '2025-12-23 20:31:24', 'Note Added', 'Added a new note: helo...', '2025-12-23 21:11:33'),
(11, 1, 5, 'kazim', 'kazim@gmail.com', NULL, '2025-12-23 20:31:24', 'Status Update', 'Changed status from \'New\' to \'Converted\'', '2025-12-23 21:11:45'),
(12, 1, 5, 'kazim', 'kazim@gmail.com', NULL, '2025-12-23 20:31:24', 'Deleted', 'Permanently deleted the lead.', '2025-12-23 21:14:05'),
(13, 1, 1, 'Brett Jerhoff', 'bjerhoff@cfmtg.com', 'Demo Request Form', '2025-12-21 02:20:21', 'Deleted', 'Permanently deleted the lead.', '2025-12-23 21:14:10'),
(14, 1, 2, 'Stephanie Gunter', 'sgunter@southlandcu.org', 'Event Form', '2025-12-21 02:20:21', 'Deleted', 'Permanently deleted the lead.', '2025-12-23 21:14:14'),
(15, 1, 3, 'Mark Hance', 'mark.hance@baseleaddata.com', 'Contact US form', '2025-12-21 02:20:21', 'Deleted', 'Permanently deleted the lead.', '2025-12-23 21:14:19'),
(16, 1, 4, 'Jansh Brown', 'jansh@testing.com', 'Demo Request Form', '2025-12-21 02:20:21', 'Deleted', 'Permanently deleted the lead.', '2025-12-23 21:14:22'),
(17, 1, 16, 'System Administrator', 'admin@system.com', 'CSV Import', '2023-12-27 18:45:00', 'Deleted', 'Permanently deleted the lead.', '2025-12-23 21:14:27'),
(18, 1, 15, 'Ayesha Omar', 'partner@globalbiz.com', 'CSV Import', '2023-12-26 15:00:00', 'Deleted', 'Permanently deleted the lead.', '2025-12-23 21:14:30'),
(19, 1, 14, 'Usman Qureshi', 'sales@retailking.com', 'CSV Import', '2023-12-26 13:30:00', 'Deleted', 'Permanently deleted the lead.', '2025-12-23 21:14:34'),
(20, 1, 13, 'Fahad Mustafa', 'no_message_user@domain.com', 'CSV Import', '2023-12-25 12:00:00', 'Deleted', 'Permanently deleted the lead.', '2025-12-23 21:14:37'),
(21, 1, 12, 'John Doe', 'tester6@qa-team.com', 'CSV Import', '2023-12-25 08:10:00', 'Deleted', 'Permanently deleted the lead.', '2025-12-23 21:14:42'),
(22, 1, 11, 'Hamza Yousuf', 'hamza@realestate.com', 'CSV Import', '2023-12-24 16:20:00', 'Deleted', 'Permanently deleted the lead.', '2025-12-23 21:14:46'),
(23, 1, 10, 'Zainab Malik', 'info@startup.io', 'CSV Import', '2023-12-23 11:45:00', 'Deleted', 'Permanently deleted the lead.', '2025-12-23 21:14:49'),
(24, 1, 9, 'Ahmed Bilal', 'ahmed.bilal@construction.pk', 'CSV Import', '2023-12-22 09:00:00', 'Deleted', 'Permanently deleted the lead.', '2025-12-23 21:14:51'),
(25, 1, 8, 'Sara Khan', 'sara.k@designstudio.com', 'CSV Import', '2023-12-21 14:15:00', 'Deleted', 'Permanently deleted the lead.', '2025-12-23 21:14:54'),
(26, 1, 7, 'Ali Raza', 'test_user1@example.com', 'CSV Import', '2023-12-20 10:30:00', 'Deleted', 'Permanently deleted the lead.', '2025-12-23 21:15:00'),
(27, 8, 370, 'Imported User', 'ncandm@gmail.com', 'CSV Import', '2025-12-24 18:03:22', 'Status Update', 'Changed status from \'New\' to \'In_progress\'', '2025-12-24 13:48:31'),
(28, 8, 371, 'Imported User', '03151182258', 'CSV Import', '2025-12-24 18:03:22', 'Status Update', 'Changed status from \'New\' to \'Converted\'', '2025-12-24 13:48:43'),
(29, 8, 372, 'Imported User', '6313961815', 'CSV Import', '2025-12-24 18:03:22', 'Status Update', 'Changed status from \'New\' to \'Converted\'', '2025-12-24 13:48:58'),
(30, 8, 427, 'Bella', 'bella@aaalendings.com', 'CSV Import', '2025-12-17 16:01:51', 'Status Update', 'Changed status from \'New\' to \'Converted\'', '2025-12-24 13:49:44'),
(31, 8, 423, 'Clint Sturgill', 'cds1macys@yahoo.com', 'CSV Import', '2025-12-23 00:57:22', 'Status Update', 'Changed status from \'New\' to \'Lost\'', '2025-12-24 13:50:50'),
(32, 8, 424, 'United Wholesale', 'freddie@uwm.com', 'CSV Import', '2025-12-22 18:09:16', 'Status Update', 'Changed status from \'New\' to \'Lost\'', '2025-12-24 13:51:02'),
(33, 1, 370, 'Imported User', 'ncandm@gmail.com', 'CSV Import', '2025-12-24 18:03:22', 'Status Update', 'Changed status from \'In_progress\' to \'Converted\'', '2025-12-24 14:37:51'),
(34, 1, 255, 'Imported User', '', 'Contact Us Form', '2025-12-26 21:22:03', 'Deleted', 'Permanently deleted the lead.', '2025-12-26 20:22:55'),
(35, 1, 256, 'Imported User', '', 'Contact Us Form', '2025-12-26 21:22:03', 'Deleted', 'Permanently deleted the lead.', '2025-12-26 20:22:59'),
(36, 1, 257, 'Imported User', '', 'Contact Us Form', '2025-12-26 21:22:03', 'Deleted', 'Permanently deleted the lead.', '2025-12-26 20:23:03'),
(37, 1, 254, 'Imported User', '', 'Contact Us Form', '2025-12-26 21:22:03', 'Deleted', 'Permanently deleted the lead.', '2025-12-26 20:23:09');

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
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `assigned_to` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `leads`
--

INSERT INTO `leads` (`id`, `client_name`, `email`, `phone`, `company`, `message`, `user_role`, `order_volume`, `preferred_date`, `event_title`, `source`, `form_name`, `submission_url`, `status`, `created_at`, `assigned_to`) VALUES
(1, 'John V LeClair', 'jvleclair53@gmail.com', '', 'JVL Real Estate Appraisal and Consulting', 'I was asked to join Connect to receive orders from Central State Appraisal Services. When I tried to sign up it said I had an account using my name and NYS Certified Residential number but not my email. I need help to find out what this is all about. Thanks.', '', '', NULL, NULL, 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-23 12:53:00', NULL),
(2, 'Clint Sturgill', 'cds1macys@yahoo.com', '', '', 'I got this from the Ohio lottery for redeeming points when I went to print it out it was a digital gift card, but I cut off half the numbers. I tried scanning the QR code. It doesn?t give me what the numbers are. Are you able to help me retrieve this? I could send you the QR code and the numbers in the pictures.Thank you so', '', '', NULL, NULL, 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-22 19:57:00', NULL),
(3, 'United Wholesale', 'freddie@uwm.com', '', 'United WS', 'Looking to setup a demo.', '', '', NULL, NULL, 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-22 13:09:00', NULL),
(4, 'Anthony Pombal', 'anthony@retconference.com', '', 'RETCON', 'Hi there! Can you please connect me to somebody in marketing regarding the opportunity for your company to join RETCON 2026 ? real estate\'s leading innovation conference? Opportunities are filling up and I?d love for you all to be able to take advantage. RETCON 2026 is taking place at the MGM Grand in Las Vegas on March 9-11 and features 2250+ executives and innovation leaders from the country\'s largest property owners, operators and developers. Over 300+ speakers and 150+ sponsors will participate. We have tracks covering multifamily, office, retail, industrial, transformation, AI, investment & asset management, and more. Is your company interested in exploring sponsorship opportunities ? including speaking roles, booths, guaranteed 1-1 meetings, and curated roundtables? The event is quickly selling out, so let me know soon! I can send sample attendee snapshots. https://retconference.com/  - Thanks! Anthony.', '', '', NULL, NULL, 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-21 22:29:00', NULL),
(5, 'Imported User', 'sheree_d_alexander@homedepot.com', '', 'The Home Depot', 'Leaders, \r\n\r\nThanks so much for the thoughtfulness, it does not go unnoticed and is very much appreciated!  Happy holidays to each of you and yours??', '', '', NULL, NULL, 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-19 14:50:00', NULL),
(6, 'Bella', 'bella@aaalendings.com', '', 'AAA Capital Investment, Inc.', 'There is a login issue. Authentication code could not be sent', '', '', NULL, NULL, 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-17 11:01:00', NULL),
(7, 'Matt Connors', 'mattconnors@fusaca.com', '', 'FUNERAL SHIPPING AND CONSULATE ASSISTANT LLC', 'I will like to learn about your payment solutions', '', '', NULL, NULL, 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-12 15:33:00', NULL),
(8, 'Rick Rostkowski', 'rick@janprohoustonclean.com', '', 'Jan-Pro of Houston', 'Hi,\r\n \r\nI am near you and live in Houston, and work for some of your neighbors. I was hoping I could come by and offer a complimentary cleaning bid? I can also do so over email.\r\n \r\nThank you in advance for your response.\r\n \r\nWith best,\r\n\r\nRick Rostkowski\r\nVP, General Manager\r\nJan-Pro of Houston\r\nrick@janprohoustonclean.com\r\n\r\nAnyone who needs somebody for commercial cleaning this is the place I recommend. They work on everything in a timely and thorough manner. They are worth every penny and dime. Take advantage. I strongly recommend! - Nathan Cervantes\r\n\r\nRespond with stop to optout', '', '', NULL, NULL, 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-12 10:18:00', NULL),
(9, 'Maureen Rucker', 'maureen.r@theprofessionalprofiles.com', '', 'The Professional Profiles', 'Wikipedia is considered to be the World?s most significant tool for reference material. The Wiki links show up on the 1st page of Google 97% of the time. With a Page on one of the most revered reference tools, you are sure to get yourself or your business noticed. So if you\'re thinking of getting a Wikipedia Page created, it\'s the best time of the year.\r\n\r\nIf you are interested in getting more information just respond back to this email.\r\n\r\nThanks,\r\n\r\nMaureen Rucker\r\nThe Professional Profiles\r\nMaureen.r@theprofessionalprofiles.com\r\n\r\nRespond with stop to optout.', '', '', NULL, NULL, 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-04-12 10:15:00', NULL),
(10, 'Adam LoPresti', 'adamlopresti.wyo@gmail.com', '', 'Brooks Appraisals', 'I have an account with ValueLink as an appraiser, however I have been unable to log in to my account. I have requested submitted a password recovery request, but never receive an email to reset the password. The email associated with the account is likely bebrooks2@vcn.com, however I am switching to alopresti.wyo@gmail.com. Thanks for your help!', '', '', NULL, NULL, 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-03-12 15:23:00', NULL),
(11, 'Matthew George', 'eagleappraisals@comcast.net', '', 'Eagle Appraisals, Inc', 'I received an alert to update my insurance. When I log into my account and go to my profile, there is no place to upload the insurance.', '', '', NULL, NULL, 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-02-12 11:11:00', NULL),
(12, 'Peter Liapis', 'pjliapis@gmail.com', '', 'Peter John Liapis Enterprises', 'I am not quite sure why my account being deactivated?? My card is still good??', '', '', NULL, NULL, 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-11-30 14:41:00', NULL),
(13, 'Robin Leclaire', 'robinwainleclaire@verizon.net', '', '', 'Gift card no working', '', '', NULL, NULL, 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-11-26 14:10:00', NULL),
(14, 'Gregg R Brooks', 'gbs603@comcast.net', '', 'Brooks Appraisal Services LLC', 'future 3.6 trainings ?', '', '', NULL, NULL, 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-11-25 15:36:00', NULL),
(15, 'Jossy Rascon', 'jossy@ecoedgejanitorial.com', '', 'EcoEdge Janitorial', 'Hi,\r\n \r\nI am local and provide service in Houston And work for others in the community. I was hoping I could come by and offer a complimentary cleaning bid? I can also do so over email.\r\n \r\nThank you in advance for your response.\r\n \r\nWith best,\r\n\r\nJossy Rascon\r\nBusiness Development Rep\r\nEcoEdge Janitorial\r\njossy@ecoedgejanitorial.com\r\n\r\nRespond with stop to optout.', '', '', NULL, NULL, 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-11-24 16:08:00', NULL),
(16, 'Yolanda Burrell', 'yolandaburrell75@gmail.com', '', 'Yolanda L Burrell', 'I\'m appraiser looking to add more lenders to my profile, so I can receive more appraisal orders. Please advise. Thanks 562 824-7373', '', '', NULL, NULL, 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-11-19 13:27:00', NULL),
(17, 'John Shaffer', 'skylineappraisals@hotmail.com', '', 'Skyline Appraisals, Inc.', 'My first time logging in.  I have an order from United Bank that I need to access.  I do not know how to reach my orders.  Thanks!', '', '', NULL, NULL, 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-11-18 11:02:00', NULL),
(18, 'Jennifer Ferguson', 'jfvaluation@gmail.com', '', 'JF Appraisals', 'I believe I am already one of your vendors however I do not see my profile setup. Please advise.', '', '', NULL, NULL, 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-11-11 14:54:00', NULL),
(19, 'Keith Nelson', 'knelson@calhounsands.com', '', 'Retail Petroleum Group, LLC', 'I was charged $19.99 and I have no idea what it\'s for.  Please remove me from your automatic billing and please refund me for this $19.99 charge that i have no idea what it\'s for.  Thank you', '', '', NULL, NULL, 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-03-11 07:14:00', NULL),
(20, 'Ann Kelley', 'orders@wentworthappraisal.net', '', 'Wentworth Appraisal', 'Please remove me from your list, close my account, I no longer want to be on your platform and I want to remove my CC info from your website immediately.', '', '', NULL, NULL, 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-02-11 17:12:00', NULL),
(21, 'John Noonan', 'jnoonan@cbresolutions.com', '', 'CBRES', 'We currently use Appraisal Scope and need to be able to integrate with Value Link in order to service a new client  - - NQM Funding out of FL.\r\n\r\nPlease advise what steps are need to make this work - Thank you', '', '', NULL, NULL, 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-31 10:00:00', NULL),
(22, 'Jennifer C Newton', 'jennewton23@gmail.com', '', 'Newton Appraisal Service', 'Having a problem getting a new password to work.', '', '', NULL, NULL, 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-22 17:52:00', NULL),
(23, 'David E Ciszek', 'dave@davidciszek.com', '', 'David Ciszek, Broker', 'I do appraisals for ESUSA. Lately, I have NOT been able to bid on an order unless I provide a credit card. NOWHERE in our industry does anyone else require I given you my credit card number. I have had my identity stolen 3 times and this requirement appears to me to be some sort of fraud attempt. Please correct if you indeed have the ability to do so. \r\nSincerely, David Ciszek, JD.', '', '', NULL, NULL, 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-21 16:52:00', NULL),
(24, 'Susan Alley', 'susan@appraisalaid.com', '', 'Appraisal Aid', 'I?m reaching out because we support AMCs with USPAP compliance reviews and related compliance initiatives. I?d love to learn more about your internal compliance tools and workflow capabilities for our clients who use ValueLink.  \r\n\r\nMy goal is to better understand how our clients can fully utilize the features already available within your platform. The more value they find in your system, the stronger both of our relationships become ? a true win-win for everyone involved.\r\n\r\nIf there?s someone on your team I could connect with for a brief call or overview, I?d really appreciate it.  Have a fantastic day!', '', '', NULL, NULL, 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-17 09:38:00', NULL),
(25, 'Sheri Efseaff', 'sheri_efseaff@outlook.com', '', 'Sheri Efseaff', 'I am an appraiser.  I currently work with GEM Mortgage.  They asked me to set up a Valuelink account, however, I have an old one under my old email address which is Sheri_Efseaff@roadrunner.com.  I can\'t log in because I no longer have that email address and when I go to request to change the password, it sends the message to my old email address.  Is there a way to change my user name/email address so I can access my account?\r\n\r\nSincerely,\r\n\r\nSheri Efseaff\r\n714/342-0255\r\nSheri_Efseaff@outlook.com', '', '', NULL, NULL, 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-14 20:10:00', NULL),
(26, 'Katie Rozman', 'katie@hdaappraisal.com', '', 'HDA Appraisal', 'My former employer is taking work in my name.  I\'ve found tow of the AMCs on your network I had worked with in the past and was able to update with them.  \r\n\r\nI\'d like to find out if there is a way for me to find out the other AMCs that my prior profile had, so that I can contact them to update my details.\r\n\r\nToday, I won a bid on the system and my prior company was able to get to my work, told the client I didn\'t work for them anymore and then requested the assignment be reassigned!  It was shocking that Chudnow Druck was able to access my account!\r\n\r\nI\'d like to determine how I can separate myself from Chudnow Druck Valuation in all ways, so there is no confusion. \r\n\r\n\r\n\r\nThanks so much!\r\n\r\nKate', '', '', NULL, NULL, 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-09 19:18:00', NULL),
(27, 'Michael Stone', 'mstone@icecapgroup.com', '', 'IceCap Group', 'I?m the CTO of the IceCap Group and we?re interested in integrating with your API to order appraisals, and we?re also interested in obtaining the original XML data from appraisals that we?re ordered for us, but not by us. From our understanding, we should have access to those appraisals that were ordered for our company, but we?d like to know if there?s an option to obtain the original XML file so we can have the raw data instead of just the appraisal document. \r\n\r\nThanks', '', '', NULL, NULL, 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-09-10 16:59:00', NULL),
(28, 'Rick Rigdon', 'rick7945@gmail.com', '', '', 'Forgot username and password', '', '', NULL, NULL, 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-08-10 15:39:00', NULL),
(29, 'Dennis R Chaissan', 'dchaissan@gmail.com', '', 'Dennis Appraisal Services', 'The sign up link for joining Connect does not seem to work.', '', '', NULL, NULL, 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-07-10 13:45:00', NULL),
(30, 'David Lane', 'david.lane@veloxval.com', '', 'Velox Valuations', 'Need help with several things in my profile. Thank you, David Lane 619-665-4291', '', '', NULL, NULL, 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-06-10 18:06:00', NULL),
(31, 'Robin Leonard', 'appraisals@appraisalsva.com', '', 'Appraisal Services of Virginia', 'I am looking for an appraisal management program for our office, and I like the way Connect works for our internal staff. A huge bonus that it connects to Total, but the biggest piece I need and can\'t seem to find with any appraisal management software is the ability to link to QuickBooks Online. Is that possible with Connect, through direct integration with QBO, or with a third-party software such as Maker?', '', '', NULL, NULL, 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-02-09 19:34:00', NULL),
(32, 'Dennis Poole', 'pooleaz@aol.com', '', 'Sierra Appraisal LLC', 'Tried to update my password and now cannot sign-in. Please update my password if possible. TY', '', '', NULL, NULL, 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-09-26 17:58:00', NULL),
(33, 'Sheikh M Safwan', 'muhammad.safwan@spursol.com', '', 'SpurSol', 'Test Message', '', '', NULL, NULL, 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-06-09 03:48:00', NULL),
(34, 'OLIVIA HOWELL', 'olympusamc@gmail.com', 'ncandm@gmail.com', 'Olympus Appraisal Management LLC', 'Software for AMCs - Cost', 'AMC', '0?99 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-12-22 21:12:00', NULL),
(35, 'Sheikh Muhammad Safwan', 'muhammad.safwan@spursol.com', '3151182258', 'SpurSol', 'Testing VMDC submission', 'AMC', '0?99 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-12-21 05:33:00', NULL),
(36, 'Leila', 'ltouhamy@unitedmortgage.com', '6313961815', 'United', 'info on your interface ability with Byte Enterprise.', 'Lender', '100?499 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-12-17 13:10:00', NULL),
(37, 'Stephen Roefaro', 'sroefaro@gmail.com', '3155254657', 'Roefaro Appraisal Service', 'Appraisals', 'AMC', '0?99 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-12-12 15:31:00', NULL),
(38, 'Heather', 'heather@valoraamc.com', '8045393163', 'Valora AMC LLC', 'Demo', 'AMC', '0?99 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-11-12 15:57:00', NULL),
(39, 'Ekta Sethi', 'realappraisalamc@gmail.com', '?(925) 297-5390?', 'Real Estate Plus LLC.', 'AMC software', 'AMC', '100?499 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-06-12 11:33:00', NULL),
(40, 'Audra', 'avanderford@emprisebank.com', '13163834494', 'Emprise Bank', 'A streamline system to work with nCino for appraisal ordering', 'AMC', '0?99 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-02-12 14:12:00', NULL),
(41, 'James Talbot', 'james@premierlending.org', '5044733030', 'Premier Lending', 'if we fit.', 'Lender', '0?99 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-11-25 14:40:00', NULL),
(42, 'Chinsoo Kim', 'chinsookim0516@gmail.com', '9075450326', 'hawaiiinn&suite llc', 'up a meeting', 'Lender', 'Not sure / exploring options', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-11-20 22:56:00', NULL),
(43, 'Yolanda Burrell', 'yolandaburrell75@gmail.com', '562 824-7373', 'Real Estate Valuation Service', 'I am looking to add more vendors in your network to my profile, so I may receive more orders.', 'AMC', '0?99 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-11-19 13:24:00', NULL),
(44, 'Lien King', 'lien@griffinfunding.com', '6196824852', 'Griffin Funding', 'An appraisal platform to build a panel to help with efficiency, cost and turn times', 'Lender', '100?499 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-11-13 18:32:00', NULL),
(45, 'Ana Margarete Lima dos Santos', 'ana.margarete.santos@gmail.com', '55 (21)96565-7501', 'AML dos Santos Im?veis', 'Laudos de avalia??o e parecer t?cnico', 'AMC', '0?99 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-08-11 07:37:00', NULL),
(46, 'Xabad', 'xabad.nadeem@valuelinksoftware.com', '\'+10000000000', 'VLS', 'testing for Encompass', 'Lender', '0?99 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-05-11 01:18:00', NULL),
(47, 'Dawn Agee', 'dagee@mtcfederal.com', '8649083457', 'MTC Federal Credit Union', 'We are looking for a new vendor for our appraisal needs. We are current using Nations and are not happy with the turn around time and hidden fees as well as additional trip fees which are not being disclosed.', 'Lender', '0?99 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-03-11 16:16:00', NULL),
(48, 'sdxfcg', 'fghdfgf@gmail.com', '2345678910', 'xdcfvgbhnjmk,l', 'sdxcfghjk', 'Lender', '0?99 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-03-11 04:59:00', NULL),
(49, 'Florencia R', 'florenciaruedas@gmail.com', '6614008114', 'Sierra Appraisal Network', 'A Demo', 'AMC', '0?99 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-27 15:21:00', NULL),
(50, 'Ron', 'ron.szukala@gmail.com', '561-459-0724', 'Lendz Financial', 'reliable tool', 'Lender', '100?499 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-23 10:28:00', NULL),
(51, 'Timothy Bryll', 'bryllappraisal@sbcglobal.net', '4408569289', 'Bryll Appraisal Service', 'I am an Appraiser trying to establish accoun', 'Other', '0?99 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-23 08:19:00', NULL),
(52, 'Sheikh M Safwan', 'safwan@gmail.com', '3152288535', 'SpurSol', 'Test', 'Lender', '100?499 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-23 05:30:00', NULL),
(53, 'Kevin', 'kevin.johnson@homewoodag.com', '3183930247', 'Homewood Appraisal Group', 'appraisal work', 'Appraiser', '0?99 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-22 08:40:00', NULL),
(54, 'Lou Rusert', 'northbay@reaa.org', '7074840608', 'Real Estate Appraisers Association', 'live demo', 'Appraiser', 'Not sure / exploring options', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-21 20:47:00', NULL),
(55, 'joanne L DeCabia', 'jdecabia@gmail.com', '9144249356', 'Residential Appraisal Service', 'reset my password', 'Appraiser', '0?99 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-21 18:30:00', NULL),
(56, 'Kenneth Tuttle', 'ktuttle@cfl.rr.com', '407-402-3131', 'Residential Appraisal Associates', 'Registration', 'Appraiser', '0?99 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-21 10:30:00', NULL),
(57, 'Ryan Parent', 'ryep111@gmail.com', '818-984-7926', 'SDI Appraisal Services', 'I am looking to start a new AMC and am looking for software solutions for the management of a modern AMC', 'AMC', 'Not sure / exploring options', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-21 10:17:00', NULL),
(58, 'Jeff', 'jeffeye1959@gmail.com', '540-333-2190', 'Allegheny Realty', 'Good Morning', 'Appraiser', '0?99 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-21 07:27:00', NULL),
(59, 'Robyn Adams', 'rradams@comcast.net', '4042770212', 'Adams Residential Appraisal Services', 'orders', 'Appraiser', '0?99 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-21 01:15:00', NULL),
(60, 'Tim Tolbert', 'appraisaladvant@mindspring.com', '408-886-0464', 'Appraisal Advantage', 'demo instructions', 'Appraiser', '0?99 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-20 14:11:00', NULL),
(61, 'Richard Clark', 'gulfsure@aol.com', '7273237153', 'Rick Clark Appraisal Serices Inc', 'Appraisal', 'Appraiser', '0?99 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-16 09:35:00', NULL),
(62, 'Byron Lea', 'byronlea@att.net', '9706991748', 'Byron Lea Valuation', 'Account setup', 'Appraiser', '0?99 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-15 12:06:00', NULL),
(63, 'Kelly Palomba', 'kcresappraisals@gmail.com', '816-550-8915', 'KC-RES Appraisals', 'Appraisal Work', 'Appraiser', '0?99 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-15 10:59:00', NULL),
(64, 'Matt Tarter', 'orders.matt@teamtarter.com', '7655958155', 'Tarter Realty Auction & Appraisal Co', 'New appraisal orders', 'Appraiser', '0?99 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-14 10:27:00', NULL),
(65, 'Greg Hefferan', 'ghefferan@comcast.net', '612-414-7750', 'Greg Hefferan', 'Info on how system works', 'Appraiser', '0?99 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-13 20:28:00', NULL),
(66, 'Donna Rodgers', 'dcrodgers5178@gmail.com', '408-836-5178', 'Donna Rodgers Appraisal', 'completing 1 to 2 appraisal assignments per week', 'Appraiser', '0?99 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-13 20:08:00', NULL),
(67, 'Matt Fernandes', 'matt.fernandes@lendinvestorscapital.com', '8058868720', 'Lend Investors Capital', 'an AMS', 'Lender', '100?499 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-10 16:59:00', NULL),
(68, 'Robert', 'prandall01@gmail.com', '7708612986', 'Robert Randall', 'Residential appraisal orders', 'Appraiser', '0?99 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-09-10 12:35:00', NULL),
(69, 'Veronica', 'veronica.vasquez@fsv.gob.sv', '\'+50377425060', 'FSV', 'My name is Ver?nica V?squez, and I am reaching out on behalf of the Fondo Social para la Vivienda (FSV), a leading institution in El Salvador dedicated to promoting affordable housing access for low- and middle-income families. At FSV, we work to provide social housing solutions through financing, property development, and management, ensuring compliance with Salvadoran regulations and maximizing the social impact of our operations. Our goal is to maintain efficient and transparent processes that benefit the communities we serve. We are currently evaluating technological solutions to modernize and optimize our real estate valuation processes, ensuring accuracy, efficiency, and regulatory compliance.', 'Appraiser', 'Not sure / exploring options', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-08-10 15:38:00', NULL),
(70, 'Susan B Jackson', 'susancbj@bellsouth.net', '18287759432', 'Associated Appraisal Services', 'Updating my profile', 'Appraiser', '0?99 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-08-10 10:56:00', NULL),
(71, 'Mark Thomas', 'mark.thomas@lendinvestorscapital.com', '7034733092', 'Lend Investors Capital', 'An AMS Solution', 'Lender', '100?499 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-07-10 16:30:00', NULL),
(72, 'Jessy Bowman', 'jbowmanappraisals@gmail.com', '937-216-4689', 'J Bowman Appraisals', 'appraisals around the Dayton & Cincinnati area. Additionally, I cover Miami county & surrounding areas.', 'Appraiser', '0?99 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-07-10 09:25:00', NULL),
(73, 'Shawn Lyons', 'indappr@gmail.com', '317-440-2455', 'Indiana Appraisal Service', 'Getting set up to Connect', 'Appraiser', '0?99 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-06-10 14:51:00', NULL),
(74, 'Julia James', 'jappraisalsllc@gmail.com', '301-491-8910', 'James Appraisals LLC', 'Instructions on setting up a ValueLink Account', 'Appraiser', '0?99 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-06-09 19:44:00', NULL),
(75, 'Clayton Hill', 'claytonhill24@icloud.com', '2816368115', 'otss, LLC', 'a way to streamline my appraisal process', 'Appraiser', '100?499 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-05-10 08:38:00', NULL),
(76, 'Tanvi Jha', 'officemanager@ciotta-appraisals.com', '5166711400', 'Frank Ciotta Appraisals', 'Demo of Valuelink connect', 'AMC', '100?499 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-02-10 09:21:00', NULL),
(77, 'MAGDALENE GREESON', 'ivaluecincy@gmail.com', '1-513-305-7083', 'MAGDALENE GREESON', 'RESIDENTIAL APPRAISAL WORK', 'Appraiser', '0?99 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-01-10 15:12:00', NULL),
(78, 'Nancy Shoemaker', 'shoethree@skybest.com', '336-877-7542', 'Shoemaker Appraisal Services', 'orders in Ashe and Watauga counties, NC', 'Appraiser', '0?99 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-01-10 13:57:00', NULL),
(79, 'Brenda Shea', 'sheabrenda@gmail.com', '951-264-3333', 'Brenda Shea Appraiser', 'for additional Appraisal work.', 'Appraiser', '0?99 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-01-10 13:41:00', NULL),
(80, 'Ryan Lefkowitz', 'ryan@lendoor.com', '6234193484', 'Lendoor', 'an appraisal order solution', 'Lender', '100?499 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-01-10 12:18:00', NULL),
(81, 'Jessy Weaver', 'appraiserjessy@gmail.com', '402-620-8563', 'TrueMark Appraisals LLC', 'Conventional orders in Northwest Iowa.', 'Appraiser', '0?99 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-01-10 11:26:00', NULL),
(82, 'Eddie Gonzalez', 'eddie.gonzalez@churchillmortgage.com', '615-767-5222', 'Churchill Mortgage', 'Looking at middleware vendors for appraisal ordering. Also, appraisal review via AI', 'Lender', '100?499 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-09-30 13:22:00', NULL),
(83, 'Tasia Willhite', 'tasiawillhite@gmail.com', '903-348-6898', 'Willhite Appraisal Company LLC', 'An account to receive orders from a current client switching to this platform for orders.', 'Appraiser', '0?99 orders / month', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-09-26 09:52:00', NULL),
(84, 'Imported User', '', '', '', '', '', '', NULL, NULL, 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-08-28 10:01:00', NULL),
(85, 'Imported User', 'glehnes@bridgeamc.com', '', '', '', '', '', NULL, NULL, 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2025-12-17 11:10:14', NULL),
(86, 'Imported User', 'tjswider@creditlenders.com', '', '', '', '', '', NULL, NULL, 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2025-10-27 13:28:29', NULL),
(87, 'Imported User', 'jshives@samco-amc.com', '', '', '', '', '', NULL, NULL, 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2025-10-16 10:21:12', NULL),
(88, 'Imported User', 'j@yopmail.com', '', '', '', '', '', NULL, NULL, 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2025-10-14 14:53:14', NULL),
(89, 'Imported User', 'david.carroll@pnc.com', '', '', '', '', '', NULL, NULL, 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2025-10-13 19:36:39', NULL),
(90, 'Imported User', 'chris.hunt@valuationnexus.com', '', '', '', '', '', NULL, NULL, 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2025-10-07 13:19:38', NULL),
(91, 'Sanjay Sethi', 'sanjay@execs.com', '9252165850', 'Real estate plus llc', 'Software to manage orders', 'AMC', '100–499 orders / month', NULL, NULL, 'CSV Import', 'Request a Demo Form Mobile View', NULL, 'new', '2025-12-21 12:27:14', NULL),
(92, 'Etoka Mzaliwa', 'mzaliwaetoka8@gmail.com', '8435341924', 'Tyson', 'Yes', 'AMC', '100–499 orders / month', NULL, NULL, 'CSV Import', 'Request a Demo Form Mobile View', NULL, 'new', '2025-11-26 10:25:18', NULL),
(93, 'Paul Donaldson', 'paul.donaldson@heartlandvaluation.com', '5164268126', 'Heartland Valuation', 'I would like information to connect with your platform', 'AMC', '1,000–4,999 orders / month', NULL, NULL, 'CSV Import', 'Request a Demo Form Mobile View', NULL, 'new', '2025-11-12 18:56:46', NULL),
(94, 'Dannie Wallace', 'leeboyywallace1155@gmail.com', '9707599882', 'Openspace.com', 'I\'m in here with nothing but a chance to get a chance to work on my way to make sure you have a chance to get the operable chain port y6 in a few minutes to go inside of the operable coin protextcoin XD with my portfolio account and the strongest point of creating a data base model successful and value of a few years and value of a new equation of protex coin protextcoin XD and the strongest point of protex is there is no way to the world to be there in time but a lot of ways to be a data level of protex and', 'AMC', '5,000+ orders / month', NULL, NULL, 'CSV Import', 'Request a Demo Form Mobile View', NULL, 'new', '2025-11-01 09:57:28', NULL),
(95, 'Florencia', 'florenciarurdas@gmail.com', '6614008114', 'Sierra', 'Demo', 'AMC', '0–99 orders / month', NULL, NULL, 'CSV Import', 'Request a Demo Form Mobile View', NULL, 'new', '2025-10-20 21:43:18', NULL),
(96, 'Con Karl', 'j@yopmai.com', '\'+1 900-433-6328', 'Hatami', 'ogf', 'Appraiser', 'Not sure / exploring options', NULL, NULL, 'CSV Import', 'Request a Demo Form Mobile View', NULL, 'new', '2025-10-14 14:55:59', NULL),
(97, 'John Barry', 'jkb8@ntrs.com', '', 'Northern Trust', 'Gift card', '', '', NULL, NULL, 'CSV Import', 'Request a Demo Form Mobile View', NULL, 'new', '2025-09-26 15:59:27', NULL);

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
(12, 'Safwan', 'safwanshaekh55@gmail.com', '$2y$10$mviEf2uL/GtFbunzItW7Y.vAObcV7sOG4qm4CbDjBmTzVChxRxqIy', 'admin', 1, NULL, NULL, '2025-12-14 23:13:14', '2025-12-14 23:13:14', 'default.png'),
(13, 'Sami', 'sami@gmail.com', '$2y$10$wBc4Qj1HgWW9XYjdsqHmd.y/U0g0pa39cIuKz.Qybjmm94G.VGKDy', 'sales', 1, NULL, NULL, '2025-12-22 16:42:23', '2025-12-22 16:42:23', 'default.png'),
(14, 'Basit', 'abdulbasit.altaf007@gmail.com', '$2y$10$PnvK9f1sFAg0NRzcmn8R5uid4nE0xbIJuz03caKotXF/NzIizwdne', 'marketing', 1, NULL, NULL, '2025-12-24 19:35:19', '2025-12-24 19:35:19', 'default.png');

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
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_assigned_user` (`assigned_to`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=98;

--
-- AUTO_INCREMENT for table `lead_notes`
--
ALTER TABLE `lead_notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

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
-- Constraints for table `leads`
--
ALTER TABLE `leads`
  ADD CONSTRAINT `fk_assigned_user` FOREIGN KEY (`assigned_to`) REFERENCES `users` (`id`) ON DELETE SET NULL;

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
