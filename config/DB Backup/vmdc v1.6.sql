-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 29, 2026 at 11:27 PM
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
(37, 1, 254, 'Imported User', '', 'Contact Us Form', '2025-12-26 21:22:03', 'Deleted', 'Permanently deleted the lead.', '2025-12-26 20:23:09'),
(38, 1, 1, 'John V LeClair', 'jvleclair53@gmail.com', 'Contact Us Form', '2025-12-23 17:53:00', 'Qualification Update', 'Changed Qualification Scale to \'Qualified\'', '2026-02-21 11:15:35'),
(39, 1, 1, 'John V LeClair', 'jvleclair53@gmail.com', 'Contact Us Form', '2025-12-23 17:53:00', 'Qualification Update', 'Changed Qualification Scale to \'Not Qualified\'', '2026-02-21 11:16:15'),
(40, 1, 1, 'John V LeClair', 'jvleclair53@gmail.com', 'Contact Us Form', '2025-12-23 17:53:00', 'Qualification Update', 'Changed Qualification Scale to \'Unassigned\'', '2026-02-21 11:16:28'),
(41, 1, 1, 'John V LeClair', 'jvleclair53@gmail.com', 'Contact Us Form', '2025-12-23 17:53:00', 'Qualification Update', 'Changed Qualification Scale to \'Qualified\'', '2026-02-21 11:21:25'),
(42, 1, 1, 'John V LeClair', 'jvleclair53@gmail.com', 'Contact Us Form', '2025-12-23 17:53:00', 'Qualification Update', 'Changed Qualification Scale to \'Not Qualified\'', '2026-02-21 11:21:28'),
(43, 1, 1, 'John V LeClair', 'jvleclair53@gmail.com', 'Contact Us Form', '2025-12-23 17:53:00', 'Qualification Update', 'Changed Qualification Scale to \'Junk\'', '2026-02-21 11:21:31'),
(44, 1, 1, 'John V LeClair', 'jvleclair53@gmail.com', 'Contact Us Form', '2025-12-23 17:53:00', 'Status Update', 'Changed status from \'New\' to \'Not Qualified\'', '2026-02-21 12:01:19'),
(45, 1, 1, 'John V LeClair', 'jvleclair53@gmail.com', 'Contact Us Form', '2025-12-23 17:53:00', 'Status Update', 'Changed status from \'\' to \'MSA Signed\'', '2026-02-21 12:02:21'),
(46, 1, 34, 'OLIVIA HOWELL', 'olympusamc@gmail.com', 'Demo Request Form', '2025-12-23 02:12:00', 'Status Update', 'Changed status from \'New\' to \'Conversion - MSA Sent\'', '2026-02-21 12:03:15'),
(47, 1, 1, 'John V LeClair', 'jvleclair53@gmail.com', 'Contact Us Form', '2025-12-23 17:53:00', 'Status Update', 'Changed status from \'\' to \'Conversion - MSA Sent\'', '2026-02-21 12:04:57'),
(48, 1, 1, 'John V LeClair', 'jvleclair53@gmail.com', 'Contact Us Form', '2025-12-23 17:53:00', 'Status Update', 'Changed status from \'\' to \'Conversion - MSA Sent\'', '2026-02-21 12:08:54'),
(49, 1, 34, 'OLIVIA HOWELL', 'olympusamc@gmail.com', 'Demo Request Form', '2025-12-23 02:12:00', 'Status Update', 'Changed status from \'\' to \'MSA Signed\'', '2026-02-21 12:09:06'),
(50, 1, 1, 'John V LeClair', 'jvleclair53@gmail.com', 'Contact Us Form', '2025-12-23 17:53:00', 'Qualification Update', 'Changed Qualification Scale to \'Qualified\'', '2026-02-21 12:11:30'),
(51, 1, 1, 'John V LeClair', 'jvleclair53@gmail.com', 'Contact Us Form', '2025-12-23 17:53:00', 'Qualification Update', 'Changed Qualification Scale to \'Not Qualified\'', '2026-02-21 12:11:33'),
(52, 1, 1, 'John V LeClair', 'jvleclair53@gmail.com', 'Contact Us Form', '2025-12-23 17:53:00', 'Qualification Update', 'Changed Qualification Scale to \'Unassigned\'', '2026-02-21 12:11:38'),
(53, 1, 1, 'John V LeClair', 'jvleclair53@gmail.com', 'Contact Us Form', '2025-12-23 17:53:00', 'Qualification Update', 'Changed Qualification Scale to \'Not Qualified\'', '2026-02-21 12:11:40'),
(54, 1, 1, 'John V LeClair', 'jvleclair53@gmail.com', 'Contact Us Form', '2025-12-23 17:53:00', 'Qualification Update', 'Changed Qualification Scale to \'Qualified\'', '2026-02-21 12:11:44'),
(55, 1, 1, 'John V LeClair', 'jvleclair53@gmail.com', 'Contact Us Form', '2025-12-23 17:53:00', 'Status Update', 'Changed status from \'Conversion - MSA Sent\' to \'Not Qualified\'', '2026-02-21 12:11:59'),
(56, 1, 1, 'John V LeClair', 'jvleclair53@gmail.com', 'Contact Us Form', '2025-12-23 17:53:00', 'Qualification Update', 'Changed Qualification Scale to \'Not Qualified\'', '2026-02-21 12:13:46'),
(57, 1, 1, 'John V LeClair', 'jvleclair53@gmail.com', 'Contact Us Form', '2025-12-23 17:53:00', 'Qualification Update', 'Changed Qualification Scale to \'Junk\'', '2026-02-21 12:13:49'),
(58, 1, 1, 'John V LeClair', 'jvleclair53@gmail.com', 'Contact Us Form', '2025-12-23 17:53:00', 'Qualification Update', 'Changed Qualification Scale to \'Not Qualified\'', '2026-02-21 12:15:30'),
(59, 1, 4, 'Anthony Pombal', 'anthony@retconference.com', 'Contact Us Form', '2025-12-22 03:29:00', 'Status Update', 'Changed status from \'New\' to \'Conversion - MSA Sent\'', '2026-02-22 12:19:55'),
(60, 1, 1, 'John V LeClair', 'jvleclair53@gmail.com', 'Contact Us Form', '2025-12-23 17:53:00', 'Qualification Update', 'Changed Qualification Scale to \'Qualified\'', '2026-02-22 13:12:49'),
(61, 1, 1, 'John V LeClair', 'jvleclair53@gmail.com', 'Contact Us Form', '2025-12-23 17:53:00', 'Status Update', 'Changed status from \'Not Qualified\' to \'MSA Signed\'', '2026-02-22 13:13:03'),
(62, 1, 1, 'John V LeClair', 'jvleclair53@gmail.com', 'Contact Us Form', '2025-12-23 17:53:00', 'Status Update', 'Changed status from \'MSA Signed\' to \'Not Sure of Status\'', '2026-02-22 13:16:23'),
(63, 1, 34, 'OLIVIA HOWELL', 'olympusamc@gmail.com', 'Demo Request Form', '2025-12-23 02:12:00', 'Qualification Update', 'Changed Qualification Scale to \'Not Qualified\'', '2026-02-23 10:41:02'),
(64, 1, 1, 'John V LeClair', 'jvleclair53@gmail.com', 'Contact Us Form', '2025-12-23 17:53:00', 'Status Update', 'Changed status from \'Not Sure of Status\' to \'Conversion - MSA Sent\'', '2026-02-23 10:41:49'),
(65, 1, 1, 'John V LeClair', 'jvleclair53@gmail.com', 'Contact Us Form', '2025-12-23 17:53:00', 'Status Update', 'Changed status from \'Conversion - MSA Sent\' to \'MSA Signed\'', '2026-02-23 10:42:04'),
(66, 1, 2, 'Clint Sturgill', 'cds1macys@yahoo.com', 'Contact Us Form', '2025-12-23 00:57:00', 'Qualification Update', 'Changed Qualification Scale to \'Junk\'', '2026-02-23 10:42:11'),
(67, 1, 91, 'Sanjay Sethi', 'sanjay@execs.com', 'Request a Demo Form Mobile View', '2025-12-21 17:27:14', 'Qualification Update', 'Changed Qualification Scale to \'Not Qualified\'', '2026-02-24 13:00:21'),
(68, 1, 92, 'Etoka Mzaliwa', 'mzaliwaetoka8@gmail.com', 'Request a Demo Form Mobile View', '2025-11-26 15:25:18', 'Qualification Update', 'Changed Qualification Scale to \'Not Qualified\'', '2026-02-24 13:00:25'),
(69, 1, 94, 'Dannie Wallace', 'leeboyywallace1155@gmail.com', 'Request a Demo Form Mobile View', '2025-11-01 14:57:28', 'Qualification Update', 'Changed Qualification Scale to \'Qualified\'', '2026-02-24 13:00:29'),
(70, 1, 95, 'Florencia', 'florenciarurdas@gmail.com', 'Request a Demo Form Mobile View', '2025-10-21 02:43:18', 'Qualification Update', 'Changed Qualification Scale to \'Qualified\'', '2026-02-24 13:00:34'),
(71, 1, 97, 'John Barry', 'jkb8@ntrs.com', 'Request a Demo Form Mobile View', '2025-09-26 20:59:27', 'Qualification Update', 'Changed Qualification Scale to \'Qualified\'', '2026-02-24 13:00:38'),
(72, 1, 85, 'Imported User', 'glehnes@bridgeamc.com', 'Newsletter Subscription Form', '2025-12-17 16:10:14', 'Qualification Update', 'Changed Qualification Scale to \'Junk\'', '2026-02-24 13:01:08'),
(73, 1, 87, 'Imported User', 'jshives@samco-amc.com', 'Newsletter Subscription Form', '2025-10-16 15:21:12', 'Qualification Update', 'Changed Qualification Scale to \'Not Qualified\'', '2026-02-24 13:01:11'),
(74, 1, 88, 'Imported User', 'j@yopmail.com', 'Newsletter Subscription Form', '2025-10-14 19:53:14', 'Qualification Update', 'Changed Qualification Scale to \'Qualified\'', '2026-02-24 13:01:15'),
(75, 1, 89, 'Imported User', 'david.carroll@pnc.com', 'Newsletter Subscription Form', '2025-10-14 00:36:39', 'Qualification Update', 'Changed Qualification Scale to \'Qualified\'', '2026-02-24 13:01:18'),
(76, 1, 85, 'Imported User', 'glehnes@bridgeamc.com', 'Newsletter Subscription Form', '2025-12-17 16:10:14', 'Status Update', 'Changed status from \'New\' to \'Not Qualified\'', '2026-02-24 13:01:26'),
(77, 1, 86, 'Imported User', 'tjswider@creditlenders.com', 'Newsletter Subscription Form', '2025-10-27 18:28:29', 'Qualification Update', 'Changed Qualification Scale to \'Not Qualified\'', '2026-02-24 13:01:30'),
(78, 1, 86, 'Imported User', 'tjswider@creditlenders.com', 'Newsletter Subscription Form', '2025-10-27 18:28:29', 'Qualification Update', 'Changed Qualification Scale to \'Qualified\'', '2026-02-24 13:01:33'),
(79, 1, 86, 'Imported User', 'tjswider@creditlenders.com', 'Newsletter Subscription Form', '2025-10-27 18:28:29', 'Status Update', 'Changed status from \'New\' to \'Demo Done\'', '2026-02-24 13:01:40'),
(80, 1, 87, 'Imported User', 'jshives@samco-amc.com', 'Newsletter Subscription Form', '2025-10-16 15:21:12', 'Status Update', 'Changed status from \'New\' to \'Customer Already\'', '2026-02-24 13:01:49'),
(81, 1, 88, 'Imported User', 'j@yopmail.com', 'Newsletter Subscription Form', '2025-10-14 19:53:14', 'Status Update', 'Changed status from \'New\' to \'Not Sure of Status\'', '2026-02-24 13:02:02'),
(82, 1, 89, 'Imported User', 'david.carroll@pnc.com', 'Newsletter Subscription Form', '2025-10-14 00:36:39', 'Status Update', 'Changed status from \'New\' to \'MSA Signed\'', '2026-02-24 13:02:15'),
(83, 1, 91, 'Sanjay Sethi', 'sanjay@execs.com', 'Request a Demo Form Mobile View', '2025-12-21 17:27:14', 'Status Update', 'Changed status from \'New\' to \'Customer Already\'', '2026-02-24 13:02:36'),
(84, 1, 92, 'Etoka Mzaliwa', 'mzaliwaetoka8@gmail.com', 'Request a Demo Form Mobile View', '2025-11-26 15:25:18', 'Status Update', 'Changed status from \'New\' to \'Customer Already\'', '2026-02-24 13:02:51'),
(85, 1, 94, 'Dannie Wallace', 'leeboyywallace1155@gmail.com', 'Request a Demo Form Mobile View', '2025-11-01 14:57:28', 'Status Update', 'Changed status from \'New\' to \'Conversion - MSA Sent\'', '2026-02-24 13:03:09'),
(86, 1, 95, 'Florencia', 'florenciarurdas@gmail.com', 'Request a Demo Form Mobile View', '2025-10-21 02:43:18', 'Status Update', 'Changed status from \'New\' to \'MSA Signed\'', '2026-02-24 13:03:20'),
(87, 1, 97, 'John Barry', 'jkb8@ntrs.com', 'Request a Demo Form Mobile View', '2025-09-26 20:59:27', 'Status Update', 'Changed status from \'New\' to \'Demo Done\'', '2026-02-24 13:03:30'),
(88, 1, 1, 'John V LeClair', 'jvleclair53@gmail.com', 'Contact Us Form', '2025-12-23 17:53:00', 'Qualification Update', 'Changed Qualification Scale to \'Unassigned\'', '2026-02-25 11:42:04'),
(89, 1, 34, 'OLIVIA HOWELL', 'olympusamc@gmail.com', 'Demo Request Form', '2025-12-23 02:12:00', 'Qualification Update', 'Changed Qualification Scale to \'Qualified\'', '2026-02-25 11:42:06'),
(90, 1, 171, 'Imported User', 'fordappraisal@gmail.com', 'Newsletter Subscription Form', '2025-12-24 18:39:22', 'Deleted', 'Permanently deleted the lead.', '2026-03-29 11:56:27'),
(91, 1, 294, 'Imported User', '', 'Demo Request Form', '2025-08-28 15:01:00', 'Deleted', 'Permanently deleted the lead.', '2026-03-29 12:48:46'),
(92, 1, 388, 'Imported User', '', 'Demo Request Form', '2025-08-28 15:01:00', 'Deleted', 'Permanently deleted the lead.', '2026-03-29 12:49:03'),
(93, 1, 84, 'Imported User', '', 'Demo Request Form', '2025-08-28 15:01:00', 'Deleted', 'Permanently deleted the lead.', '2026-03-29 12:49:16'),
(94, 1, 654, 'Amy Moss', 'amoss@cortrustbank.com', 'Events Form', '2026-03-09 15:06:00', 'Deleted', 'Permanently deleted the lead.', '2026-03-29 19:43:13'),
(95, 1, 577, 'Joseph Batrich', 'joebatrich@bellsouth.net', 'Contact Us Form', '2026-03-16 23:15:00', 'Deleted', 'Permanently deleted the lead.', '2026-03-29 19:43:19'),
(96, 1, 578, 'Leanna Rose Gonzalez', 'leanna@farmingmama.com', 'Contact Us Form', '2026-03-16 05:21:00', 'Deleted', 'Permanently deleted the lead.', '2026-03-29 19:43:23'),
(97, 1, 389, 'Derek Bolls', 'dbolls@metriqvaluation.com', 'Demo Request Form', '2026-03-12 19:48:00', 'Deleted', 'Permanently deleted the lead.', '2026-03-29 19:43:29'),
(98, 1, 579, 'Jeffrey Jenkins', 'appraisalservicebyjenkins@yahoo.com', 'Contact Us Form', '2026-03-12 17:03:00', 'Deleted', 'Permanently deleted the lead.', '2026-03-29 19:43:33'),
(99, 1, 580, 'Jodi Vinci', 'jvinci@clearmarkvaluation.com', 'Contact Us Form', '2026-03-10 15:48:00', 'Deleted', 'Permanently deleted the lead.', '2026-03-29 19:43:38'),
(100, 1, 655, 'Sheikh M Safwan', 'muhammad.safwan@spursol.com', 'Events Form', '2026-01-22 12:03:00', 'Deleted', 'Permanently deleted the lead.', '2026-03-29 19:44:07'),
(101, 1, 656, 'ValueLink Software', 'marketing@valuelinksoftware.com', 'Events Form', '2025-10-02 11:08:00', 'Deleted', 'Permanently deleted the lead.', '2026-03-29 19:44:19'),
(102, 1, 657, 'Jonathan Gifford', 'jgifford@inspirehomeloans.com', 'Events Form', '2025-09-30 17:36:00', 'Deleted', 'Permanently deleted the lead.', '2026-03-29 19:44:28'),
(103, 1, 658, 'Sheikh M Safwan', 'safwan@gmail.com', 'Events Form', '2025-09-29 13:19:00', 'Deleted', 'Permanently deleted the lead.', '2026-03-29 19:44:52'),
(104, 1, 163, 'Imported User', '', 'Demo Request Form', '2026-03-29 22:46:17', 'Deleted', 'Permanently deleted the lead.', '2026-03-29 20:48:20'),
(105, 1, 257, 'Imported User', '', 'Demo Request Form', '2026-03-29 22:49:22', 'Deleted', 'Permanently deleted the lead.', '2026-03-29 20:49:50'),
(106, 1, 278, 'Sanjay Sethi', 'sanjay@execs.com', 'Request a Demo Form Mobile View', '2026-03-29 22:51:50', 'Deleted', 'Permanently deleted the lead.', '2026-03-29 20:57:36'),
(107, 1, 279, 'Etoka Mzaliwa', 'mzaliwaetoka8@gmail.com', 'Request a Demo Form Mobile View', '2026-03-29 22:51:50', 'Deleted', 'Permanently deleted the lead.', '2026-03-29 20:57:47'),
(108, 1, 280, 'Paul Donaldson', 'paul.donaldson@heartlandvaluation.com', 'Request a Demo Form Mobile View', '2026-03-29 22:51:50', 'Deleted', 'Permanently deleted the lead.', '2026-03-29 20:57:57'),
(109, 1, 281, 'Dannie Wallace', 'leeboyywallace1155@gmail.com', 'Request a Demo Form Mobile View', '2026-03-29 22:51:50', 'Deleted', 'Permanently deleted the lead.', '2026-03-29 20:58:12'),
(110, 1, 282, 'Florencia', 'florenciarurdas@gmail.com', 'Request a Demo Form Mobile View', '2026-03-29 22:51:50', 'Deleted', 'Permanently deleted the lead.', '2026-03-29 20:58:26'),
(111, 1, 283, 'Con Karl', 'j@yopmai.com', 'Request a Demo Form Mobile View', '2026-03-29 22:51:50', 'Deleted', 'Permanently deleted the lead.', '2026-03-29 20:58:53'),
(112, 1, 284, 'John Barry', 'jkb8@ntrs.com', 'Request a Demo Form Mobile View', '2026-03-29 22:51:50', 'Deleted', 'Permanently deleted the lead.', '2026-03-29 20:59:13');

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
  `status` varchar(100) DEFAULT 'New',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `assigned_to` int(11) DEFAULT NULL,
  `qualification_scale` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `leads`
