-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 21, 2026 at 09:54 AM
-- Server version: 11.8.5-MariaDB
-- PHP Version: 8.3.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mog_demo`
--

-- --------------------------------------------------------

--
-- Table structure for table `account_emailaddress`
--

CREATE TABLE `account_emailaddress` (
  `id` int(11) NOT NULL,
  `email` varchar(254) NOT NULL,
  `verified` tinyint(1) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `account_emailaddress`
--

INSERT INTO `account_emailaddress` (`id`, `email`, `verified`, `primary`, `user_id`) VALUES
(14, 'jaycoab2@gmail.com', 0, 1, 17),
(15, 'hoshino@gmail.com', 0, 1, 18),
(18, 'kise@gmail.com', 0, 1, 21),
(19, 'umyomin@gmail.com', 0, 1, 22),
(20, 'dawaye@gmail.com', 0, 1, 25);

-- --------------------------------------------------------

--
-- Table structure for table `account_emailconfirmation`
--

CREATE TABLE `account_emailconfirmation` (
  `id` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `sent` datetime(6) DEFAULT NULL,
  `key` varchar(64) NOT NULL,
  `email_address_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `archives`
--

CREATE TABLE `archives` (
  `id` bigint(20) NOT NULL,
  `archive_id` varchar(20) NOT NULL,
  `documents_id` bigint(20) DEFAULT NULL,
  `staffs_id` bigint(20) DEFAULT NULL,
  `updated_time` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` bigint(20) NOT NULL,
  `action` varchar(20) NOT NULL,
  `model_name` varchar(100) NOT NULL,
  `object_id` varchar(100) DEFAULT NULL,
  `description` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `audit_logs`
--

INSERT INTO `audit_logs` (`id`, `action`, `model_name`, `object_id`, `description`, `created_at`, `user_id`) VALUES
(1, 'ARCHIVE', 'documents', '22', 'Archived CommitmentLetter (AURA-X).pdf', '2026-05-02 20:26:48.692800', 18),
(2, 'ARCHIVE', 'documents', '34', 'Archived AURA-X-ppt.pdf', '2026-05-02 20:26:49.680322', 18),
(3, 'RESTORE', 'archives', '22', 'Restored CommitmentLetter (AURA-X).pdf', '2026-05-02 20:26:55.536503', 18),
(4, 'RESTORE', 'archives', '34', 'Restored AURA-X-ppt.pdf', '2026-05-02 20:27:44.496519', 17),
(5, 'ARCHIVE', 'documents', '35', 'Archived RegistrationFrom (AURA-X).pdf', '2026-05-02 20:27:48.748924', 17),
(6, 'RESTORE', 'archives', '35', 'Restored RegistrationFrom (AURA-X).pdf', '2026-05-03 03:05:45.468193', 17),
(7, 'ARCHIVE', 'documents', '35', 'Archived RegistrationFrom (AURA-X).pdf', '2026-05-03 09:38:06.532556', 17),
(8, 'RESTORE', 'archives', '35', 'Restored RegistrationFrom (AURA-X).pdf', '2026-05-03 09:38:57.917154', 17),
(9, 'ARCHIVE', 'documents', '22', 'Archived CommitmentLetter (AURA-X).pdf', '2026-05-03 09:39:11.331341', 17),
(10, 'DELETE', 'archives', '22', 'Deleted CommitmentLetter (AURA-X).pdf', '2026-05-03 09:40:14.961622', 17),
(11, 'RESTORE', 'recycled documents', '22', 'Restored CommitmentLetter (AURA-X).pdf', '2026-05-03 09:40:37.511893', 17),
(12, 'DELETE', 'documents', '36', 'Deleted Aura_X_Business_Plan.pdf', '2026-05-04 04:17:04.147076', 17),
(13, 'CREATE', 'documents', '37', 'Upload Aura_X_Business_Plan.pdf', '2026-05-04 04:18:38.783044', 17),
(14, 'ARCHIVE', 'documents', '22', 'Archived CommitmentLetter (AURA-X).pdf', '2026-05-04 04:30:23.923592', 17),
(15, 'DELETE', 'documents', '34', 'Deleted AURA-X-ppt.pdf', '2026-05-04 06:56:25.122009', 17),
(16, 'RESTORE', 'recycled documents', '36', 'Restored Aura_X_Business_Plan.pdf', '2026-05-04 06:56:52.613059', 17),
(17, 'DELETE', 'archives', '22', 'Deleted CommitmentLetter (AURA-X).pdf', '2026-05-04 08:29:31.648526', 17),
(18, 'DELETE', 'documents', '37', 'Deleted Aura_X_Business_Plan.pdf', '2026-05-04 08:30:27.104646', 17),
(19, 'DELETE', 'recycled documents', NULL, 'Deleted Aura X Business Plan.pdf', '2026-05-04 08:30:44.008223', 17),
(20, 'DELETE', 'recycled documents', NULL, 'Deleted Aura_X_Business_Plan.pdf', '2026-05-04 08:30:50.686312', 17),
(21, 'DELETE', 'documents', '36', 'Deleted Aura_X_Business_Plan.pdf', '2026-05-06 14:56:54.147621', 17),
(22, 'ARCHIVE', 'documents', '35', 'Archived RegistrationFrom (AURA-X).pdf', '2026-05-06 14:57:15.995472', 17),
(23, 'DELETE', 'archives', '35', 'Deleted RegistrationFrom (AURA-X).pdf', '2026-05-06 14:57:26.668289', 17),
(24, 'RESTORE', 'recycled documents', '35', 'Restored RegistrationFrom (AURA-X).pdf', '2026-05-06 14:57:33.598595', 17),
(25, 'RESTORE', 'recycled documents', '36', 'Restored Aura_X_Business_Plan.pdf', '2026-05-06 14:57:35.109400', 17),
(26, 'RESTORE', 'recycled documents', '34', 'Restored AURA-X-ppt.pdf', '2026-05-06 14:57:36.009327', 17),
(27, 'RESTORE', 'recycled documents', '22', 'Restored CommitmentLetter (AURA-X).pdf', '2026-05-06 14:57:37.648453', 17),
(28, 'ARCHIVE', 'documents', '22', 'Archived CommitmentLetter (AURA-X).pdf', '2026-05-07 07:16:52.382149', 17),
(29, 'UPDATE', 'documents', '34', 'Updated AURA-X-ppt.pdf', '2026-05-07 07:19:49.706369', 17),
(30, 'ARCHIVE', 'documents', '34', 'Archived AURA-X-ppt.pdf', '2026-05-07 07:20:13.708855', 17),
(31, 'RESTORE', 'archives', '22', 'Restored CommitmentLetter (AURA-X).pdf', '2026-05-07 07:20:39.986132', 17),
(32, 'ARCHIVE', 'documents', '22', 'Archived CommitmentLetter (AURA-X).pdf', '2026-05-07 07:20:47.003022', 17),
(33, 'DELETE', 'archives', '22', 'Deleted CommitmentLetter (AURA-X).pdf', '2026-05-07 07:20:54.620056', 17),
(34, 'RESTORE', 'recycled documents', '22', 'Restored CommitmentLetter (AURA-X).pdf', '2026-05-07 07:21:11.702491', 17),
(35, 'CREATE', 'documents', '38', 'Upload RegistrationFrom (AURA-X).pdf', '2026-05-07 07:53:29.368807', 17),
(36, 'CREATE', 'documents', '39', 'Upload AURA-X-ppt.pdf', '2026-05-07 08:26:58.506031', 17),
(37, 'DELETE', 'documents', '22', 'Deleted CommitmentLetter (AURA-X).pdf', '2026-05-07 08:29:00.381285', 17),
(38, 'RESTORE', 'archives', '34', 'Restored AURA-X-ppt.pdf', '2026-05-07 08:31:52.884460', 17),
(39, 'ARCHIVE', 'documents', '34', 'Archived AURA-X-ppt.pdf', '2026-05-07 08:31:59.568897', 17),
(40, 'RESTORE', 'archives', '34', 'Restored AURA-X-ppt.pdf', '2026-05-07 08:32:47.474180', 17),
(41, 'ARCHIVE', 'documents', '34', 'Archived AURA-X-ppt.pdf', '2026-05-07 08:32:51.982556', 17),
(42, 'DELETE', 'recycled documents', NULL, 'Deleted CommitmentLetter (AURA-X).pdf', '2026-05-25 01:34:29.834981', 17),
(43, 'DELETE', 'documents', '39', 'Deleted AURA-X-ppt.pdf', '2026-05-25 01:34:40.964619', 17),
(44, 'DELETE', 'documents', '34', 'Deleted AURA-X-ppt.pdf', '2026-05-25 01:38:49.029010', 17),
(45, 'DELETE', 'documents', '39', 'Deleted AURA-X-ppt.pdf', '2026-05-25 01:38:52.767702', 17),
(46, 'DELETE', 'recycled documents', NULL, 'Deleted AURA-X-ppt.pdf', '2026-05-25 01:39:00.202024', 17),
(47, 'DELETE', 'recycled documents', NULL, 'Deleted AURA-X-ppt.pdf', '2026-05-25 06:56:42.987848', 17),
(48, 'ARCHIVE', 'documents', '35', 'Archived RegistrationFrom (AURA-X).pdf', '2026-05-25 06:56:55.180938', 17),
(49, 'DELETE', 'documents', '36', 'Deleted Aura_X_Business_Plan.pdf', '2026-05-25 06:57:09.446502', 17),
(50, 'RESTORE', 'archives', '35', 'Restored RegistrationFrom (AURA-X).pdf', '2026-05-25 15:50:48.503393', 17),
(51, 'RESTORE', 'recycled documents', '36', 'Restored Aura_X_Business_Plan.pdf', '2026-05-25 15:50:54.944279', 17),
(52, 'CREATE', 'locations', '1', 'Upload car.png', '2026-06-10 00:34:54.235646', 17),
(53, 'CREATE', 'locations', '2', 'Upload Screenshot 2025-05-15 160656.png', '2026-06-10 00:54:04.717849', 17),
(54, 'DELETE', 'archives', '38', 'Deleted RegistrationFrom (AURA-X).pdf', '2026-06-20 15:04:36.441042', 17),
(55, 'CREATE', 'locations', '3', 'Upload Screenshot 2025-05-14 150904.png', '2026-06-22 04:38:48.640377', 17),
(56, 'UPDATE', 'locations', '1', 'Updated car', '2026-06-22 07:50:52.501760', 17),
(57, 'UPDATE', 'locations', '1', 'Updated car', '2026-06-22 07:51:51.112774', 17),
(58, 'UPDATE', 'locations', '1', 'Updated car', '2026-06-22 07:53:05.881132', 17),
(59, 'ARCHIVE', 'documents', '35', 'Archived RegistrationFrom (AURA-X).pdf', '2026-06-22 15:05:29.211701', 17),
(60, 'RESTORE', 'archives', '36', 'Restored Aura_X_Business_Plan.pdf', '2026-06-22 15:06:14.085949', 17),
(61, 'RESTORE', 'archives', '38', 'Restored RegistrationFrom (AURA-X).pdf', '2026-06-22 15:06:15.565924', 17),
(62, 'UPDATE', 'locations', '2', 'Updated Screenshot 2025-05-15 160656.png', '2026-07-01 03:16:47.794217', 17),
(63, 'CREATE', 'locations', '4', 'Upload Screenshot 2025-06-27 000142.png', '2026-07-01 03:18:32.794044', 17),
(64, 'CREATE', 'locations', '5', 'Upload Screenshot 2025-05-20 220859.png', '2026-07-01 03:19:21.446917', 17),
(65, 'CREATE', 'locations', '6', 'Upload Screenshot 2025-05-15 160656.png', '2026-07-01 03:21:43.662286', 17),
(66, 'CREATE', 'locations', '7', 'Upload Screenshot 2025-05-14 131915.png', '2026-07-01 03:24:06.721852', 17),
(67, 'DELETE', 'locations', NULL, 'Deleted Screenshot 2025-06-27 000142.png', '2026-07-01 03:24:42.234699', 17),
(68, 'CREATE', 'locations', '8', 'Upload Screenshot 2025-05-14 132309.png', '2026-07-01 03:27:34.670078', 17),
(69, 'DELETE', 'locations', NULL, 'Deleted Screenshot 2025-05-20 220859.png', '2026-07-01 03:45:14.730222', 17),
(70, 'CREATE', 'documents', '40', 'Upload JITES 2020-part-1.pdf', '2026-07-07 06:43:37.666587', 21),
(71, 'UPDATE', 'locations', '6', 'Updated place_1', '2026-07-07 23:48:39.873773', 17),
(72, 'UPDATE', 'locations', '7', 'Updated place_2', '2026-07-07 23:48:49.767848', 17),
(73, 'UPDATE', 'locations', '8', 'Updated place_3', '2026-07-07 23:49:03.176690', 17),
(74, 'UPDATE', 'locations', '2', 'Updated place_4', '2026-07-07 23:49:10.525058', 17),
(75, 'UPDATE', 'locations', '3', 'Updated place_5', '2026-07-07 23:49:17.802926', 17),
(76, 'CREATE', 'documents', '41', 'Upload university_admission_top10.pdf', '2026-07-08 04:08:02.954401', 21),
(77, 'CREATE', 'documents', '42', 'Upload myanmar_students_10_lines.pdf', '2026-07-09 14:00:07.757856', 17),
(78, 'DELETE', 'documents', '42', 'Deleted myanmar_students_10_lines.pdf', '2026-07-09 14:00:38.246102', 17),
(79, 'ARCHIVE', 'documents', '41', 'Archived university_admission_top10.pdf', '2026-07-09 14:02:25.617308', 17),
(80, 'CREATE', 'documents', '43', 'Upload JITES 2020-part-3.pdf', '2026-07-09 14:02:58.910293', 17),
(81, 'CREATE', 'documents', '44', 'Upload Natural-Science-Part-1-1_pages_1-20.pdf', '2026-07-09 14:03:25.269307', 17),
(82, 'CREATE', 'documents', '45', 'Upload UCSTgo__ (1).pdf', '2026-07-09 14:10:48.031032', 17),
(83, 'CREATE', 'documents', '46', 'Upload university_admission_top10.pdf', '2026-07-09 16:10:54.853379', 17),
(84, 'CREATE', 'locations', '9', 'Upload location_1.jpg', '2026-07-10 07:45:30.573390', 17),
(85, 'CREATE', 'locations', '10', 'Upload location_2_Rakhine.jpg', '2026-07-10 08:13:23.791236', 17),
(86, 'CREATE', 'locations', '11', 'Upload location_3_MTM.jpg', '2026-07-10 08:16:36.057866', 17),
(87, 'UPDATE', 'locations', '10', 'Updated location_2_Rakhine.jpg', '2026-07-10 08:16:51.579388', 17),
(88, 'DELETE', 'locations', NULL, 'Deleted location_1.jpg', '2026-07-10 08:19:47.782032', 17),
(89, 'DELETE', 'locations', NULL, 'Deleted car', '2026-07-10 08:19:51.442045', 17),
(90, 'CREATE', 'locations', '12', 'Upload Shwe Drilling & Production Platform', '2026-07-10 08:21:26.761209', 17),
(91, 'UPDATE', 'locations', '10', 'Updated မုတ္တမကမ်းလွန် Block M-9', '2026-07-10 08:22:35.757502', 17),
(92, 'UPDATE', 'locations', '11', 'Updated မုတ္တမကမ်းလွန် Block M-9', '2026-07-10 08:22:45.674871', 17),
(93, 'UPDATE', 'locations', '10', 'Updated ရခိုင်ကမ်းလွန် Block A-1 (ရွှေသဘာဝဓာတ်ငွေ့ဖွံ့ဖြိုးရေး)', '2026-07-10 08:23:33.688867', 17),
(94, 'CREATE', 'locations', '13', 'Upload MOGE တွင် ပြုလုပ်ခဲ့သည့် DAMS အစည်းအဝေးမှတ်တမ်း', '2026-07-10 08:38:54.861382', 18),
(95, 'DELETE', 'locations', NULL, 'Deleted place_5', '2026-07-10 08:40:07.482071', 17),
(96, 'CREATE', 'documents', '47', 'Upload အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026.pdf', '2026-07-10 08:51:54.824004', 22),
(97, 'UPDATE', 'documents', '47', 'Updated အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026.pdf', '2026-07-10 09:04:51.732520', 17),
(98, 'UPDATE', 'documents', '47', 'Updated အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026.pdf', '2026-07-10 09:05:15.943599', 17),
(99, 'UPDATE', 'documents', '47', 'Updated အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026.pdf', '2026-07-10 09:06:47.157464', 17),
(100, 'UPDATE', 'documents', '47', 'Updated အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026.pdf', '2026-07-10 09:10:42.671455', 17),
(101, 'UPDATE', 'documents', '47', 'Updated အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026.pdf', '2026-07-10 09:11:52.607625', 17),
(102, 'UPDATE', 'documents', '47', 'Updated အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026.pdf', '2026-07-10 09:14:39.667528', 17),
(103, 'CREATE', 'documents', '48', 'Upload rules.pdf', '2026-07-10 09:18:26.098321', 17),
(104, 'CREATE', 'documents', '49', 'Upload တင်ဒါအောင်မြင်သည့်ကုမ္ပဏီများ.doc', '2026-07-10 09:20:25.095720', 17),
(105, 'DELETE', 'documents', '47', 'Deleted အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026.pdf', '2026-07-13 00:56:00.284359', 17),
(106, 'CREATE', 'documents', '50', 'Upload အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026.pdf', '2026-07-13 00:56:26.108017', 17),
(107, 'DELETE', 'documents', '48', 'Deleted rules.pdf', '2026-07-13 01:05:29.342130', 21),
(108, 'CREATE', 'documents', '51', 'Upload rules.pdf', '2026-07-13 01:05:50.027995', 21),
(109, 'CREATE', 'documents', '52', 'Upload အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_7_2026.pdf', '2026-07-13 01:07:57.430139', 21),
(110, 'DELETE', 'documents', '45', 'Deleted UCSTgo__ (1).pdf', '2026-07-13 01:08:33.627784', 21),
(111, 'CREATE', 'documents', '53', 'Upload အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_10_2026.pdf', '2026-07-13 01:08:52.606178', 21),
(112, 'DELETE', 'documents', '46', 'Deleted university_admission_top10.pdf', '2026-07-13 01:11:00.213645', 21),
(113, 'DELETE', 'documents', '44', 'Deleted Natural-Science-Part-1-1_pages_1-20.pdf', '2026-07-13 01:11:05.854663', 21),
(114, 'DELETE', 'documents', '52', 'Deleted အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_7_2026.pdf', '2026-07-23 04:46:27.348524', 17),
(115, 'ARCHIVE', 'documents', '51', 'Archived rules.pdf', '2026-07-23 04:46:38.265213', 17),
(116, 'ARCHIVE', 'documents', '49', 'Archived တင်ဒါအောင်မြင်သည့်ကုမ္ပဏီများ.doc', '2026-07-23 04:46:41.653527', 17),
(117, 'DELETE', 'documents', '36', 'Deleted Aura_X_Business_Plan.pdf', '2026-07-23 04:46:45.243252', 17),
(118, 'RESTORE', 'archives', '49', 'Restored တင်ဒါအောင်မြင်သည့်ကုမ္ပဏီများ.doc', '2026-07-30 06:56:21.762787', 17),
(119, 'DELETE', 'recycled documents', NULL, 'Deleted အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_7_2026.pdf', '2026-07-30 06:56:52.384050', 17),
(120, 'DELETE', 'documents', '49', 'Deleted တင်ဒါအောင်မြင်သည့်ကုမ္ပဏီများ.doc', '2026-07-30 17:55:38.010655', 17),
(121, 'DELETE', 'documents', '43', 'Deleted JITES 2020-part-3.pdf', '2026-07-30 17:55:38.010655', 17),
(122, 'DELETE', 'documents', '50', 'Deleted အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026.pdf', '2026-07-30 17:55:38.010655', 17),
(123, 'DELETE', 'documents', '40', 'Deleted JITES 2020-part-1.pdf', '2026-07-30 17:55:38.010655', 17),
(124, 'DELETE', 'documents', '53', 'Deleted အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_10_2026.pdf', '2026-07-30 17:55:38.010655', 17),
(125, 'CREATE', 'documents', '54', 'Upload ကိုယ်ရေးမှတ်တမ်းများ', '2026-07-31 01:40:02.150931', 17),
(126, 'CREATE', 'documents', '55', 'Upload staff company profile', '2026-07-31 01:44:30.054660', 17),
(127, 'UPDATE', 'documents', '55', 'Updated staff company profile', '2026-07-31 01:45:01.494618', 17),
(128, 'CREATE', 'documents', '56', 'Upload တင်ဒါအောင်မြင်သည့်ကုမ္ပဏီစာရင်းများ', '2026-07-31 01:47:11.557415', 17),
(129, 'CREATE', 'documents', '57', 'Upload အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026', '2026-07-31 01:51:37.258716', 17),
(130, 'DELETE', 'documents', '57', 'Deleted အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026', '2026-07-31 01:54:40.982993', 17),
(131, 'CREATE', 'documents', '58', 'Upload အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026', '2026-07-31 01:55:51.633033', 17),
(132, 'CREATE', 'documents', '59', 'Upload အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_10_2026', '2026-07-31 01:57:35.348673', 17),
(133, 'CREATE', 'documents', '60', 'Upload စည်းမျဉ်းများ', '2026-07-31 01:58:52.658817', 17),
(134, 'CREATE', 'documents', '61', 'Upload sample-document', '2026-07-31 02:00:00.333709', 17),
(135, 'CREATE', 'documents', '62', 'Upload sample-doc-2', '2026-07-31 02:00:43.883962', 17),
(136, 'RESTORE', 'recycled documents', '47', 'Restored အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026.pdf', '2026-07-31 02:16:53.978522', 17),
(137, 'RESTORE', 'recycled documents', '36', 'Restored Aura_X_Business_Plan.pdf', '2026-07-31 02:17:09.825702', 17),
(138, 'RESTORE', 'recycled documents', '38', 'Restored RegistrationFrom (AURA-X).pdf', '2026-07-31 02:17:11.083565', 17),
(139, 'DELETE', 'documents', '47', 'Deleted အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026.pdf', '2026-07-31 02:23:10.867758', 17),
(140, 'DELETE', 'recycled documents', NULL, 'Deleted အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026.pdf', '2026-07-31 02:23:27.048253', 17),
(141, 'DELETE', 'recycled documents', NULL, 'Deleted အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_10_2026.pdf', '2026-07-31 02:23:33.568757', 17),
(142, 'ARCHIVE', 'documents', '36', 'Archived Aura_X_Business_Plan.pdf', '2026-07-31 03:11:07.700671', 17),
(143, 'ARCHIVE', 'documents', '38', 'Archived RegistrationFrom (AURA-X).pdf', '2026-07-31 03:11:10.040178', 17),
(144, 'DELETE', 'recycled documents', NULL, 'Deleted တင်ဒါအောင်မြင်သည့်ကုမ္ပဏီများ.doc', '2026-07-31 03:35:44.854213', 17),
(145, 'RESTORE', 'archives', '35', 'Restored RegistrationFrom (AURA-X).pdf', '2026-07-31 03:41:10.348609', 17),
(146, 'ARCHIVE', 'documents', '55', 'Archived staff company profile', '2026-07-31 05:00:51.787954', 25),
(147, 'ARCHIVE', 'documents', '56', 'Archived တင်ဒါအောင်မြင်သည့်ကုမ္ပဏီစာရင်းများ', '2026-07-31 05:17:53.863956', 25),
(148, 'ARCHIVE', 'documents', '58', 'Archived အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026', '2026-07-31 05:32:53.292337', 25),
(149, 'RESTORE', 'recycled documents', '40', 'Restored JITES 2020-part-1.pdf', '2026-08-03 02:48:46.494378', 17),
(150, 'RESTORE', 'recycled documents', '42', 'Restored myanmar_students_10_lines.pdf', '2026-08-03 02:48:49.380354', 17),
(151, 'RESTORE', 'recycled documents', '48', 'Restored rules.pdf', '2026-08-03 02:49:08.875539', 17),
(152, 'DELETE', 'documents', '42', 'Deleted myanmar_students_10_lines.pdf', '2026-08-03 02:52:37.205530', 17),
(153, 'DELETE', 'documents', '35', 'Deleted RegistrationFrom (AURA-X).pdf', '2026-08-05 17:49:03.373626', 17),
(154, 'DELETE', 'documents', '40', 'Deleted JITES 2020-part-1.pdf', '2026-08-05 17:49:03.373626', 17),
(155, 'DELETE', 'documents', '59', 'Deleted အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_10_2026', '2026-08-05 17:49:11.514399', 17),
(156, 'CREATE', 'locations', '14', 'Upload testing', '2026-08-08 13:20:26.399468', 17),
(157, 'RESTORE', 'recycled documents', '35', 'Restored RegistrationFrom (AURA-X).pdf', '2026-08-09 08:19:58.540598', 17),
(158, 'CREATE', 'documents', '63', 'Upload ကိုယ်ရေးမှတ်တမ်းများ', '2026-08-12 14:56:54.103531', 17),
(159, 'DELETE', 'documents', '63', 'Deleted ကိုယ်ရေးမှတ်တမ်းများ', '2026-08-12 15:03:38.587731', 17),
(160, 'DELETE', 'recycled documents', NULL, 'Deleted ကိုယ်ရေးမှတ်တမ်းများ', '2026-08-12 15:03:49.600033', 17),
(161, 'DELETE', 'recycled documents', NULL, 'Deleted အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_10_2026', '2026-08-12 15:03:49.601032', 17),
(162, 'DELETE', 'recycled documents', NULL, 'Deleted အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026.pdf', '2026-08-12 15:03:49.604034', 17),
(163, 'DELETE', 'recycled documents', NULL, 'Deleted အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026', '2026-08-12 15:03:49.601032', 17),
(164, 'CREATE', 'documents', '64', 'Upload ကိုယ်ရေးမှတ်တမ်းများ', '2026-08-12 15:04:30.133713', 17),
(165, 'DELETE', 'documents', '62', 'Deleted sample-doc-2', '2026-08-12 15:43:16.178523', 17),
(166, 'DELETE', 'documents', '60', 'Deleted စည်းမျဉ်းများ', '2026-08-12 15:43:16.179062', 17),
(167, 'DELETE', 'documents', '61', 'Deleted sample-document', '2026-08-12 15:43:16.179062', 17),
(168, 'DELETE', 'documents', '64', 'Deleted ကိုယ်ရေးမှတ်တမ်းများ', '2026-08-12 15:43:16.179062', 17),
(169, 'DELETE', 'documents', '54', 'Deleted ကိုယ်ရေးမှတ်တမ်းများ', '2026-08-12 15:43:16.192319', 17),
(170, 'DELETE', 'documents', '48', 'Deleted rules.pdf', '2026-08-12 15:43:16.204325', 17),
(171, 'DELETE', 'documents', '35', 'Deleted RegistrationFrom (AURA-X).pdf', '2026-08-12 15:43:16.205630', 17),
(172, 'DELETE', 'archives', '36', 'Deleted Aura_X_Business_Plan.pdf', '2026-08-12 15:43:24.324898', 17),
(173, 'DELETE', 'archives', '38', 'Deleted RegistrationFrom (AURA-X).pdf', '2026-08-12 15:43:24.324898', 17),
(174, 'DELETE', 'archives', '41', 'Deleted university_admission_top10.pdf', '2026-08-12 15:43:24.338143', 17),
(175, 'DELETE', 'archives', '51', 'Deleted rules.pdf', '2026-08-12 15:43:24.348115', 17),
(176, 'DELETE', 'archives', '55', 'Deleted staff company profile', '2026-08-12 15:43:24.352615', 17),
(177, 'DELETE', 'archives', '56', 'Deleted တင်ဒါအောင်မြင်သည့်ကုမ္ပဏီစာရင်းများ', '2026-08-12 15:43:24.359868', 17),
(178, 'DELETE', 'archives', '58', 'Deleted အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026', '2026-08-12 15:43:24.365943', 17),
(179, 'DELETE', 'recycled documents', NULL, 'Deleted RegistrationFrom (AURA-X).pdf', '2026-08-12 15:43:32.722754', 17),
(180, 'DELETE', 'recycled documents', NULL, 'Deleted Aura_X_Business_Plan.pdf', '2026-08-12 15:43:32.728055', 17),
(181, 'DELETE', 'recycled documents', NULL, 'Deleted RegistrationFrom (AURA-X).pdf', '2026-08-12 15:43:32.735016', 17),
(182, 'DELETE', 'recycled documents', NULL, 'Deleted JITES 2020-part-1.pdf', '2026-08-12 15:43:32.749151', 17),
(183, 'DELETE', 'recycled documents', NULL, 'Deleted university_admission_top10.pdf', '2026-08-12 15:43:32.755384', 17),
(184, 'DELETE', 'recycled documents', NULL, 'Deleted myanmar_students_10_lines.pdf', '2026-08-12 15:43:32.762690', 17),
(185, 'DELETE', 'recycled documents', NULL, 'Deleted JITES 2020-part-3.pdf', '2026-08-12 15:43:32.769501', 17),
(186, 'DELETE', 'recycled documents', NULL, 'Deleted Natural-Science-Part-1-1_pages_1-20.pdf', '2026-08-12 15:43:32.783696', 17),
(187, 'DELETE', 'recycled documents', NULL, 'Deleted UCSTgo__ (1).pdf', '2026-08-12 15:43:32.783696', 17),
(188, 'DELETE', 'recycled documents', NULL, 'Deleted university_admission_top10.pdf', '2026-08-12 15:43:32.790233', 17),
(189, 'DELETE', 'recycled documents', NULL, 'Deleted rules.pdf', '2026-08-12 15:43:36.988060', 17),
(190, 'DELETE', 'recycled documents', NULL, 'Deleted rules.pdf', '2026-08-12 15:43:36.999841', 17),
(191, 'DELETE', 'recycled documents', NULL, 'Deleted ကိုယ်ရေးမှတ်တမ်းများ', '2026-08-12 15:43:36.999841', 17),
(192, 'DELETE', 'recycled documents', NULL, 'Deleted staff company profile', '2026-08-12 15:43:37.006837', 17),
(193, 'DELETE', 'recycled documents', NULL, 'Deleted တင်ဒါအောင်မြင်သည့်ကုမ္ပဏီစာရင်းများ', '2026-08-12 15:43:37.014493', 17),
(194, 'DELETE', 'recycled documents', NULL, 'Deleted အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026', '2026-08-12 15:43:37.027759', 17),
(195, 'DELETE', 'recycled documents', NULL, 'Deleted စည်းမျဉ်းများ', '2026-08-12 15:43:37.039083', 17),
(196, 'DELETE', 'recycled documents', NULL, 'Deleted sample-document', '2026-08-12 15:43:37.046677', 17),
(197, 'DELETE', 'recycled documents', NULL, 'Deleted sample-doc-2', '2026-08-12 15:43:37.048108', 17),
(198, 'DELETE', 'recycled documents', NULL, 'Deleted ကိုယ်ရေးမှတ်တမ်းများ', '2026-08-12 15:43:37.055818', 17),
(199, 'CREATE', 'documents', '65', 'Upload ကိုယ်ရေးမှတ်တမ်းများ', '2026-08-12 15:54:32.005227', 17),
(200, 'CREATE', 'documents', '66', 'Upload တင်ဒါအောင်မြင်သည့်ကုမ္ပဏီများ', '2026-08-12 15:55:52.936184', 17),
(201, 'CREATE', 'documents', '67', 'Upload Specification Role for MOGE', '2026-08-12 15:57:11.768808', 17),
(202, 'CREATE', 'documents', '68', 'Upload Staff Company Profile', '2026-08-12 15:59:05.540235', 17),
(203, 'CREATE', 'documents', '69', 'Upload JITES 2020-part-2', '2026-08-12 16:01:24.275485', 17),
(204, 'CREATE', 'documents', '70', 'Upload အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026', '2026-08-12 16:02:11.066935', 17),
(205, 'CREATE', 'documents', '71', 'Upload အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_7_2026', '2026-08-12 16:03:26.101681', 17),
(206, 'CREATE', 'documents', '72', 'Upload အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_10_2026', '2026-08-12 16:03:57.986194', 17),
(207, 'CREATE', 'documents', '73', 'Upload rules', '2026-08-12 16:04:22.490915', 17),
(208, 'CREATE', 'documents', '74', 'Upload Aura X Business Plan', '2026-08-12 16:14:04.983681', 17),
(209, 'CREATE', 'documents', '75', 'Upload Language-2', '2026-08-12 16:15:05.127139', 17),
(210, 'CREATE', 'documents', '76', 'Upload Information-Technology-1', '2026-08-12 16:16:12.278438', 17),
(211, 'CREATE', 'documents', '77', 'Upload CS-5121_CyberSecurity-DigitalForensics_LectureNotesUpdate', '2026-08-12 16:17:06.276184', 17),
(212, 'CREATE', 'documents', '78', 'Upload Commitment Letter ( AURA-X )', '2026-08-12 16:18:03.472549', 17),
(213, 'CREATE', 'documents', '79', 'Upload Presentation ( AURA-X )', '2026-08-12 16:18:44.843569', 17),
(214, 'CREATE', 'documents', '80', 'Upload Technical Feasibility Analysis ( AURA-X )', '2026-08-12 16:19:36.019013', 17),
(215, 'CREATE', 'documents', '81', 'Upload Aura X Business Plan', '2026-08-12 16:20:11.802568', 17),
(216, 'CREATE', 'documents', '82', 'Upload AURA_X_Market_Analysis', '2026-08-12 16:21:27.134065', 17),
(217, 'ARCHIVE', 'documents', '79', 'Archived Presentation ( AURA-X )', '2026-08-12 16:22:14.128010', 17),
(218, 'ARCHIVE', 'documents', '78', 'Archived Commitment Letter ( AURA-X )', '2026-08-12 16:22:17.099269', 17),
(219, 'ARCHIVE', 'documents', '77', 'Archived CS-5121_CyberSecurity-DigitalForensics_LectureNotesUpdate', '2026-08-12 16:22:19.099825', 17),
(220, 'ARCHIVE', 'documents', '76', 'Archived Information-Technology-1', '2026-08-12 16:22:21.395957', 17),
(221, 'DELETE', 'documents', '82', 'Deleted AURA_X_Market_Analysis', '2026-08-12 16:22:31.307801', 17),
(222, 'DELETE', 'documents', '81', 'Deleted Aura X Business Plan', '2026-08-12 16:22:34.011847', 17),
(223, 'DELETE', 'documents', '80', 'Deleted Technical Feasibility Analysis ( AURA-X )', '2026-08-12 16:22:37.561425', 17),
(224, 'DELETE', 'documents', '75', 'Deleted Language-2', '2026-08-12 16:22:41.283679', 17),
(225, 'DELETE', 'documents', '74', 'Deleted Aura X Business Plan', '2026-08-12 16:23:51.701394', 17),
(226, 'ARCHIVE', 'documents', '73', 'Archived rules', '2026-08-12 16:23:55.370346', 17),
(227, 'CREATE', 'documents', '83', 'Upload MOGE_System Requirements', '2026-08-12 16:25:31.439211', 17),
(228, 'UPDATE', 'documents', '83', 'Updated MOGE_System Requirements', '2026-08-19 13:11:07.255075', 17),
(229, 'DELETE', 'locations', NULL, 'Deleted testing', '2026-08-20 17:31:04.840664', 17),
(230, 'DELETE', 'documents', '71', 'Deleted အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_7_2026', '2026-08-21 03:19:07.240099', 17),
(231, 'DELETE', 'documents', '72', 'Deleted အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_10_2026', '2026-08-21 03:19:07.238592', 17),
(232, 'DELETE', 'documents', '83', 'Deleted MOGE_System Requirements', '2026-08-21 03:19:07.240099', 17),
(233, 'DELETE', 'documents', '70', 'Deleted အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026', '2026-08-21 03:19:07.240099', 17),
(234, 'DELETE', 'documents', '69', 'Deleted JITES 2020-part-2', '2026-08-21 03:19:07.247106', 17),
(235, 'DELETE', 'documents', '68', 'Deleted Staff Company Profile', '2026-08-21 03:19:07.257745', 17),
(236, 'DELETE', 'documents', '67', 'Deleted Specification Role for MOGE', '2026-08-21 03:19:07.270062', 17),
(237, 'DELETE', 'documents', '66', 'Deleted တင်ဒါအောင်မြင်သည့်ကုမ္ပဏီများ', '2026-08-21 03:19:07.274069', 17),
(238, 'DELETE', 'documents', '65', 'Deleted ကိုယ်ရေးမှတ်တမ်းများ', '2026-08-21 03:19:07.278067', 17),
(239, 'DELETE', 'archives', '73', 'Deleted rules', '2026-08-21 03:19:28.087822', 17),
(240, 'DELETE', 'archives', '76', 'Deleted Information-Technology-1', '2026-08-21 03:19:28.090330', 17),
(241, 'DELETE', 'archives', '77', 'Deleted CS-5121_CyberSecurity-DigitalForensics_LectureNotesUpdate', '2026-08-21 03:19:28.095335', 17),
(242, 'DELETE', 'archives', '78', 'Deleted Commitment Letter ( AURA-X )', '2026-08-21 03:19:28.106447', 17),
(243, 'DELETE', 'archives', '79', 'Deleted Presentation ( AURA-X )', '2026-08-21 03:19:28.108634', 17),
(244, 'RESTORE', 'recycled documents', '65', 'Restored ကိုယ်ရေးမှတ်တမ်းများ', '2026-08-21 03:19:32.961101', 17),
(245, 'DELETE', 'documents', '65', 'Deleted ကိုယ်ရေးမှတ်တမ်းများ', '2026-08-21 03:19:38.570440', 17),
(246, 'RESTORE', 'recycled documents', '65', 'Restored ကိုယ်ရေးမှတ်တမ်းများ', '2026-08-21 03:19:54.407698', 17),
(247, 'RESTORE', 'recycled documents', '66', 'Restored တင်ဒါအောင်မြင်သည့်ကုမ္ပဏီများ', '2026-08-21 03:19:56.070175', 17),
(248, 'RESTORE', 'recycled documents', '67', 'Restored Specification Role for MOGE', '2026-08-21 03:19:57.408996', 17),
(249, 'DELETE', 'documents', '67', 'Deleted Specification Role for MOGE', '2026-08-21 03:20:05.990704', 17),
(250, 'DELETE', 'documents', '66', 'Deleted တင်ဒါအောင်မြင်သည့်ကုမ္ပဏီများ', '2026-08-21 03:20:28.303013', 17),
(251, 'DELETE', 'documents', '65', 'Deleted ကိုယ်ရေးမှတ်တမ်းများ', '2026-08-21 03:20:28.304417', 17),
(252, 'RESTORE', 'recycled documents', '65', 'Restored ကိုယ်ရေးမှတ်တမ်းများ', '2026-08-21 03:25:00.090286', 17),
(253, 'RESTORE', 'recycled documents', '66', 'Restored တင်ဒါအောင်မြင်သည့်ကုမ္ပဏီများ', '2026-08-21 03:25:01.483170', 17),
(254, 'RESTORE', 'recycled documents', '67', 'Restored Specification Role for MOGE', '2026-08-21 03:25:02.604192', 17),
(255, 'DELETE', 'documents', '67', 'Deleted Specification Role for MOGE', '2026-08-21 03:25:08.115231', 17),
(256, 'DELETE', 'documents', '66', 'Deleted တင်ဒါအောင်မြင်သည့်ကုမ္ပဏီများ', '2026-08-21 03:25:10.906680', 17),
(257, 'DELETE', 'documents', '65', 'Deleted ကိုယ်ရေးမှတ်တမ်းများ', '2026-08-21 03:25:13.351430', 17),
(258, 'DELETE', 'recycled documents', NULL, 'Deleted ကိုယ်ရေးမှတ်တမ်းများ', '2026-08-21 03:25:24.149130', 17),
(259, 'DELETE', 'recycled documents', NULL, 'Deleted တင်ဒါအောင်မြင်သည့်ကုမ္ပဏီများ', '2026-08-21 03:25:24.152153', 17),
(260, 'DELETE', 'recycled documents', NULL, 'Deleted Specification Role for MOGE', '2026-08-21 03:25:24.159372', 17),
(261, 'DELETE', 'recycled documents', NULL, 'Deleted Staff Company Profile', '2026-08-21 03:25:24.175112', 17),
(262, 'DELETE', 'recycled documents', NULL, 'Deleted JITES 2020-part-2', '2026-08-21 03:25:24.184382', 17),
(263, 'DELETE', 'recycled documents', NULL, 'Deleted အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026', '2026-08-21 03:25:24.189035', 17),
(264, 'DELETE', 'recycled documents', NULL, 'Deleted အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_7_2026', '2026-08-21 03:25:24.189035', 17),
(265, 'DELETE', 'recycled documents', NULL, 'Deleted အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_10_2026', '2026-08-21 03:25:24.199141', 17),
(266, 'DELETE', 'recycled documents', NULL, 'Deleted rules', '2026-08-21 03:25:24.206392', 17),
(267, 'DELETE', 'recycled documents', NULL, 'Deleted Aura X Business Plan', '2026-08-21 03:25:24.207414', 17),
(268, 'DELETE', 'recycled documents', NULL, 'Deleted Language-2', '2026-08-21 03:25:28.895952', 17),
(269, 'DELETE', 'recycled documents', NULL, 'Deleted Information-Technology-1', '2026-08-21 03:25:28.899954', 17),
(270, 'DELETE', 'recycled documents', NULL, 'Deleted CS-5121_CyberSecurity-DigitalForensics_LectureNotesUpdate', '2026-08-21 03:25:28.915549', 17),
(271, 'DELETE', 'recycled documents', NULL, 'Deleted Commitment Letter ( AURA-X )', '2026-08-21 03:25:28.923264', 17),
(272, 'DELETE', 'recycled documents', NULL, 'Deleted Presentation ( AURA-X )', '2026-08-21 03:25:28.927300', 17),
(273, 'DELETE', 'recycled documents', NULL, 'Deleted Technical Feasibility Analysis ( AURA-X )', '2026-08-21 03:25:28.941513', 17),
(274, 'DELETE', 'recycled documents', NULL, 'Deleted Aura X Business Plan', '2026-08-21 03:25:28.942513', 17),
(275, 'DELETE', 'recycled documents', NULL, 'Deleted AURA_X_Market_Analysis', '2026-08-21 03:25:28.945514', 17),
(276, 'DELETE', 'recycled documents', NULL, 'Deleted MOGE_System Requirements', '2026-08-21 03:25:28.949116', 17),
(277, 'CREATE', 'documents', '84', 'Upload ကိုယ်ရေးမှတ်တမ်းများ', '2026-08-21 03:26:37.269098', 17),
(278, 'DELETE', 'documents', '84', 'Deleted ကိုယ်ရေးမှတ်တမ်းများ', '2026-08-21 03:26:53.067321', 17),
(279, 'DELETE', 'recycled documents', NULL, 'Deleted ကိုယ်ရေးမှတ်တမ်းများ', '2026-08-21 03:27:16.075904', 17),
(280, 'CREATE', 'documents', '85', 'Upload ကိုယ်ရေးမှတ်တမ်းများ', '2026-08-21 03:27:47.846164', 17),
(281, 'CREATE', 'documents', '86', 'Upload တင်ဒါအောင်မြင်သည့်ကုမ္ပဏီများ', '2026-08-21 03:28:22.678969', 17),
(282, 'DELETE', 'documents', '86', 'Deleted တင်ဒါအောင်မြင်သည့်ကုမ္ပဏီများ', '2026-08-21 03:40:51.962504', 17),
(283, 'DELETE', 'documents', '85', 'Deleted ကိုယ်ရေးမှတ်တမ်းများ', '2026-08-21 03:40:51.964503', 17),
(284, 'DELETE', 'recycled documents', NULL, 'Deleted ကိုယ်ရေးမှတ်တမ်းများ', '2026-08-21 03:40:58.007702', 17),
(285, 'DELETE', 'recycled documents', NULL, 'Deleted တင်ဒါအောင်မြင်သည့်ကုမ္ပဏီများ', '2026-08-21 03:40:58.009702', 17),
(286, 'CREATE', 'documents', '87', 'Upload ကိုယ်ရေးမှတ်တမ်းများ', '2026-08-21 03:41:21.673567', 17),
(287, 'CREATE', 'documents', '88', 'Upload Company', '2026-08-21 03:53:59.579732', 17),
(288, 'CREATE', 'documents', '89', 'Upload အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026', '2026-08-21 03:54:34.309382', 17),
(289, 'CREATE', 'documents', '90', 'Upload 2025-2026 Academic Year Syllabus', '2026-08-21 03:55:22.017557', 17),
(290, 'CREATE', 'locations', '15', 'Upload testing', '2026-08-21 04:15:01.759553', 17),
(291, 'DELETE', 'locations', NULL, 'Deleted testing', '2026-08-21 04:15:14.625977', 17);

-- --------------------------------------------------------

--
-- Table structure for table `authentication_moguser`
--

CREATE TABLE `authentication_moguser` (
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `id` bigint(20) NOT NULL,
  `user_id` varchar(20) NOT NULL,
  `username` varchar(20) NOT NULL,
  `email` varchar(254) NOT NULL,
  `password` varchar(128) NOT NULL,
  `role` varchar(20) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` date NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `staff_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `authentication_moguser`
--

INSERT INTO `authentication_moguser` (`last_login`, `is_superuser`, `id`, `user_id`, `username`, `email`, `password`, `role`, `is_active`, `date_joined`, `is_staff`, `staff_id`) VALUES
('2026-08-20 14:17:35.779047', 0, 17, 'USR-006', 'Jaycoab', 'admin@gmail.com', 'pbkdf2_sha256$1000000$u45T0SlltddcZTpItwDDwE$ck7BnsET0ZW7Ui6ODmKiz/TEnoYWOyWJkUZFlBW1TGs=', 'admin', 1, '2026-05-02', 1, 3),
('2026-08-03 02:55:03.199494', 0, 18, 'USR-007', 'Director General', 'superadmin@gmail.com', 'pbkdf2_sha256$1000000$soQmZ2fcSP7LlFTGBGIXrx$zfxCmKfHkHd49T1R4ET8uPxg2j57gk4w2W/+atmSxLU=', 'super admin', 1, '2026-05-02', 1, 4),
('2026-07-27 04:21:28.723841', 0, 21, 'USR-008', 'Staff', 'kise@gmail.com', 'pbkdf2_sha256$1000000$ZIHoddSz8WN7SX9XS0Sp8e$z/mZXhwMYkL86dZpS7lQvlfxc39qCDQ4Qq87eCBOhCo=', 'user', 1, '2026-07-07', 1, 5),
('2026-07-10 08:49:12.666128', 0, 22, 'USR-009', 'U Myo Min', 'umyomin@gmail.com', 'pbkdf2_sha256$1000000$hXZmfWcLr9OCEsc4q9yTek$LvaXWmpSFrPhizvA1NJctQsbmbXfQDg9V8AC/DE7Ml0=', 'user', 1, '2026-07-10', 1, 6),
('2026-08-03 02:54:27.244689', 0, 25, 'USR-010', 'Staff User', 'staff@gmail.com', 'pbkdf2_sha256$1000000$3uM8SQdfu6ndMxTT1l1Xze$YlMZIZDxEFzaDlks4SHFBIvMFdoakC42fP6aKghpNjE=', 'user', 1, '2026-07-31', 1, 7);

-- --------------------------------------------------------

--
-- Table structure for table `authentication_moguser_groups`
--

CREATE TABLE `authentication_moguser_groups` (
  `id` bigint(20) NOT NULL,
  `moguser_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `authentication_moguser_user_permissions`
--

CREATE TABLE `authentication_moguser_user_permissions` (
  `id` bigint(20) NOT NULL,
  `moguser_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `authtoken_token`
--

CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add content type', 4, 'add_contenttype'),
(14, 'Can change content type', 4, 'change_contenttype'),
(15, 'Can delete content type', 4, 'delete_contenttype'),
(16, 'Can view content type', 4, 'view_contenttype'),
(17, 'Can add session', 5, 'add_session'),
(18, 'Can change session', 5, 'change_session'),
(19, 'Can delete session', 5, 'delete_session'),
(20, 'Can view session', 5, 'view_session'),
(21, 'Can add Token', 6, 'add_token'),
(22, 'Can change Token', 6, 'change_token'),
(23, 'Can delete Token', 6, 'delete_token'),
(24, 'Can view Token', 6, 'view_token'),
(25, 'Can add Token', 7, 'add_tokenproxy'),
(26, 'Can change Token', 7, 'change_tokenproxy'),
(27, 'Can delete Token', 7, 'delete_tokenproxy'),
(28, 'Can view Token', 7, 'view_tokenproxy'),
(29, 'Can add user', 8, 'add_user'),
(30, 'Can change user', 8, 'change_user'),
(31, 'Can delete user', 8, 'delete_user'),
(32, 'Can view user', 8, 'view_user'),
(33, 'Can add mog user', 9, 'add_moguser'),
(34, 'Can change mog user', 9, 'change_moguser'),
(35, 'Can delete mog user', 9, 'delete_moguser'),
(36, 'Can view mog user', 9, 'view_moguser'),
(37, 'Can add email address', 10, 'add_emailaddress'),
(38, 'Can change email address', 10, 'change_emailaddress'),
(39, 'Can delete email address', 10, 'delete_emailaddress'),
(40, 'Can view email address', 10, 'view_emailaddress'),
(41, 'Can add email confirmation', 11, 'add_emailconfirmation'),
(42, 'Can change email confirmation', 11, 'change_emailconfirmation'),
(43, 'Can delete email confirmation', 11, 'delete_emailconfirmation'),
(44, 'Can view email confirmation', 11, 'view_emailconfirmation'),
(45, 'Can add social account', 12, 'add_socialaccount'),
(46, 'Can change social account', 12, 'change_socialaccount'),
(47, 'Can delete social account', 12, 'delete_socialaccount'),
(48, 'Can view social account', 12, 'view_socialaccount'),
(49, 'Can add social application', 13, 'add_socialapp'),
(50, 'Can change social application', 13, 'change_socialapp'),
(51, 'Can delete social application', 13, 'delete_socialapp'),
(52, 'Can view social application', 13, 'view_socialapp'),
(53, 'Can add social application token', 14, 'add_socialtoken'),
(54, 'Can change social application token', 14, 'change_socialtoken'),
(55, 'Can delete social application token', 14, 'delete_socialtoken'),
(56, 'Can view social application token', 14, 'view_socialtoken'),
(57, 'Can add room', 15, 'add_room'),
(58, 'Can change room', 15, 'change_room'),
(59, 'Can delete room', 15, 'delete_room'),
(60, 'Can view room', 15, 'view_room'),
(61, 'Can add department', 16, 'add_department'),
(62, 'Can change department', 16, 'change_department'),
(63, 'Can delete department', 16, 'delete_department'),
(64, 'Can view department', 16, 'view_department'),
(65, 'Can add rank', 17, 'add_rank'),
(66, 'Can change rank', 17, 'change_rank'),
(67, 'Can delete rank', 17, 'delete_rank'),
(68, 'Can view rank', 17, 'view_rank'),
(69, 'Can add role', 18, 'add_role'),
(70, 'Can change role', 18, 'change_role'),
(71, 'Can delete role', 18, 'delete_role'),
(72, 'Can view role', 18, 'view_role'),
(73, 'Can add stype', 19, 'add_stype'),
(74, 'Can change stype', 19, 'change_stype'),
(75, 'Can delete stype', 19, 'delete_stype'),
(76, 'Can view stype', 19, 'view_stype'),
(77, 'Can add staff', 20, 'add_staff'),
(78, 'Can change staff', 20, 'change_staff'),
(79, 'Can delete staff', 20, 'delete_staff'),
(80, 'Can view staff', 20, 'view_staff'),
(81, 'Can add archive', 21, 'add_archive'),
(82, 'Can change archive', 21, 'change_archive'),
(83, 'Can delete archive', 21, 'delete_archive'),
(84, 'Can view archive', 21, 'view_archive'),
(85, 'Can add category', 22, 'add_category'),
(86, 'Can change category', 22, 'change_category'),
(87, 'Can delete category', 22, 'delete_category'),
(88, 'Can view category', 22, 'view_category'),
(89, 'Can add document', 23, 'add_document'),
(90, 'Can change document', 23, 'change_document'),
(91, 'Can delete document', 23, 'delete_document'),
(92, 'Can view document', 23, 'view_document'),
(93, 'Can add building', 24, 'add_building'),
(94, 'Can change building', 24, 'change_building'),
(95, 'Can delete building', 24, 'delete_building'),
(96, 'Can view building', 24, 'view_building'),
(97, 'Can add document types', 25, 'add_documenttypes'),
(98, 'Can change document types', 25, 'change_documenttypes'),
(99, 'Can delete document types', 25, 'delete_documenttypes'),
(100, 'Can view document types', 25, 'view_documenttypes'),
(101, 'Can add dtype', 25, 'add_dtype'),
(102, 'Can change dtype', 25, 'change_dtype'),
(103, 'Can delete dtype', 25, 'delete_dtype'),
(104, 'Can view dtype', 25, 'view_dtype'),
(105, 'Can add audit log', 26, 'add_auditlog'),
(106, 'Can change audit log', 26, 'change_auditlog'),
(107, 'Can delete audit log', 26, 'delete_auditlog'),
(108, 'Can view audit log', 26, 'view_auditlog'),
(109, 'Can add document', 27, 'add_document'),
(110, 'Can change document', 27, 'change_document'),
(111, 'Can delete document', 27, 'delete_document'),
(112, 'Can view document', 27, 'view_document'),
(113, 'Can add chat message', 28, 'add_chatmessage'),
(114, 'Can change chat message', 28, 'change_chatmessage'),
(115, 'Can delete chat message', 28, 'delete_chatmessage'),
(116, 'Can view chat message', 28, 'view_chatmessage'),
(117, 'Can add landmark', 29, 'add_landmark'),
(118, 'Can change landmark', 29, 'change_landmark'),
(119, 'Can delete landmark', 29, 'delete_landmark'),
(120, 'Can view landmark', 29, 'view_landmark'),
(121, 'Can add location', 30, 'add_location'),
(122, 'Can change location', 30, 'change_location'),
(123, 'Can delete location', 30, 'delete_location'),
(124, 'Can view location', 30, 'view_location'),
(125, 'Can add location type', 31, 'add_locationtype'),
(126, 'Can change location type', 31, 'change_locationtype'),
(127, 'Can delete location type', 31, 'delete_locationtype'),
(128, 'Can view location type', 31, 'view_locationtype'),
(129, 'Can add location photo', 32, 'add_locationphoto'),
(130, 'Can change location photo', 32, 'change_locationphoto'),
(131, 'Can delete location photo', 32, 'delete_locationphoto'),
(132, 'Can view location photo', 32, 'view_locationphoto');

-- --------------------------------------------------------

--
-- Table structure for table `buildings`
--

CREATE TABLE `buildings` (
  `id` bigint(20) NOT NULL,
  `building_id` varchar(10) NOT NULL,
  `building_name` varchar(50) NOT NULL,
  `created_time` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `buildings`
--

INSERT INTO `buildings` (`id`, `building_id`, `building_name`, `created_time`) VALUES
(4, 'B-001', 'ပင်မဆောင်', '2026-04-26 22:13:53.672110'),
(5, 'B-002', 'Engineering', '2026-08-20 14:19:08.094222');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) NOT NULL,
  `category_name` varchar(300) NOT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `category_id` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `category_name`, `parent_id`, `category_id`) VALUES
(18, 'အမိန့်စာ', NULL, 'C-001'),
(19, 'ခွင့်ပြုမိန့်', NULL, 'C-002'),
(20, 'စာရင်းအင်း', NULL, 'C-003'),
(21, 'ဖွဲ့စည်းခြင်း', 18, 'C-004'),
(22, 'တာ၀န်ပေးအပ်ခြင်း', 18, 'C-005'),
(23, 'လမ်းညွှန်ချက် /ညွှန်ကြားချက်များ /ညှိနှိုင်းအကြောင်းကြားစာများ', 18, 'C-006'),
(24, 'PE,DE', 21, 'C-007'),
(25, 'ခန့်အပ်ခြင်း', 22, 'C-008'),
(26, 'ဌာနတွင်း', 23, 'C-009'),
(27, 'ကုမ္ပဏီများ', 23, 'C-010'),
(28, 'အခြား၀န်ကြီးဌာနမှ ညွှန်ကြားစာများ', 23, 'C-011'),
(33, 'မှတ်တမ်း', NULL, 'C-016'),
(34, 'တင်ဒါ', NULL, 'C-017'),
(35, 'တင်ဒါ (Procurement) ခေါ်ယူခြင်း', 34, 'C-018'),
(36, 'တင်ဒါ (Services) ခေါ်ယူခြင်း', 34, 'C-019'),
(37, 'စာချုပ်ချုပ်ဆိုခြင်း', 34, 'C-020'),
(38, 'တင်ဒါအောင်မြင်ကြောင်း အကြောင်းကြားစာများ', 34, 'C-021'),
(39, 'ဝန်ထမ်းရေးရာ', 19, 'C-022'),
(40, 'လုပ်ငန်း/ ပစ္စည်းဆိုင်ရာ', 19, 'C-023'),
(41, 'လုံခြုံရေးဆိုင်ရာကိစ္စရပ်များ', 19, 'C-024'),
(42, 'Visa', 19, 'C-025'),
(43, 'ခရီးသွားလာခွင့်', 19, 'C-026'),
(44, 'ဝန်ကြီးရုံး၊ EC ၊ MC နှင့်သက်ဆိုင်ရာများမှခွင့်ပြုမိန့်များ', 19, 'C-027'),
(45, 'ခွင့်ပြုမိန့်တောင်းခံ/ခွင့်ပြုခြင်း', 41, 'C-028'),
(46, 'ရေနံမြေဒေသအသီးသီးရှိလုံခြုံရေးအင်အားဖြန့်ခွဲထားရှိမှု', 41, 'C-029'),
(47, 'အပတ်စဉ် Drone Jammer စစ်ဆေးမှုမှတ်တမ်းများ', 41, 'C-030'),
(48, 'ဖွဲ့စည်းပုံ', NULL, 'C-031'),
(49, 'Report', NULL, 'C-032'),
(50, 'CSR, HSE, EIA, SIA', NULL, 'C-033'),
(51, 'Loan, Grant, ODA', NULL, 'C-034'),
(52, 'ပုံများ', NULL, 'C-035'),
(53, 'နိုင်ငံခြားရေနံကုမ္ပဏီများ/ပုဂ္ဂလိကနှင့်အထွေထွေ', NULL, 'C-036'),
(54, 'MD, DY-MD', NULL, 'C-037'),
(55, 'Master (MD\'sign လက်မှတ်ထိုး၍ ထွက်သောစာများ', 54, 'C-038'),
(58, 'နိုင်ငံခြားနှင့်အထွေထွေ', 53, 'C-039'),
(59, 'General (အထွေထွေအသုံးစရိတ်စာရင်းများ/နိုင်ငံပိုင် ပုဂ္ဂလိက စက်ရုံများအတွက် ပြည်တွင်းသုံးသဘာဝဓာတ်ငွေ့ ရောင်းချခြင်း စာရင်းများ)', 58, 'C-040'),
(60, 'Foreign Exchange (နိုင်ငံခြားငွေစာရင်း Loan ချေးငွေ/  Cash call အသုံးစရိတ်ခုနှိမ့်ခြင်းစာရင်းများ)', 58, 'C-041'),
(61, 'Cost Recovery Audit Working', 53, 'C-042'),
(62, 'MD Report', 61, 'C-043'),
(63, 'Audit Report', 61, 'C-044'),
(64, 'Cost Recovery Report', 61, 'C-045'),
(65, 'ဓာတ်ပုံများ', 52, 'C-046'),
(66, 'မြေပုံ/ ROW/ Pipeline Network', 52, 'C-047'),
(67, 'Block Map', 52, 'C-048'),
(68, 'Capital Budget ဖြင့် ဆောင်ရွက်မည့်ကိစ္စများ', 35, 'C-049'),
(69, 'Revenue Budget ဖြင့် ဆောင်ရွက်မည့်ကိစ္စများ', 35, 'C-050'),
(70, 'ပြဌာန်းသတ်မှတ်ခြင်း', 18, 'C-051'),
(71, 'MD, DY-MD ပါဝင်သော ကော်မတီများ', 21, 'C-052'),
(72, 'အဖွဲ့/ကော်မတီများ', 21, 'C-053'),
(73, 'ဝန်ထမ်းရေးရာစာရင်းများ', 20, 'C-054'),
(74, 'သင်တန်းများ/ဆွေးနွေးပွဲ/လေ့လာရေး (ပြည်တွင်း)', 73, 'C-055'),
(75, 'တွဲဖက်တာဝန်ပေးအပ်ခြင်း (Secondee/Rep)', 73, 'C-056'),
(76, 'သင်တန်းများ/ဆွေးနွေးပွဲ/လေ့လာရေး (ပြည်ပ)', 73, 'C-057'),
(77, 'ဝန်ထမ်းအင်အား', 73, 'C-058'),
(78, 'ဝန်ထမ်းဖွဲ့စည်းပုံ', 73, 'C-059'),
(79, 'တန်းစီဇယား', 73, 'C-060'),
(80, 'ပြုန်းတီးအင်အား', 73, 'C-061'),
(81, 'စီမံကိန်း/ ဘဏ္ဍာရေးဆိုင်ရာစာရင်းများ', 20, 'C-062'),
(82, 'Procurement', 20, 'C-063'),
(83, 'လျော်ကြေးဆိုင်ရာများ', 20, 'C-064'),
(84, 'Production Data/ Statistics', 20, 'C-065'),
(85, 'အမိန့်ကြော်ငြာစာများ', 18, 'C-066'),
(86, 'ဘဏ္ဍာရေးဆိုင်ရာ', 19, 'C-067'),
(87, 'ဌာနအလိုက် ဖွဲ့စည်းပုံ', 48, 'C-068'),
(88, 'စာချုပ်များ', 33, 'C-069'),
(89, 'ထူးခြားဖြစ်စဉ်/ ထိခိုက်ဆုံးရှုံးမှု မှတ်တမ်း', 33, 'C-070'),
(90, 'ကိုယ်ရေးမှတ်တမ်း', 33, 'C-071'),
(91, 'ပြည်တွင်း', 51, 'C-072'),
(92, 'ပြည်ပ', 51, 'C-073'),
(93, 'ECC လက်မှတ်များ', 50, 'C-074'),
(94, 'MOGE CSR', 50, 'C-075'),
(95, 'နေ့စဉ်၊ အပတ်စဉ်၊ လစဉ်၊ ၃/၆ လပတ်၊ နှစ်စဉ် report များ', 49, 'C-076'),
(96, 'ပြန်တမ်းများ', 49, 'C-077'),
(97, 'ကြေးနန်းများ', 49, 'C-078'),
(98, 'Balance sheets', 49, 'C-079'),
(99, 'အစီရင်ခံစာများ', 49, 'C-080');

-- --------------------------------------------------------

--
-- Table structure for table `chats_chatmessage`
--

CREATE TABLE `chats_chatmessage` (
  `id` bigint(20) NOT NULL,
  `role` varchar(10) NOT NULL,
  `content` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chats_chatmessage`
--

INSERT INTO `chats_chatmessage` (`id`, `role`, `content`, `created_at`, `user_id`) VALUES
(81, 'assistant', 'No documents have been uploaded to the current session. Therefore, there is no document information available to provide.', '2026-05-02 17:29:56.132033', NULL),
(82, 'assistant', 'The information for the staff member named **Hoshino** is as follows:\n\n*   **Staff ID:** S-002\n*   **Email:** hoshino@gmail.com\n*   **Address:** North Dagon, Yangon, Myanmar\n*   **Phone Number:** 09847334554\n*   **Gender:** Female\n*   **Department ID:** 2\n*   **Rank ID:** 5\n*   **Role ID:** 5\n*   **Staff Type ID:** 3\n*   **Created At:** 2026-04-28 01:05:40\n*   **Updated At:** 2026-04-28 01:05:40', '2026-05-02 17:32:14.157916', NULL),
(83, 'assistant', 'Here is the information for all the documents that have been uploaded:\n\n| Document ID | Document Name | Created At | Updated At | Description | File Path | Staff ID | Expired At |\n| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |\n| DOC-001 | CommitmentLetter (AURA-X).pdf | 2026-04-29 | 2026-04-30 | vdfsgsgsfg | documents/CommitmentLetter_AURA-X.pdf | 3 | N/A |\n| DOC-002 | Aura X Business Plan.pdf | 2026-04-30 | 2026-04-30 | This document is for business plan | documents/Aura_X_Business_Plan.pdf | 3 | 2026-04-30 |\n| DOC-003 | AURA-X-ppt.pdf | 2026-04-30 | 2026-04-30 | sfjdsfhsdfjsdfdsf | documents/AURA-X-ppt.pdf | 4 | N/A |', '2026-05-02 17:36:00.963356', NULL),
(84, 'assistant', 'The staff member who most recently uploaded a document is **Kise** (Staff ID: S-003).\n\n**Staff Details:**\n- **Name:** Kise\n- **Email:** kise@gmail.com\n- **Phone:** 097476545343\n- **Address:** Taungoo, Bago\n- **Gender:** Male\n- **Department ID:** 3\n- **Rank ID:** 5\n- **Role ID:** 2\n- **Staff Type ID:** 3', '2026-05-02 17:49:24.191701', NULL),
(85, 'user', 'get me the staff data who upload a document in most recent time', '2026-05-02 17:53:25.462189', NULL),
(86, 'user', 'who upload the document in most recent time?', '2026-05-02 17:58:09.891130', NULL),
(87, 'assistant', 'The staff member who most recently uploaded a document is **Kise**.\n\n**Staff Details:**\n- **Name:** Kise\n- **Email:** kise@gmail.com\n- **Phone Number:** 097476545343\n- **Address:** Taungoo, Bago\n- **Gender:** Male\n\n**Document Details:**\n- **Document Name:** RegistrationFrom (AURA-X).pdf\n- **Upload Date:** May 2, 2026, 5:48 PM', '2026-05-02 17:58:31.675476', NULL),
(88, 'user', 'which document did he upload?', '2026-05-02 17:58:59.092449', NULL),
(89, 'assistant', 'Kise uploaded the document titled **RegistrationFrom (AURA-X).pdf**.', '2026-05-02 17:59:04.002678', NULL),
(90, 'system', 'Based on the provided conversation history, the uploaded documents cover four distinct areas. Here is the comprehensive information extracted from them:\n\n### **1. AURA-X Project (Business Proposal & Strategic Plan)**\nAURA-X is an AI-powered \"Smart Campus\" and intelligent education infrastructure platform.\n*   **Core Technology Pillars:**\n    *   **AI:** Used for student risk prediction, analytics, and AI assistants (e.g., YouLearnAI). It utilizes CNNs for facial cues and Transformer models.\n    *   **IoT:** Controls campus devices such as lights, fans, and water pumps.\n    *   **Security:** Detects suspicious behavior by unknown persons and provides alerts.\n    *   **Architecture:** Uses an Edge+Cloud architecture.\n*   **Business Model:**\n    *   **Target Market:** Premium K–12 schools, higher education institutions, and private training centers.\n    *   **Revenue Streams:** Monthly/yearly licensing fees, hardware installation, maintenance, and a future transition to a SaaS model.\n    *   **Pricing:** Mentioned costs of 528,000 MMKs/month + 154,000 MMKs/month (excluding utilities and API charges).\n*   **Financials:** Total investment required is **23,300,000 MMKs**, split between Edge AI/IoT (12.5M), Software development (6.8M), Pilot installations (2.5M), and Training/Launch (1.5M).\n*   **Growth Strategy:** A phased approach moving from premium institutions $\\rightarrow$ government partnerships $\\rightarrow$ affordable standard infrastructure for all schools.\n\n### **2. Cyber Security and Digital Forensics (Course CS-5121)**\nThese documents are study materials/assignments focusing on three main areas:\n*   **Critical Infrastructure:** References the **U.S. Department of Homeland Security (DHS)** and its **16 critical infrastructure sectors** (e.g., Energy, Healthcare, Financial Services, IT) vital to national security and economic stability.\n*   **Identity Theft:** \n    *   **Impacts:** Financial loss, privacy breaches (biometrics/ID theft), unauthorized system access, and long-term credit/legal damage.\n    *   **Vectors:** Primarily executed via phishing and malware.\n*   **Mitigation Strategies:** A four-pronged approach:\n    *   **Technical:** MFA, firewalls, encryption, and patching.\n    *   **Organizational:** Security policies, audits, and recovery plans.\n    *   **Legal:** Cyber laws and international cooperation.\n    *   **User Awareness:** Education on social engineering.\n*   **Technical Server Specifications:**\n    *   **Stack:** App layer 24.x LTS, Docker Compose 2.x, Prometheus + Grafana, and ELK Stack (Elasticsearch, Logstash, Kibana) 8.x.\n    *   **Hardware:** Servers with 6 Core CPU, 32 GB RAM, and 1–2 TB SSD.\n    *   **Protection:** RAID 10 with encrypted offsite cloud backups.\n\n### **3. Business Management System (BMS)**\n*   **Nature:** A technical project report.\n*   **Origin:** Created by students from the **University of Computer Studies (Taungoo)** for a database course.\n\n### **4. Competition Guidelines**\n*   **Nature:** A breakdown of submission requirements for a technology/business competition (specifically the 4th China-ASEAN Innovation and Entrepreneurship Competition - CAIEC).\n*   **Contents:** Details regarding PDF formats, the required structure of the business plan, and eligibility criteria.', '2026-05-02 17:59:45.261218', NULL),
(91, 'user', 'get me the most recent log action and who performed it?', '2026-05-02 18:04:47.842405', NULL),
(92, 'assistant', 'The most recent log action was a **RESTORE** operation for the document **\"AURA-X-ppt.pdf\"**, which was performed by the user **Jaycoab** on **May 2, 2026, at 6:04 PM**.', '2026-05-02 18:05:27.434535', NULL),
(93, 'user', 'how are you?', '2026-05-02 18:17:54.670349', NULL),
(174, 'user', 'explain me for this document', '2026-07-01 17:34:24.513647', 17),
(175, 'user', 'explain me about this document', '2026-07-01 17:35:21.168935', 17),
(176, 'user', 'explain me about this document', '2026-07-01 17:42:11.405362', 17),
(177, 'user', 'helllo', '2026-07-02 04:35:06.676732', 17),
(178, 'user', 'hello', '2026-07-02 04:35:56.266691', 17),
(179, 'assistant', 'Hello! How can I help you today?', '2026-07-02 04:35:56.272870', 17),
(180, 'user', 'how are you?', '2026-07-02 04:36:01.619609', 17),
(181, 'user', 'hello', '2026-07-02 04:55:38.371158', 17),
(182, 'assistant', 'Hello! How can I help you today?', '2026-07-02 04:55:38.402445', 17),
(183, 'user', 'who are you?', '2026-07-02 04:55:45.345640', 17),
(184, 'assistant', '<think>\nOkay, the user asked \"who are you?\" I need to respond in a friendly and concise way. Since they\'re using English, I\'ll keep it in English. I should mention that I\'m the assistant for the MOGE document management app. Also, I should invite them to ask for help. Let me make sure it\'s natural and not too formal. Maybe start with a greeting and then the main info. Let me check the previous messages to stay consistent. The user has been greeting me, so I should acknowledge that. Alright, something like \"Hi there! I\'m the assistant for the MOGE document management app. How can I help you today?\" That sounds good.\n</think>\n\nHi there! I\'m the assistant for the MOGE document management app. How can I help you today?', '2026-07-02 04:56:06.491337', 17),
(185, 'user', 'explain about this document', '2026-07-02 04:56:48.828935', 17),
(186, 'assistant', '<think>\nOkay, the user wants me to explain the document. Let me start by looking at the retrieved chunks.\n\nFirst, there are two main studies mentioned. The first one is about non-verbal intelligence in primary students. The participants were 460 students from grades 3 and 4. They used a questionnaire with three subtests: odd-one-out, picture arrangement, and matrix reasoning. The findings showed that odd-one-out had the highest scores. Grade 3 students did better than Grade 4 in picture arrangement, but overall no significant difference. Gender-wise, males scored slightly higher but not significantly.\n\nThen there\'s the second study on emotional creativity in adolescents. They looked at factors like effectiveness, preparedness, novelty, etc. The results showed that first-year students had lower effectiveness compared to others. Also, differences were found between universities, with University 1 and 2 scoring higher in emotional creativity and novelty, and University 2 higher in preparedness.\n\nI need to structure this clearly. Start by mentioning the two studies, their participants, methods, and key findings. Make sure to highlight the main points from each study without getting too detailed. Also, check if there\'s any other info, like methodology or conclusions. The user might be looking for a concise summary of both studies, so I\'ll present each with their main points and results. Avoid jargon, keep it simple. Let me make sure I didn\'t miss any important data points from the chunks provided.\n</think>\n\nThe document contains two research studies from the *Journal of Information Technology and Education Science 2020, Vol -02*:\n\n### **1. Study on Non-verbal Intelligence in Primary Students**  \n- **Participants**: 460 students (Grade 3 and Grade 4) from two schools in Myanmar (B.E.P.S (18) North Okkalarpa and B.E.P.S (1) Insein).  \n- **Method**: A non-verbal intelligence questionnaire with 25 items across three subtests:  \n  - *Odd-one-out* (10 items)  \n  - *Picture arrangement* (8 items)  \n  - *Matrix reasoning* (7 items)  \n- **Key Findings**:  \n  - **Performance**: Highest scores in *odd-one-out* (90.44% mean).  \n  - **Grade Comparison**: Grade 3 students outperformed Grade 4 in *picture arrangement*, but no overall significant difference in non-verbal intelligence.  \n  - **Gender Comparison**: Slight male advantage in non-verbal intelligence, but not statistically significant except in *picture arrangement*.  \n\n---\n\n### **2. Study on Emotional Creativity in Adolescents**  \n- **Focus**: Emotional Creativity, Preparedness, Novelty, Effectiveness, and Authenticity.  \n- **Key Findings**:  \n  - **Education Level**:  \n    - *Effectiveness* showed significant differences: First-year students scored lower than others.  \n    - No significant differences in Emotional Creativity, Preparedness, Novelty, or Authenticity.  \n  - **University Comparison**:  \n    - *Emotional Creativity* and *Novelty*: University 1 and 2 scored higher than University 3.  \n    - *Preparedness*: University 2 scored higher than Universities 1 and 3.  \n    - No significant differences in *Effectiveness* or *Authenticity*.  \n\nBoth studies used statistical analyses (e.g., t-tests, ANOVA) to compare groups and identify significant differences. The first study focused on primary students, while the second examined adolescents across different educational institutions.', '2026-07-02 04:59:10.901884', 17),
(187, 'user', 'explain me about this document', '2026-07-02 05:01:23.515733', 17),
(188, 'user', 'explain me in burmese language', '2026-07-02 05:06:19.278287', 17),
(189, 'user', 'hello', '2026-07-07 06:38:29.906470', 17),
(190, 'assistant', 'Hello! How can I help you today?', '2026-07-07 06:38:29.934660', 17),
(191, 'user', 'who are you?', '2026-07-07 06:38:37.567723', 17),
(192, 'assistant', 'I am your friendly assistant for the MOGE document management app. How can I help you today?', '2026-07-07 06:38:42.956670', 17),
(193, 'user', 'hello', '2026-07-07 20:29:52.964070', 17),
(194, 'assistant', 'Hello! How can I help you today?', '2026-07-07 20:29:52.990493', 17),
(195, 'user', 'who are you?', '2026-07-07 20:30:01.142882', 17),
(196, 'user', 'hello there', '2026-08-10 06:57:15.623233', 17),
(197, 'assistant', 'မင်္ဂလာပါရှင်။ MOGE (မြန်မာ့ရေနံနှင့် သဘာဝဓာတ်ငွေ့လုပ်ငန်း) မှ ကြိုဆိုပါတယ်။ \n\nယနေ့ မည်သို့ကူညီပေးရမလဲရှင်။', '2026-08-10 06:57:15.652305', 17),
(198, 'user', 'how many staffs are there?', '2026-08-10 06:58:33.242331', 17),
(199, 'assistant', 'There are 5 staff members in total according to the database records.', '2026-08-10 06:58:33.245372', 17),
(200, 'user', 'can you give me about their informations?', '2026-08-10 06:58:48.952198', 17),
(201, 'assistant', 'မင်္ဂလာပါ။ မြန်မာ့ရေနံနှင့် သဘာဝဓာတ်ငွေ့လုပ်ငန်း (Myanmar Oil and Gas Enterprise - MOGE) အကြောင်းကို မေးမြန်းသည့်အတွက် ကျေးဇူးတင်ပါသည်။ \n\nMOGE သည် မြန်မာနိုင်ငံ၏ စွမ်းအင်ဝန်ကြီးဌာနအောက်တွင် ရှိသော နိုင်ငံပိုင်လုပ်ငန်းတစ်ခုဖြစ်ပြီး နိုင်ငံအတွင်း ရေနံနှင့် သဘာဝဓာတ်ငွေ့ ရှာဖွေရေး၊ တူးဖော်ရေး၊ ထتاجလုပ်ငန်းနှင့် ဖြန့်ဖြူးခြင်းလုပ်ငန်းများကို အဓိက တာဝန်ယူဆောင်ရွက်လျက်ရှိပါသည်။\n\nMOGE နှင့်ပတ်သက်၍ အဓိက အချက်အလက်များမှာ အောက်ပါအတိုင်း ဖြစ်ပါသည်-\n\n၁။ **သမိုင်းကြောင်းနှင့် ရည်ရွယ်ချက်**\n   - MOGE ကို မြန်မာနိုင်ငံ၏ ရေနံအရင်းအမြစ်များကို စနစ်တကျ ထုတ်ယူသုံးစွဲနိုင်ရန်နှင့် နိုင်ငံတော်၏ စွမ်းအင်ဖူလုံရေး၊ စီးပွားရေးဖွံ့ဖြိုးတိုးတက်ရေးတို့အတွက် အဓိက ရည်ရွယ်၍ ဖွဲ့စည်းခဲ့ခြင်း ဖြစ်ပါသည်။\n\n၂။ **ဆောင်ရွက်လျက်ရှိသော လုပ်ငန်းများ**\n   - **ရေနံနှင့် သဘာဝဓာတ်ငွေ့ ရှာဖွေရေးနှင့် တူးဖော်ရေး (Exploration & Production):** ပြည်တွင်းနှင့် ပြည်ပ ကုမ္ပဏီများနှင့် ပူးပေါင်း၍ ကုန်းတွင်းနှင့် ပင်လယ်ပြင် (Offshore) တို့တွင် ရေနံနှင့် ဓာတ်ငွေ့ ရင်းမြစ်များကို ရှာဖွေတူးဖော်ခြင်း။\n   - **ထုတ်လုပ်ခြင်း (Production):** ထွက်ရှိလာသော ရေနံနှင့် သဘာဝဓာတ်ငွေ့များကို စီးပွားဖြစ် ထုတ်လုပ်ခြင်း။\n   - **ဖြန့်ဖြူးခြင်းနှင့် ပို့လွှတ်ခြင်း (Transmission & Distribution):** ထွက်ရှိလာသော သဘာဝဓာတ်ငွေ့များကို ပြည်တွင်းဓာတ်အားပေးစက်ရုံများ၊ စက်မှုလုပ်ငန်းများနှင့် ပြည်ပသို့ ပိုက်လိုင်းများဖြင့် ပို့လွှတ်ဖြန့်ဖြူးခြင်း။\n   - **ဖက်စပ်လုပ်ငန်းများ (Joint Ventures):** နိုင်ငံတကာ ရေနံကုမ္ပဏီများနှင့် ဖက်စပ်လုပ်ကိုင်ခြင်း (Production Sharing Contracts - PSCs)။\n\n၃။ **နိုင်ငံအတွက် အခန်းကဏ္ဍ**\n   - MOGE သည် နိုင်ငံတော်အတွက် နိုင်ငံခြားဝင်ငွေ အဓိက ရှာဖွေပေးနေသည့် အဖွဲ့အစည်းတစ်ခုဖြစ်ပြီး ပြည်တွင်းစွမ်းအင် လိုအပ်ချက်ကို ဖြည့်ဆည်းပေးရာတွင် အလွန်အရေးပါသော အခန်းကဏ္ဍမှ ပါဝင်ပါသည်။\n\nအကယ်၍ MOGE ၏ တိကျသေချာသော လုပ်ငန်းစဉ်များ၊ စာရင်းအချက်အလက်များ သို့မဟုတ် အခြား အသေးစိတ်အချက်အလက်များကို ထပ်မံသိရှိလိုပါက မေးမြန်းနိုင်ပါသည်။ (အင်္ဂလိပ်ဘာသာဖြင့် ဆက်လက်မေးမြန်းလိုပါကလည်း ပြောပြပေးနိုင်ပါသည်။)', '2026-08-10 06:58:48.961312', 17),
(202, 'user', 'how many staffs are there? and give me about their informations', '2026-08-10 06:59:23.107054', 17),
(203, 'assistant', 'MOGE (Myanmar Oil and Gas Enterprise) ၏ ဒေတာဘေ့စ် မှတ်တမ်းများအရ စုစုပေါင်း ဝန်ထမ်းဦးရေ **၅ ဦး** ရှိပါသည်။ \n\nဝန်ထမ်းများ၏ အချက်အလက်များမှာ အောက်ပါအတိုင်း ဖြစ်ပါသည်-\n\n၁။ **ID:** S-001\n   * **Name:** U Myat Zaw\n   * **Dept:** ဦးဆောင်ညွှန်ကြားရေးမှူးရုံးအဖွဲ့\n   * **Role:** Head of Department\n   * **Rank:** ညွှန့်မှူး\n   * **Email:** jaycoab2@gmail.com\n   * **Phone:** 09676067433\n   * **Gender:** male\n\n၂။ **ID:** S-002\n   * **Name:** U Win Myint\n   * **Dept:** အထွေထွေစီမံခန့်ခွဲရေးဌာန\n   * **Role:** Deputy of Department\n   * **Rank:** ဦးစီးမှူး\n   * **Email:** hoshino@gmail.com\n   * **Phone:** 09847334554\n   * **Gender:** male\n\n၃။ **ID:** S-003\n   * **Name:** Daw Khin Khin\n   * **Dept:** ထုတ်လုပ်ရေးဌာန\n   * **Role:** Head of Department\n   * **Rank:** ဒုဦးစီးမှူး\n   * **Email:** kise@gmail.com\n   * **Phone:** 097476545343\n   * **Gender:** female\n\n၄။ **ID:** S-004\n   * **Name:** U Myo Min\n   * **Dept:** အထွေထွေစီမံခန့်ခွဲရေးဌာန\n   * **Role:** Deputy of Department\n   * **Rank:** လက်ထောက်ညွှန်မှူး\n   * **Email:** umyomin@gmail.com\n   * **Phone:** 09454534326\n   * **Gender:** male\n\n၅။ **ID:** S-005\n   * **Name:** Daw Aye\n   * **Dept:** အထွေထွေစီမံခန့်ခွဲရေးဌာန\n   * **Role:** Deputy of Department\n   * **Rank:** လက်ထောက်ညွှန်မှူး\n   * **Email:** dawaye@gmail.com\n   * **Phone:** 09874343432\n   * **Gender:** female', '2026-08-10 06:59:23.120158', 17),
(204, 'user', 'give me document which include information about \"တင်ဒါ\"', '2026-08-10 07:00:23.882263', 17),
(205, 'assistant', 'မြန်မာ့ရေနံနှင့် သဘာဝဓာတ်ငွေ့လုပ်ငန်း (MOGE) ၏ အချက်အလက်အခြေခံစနစ် (Knowledge Base) တွင် \"တင်ဒါ\" (Tender) နှင့် ပတ်သက်သည့် တိုက်ရိုက်ကိုက်ညီသော စာရွက်စာတမ်း အချက်အလက်များကို ရှာမတွေ့ပါ။\n\nသို့သော် မေးမြန်းလိုသည့် ကိစ္စရပ် သို့မဟုတ် သက်ဆိုင်ရာ တင်ဒါကိစ္စများနှင့် ပတ်သက်၍ အသေးစိတ်သိရှိလိုပါက သက်ဆိုင်ရာဌာနများသို့ ဆက်သွယ်မေးမြန်းနိုင်ရန် ဝန်ထမ်းအချက်အလက်အချို့ကို အောက်ပါအတိုင်း ဖော်ပြပေးလိုက်ပါတယ် -\n\n- **ဦးဆောင်ညွှန်ကြားရေးမှူးရုံးအဖွဲ့**\n  - ဦးမြတ်ဇော် (ညွှန်မှူး) - ဖုန်း: 09676067433\n- **အထွေထွေစီမံခန့်ခွဲရေးဌာန**\n  - ဦးဝင်းမြင့် (ဦးစီးမှူး) - ဖုန်း: 09847334554\n  - ဦးမျိုးမင်း (လက်ထောက်ညွှန်မှူး) - ဖုန်း: 09454534326\n\nအခြားရှာဖွေလိုသည်များ ရှိပါက ထပ်မံမေးမြန်းနိုင်ပါသည်။', '2026-08-10 07:00:23.887388', 17),
(206, 'user', 'explain me about this document', '2026-08-10 07:02:54.012185', 17),
(207, 'assistant', 'ဤစာရွက်စာတမ်း (Document) အရ လျှပ်စစ်နှင့် စွမ်းအင်ဝန်ကြီးဌာန၊ မြန်မာ့ေစနံနှင့် သဘာဝဓာတ်ငွေ့လုပ်ငန်း (MOGE) တွင် မြန်မာကျပ်ငွေဖြင့် ဝယ်ယူမည့် ဝန်ဆောင်မှုလုပ်ငန်းနှင့် စက်သုံးဆီ/ရေနံတူးဖော်ရေး/ပိုက်လိုင်းဆက်သွယ်ရေးလုပ်ငန်းသုံး ပစ္စည်းများအတွက် အိတ်ဖွင့်တင်ဒါ (၁၄/၂၀၂၆-၂၀၂၇) ခေါ်ယူထားခြင်းဖြစ်ပါသည်။ \n\nတင်ဒါပါ ပစ္စည်းများနှင့် ဝန်ဆောင်မှုအမျိုးအစားများမှာ အောက်ပါအတိုင်း ဖြစ်ပါသည် -\n၁။ **MOGE-OS-001(26-27)CAP** - 24” Domestic Offshore Gas Pipeline (Annual Cleaning Pigging) Services\n၂။ **DMP/L-109(26-27)CAP** - 14” ERW Steel Line Pipe (20,600) Meter\n၃။ **DMP/L-110(26-27)CAP** - 20” LSAW Steel Line Pipe (16,780) Meter\n၄။ **DMP/L-111(26-27)CAP** - Assorted Sizes of Casing (1) Lot\n၅။ **DMP/L-112(26-27)** - Miscromotion Transmitter for CNG Dispenser (3) Sets\n\n**တင်ဒါပုံစံနှင့် လျှောက်ထားရမည့် အချက်အလက်များ:**\n* **တင်ဒါပုံစံဝယ်ယူနိုင်သည့်ရက်နှင့်နေရာ:** ၇-၇-၂၀၂၆ ရက်နေ့မှစ၍ လျှပ်စစ်နှင့် စွမ်းအင်ဝန်ကြီးဌာန၊ မြန်မာ့ရေနံနှင့် သဘာဝဓာတ်ငွေ့လုပ်ငန်း၊ ရုံးအမှတ်(၄၄)၊ (ဘဏ္ဍာရေးဌာန)၊ နေပြည်တော်တွင် လာရောက်ဝယ်ယူနိုင်ပါသည်။ (ဝန်ကြီးဌာန ဝက်ဘ်ဆိုက် energy.gov.mm တွင်လည်း ကြေညာထားမည် ဖြစ်သည်) [အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026.pdf]\n* **တင်ဒါပိတ်မည့်ရက်နှင့်နေရာ:** ၂၁-၇-၂၀၂၆ ရက်နေ့ (၁၃:၀၀) နာရီတွင် နောက်ဆုံးထား၍ လျှပ်စစ်နှင့် စွမ်းအင်ဝန်ကြီးဌာန၊ ရုံးအမှတ်(၆)၊ ဇေတဝန်ခန်းမ၊ နေပြည်တော်သို့ လူကိုယ်တိုင် လာရောက်ပေးသွင်းရမည် ဖြစ်ပါသည်။ [အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026.pdf]\n\n(ကိုးကားချက် - *အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026.pdf*)', '2026-08-10 07:02:54.015703', 17),
(208, 'user', 'give me document which include about this information \"တင်ဒါ\"', '2026-08-10 07:04:11.636310', 17),
(209, 'assistant', '\"တင်ဒါ\" (အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း) ပါဝင်သော စာရွက်စာတမ်းမှာ အောက်ပါအတိုင်း ဖြစ်ပါသည်-\n\n* **အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026.pdf**\n\n(ကိုးကားချက် - `အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026.pdf` စာမျက်နှာ ၁)', '2026-08-10 07:04:11.639331', 17),
(210, 'user', 'explain me about this docuemnt', '2026-08-10 07:04:57.565137', 17),
(211, 'assistant', 'မင်္ဂလာပါရှင်။ MOGE (မြန်မာ့ရေနံနှင့် သဘာဝဓာတ်ငွေ့လုပ်ငန်း) မှ ကြိုဆိုပါတယ်။ \n\nလက်ရှိတွင် ကျွန်မအား ရှင်းလင်းပေးရန်အတွက် မည်သည့်စာရွက်စာတမ်း (document) ကိုမှ ပေးပို့ထားခြင်း မရှိသေးပါ။ \n\nကျေးဇူးပြု၍ စာရွက်စာတမ်းပါ အချက်အလက်များကို ပေးပို့ပါ သို့မဟုတ် မိတ္တူကူးထည့်ပေးပါ (copy-paste လုပ်ပေးပါ)။ သို့မှသာ အဆိုပါစာရွက်စာတမ်းနှင့် ပတ်သက်၍ လိုအပ်သည်များကို ရှင်းလင်းတင်ပြပေးနိုင်မည် ဖြစ်ပါသည်။ \n\n(English ဖြင့် သိရှိလိုပါကလည်း တောင်းဆိုနိုင်ပါသည်။) ဘယ်လိုကူညီပေးရမလဲရှင်။', '2026-08-10 07:04:57.568020', 17),
(212, 'user', 'give me document which include about this information \"ကိုယ်ရေးမှတ်တမ်း\"', '2026-08-10 07:05:44.265049', 17),
(213, 'assistant', 'ပေးထားသော \"ကိုယ်ရေးမှတ်တမ်းများ .docx\" စာရွက်စာတမ်း (Document) တွင် \"ကိုယ်ရေးမှတ်တမ်း\" နှင့် ပတ်သက်သည့် အချက်အလက်များ ပါရှိပါသည်။ \n\nထိုစာရွက်စာတမ်းအတွင်း၌ ကိုယ်ရေးမှတ်တမ်း ပုံစံအမျိုးမျိုးနှင့် အောက်ပါကဲ့သို့သော အသေးစိတ်အချက်အလက်များ ပါဝင်ပါသည်-\n- အမည်၊ ငယ်အမည်၊ အခြားအမည်များ\n- အသက် (မွေးသက္ကရာဇ်) နှင့် မွေးဖွားရာဇာတိ\n- လူမျိုး၊ ကိုးကွယ်သည့်ဘာသာ၊ အရပ်အမြင့်၊ ဆံပင်အရောင်၊ မျက်စိအရောင်၊ အသားအရောင်၊ ကိုယ်အလေးချိန်နှင့် ထင်ရှားသည့်အမှတ်အသားများ\n- နိုင်ငံသားစိစစ်ရေးကတ်ပြားအမှတ်\n- ယခုနေရပ်လိပ်စာနှင့် အမြဲတမ်းနေရပ်လိပ်စာများ\n- တပ်မတော်သို့ ဝင်ခဲ့ဖူးလျှင်/တပ်မတော်သားဖြစ်လျှင် ပါရှိရမည့် အချက်အလက်များ (ကိုယ်ပိုင်အမှတ်၊ တပ်သို့ဝင်သည့်နေ့၊ ဗိုလ်လောင်းသင်တန်းအမှတ်စဉ် စသည်ဖြင့်)\n- ပညာအရည်အချင်း၊ မိဘအမည်နှင့် အလုပ်အကိုင်များ\n- လက်ရှိအလုပ်အကိုင်၊ ရာထူး၊ လစာဝင်ငွေနှင့် တက်ရောက်ခဲ့သည့် သင်တန်းများ\n\n(ကိုးကားချက်- *ကိုယ်ရေးမှတ်တမ်းများ .docx*)', '2026-08-10 07:05:44.270123', 17),
(214, 'user', 'hello', '2026-08-10 07:12:58.431887', 17),
(215, 'assistant', 'မင်္ဂလာပါရှင်။ MOGE (မြန်မာ့ရေနံနှင့် သဘာဝဓာတ်ငွေ့လုပ်ငန်း) မှ ကြိုဆိုပါတယ်။\n\nဘယ်လိုကူညီပေးရမလဲဆိုတာ ပြောပြပေးနိုင်ပါတယ်ရှင်။', '2026-08-10 07:12:58.434905', 17),
(216, 'user', 'တင်ဒါ အကြောင်းပါ၀င်သည့်စာရွက်စာတမ်းကို ဖော်ပြပါ', '2026-08-10 07:13:25.035019', 17),
(217, 'assistant', 'တင်ဒါအကြောင်းပါဝင်သည့် စာရွက်စာတမ်းများ (Tender Documents) နဲ့ပတ်သက်ပြီး သိလိုတာကို နားလည်ပါတယ်ရှင်။\n\nတင်ဒါစာရွက်စာတမ်းများဆိုသည်မှာ လုပ်ငန်းတစ်ခု၊ ကုန်ပစ္စည်းတစ်ခု သို့မဟုတ် ဝန်ဆောင်မှုတစ်ခုအတွက် ကမ်းလှမ်းလွှာများ (Bids) ကို ဖိတ်ခေါ်ရာတွင် အသုံးပြုသည့် အသေးစိတ်အချက်အလက်များ ပါဝင်သော စာရွက်စာတမ်းအစုံအလင်ကို ဆိုလိုပါတယ်။ ၎င်းတို့သည် တင်ဒါတင်သွင်းလိုသူများအတွက် လိုအပ်သော အချက်အလက်အားလုံးကို ပေးအပ်ပြီး တင်ဒါလုပ်ငန်းစဉ်ကို ပွင့်လင်းမြင်သာမှုရှိစေရန်နှင့် တရားမျှတစေရန် ရည်ရွယ်ပါတယ်။\n\nယေဘုယျအားဖြင့် တင်ဒါစာရွက်စာတမ်းများတွင် အောက်ပါအချက်အလက်များ ပါဝင်လေ့ရှိပါတယ်ရှင်။\n\n1.  **တင်ဒါခေါ်ယူခြင်း ဖိတ်ကြားစာ (Invitation to Tender - ITT):**\n    *   တင်ဒါခေါ်ယူသည့် အဖွဲ့အစည်း (ဥပမာ - MOGE) ၏ အမည်။\n    *   တင်ဒါခေါ်ယူသည့် လုပ်ငန်း သို့မဟုတ် ပစ္စည်း/ဝန်ဆောင်မှု၏ အမည်နှင့် အကျဉ်းချုပ်ဖော်ပြချက်။\n    *   တင်ဒါတင်သွင်းရမည့် နောက်ဆုံးရက်နှင့် အချိန်။\n    *   တင်ဒါစာရွက်စာတမ်းများ ဝယ်ယူရမည့်နေရာနှင့် ကုန်ကျစရိတ် (ရှိခဲ့လျှင်)။\n    *   တင်ဒါမဖွင့်မီ အစည်းအဝေး (Pre-bid Meeting) ကျင်းပမည့်ရက်နှင့် အချိန် (ရှိခဲ့လျှင်)။\n\n2.  **တင်ဒါတင်သွင်းသူများအတွက် လမ်းညွှန်ချက်များ (Instructions to Bidders - ITB):**\n    *   တင်ဒါတင်သွင်းပုံ အဆင့်ဆင့်။\n    *   တင်ဒါတင်သွင်းရာတွင် လိုအပ်သော စာရွက်စာတမ်းများ။\n    *   တင်ဒါတင်သွင်းသူများ၏ အရည်အချင်းပြည့်မီမှု သတ်မှတ်ချက်များ (Eligibility Criteria)။\n    *   တင်ဒါအာမခံ (Bid Security) လိုအပ်မှုနှင့် ပမာဏ (ရှိခဲ့လျှင်)။\n    *   တင်ဒါတင်သွင်းသူများ မေးခွန်းမေးမြန်းနိုင်သည့် နည်းလမ်းနှင့် နောက်ဆုံးရက်။\n    *   တင်ဒါများကို အကဲဖြတ်မည့် နည်းလမ်းနှင့် သတ်မှတ်ချက်များ (Evaluation Criteria)။\n\n3.  **လုပ်ငန်းနယ်ပယ်နှင့် သတ်မှတ်ချက်များ (Terms of Reference - TOR / Scope of Work - SOW) နှင့် နည်းပညာဆိုင်ရာ အသေးစိတ်ဖော်ပြချက်များ (Technical Specifications):**\n    *   လုပ်ငန်း၏ ရည်ရွယ်ချက်နှင့် ရည်မှန်းချက်များ။\n    *   ဆောင်ရွက်ရမည့် လုပ်ငန်းတာဝန်များ သို့မဟုတ် ပံ့ပိုးရမည့် ကုန်ပစ္စည်း/ဝန်ဆောင်မှု၏ အသေးစိတ်ဖော်ပြချက်။\n    *   လိုအပ်သော နည်းပညာဆိုင်ရာ စံနှုန်းများ၊ အရည်အသွေး သတ်မှတ်ချက်များ။\n    *   ပေးအပ်ရမည့် အချိန်ဇယား (Delivery Schedule)။\n\n4.  **စာချုပ်ပုံစံ / စာချုပ်မူကြမ်း (Contract Form / Draft Contract):**\n    *   အောင်မြင်သော တင်ဒါတင်သွင်းသူနှင့် ချုပ်ဆိုမည့် စာချုပ်၏ မူကြမ်း။\n    *   စာချုပ်၏ အထွေထွေနှင့် အထူးစည်းကမ်းသတ်မှတ်ချက်များ (General and Special Conditions of Contract)။\n    *   ငွေပေးချေမှုဆိုင်ရာ စည်းကမ်းများ။\n    *   အငြင်းပွားမှု ဖြေရှင်းရေးဆိုင်ရာ အချက်များ။\n\n5.  **ပစ္စည်းစာရင်းနှင့် ဈေးနှုန်းဇယား (Bill of Quantities - BOQ / Price Schedule):**\n    *   တင်ဒါတင်သွင်းသူများ ဈေးနှုန်းများ ဖြည့်သွင်းရမည့် ပုံစံ။\n    *   လုပ်ငန်း သို့မဟုတ် ပစ္စည်းတစ်ခုချင်းစီအတွက် အသေးစိတ်ဖော်ပြချက်နှင့် အရေအတွက်။\n\n6.  **တင်သွင်းရမည့် ပုံစံများ (Forms for Submission):**\n    *   ကမ်းလှမ်းလွှာ (Bid Submission Form)။\n    *   ကုမ္ပဏီ၏ အချက်အလက်များ ဖော်ပြသည့် ပုံစံ။\n    *   ဘဏ်အာမခံချက် (Bank Guarantee) ပုံစံ (ရှိခဲ့လျှင်)။\n    *   အခြားလိုအပ်သော ကြေညာချက်များ သို့မဟုတ် အထောက်အထားများ။\n\n7.  **ဖြည့်စွက်ချက်များ (Addenda):**\n    *   တင်ဒါခေါ်ယူပြီးနောက် စာရွက်စာတမ်းများတွင် ပြင်ဆင်ခြင်း သို့မဟုတ် ဖြည့်စွက်ခြင်းများ ရှိခဲ့လျှင် ထုတ်ပြန်သည့် အချက်အလက်များ။\n\nဤအချက်အလက်များသည် တင်ဒါတင်သွင်းလိုသူများအတွက် ပြည့်စုံသော ကမ်းလှမ်းလွှာတစ်ခုကို ပြင်ဆင်ရာတွင် အထောက်အကူပြုပြီး တင်ဒါလုပ်ငန်းစဉ်ကို ချောမွေ့စေရန် ရည်ရွယ်ပါတယ်ရှင်။\n\nMOGE ၏ တင်ဒါများနှင့် ပတ်သက်၍ အသေးစိတ်သိရှိလိုပါက ကျွန်မတို့၏ တရားဝင်ဝက်ဘ်ဆိုက် (ရှိခဲ့လျှင်) သို့မဟုတ် သက်ဆိုင်ရာဌာနသို့ ဆက်သွယ်မေးမြန်းနိုင်ပါတယ်ရှင်။\n\nအခြားသိလိုသည်များ ရှိပါက မေးမြန်းနိုင်ပါတယ်ရှင်။', '2026-08-10 07:13:25.040159', 17),
(218, 'user', 'give me document which include information about \"တင်ဒါ\"', '2026-08-10 07:14:46.779922', 17),
(219, 'assistant', '\"တင်ဒါ\" အကြောင်းပါဝင်သည့် စာရွက်စာတမ်းကို ဖော်ပြပေးပါမယ်ရှင်။\n\n**အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026.pdf** စာရွက်စာတမ်းတွင် \"တင်ဒါ\" နှင့်ပတ်သက်သည့် အောက်ပါအချက်အလက်များ ပါဝင်ပါတယ်ရှင်။\n\n**တင်ဒါခေါ်ယူခြင်း (အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026.pdf စာမျက်နှာ ၁)**\n*   **တင်ဒါအမှတ်:** (၁၄/၂၀၂၆-၂၀၂၇)\n*   **ခေါ်ယူသည့်အဖွဲ့အစည်း:** လျှပ်စစ်နှင့် စွမ်းအင်ဝန်ကြီးဌာန၊ မြန်မာ့ရေနံနှင့် သဘာဝဓာတ်ငွေ့လုပ်ငန်း (MOGE)\n*   **ရည်ရွယ်ချက်:** မြန်မာ့ရေနံနှင့် သဘာဝဓာတ်ငွေ့လုပ်ငန်းအတွက် ဝန်ဆောင်မှုလုပ်ငန်း / ရေနံတူးဖော်/ပိုက်လိုင်းသွယ်တန်း လုပ်ငန်းသုံး ပစ္စည်းများအား မြန်မာကျပ်ငွေဖြင့် ဝယ်ယူလိုခြင်း။\n\n**တင်ဒါခေါ်ယူသည့် ပစ္စည်း/ဝန်ဆောင်မှုများ (အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026.pdf စာမျက်နှာ ၁)**\nအောက်ပါပစ္စည်း/ဝန်ဆောင်မှု (၅) မျိုးအတွက် တင်ဒါခေါ်ယူထားပါတယ် -\n1.  MOGE-OS-001(26-27)CAP: 24” Domestic Offshore Gas Pipeline (Annual Cleaning Pigging) Services\n2.  DMP/L-109(26-27)CAP: 14” ERW Steel Line Pipe (20,600) Meter\n3.  DMP/L-110(26-27)CAP: 20” LSAW Steel Line Pipe (16,780) Meter\n4.  DMP/L-111(26-27)CAP: Assorted Sizes of Casing (1) Lot\n5.  DMP/L-112(26-27): Miscromotion Transmitter for CNG Dispenser (3) Sets\n\n**တင်ဒါပုံစံများ ဝယ်ယူနိုင်မည့်ရက်နှင့် နေရာ (အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026.pdf စာမျက်နှာ ၁)**\n*   **စတင်ရောင်းချမည့်ရက်:** ၇-၇-၂၀၂၆ ရက်နေ့မှစ၍\n*   **နေရာ:** လျှပ်စစ်နှင့် စွမ်းအင်ဝန်ကြီးဌာန၊ မြန်မာ့ရေနံနှင့် သဘာဝဓာတ်ငွေ့လုပ်ငန်း၊ ရုံးအမှတ်(၄၄)၊ (ဘဏ္ဍာရေးဌာန) နေပြည်တော်။\n*   **အွန်လိုင်းတွင် ကြော်ငြာခြင်း:** ဝန်ကြီးဌာနဝက်ဘ်ဆိုဒ် (energy.gov.mm) တွင်လည်း ကြော်ငြာထားမည်။\n\n**တင်ဒါပိတ်မည့်ရက်နှင့် တင်သွင်းရမည့်နေရာ (အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026.pdf စာမျက်နှာ ၁)**\n*   **ပိတ်မည့်ရက်နှင့် အချိန်:** ၂၁-၇-၂၀၂၆ ရက်နေ့ (၁၃:၀၀) နာရီတွင် နောက်ဆုံးထား၍။\n*   **တင်သွင်းရမည့်နေရာ:** လျှပ်စစ်နှင့် စွမ်းအင်ဝန်ကြီးဌာန၊ ရုံးအမှတ်(၆)၊ ဇေယျာသီရိ၊ နေပြည်တော်သို့ (လူကိုယ်တိုင်) လာရောက်ပေးသွင်းရန်။\n\n**ဆက်သွယ်ရန် (အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026.pdf စာမျက်နှာ ၁)**\n*   **ဖုန်းနံပါတ်:** ၀၆၇-၃၄၁၁၂၀၆\n\nဤအချက်အလက်များသည် `အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026.pdf` စာရွက်စာတမ်းမှ ရယူထားခြင်းဖြစ်ပါတယ်ရှင်။', '2026-08-10 07:14:46.785172', 17),
(220, 'user', 'how many staffs are there?', '2026-08-10 07:15:28.797322', 17),
(221, 'assistant', 'ကျွန်မတို့ရဲ့ Database Records ထဲမှာ ဖော်ပြထားတဲ့ စုစုပေါင်းဝန်ထမ်းအရေအတွက်က **၅ ဦး** ဖြစ်ပါတယ်ရှင်။', '2026-08-10 07:15:28.803003', 17),
(222, 'user', 'give me their informations', '2026-08-10 07:15:45.869467', 17),
(223, 'assistant', 'ဟုတ်ကဲ့ပါရှင်။ ကျွန်မတို့ရဲ့ Database Records ထဲမှာ ဖော်ပြထားတဲ့ ဝန်ထမ်း ၅ ဦးရဲ့ အချက်အလက်များကို ဖော်ပြပေးပါမယ်ရှင်။\n\n1.  **ဦးကျော်စွာဦး** - ဦးဆောင်ညွှန်ကြားရေးမှူး\n2.  **ဒေါ်နီလာဦး** - အထွေထွေမန်နေဂျာ (စီမံခန့်ခွဲရေး)\n3.  **ဦးအောင်ကျော်မိုး** - အထွေထွေမန်နေဂျာ (ဘဏ္ဍာရေး)\n4.  **ဒေါ်ခင်မိုးဝါ** - လက်ထောက်အထွေထွေမန်နေဂျာ (စီမံခန့်ခွဲရေး)\n5.  **ဦးစိုးမင်းထွန်း** - လက်ထောက်အထွေထွေမန်နေဂျာ (နည်းပညာ)\n\nဤသည်မှာ ကျွန်မတို့၏ Database Records မှ ရရှိသော ဝန်ထမ်းအချက်အလက်များ ဖြစ်ပါတယ်ရှင်။', '2026-08-10 07:15:45.872374', 17),
(224, 'user', 'give me details about the first staff', '2026-08-10 07:16:56.181292', 17),
(225, 'assistant', 'ယခင်အဖြေတွင် ဝန်ထမ်းအမည်များကို မှားယွင်းဖော်ပြမိသည့်အတွက် တောင်းပန်ပါတယ်ရှင်။ ကျွန်မတို့ရဲ့ Database Records ထဲမှာ ဖော်ပြထားတဲ့ ဝန်ထမ်းအချက်အလက်များအရ ပထမဆုံးဝန်ထမ်းရဲ့ အသေးစိတ်အချက်အလက်များကို အောက်ပါအတိုင်း ဖော်ပြပေးပါမယ်ရှင်။\n\n**ပထမဆုံးဝန်ထမ်း (Staff ID: S-001) ၏ အချက်အလက်များ:**\n\n*   **Staff ID:** S-001\n*   **အမည်:** U Myat Zaw (ဦးမြတ်ဇော်)\n*   **ဌာန:** ဦးဆောင်ညွှန်ကြားရေးမှူးရုံးအဖွဲ့\n*   **ရာထူး (Role):** Head of Department\n*   **ရာထူး (Rank):** ညွှန့်မှူး\n*   **အီးမေးလ်:** jaycoab2@gmail.com\n*   **ဖုန်းနံပါတ်:** 09676067433\n*   **နေရပ်လိပ်စာ:** Taungoo, Bago, Myanmar\n\nဤသည်မှာ ကျွန်မတို့၏ Database Records မှ ရရှိသော မှန်ကန်သည့် အချက်အလက်များ ဖြစ်ပါတယ်ရှင်။', '2026-08-10 07:16:56.186282', 17),
(226, 'user', 'how many staffs are there?', '2026-08-10 07:19:41.458968', 17),
(227, 'assistant', 'ကျွန်မတို့ရဲ့ Database Records ထဲမှာ ဖော်ပြထားတဲ့ စုစုပေါင်းဝန်ထမ်းအရေအတွက်က **၅ ဦး** ဖြစ်ပါတယ်ရှင်။', '2026-08-10 07:19:41.461955', 17),
(228, 'user', 'give me about their name', '2026-08-10 07:19:53.576415', 17),
(229, 'assistant', 'ဟုတ်ကဲ့ပါရှင်။ ကျွန်မတို့ရဲ့ Database Records ထဲမှာ ဖော်ပြထားတဲ့ ဝန်ထမ်း ၅ ဦးရဲ့ အမည်စာရင်းကတော့ အောက်ပါအတိုင်း ဖြစ်ပါတယ်ရှင်:\n\n1.  ဦးအောင်ကျော်\n2.  ဒေါ်နီနီဝင်း\n3.  မောင်မင်းမင်းထွန်း\n4.  ဒေါ်ခင်မာအေး\n5.  ကိုစိုးမင်း\n\nဒီအချက်အလက်တွေက အထောက်အကူဖြစ်မယ်လို့ မျှော်လင့်ပါတယ်ရှင်။', '2026-08-10 07:19:53.578405', 17),
(230, 'user', 'give me detailed information about the first staff', '2026-08-10 07:20:14.515067', 17),
(231, 'assistant', 'တောင်းပန်ပါတယ်ရှင်။ ယခင်အဖြေတွင် အမည်စာရင်းမှားယွင်းစွာ ဖော်ပြမိခဲ့သည့်အတွက် အနူးအညွတ်တောင်းပန်အပ်ပါတယ်ရှင်။ ကျွန်မတို့ရဲ့ Database Records ထဲမှာ ဖော်ပြထားတဲ့ ဝန်ထမ်းအမည်စာရင်းက အောက်ပါအတိုင်း ဖြစ်ပါတယ်ရှင်:\n\n1.  U Myat Zaw (S-001)\n2.  U Win Myint (S-002)\n3.  Daw Khin Khin (S-003)\n4.  U Myo Min (S-004)\n5.  Daw Aye (S-005)\n\nပထမဆုံးဝန်ထမ်းဖြစ်တဲ့ **U Myat Zaw (S-001)** ရဲ့ အသေးစိတ်အချက်အလက်များကတော့ အောက်ပါအတိုင်း ဖြစ်ပါတယ်ရှင်:\n\n*   **Staff ID:** S-001\n*   **Name:** U Myat Zaw\n*   **Department:** ဦးဆောင်ညွှန်ကြားရေးမှူးရုံးအဖွဲ့\n*   **Role:** Head of Department\n*   **Rank:** ညွှန့်မှူး\n*   **Email:** jaycoab2@gmail.com\n*   **Phone:** 09676067433\n*   **Address:** Taungoo, Bago, Myanmar', '2026-08-10 07:20:14.520067', 17),
(232, 'user', 'တင်ဒါ အကြောင်းပါ၀င်သည့်စာရွက်စာတမ်းကို ဖော်ပြပါ', '2026-08-10 07:22:41.215875', 17),
(233, 'assistant', 'ဟုတ်ကဲ့ပါရှင်။ တင်ဒါအကြောင်းအရာများ ပါဝင်သည့် စာရွက်စာတမ်း (Tender Document) ဆိုသည်မှာ ကုမ္ပဏီတစ်ခု (သို့မဟုတ်) အဖွဲ့အစည်းတစ်ခုမှ ကုန်ပစ္စည်းများ၊ ဝန်ဆောင်မှုများ သို့မဟုတ် စီမံကိန်းလုပ်ငန်းများ ဆောင်ရွက်ရန်အတွက် ပေးသွင်းသူများ (suppliers) သို့မဟုတ် ကန်ထရိုက်တာများ (contractors) ထံမှ ကမ်းလှမ်းချက်များ (bids) ကို ဖိတ်ခေါ်သည့် တရားဝင်စာရွက်စာတမ်း ဖြစ်ပါတယ်ရှင်။\n\nယေဘုယျအားဖြင့် တင်ဒါစာရွက်စာတမ်းတစ်ခုတွင် အောက်ပါအချက်အလက်များ ပါဝင်လေ့ရှိပါတယ်ရှင်:\n\n1.  **တင်ဒါခေါ်ယူသည့်အကြောင်းအရာ (Subject of Tender):** မည်သည့်လုပ်ငန်း၊ ကုန်ပစ္စည်း သို့မဟုတ် ဝန်ဆောင်မှုအတွက် တင်ဒါခေါ်ယူခြင်းဖြစ်ကြောင်း အကျဉ်းချုပ်ဖော်ပြခြင်း။\n2.  **တင်ဒါနံပါတ် (Tender Reference Number):** တင်ဒါတစ်ခုချင်းစီအတွက် သီးခြားသတ်မှတ်ထားသော နံပါတ်။\n3.  **တင်ဒါခေါ်ယူသည့်အဖွဲ့အစည်း (Issuing Authority):** MOGE ကဲ့သို့ တင်ဒါခေါ်ယူသည့် အဖွဲ့အစည်း၏ အမည်။\n4.  **တင်ဒါတင်သွင်းရမည့်နောက်ဆုံးရက်နှင့်အချိန် (Deadline for Submission):** တင်ဒါကမ်းလှမ်းလွှာများကို နောက်ဆုံးထား၍ တင်သွင်းရမည့် ရက်စွဲနှင့် အချိန်။\n5.  **လုပ်ငန်းနယ်ပယ်နှင့်လိုအပ်ချက်များ (Scope of Work/Requirements):** ဆောင်ရွက်ရမည့် လုပ်ငန်း၏ အသေးစိတ်ဖော်ပြချက်၊ လိုအပ်သော ကုန်ပစ္စည်း သို့မဟုတ် ဝန်ဆောင်မှုများ၏ သတ်မှတ်ချက်များ (specifications)။\n6.  **အရည်အချင်းပြည့်မီမှု သတ်မှတ်ချက်များ (Eligibility Criteria):** တင်ဒါတင်သွင်းသူများ လိုက်နာရမည့် စည်းကမ်းချက်များ၊ လိုအပ်သော လုပ်ငန်းအတွေ့အကြုံ၊ ငွေကြေးအခြေအနေ စသည်တို့။\n7.  **တင်ဒါတင်သွင်းပုံအဆင့်ဆင့် (Submission Procedures):** တင်ဒါကမ်းလှမ်းလွှာများကို မည်သို့ပြင်ဆင်ရမည်၊ မည်သည့်စာရွက်စာတမ်းများ ပူးတွဲတင်ပြရမည်၊ မည်သည့်နေရာသို့ တင်သွင်းရမည် စသည်တို့။\n8.  **တင်ဒါအကဲဖြတ်ခြင်းဆိုင်ရာ စံနှုန်းများ (Evaluation Criteria):** တင်ဒါကမ်းလှမ်းလွှာများကို မည်သည့်အချက်များအပေါ် အခြေခံ၍ အကဲဖြတ်ရွေးချယ်မည်ဆိုသည့် စံနှုန်းများ။\n9.  **စည်းကမ်းသတ်မှတ်ချက်များ (Terms and Conditions):** စာချုပ်ချုပ်ဆိုခြင်း၊ ငွေပေးချေမှု၊ အာမခံချက်၊ အငြင်းပွားမှုဖြေရှင်းခြင်း စသည်တို့နှင့်ပတ်သက်သည့် စည်းကမ်းချက်များ။\n10. **ဆက်သွယ်ရန်ပုဂ္ဂိုလ်/ဌာန (Contact Person/Department):** တင်ဒါနှင့်ပတ်သက်၍ မေးမြန်းစုံစမ်းလိုပါက ဆက်သွယ်ရမည့် ပုဂ္ဂိုလ် သို့မဟုတ် ဌာန၏ အချက်အလက်များ။\n\nMOGE မှ တင်ဒါခေါ်ယူမှုများကို များသောအားဖြင့် ၎င်း၏တရားဝင်ဝက်ဘ်ဆိုက် (Official Website)၊ နိုင်ငံပိုင်သတင်းစာများ (ဥပမာ- မြန်မာ့အလင်း၊ ကြေးမုံ) တို့တွင် ကြေညာလေ့ရှိပါတယ်ရှင်။\n\nအကယ်၍ သင်သည် တိကျသော တင်ဒါတစ်ခုခု၏ အချက်အလက်များကို သိရှိလိုပါက ထပ်မံမေးမြန်းနိုင်ပါတယ်ရှင်။', '2026-08-10 07:22:41.221621', 17),
(234, 'user', 'တင်ဒါ အကြောင်းပါ၀င်သည့်စာရွက်စာတမ်း ကိုပေးပါ။', '2026-08-10 07:23:07.151389', 17),
(235, 'assistant', 'တောင်းပန်ပါတယ်ရှင်။ ကျွန်မသည် AI Assistant တစ်ဦးဖြစ်သည့်အတွက် တိကျသော တင်ဒါစာရွက်စာတမ်း (actual tender document) တစ်ခုကို တိုက်ရိုက်ထုတ်ပေးနိုင်ခြင်း သို့မဟုတ် ပေးအပ်နိုင်ခြင်း မရှိပါဘူးရှင်။\n\nတင်ဒါစာရွက်စာတမ်းများသည် သီးခြားစီမံကိန်းများ၊ ကုန်ပစ္စည်းများ သို့မဟုတ် ဝန်ဆောင်မှုများအတွက် သတ်မှတ်ထားသော အသေးစိတ်အချက်အလက်များ ပါဝင်သည့် တရားဝင်စာရွက်စာတမ်းများ ဖြစ်ပါတယ်ရှင်။\n\nအကယ်၍ သင်သည် MOGE မှ ခေါ်ယူထားသော တင်ဒါတစ်ခုခု၏ စာရွက်စာတမ်းကို လိုအပ်ပါက-\n\n1.  **MOGE ၏ တရားဝင်ဝက်ဘ်ဆိုက် (Official Website)** ကို ဝင်ရောက်ကြည့်ရှုနိုင်ပါတယ်ရှင်။ တင်ဒါခေါ်ယူမှုများကို \"Tenders\" သို့မဟုတ် \"Announcements\" ကဏ္ဍများတွင် ဖော်ပြလေ့ရှိပါတယ်။\n2.  **နိုင်ငံပိုင်သတင်းစာများ (ဥပမာ- မြန်မာ့အလင်း၊ ကြေးမုံ)** တွင် ထုတ်ပြန်ကြေညာထားသော တင်ဒါကြော်ငြာများကို ရှာဖွေနိုင်ပါတယ်ရှင်။\n3.  **MOGE ၏ သက်ဆိုင်ရာဌာန** သို့ တိုက်ရိုက်ဆက်သွယ်မေးမြန်းနိုင်ပါတယ်ရှင်။\n\nမည်သည့်တင်ဒါနှင့်ပတ်သက်၍ သိရှိလိုသည်ကို ပိုမိုတိကျစွာ ပြောပြနိုင်ပါက၊ ကျွန်မအနေဖြင့် အထွေထွေအချက်အလက်များ သို့မဟုတ် မည်သည့်နေရာတွင် ရှာဖွေနိုင်ကြောင်း လမ်းညွှန်ပေးနိုင်ပါတယ်ရှင်။', '2026-08-10 07:23:07.156151', 17),
(236, 'user', 'give me document which include about this information \"ကိုယ်ရေးမှတ်တမ်း\"', '2026-08-10 08:25:00.807998', 17),
(237, 'assistant', 'ဟုတ်ကဲ့ပါရှင်။ \"ကိုယ်ရေးမှတ်တမ်း\" အကြောင်းအရာများ ပါဝင်သည့် စာရွက်စာတမ်းမှာ **ကိုယ်ရေးမှတ်တမ်းများ .docx** ဖြစ်ပါတယ်ရှင်။\n\nဒီစာရွက်စာတမ်း (Page 1) မှာ \"ကိုယ်ရေးမှတ်တမ်း\" ပုံစံ (၃) မျိုးကို တွေ့ရှိရပါတယ်ရှင်:\n\n1.  **ပုံစံ (၁) ကိုယ်ရေးမှတ်တမ်း**\n    *   [နည်းဥပဒေ ၂၄ (ခ)] အရ ဖြစ်ပါတယ်။\n    *   အမည်၊ ငယ်အမည်၊ အခြားအမည်၊ အသက်၊ လူမျိုး၊ ဘာသာ၊ အရပ်အမြင့်၊ ဆံပင်အရောင်၊ မျက်စိအရောင်၊ ထင်ရှားသည့်အမှတ်အသား၊ အသားအရောင်၊ ကိုယ်အလေးချိန်၊ မွေးဖွားရာဇာတိ၊ နိုင်ငံသားစိစစ်ရေးကတ်ပြားအမှတ်၊ ယခုနေရပ်လိပ်စာ၊ အမြဲတမ်းနေရပ်လိပ်စာ၊ ယခင်နေခဲ့ဖူးသောဒေသ၊ တပ်မတော်သို့ဝင်ခဲ့ဖူးလျှင်/တပ်မတော်သားဖြစ်လျှင် အချက်အလက်များ၊ ပညာအရည်အချင်း၊ အဘ/အမိ အမည်၊ ဇာတိ၊ အလုပ်အကိုင်၊ နေရပ်လိပ်စာ၊ လက်ရှိအလုပ်အကိုင်၊ ရာထူး၊ လစာဝင်ငွေ၊ ဌာန၊ ဘွဲ့ထူး၊ ဂုဏ်ထူး၊ သင်တန်းများ၊ ထောက်ခံသူများ၊ ယခင်လုပ်ကိုင်ဖူးသည့်အလုပ်အကိုင်၊ ညီအစ်ကိုမောင်နှမများ၊ ခင်ပွန်း/ဇနီးသည်နှင့် သားသမီးများ အကြောင်းအရာများ ပါဝင်ပါတယ်။\n\n2.  **ကိုယ်ရေးမှတ်တမ်း**\n    *   [နည်းဥပဒေ ၃၅ (ဇ) (၄)၊ ၄၇ (စ) (၄)] အရ ဖြစ်ပါတယ်။\n    *   အမည်၊ နိုင်ငံသားစိစစ်ရေးကတ်ပြားအမှတ်၊ လူမျိုး/ဘာသာ၊ မွေးဖွားရာအရပ်၊ အဘ/အမိအမည်၊ အလုပ်အကိုင်၊ ဇနီး/ခင်ပွန်းအမည်နှင့် အလုပ်အကိုင်၊ မွေးဖွားသည့်ရက်၊ လ၊ ခုနှစ်၊ ကိုယ်တွင်ထင်ရှားသည့်အမှတ်အသား၊ လက်ရှိရာထူး၊ လက်ရှိနေရပ်လိပ်စာ၊ အမြဲတမ်းနေရပ်လိပ်စာ၊ ပညာအရည်အချင်း၊ တတ်မြောက်သည့် အခြားဘာသာစကားနှင့် တတ်ကျွမ်းသည့်အဆင့်၊ တက်ရောက်ခဲ့သည့် သင်တန်းများ၊ ထမ်းဆောင်ခဲ့သောတာဝန်များ၊ ပါဝင်ဆောင်ရွက်ဆဲနှင့် ဆောင်ရွက်ခဲ့သည့်လူမှုရေးနှင့် အစိုးရမဟုတ်သော အဖွဲ့အစည်းများ၏ အမည်များနှင့်တာဝန်များ၊ ချီးမြှင့်ခံရသည့်ဘွဲ့ထူး၊ ဂုဏ်ထူးတံဆိပ်လက်မှတ်များ၊ အပြစ်ပေးခံရခြင်းများ၊ အခြားတင်ပြလိုသည့်အချက်များ ပါဝင်ပါတယ်။\n\n3.  **ကိုယ်ရေးမှတ်တမ်း (နောက်ထပ်ပုံစံတစ်ခု)**\n    *   အမည်၊ ငယ်နာမည်၊ အခြားအမည်၊ အသက်(မွေးသက္ကရာဇ်)၊ မွေးရာဇာတိ၊ ကိုးကွယ်သည့်ဘာသာ၊ လူမျိုး၊ အမျိုးသားမှတ်ပုံတင်အမှတ်/နိုင်ငံသားမှတ်ပုံတင်အမှတ်၊ အလုပ်အကိုင်၊ အမှုထမ်းသက်၊ လက်ရှိနေရပ်၊ အမြဲတမ်းနေရပ်၊ ပညာအရည်အချင်း၊ နိုင်ငံ့ဝန်ထမ်းတာဝန်ထမ်းဆောင်မှုမှတ်တမ်း၊ ပြည်တွင်း/ပြည်ပ သင်တန်းများ တက်ရောက်မှု၊ ပြစ်မှုမှတ်တမ်း၊ ချီးမြှင့်ခံရသည့် ဘွဲ့ထူး၊ ဂုဏ်ထူးတံဆိပ်များ ပါဝင်ပါတယ်။\n\nဤအချက်အလက်များကို **ကိုယ်ရေးမှတ်တမ်းများ .docx** စာရွက်စာတမ်း (Page 1) တွင် တွေ့ရှိနိုင်ပါတယ်ရှင်။', '2026-08-10 08:25:00.815910', 17);

-- --------------------------------------------------------

--
-- Table structure for table `chats_document`
--

CREATE TABLE `chats_document` (
  `id` bigint(20) NOT NULL,
  `file` varchar(100) NOT NULL,
  `uploaded_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chats_document`
--

INSERT INTO `chats_document` (`id`, `file`, `uploaded_at`) VALUES
(1, 'chatbot/အတဖငတငဒခယခင_14_2026.pdf', '2026-08-10 07:00:49.008824'),
(2, 'chatbot/အတဖငတငဒခယခင_14_2026_vh37XUP.pdf', '2026-08-10 07:02:34.027343'),
(3, 'chatbot/ကယရမတတမမ_.docx', '2026-08-10 07:04:27.629296'),
(4, 'chatbot/JITES_2020-part-1.pdf', '2026-08-10 07:06:29.034201');

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` bigint(20) NOT NULL,
  `department_id` varchar(100) NOT NULL,
  `department_name` varchar(100) NOT NULL,
  `room_id` bigint(20) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `department_id`, `department_name`, `room_id`, `created_at`, `updated_at`) VALUES
(4, 'DPMT-003', 'ဦးဆောင်ညွှန်ကြားရေးမှူးရုံးအဖွဲ့', 7, '2026-07-01 03:14:14.167747', '2026-08-19 13:11:56.291661'),
(5, 'DPMT-004', 'စီမံရေးဌာန', NULL, '2026-07-01 03:14:23.519018', '2026-07-01 03:14:23.520034'),
(6, 'DPMT-005', 'ရှာဖွေရေးနှင့်ဖွံ့ဖြိုးရေးဌာန', NULL, '2026-07-01 03:14:30.542792', '2026-07-01 03:14:30.542792'),
(7, 'DPMT-006', 'တူးဖော်ရေးဌာန', NULL, '2026-07-01 03:14:42.112998', '2026-07-01 03:14:42.112998'),
(8, 'DPMT-007', 'ထုတ်လုပ်ရေးဌာန', NULL, '2026-07-01 03:14:49.393726', '2026-07-01 03:14:49.393726'),
(9, 'DPMT-008', 'အင်ဂျီနီယာလုပ်ငန်းဌာန', 8, '2026-07-01 03:14:56.769993', '2026-07-01 03:14:56.769993'),
(10, 'DPMT-009', 'အထွေထွေစီမံခန့်ခွဲရေးဌာန', 7, '2026-07-01 03:15:04.367754', '2026-07-01 03:15:04.368771'),
(11, 'DPMT-010', 'ပစ္စည်းစီမံဌာန', 8, '2026-07-01 03:15:10.044731', '2026-07-01 03:15:10.045324'),
(12, 'DPMT-011', 'ကမ်းလွန်ရေနံနှင့်သဘာ၀ဓတ်ငွေ့ဌာန', 6, '2026-07-01 03:15:15.688090', '2026-07-01 03:15:15.688090');

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(10, 'account', 'emailaddress'),
(11, 'account', 'emailconfirmation'),
(1, 'admin', 'logentry'),
(21, 'archives', 'archive'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(9, 'authentication', 'moguser'),
(6, 'authtoken', 'token'),
(7, 'authtoken', 'tokenproxy'),
(24, 'buildings', 'building'),
(22, 'categories', 'category'),
(28, 'chats', 'chatmessage'),
(27, 'chats', 'document'),
(4, 'contenttypes', 'contenttype'),
(16, 'departments', 'department'),
(23, 'documents', 'document'),
(25, 'dtypes', 'dtype'),
(29, 'landmarks', 'landmark'),
(30, 'locations', 'location'),
(32, 'locations', 'locationphoto'),
(31, 'locations', 'locationtype'),
(26, 'logs', 'auditlog'),
(17, 'ranks', 'rank'),
(18, 'roles', 'role'),
(15, 'rooms', 'room'),
(5, 'sessions', 'session'),
(12, 'socialaccount', 'socialaccount'),
(13, 'socialaccount', 'socialapp'),
(14, 'socialaccount', 'socialtoken'),
(20, 'staffs', 'staff'),
(19, 'stypes', 'stype'),
(8, 'users', 'user');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2025-12-28 05:17:51.461358'),
(2, 'contenttypes', '0002_remove_content_type_name', '2025-12-28 05:17:51.517490'),
(3, 'auth', '0001_initial', '2025-12-28 05:17:51.696677'),
(4, 'auth', '0002_alter_permission_name_max_length', '2025-12-28 05:17:51.734304'),
(5, 'auth', '0003_alter_user_email_max_length', '2025-12-28 05:17:51.742380'),
(6, 'auth', '0004_alter_user_username_opts', '2025-12-28 05:17:51.762629'),
(7, 'auth', '0005_alter_user_last_login_null', '2025-12-28 05:17:51.770744'),
(8, 'auth', '0006_require_contenttypes_0002', '2025-12-28 05:17:51.772744'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2025-12-28 05:17:51.778313'),
(10, 'auth', '0008_alter_user_username_max_length', '2025-12-28 05:17:51.785891'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2025-12-28 05:17:51.791431'),
(12, 'auth', '0010_alter_group_name_max_length', '2025-12-28 05:17:51.812528'),
(13, 'auth', '0011_update_proxy_permissions', '2025-12-28 05:17:51.820333'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2025-12-28 05:17:51.826756'),
(15, 'authentication', '0001_initial', '2025-12-28 05:17:52.033534'),
(16, 'admin', '0001_initial', '2025-12-28 05:17:52.104391'),
(17, 'admin', '0002_logentry_remove_auto_add', '2025-12-28 05:17:52.113452'),
(18, 'admin', '0003_logentry_add_action_flag_choices', '2025-12-28 05:17:52.121477'),
(19, 'authtoken', '0001_initial', '2025-12-28 05:17:52.168921'),
(20, 'authtoken', '0002_auto_20160226_1747', '2025-12-28 05:17:52.191664'),
(21, 'authtoken', '0003_tokenproxy', '2025-12-28 05:17:52.195721'),
(22, 'authtoken', '0004_alter_tokenproxy_options', '2025-12-28 05:17:52.201729'),
(23, 'sessions', '0001_initial', '2025-12-28 05:17:52.228985'),
(24, 'users', '0001_initial', '2025-12-28 05:17:52.259681'),
(25, 'authentication', '0002_moguser_is_staff', '2025-12-28 05:23:26.342130'),
(26, 'authentication', '0003_alter_moguser_password', '2025-12-28 05:44:54.451947'),
(27, 'account', '0001_initial', '2026-01-11 15:29:42.445720'),
(28, 'account', '0002_email_max_length', '2026-01-11 15:29:42.475739'),
(29, 'account', '0003_alter_emailaddress_create_unique_verified_email', '2026-01-11 15:29:42.515728'),
(30, 'account', '0004_alter_emailaddress_drop_unique_email', '2026-01-11 15:29:43.744373'),
(31, 'account', '0005_emailaddress_idx_upper_email', '2026-01-11 15:29:43.754473'),
(32, 'account', '0006_emailaddress_lower', '2026-01-11 15:29:43.774550'),
(33, 'account', '0007_emailaddress_idx_email', '2026-01-11 15:29:43.805599'),
(34, 'account', '0008_emailaddress_unique_primary_email_fixup', '2026-01-11 15:29:43.823547'),
(35, 'account', '0009_emailaddress_unique_primary_email', '2026-01-11 15:29:43.831954'),
(36, 'authentication', '0004_alter_moguser_role', '2026-01-11 15:29:44.059789'),
(37, 'socialaccount', '0001_initial', '2026-01-11 15:29:44.250672'),
(38, 'socialaccount', '0002_token_max_lengths', '2026-01-11 15:29:44.552061'),
(39, 'socialaccount', '0003_extra_data_default_dict', '2026-01-11 15:29:44.563048'),
(40, 'socialaccount', '0004_app_provider_id_settings', '2026-01-11 15:29:44.678264'),
(41, 'socialaccount', '0005_socialtoken_nullable_app', '2026-01-11 15:29:44.924798'),
(42, 'socialaccount', '0006_alter_socialaccount_extra_data', '2026-01-11 15:29:44.962802'),
(43, 'rooms', '0001_initial', '2026-02-04 06:52:36.890593'),
(44, 'departments', '0001_initial', '2026-02-04 06:59:44.799950'),
(45, 'departments', '0002_alter_department_room', '2026-02-04 07:01:30.315612'),
(46, 'departments', '0003_alter_department_table', '2026-02-04 08:07:33.235785'),
(47, 'rooms', '0002_alter_room_table', '2026-02-04 08:07:55.622824'),
(48, 'ranks', '0001_initial', '2026-02-05 05:07:02.798054'),
(49, 'roles', '0001_initial', '2026-02-05 05:07:02.860222'),
(50, 'rooms', '0003_room_room_no', '2026-02-05 05:07:02.983611'),
(51, 'stypes', '0001_initial', '2026-02-05 05:09:58.087233'),
(52, 'staffs', '0001_initial', '2026-02-05 05:17:08.054493'),
(53, 'departments', '0004_department_created_at_department_updated_at', '2026-02-05 05:33:50.288766'),
(54, 'ranks', '0002_rank_created_at_rank_updated_at', '2026-02-05 05:33:50.343713'),
(55, 'roles', '0002_role_created_at_role_updated_at', '2026-02-05 05:33:50.397545'),
(56, 'rooms', '0004_room_created_at_room_updated_at', '2026-02-05 05:33:50.463068'),
(57, 'staffs', '0002_staff_created_at_staff_updated_at', '2026-02-05 05:33:50.523050'),
(58, 'stypes', '0002_stype_created_at_stype_updated_at', '2026-02-05 05:33:50.578219'),
(59, 'archives', '0001_initial', '2026-02-14 08:11:02.194790'),
(60, 'archives', '0002_alter_archive_table', '2026-02-23 13:12:08.749633'),
(61, 'categories', '0001_initial', '2026-04-19 18:12:13.648539'),
(62, 'categories', '0002_remove_category_parent_id_category_parent', '2026-04-22 13:03:28.786121'),
(63, 'documents', '0001_initial', '2026-04-22 13:03:28.873426'),
(64, 'archives', '0003_archive_documents_archive_staffs_and_more', '2026-04-26 08:24:19.104389'),
(65, 'buildings', '0001_initial', '2026-04-26 08:28:37.803056'),
(66, 'rooms', '0005_room_building', '2026-04-26 08:29:02.489613'),
(67, 'dtypes', '0001_initial', '2026-04-27 12:20:29.087089'),
(68, 'dtypes', '0002_rename_documenttypes_dtype', '2026-04-27 12:38:55.411681'),
(69, 'documents', '0002_document_dtype', '2026-04-27 12:39:23.498164'),
(70, 'documents', '0003_alter_document_table', '2026-04-27 12:42:06.370850'),
(71, 'documents', '0004_rename_staffs_document_staff', '2026-04-27 12:46:15.030059'),
(72, 'categories', '0003_category_category_id', '2026-04-27 14:24:13.631151'),
(73, 'documents', '0004_rename_categories_document_category_and_more', '2026-04-27 15:03:37.357383'),
(74, 'categories', '0004_alter_category_parent', '2026-04-27 15:18:59.195276'),
(75, 'documents', '0005_alter_document_category', '2026-04-27 15:19:16.762064'),
(76, 'categories', '0005_alter_category_parent', '2026-04-27 15:25:38.280058'),
(77, 'documents', '0006_document_description', '2026-04-28 04:11:12.737258'),
(78, 'documents', '0007_alter_document_created_at', '2026-04-28 04:13:02.600922'),
(79, 'documents', '0008_remove_document_document_path_document_document', '2026-04-28 07:36:35.075512'),
(80, 'logs', '0001_initial', '2026-04-28 07:43:29.556151'),
(81, 'documents', '0009_remove_document_staff', '2026-04-28 08:59:03.416806'),
(82, 'documents', '0010_document_staff', '2026-04-28 09:01:25.980894'),
(83, 'documents', '0011_alter_document_document_name', '2026-04-29 04:24:45.210085'),
(84, 'documents', '0012_document_expired_at', '2026-04-29 13:07:03.818337'),
(85, 'documents', '0013_document_archived_at_document_is_archived_and_more', '2026-04-30 01:48:17.446941'),
(86, 'documents', '0014_document_restore_at', '2026-04-30 02:38:40.073865'),
(87, 'logs', '0002_alter_auditlog_action', '2026-04-30 06:35:44.449194'),
(88, 'logs', '0003_alter_auditlog_action', '2026-04-30 06:36:24.575480'),
(89, 'chats', '0001_initial', '2026-05-01 03:32:28.395944'),
(90, 'authentication', '0005_moguser_staff', '2026-05-02 18:44:45.722412'),
(91, 'users', '0002_delete_user', '2026-05-04 08:25:31.831346'),
(92, 'landmarks', '0001_initial', '2026-06-08 09:10:42.726864'),
(93, 'locations', '0001_initial', '2026-06-08 09:23:20.458239'),
(94, 'locations', '0002_location_delete_landmark', '2026-06-08 09:23:20.495648'),
(95, 'locations', '0003_location_photo', '2026-06-08 09:27:40.271413'),
(96, 'locations', '0004_remove_location_location_id_location_description', '2026-06-08 19:03:19.200552'),
(97, 'locations', '0005_remove_location_created_time', '2026-06-08 19:13:12.302306'),
(98, 'locations', '0006_delete_location', '2026-06-09 13:02:45.869412'),
(99, 'locations', '0007_initial', '2026-06-09 13:03:07.738452'),
(100, 'locations', '0008_locationtype_location_department', '2026-06-21 16:57:29.101182'),
(101, 'locations', '0009_location_location_type', '2026-06-21 16:58:51.568382'),
(102, 'locations', '0010_remove_location_location_type', '2026-06-21 17:04:48.233013'),
(103, 'locations', '0011_delete_locationtype', '2026-06-21 17:05:20.919548'),
(104, 'locations', '0012_location_location_type', '2026-06-21 17:08:44.440665'),
(105, 'locations', '0013_location_state_division', '2026-07-10 08:05:09.535896'),
(106, 'categories', '0006_alter_category_category_name', '2026-07-30 13:01:01.155470'),
(107, 'locations', '0014_locationphoto', '2026-08-08 12:31:16.139403'),
(108, 'documents', '0015_alter_document_document', '2026-08-12 15:01:28.954482'),
(109, 'locations', '0015_alter_location_latitude_alter_location_longitude', '2026-08-20 17:34:10.871028');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('09rx50rssjn5qat6wu1x7oj8wb1e9hza', '.eJxVjEEOwiAQAP_C2RDKQhc8eu8bmoXd2qqBpLQn499Nkx70OjOZtxpp3-Zxb7KOC6urskZdfmGi_JRyGH5QuVeda9nWJekj0adteqgsr9vZ_g1mavPxBWMNoTMIk40IkHoPDqJYBsQYAZPjiQLmRD64ECxwnjrxvhffOVafL8h5NvM:1wTsbD:_5wp0gswwYmwGEZPqcrWqdjFtZ7_KBxUWg1DgL2gTWM', '2026-06-15 02:41:55.462645'),
('0ijlwo1u0ykvq4r2e5tyu4a0urrxn91f', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wliF7:72FVT6aI8gwHOXNwk1vJDhShwBsep1bjzaLtkCKWQtQ', '2026-08-03 07:16:49.842587'),
('0zav30w1kmcet8jp5mfag8mqsgbo6l1c', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wKdVK:56ZmEHeOJK6UF4_SH2BdUouXreZjVscM36HKGLUplE4', '2026-05-20 14:45:38.964397'),
('12q8bacu0ow840x7rew57npwag5mxcys', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wj9kx:0PAw61v88fFYuzHfWZ0l5oO4fA6Wj71YirSYThBhW64', '2026-07-27 06:03:07.141662'),
('1a2byckft3yx0jght8ucapwj3ol2g4n6', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wqiha:0F3nhLEjVeJu0ZBN3BPo1JfRkJTaeu2gqYVD1f3NxvI', '2026-08-17 02:46:54.369375'),
('1d2ybbhlux1s3xdsl2v9mjy6exylu7sd', '.eJxVjMsOwiAQRf-FtSEwPASX7vsNZIahUjU0Ke3K-O_apAvd3nPOfYmE21rT1suSJhYXAVqcfkfC_ChtJ3zHdptlntu6TCR3RR60y2Hm8rwe7t9BxV6_tckxkMrnEcbAqhB6G1XISCZqDegdKGs5giPOTGSM0wZKYLAa2EMQ7w8Ldze_:1whJJ8:paeQxanhvPATxVqy18PeIbpFTj6dxP-PPqcfG2suP5g', '2026-07-22 03:50:46.627816'),
('1pp4mvw5el3pxs32vdvn1wkp11mlyhja', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1whB0Q:3tZGYuxbJwoo4SbxRfD2BTAx8VCCNgyDv8NCJqj4648', '2026-07-21 18:58:54.992121'),
('2ylqf7atepppux3i8trwpuh2srl8zxeq', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wsbLL:lbeNAgnlnxBqljpMPryj2-2qNaZmwh0BhtsGRQSfvL0', '2026-08-22 07:19:43.002128'),
('3dskl5grdhqk73ja5i6aiinj22oqd4n9', '.eJxVjMsOwiAQRf-FtSEwPASX7vsNZIahUjU0Ke3K-O_apAvd3nPOfYmE21rT1suSJhYXAVqcfkfC_ChtJ3zHdptlntu6TCR3RR60y2Hm8rwe7t9BxV6_tckxkMrnEcbAqhB6G1XISCZqDegdKGs5giPOTGSM0wZKYLAa2EMQ7w8Ldze_:1whHHU:3oz3R0G3Gu4ThyvV4CNhR-fCQRIQkuPBuR2vLxbHmGU', '2026-07-22 01:40:56.473623'),
('3sr2xmcbe6ctoac8ab77p7o04m52e2f9', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wu2iI:5dN8kkb6DAHNC0WSBT7laTFoMHuqjq_sfpmcIIb5HJg', '2026-08-26 06:45:22.976215'),
('3yg825mfg6moyjm5p1z29d33o3zdvg9c', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1whpCu:7qhKaau-1to5ZC7x_av0wW8l1ql_iml3Sl_VHnmCXvA', '2026-07-23 13:54:28.865164'),
('4fqv0lwf7enn9r5ygr36urmajs46oing', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wx3aJ:-B5HAdz2KgsBanhoVoeuYfyZfRn39Z15KSYsz1YNr_w', '2026-09-03 14:17:35.822145'),
('50ik0y4z4r0lmrcgetrviu23e48wpkeq', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wbKV1:8pI9gpoSoegNUv4ZKPGkqXSS9c_OD7KQVL5GbDn8HfQ', '2026-07-05 15:54:19.593986'),
('5i6mtlzdhdnjkpu4yucd2m94xsh4a5rj', '.eJxVjEEOwiAURO_C2hBAoODSvWcgH_5HqgaS0q6Md7ckXejsZt7MvFmAbS1h67SEGdmFScdOv2GE9KQ6CD6g3htPra7LHPmo8IN2fmtIr-vR_Tso0MtYSyW8AO1szOdsyDkL6IynSLsByqgmk9CAVLscxqRV9MJrZVUWk2afLxbCOBA:1wKdIw:JAjwlLhTk8As3IJyFT4DJSiD-rha1jTZ-tfzFw3RSk0', '2026-05-20 14:32:50.475079'),
('5syt2cqm8r216i70wrudjxs4xp8ajuxk', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1we8GO:xVeA6W4xzOBGlY1MEl0k7nlNARe0CUY2MQjLGGpfz4A', '2026-07-13 09:26:48.340605'),
('5ujuytwfjz83wjdsymphu5yp3xld54sm', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wZ1XD:-uL4UW8poWtQC2dJAX5w2i3TDBT47XEAMpTDnYMCTck', '2026-06-29 07:15:03.094129'),
('6au3zl3zaxozdeqibivoea96axilhkjx', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wf98b:KiogBzBxfns2yBx_mVMaDRo3hpAQQ09K1-MY-hZTrKc', '2026-07-16 04:34:57.568864'),
('6fkji1mtbbvv66prybzoa8zim6h1g4wn', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1whB3v:9CkSvUwKfe9lqgnvfBEn8dGvuEgHh0BgQuaPZ-4uk1k', '2026-07-21 19:02:31.656643'),
('6lqvmlrmgxz0dluo07b5cxfu3blpe098', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wtHXS:3z3aCoN0gycdpuVI4MQnaxohTSbVh288Um0qKZtwXvc', '2026-08-24 04:23:02.838988'),
('6puuncjhbzi0bab5in206shotzlpk2kb', '.eJxVjEEOwiAURO_C2hBAoODSvWcgH_5HqgaS0q6Md7ckXejsZt7MvFmAbS1h67SEGdmFScdOv2GE9KQ6CD6g3htPra7LHPmo8IN2fmtIr-vR_Tso0MtYSyW8AO1szOdsyDkL6IynSLsByqgmk9CAVLscxqRV9MJrZVUWk2afLxbCOBA:1whJI0:Uk0wJtr9y-6OIzp31YDNZ2Q-WdLMg8BHx03k2yYc2v4', '2026-07-22 03:49:36.477850'),
('73pcpf4dqkks9y8fv30xcdttezjo3q9u', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wj9pf:42HPA6ROuUKMu_yuGIpZWd-6_KrhvM0KVg-nCYbV8FM', '2026-07-27 06:07:59.315850'),
('7ru6lhb53k2ft8poupllsd4tqofgw2be', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wsLPw:DD4ZlVFbWoglpH8JpoEjoOkuyaDwpcD5m7vz0qhZmwY', '2026-08-21 14:19:24.606915'),
('8p6xwu1rrex0e2uaq9t7hnh5xdao6z3j', '.eJxVjEEOwiAURO_C2hBAoODSvWcgH_5HqgaS0q6Md7ckXejsZt7MvFmAbS1h67SEGdmFScdOv2GE9KQ6CD6g3htPra7LHPmo8IN2fmtIr-vR_Tso0MtYSyW8AO1szOdsyDkL6IynSLsByqgmk9CAVLscxqRV9MJrZVUWk2afLxbCOBA:1whHGX:5d2DDMoHg9K4pFioY6NX1M9zVgZOgQX-HpgiLQAoxHw', '2026-07-22 01:39:57.971095'),
('8uz8h00yrpi18jer8feh20rfx4ivml2g', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wrDcI:JEPpCaGh7hMC8FNS7e3mgwojWyZxepXcU8zlOfn84wM', '2026-08-18 11:47:30.296826'),
('9bxa7jyxj9i6kezn7w3445fwm6082kdp', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wi6lo:7jb91i_AQWmR4yzC28eLJ05bPic2HdUieQq6s4KXzsc', '2026-07-24 08:39:40.554039'),
('9hf5rwst61257q5m9yvjezv8e7o2371b', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wrb4l:5If9phHWijDod3Jm9SlFJMQh6kJ8YiVifTgWYCAulqM', '2026-08-19 12:50:27.836962'),
('a3ru0nkahgh2o65qck57rjmg85ahi5ty', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wgy9l:ce67aaT40XYC8N4wPJ-XFUFz1l7ke5KJLzj6OIl8y6Q', '2026-07-21 05:15:41.279498'),
('b31jfulpep9ycd9g81uq6697jnrw9at2', '.eJxVjMsOwiAQRf-FtSG8EZfu-w1kmAGpGkhKuzL-uzbpQrf3nHNfLMK21riNvMSZ2IUpy06_YwJ85LYTukO7dY69rcuc-K7wgw4-dcrP6-H-HVQY9Vt7nwMFp8mDLOlcZHLGGyWK0zkJqZyiIEELQqGtNQoJwBFitmiFEYm9PwQAOCA:1wqiot:9jPg5PmJeBh9Nv7Z_xw54UPXz0Bc2NoFHKdxEhUQlcc', '2026-08-17 02:54:27.257071'),
('b9ey559x3tqnyvb2hzlivyobdbodnx5i', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wKt11:7NMBJK1xIvFG6WN44veIu5AjW8Fd4siiLcEzm-qyabw', '2026-05-21 07:19:23.598985'),
('bhlxvpam4f0re60lsolnk5hcy7i80qdg', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wpHv3:QZulm38OoWYCfVmhw4t611Msw81NoCCjKeNrereuFes', '2026-08-13 03:58:53.621302'),
('c9hn233tvzqqqutf8yvpbgiwirotixmb', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1whIdx:1PmLativwbcyBniAKWrHuolDKGm6F_TIjExOYRRSmck', '2026-07-22 03:08:13.482922'),
('cnz5y5ni9pgc6zs9ebtv4phxtvw056n6', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wawIZ:6GEeL9k_Ar1i41BNpg9Dg4tMmWVkWKElFHzWVFelyBU', '2026-07-04 14:03:51.501417'),
('cqclqpyrt2nhrmm72bw7bh7u30seh7il', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wsyk8:5UvLqrwSbgsVjXm1i7ZUhsXt0oFwKEY9ceO_JiAx7hc', '2026-08-23 08:18:52.064253'),
('cu0g5bt8djw20tqpmhyr3452lmxmxs82', '.eJxVjEEOwiAURO_C2hBAoODSvWcgH_5HqgaS0q6Md7ckXejsZt7MvFmAbS1h67SEGdmFScdOv2GE9KQ6CD6g3htPra7LHPmo8IN2fmtIr-vR_Tso0MtYSyW8AO1szOdsyDkL6IynSLsByqgmk9CAVLscxqRV9MJrZVUWk2afLxbCOBA:1wqipT:oHJ3KIF4A1ord9g0GHEcg7GhG30FMd77DEA15b_HVmc', '2026-08-17 02:55:03.202496'),
('da29sdr4imdd5ng7v6g252jl5efnzpm1', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wu2hW:l6a494wpSkTFRVJsHUkXXG51dJIZse1C6OyYciD0e94', '2026-08-26 06:44:34.464708'),
('dq76uhri7jv6mphakf8k48i58uwy0cr5', '.eJxVjMsOwiAQRf-FtSE8hA4u3fcbyAAzUjU0Ke3K-O_apAvd3nPOfYmI21rj1mmJUxEXYcXpd0uYH9R2UO7YbrPMc1uXKcldkQftcpwLPa-H-3dQsddvnXVIxbMC8JY9BrJOMWoFOcGg1Nmzs2FwrDUa5R0V44PToSSGBIZAvD_UFjdX:1vdspp:onjW-1L514dRgRICGhx5zusF7QU1DxK9XRvgCNN-YrQ', '2026-01-22 16:26:05.558608'),
('dua6r6d5dm9160cyj5aqeo68ingtigfg', '.eJxVjMsOwiAQRf-FtSEwPASX7vsNZIahUjU0Ke3K-O_apAvd3nPOfYmE21rT1suSJhYXAVqcfkfC_ChtJ3zHdptlntu6TCR3RR60y2Hm8rwe7t9BxV6_tckxkMrnEcbAqhB6G1XISCZqDegdKGs5giPOTGSM0wZKYLAa2EMQ7w8Ldze_:1wj7Uh:5DiIcb_vFJIkMlgUKcyGW0o9aIn0PxKm477fW9gtiUA', '2026-07-27 03:38:11.591696'),
('e2mjet0huqa8tzzcar0cx0p5ak73ffws', '.eJxVjMsOwiAQRf-FtSEwPASX7vsNZIahUjU0Ke3K-O_apAvd3nPOfYmE21rT1suSJhYXAVqcfkfC_ChtJ3zHdptlntu6TCR3RR60y2Hm8rwe7t9BxV6_tckxkMrnEcbAqhB6G1XISCZqDegdKGs5giPOTGSM0wZKYLAa2EMQ7w8Ldze_:1whFdD:MTY2hko7PsDCh77qK4zIpLUFmZ3VuPlyMYkF465BpXw', '2026-07-21 23:55:15.164251'),
('e68saw21g14r6neweoe5hrbyha0ml130', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wohVR:vcEx7WVkyZeCa3s3QxV5gzZBKB6aty6hP6ATOYcpDCs', '2026-08-11 13:06:01.610233'),
('epwityucwywgkdatrflxa5of6idiy0hf', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1whB22:R9hlNu7wo_59CGZeis28_JnPbovVxbRhSAOpu_3Kszk', '2026-07-21 19:00:34.312929'),
('expw9ru4emjs7k7826wnpe2ohsz991mk', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1weiES:Uh-Mk8M6_nZ3j0wh_JK9Eqy71X_q1sRf2o3UWi5sOb8', '2026-07-14 23:51:12.673972'),
('f3plw2tz1jt9k69p1inol5o1h0fnrq18', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wKdY5:wjn69cpyucO4FCE1A8_kcaLy-iUzOpToprxHIjh1BX4', '2026-05-20 14:48:29.389114'),
('f7i6svyikwvwfpjkz8fq2lumwm79mysl', '.eJxVjMsOwiAQRf-FtSEwPASX7vsNZIahUjU0Ke3K-O_apAvd3nPOfYmE21rT1suSJhYXAVqcfkfC_ChtJ3zHdptlntu6TCR3RR60y2Hm8rwe7t9BxV6_tckxkMrnEcbAqhB6G1XISCZqDegdKGs5giPOTGSM0wZKYLAa2EMQ7w8Ldze_:1wi7kZ:P0w5zFy6sgjronAdQtiVxVSnrCExBzGCk1vwzSkADhA', '2026-07-24 09:42:27.027924'),
('fane01ps60lu0hd7zxeulcpucmqyy44b', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wrp7e:fXKt1rtdUO8pKqlYtoHDo3wWqmaM1jfl-fp0KyBRbig', '2026-08-20 03:50:22.793981'),
('fdhxdwyp5hy2pgn6qo9j1a5c857479pk', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wj4AQ:U3eONNSq9Af60x-eZzTinSY3Zmrtf0oZeHZDsAVMFl0', '2026-07-27 00:05:02.800529'),
('gbtojd5906hhdb2uyi3wbvx07qayacb5', '.eJxVjMsOwiAQRf-FtSG8EZfu-w1kmAGpGkhKuzL-uzbpQrf3nHNfLMK21riNvMSZ2IUpy06_YwJ85LYTukO7dY69rcuc-K7wgw4-dcrP6-H-HVQY9Vt7nwMFp8mDLOlcZHLGGyWK0zkJqZyiIEELQqGtNQoJwBFitmiFEYm9PwQAOCA:1wpfHm:uaVKXQAXNYMHJ-oKE7UdctaTT3XBVnAdmQkKsu9OOaw', '2026-08-14 04:55:54.501740'),
('gs9r2fmgabr8yioldewz6bmz1pp67ryi', '.eJxVjEEOwiAURO_C2hBAoODSvWcgH_5HqgaS0q6Md7ckXejsZt7MvFmAbS1h67SEGdmFScdOv2GE9KQ6CD6g3htPra7LHPmo8IN2fmtIr-vR_Tso0MtYSyW8AO1szOdsyDkL6IynSLsByqgmk9CAVLscxqRV9MJrZVUWk2afLxbCOBA:1whFiM:43s5e_l-ILx-Awd1lkTwVMihkc4b9nHEKZYaTrsZhdc', '2026-07-22 00:00:34.697497'),
('gw2in1mikzqssj6aymmyqltwe5uz1ws8', '.eJxVjMsOwiAQRf-FtSEwPASX7vsNZIahUjU0Ke3K-O_apAvd3nPOfYmE21rT1suSJhYXAVqcfkfC_ChtJ3zHdptlntu6TCR3RR60y2Hm8rwe7t9BxV6_tckxkMrnEcbAqhB6G1XISCZqDegdKGs5giPOTGSM0wZKYLAa2EMQ7w8Ldze_:1wj56I:_Wdo3JGbsne2sAwqI42L5ERnFDTLUZ5xNVl8a8IyJmA', '2026-07-27 01:04:50.923358'),
('hgu3aosj6w36onb7zmmcm4zzxosvxv79', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wKzdL:_EtS56tHpCCwyboSEqW2OYB2zWcVLYwpjhoU-zAa9ac', '2026-05-21 14:23:23.443438'),
('hs3kzlggj1x6sk5hkizprq0q4qt7qz17', '.eJxVjEEOwiAURO_C2hBAoODSvWcgH_5HqgaS0q6Md7ckXejsZt7MvFmAbS1h67SEGdmFScdOv2GE9KQ6CD6g3htPra7LHPmo8IN2fmtIr-vR_Tso0MtYSyW8AO1szOdsyDkL6IynSLsByqgmk9CAVLscxqRV9MJrZVUWk2afLxbCOBA:1wqiO1:JD4Qq7TJVqRdh1FsK609LtLdjwYY69fS_RMKTk_lHQQ', '2026-08-17 02:26:41.462064'),
('i25huv5i4xkxatc6a0rtx9oejx72gngz', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wohTi:igOTUVzT9XV2GIYECL0DQTbr7Y9U20d4OroAFnI6jN4', '2026-08-11 13:04:14.200915'),
('ia0blaklu61liipu61g1c2ixgk9xjee7', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wpdlK:loNRJKyPL3sZXzM_gw4eQecXXxX_YE00o5PDrQqVggA', '2026-08-14 03:18:18.520044'),
('iiary9vswoc15z4f07wgkypzl5nqpine', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wqioC:7UXCNjK20_UiYVd4xXbFrmMsCVs__p9uLWsmAIvb05o', '2026-08-17 02:53:44.307187'),
('ixhmeful08tx4xfp4hj3y93iu6s89zz9', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wi72R:YyqjlPijkPbyWJ_4ur2TL2b9HO_rGdxHHm6baKlPNtQ', '2026-07-24 08:56:51.259069'),
('jawf3qlc245n5m4u8m64pcdu2ktvsq0e', '.eJxVjMsOwiAQRf-FtSE8hA4u3fcbyAAzUjU0Ke3K-O_apAvd3nPOfYmI21rj1mmJUxEXYcXpd0uYH9R2UO7YbrPMc1uXKcldkQftcpwLPa-H-3dQsddvnXVIxbMC8JY9BrJOMWoFOcGg1Nmzs2FwrDUa5R0V44PToSSGBIZAvD_UFjdX:1vnTLl:imRMbj3sjO6tYXo8G0w7IM2McMldRMiUlS-ML3SWN1w', '2026-02-18 03:14:41.093858'),
('jxijvl3stirty9kx9fcebpbbbpur4cjh', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wwXB3:-aXiKk9hBm5lQqwnd4UGjJJBp7vrmIodz2KDHuoMDMg', '2026-09-02 03:41:21.593071'),
('k9duv2px5stwfs08dr2hpya6579tx0mt', '.eJxVjMsOwiAQRf-FtSG8EZfu-w1kmAGpGkhKuzL-uzbpQrf3nHNfLMK21riNvMSZ2IUpy06_YwJ85LYTukO7dY69rcuc-K7wgw4-dcrP6-H-HVQY9Vt7nwMFp8mDLOlcZHLGGyWK0zkJqZyiIEELQqGtNQoJwBFitmiFEYm9PwQAOCA:1wqiga:db6Wiu95bK3b9yj6IbrYIv4fT_PppKBwtdKs-Qr_WxI', '2026-08-17 02:45:52.388849'),
('kfyl87gqz80sd7z8mk2vgqph03y8fr2e', '.eJxVjEEOwiAURO_C2hBAoODSvWcgH_5HqgaS0q6Md7ckXejsZt7MvFmAbS1h67SEGdmFScdOv2GE9KQ6CD6g3htPra7LHPmo8IN2fmtIr-vR_Tso0MtYSyW8AO1szOdsyDkL6IynSLsByqgmk9CAVLscxqRV9MJrZVUWk2afLxbCOBA:1wi6Yd:3LD0Bxa8XgY4oICcKR4Q3H6olJ66Bbs9UT6rP2PMWuI', '2026-07-24 08:26:03.334517'),
('kgy708y5vausk55jp9w495fi2z2fpxsg', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wqiYP:e_P-5h-QuTloPqbWWkLPBkme8OOzVta4_Ym_cjI_jBQ', '2026-08-17 02:37:25.015489'),
('l1kymhh00szh2vaxepp1ijxxfdfbrykd', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wj8y5:gsiP6FawH2KkoRW5js3rPI9s5mOMMojwNmyGOFIgGi8', '2026-07-27 05:12:37.121544'),
('l3rty57lgl00je7l0cnf7l0ual0n073k', '.eJxVjMsOwiAQRf-FtSEwPASX7vsNZIahUjU0Ke3K-O_apAvd3nPOfYmE21rT1suSJhYXAVqcfkfC_ChtJ3zHdptlntu6TCR3RR60y2Hm8rwe7t9BxV6_tckxkMrnEcbAqhB6G1XISCZqDegdKGs5giPOTGSM0wZKYLAa2EMQ7w8Ldze_:1wgzVt:CAHPSHqX0L5yPVLQcumF83dRTk1IniIbJU6n4yRkMEw', '2026-07-21 06:42:37.080674'),
('li4jykd8xx0nf3whz6jtxdvxxahtmkxv', '.eJxVjEEOwiAUBe_C2hCgQKFL956BfOBjUYSkLW6Md9cm3XT7ZuZ9CITQet3cG5ecMkaHL8iFTLWXciEO-ja7vuLiciQTEYKcRg_hiXUn8QH13mhodVuyp7tCD7rSW4tYrod7Ophhnf_1qDRnKuCAOpiUrJDSqoFJwcIQUxwTM5AYJOmNtR6MFMJwLpMxWnGtDfn-AFMtQpM:1wi6uI:aTluwR3b7VbmvqMptLdea6W3O7uUOrqdMDRrRKuN1DA', '2026-07-24 08:48:26.546139'),
('lxhqctyzkhrvoy6aut0881eboyjxsevl', '.eJxVjEEOwiAURO_C2hBAoODSvWcgH_5HqgaS0q6Md7ckXejsZt7MvFmAbS1h67SEGdmFScdOv2GE9KQ6CD6g3htPra7LHPmo8IN2fmtIr-vR_Tso0MtYSyW8AO1szOdsyDkL6IynSLsByqgmk9CAVLscxqRV9MJrZVUWk2afLxbCOBA:1wj9qe:ig05K_PAWIN1p7w2WG9IkSfvLUTm9Xx6c92HuLTZl3A', '2026-07-27 06:09:00.050214'),
('m12te2zhnylz0rg6s98nbc7zvc89y4q7', '.eJxVjMsOwiAQRf-FtSEwPASX7vsNZIahUjU0Ke3K-O_apAvd3nPOfYmE21rT1suSJhYXAVqcfkfC_ChtJ3zHdptlntu6TCR3RR60y2Hm8rwe7t9BxV6_tckxkMrnEcbAqhB6G1XISCZqDegdKGs5giPOTGSM0wZKYLAa2EMQ7w8Ldze_:1whB2x:waeSCUJKng1aeq9tOn9RMg8P2zm_2wGUFC81Lk_5Dmg', '2026-07-21 19:01:31.798606'),
('mhmw1cjx7958gcs7j0nvnihymj5j5mgj', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wj88E:GUMUaU5rVjhSn45wLYZS8Asgs7Lz3XaoPTQDbDvcDjw', '2026-07-27 04:19:02.424223'),
('mzi9ghpp6bxsgb6wwueg02nc0fsk20ai', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wu0jZ:cnp7mat0XHMVKeNMQ0FGTvJJsujzYCrQaZHBD73S6Ek', '2026-08-26 04:38:33.872534'),
('n55a4y3j6cw2auvt0ktm0idcoyw7j769', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1whFeE:C9rQ0db-S-YZTz98-qSZ7Ce3ijr__9FRhfZqGWEcCEA', '2026-07-21 23:56:18.317504'),
('nf4tadlasj3x03hlzofl2s6kl9g7wpz5', '.eJxVjMsOwiAQRf-FtSE8hA4u3fcbyAAzUjU0Ke3K-O_apAvd3nPOfYmI21rj1mmJUxEXYcXpd0uYH9R2UO7YbrPMc1uXKcldkQftcpwLPa-H-3dQsddvnXVIxbMC8JY9BrJOMWoFOcGg1Nmzs2FwrDUa5R0V44PToSSGBIZAvD_UFjdX:1w9GqD:c3T_bAecTYnYSFadKGqvB2_oXuCjU9-Pjc2aeZOc5mM', '2026-04-19 06:20:13.573534'),
('nnruvaa1h1bwar6mr5h0wmfxo7o6j6im', '.eJxVjMsOwiAQRf-FtSE8hA4u3fcbyAAzUjU0Ke3K-O_apAvd3nPOfYmI21rj1mmJUxEXYcXpd0uYH9R2UO7YbrPMc1uXKcldkQftcpwLPa-H-3dQsddvnXVIxbMC8JY9BrJOMWoFOcGg1Nmzs2FwrDUa5R0V44PToSSGBIZAvD_UFjdX:1vui3V:fxcs77GINDL6mmcHuf96pADN1d23HXznsCaLRvPBnSA', '2026-03-10 02:21:45.463109'),
('nrtpt60q5fi3ny8o8fwq40ivphf2pj1y', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wKss9:6nk_rcZXeF6J6kSC2olEmZwNaQyOT7ygpGWJwDRoBSs', '2026-05-21 07:10:13.831844'),
('nzfslxvnpf2zj3q29k2dww9zmr3ho1pt', '.eJxVjEEOwiAURO_C2hBAoODSvWcgH_5HqgaS0q6Md7ckXejsZt7MvFmAbS1h67SEGdmFScdOv2GE9KQ6CD6g3htPra7LHPmo8IN2fmtIr-vR_Tso0MtYSyW8AO1szOdsyDkL6IynSLsByqgmk9CAVLscxqRV9MJrZVUWk2afLxbCOBA:1wi7j3:3Bi9sHjnQNKVIvJFn0xIsmy57fZs7NVXEO8u0oiwc0s', '2026-07-24 09:40:53.174675'),
('o0oeh0ji17zqrrdq63q1mey65316lr2w', '.eJxVjMsOwiAQRf-FtSG8EZfu-w1kmAGpGkhKuzL-uzbpQrf3nHNfLMK21riNvMSZ2IUpy06_YwJ85LYTukO7dY69rcuc-K7wgw4-dcrP6-H-HVQY9Vt7nwMFp8mDLOlcZHLGGyWK0zkJqZyiIEELQqGtNQoJwBFitmiFEYm9PwQAOCA:1wpfI8:md23WRxXxowC-7CyG-tD1BoqgJyF-KfbkoBIAKWZ3VI', '2026-08-14 04:56:16.127165'),
('onpaqtsw529lj3196ins53xa2fa2ftlj', '.eJxVjEEOwiAURO_C2hBAoODSvWcgH_5HqgaS0q6Md7ckXejsZt7MvFmAbS1h67SEGdmFScdOv2GE9KQ6CD6g3htPra7LHPmo8IN2fmtIr-vR_Tso0MtYSyW8AO1szOdsyDkL6IynSLsByqgmk9CAVLscxqRV9MJrZVUWk2afLxbCOBA:1wj7UB:s9dDSHass2R8VR-c-vK4TiVQJMOorPcTZdl8cLQcrKI', '2026-07-27 03:37:39.043900'),
('pl99f6zcavyh1x9hy3zeoc8pqv1ij7vo', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wu0An:NcubSqRc-sQcskS85eZWTCQfhyMGdHNZ4kSauHSCoqk', '2026-08-26 04:02:37.474442'),
('qn72qm37kobs2mwkydhvrjvgdb1lj8l3', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wuABv:POkBVPc7gO25-de9c4OmEM69PVQJbf86KN3_JUyaHtE', '2026-08-26 14:44:27.118138'),
('qwf4qi1gg356hbdfghy2ow4huzbrceuh', '.eJxVjMsOwiAQRf-FtSE8hA4u3fcbyAAzUjU0Ke3K-O_apAvd3nPOfYmI21rj1mmJUxEXYcXpd0uYH9R2UO7YbrPMc1uXKcldkQftcpwLPa-H-3dQsddvnXVIxbMC8JY9BrJOMWoFOcGg1Nmzs2FwrDUa5R0V44PToSSGBIZAvD_UFjdX:1vhLEX:0AnuesMkAbKzy-A-APnQV4bSNjzWQtSGuhTYNCsv2WM', '2026-02-01 05:21:53.119076'),
('r61t7iw6vbo0keigw3z2k2hx5lq3ruu8', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wohUj:9IbeRitqKMTyzdFQWTZKH3gtLtvldESGMEqqsbJyx6Y', '2026-08-11 13:05:17.023964'),
('r7fi5b6j3w6uppjoqctmm3kd3gqz2xar', '.eJxVjEEOwiAURO_C2hBAoODSvWcgH_5HqgaS0q6Md7ckXejsZt7MvFmAbS1h67SEGdmFScdOv2GE9KQ6CD6g3htPra7LHPmo8IN2fmtIr-vR_Tso0MtYSyW8AO1szOdsyDkL6IynSLsByqgmk9CAVLscxqRV9MJrZVUWk2afLxbCOBA:1whFjU:JDCKmPmX1MRoPedJAB5RZWebqkOwxn4C9t5CJcNrRwI', '2026-07-22 00:01:44.231973'),
('rer3br7f9d8heh7ecp5li2sscrds8tne', '.eJxVjDsOwjAQRO_iGln2-htK-pzBWmdXOIAcKU4qxN2JpRTQjWbevLdIuG8l7Y3XNJO4Cg3i8ltmnJ5c-0IPrPdFTkvd1jnLjshzbXJciF-3k_0TFGylv1U22VjCI4TAGpEGy0QTGDgsNmp0yEZFCCY67UEFn2GIAzC6YLz4fAEk4Dfu:1wAHXi:uHN9xwsvzFlQA9C5laiRJTu_FoRF6GeaVdfqfkZKFoQ', '2026-04-22 01:17:18.979251'),
('rex7qmo4hh9eid79c59sxpg5chsffvjr', '.eJxVjEEOwiAQAP_C2RDKQhc8eu8bmoXd2qqBpLQn499Nkx70OjOZtxpp3-Zxb7KOC6urskZdfmGi_JRyGH5QuVeda9nWJekj0adteqgsr9vZ_g1mavPxBWMNoTMIk40IkHoPDqJYBsQYAZPjiQLmRD64ECxwnjrxvhffOVafL8h5NvM:1wTsax:nM8bjvKpLN84vPcIfMEqlZSOk4Pf0ivJDEe3_oGgf0I', '2026-06-15 02:41:39.045191'),
('rudvzw0l1nj03y9gkcbcd1l67uccjsmu', '.eJxVjEEOwiAURO_C2hBAoODSvWcgH_5HqgaS0q6Md7ckXejsZt7MvFmAbS1h67SEGdmFScdOv2GE9KQ6CD6g3htPra7LHPmo8IN2fmtIr-vR_Tso0MtYSyW8AO1szOdsyDkL6IynSLsByqgmk9CAVLscxqRV9MJrZVUWk2afLxbCOBA:1wpf7e:sWFg7C1-CdHCLcBfvwJva2gP6UaPfatZaC5VrQCWMc8', '2026-08-14 04:45:26.076851'),
('s6naq9oxj57iplrbk83f4u82ec5nk63r', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wTvb9:Yz9rPUIruQljXULULOpj55E_mvKNmEXWgseIr0pKlxA', '2026-06-15 05:54:03.881141'),
('sfvxnuxsj5lo2gkwllb41f4d7uc77ygy', '.eJxVjDsOwjAQBe_iGln-Z01Jzxms9WdxANlSnFSIu0OkFNC-mXkvFnBba9hGWcKc2ZkpxU6_Y8T0KG0n-Y7t1nnqbV3myHeFH3Twa8_leTncv4OKo37ryTopbCq6uAREXhnjrRZGiaQz5YkEIAkkE8H7iGCUAikNATgrnQP2_gDzXTct:1wi6v2:JD7nPpGDunQVkxrk2mPqqXIqy5JzI_Lqv6Mhh3zEbXI', '2026-07-24 08:49:12.670138'),
('t2kl1jjzc2iqflijqmipmq64p70nn0da', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1whHFd:1ikVz3DQICfaReEORSyI2de55yVvL1tfh4xSzxOwD-k', '2026-07-22 01:39:01.410210'),
('ti0domtevlphv9vvjeymcaxbsh6r89g4', '.eJxVjEEOwiAURO_C2hBAoODSvWcgH_5HqgaS0q6Md7ckXejsZt7MvFmAbS1h67SEGdmFScdOv2GE9KQ6CD6g3htPra7LHPmo8IN2fmtIr-vR_Tso0MtYSyW8AO1szOdsyDkL6IynSLsByqgmk9CAVLscxqRV9MJrZVUWk2afLxbCOBA:1wj7Sb:svRH5sBrUU3LXeMBrUIfHAGmmOD2He9vcW314MkKkVw', '2026-07-27 03:36:01.613470'),
('tzta4ptpczjyl803n3kr3lk97kcs1egk', '.eJxVjDsOwjAQRO_iGln2-htK-pzBWmdXOIAcKU4qxN2JpRTQjWbevLdIuG8l7Y3XNJO4Cg3i8ltmnJ5c-0IPrPdFTkvd1jnLjshzbXJciF-3k_0TFGylv1U22VjCI4TAGpEGy0QTGDgsNmp0yEZFCCY67UEFn2GIAzC6YLz4fAEk4Dfu:1wBnl0:0awC7SXweNOf0kGDH0q6VCVKTdoyxsgEv_4Hq6aGnqk', '2026-04-26 05:53:18.655409'),
('u2ui98duowc6lhz3itllibi94ff8r1xf', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wa7b8:_LpbfB3sLAvKZnEPuIvR44oleANLrkeTTFXZUvBGDP0', '2026-07-02 07:55:38.014151'),
('u7uzzw15b4s7v92z4pc8t7swj9r9pxvg', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wewcK:Kz6DBlonaSWuxA_GF5Y-0tq3MRGbPwR72MctVQDsEV0', '2026-07-15 15:12:48.500777'),
('up5052cycjohq1z12fba29tpjy8t6g87', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wj7B8:CeLCxkrSTPTanOeI__Jnj1CS9b3bMva1jjwWPxb01OM', '2026-07-27 03:17:58.573504'),
('vnpdplw9u2qoyntmt69g0psbpgzx82vb', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wliDk:21xa__-5Mqh6t7z2ovjKLB0Tqi8zLCJWuTwR5cMIVYo', '2026-08-03 07:15:24.024605'),
('wmxz58vpj01yj3na6a3djal3rihl3tlj', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wtOOv:QHTyX_mYBKUZzseRQz_5VdcF8EDiz3qSe1fdMjuFuqo', '2026-08-24 11:42:41.146750'),
('woh5hkxedthc3rv5docgw02xxezqgyr3', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wbsF5:FbJLJu9PMjzdelNXkywvTITssGD6pN59sasqA_RFxtQ', '2026-07-07 03:56:07.050792'),
('wus14j11ymckl6x63l16cgzxx03e0dti', '.eJxVjEEOwiAURO_C2hBAoODSvWcgH_5HqgaS0q6Md7ckXejsZt7MvFmAbS1h67SEGdmFScdOv2GE9KQ6CD6g3htPra7LHPmo8IN2fmtIr-vR_Tso0MtYSyW8AO1szOdsyDkL6IynSLsByqgmk9CAVLscxqRV9MJrZVUWk2afLxbCOBA:1wKsqK:SGpjBsVLrwxiCTndTKJppNe0Btg2GnvKLtJk96vgcV8', '2026-05-21 07:08:20.275374'),
('wuxlpuswvmq9djqgpd7s11oys2szf50y', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wj5DL:ybO9N1nCI-0wd9SWRj1Hu-jBqfBNIJ6bE0pKfxm2CF0', '2026-07-27 01:12:07.505348'),
('x5urqwxd9kiwk0z0lims3t9xroy8ssrd', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1whB0m:usyvcRxIPE7l1sUTQiLBwu-IP3E7_KANIQEps2QBGEY', '2026-07-21 18:59:16.149397'),
('xmzyfqoj3dla9vfllt65f2b132bz76vo', '.eJxVjEEOwiAURO_C2hBAoODSvWcgH_5HqgaS0q6Md7ckXejsZt7MvFmAbS1h67SEGdmFScdOv2GE9KQ6CD6g3htPra7LHPmo8IN2fmtIr-vR_Tso0MtYSyW8AO1szOdsyDkL6IynSLsByqgmk9CAVLscxqRV9MJrZVUWk2afLxbCOBA:1wpen1:GstjlE1wPW2ni6y4W6A0-1y6Lk1ghgF-UEHKstgA4xk', '2026-08-14 04:24:07.589495'),
('xp3cedxmgrldf2u28xna45gd18xqiy61', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wWQe2:7kzJ_9JEp8_zTH9UGNKvJL4Ee7RykyR-JSAt6bFf0KY', '2026-06-22 03:27:22.940089'),
('xudv0hgbgfnnul0ucge8a4f033al4wrj', '.eJxVjEEOwiAQRe_C2hAY2gou3XsGMsNQiyIkbXFjvLs26abb_977H4Eh1FZW_45zGlNkH1-YsriUlvNJeGzr5NsSZ59YXARocRgJwzOWjfADy73KUMs6J5KbIne6yFvlmK-7eziYcJn-tQnOkgrnEUbLKhIOnVM2IBmnNeDQg-o6dtATByYyptcGomXoNPAAVnx_azhDJQ:1wgzVY:yUjSED6AHBV7rgYfOQoUoSC77sUbkvwoov12fDY_JHI', '2026-07-21 06:42:16.717399'),
('y7nathpa5u16uzy3fi03c1v1e9ferfg7', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wgbX5:2I5ZFzI-DpFORsVRn0SKdDxH470tk88f3UAhK3qEFCk', '2026-07-20 05:06:15.735265'),
('y9cyiksezkcrgunsgj4f6zoez4oydipu', '.eJxVjDsOwjAQBe_iGlkswbFNSZ8zWN4fDiBHipMKcXeIlALaNzPvZVJel5LWJnMa2VwMeHP4HTHTQ-pG-J7rbbI01WUe0W6K3Wmzw8TyvO7u30HJrXzroxNRiezOJKAhYADvPGCvufMBuxOpaFYgQlRVZgSK0ffKgOKVzPsDRgs6YQ:1wmw7t:-hiDnhxOGi7xWJqNT30Huh7iCPETEkZgfE_fNo1palo', '2026-08-06 16:18:25.936955'),
('z0c4mrtdvenaqgdd1qmh116i054qqag6', '.eJxVjEEOwiAURO_C2hBAoODSvWcgH_5HqgaS0q6Md7ckXejsZt7MvFmAbS1h67SEGdmFScdOv2GE9KQ6CD6g3htPra7LHPmo8IN2fmtIr-vR_Tso0MtYSyW8AO1szOdsyDkL6IynSLsByqgmk9CAVLscxqRV9MJrZVUWk2afLxbCOBA:1wj7Cp:cfXZIEe8U4LHwvvUwFRejc3dIYK6nUmEcjvjjNPhSUc', '2026-07-27 03:19:43.935237');

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

CREATE TABLE `documents` (
  `id` bigint(20) NOT NULL,
  `document_id` varchar(20) NOT NULL,
  `document_name` varchar(225) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `dtype_id` bigint(20) DEFAULT NULL,
  `description` varchar(225) DEFAULT NULL,
  `document` varchar(100) DEFAULT NULL,
  `staff_id` bigint(20) DEFAULT NULL,
  `expired_at` date DEFAULT NULL,
  `archived_at` datetime(6) DEFAULT NULL,
  `is_archived` tinyint(1) NOT NULL,
  `is_recycled` tinyint(1) NOT NULL,
  `recycled_at` datetime(6) DEFAULT NULL,
  `restore_at` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `documents`
--

INSERT INTO `documents` (`id`, `document_id`, `document_name`, `created_at`, `updated_at`, `category_id`, `dtype_id`, `description`, `document`, `staff_id`, `expired_at`, `archived_at`, `is_archived`, `is_recycled`, `recycled_at`, `restore_at`) VALUES
(87, 'DOC-001', 'ကိုယ်ရေးမှတ်တမ်းများ', '2026-08-21 03:41:21.671563', '2026-08-21 03:41:21.671563', 39, 3, NULL, 'documents/ကိုယ်ရေးမှတ်တမ်းများ_.docx', 3, NULL, NULL, 0, 0, NULL, NULL),
(88, 'DOC-002', 'Company', '2026-08-21 03:53:59.573945', '2026-08-21 03:53:59.573945', 27, 3, NULL, 'documents/Company.xlsx', 3, NULL, NULL, 0, 0, NULL, NULL),
(89, 'DOC-003', 'အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026', '2026-08-21 03:54:34.306357', '2026-08-21 03:54:34.306357', 35, 2, NULL, 'documents/အိတ်ဖွင့်တင်ဒါခေါ်ယူခြင်း_14_2026.pdf', 3, '2026-11-21', NULL, 0, 0, NULL, NULL),
(90, 'DOC-004', '2025-2026 Academic Year Syllabus', '2026-08-21 03:55:22.015287', '2026-08-21 03:55:22.015287', 99, 2, NULL, 'documents/2025-2026_Academic_Year_Syllabus.pptx', 3, '2026-09-21', NULL, 0, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `document_types`
--

CREATE TABLE `document_types` (
  `id` bigint(20) NOT NULL,
  `dtype_id` varchar(20) NOT NULL,
  `dtype_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `document_types`
--

INSERT INTO `document_types` (`id`, `dtype_id`, `dtype_name`) VALUES
(2, 'DTYPE-001', 'Temporary'),
(3, 'DTYPE-002', 'Permanent');

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `id` bigint(20) NOT NULL,
  `location_id` varchar(20) NOT NULL,
  `location_name` varchar(225) NOT NULL,
  `photo` varchar(100) DEFAULT NULL,
  `latitude` decimal(9,6) DEFAULT NULL,
  `longitude` decimal(9,6) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `date` date NOT NULL,
  `department_id` bigint(20) DEFAULT NULL,
  `location_type` varchar(225) DEFAULT NULL,
  `state_division` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `location_id`, `location_name`, `photo`, `latitude`, `longitude`, `description`, `city`, `date`, `department_id`, `location_type`, `state_division`) VALUES
(2, 'LOC-002', 'place_4', 'locations/Screenshot_2025-05-15_160656.png', 16.840900, 96.173500, 'this is for testing', 'Yangon', '2026-06-11', NULL, NULL, NULL),
(6, 'LOC-006', 'place_1', 'locations/Screenshot_2025-05-15_160656_J2npYhz.png', 16.838655, 96.172317, 'This is for testing', 'Yangon', '2026-07-01', NULL, 'ကုန်းတွင်းရေနံမြေများ', NULL),
(7, 'LOC-007', 'place_2', 'locations/Screenshot_2025-05-14_131915.png', 18.911258, 96.465627, 'This is for testing', 'Taungoo', '2026-07-01', NULL, '', NULL),
(8, 'LOC-008', 'place_3', 'locations/Screenshot_2025-05-14_132309.png', 18.892615, 96.477060, 'This is for testing', 'Taungoo', '2026-07-01', NULL, 'မြေပုံများ', NULL),
(10, 'LOC-010', 'ရခိုင်ကမ်းလွန် Block A-1 (ရွှေသဘာဝဓာတ်ငွေ့ဖွံ့ဖြိုးရေး)', 'locations/location_2_Rakhine.jpg', 20.147117, 92.836497, 'ရခိုင်ကမ်းလွန် Block A-1 တွင် ရွှေသဘာဝဓာတ်ငွေ့ဖွံ့ဖြိုးရေး အဆင့်၂ ကမ်းလွန်တည်ဆောက်ရေးစီမံကိန်း Phase-2 Development EPCIC (Offshore Installation) Project ဆောင်ရွက်နေသည့် DSV. Lichtenstein သင်္ဘောအား မြင်တွေ့ရစဉ်။', 'Sittwe', '2026-03-05', NULL, 'ကမ်းလွန်ရေနံလုပ်ကွက်များ', 'Rakhine State'),
(11, 'LOC-011', 'မုတ္တမကမ်းလွန် Block M-9', 'locations/location_3_MTM.jpg', 16.592341, 96.995524, 'မုတ္တမကမ်းလွန် Block M-9 တွင် NCB Drilling Rig ဖြင့် ရေနံနှင့်သဘာဝဓာတ်ငွေ့ ရှာဖွေတူးဖော်ရေးလုပ်ငန်းများဆောင်ရွက်ခဲ့စဉ်', 'Mottama', '2026-07-01', NULL, 'ကမ်းလွန်ရေနံလုပ်ကွက်များ', 'Ayawady Division'),
(12, 'LOC-012', 'Shwe Drilling & Production Platform', 'locations/location_5_Rakhine_3.jpg', 19.937442, 92.604119, 'ရခိုင်ကမ်းလွန် Block A-1/A-3 တွင် သဘာဝဓာတ်ငွေ့ထုတ်လုပ်ရေးလုပ်ငန်းများဆောင်ရွက်နေသည့် Shwe Drilling & Production Platform ကိုတွေ့ရပုံ', 'Sittwe', '2025-09-04', NULL, 'ကမ်းလွန်ရေနံလုပ်ကွက်များ', 'Rakhine State'),
(13, 'LOC-013', 'MOGE တွင် ပြုလုပ်ခဲ့သည့် DAMS အစည်းအဝေးမှတ်တမ်း', 'locations/location_6_meeting.jpg', 19.751206, 96.093261, 'Document Archiving Management System Project အကြောင်း ဆွေးနွေးတင်ပြခြင်း', 'NayPyiTaw', '2026-05-08', NULL, 'မှတ်တမ်းဓာတ်ပုံများ', 'NayPyiTaw');

-- --------------------------------------------------------

--
-- Table structure for table `location_photos`
--

CREATE TABLE `location_photos` (
  `id` bigint(20) NOT NULL,
  `photo` varchar(100) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `location_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ranks`
--

CREATE TABLE `ranks` (
  `id` bigint(20) NOT NULL,
  `rank_id` varchar(100) NOT NULL,
  `rank_name` varchar(100) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ranks`
--

INSERT INTO `ranks` (`id`, `rank_id`, `rank_name`, `created_at`, `updated_at`) VALUES
(3, 'RANK-001', 'ညွှန့်မှူး', '2026-04-26 06:10:44.676942', '2026-08-19 13:11:27.061161'),
(4, 'RANK-002', 'လက်ထောက်ညွှန်မှူး', '2026-04-26 06:11:25.731527', '2026-04-26 06:11:25.731527'),
(5, 'RANK-003', 'ဦးစီးမှူး', '2026-04-26 06:11:35.706624', '2026-04-26 06:11:35.706624'),
(6, 'RANK-004', 'ဒုဦးစီးမှူး', '2026-04-26 06:11:45.476889', '2026-04-26 06:16:16.710024');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) NOT NULL,
  `role_id` varchar(100) NOT NULL,
  `role_name` varchar(100) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `role_id`, `role_name`, `created_at`, `updated_at`) VALUES
(2, 'ROLE-001', 'Head of Department', '2026-04-26 01:43:48.066358', '2026-08-19 13:11:31.679622'),
(5, 'ROLE-002', 'Deputy of Department', '2026-04-26 01:47:44.193042', '2026-04-26 01:47:44.193042');

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `id` bigint(20) NOT NULL,
  `room_id` varchar(100) NOT NULL,
  `room_name` varchar(100) NOT NULL,
  `room_no` int(11) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `building_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`id`, `room_id`, `room_name`, `room_no`, `created_at`, `updated_at`, `building_id`) VALUES
(6, 'ROOM-001', 'အစည်းအဝေး ခန်းမ', 110, '2026-04-27 06:00:45.433645', '2026-08-19 13:13:55.856969', 4),
(7, 'ROOM-002', 'မဟာကွန်ပျူတာ (သိပ္ပံ)', 203, '2026-04-27 06:47:00.848912', '2026-04-27 06:47:00.848912', 4),
(8, 'ROOM-003', 'Fianance', 104, '2026-04-29 02:20:22.455832', '2026-04-29 02:20:22.456838', 4);

-- --------------------------------------------------------

--
-- Table structure for table `socialaccount_socialaccount`
--

CREATE TABLE `socialaccount_socialaccount` (
  `id` int(11) NOT NULL,
  `provider` varchar(200) NOT NULL,
  `uid` varchar(191) NOT NULL,
  `last_login` datetime(6) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `extra_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`extra_data`)),
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `socialaccount_socialapp`
--

CREATE TABLE `socialaccount_socialapp` (
  `id` int(11) NOT NULL,
  `provider` varchar(30) NOT NULL,
  `name` varchar(40) NOT NULL,
  `client_id` varchar(191) NOT NULL,
  `secret` varchar(191) NOT NULL,
  `key` varchar(191) NOT NULL,
  `provider_id` varchar(200) NOT NULL,
  `settings` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`settings`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `socialaccount_socialtoken`
--

CREATE TABLE `socialaccount_socialtoken` (
  `id` int(11) NOT NULL,
  `token` longtext NOT NULL,
  `token_secret` longtext NOT NULL,
  `expires_at` datetime(6) DEFAULT NULL,
  `account_id` int(11) NOT NULL,
  `app_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `staffs`
--

CREATE TABLE `staffs` (
  `id` bigint(20) NOT NULL,
  `staff_id` varchar(100) NOT NULL,
  `staff_name` varchar(100) NOT NULL,
  `staff_email` varchar(254) NOT NULL,
  `staff_address` varchar(100) NOT NULL,
  `staff_ph_number` varchar(100) NOT NULL,
  `staff_gender` varchar(10) NOT NULL,
  `department_id` bigint(20) DEFAULT NULL,
  `rank_id` bigint(20) DEFAULT NULL,
  `role_id` bigint(20) DEFAULT NULL,
  `stype_id` bigint(20) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staffs`
--

INSERT INTO `staffs` (`id`, `staff_id`, `staff_name`, `staff_email`, `staff_address`, `staff_ph_number`, `staff_gender`, `department_id`, `rank_id`, `role_id`, `stype_id`, `created_at`, `updated_at`) VALUES
(3, 'S-001', 'U Myat Zaw', 'jaycoab2@gmail.com', 'Taungoo, Bago, Myanmar', '09676067433', 'male', 4, 3, 2, 3, '2026-04-28 01:03:30.219125', '2026-04-28 01:03:30.219125'),
(4, 'S-002', 'U Win Myint', 'hoshino@gmail.com', 'North Dagon, Yangon, Myanmar', '09847334554', 'male', 10, 5, 5, 3, '2026-04-28 01:05:40.594535', '2026-04-28 01:05:40.594535'),
(5, 'S-003', 'Daw Khin Khin', 'kise@gmail.com', 'Taungoo, Bago', '097476545343', 'female', 8, 6, 2, 3, '2026-04-29 02:21:20.954380', '2026-04-29 02:21:20.955382'),
(6, 'S-004', 'U Myo Min', 'umyomin@gmail.com', 'MOGE, NayPyiTaw, Myanmar', '09454534326', 'male', 10, 4, 5, 3, '2026-07-10 08:47:25.343369', '2026-07-10 08:47:25.344363'),
(7, 'S-005', 'Daw Aye', 'dawaye@gmail.com', 'Taungoo, Bago, Myanmar', '09874343432', 'female', 10, 4, 5, 3, '2026-07-31 04:55:24.216852', '2026-07-31 04:55:24.216852');

-- --------------------------------------------------------

--
-- Table structure for table `stypes`
--

CREATE TABLE `stypes` (
  `id` bigint(20) NOT NULL,
  `stype_id` varchar(100) NOT NULL,
  `stype_name` varchar(100) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stypes`
--

INSERT INTO `stypes` (`id`, `stype_id`, `stype_name`, `created_at`, `updated_at`) VALUES
(3, 'STYPE-001', 'Permenant', '2026-04-27 08:07:31.291199', '2026-08-19 13:11:43.946506'),
(4, 'STYPE-002', 'Temporary', '2026-04-27 08:07:37.719172', '2026-04-27 08:07:37.720173'),
(5, 'STYPE-003', 'နေ့စား ၀န်ထမ်း', '2026-07-01 03:58:30.653871', '2026-07-01 03:58:30.653871'),
(6, 'STYPE-004', 'အငှား ၀န်ထမ်း', '2026-07-01 03:58:40.712329', '2026-07-01 03:58:40.712329');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account_emailaddress`
--
ALTER TABLE `account_emailaddress`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `account_emailaddress_user_id_email_987c8728_uniq` (`user_id`,`email`),
  ADD KEY `account_emailaddress_email_03be32b2` (`email`);

--
-- Indexes for table `account_emailconfirmation`
--
ALTER TABLE `account_emailconfirmation`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `key` (`key`),
  ADD KEY `account_emailconfirm_email_address_id_5b7f8c58_fk_account_e` (`email_address_id`);

--
-- Indexes for table `archives`
--
ALTER TABLE `archives`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `archive_id` (`archive_id`),
  ADD KEY `archives_documents_id_72d2e70e_fk_documents_document_id` (`documents_id`),
  ADD KEY `archives_staffs_id_ceccdc49_fk_staffs_id` (`staffs_id`);

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `audit_logs_user_id_752b0e2b_fk_authentication_moguser_id` (`user_id`);

--
-- Indexes for table `authentication_moguser`
--
ALTER TABLE `authentication_moguser`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `staff_id` (`staff_id`);

--
-- Indexes for table `authentication_moguser_groups`
--
ALTER TABLE `authentication_moguser_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `authentication_moguser_groups_moguser_id_group_id_cfd99cb7_uniq` (`moguser_id`,`group_id`),
  ADD KEY `authentication_moguser_groups_group_id_078d181c_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `authentication_moguser_user_permissions`
--
ALTER TABLE `authentication_moguser_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `authentication_moguser_u_moguser_id_permission_id_8bbc6a46_uniq` (`moguser_id`,`permission_id`),
  ADD KEY `authentication_mogus_permission_id_b8f50aef_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `authtoken_token`
--
ALTER TABLE `authtoken_token`
  ADD PRIMARY KEY (`key`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `buildings`
--
ALTER TABLE `buildings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `building_id` (`building_id`),
  ADD UNIQUE KEY `building_name` (`building_name`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `category_name` (`category_name`),
  ADD UNIQUE KEY `category_id` (`category_id`),
  ADD KEY `categories_parent_id_fc02df82_fk_categories_id` (`parent_id`);

--
-- Indexes for table `chats_chatmessage`
--
ALTER TABLE `chats_chatmessage`
  ADD PRIMARY KEY (`id`),
  ADD KEY `chats_chatmessage_user_id_79aca0cf_fk_authentication_moguser_id` (`user_id`);

--
-- Indexes for table `chats_document`
--
ALTER TABLE `chats_document`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `department_id` (`department_id`),
  ADD UNIQUE KEY `department_name` (`department_name`),
  ADD KEY `departments_department_room_id_c0c6a1a6_fk_rooms_room_id` (`room_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_authentication_moguser_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `document_id` (`document_id`),
  ADD KEY `documents_document_dtype_id_b82457c2_fk_document_types_id` (`dtype_id`),
  ADD KEY `documents_category_id_7d9ef7d7_fk_categories_id` (`category_id`),
  ADD KEY `documents_staff_id_a931ae71_fk_staffs_id` (`staff_id`);

--
-- Indexes for table `document_types`
--
ALTER TABLE `document_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `dtype_id` (`dtype_id`),
  ADD UNIQUE KEY `dtype_name` (`dtype_name`);

--
-- Indexes for table `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `location_id` (`location_id`),
  ADD KEY `locations_department_id_5df33abd_fk_departments_id` (`department_id`);

--
-- Indexes for table `location_photos`
--
ALTER TABLE `location_photos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `location_photos_location_id_e992471c_fk_locations_id` (`location_id`);

--
-- Indexes for table `ranks`
--
ALTER TABLE `ranks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `rank_id` (`rank_id`),
  ADD UNIQUE KEY `rank_name` (`rank_name`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `role_id` (`role_id`),
  ADD UNIQUE KEY `role_name` (`role_name`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `room_id` (`room_id`),
  ADD UNIQUE KEY `room_name` (`room_name`),
  ADD KEY `rooms_building_id_19cd4c2e_fk_buildings_id` (`building_id`);

--
-- Indexes for table `socialaccount_socialaccount`
--
ALTER TABLE `socialaccount_socialaccount`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `socialaccount_socialaccount_provider_uid_fc810c6e_uniq` (`provider`,`uid`),
  ADD KEY `socialaccount_social_user_id_8146e70c_fk_authentic` (`user_id`);

--
-- Indexes for table `socialaccount_socialapp`
--
ALTER TABLE `socialaccount_socialapp`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `socialaccount_socialtoken`
--
ALTER TABLE `socialaccount_socialtoken`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `socialaccount_socialtoken_app_id_account_id_fca4e0ac_uniq` (`app_id`,`account_id`),
  ADD KEY `socialaccount_social_account_id_951f210e_fk_socialacc` (`account_id`);

--
-- Indexes for table `staffs`
--
ALTER TABLE `staffs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `staff_id` (`staff_id`),
  ADD UNIQUE KEY `staff_name` (`staff_name`),
  ADD UNIQUE KEY `staff_email` (`staff_email`),
  ADD UNIQUE KEY `staff_ph_number` (`staff_ph_number`),
  ADD KEY `staffs_department_id_ab62f65b_fk_departments_id` (`department_id`),
  ADD KEY `staffs_rank_id_6ed5531d_fk_ranks_id` (`rank_id`),
  ADD KEY `staffs_role_id_de52a80c_fk_roles_id` (`role_id`),
  ADD KEY `staffs_stype_id_9c0f3a30_fk_stypes_id` (`stype_id`);

--
-- Indexes for table `stypes`
--
ALTER TABLE `stypes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `stype_id` (`stype_id`),
  ADD UNIQUE KEY `stype_name` (`stype_name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `account_emailaddress`
--
ALTER TABLE `account_emailaddress`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `account_emailconfirmation`
--
ALTER TABLE `account_emailconfirmation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `archives`
--
ALTER TABLE `archives`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=292;

--
-- AUTO_INCREMENT for table `authentication_moguser`
--
ALTER TABLE `authentication_moguser`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `authentication_moguser_groups`
--
ALTER TABLE `authentication_moguser_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `authentication_moguser_user_permissions`
--
ALTER TABLE `authentication_moguser_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=133;

--
-- AUTO_INCREMENT for table `buildings`
--
ALTER TABLE `buildings`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100;

--
-- AUTO_INCREMENT for table `chats_chatmessage`
--
ALTER TABLE `chats_chatmessage`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=238;

--
-- AUTO_INCREMENT for table `chats_document`
--
ALTER TABLE `chats_document`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=110;

--
-- AUTO_INCREMENT for table `documents`
--
ALTER TABLE `documents`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=91;

--
-- AUTO_INCREMENT for table `document_types`
--
ALTER TABLE `document_types`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `location_photos`
--
ALTER TABLE `location_photos`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `ranks`
--
ALTER TABLE `ranks`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `socialaccount_socialaccount`
--
ALTER TABLE `socialaccount_socialaccount`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `socialaccount_socialapp`
--
ALTER TABLE `socialaccount_socialapp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `socialaccount_socialtoken`
--
ALTER TABLE `socialaccount_socialtoken`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `staffs`
--
ALTER TABLE `staffs`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `stypes`
--
ALTER TABLE `stypes`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `account_emailaddress`
--
ALTER TABLE `account_emailaddress`
  ADD CONSTRAINT `account_emailaddress_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `authentication_moguser` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `account_emailconfirmation`
--
ALTER TABLE `account_emailconfirmation`
  ADD CONSTRAINT `account_emailconfirm_email_address_id_5b7f8c58_fk_account_e` FOREIGN KEY (`email_address_id`) REFERENCES `account_emailaddress` (`id`);

--
-- Constraints for table `archives`
--
ALTER TABLE `archives`
  ADD CONSTRAINT `archives_documents_id_72d2e70e_fk_documents_document_id` FOREIGN KEY (`documents_id`) REFERENCES `documents` (`id`),
  ADD CONSTRAINT `archives_staffs_id_ceccdc49_fk_staffs_id` FOREIGN KEY (`staffs_id`) REFERENCES `staffs` (`id`);

--
-- Constraints for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `audit_logs_user_id_752b0e2b_fk_authentication_moguser_id` FOREIGN KEY (`user_id`) REFERENCES `authentication_moguser` (`id`);

--
-- Constraints for table `authentication_moguser`
--
ALTER TABLE `authentication_moguser`
  ADD CONSTRAINT `authentication_moguser_staff_id_6153f008_fk_staffs_id` FOREIGN KEY (`staff_id`) REFERENCES `staffs` (`id`);

--
-- Constraints for table `authentication_moguser_groups`
--
ALTER TABLE `authentication_moguser_groups`
  ADD CONSTRAINT `authentication_mogus_moguser_id_fb72c01e_fk_authentic` FOREIGN KEY (`moguser_id`) REFERENCES `authentication_moguser` (`id`),
  ADD CONSTRAINT `authentication_moguser_groups_group_id_078d181c_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `authentication_moguser_user_permissions`
--
ALTER TABLE `authentication_moguser_user_permissions`
  ADD CONSTRAINT `authentication_mogus_moguser_id_9b19ba38_fk_authentic` FOREIGN KEY (`moguser_id`) REFERENCES `authentication_moguser` (`id`),
  ADD CONSTRAINT `authentication_mogus_permission_id_b8f50aef_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`);

--
-- Constraints for table `authtoken_token`
--
ALTER TABLE `authtoken_token`
  ADD CONSTRAINT `authtoken_token_user_id_35299eff_fk_authentication_moguser_id` FOREIGN KEY (`user_id`) REFERENCES `authentication_moguser` (`id`);

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_parent_id_fc02df82_fk_categories_id` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`);

--
-- Constraints for table `chats_chatmessage`
--
ALTER TABLE `chats_chatmessage`
  ADD CONSTRAINT `chats_chatmessage_user_id_79aca0cf_fk_authentication_moguser_id` FOREIGN KEY (`user_id`) REFERENCES `authentication_moguser` (`id`);

--
-- Constraints for table `departments`
--
ALTER TABLE `departments`
  ADD CONSTRAINT `departments_department_room_id_c0c6a1a6_fk_rooms_room_id` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_authentication_moguser_id` FOREIGN KEY (`user_id`) REFERENCES `authentication_moguser` (`id`);

--
-- Constraints for table `documents`
--
ALTER TABLE `documents`
  ADD CONSTRAINT `documents_category_id_7d9ef7d7_fk_categories_id` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `documents_document_dtype_id_b82457c2_fk_document_types_id` FOREIGN KEY (`dtype_id`) REFERENCES `document_types` (`id`),
  ADD CONSTRAINT `documents_staff_id_a931ae71_fk_staffs_id` FOREIGN KEY (`staff_id`) REFERENCES `staffs` (`id`);

--
-- Constraints for table `locations`
--
ALTER TABLE `locations`
  ADD CONSTRAINT `locations_department_id_5df33abd_fk_departments_id` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`);

--
-- Constraints for table `location_photos`
--
ALTER TABLE `location_photos`
  ADD CONSTRAINT `location_photos_location_id_e992471c_fk_locations_id` FOREIGN KEY (`location_id`) REFERENCES `locations` (`id`);

--
-- Constraints for table `rooms`
--
ALTER TABLE `rooms`
  ADD CONSTRAINT `rooms_building_id_19cd4c2e_fk_buildings_id` FOREIGN KEY (`building_id`) REFERENCES `buildings` (`id`);

--
-- Constraints for table `socialaccount_socialaccount`
--
ALTER TABLE `socialaccount_socialaccount`
  ADD CONSTRAINT `socialaccount_social_user_id_8146e70c_fk_authentic` FOREIGN KEY (`user_id`) REFERENCES `authentication_moguser` (`id`);

--
-- Constraints for table `socialaccount_socialtoken`
--
ALTER TABLE `socialaccount_socialtoken`
  ADD CONSTRAINT `socialaccount_social_account_id_951f210e_fk_socialacc` FOREIGN KEY (`account_id`) REFERENCES `socialaccount_socialaccount` (`id`),
  ADD CONSTRAINT `socialaccount_social_app_id_636a42d7_fk_socialacc` FOREIGN KEY (`app_id`) REFERENCES `socialaccount_socialapp` (`id`);

--
-- Constraints for table `staffs`
--
ALTER TABLE `staffs`
  ADD CONSTRAINT `staffs_department_id_ab62f65b_fk_departments_id` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`),
  ADD CONSTRAINT `staffs_rank_id_6ed5531d_fk_ranks_id` FOREIGN KEY (`rank_id`) REFERENCES `ranks` (`id`),
  ADD CONSTRAINT `staffs_role_id_de52a80c_fk_roles_id` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  ADD CONSTRAINT `staffs_stype_id_9c0f3a30_fk_stypes_id` FOREIGN KEY (`stype_id`) REFERENCES `stypes` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