--

INSERT INTO `leads` (`id`, `client_name`, `email`, `phone`, `company`, `message`, `user_role`, `order_volume`, `preferred_date`, `event_title`, `source`, `form_name`, `submission_url`, `status`, `created_at`, `assigned_to`, `qualification_scale`) VALUES
(1, 'John V LeClair', 'jvleclair53@gmail.com', '', 'JVL Real Estate Appraisal and Consulting', 'I was asked to join Connect to receive orders from Central State Appraisal Services. When I tried to sign up it said I had an account using my name and NYS Certified Residential number but not my email. I need help to find out what this is all about. Thanks.', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-23 12:53:42', NULL, NULL),
(2, 'Clint Sturgill', 'cds1macys@yahoo.com', '', '', 'I got this from the Ohio lottery for redeeming points when I went to print it out it was a digital gift card, but I cut off half the numbers. I tried scanning the QR code. It doesn’t give me what the numbers are. Are you able to help me retrieve this? I could send you the QR code and the numbers in the pictures.Thank you so', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-22 19:57:22', NULL, NULL),
(3, 'United Wholesale', 'freddie@uwm.com', '', 'United WS', 'Looking to setup a demo.', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-22 13:09:16', NULL, NULL),
(4, 'Anthony Pombal', 'anthony@retconference.com', '', 'RETCON', 'Hi there! Can you please connect me to somebody in marketing regarding the opportunity for your company to join RETCON 2026 – real estate\'s leading innovation conference? Opportunities are filling up and I’d love for you all to be able to take advantage. RETCON 2026 is taking place at the MGM Grand in Las Vegas on March 9-11 and features 2250+ executives and innovation leaders from the country\'s largest property owners, operators and developers. Over 300+ speakers and 150+ sponsors will participate. We have tracks covering multifamily, office, retail, industrial, transformation, AI, investment & asset management, and more. Is your company interested in exploring sponsorship opportunities – including speaking roles, booths, guaranteed 1-1 meetings, and curated roundtables? The event is quickly selling out, so let me know soon! I can send sample attendee snapshots. https://retconference.com/  - Thanks! Anthony.', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-21 22:29:51', NULL, NULL),
(5, 'Sheree Alexander', 'sheree_d_alexander@homedepot.com', '', 'The Home Depot', 'Leaders, \r\n\r\nThanks so much for the thoughtfulness, it does not go unnoticed and is very much appreciated!  Happy holidays to each of you and yours❤️', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-19 14:50:45', NULL, NULL),
(6, 'Bella', 'bella@aaalendings.com', '', 'AAA Capital Investment, Inc.', 'There is a login issue. Authentication code could not be sent', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-17 11:01:51', NULL, NULL),
(7, 'Matt Connors', 'mattconnors@fusaca.com', '', 'FUNERAL SHIPPING AND CONSULATE ASSISTANT LLC', 'I will like to learn about your payment solutions', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-12 15:33:07', NULL, NULL),
(8, 'Rick Rostkowski', 'rick@janprohoustonclean.com', '', 'Jan-Pro of Houston', 'Hi,\r\n \r\nI am near you and live in Houston, and work for some of your neighbors. I was hoping I could come by and offer a complimentary cleaning bid? I can also do so over email.\r\n \r\nThank you in advance for your response.\r\n \r\nWith best,\r\n\r\nRick Rostkowski\r\nVP, General Manager\r\nJan-Pro of Houston\r\nrick@janprohoustonclean.com\r\n\r\nAnyone who needs somebody for commercial cleaning this is the place I recommend. They work on everything in a timely and thorough manner. They are worth every penny and dime. Take advantage. I strongly recommend! - Nathan Cervantes\r\n\r\nRespond with stop to optout', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-12 10:18:58', NULL, NULL),
(9, 'Maureen Rucker', 'maureen.r@theprofessionalprofiles.com', '', 'The Professional Profiles', 'Wikipedia is considered to be the World’s most significant tool for reference material. The Wiki links show up on the 1st page of Google 97% of the time. With a Page on one of the most revered reference tools, you are sure to get yourself or your business noticed. So if you\'re thinking of getting a Wikipedia Page created, it\'s the best time of the year.\r\n\r\nIf you are interested in getting more information just respond back to this email.\r\n\r\nThanks,\r\n\r\nMaureen Rucker\r\nThe Professional Profiles\r\nMaureen.r@theprofessionalprofiles.com\r\n\r\nRespond with stop to optout.', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-04 10:15:57', NULL, NULL),
(10, 'Adam LoPresti', 'adamlopresti.wyo@gmail.com', '', 'Brooks Appraisals', 'I have an account with ValueLink as an appraiser, however I have been unable to log in to my account. I have requested submitted a password recovery request, but never receive an email to reset the password. The email associated with the account is likely bebrooks2@vcn.com, however I am switching to alopresti.wyo@gmail.com. Thanks for your help!', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-03 15:23:40', NULL, NULL),
(11, 'Matthew George', 'eagleappraisals@comcast.net', '', 'Eagle Appraisals, Inc', 'I received an alert to update my insurance. When I log into my account and go to my profile, there is no place to upload the insurance.', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-02 11:11:00', NULL, NULL),
(12, 'Peter Liapis', 'pjliapis@gmail.com', '', 'Peter John Liapis Enterprises', 'I am not quite sure why my account being deactivated?? My card is still good??', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-11-30 14:41:30', NULL, NULL),
(13, 'Robin Leclaire', 'robinwainleclaire@verizon.net', '', '', 'Gift card no working', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-11-26 14:10:24', NULL, NULL),
(14, 'Gregg R Brooks', 'gbs603@comcast.net', '', 'Brooks Appraisal Services LLC', 'future 3.6 trainings ?', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-11-25 15:36:02', NULL, NULL),
(15, 'Jossy Rascon', 'jossy@ecoedgejanitorial.com', '', 'EcoEdge Janitorial', 'Hi,\r\n \r\nI am local and provide service in Houston And work for others in the community. I was hoping I could come by and offer a complimentary cleaning bid? I can also do so over email.\r\n \r\nThank you in advance for your response.\r\n \r\nWith best,\r\n\r\nJossy Rascon\r\nBusiness Development Rep\r\nEcoEdge Janitorial\r\njossy@ecoedgejanitorial.com\r\n\r\nRespond with stop to optout.', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-11-24 16:08:38', NULL, NULL),
(16, 'Yolanda Burrell', 'yolandaburrell75@gmail.com', '', 'Yolanda L Burrell', 'I\'m appraiser looking to add more lenders to my profile, so I can receive more appraisal orders. Please advise. Thanks 562 824-7373', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-11-19 13:27:26', NULL, NULL),
(17, 'John Shaffer', 'skylineappraisals@hotmail.com', '', 'Skyline Appraisals, Inc.', 'My first time logging in.  I have an order from United Bank that I need to access.  I do not know how to reach my orders.  Thanks!', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-11-18 11:02:55', NULL, NULL),
(18, 'Jennifer Ferguson', 'jfvaluation@gmail.com', '', 'JF Appraisals', 'I believe I am already one of your vendors however I do not see my profile setup. Please advise.', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-11-11 14:54:46', NULL, NULL),
(19, 'Keith Nelson', 'knelson@calhounsands.com', '', 'Retail Petroleum Group, LLC', 'I was charged $19.99 and I have no idea what it\'s for.  Please remove me from your automatic billing and please refund me for this $19.99 charge that i have no idea what it\'s for.  Thank you', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-11-03 07:14:45', NULL, NULL),
(20, 'Ann Kelley', 'orders@wentworthappraisal.net', '', 'Wentworth Appraisal', 'Please remove me from your list, close my account, I no longer want to be on your platform and I want to remove my CC info from your website immediately.', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-11-02 17:12:30', NULL, NULL),
(21, 'John Noonan', 'jnoonan@cbresolutions.com', '', 'CBRES', 'We currently use Appraisal Scope and need to be able to integrate with Value Link in order to service a new client  - - NQM Funding out of FL.\r\n\r\nPlease advise what steps are need to make this work - Thank you', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-31 10:00:49', NULL, NULL),
(22, 'Jennifer C Newton', 'jennewton23@gmail.com', '', 'Newton Appraisal Service', 'Having a problem getting a new password to work.', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-22 17:52:20', NULL, NULL),
(23, 'David E Ciszek', 'dave@davidciszek.com', '', 'David Ciszek, Broker', 'I do appraisals for ESUSA. Lately, I have NOT been able to bid on an order unless I provide a credit card. NOWHERE in our industry does anyone else require I given you my credit card number. I have had my identity stolen 3 times and this requirement appears to me to be some sort of fraud attempt. Please correct if you indeed have the ability to do so. \r\nSincerely, David Ciszek, JD.', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-21 16:52:54', NULL, NULL),
(24, 'Susan Alley', 'susan@appraisalaid.com', '', 'Appraisal Aid', 'I’m reaching out because we support AMCs with USPAP compliance reviews and related compliance initiatives. I’d love to learn more about your internal compliance tools and workflow capabilities for our clients who use ValueLink.  \r\n\r\nMy goal is to better understand how our clients can fully utilize the features already available within your platform. The more value they find in your system, the stronger both of our relationships become — a true win-win for everyone involved.\r\n\r\nIf there’s someone on your team I could connect with for a brief call or overview, I’d really appreciate it.  Have a fantastic day!', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-17 09:38:52', NULL, NULL),
(25, 'Sheri Efseaff', 'sheri_efseaff@outlook.com', '', 'Sheri Efseaff', 'I am an appraiser.  I currently work with GEM Mortgage.  They asked me to set up a Valuelink account, however, I have an old one under my old email address which is Sheri_Efseaff@roadrunner.com.  I can\'t log in because I no longer have that email address and when I go to request to change the password, it sends the message to my old email address.  Is there a way to change my user name/email address so I can access my account?\r\n\r\nSincerely,\r\n\r\nSheri Efseaff\r\n714/342-0255\r\nSheri_Efseaff@outlook.com', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-14 20:10:00', NULL, NULL),
(26, 'Katie Rozman', 'katie@hdaappraisal.com', '', 'HDA Appraisal', 'My former employer is taking work in my name.  I\'ve found tow of the AMCs on your network I had worked with in the past and was able to update with them.  \r\n\r\nI\'d like to find out if there is a way for me to find out the other AMCs that my prior profile had, so that I can contact them to update my details.\r\n\r\nToday, I won a bid on the system and my prior company was able to get to my work, told the client I didn\'t work for them anymore and then requested the assignment be reassigned!  It was shocking that Chudnow Druck was able to access my account!\r\n\r\nI\'d like to determine how I can separate myself from Chudnow Druck Valuation in all ways, so there is no confusion. \r\n\r\n\r\n\r\nThanks so much!\r\n\r\nKate', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-09 19:18:33', NULL, NULL),
(27, 'Michael Stone', 'mstone@icecapgroup.com', '', 'IceCap Group', 'I’m the CTO of the IceCap Group and we’re interested in integrating with your API to order appraisals, and we’re also interested in obtaining the original XML data from appraisals that we’re ordered for us, but not by us. From our understanding, we should have access to those appraisals that were ordered for our company, but we’d like to know if there’s an option to obtain the original XML file so we can have the raw data instead of just the appraisal document. \r\n\r\nThanks', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-09 16:59:54', NULL, NULL),
(28, 'Rick Rigdon', 'rick7945@gmail.com', '', '', 'Forgot username and password', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-08 15:39:20', NULL, NULL),
(29, 'Dennis R Chaissan', 'dchaissan@gmail.com', '', 'Dennis Appraisal Services', 'The sign up link for joining Connect does not seem to work.', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-07 13:45:37', NULL, NULL),
(30, 'David Lane', 'david.lane@veloxval.com', '', 'Velox Valuations', 'Need help with several things in my profile. Thank you, David Lane 619-665-4291', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-06 18:06:50', NULL, NULL),
(31, 'Robin Leonard', 'appraisals@appraisalsva.com', '', 'Appraisal Services of Virginia', 'I am looking for an appraisal management program for our office, and I like the way Connect works for our internal staff. A huge bonus that it connects to Total, but the biggest piece I need and can\'t seem to find with any appraisal management software is the ability to link to QuickBooks Online. Is that possible with Connect, through direct integration with QBO, or with a third-party software such as Maker?', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-01 19:34:38', NULL, NULL),
(32, 'Dennis Poole', 'pooleaz@aol.com', '', 'Sierra Appraisal LLC', 'Tried to update my password and now cannot sign-in. Please update my password if possible. TY', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-09-26 17:58:49', NULL, NULL),
(33, 'Sheikh M Safwan', 'muhammad.safwan@spursol.com', '', 'SpurSol', 'Test Message', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-09-06 03:48:14', NULL, NULL),
(34, 'Joseph Batrich', 'joebatrich@bellsouth.net', '', 'JNB Appraisal Services', 'Valuelink is a scam!  A complete waste of a company bilking money from appraisers and your clients.  I hope you go bankrupt.  I will never do business with Connect by Valuelink ever again and I will let any of your clients know just how shady your business practices are and how bad of a company you are, you all are scum!', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-03-16 18:15:00', NULL, NULL),
(35, 'Joseph Batrich', 'joebatrich@bellsouth.net', '', 'JNB Appraisal Services', 'Why am I getting a monthly charge for your software?', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-03-16 11:17:00', NULL, NULL),
(36, 'Leanna Rose Gonzalez', 'leanna@farmingmama.com', '', 'Faithful Foundations Realty', 'Good afternoon ,\r\nI am contacting you to expedite the onboarding process for new BPO and asset manager services. I am an experienced vendor working with ServiceLink and AssetValue, holding a QC score of 98%.\r\nI am looking to be added to your list of vendors that service Riverside & San Bernardino counties in Southern California.\r\nI look forward to hearing from you,\r\nLeanna', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-03-16 00:21:00', NULL, NULL),
(37, 'Jeffrey Jenkins', 'appraisalservicebyjenkins@yahoo.com', '', 'jenkins appraisal service', 'I am not receiving any emails from you.  I think yahoo is blocking all my emails with attachments or with a site that sends out mass mailing.  I don\'t know whats going on I missed 4 assignments from tamarisk and so I changed my email address to jjenkinsappraisalservice@gmail.com', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-03-12 12:03:00', NULL, NULL),
(38, 'Jodi Vinci', 'jvinci@clearmarkvaluation.com', '', 'Clearmark Valuation', 'I have been an appraiser for 27+ years. Recently took a position with a start-up AMC, looking for AMC software. Looking for features and costs.', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-03-10 10:48:00', NULL, NULL),
(39, 'Zohair Sheikh', 'zohair.sheikh@valuelinksoftware.com', '', 'VL', 'demo_req', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-03-10 04:38:00', NULL, NULL),
(40, 'colette harrington', 'colette.harrington@consultpartner360.com', '', 'consultpartner360.com', 'Are you interested in acquiring the attendee list for RSA Conference 2026 to support your marketing initiatives?\r\n\r\nWith RSA Conference 2026 approaching, this is the perfect opportunity to connect with key decision-makers from the event.\r\n\r\nPlease let me know if this would be of interest?I?d be happy to share the available contact count and pricing details.', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-03-09 07:23:00', NULL, NULL),
(41, 'Frank S Moody', 'frankmoody611@gmail.com', '', 'Frank S Moody Appraisals LLC', 'Good afternoon.  I have been using valuelink with the appraisal company I have been working for for several years.  I am leaving to become an independent appraiser and would like to sign on with you.  I already have a profile through the company I am leaving and don\'t know if I need to start over or just transfer what I already have.  Thank you for your help.  I look forward to hearing back from you.', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-03-05 13:04:00', NULL, NULL),
(42, 'Ed Remenapp', 'edremenapp@yahoo.com', '', 'Coldwell Banker Professionals', 'I have an order from estreet Appraisal Management. Order # 262-10475\r\n729 Applegate Dr, Marysville, MI 48040\r\nThe order is through ValueLink. \r\nNeed to know how to log in to an account.\r\nPlease Advise.\r\nEd Remenapp\r\n313-969-0021', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-02-28 11:35:00', NULL, NULL),
(43, 'EDDY MITZEL', 'legendaryappraisal@gmail.com', '', 'Legendary Appraisal', 'need help to log in', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-02-25 13:37:00', NULL, NULL),
(44, 'Larry G Wilson', 'comappraisal@comcast.net', '', 'Community Appraisal, INC', 'How do I submit a quote?', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-02-24 11:13:00', NULL, NULL),
(45, 'Spencer B. Humphrey', 'humphreyhere@pon.net', '', 'Spencer B. Humphrey & Associates', 'I have received a message that you have had trouble getting in touch with me. If it helps my phone number is: (707) 585-0987.\r\n\r\nSpencer B. Humphrey', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-02-23 18:15:00', NULL, NULL),
(46, 'timothy mustard', 'discoapp@comcast.net', '', 'discovery appraisal services', 'i need to reach help but the entire 888 587 0805 number goes directly to an automatic answering message to give me a free emergency alert system.  i cannot receive the help with cmg mortgage I need.  I\'ve received an appraisal order which I cannot properly accept, make an appointment and perform.  Help please  this is a mess and I\'ve wasted over an hour with it.\r\n\r\nTimothy I Mustard, owner of Discovery Appraisal services, 925 998 9855  Please respond', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-02-18 16:23:00', NULL, NULL),
(47, 'Alexander Harris', 'aharris@urbaninformationservices.com', '', 'Urban Information Services, Inc.', 'Please remove me from your system.  I don\'t need to pay an appraiser management company for work.  Thank you.', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-02-09 20:11:00', NULL, NULL),
(48, 'Chris Lesnik', 'clesnik@brrrr.com', '', 'Brrrr Loans', 'Hello - I submitted a form for a demo last week but was never contacted by anyone. My cell is (732) 804-0939, you can reach me there or via email. Thank you', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-02-09 08:27:00', NULL, NULL),
(49, 'Julie Peak', 'juliekpeak@gmail.com', '', 'Northwoods Real Estate Group L', 'Need help logging into E Street to accept orders for appraisals', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-02-02 12:55:00', NULL, NULL),
(50, 'Tracie Grant', 'tgrant@metrocast.net', '', 'Elite Appraisals', 'You have de-activated my account so I can sign up[ as an individual account and it says my email has already been used.  please advise.\r\n\r\nThank you.', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-02-02 06:25:00', NULL, NULL),
(51, 'Christopher D Arnt', 'chrisarntcra@gmail.com', '', 'CDA Appraisal Services', 'There is no easily accessible link on the mail valuelinsoftware page for appraisers to login to their profiles.  Please put one up by the top.', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-01-22 10:29:00', NULL, NULL),
(52, 'Valentina Martirena', 'valentina.martirena@altisource.com', '', 'Altisource Solutions', 'Hello. We are evaluating platforms to support our valuation workflow (appraisals, hybrids, BPOs, AVMs). We need customizable forms with auto?populated fields, images/maps, and robust document handling.\r\nAutomation is key: rules?based assignment, queues, exclusions, and vendor management controls. Reporting (SLA, productivity, financials) and integrations with tools like RealEC, ProxyPics, PPW are required. We?re in early assessment and would like a general pricing overview (per user, per volume, per module, tiered, etc.). Could I please be contacted at my email by a sales rep? Thank you.', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-01-21 09:18:00', NULL, NULL),
(53, 'GEORGE PORTER', 'gpsouthland@gmail.com', '', 'SOUTHLAND APPRAISERS AKA H & P APPRAISALS LLC', 'NO PHONE??ASK FOR QUOTE NO PLACE TO PUT FEE JUST TAKE ME OFF YOUR LIST UNTIL YOU REPLACE THE 3RD GRADER THAT DID YOUR FORMS I WORK 12 COUNTIES HAVE DONE 10,000  AND YOU WANT TO CHARGE ME 20 A MONTH YOUR NUTS AND WE ARE GONE', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-01-16 11:28:00', NULL, NULL),
(54, 'Doug Ledewitz', 'doug@pulserealty.com', '', 'Pulse Realty LLC', 'Hello - I\'m emailing to see if your company works with real estate brokers to complete BPOs or other valuations. Am looking to partner with you if possible. Thank you.', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-01-12 18:22:00', NULL, NULL),
(55, 'Ben Yau', 'benjaminyau@hotmail.com', '', 'Benjamin Yau', 'It looks like I am being double charge for your service because beside value charge me $19,95 months, lenders also deducted a fee for technology per order. would you please help me clarify this.\r\n\r\nThx\r\nBen\r\n(415)378-3711', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-01-09 19:27:00', NULL, NULL),
(56, 'Deb Daniels', 'casddaniels@comcast.net', '', 'Complete Appraisal Solutions, LLC', 'I have added my new license many times to my link... can you please check it..', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-01-09 12:10:00', NULL, NULL),
(57, 'Francis T Mccarthy', 'mccarthyappraisalsny@gmail.com', '', 'mccarthy appraisals', 'lic number  ny 045450327  its said i am already registered', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-01-08 12:01:00', NULL, NULL),
(58, 'Stacey Roberts', 'stacey@valuevirginia.com', '', 'Value Virginia Appraisal Services, LLC', 'Hello, I am a certified appraiser on your panel. I recently renewed my E&O Insurance. I\'m not sure how to update my profile with this information. Can you let me know the correct procedure or contact. Thanks!', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-01-07 12:07:00', NULL, NULL),
(59, 'Zoe Dyer', 'zoe@apexpurefacilities.com', '', 'ApexPure Facilities', 'Are you interested in a straightforward cleaning quote that meets your company\'s specific needs? Our team has earned countless awards for not only the quality of our cleaning services but also the support we offer our customers. May I give you more information? I\'d be available to provide a no-obligation cleaning estimate based on your cleaning expectations and specifications. \r\n\r\nAll the best,\r\n\r\nZoe Dyer\r\nBusiness Development Rep\r\nApexPure Facilities\r\nzoe@apexpurefacilities.com\r\n\r\nRespond with stop to optout.', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-01-06 19:17:00', NULL, NULL),
(60, 'Lois Ellis', 'lois9811@msn.com', '', 'Lois Ellis', 'I received on 08/04/2025 an email reporting that I had completed 99 orders and earned $42,950 in revenue.  is it possible to get another email reflecting total orders for all of 2025 and amount of revenue.  I would appreciate it!', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-01-06 12:41:00', NULL, NULL),
(61, 'Rick Rostkowski', 'rick@janprohoustonclean.com', '', 'Jan-Pro of Houston', 'Would it be helpful to provide you with an updated cleaning quote for your business?\r\n\r\nWe are working with several businesses in the area who say our reliability and attention to detail sets us apart.\r\n\r\nWith your permission, I can provide a site visit, strategy and cleaning quote that will take care of all your facility needs.\r\n\r\nAll the best,\r\n\r\nRick Rostkowski\r\nVP, General Manager\r\nJan-Pro of Houston\r\nrick@janprohoustonclean.com\r\n\r\nAnyone who needs somebody for commercial cleaning this is the place I recommend. They work on everything in a timely and thorough manner. They are worth every penny and dime. Take advantage. I strongly recommend! - Nathan Cervantes\r\n\r\nRespond with stop to optout', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-01-06 09:15:00', NULL, NULL),
(62, 'Lesley Piper', 'lesleypiperali@gmail.com', '', 'LA Appraisals', 'Please stop sending me a request for payment. I don\'t complete appraisals for you and I never have.', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-01-05 14:20:00', NULL, NULL),
(63, 'Mary OBrien', 'tncappraisal@comcast.net', '', 'TNC Appraisal Service, Inc', 'Im trying to log into A2U to reset Marys Password and add her Renewed License and i cant log in', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-01-05 13:54:00', NULL, NULL),
(64, 'Jeffrey Johnson', 'jcomstl@sbcglobal.net', '', 'Johnson Commercial', 'Interested in learning more about your software', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-01-03 22:30:00', NULL, NULL),
(65, 'Erick Leal', 'el478092@gmail.com', '', 'Self', 'Happy new year! My name is Erick Leal and I am trying to contact someone in regards to the job posting on Linkedin for the Sales Position. I would love to hear back from someone regarding this opportunity. Please call me at 281-919-6130. Thank you in advance for this amazing opportunity.', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2026-01-02 16:46:00', NULL, NULL),
(66, 'Joseph Schulte', 'schulteappraisals@hotmail.com', '', 'Schulte Appraisals', 'I have an issue with connect. I am a part time staff appraiser for Opteon USA and I also have my own company. Since connect was used my orders for Schulteappraisals are mixed up with Opteon. My client got an invoice from Opteon for an order that is not theirs. I also got a check for Opteon that has my old address on it. I need some help please I have report due and I can?t get it out with Opteons name all over it', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-28 17:03:00', NULL, NULL),
(67, 'Amelia Hughes', 'amelia@cleaneliteco.com', '', 'CleanElite Co.', 'Are you interested in a straightforward cleaning quote that meets your company\'s specific needs? Our team has earned countless awards for not only the quality of our cleaning services but also the support we offer our customers. May I give you more information? I\'d be available to provide a no-obligation cleaning estimate based on your cleaning expectations and specifications. \r\n\r\nAll the best,\r\n\r\nAmelia Hughes\r\nBusiness Development Rep\r\nCleanElite Co.\r\namelia@cleaneliteco.com\r\n\r\nRespond with stop to optout.', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-25 05:51:00', NULL, NULL),
(68, 'John V LeClair', 'jvleclair53@gmail.com', '', 'JVL Real Estate Appraisal and Consulting', 'I was asked to join Connect to receive orders from Central State Appraisal Services. When I tried to sign up it said I had an account using my name and NYS Certified Residential number but not my email. I need help to find out what this is all about. Thanks.', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-23 12:53:00', NULL, NULL),
(69, 'Clint Sturgill', 'cds1macys@yahoo.com', '', '', 'I got this from the Ohio lottery for redeeming points when I went to print it out it was a digital gift card, but I cut off half the numbers. I tried scanning the QR code. It doesn?t give me what the numbers are. Are you able to help me retrieve this? I could send you the QR code and the numbers in the pictures.Thank you so', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-22 19:57:00', NULL, NULL),
(70, 'United Wholesale', 'freddie@uwm.com', '', 'United WS', 'Looking to setup a demo.', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-22 13:09:00', NULL, NULL),
(71, 'Anthony Pombal', 'anthony@retconference.com', '', 'RETCON', 'Hi there! Can you please connect me to somebody in marketing regarding the opportunity for your company to join RETCON 2026 ? real estate\'s leading innovation conference? Opportunities are filling up and I?d love for you all to be able to take advantage. RETCON 2026 is taking place at the MGM Grand in Las Vegas on March 9-11 and features 2250+ executives and innovation leaders from the country\'s largest property owners, operators and developers. Over 300+ speakers and 150+ sponsors will participate. We have tracks covering multifamily, office, retail, industrial, transformation, AI, investment & asset management, and more. Is your company interested in exploring sponsorship opportunities ? including speaking roles, booths, guaranteed 1-1 meetings, and curated roundtables? The event is quickly selling out, so let me know soon! I can send sample attendee snapshots. https://retconference.com/  - Thanks! Anthony.', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-21 22:29:00', NULL, NULL),
(72, 'Sheree Alexander', 'sheree_d_alexander@homedepot.com', '', 'The Home Depot', 'Leaders, \r\n\r\nThanks so much for the thoughtfulness, it does not go unnoticed and is very much appreciated!  Happy holidays to each of you and yours??', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-19 14:50:00', NULL, NULL),
(73, 'Bella', 'bella@aaalendings.com', '', 'AAA Capital Investment, Inc.', 'There is a login issue. Authentication code could not be sent', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-17 11:01:00', NULL, NULL),
(74, 'Matt Connors', 'mattconnors@fusaca.com', '', 'FUNERAL SHIPPING AND CONSULATE ASSISTANT LLC', 'I will like to learn about your payment solutions', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-12 15:33:00', NULL, NULL),
(75, 'Rick Rostkowski', 'rick@janprohoustonclean.com', '', 'Jan-Pro of Houston', 'Hi,\r\n \r\nI am near you and live in Houston, and work for some of your neighbors. I was hoping I could come by and offer a complimentary cleaning bid? I can also do so over email.\r\n \r\nThank you in advance for your response.\r\n \r\nWith best,\r\n\r\nRick Rostkowski\r\nVP, General Manager\r\nJan-Pro of Houston\r\nrick@janprohoustonclean.com\r\n\r\nAnyone who needs somebody for commercial cleaning this is the place I recommend. They work on everything in a timely and thorough manner. They are worth every penny and dime. Take advantage. I strongly recommend! - Nathan Cervantes\r\n\r\nRespond with stop to optout', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-12 10:18:00', NULL, NULL),
(76, 'Maureen Rucker', 'maureen.r@theprofessionalprofiles.com', '', 'The Professional Profiles', 'Wikipedia is considered to be the World?s most significant tool for reference material. The Wiki links show up on the 1st page of Google 97% of the time. With a Page on one of the most revered reference tools, you are sure to get yourself or your business noticed. So if you\'re thinking of getting a Wikipedia Page created, it\'s the best time of the year.\r\n\r\nIf you are interested in getting more information just respond back to this email.\r\n\r\nThanks,\r\n\r\nMaureen Rucker\r\nThe Professional Profiles\r\nMaureen.r@theprofessionalprofiles.com\r\n\r\nRespond with stop to optout.', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-04 10:15:00', NULL, NULL),
(77, 'Adam LoPresti', 'adamlopresti.wyo@gmail.com', '', 'Brooks Appraisals', 'I have an account with ValueLink as an appraiser, however I have been unable to log in to my account. I have requested submitted a password recovery request, but never receive an email to reset the password. The email associated with the account is likely bebrooks2@vcn.com, however I am switching to alopresti.wyo@gmail.com. Thanks for your help!', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-03 15:23:00', NULL, NULL),
(78, 'Matthew George', 'eagleappraisals@comcast.net', '', 'Eagle Appraisals, Inc', 'I received an alert to update my insurance. When I log into my account and go to my profile, there is no place to upload the insurance.', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-12-02 11:11:00', NULL, NULL),
(79, 'Peter Liapis', 'pjliapis@gmail.com', '', 'Peter John Liapis Enterprises', 'I am not quite sure why my account being deactivated?? My card is still good??', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-11-30 14:41:00', NULL, NULL),
(80, 'Robin Leclaire', 'robinwainleclaire@verizon.net', '', '', 'Gift card no working', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-11-26 14:10:00', NULL, NULL),
(81, 'Gregg R Brooks', 'gbs603@comcast.net', '', 'Brooks Appraisal Services LLC', 'future 3.6 trainings ?', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-11-25 15:36:00', NULL, NULL),
(82, 'Jossy Rascon', 'jossy@ecoedgejanitorial.com', '', 'EcoEdge Janitorial', 'Hi,\r\n \r\nI am local and provide service in Houston And work for others in the community. I was hoping I could come by and offer a complimentary cleaning bid? I can also do so over email.\r\n \r\nThank you in advance for your response.\r\n \r\nWith best,\r\n\r\nJossy Rascon\r\nBusiness Development Rep\r\nEcoEdge Janitorial\r\njossy@ecoedgejanitorial.com\r\n\r\nRespond with stop to optout.', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-11-24 16:08:00', NULL, NULL),
(83, 'Yolanda Burrell', 'yolandaburrell75@gmail.com', '', 'Yolanda L Burrell', 'I\'m appraiser looking to add more lenders to my profile, so I can receive more appraisal orders. Please advise. Thanks 562 824-7373', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-11-19 13:27:00', NULL, NULL),
(84, 'John Shaffer', 'skylineappraisals@hotmail.com', '', 'Skyline Appraisals, Inc.', 'My first time logging in.  I have an order from United Bank that I need to access.  I do not know how to reach my orders.  Thanks!', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-11-18 11:02:00', NULL, NULL),
(85, 'Jennifer Ferguson', 'jfvaluation@gmail.com', '', 'JF Appraisals', 'I believe I am already one of your vendors however I do not see my profile setup. Please advise.', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-11-11 14:54:00', NULL, NULL),
(86, 'Keith Nelson', 'knelson@calhounsands.com', '', 'Retail Petroleum Group, LLC', 'I was charged $19.99 and I have no idea what it\'s for.  Please remove me from your automatic billing and please refund me for this $19.99 charge that i have no idea what it\'s for.  Thank you', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-11-03 07:14:00', NULL, NULL),
(87, 'Ann Kelley', 'orders@wentworthappraisal.net', '', 'Wentworth Appraisal', 'Please remove me from your list, close my account, I no longer want to be on your platform and I want to remove my CC info from your website immediately.', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-11-02 17:12:00', NULL, NULL),
(88, 'John Noonan', 'jnoonan@cbresolutions.com', '', 'CBRES', 'We currently use Appraisal Scope and need to be able to integrate with Value Link in order to service a new client  - - NQM Funding out of FL.\r\n\r\nPlease advise what steps are need to make this work - Thank you', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-31 10:00:00', NULL, NULL),
(89, 'Jennifer C Newton', 'jennewton23@gmail.com', '', 'Newton Appraisal Service', 'Having a problem getting a new password to work.', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-22 17:52:00', NULL, NULL),
(90, 'David E Ciszek', 'dave@davidciszek.com', '', 'David Ciszek, Broker', 'I do appraisals for ESUSA. Lately, I have NOT been able to bid on an order unless I provide a credit card. NOWHERE in our industry does anyone else require I given you my credit card number. I have had my identity stolen 3 times and this requirement appears to me to be some sort of fraud attempt. Please correct if you indeed have the ability to do so. \r\nSincerely, David Ciszek, JD.', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-21 16:52:00', NULL, NULL),
(91, 'Susan Alley', 'susan@appraisalaid.com', '', 'Appraisal Aid', 'I?m reaching out because we support AMCs with USPAP compliance reviews and related compliance initiatives. I?d love to learn more about your internal compliance tools and workflow capabilities for our clients who use ValueLink.  \r\n\r\nMy goal is to better understand how our clients can fully utilize the features already available within your platform. The more value they find in your system, the stronger both of our relationships become ? a true win-win for everyone involved.\r\n\r\nIf there?s someone on your team I could connect with for a brief call or overview, I?d really appreciate it.  Have a fantastic day!', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-17 09:38:00', NULL, NULL),
(92, 'Sheri Efseaff', 'sheri_efseaff@outlook.com', '', 'Sheri Efseaff', 'I am an appraiser.  I currently work with GEM Mortgage.  They asked me to set up a Valuelink account, however, I have an old one under my old email address which is Sheri_Efseaff@roadrunner.com.  I can\'t log in because I no longer have that email address and when I go to request to change the password, it sends the message to my old email address.  Is there a way to change my user name/email address so I can access my account?\r\n\r\nSincerely,\r\n\r\nSheri Efseaff\r\n714/342-0255\r\nSheri_Efseaff@outlook.com', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-14 20:10:00', NULL, NULL),
(93, 'Katie Rozman', 'katie@hdaappraisal.com', '', 'HDA Appraisal', 'My former employer is taking work in my name.  I\'ve found tow of the AMCs on your network I had worked with in the past and was able to update with them.  \r\n\r\nI\'d like to find out if there is a way for me to find out the other AMCs that my prior profile had, so that I can contact them to update my details.\r\n\r\nToday, I won a bid on the system and my prior company was able to get to my work, told the client I didn\'t work for them anymore and then requested the assignment be reassigned!  It was shocking that Chudnow Druck was able to access my account!\r\n\r\nI\'d like to determine how I can separate myself from Chudnow Druck Valuation in all ways, so there is no confusion. \r\n\r\n\r\n\r\nThanks so much!\r\n\r\nKate', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-09 19:18:00', NULL, NULL),
(94, 'Michael Stone', 'mstone@icecapgroup.com', '', 'IceCap Group', 'I?m the CTO of the IceCap Group and we?re interested in integrating with your API to order appraisals, and we?re also interested in obtaining the original XML data from appraisals that we?re ordered for us, but not by us. From our understanding, we should have access to those appraisals that were ordered for our company, but we?d like to know if there?s an option to obtain the original XML file so we can have the raw data instead of just the appraisal document. \r\n\r\nThanks', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-09 16:59:00', NULL, NULL),
(95, 'Rick Rigdon', 'rick7945@gmail.com', '', '', 'Forgot username and password', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-08 15:39:00', NULL, NULL),
(96, 'Dennis R Chaissan', 'dchaissan@gmail.com', '', 'Dennis Appraisal Services', 'The sign up link for joining Connect does not seem to work.', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-07 13:45:00', NULL, NULL),
(97, 'David Lane', 'david.lane@veloxval.com', '', 'Velox Valuations', 'Need help with several things in my profile. Thank you, David Lane 619-665-4291', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-06 18:06:00', NULL, NULL),
(98, 'Robin Leonard', 'appraisals@appraisalsva.com', '', 'Appraisal Services of Virginia', 'I am looking for an appraisal management program for our office, and I like the way Connect works for our internal staff. A huge bonus that it connects to Total, but the biggest piece I need and can\'t seem to find with any appraisal management software is the ability to link to QuickBooks Online. Is that possible with Connect, through direct integration with QBO, or with a third-party software such as Maker?', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-10-01 19:34:00', NULL, NULL),
(99, 'Dennis Poole', 'pooleaz@aol.com', '', 'Sierra Appraisal LLC', 'Tried to update my password and now cannot sign-in. Please update my password if possible. TY', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-09-26 17:58:00', NULL, NULL),
(100, 'Sheikh M Safwan', 'muhammad.safwan@spursol.com', '', 'SpurSol', 'Test Message', '', '', NULL, '', 'CSV Import', 'Contact Us Form', NULL, 'new', '2025-09-06 03:48:00', NULL, NULL),
(101, 'OLIVIA HOWELL', 'olympusamc@gmail.com', 'ncandm@gmail.com', 'Olympus Appraisal Management LLC', 'Software for AMCs - Cost', 'AMC', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-12-22 17:46:17', NULL, NULL),
(102, 'Sheikh Muhammad Safwan', 'muhammad.safwan@spursol.com', '3151182258', 'SpurSol', 'Testing VMDC submission', 'AMC', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-12-22 17:46:17', NULL, NULL),
(103, 'Safwan', 'muhammad.safwan@spursol.com', '3151182258', 'SpurSol', 'Testing VMDC submission', 'Lender', '100?499 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-12-23 17:46:17', NULL, NULL),
(104, 'Leila', 'ltouhamy@unitedmortgage.com', '6313961815', 'United', 'info on your interface ability with Byte Enterprise.', 'Lender', '100?499 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-12-17 17:46:17', NULL, NULL),
(105, 'Stephen Roefaro', 'sroefaro@gmail.com', '3155254657', 'Roefaro Appraisal Service', 'Appraisals', 'AMC', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-12-12 17:46:17', NULL, NULL),
(106, 'Heather', 'heather@valoraamc.com', '8045393163', 'Valora AMC LLC', 'Demo', 'AMC', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-12-12 17:46:17', NULL, NULL),
(107, 'Ekta Sethi', 'realappraisalamc@gmail.com', '?(925) 297-5390?', 'Real Estate Plus LLC.', 'AMC software', 'AMC', '100?499 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-12-06 17:46:17', NULL, NULL),
(108, 'Audra', 'avanderford@emprisebank.com', '13163834494', 'Emprise Bank', 'A streamline system to work with nCino for appraisal ordering', 'AMC', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-12-02 17:46:17', NULL, NULL),
(109, 'James Talbot', 'james@premierlending.org', '5044733030', 'Premier Lending', 'if we fit.', 'Lender', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-11-25 17:46:17', NULL, NULL),
(110, 'Chinsoo Kim', 'chinsookim0516@gmail.com', '9075450326', 'hawaiiinn&suite llc', 'up a meeting', 'Lender', 'Not sure / exploring options', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-11-20 17:46:17', NULL, NULL),
(111, 'James Talbot', 'james@premierlending.org', '5044733030', 'Premier Lending', 'if we fit.', 'Lender', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-11-20 17:46:17', NULL, NULL),
(112, 'Yolanda Burrell', 'yolandaburrell75@gmail.com', '562 824-7373', 'Real Estate Valuation Service', 'I am looking to add more vendors in your network to my profile, so I may receive more orders.', 'AMC', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-11-19 17:46:17', NULL, NULL),
(113, 'Lien King', 'lien@griffinfunding.com', '6196824852', 'Griffin Funding', 'An appraisal platform to build a panel to help with efficiency, cost and turn times', 'Lender', '100?499 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-11-13 17:46:17', NULL, NULL),
(114, 'Ana Margarete Lima dos Santos', 'ana.margarete.santos@gmail.com', '55 (21)96565-7501', 'AML dos Santos Im?veis', 'Laudos de avalia??o e parecer t?cnico', 'AMC', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-11-08 17:46:17', NULL, NULL),
(115, 'Xabad', 'xabad.nadeem@valuelinksoftware.com', '\'+10000000000', 'VLS', 'testing for Encompass', 'Lender', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-11-06 17:46:17', NULL, NULL),
(116, 'Dawn Agee', 'dagee@mtcfederal.com', '8649083457', 'MTC Federal Credit Union', 'We are looking for a new vendor for our appraisal needs. We are current using Nations and are not happy with the turn around time and hidden fees as well as additional trip fees which are not being disclosed.', 'Lender', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-11-03 17:46:17', NULL, NULL),
(117, 'sdxfcg', 'fghdfgf@gmail.com', '2345678910', 'xdcfvgbhnjmk,l', 'sdxcfghjk', 'Lender', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-11-26 17:46:17', NULL, NULL),
(118, 'Florencia R', 'florenciaruedas@gmail.com', '6614008114', 'Sierra Appraisal Network', 'A Demo', 'AMC', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-28 17:46:17', NULL, NULL),
(119, 'Ron', 'ron.szukala@gmail.com', '561-459-0724', 'Lendz Financial', 'reliable tool', 'Lender', '100?499 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-28 17:46:17', NULL, NULL),
(120, 'Timothy Bryll', 'bryllappraisal@sbcglobal.net', '4408569289', 'Bryll Appraisal Service', 'I am an Appraiser trying to establish accoun', 'Other', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-23 17:46:17', NULL, NULL),
(121, 'Sheikh M Safwan', 'safwan@gmail.com', '3152288535', 'SpurSol', 'Test', 'Lender', '100?499 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-24 17:46:17', NULL, NULL),
(122, 'Kevin', 'kevin.johnson@homewoodag.com', '3183930247', 'Homewood Appraisal Group', 'appraisal work', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-22 17:46:17', NULL, NULL),
(123, 'Lou Rusert', 'northbay@reaa.org', '7074840608', 'Real Estate Appraisers Association', 'live demo', 'Appraiser', 'Not sure / exploring options', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-21 17:46:17', NULL, NULL),
(124, 'joanne L DeCabia', 'jdecabia@gmail.com', '9144249356', 'Residential Appraisal Service', 'reset my password', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-21 17:46:17', NULL, NULL),
(125, 'Kenneth Tuttle', 'ktuttle@cfl.rr.com', '407-402-3131', 'Residential Appraisal Associates', 'Registration', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-21 17:46:17', NULL, NULL),
(126, 'Ryan Parent', 'ryep111@gmail.com', '818-984-7926', 'SDI Appraisal Services', 'I am looking to start a new AMC and am looking for software solutions for the management of a modern AMC', 'AMC', 'Not sure / exploring options', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-21 17:46:17', NULL, NULL),
(127, 'Jeff', 'jeffeye1959@gmail.com', '540-333-2190', 'Allegheny Realty', 'Good Morning', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-21 17:46:17', NULL, NULL),
(128, 'Robyn Adams', 'rradams@comcast.net', '4042770212', 'Adams Residential Appraisal Services', 'orders', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-21 17:46:17', NULL, NULL);
INSERT INTO `leads` (`id`, `client_name`, `email`, `phone`, `company`, `message`, `user_role`, `order_volume`, `preferred_date`, `event_title`, `source`, `form_name`, `submission_url`, `status`, `created_at`, `assigned_to`, `qualification_scale`) VALUES
(129, 'Tim Tolbert', 'appraisaladvant@mindspring.com', '408-886-0464', 'Appraisal Advantage', 'demo instructions', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-20 17:46:17', NULL, NULL),
(130, 'Richard Clark', 'gulfsure@aol.com', '7273237153', 'Rick Clark Appraisal Serices Inc', 'Appraisal', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-16 17:46:17', NULL, NULL),
(131, 'Richard Clark', 'gulfsure@aol.com', '7273237153', 'Rick Clark Appraisal Services', '1004', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-16 17:46:17', NULL, NULL),
(132, 'Byron Lea', 'byronlea@att.net', '9706991748', 'Byron Lea Valuation', 'Account setup', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-15 17:46:17', NULL, NULL),
(133, 'Kelly Palomba', 'kcresappraisals@gmail.com', '816-550-8915', 'KC-RES Appraisals', 'Appraisal Work', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-15 17:46:17', NULL, NULL),
(134, 'Kelly Palomba', 'kcresappraisals@gmail.com', '816-550-8915', 'KC-RES Appraisals', 'I\'m looking to be added to your appraiser rotation. I cover Missouri, Kansas and Oklahoma.', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-15 17:46:17', NULL, NULL),
(135, 'Timothy Bryll', 'bryllappraisal@sbcglobal.net', '4408569289', 'Bryll Appraisal Service', 'Trying to get logged into your system', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-15 17:46:17', NULL, NULL),
(136, 'Matt Tarter', 'orders.matt@teamtarter.com', '7655958155', 'Tarter Realty Auction & Appraisal Co', 'New appraisal orders', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-14 17:46:17', NULL, NULL),
(137, 'Greg Hefferan', 'ghefferan@comcast.net', '612-414-7750', 'Greg Hefferan', 'Info on how system works', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-13 17:46:17', NULL, NULL),
(138, 'Donna Rodgers', 'dcrodgers5178@gmail.com', '408-836-5178', 'Donna Rodgers Appraisal', 'completing 1 to 2 appraisal assignments per week', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-13 17:46:17', NULL, NULL),
(139, 'Matt Fernandes', 'matt.fernandes@lendinvestorscapital.com', '8058868720', 'Lend Investors Capital', 'an AMS', 'Lender', '100?499 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-10 17:46:17', NULL, NULL),
(140, 'Robert', 'prandall01@gmail.com', '7708612986', 'Robert Randall', 'Residential appraisal orders', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-09 17:46:17', NULL, NULL),
(141, 'Veronica', 'veronica.vasquez@fsv.gob.sv', '\'+50377425060', 'FSV', 'My name is Ver?nica V?squez, and I am reaching out on behalf of the Fondo Social para la Vivienda (FSV), a leading institution in El Salvador dedicated to promoting affordable housing access for low- and middle-income families. At FSV, we work to provide social housing solutions through financing, property development, and management, ensuring compliance with Salvadoran regulations and maximizing the social impact of our operations. Our goal is to maintain efficient and transparent processes that benefit the communities we serve. We are currently evaluating technological solutions to modernize and optimize our real estate valuation processes, ensuring accuracy, efficiency, and regulatory compliance.', 'Appraiser', 'Not sure / exploring options', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-08 17:46:17', NULL, NULL),
(142, 'Susan B Jackson', 'susancbj@bellsouth.net', '18287759432', 'Associated Appraisal Services', 'Updating my profile', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-08 17:46:17', NULL, NULL),
(143, 'Jeff Eye', 'jeffeye1959@gmail.com', '540-333-2190', 'Allegheny Realty', 'Appraisal Assignments', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-08 17:46:17', NULL, NULL),
(144, 'Mark Thomas', 'mark.thomas@lendinvestorscapital.com', '7034733092', 'Lend Investors Capital', 'An AMS Solution', 'Lender', '100?499 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-07 17:46:17', NULL, NULL),
(145, 'Jessy Bowman', 'jbowmanappraisals@gmail.com', '937-216-4689', 'J Bowman Appraisals', 'appraisals around the Dayton & Cincinnati area. Additionally, I cover Miami county & surrounding areas.', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-07 17:46:17', NULL, NULL),
(146, 'Shawn Lyons', 'indappr@gmail.com', '317-440-2455', 'Indiana Appraisal Service', 'Getting set up to Connect', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-06 17:46:17', NULL, NULL),
(147, 'Shawn Lyons', 'indappr@gmail.com', '317-440-2455', 'Indiana Appraisal Service', 'Getting set up to Connect', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-06 17:46:17', NULL, NULL),
(148, 'Julia James', 'jappraisalsllc@gmail.com', '301-491-8910', 'James Appraisals LLC', 'Instructions on setting up a ValueLink Account', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-05 17:46:17', NULL, NULL),
(149, 'Clayton Hill', 'claytonhill24@icloud.com', '2816368115', 'otss, LLC', 'a way to streamline my appraisal process', 'Appraiser', '100?499 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-05 17:46:17', NULL, NULL),
(150, 'Tanvi Jha', 'officemanager@ciotta-appraisals.com', '5166711400', 'Frank Ciotta Appraisals', 'Demo of Valuelink connect', 'AMC', '100?499 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-07 17:46:17', NULL, NULL),
(151, 'MAGDALENE GREESON', 'ivaluecincy@gmail.com', '1-513-305-7083', 'MAGDALENE GREESON', 'RESIDENTIAL APPRAISAL WORK', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-01 17:46:17', NULL, NULL),
(152, 'Nancy Shoemaker', 'shoethree@skybest.com', '336-877-7542', 'Shoemaker Appraisal Services', 'orders in Ashe and Watauga counties, NC', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-01 17:46:17', NULL, NULL),
(153, 'Brenda Shea', 'sheabrenda@gmail.com', '951-264-3333', 'Brenda Shea Appraiser', 'for additional Appraisal work.', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-01 17:46:17', NULL, NULL),
(154, 'Ryan Lefkowitz', 'ryan@lendoor.com', '6234193484', 'Lendoor', 'an appraisal order solution', 'Lender', '100?499 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-01 17:46:17', NULL, NULL),
(155, 'Jessy Weaver', 'appraiserjessy@gmail.com', '402-620-8563', 'TrueMark Appraisals LLC', 'Conventional orders in Northwest Iowa.', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-01 17:46:17', NULL, NULL),
(156, 'Nancy Shoemaker', 'shoethree@skybest.com', '336-877-7542', 'Shoemaker Appraisal Services', 'orders in Ashe and Watauga counties, NC', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-01 17:46:17', NULL, NULL),
(157, 'Eddie Gonzalez', 'eddie.gonzalez@churchillmortgage.com', '615-767-5222', 'Churchill Mortgage', 'Looking at middleware vendors for appraisal ordering. Also, appraisal review via AI', 'Lender', '100?499 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-09-30 17:46:17', NULL, NULL),
(158, 'Sheikh M Safwan', 'safwan@gmail.com', '3152288535', 'SpurSol', 'Lender', 'Lender', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-09-30 17:46:17', NULL, NULL),
(159, 'Ryan', 'ryan@lendoor.com', '6234193484', 'Lendoor', 'an appraisal order solution', 'Lender', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-09-29 17:46:17', NULL, NULL),
(160, 'Tasia Willhite', 'tasiawillhite@gmail.com', '903-348-6898', 'Willhite Appraisal Company LLC', 'An account to receive orders from a current client switching to this platform for orders.', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-09-26 17:46:17', NULL, NULL),
(161, 'Sheikh M Safwan', 'safwan@gmail.com', '3152288535', 'SpurSol', 'Test', 'Lender', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-09-27 17:46:17', NULL, NULL),
(162, 'Sheikh M Safwan', 'muhammad.safwan@spursol.com', '', 'SpurSol', 'Test', '', '', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-09-17 17:46:17', NULL, NULL),
(164, 'Derek Bolls', 'dbolls@metriqvaluation.com', '832-721-1660', 'MetriQ Valuation, LLC', 'demo of your AMS', 'AMC', '1,000?4,999 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-03-12 17:49:22', NULL, NULL),
(165, 'Zohair Sheikh', 'zohair.sheikh@valuelinksoftware.com', '\'+18885870805', 'VL', 'Demo req', 'AMC', '100?499 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-03-10 17:49:22', NULL, NULL),
(166, 'Zohair Sheikh', 'zohair.sheikh@valuelinksoftware.com', '\'+18885870805', 'VL', 'Demo req', 'AMC', '100?499 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-03-10 17:49:22', NULL, NULL),
(167, 'Zohair Sheikh', 'zohair.sheikh@valuelinksoftware.com', '\'+18885870805', 'VL', 'Demo req', 'AMC', '100?499 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-03-10 17:49:22', NULL, NULL),
(168, 'Zohair Sheikh', 'zohair.sheikh@valuelinksoftware.com', '\'+18885870805', 'VL', 'Demo req', 'AMC', '100?499 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-03-10 17:49:22', NULL, NULL),
(169, 'Harold Harper', 'harold.harper@tieronetitle.com', '8138981277', 'Tier 1 Title', 'information to be set up in realec to receive title orders.', 'AMC', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-03-09 17:49:22', NULL, NULL),
(170, 'Jodi', 'jvinci@clearmarkvaluation.com', '614-570-7895', 'Clearmark Valuation', 'How the system works and costs', 'AMC', 'Not sure / exploring options', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-03-09 17:49:22', NULL, NULL),
(171, 'Karen Kegel', 'k.appraisal@outlook.com', '8457075040', 'Foundry Valuation', 'Demo, info & pricing', 'AMC', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-03-09 17:49:22', NULL, NULL),
(172, 'Sofia Vanegas', 'sofia.vanegas@dalberg.com', '\'+57 3212496885', 'Dalberg', 'an appraisal management software that can be used by a bank in Panama. Could ValueLink provide that? Thank you!', 'Lender', '100?499 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-03-03 17:49:22', NULL, NULL),
(173, 'Lisa Stremme', 'lstremme@vipmtginc.com', '602 418-4559', 'VIP Mortgage Inc', 'A demo on your system.', 'Lender', '500?999 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-03-02 17:49:22', NULL, NULL),
(174, 'Priscilla Arzivian', 'priscillaarzivian@gmail.com', '3867957653', 'LPT Realty , llc', 'bpos', 'AMC', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-02-28 17:49:22', NULL, NULL),
(175, 'Matthew Wolfer', 'matthew@ledgertc.com', '5089335601', 'Ledger Trade and Capital', 'New AMC for RTL/DSCR loans', 'Lender', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-02-26 17:49:22', NULL, NULL),
(176, 'amita singh', 'mark2pan@yahoo.com', '\'+16462702889', 'aaa enterpries llc', 'appraiser', 'Lender', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-02-26 17:49:22', NULL, NULL),
(177, 'Nikki Dao', 'nikkidao@barrettfinancial.com', '4077332261', 'Barrett Financial Group LLC', 'login to order appraisal', 'Lender', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-02-23 17:49:22', NULL, NULL),
(178, 'Walter Graham', 'waltgraham18@gmail.com', '2672512330', 'DC Casper Real Estate', 'to complete bpos', 'AMC', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-02-15 17:49:22', NULL, NULL),
(179, 'Sheikh Muhammad Safwan', 'safwan.spursol@gmail.com', '3152288535', 'SpurSol', 'Test', 'Lender', '5,000+ orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-02-13 17:49:22', NULL, NULL),
(180, 'Tom Armstrong, MAI', 'tom@aandsappraisal.com', '2566846606', 'A&S Appraisal Co., LLC', 'Commercial Appraisals', 'AMC', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-02-11 17:49:22', NULL, NULL),
(181, 'Francis', 'frank@redfish-appraisals.com', '4095026065', 'Redfish Appraisal Services', 'I am looking to push and pull appraisals', 'AMC', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-02-10 17:49:22', NULL, NULL),
(182, 'EMAD RAYYAN', 'socaldirect@aol.com', '7142876900', 'So Cal Direct AMC', 'replacing my current software', 'AMC', '500?999 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-02-06 17:49:22', NULL, NULL),
(183, 'Chris Lesnik', 'clesnik@brrrr.com', '17328040939', 'Brrrr Loans', 'Integrate into my loan portal that is self built', 'Lender', '100?499 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-02-05 17:49:22', NULL, NULL),
(184, 'Cory Reed', 'creed@altaircapitalgroup.com', '\'+18454921877', 'Altair Capital Group', 'Consult', 'Lender', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-02-04 17:49:22', NULL, NULL),
(185, 'Lisa Arnold', 'larnold@unitedappraisalvaluations.com', '708-852-3710', 'United Appraisal Valuations', 'We are a startup Company looking to get started', 'AMC', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-01-29 17:49:22', NULL, NULL),
(186, 'Joe Quenneville', 'joe@poseidonaisystems.com', '9257879222', 'Accuity Appraisal Services', 'Complete appraisal management stack', 'AMC', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-01-30 17:49:22', NULL, NULL),
(187, 'Tom Kennedy', 'tom.kennedy@regions.com', '601-554-2330', 'Regions Mortgage', 'An AI based review tool', 'Lender', '1,000?4,999 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-01-29 17:49:22', NULL, NULL),
(188, 'Kamal', 'kamal.lalwani@zenzinnovation.com', '\'+12792487434', 'Zenz Innovation', 'Want to do automated valuation for client property', 'AMC', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-01-23 17:49:22', NULL, NULL),
(189, 'Sanjay Sethi', 'info@realestateplusamc.com', '19255518500', 'Real Esatte Plus LLC', 'Sofftware to manage orders', 'AMC', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-01-18 17:49:22', NULL, NULL),
(190, 'George Lewis', 'george.lewis@cbtcares.com', '919-815-2443', 'Carter Bank & Trust', 'Looking AVM and other valuations for Home Equity Lines', 'Lender', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-01-12 17:49:22', NULL, NULL),
(191, 'Noelle', 'noelle.mundy@waynebank.com', '570-253-8517', 'Mundy', 'an appraisal ordering management system', 'Lender', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-01-08 17:49:22', NULL, NULL),
(192, 'Evan Schwartz', 'evan@ehsmgmt.net', '732-245-7380', 'EHS Appraisal Management', 'info on pricing, integration, data migration', 'AMC', '100?499 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2026-01-06 17:49:22', NULL, NULL),
(193, 'Raymond Wood', 'r_wood@bellsouth.net', '9542905543', 'Raymond G. Wood', 'I have been working with Supreme lending for many years and have been an appraiser with myAMC just as long. I an trying to navigate ValueLinks new system.', 'AMC', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-12-28 17:49:22', NULL, NULL),
(194, 'Sanjay Sethi', 'sanjay@ekdsa.com', '19255518500', 'Real Esatte Plus LLC', 'Sofftware to manage orders', 'AMC', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-12-27 17:49:22', NULL, NULL),
(195, 'OLIVIA HOWELL', 'olympusamc@gmail.com', 'ncandm@gmail.com', 'Olympus Appraisal Management LLC', 'Software for AMCs - Cost', 'AMC', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-12-22 17:49:22', NULL, NULL),
(196, 'Sheikh Muhammad Safwan', 'muhammad.safwan@spursol.com', '3151182258', 'SpurSol', 'Testing VMDC submission', 'AMC', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-12-22 17:49:22', NULL, NULL),
(197, 'Safwan', 'muhammad.safwan@spursol.com', '3151182258', 'SpurSol', 'Testing VMDC submission', 'Lender', '100?499 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-12-23 17:49:22', NULL, NULL),
(198, 'Leila', 'ltouhamy@unitedmortgage.com', '6313961815', 'United', 'info on your interface ability with Byte Enterprise.', 'Lender', '100?499 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-12-17 17:49:22', NULL, NULL),
(199, 'Stephen Roefaro', 'sroefaro@gmail.com', '3155254657', 'Roefaro Appraisal Service', 'Appraisals', 'AMC', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-12-12 17:49:22', NULL, NULL),
(200, 'Heather', 'heather@valoraamc.com', '8045393163', 'Valora AMC LLC', 'Demo', 'AMC', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-12-12 17:49:22', NULL, NULL),
(201, 'Ekta Sethi', 'realappraisalamc@gmail.com', '?(925) 297-5390?', 'Real Estate Plus LLC.', 'AMC software', 'AMC', '100?499 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-12-06 17:49:22', NULL, NULL),
(202, 'Audra', 'avanderford@emprisebank.com', '13163834494', 'Emprise Bank', 'A streamline system to work with nCino for appraisal ordering', 'AMC', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-12-02 17:49:22', NULL, NULL),
(203, 'James Talbot', 'james@premierlending.org', '5044733030', 'Premier Lending', 'if we fit.', 'Lender', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-11-25 17:49:22', NULL, NULL),
(204, 'Chinsoo Kim', 'chinsookim0516@gmail.com', '9075450326', 'hawaiiinn&suite llc', 'up a meeting', 'Lender', 'Not sure / exploring options', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-11-20 17:49:22', NULL, NULL),
(205, 'James Talbot', 'james@premierlending.org', '5044733030', 'Premier Lending', 'if we fit.', 'Lender', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-11-20 17:49:22', NULL, NULL),
(206, 'Yolanda Burrell', 'yolandaburrell75@gmail.com', '562 824-7373', 'Real Estate Valuation Service', 'I am looking to add more vendors in your network to my profile, so I may receive more orders.', 'AMC', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-11-19 17:49:22', NULL, NULL),
(207, 'Lien King', 'lien@griffinfunding.com', '6196824852', 'Griffin Funding', 'An appraisal platform to build a panel to help with efficiency, cost and turn times', 'Lender', '100?499 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-11-13 17:49:22', NULL, NULL),
(208, 'Ana Margarete Lima dos Santos', 'ana.margarete.santos@gmail.com', '55 (21)96565-7501', 'AML dos Santos Im?veis', 'Laudos de avalia??o e parecer t?cnico', 'AMC', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-11-08 17:49:22', NULL, NULL),
(209, 'Xabad', 'xabad.nadeem@valuelinksoftware.com', '\'+10000000000', 'VLS', 'testing for Encompass', 'Lender', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-11-06 17:49:22', NULL, NULL),
(210, 'Dawn Agee', 'dagee@mtcfederal.com', '8649083457', 'MTC Federal Credit Union', 'We are looking for a new vendor for our appraisal needs. We are current using Nations and are not happy with the turn around time and hidden fees as well as additional trip fees which are not being disclosed.', 'Lender', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-11-03 17:49:22', NULL, NULL),
(211, 'sdxfcg', 'fghdfgf@gmail.com', '2345678910', 'xdcfvgbhnjmk,l', 'sdxcfghjk', 'Lender', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-11-26 17:49:22', NULL, NULL),
(212, 'Florencia R', 'florenciaruedas@gmail.com', '6614008114', 'Sierra Appraisal Network', 'A Demo', 'AMC', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-28 17:49:22', NULL, NULL),
(213, 'Ron', 'ron.szukala@gmail.com', '561-459-0724', 'Lendz Financial', 'reliable tool', 'Lender', '100?499 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-28 17:49:22', NULL, NULL),
(214, 'Timothy Bryll', 'bryllappraisal@sbcglobal.net', '4408569289', 'Bryll Appraisal Service', 'I am an Appraiser trying to establish accoun', 'Other', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-23 17:49:22', NULL, NULL),
(215, 'Sheikh M Safwan', 'safwan@gmail.com', '3152288535', 'SpurSol', 'Test', 'Lender', '100?499 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-24 17:49:22', NULL, NULL),
(216, 'Kevin', 'kevin.johnson@homewoodag.com', '3183930247', 'Homewood Appraisal Group', 'appraisal work', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-22 17:49:22', NULL, NULL),
(217, 'Lou Rusert', 'northbay@reaa.org', '7074840608', 'Real Estate Appraisers Association', 'live demo', 'Appraiser', 'Not sure / exploring options', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-21 17:49:22', NULL, NULL),
(218, 'joanne L DeCabia', 'jdecabia@gmail.com', '9144249356', 'Residential Appraisal Service', 'reset my password', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-21 17:49:22', NULL, NULL),
(219, 'Kenneth Tuttle', 'ktuttle@cfl.rr.com', '407-402-3131', 'Residential Appraisal Associates', 'Registration', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-21 17:49:22', NULL, NULL),
(220, 'Ryan Parent', 'ryep111@gmail.com', '818-984-7926', 'SDI Appraisal Services', 'I am looking to start a new AMC and am looking for software solutions for the management of a modern AMC', 'AMC', 'Not sure / exploring options', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-21 17:49:22', NULL, NULL),
(221, 'Jeff', 'jeffeye1959@gmail.com', '540-333-2190', 'Allegheny Realty', 'Good Morning', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-21 17:49:22', NULL, NULL),
(222, 'Robyn Adams', 'rradams@comcast.net', '4042770212', 'Adams Residential Appraisal Services', 'orders', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-21 17:49:22', NULL, NULL),
(223, 'Tim Tolbert', 'appraisaladvant@mindspring.com', '408-886-0464', 'Appraisal Advantage', 'demo instructions', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-20 17:49:22', NULL, NULL),
(224, 'Richard Clark', 'gulfsure@aol.com', '7273237153', 'Rick Clark Appraisal Serices Inc', 'Appraisal', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-16 17:49:22', NULL, NULL),
(225, 'Richard Clark', 'gulfsure@aol.com', '7273237153', 'Rick Clark Appraisal Services', '1004', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-16 17:49:22', NULL, NULL),
(226, 'Byron Lea', 'byronlea@att.net', '9706991748', 'Byron Lea Valuation', 'Account setup', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-15 17:49:22', NULL, NULL),
(227, 'Kelly Palomba', 'kcresappraisals@gmail.com', '816-550-8915', 'KC-RES Appraisals', 'Appraisal Work', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-15 17:49:22', NULL, NULL),
(228, 'Kelly Palomba', 'kcresappraisals@gmail.com', '816-550-8915', 'KC-RES Appraisals', 'I\'m looking to be added to your appraiser rotation. I cover Missouri, Kansas and Oklahoma.', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-15 17:49:22', NULL, NULL),
(229, 'Timothy Bryll', 'bryllappraisal@sbcglobal.net', '4408569289', 'Bryll Appraisal Service', 'Trying to get logged into your system', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-15 17:49:22', NULL, NULL),
(230, 'Matt Tarter', 'orders.matt@teamtarter.com', '7655958155', 'Tarter Realty Auction & Appraisal Co', 'New appraisal orders', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-14 17:49:22', NULL, NULL),
(231, 'Greg Hefferan', 'ghefferan@comcast.net', '612-414-7750', 'Greg Hefferan', 'Info on how system works', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-13 17:49:22', NULL, NULL),
(232, 'Donna Rodgers', 'dcrodgers5178@gmail.com', '408-836-5178', 'Donna Rodgers Appraisal', 'completing 1 to 2 appraisal assignments per week', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-13 17:49:22', NULL, NULL),
(233, 'Matt Fernandes', 'matt.fernandes@lendinvestorscapital.com', '8058868720', 'Lend Investors Capital', 'an AMS', 'Lender', '100?499 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-10 17:49:22', NULL, NULL),
(234, 'Robert', 'prandall01@gmail.com', '7708612986', 'Robert Randall', 'Residential appraisal orders', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-09 17:49:22', NULL, NULL),
(235, 'Veronica', 'veronica.vasquez@fsv.gob.sv', '\'+50377425060', 'FSV', 'My name is Ver?nica V?squez, and I am reaching out on behalf of the Fondo Social para la Vivienda (FSV), a leading institution in El Salvador dedicated to promoting affordable housing access for low- and middle-income families. At FSV, we work to provide social housing solutions through financing, property development, and management, ensuring compliance with Salvadoran regulations and maximizing the social impact of our operations. Our goal is to maintain efficient and transparent processes that benefit the communities we serve. We are currently evaluating technological solutions to modernize and optimize our real estate valuation processes, ensuring accuracy, efficiency, and regulatory compliance.', 'Appraiser', 'Not sure / exploring options', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-08 17:49:22', NULL, NULL),
(236, 'Susan B Jackson', 'susancbj@bellsouth.net', '18287759432', 'Associated Appraisal Services', 'Updating my profile', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-08 17:49:22', NULL, NULL),
(237, 'Jeff Eye', 'jeffeye1959@gmail.com', '540-333-2190', 'Allegheny Realty', 'Appraisal Assignments', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-08 17:49:22', NULL, NULL),
(238, 'Mark Thomas', 'mark.thomas@lendinvestorscapital.com', '7034733092', 'Lend Investors Capital', 'An AMS Solution', 'Lender', '100?499 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-07 17:49:22', NULL, NULL),
(239, 'Jessy Bowman', 'jbowmanappraisals@gmail.com', '937-216-4689', 'J Bowman Appraisals', 'appraisals around the Dayton & Cincinnati area. Additionally, I cover Miami county & surrounding areas.', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-07 17:49:22', NULL, NULL),
(240, 'Shawn Lyons', 'indappr@gmail.com', '317-440-2455', 'Indiana Appraisal Service', 'Getting set up to Connect', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-06 17:49:22', NULL, NULL),
(241, 'Shawn Lyons', 'indappr@gmail.com', '317-440-2455', 'Indiana Appraisal Service', 'Getting set up to Connect', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-06 17:49:22', NULL, NULL),
(242, 'Julia James', 'jappraisalsllc@gmail.com', '301-491-8910', 'James Appraisals LLC', 'Instructions on setting up a ValueLink Account', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-05 17:49:22', NULL, NULL),
(243, 'Clayton Hill', 'claytonhill24@icloud.com', '2816368115', 'otss, LLC', 'a way to streamline my appraisal process', 'Appraiser', '100?499 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-05 17:49:22', NULL, NULL),
(244, 'Tanvi Jha', 'officemanager@ciotta-appraisals.com', '5166711400', 'Frank Ciotta Appraisals', 'Demo of Valuelink connect', 'AMC', '100?499 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-07 17:49:22', NULL, NULL),
(245, 'MAGDALENE GREESON', 'ivaluecincy@gmail.com', '1-513-305-7083', 'MAGDALENE GREESON', 'RESIDENTIAL APPRAISAL WORK', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-01 17:49:22', NULL, NULL),
(246, 'Nancy Shoemaker', 'shoethree@skybest.com', '336-877-7542', 'Shoemaker Appraisal Services', 'orders in Ashe and Watauga counties, NC', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-01 17:49:22', NULL, NULL),
(247, 'Brenda Shea', 'sheabrenda@gmail.com', '951-264-3333', 'Brenda Shea Appraiser', 'for additional Appraisal work.', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-01 17:49:22', NULL, NULL),
(248, 'Ryan Lefkowitz', 'ryan@lendoor.com', '6234193484', 'Lendoor', 'an appraisal order solution', 'Lender', '100?499 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-01 17:49:22', NULL, NULL),
(249, 'Jessy Weaver', 'appraiserjessy@gmail.com', '402-620-8563', 'TrueMark Appraisals LLC', 'Conventional orders in Northwest Iowa.', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-01 17:49:22', NULL, NULL),
(250, 'Nancy Shoemaker', 'shoethree@skybest.com', '336-877-7542', 'Shoemaker Appraisal Services', 'orders in Ashe and Watauga counties, NC', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-10-01 17:49:22', NULL, NULL),
(251, 'Eddie Gonzalez', 'eddie.gonzalez@churchillmortgage.com', '615-767-5222', 'Churchill Mortgage', 'Looking at middleware vendors for appraisal ordering. Also, appraisal review via AI', 'Lender', '100?499 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-09-30 17:49:22', NULL, NULL),
(252, 'Sheikh M Safwan', 'safwan@gmail.com', '3152288535', 'SpurSol', 'Lender', 'Lender', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-09-30 17:49:22', NULL, NULL),
(253, 'Ryan', 'ryan@lendoor.com', '6234193484', 'Lendoor', 'an appraisal order solution', 'Lender', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-09-29 17:49:22', NULL, NULL),
(254, 'Tasia Willhite', 'tasiawillhite@gmail.com', '903-348-6898', 'Willhite Appraisal Company LLC', 'An account to receive orders from a current client switching to this platform for orders.', 'Appraiser', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-09-26 17:49:22', NULL, NULL),
(255, 'Sheikh M Safwan', 'safwan@gmail.com', '3152288535', 'SpurSol', 'Test', 'Lender', '0?99 orders / month', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-09-27 17:49:22', NULL, NULL),
(256, 'Sheikh M Safwan', 'muhammad.safwan@spursol.com', '', 'SpurSol', 'Test', '', '', NULL, '', 'CSV Import', 'Demo Request Form', NULL, 'new', '2025-09-17 17:49:22', NULL, NULL),
(258, 'Imported User', 'glehnes@bridgeamc.com', '', '', '', '', '', NULL, '', 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2025-12-17 11:10:14', NULL, NULL),
(259, 'Imported User', 'tjswider@creditlenders.com', '', '', '', '', '', NULL, '', 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2025-10-27 13:28:29', NULL, NULL),
(260, 'Imported User', 'jshives@samco-amc.com', '', '', '', '', '', NULL, '', 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2025-10-16 10:21:12', NULL, NULL),
(261, 'Imported User', 'j@yopmail.com', '', '', '', '', '', NULL, '', 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2025-10-14 14:53:14', NULL, NULL),
(262, 'Imported User', 'david.carroll@pnc.com', '', '', '', '', '', NULL, '', 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2025-10-13 19:36:39', NULL, NULL),
(263, 'Imported User', 'chris.hunt@valuationnexus.com', '', '', '', '', '', NULL, '', 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2025-10-07 13:19:38', NULL, NULL),
(264, 'Imported User', 'canfield86@gmail.com', '', '', '', '', '', NULL, '', 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2026-03-06 18:30:00', NULL, NULL),
(265, 'Imported User', 'edremenapp@yahoo.com', '', '', '', '', '', NULL, '', 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2026-03-03 12:51:00', NULL, NULL),
(266, 'Imported User', 'mstepanovich@guardianassetmgt.com', '', '', '', '', '', NULL, '', 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2026-02-25 17:26:00', NULL, NULL),
(267, 'Imported User', 'leonie.tait@rpsrealsolutions.com', '', '', '', '', '', NULL, '', 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2026-02-12 16:25:00', NULL, NULL),
(268, 'Imported User', 'melissa.curtis@valuelinksoftware.com', '', '', '', '', '', NULL, '', 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2026-02-04 14:20:00', NULL, NULL),
(269, 'Imported User', 'batonrougeappraiser@gmail.com', '', '', '', '', '', NULL, '', 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2026-01-24 21:47:00', NULL, NULL),
(270, 'Imported User', 'peterbutcher76@gmail.com', '', '', '', '', '', NULL, '', 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2026-01-21 05:57:00', NULL, NULL),
(271, 'Imported User', 'fordappraisal@gmail.com', '', '', '', '', '', NULL, '', 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2025-12-24 13:39:00', NULL, NULL),
(272, 'Imported User', 'glehnes@bridgeamc.com', '', '', '', '', '', NULL, '', 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2025-12-17 11:10:00', NULL, NULL),
(273, 'Imported User', 'tjswider@creditlenders.com', '', '', '', '', '', NULL, '', 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2025-10-27 13:28:00', NULL, NULL),
(274, 'Imported User', 'jshives@samco-amc.com', '', '', '', '', '', NULL, '', 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2025-10-16 10:21:00', NULL, NULL),
(275, 'Imported User', 'j@yopmail.com', '', '', '', '', '', NULL, '', 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2025-10-14 14:53:00', NULL, NULL),
(276, 'Imported User', 'david.carroll@pnc.com', '', '', '', '', '', NULL, '', 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2025-10-13 19:36:00', NULL, NULL),
(277, 'Imported User', 'chris.hunt@valuationnexus.com', '', '', '', '', '', NULL, '', 'CSV Import', 'Newsletter Subscription Form', NULL, 'new', '2025-10-07 13:19:00', NULL, NULL),
(300, 'Amy Moss', 'amoss@cortrustbank.com', '', 'CorTrust Mortgage', '', '', '', NULL, '18/03/2026', 'CSV Import', 'Events Form', NULL, 'new', '2026-03-09 10:06:00', NULL, NULL),
(301, 'Amy Moss', 'amoss@cortrustbank.com', '', 'CorTrust Mortgage, Inc.', '', '', '', NULL, '17/03/2026', 'CSV Import', 'Events Form', NULL, 'new', '2026-03-06 11:10:00', NULL, NULL),
(302, 'Sheikh M Safwan', 'muhammad.safwan@spursol.com', '', 'SpurSol', 'Test', '', '', NULL, '24/01/2026', 'CSV Import', 'Events Form', NULL, 'new', '2026-01-22 07:03:00', NULL, NULL),
(303, 'Sheikh M Safwan', 'muhammad.safwan@spursol.com', '', 'SpurSol', 'test', '', '', NULL, '9/1/2026', 'CSV Import', 'Events Form', NULL, 'new', '2026-01-08 05:04:00', NULL, NULL),
(304, 'ValueLink Software', 'marketing@valuelinksoftware.com', '', 'SpurSol', 'Testing form', '', '', NULL, '3/10/2025', 'CSV Import', 'Events Form', NULL, 'new', '2025-10-02 06:08:00', NULL, NULL),
(305, 'Jonathan Gifford', 'jgifford@inspirehomeloans.com', '', 'Inspire Home Loans', 'Interested in spending 15 minutes seeing a demo of your product.', '', '', NULL, '21/10/2025', 'CSV Import', 'Events Form', NULL, 'new', '2025-09-30 12:36:00', NULL, NULL),
(306, 'Sheikh M Safwan', 'safwan@gmail.com', '', 'SpurSol', 'Test', '', '', NULL, '30/09/2025', 'CSV Import', 'Events Form', NULL, 'new', '2025-09-29 08:19:00', NULL, NULL),
(307, 'Sheikh M Safwan', 'muhammad.safwan@spursol.com', '', 'SpurSol', 'Test Message', '', '', NULL, '12/9/2025', 'CSV Import', 'Events Form', NULL, 'new', '2025-09-11 06:02:00', NULL, NULL),
(308, 'Sheikh M Safwan', 'muhammad.safwan@spursol.com', '', 'SpurSol', 'Test 2', '', '', NULL, '23/08/2025', 'CSV Import', 'Events Form', NULL, 'new', '2025-08-20 15:49:00', NULL, NULL),
(309, 'Sheikh M Safwan', 'muhammad.safwan@spursol.com', '', 'SpurSol', 'Test on Staging', '', '', NULL, '22/08/2025', 'CSV Import', 'Events Form', NULL, 'new', '2025-08-20 15:40:00', NULL, NULL),
(310, 'Sanjay Sethi', 'sanjay@execs.com', '9252165850', 'Real estate plus llc', 'Software to manage orders', 'AMC', '100?499 orders / month', NULL, '', 'CSV Import', 'Request a Demo Form Mobile View', NULL, 'new', '2025-12-22 18:17:08', NULL, NULL),
(311, 'Etoka Mzaliwa', 'mzaliwaetoka8@gmail.com', '8435341924', 'Tyson', 'Yes', 'AMC', '100?499 orders / month', NULL, '', 'CSV Import', 'Request a Demo Form Mobile View', NULL, 'new', '2025-11-30 18:17:08', NULL, NULL),
(312, 'Paul Donaldson', 'paul.donaldson@heartlandvaluation.com', '5164268126', 'Heartland Valuation', 'I would like information to connect with your platform', 'AMC', '1,000?4,999 orders / month', NULL, '', 'CSV Import', 'Request a Demo Form Mobile View', NULL, 'new', '2025-11-13 18:17:08', NULL, NULL),
(313, 'Dannie Wallace', 'leeboyywallace1155@gmail.com', '9707599882', 'Openspace.com', 'I\'m in here with nothing but a chance to get a chance to work on my way to make sure you have a chance to get the operable chain port y6 in a few minutes to go inside of the operable coin protextcoin XD with my portfolio account and the strongest point of creating a data base model successful and value of a few years and value of a new equation of protex coin protextcoin XD and the strongest point of protex is there is no way to the world to be there in time but a lot of ways to be a data level of protex and', 'AMC', '5,000+ orders / month', NULL, '', 'CSV Import', 'Request a Demo Form Mobile View', NULL, 'new', '2025-11-01 18:17:08', NULL, NULL),
(314, 'Florencia', 'florenciarurdas@gmail.com', '6614008114', 'Sierra', 'Demo', 'AMC', '0?99 orders / month', NULL, '', 'CSV Import', 'Request a Demo Form Mobile View', NULL, 'new', '2025-10-21 18:17:08', NULL, NULL),
(315, 'Con Karl', 'j@yopmai.com', '\'+1 900-433-6328', 'Hatami', 'ogf', 'Appraiser', 'Not sure / exploring options', NULL, '', 'CSV Import', 'Request a Demo Form Mobile View', NULL, 'new', '2025-10-08 18:17:08', NULL, NULL),
(316, 'John Barry', 'jkb8@ntrs.com', '', 'Northern Trust', 'Gift card', '', '', NULL, '', 'CSV Import', 'Request a Demo Form Mobile View', NULL, 'new', '2025-09-26 18:17:08', NULL, NULL),
(317, 'Kimberly Vargas', 'appraisalmanagement@outlook.com', '6313008127', 'Appraisal Management', 'To get my company integrated to receive orders through your company', 'AMC', '0?99 orders / month', NULL, '', 'CSV Import', 'Request a Demo Form Mobile View', NULL, 'new', '2026-01-06 08:45:00', NULL, NULL),
(318, 'Sanjay Sethi', 'sanjay@execs.com', '9252165850', 'Real estate plus llc', 'Software to manage orders', 'AMC', '100?499 orders / month', NULL, '', 'CSV Import', 'Request a Demo Form Mobile View', NULL, 'new', '2025-12-21 12:27:00', NULL, NULL),
(319, 'Etoka Mzaliwa', 'mzaliwaetoka8@gmail.com', '8435341924', 'Tyson', 'Yes', 'AMC', '100?499 orders / month', NULL, '', 'CSV Import', 'Request a Demo Form Mobile View', NULL, 'new', '2025-11-26 10:25:00', NULL, NULL),
(320, 'Paul Donaldson', 'paul.donaldson@heartlandvaluation.com', '5164268126', 'Heartland Valuation', 'I would like information to connect with your platform', 'AMC', '1,000?4,999 orders / month', NULL, '', 'CSV Import', 'Request a Demo Form Mobile View', NULL, 'new', '2025-11-12 18:56:00', NULL, NULL),
(321, 'Dannie Wallace', 'leeboyywallace1155@gmail.com', '9707599882', 'Openspace.com', 'I\'m in here with nothing but a chance to get a chance to work on my way to make sure you have a chance to get the operable chain port y6 in a few minutes to go inside of the operable coin protextcoin XD with my portfolio account and the strongest point of creating a data base model successful and value of a few years and value of a new equation of protex coin protextcoin XD and the strongest point of protex is there is no way to the world to be there in time but a lot of ways to be a data level of protex and', 'AMC', '5,000+ orders / month', NULL, '', 'CSV Import', 'Request a Demo Form Mobile View', NULL, 'new', '2025-11-01 09:57:00', NULL, NULL),
(322, 'Florencia', 'florenciarurdas@gmail.com', '6614008114', 'Sierra', 'Demo', 'AMC', '0?99 orders / month', NULL, '', 'CSV Import', 'Request a Demo Form Mobile View', NULL, 'new', '2025-10-20 21:43:00', NULL, NULL),
(323, 'Con Karl', 'j@yopmai.com', '\'+1 900-433-6328', 'Hatami', 'ogf', 'Appraiser', 'Not sure / exploring options', NULL, '', 'CSV Import', 'Request a Demo Form Mobile View', NULL, 'new', '2025-10-14 14:55:00', NULL, NULL),
(324, 'John Barry', 'jkb8@ntrs.com', '', 'Northern Trust', 'Gift card', '', '', NULL, '', 'CSV Import', 'Request a Demo Form Mobile View', NULL, 'new', '2025-09-26 15:59:00', NULL, NULL);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=113;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=325;

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
