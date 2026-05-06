-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 06, 2026 at 11:43 AM
-- Server version: 11.8.6-MariaDB-log
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u470144664_library_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `id` int(11) NOT NULL,
  `accession_number` varchar(20) DEFAULT NULL,
  `call_no` varchar(50) DEFAULT NULL COMMENT 'Library classification number',
  `title` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `edition` varchar(50) DEFAULT NULL COMMENT 'Book edition (e.g., 3rd, revised)',
  `volume` varchar(20) DEFAULT NULL COMMENT 'Volume number',
  `pages` int(10) UNSIGNED DEFAULT NULL COMMENT 'Total pages',
  `publication_year` smallint(5) UNSIGNED DEFAULT NULL COMMENT 'Year of publication',
  `category` varchar(100) DEFAULT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `description` text DEFAULT NULL,
  `pdf_file` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `available` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('available','borrowed','temporary_unavailable','archived') DEFAULT 'available',
  `ebook_type` enum('none','file','blob') DEFAULT 'none' COMMENT 'How PDF is stored: none=physical book, file=path, blob=database',
  `ebook_max_access_days` tinyint(3) UNSIGNED DEFAULT 7 COMMENT 'Default max days a student can borrow this e-book',
  `ebook_allow_download` tinyint(1) DEFAULT 0 COMMENT 'Default: students cannot download, only view online',
  `ebook_concurrent_limit` int(11) DEFAULT NULL COMMENT 'NULL = unlimited concurrent readers, or set a max number'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`id`, `accession_number`, `call_no`, `title`, `author`, `edition`, `volume`, `pages`, `publication_year`, `category`, `quantity`, `description`, `pdf_file`, `image`, `available`, `created_at`, `status`, `ebook_type`, `ebook_max_access_days`, `ebook_allow_download`, `ebook_concurrent_limit`) VALUES
(154, '2026-00001', 'Fi B 74 C78', 'Philosophy of Man', 'Cruz, Corazon L', '3rd', NULL, 236, 1995, 'Philosophy', 12, 'Introduction to philosophical concepts', NULL, NULL, 1, '2026-03-25 17:21:47', 'available', 'none', 7, 0, NULL),
(155, '2026-00002', 'Fi H 61 D9', 'Contemporary Social Philosophy', 'Dy, Manuel B', NULL, NULL, 78, 1994, 'Philosophy', 3, '', NULL, NULL, 1, '2026-03-25 17:21:47', 'available', 'none', 7, 0, NULL),
(156, '2026-00003', NULL, 'Basic Mathematics', 'Alan Turing', NULL, NULL, NULL, NULL, 'Mathematics', 30, '', NULL, NULL, 1, '2026-03-25 17:21:47', 'available', 'none', 7, 0, NULL),
(157, '2026-00004', '', 'Object Oriented Programming using Java', 'Simon Kendal', '1st Edition', '', 216, 2009, 'Programming', 1, 'Object Oriented Programming using Java by Simon Kendal (2009) is a practical guide that teaches core OOP concepts and software design using Java. It combines theory with exercises and a final case study to help learners develop real-world programming and system design skills.', '1774460099_OOP using Java.pdf', NULL, 1, '2026-03-25 17:34:59', 'available', 'file', 7, 0, NULL),
(158, '2026-00005', NULL, 'Angular 2', 'GoalKicker.com', '1st Edition', NULL, 232, 2018, '', 1, 'Angular 2+ Notes for Professionals by GoalKicker is a free, community-driven reference book that compiles knowledge from Stack Overflow contributors into a structured guide for learning Angular development. The book focuses on helping readers understand how to build modern, dynamic web applications using Angular (version 2 and above).', '1774460816_Angular2NotesForProfessionals.pdf', NULL, 1, '2026-03-25 17:46:56', 'available', 'none', 7, 0, NULL),
(159, '2026-00006', 'Fi Fi H 61 D10', 'Introduction to c#', 'santos', '1st edition', '', 200, 2009, 'programming', 19, 'Introduction to philosophical concepts', NULL, '1774499447_return_qr.png', 1, '2026-03-26 04:27:45', 'available', 'none', 7, 0, NULL),
(160, '2026-00007', 'Fi B 234', 'LOL', 'john', '3rd', 'vol1', 234, 1990, 'Mathematics', 10, 'EEEEEE', NULL, NULL, 1, '2026-04-14 10:27:14', 'available', 'none', 7, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `book_copies`
--

CREATE TABLE `book_copies` (
  `id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `accession_no` varchar(50) DEFAULT NULL,
  `qr_code` varchar(255) DEFAULT NULL,
  `condition_status` enum('good','damaged','lost','archived') NOT NULL DEFAULT 'good',
  `circulation_status` enum('available','borrowed','inactive') NOT NULL DEFAULT 'available',
  `replacement_for_copy_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `book_copies`
--

INSERT INTO `book_copies` (`id`, `book_id`, `accession_no`, `qr_code`, `condition_status`, `circulation_status`, `replacement_for_copy_id`, `created_at`, `updated_at`) VALUES
(3, 155, NULL, NULL, 'good', 'available', NULL, '2026-03-26 01:36:06', '2026-03-26 01:36:06');

-- --------------------------------------------------------

--
-- Table structure for table `borrows`
--

CREATE TABLE `borrows` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `borrow_date` datetime DEFAULT current_timestamp(),
  `due_date` datetime DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL COMMENT '24h expiry for pending requests',
  `return_date` datetime DEFAULT NULL,
  `return_condition` enum('good','damaged','lost') DEFAULT NULL,
  `status` enum('pending','approved','ready_for_pickup','awaiting_handshake','to_be_receive','received','lent','returned','rejected','cancelled','overdue') NOT NULL DEFAULT 'pending',
  `approved_at` datetime DEFAULT NULL,
  `desired_date` date DEFAULT NULL,
  `quantity` int(11) DEFAULT 1,
  `qr_token` varchar(255) DEFAULT NULL,
  `qr_image` varchar(255) DEFAULT NULL,
  `desired_days` tinyint(3) UNSIGNED DEFAULT NULL,
  `qr_code` varchar(255) DEFAULT NULL,
  `qr_expires_at` datetime DEFAULT NULL COMMENT 'When the QR token expires (5 min window)',
  `handshake_confirmed_at` datetime DEFAULT NULL COMMENT 'When student confirmed pickup on mobile',
  `lent_at` datetime DEFAULT NULL COMMENT 'When book was physically handed to student',
  `return_ticket_hash` varchar(128) DEFAULT NULL COMMENT 'HMAC signature for return ticket validation',
  `return_ticket_generated_at` datetime DEFAULT NULL COMMENT 'When return ticket PNG was generated',
  `overdue_sms_sent` varchar(20) DEFAULT NULL COMMENT 'Comma-separated overdue milestones already sent (e.g., 1,3,7)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `borrows`
--

INSERT INTO `borrows` (`id`, `user_id`, `book_id`, `borrow_date`, `due_date`, `expires_at`, `return_date`, `return_condition`, `status`, `approved_at`, `desired_date`, `quantity`, `qr_token`, `qr_image`, `desired_days`, `qr_code`, `qr_expires_at`, `handshake_confirmed_at`, `lent_at`, `return_ticket_hash`, `return_ticket_generated_at`, `overdue_sms_sent`) VALUES
(198, 104, 155, '2026-03-26 01:27:28', '2026-03-27 23:59:59', NULL, '2026-03-26 01:27:48', 'damaged', 'returned', NULL, NULL, 1, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(199, 104, 156, '2026-03-26 01:30:18', '2026-03-27 23:59:59', NULL, NULL, NULL, 'lent', NULL, NULL, 1, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, '3'),
(200, 105, 156, '2026-03-26 12:31:46', '2026-03-27 23:59:59', '2026-03-27 12:31:46', NULL, NULL, 'rejected', NULL, NULL, 1, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(201, 105, 159, '2026-03-26 12:36:10', '2026-03-27 23:59:59', NULL, '2026-03-26 12:54:30', 'damaged', 'returned', NULL, NULL, 1, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(202, 104, 159, '2026-03-23 13:06:57', '2026-03-23 12:12:59', NULL, NULL, NULL, 'lent', NULL, NULL, 1, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, '3,7'),
(203, 106, 156, '2026-04-10 23:15:05', '2026-04-15 23:59:59', NULL, '2026-04-10 23:15:28', 'good', 'returned', NULL, NULL, 1, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(205, 106, 155, '2026-04-10 23:55:05', '2026-04-09 23:59:59', NULL, NULL, NULL, 'lent', NULL, NULL, 1, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, '1'),
(206, 105, 160, '2026-04-14 18:33:43', '2026-04-20 23:59:59', NULL, NULL, NULL, 'lent', NULL, NULL, 1, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, '3');

-- --------------------------------------------------------

--
-- Table structure for table `borrow_requests`
--

CREATE TABLE `borrow_requests` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `damage_cases`
--

CREATE TABLE `damage_cases` (
  `id` int(11) NOT NULL,
  `borrow_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `copy_id` int(11) DEFAULT NULL,
  `case_type` enum('damaged','lost') NOT NULL,
  `severity` enum('minor','major','total_loss') DEFAULT NULL,
  `resolution_mode` enum('replacement','cash_payment','wallet_deduction','mixed','waived') DEFAULT NULL,
  `amount_due` decimal(10,2) NOT NULL DEFAULT 0.00,
  `amount_paid` decimal(10,2) NOT NULL DEFAULT 0.00,
  `status` enum('open','awaiting_approval','partially_settled','settled','closed','disputed','void','reopened') NOT NULL DEFAULT 'open',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `opened_by` int(11) DEFAULT NULL,
  `closed_by` int(11) DEFAULT NULL,
  `opened_at` datetime NOT NULL DEFAULT current_timestamp(),
  `closed_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `damage_cases`
--

INSERT INTO `damage_cases` (`id`, `borrow_id`, `student_id`, `book_id`, `copy_id`, `case_type`, `severity`, `resolution_mode`, `amount_due`, `amount_paid`, `status`, `is_active`, `opened_by`, `closed_by`, `opened_at`, `closed_at`) VALUES
(6, 198, 104, 155, 3, 'damaged', 'major', 'replacement', 0.00, 0.00, 'settled', 0, 94, NULL, '2026-03-26 01:27:48', NULL),
(7, 201, 105, 159, NULL, 'damaged', 'minor', NULL, 0.00, 0.00, 'open', 1, 103, NULL, '2026-03-26 12:54:30', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `damage_case_events`
--

CREATE TABLE `damage_case_events` (
  `id` int(11) NOT NULL,
  `case_id` int(11) NOT NULL,
  `event_type` enum('created','inspection_added','payment_received','replacement_submitted','replacement_approved','closed','reopened','disputed','dispute_resolved_open') NOT NULL,
  `notes` text DEFAULT NULL,
  `meta_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`meta_json`)),
  `actor_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `damage_case_events`
--

INSERT INTO `damage_case_events` (`id`, `case_id`, `event_type`, `notes`, `meta_json`, `actor_id`, `created_at`) VALUES
(10, 6, 'created', 'missing pages', '{\"return_condition\":\"damaged\",\"severity\":\"major\",\"amount_due\":0,\"ticket_hash\":\"6f4bb2dddc6cdb39...\"}', 94, '2026-03-26 01:27:48'),
(11, 6, 'replacement_approved', 'Replacement approved and inventory restored.', '{\"accession_no\":null,\"qr_code\":null}', 94, '2026-03-26 01:36:07'),
(12, 7, 'created', 'Case opened from return scan: damaged', '{\"return_condition\":\"damaged\",\"severity\":\"minor\",\"amount_due\":0,\"ticket_hash\":\"cef13c720240ccac...\"}', 103, '2026-03-26 12:54:30');

-- --------------------------------------------------------

--
-- Table structure for table `damage_case_payments`
--

CREATE TABLE `damage_case_payments` (
  `id` int(11) NOT NULL,
  `case_id` int(11) NOT NULL,
  `payment_method` enum('cash_payment','wallet_deduction','mixed') NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `reference_no` varchar(100) DEFAULT NULL,
  `received_by` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ebook_access`
--

CREATE TABLE `ebook_access` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `status` enum('pending','approved','active','expired','rejected','revoked','cancelled') NOT NULL DEFAULT 'pending',
  `requested_at` datetime DEFAULT current_timestamp(),
  `requested_days` tinyint(3) UNSIGNED DEFAULT 7 COMMENT 'Days requested (1-30)',
  `approved_at` datetime DEFAULT NULL,
  `approved_by` int(11) DEFAULT NULL COMMENT 'Admin who approved',
  `rejected_at` datetime DEFAULT NULL,
  `rejection_reason` varchar(255) DEFAULT NULL,
  `access_granted_at` datetime DEFAULT NULL COMMENT 'When reading access started',
  `expires_at` datetime DEFAULT NULL COMMENT 'When access expires',
  `last_accessed_at` datetime DEFAULT NULL COMMENT 'Last time student opened PDF',
  `access_count` int(11) DEFAULT 0 COMMENT 'How many times PDF was opened',
  `total_reading_minutes` int(11) DEFAULT 0 COMMENT 'Estimated reading time',
  `allow_download` tinyint(1) DEFAULT 0 COMMENT 'Can student download PDF?',
  `download_count` int(11) DEFAULT 0,
  `renewed_count` tinyint(4) DEFAULT 0 COMMENT 'How many times renewed',
  `last_renewed_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `expiry_notified_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Tracks student access to e-books with time limits';

--
-- Dumping data for table `ebook_access`
--

INSERT INTO `ebook_access` (`id`, `user_id`, `book_id`, `status`, `requested_at`, `requested_days`, `approved_at`, `approved_by`, `rejected_at`, `rejection_reason`, `access_granted_at`, `expires_at`, `last_accessed_at`, `access_count`, `total_reading_minutes`, `allow_download`, `download_count`, `renewed_count`, `last_renewed_at`, `created_at`, `updated_at`, `expiry_notified_at`) VALUES
(46, 104, 158, 'expired', '2026-03-26 13:19:55', 7, '2026-03-26 13:20:13', 103, NULL, NULL, '2026-03-26 13:20:13', '2026-04-02 13:20:13', '2026-03-26 13:20:59', 2, 0, 0, 0, 0, NULL, '2026-03-26 05:19:55', '2026-04-10 15:07:48', NULL),
(47, 104, 157, 'expired', '2026-04-14 14:50:24', 7, '2026-04-14 14:50:39', 103, NULL, NULL, '2026-04-14 14:50:39', '2026-04-21 14:50:39', '2026-04-14 17:49:28', 4, 0, 0, 0, 0, NULL, '2026-04-14 06:50:24', '2026-04-23 14:29:56', NULL),
(48, 105, 158, 'approved', '2026-04-24 11:55:44', 7, '2026-04-24 11:55:57', 103, NULL, NULL, '2026-04-24 11:55:57', '2026-05-01 11:55:57', NULL, 0, 0, 0, 0, 0, NULL, '2026-04-24 03:55:44', '2026-04-24 03:55:57', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `favorites`
--

CREATE TABLE `favorites` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `favorites`
--

INSERT INTO `favorites` (`id`, `user_id`, `book_id`, `created_at`) VALUES
(21, 95, 115, '2026-03-24 05:25:45'),
(23, 95, 130, '2026-03-24 05:25:47'),
(24, 95, 129, '2026-03-24 05:25:49'),
(0, 87, 115, '2026-03-25 15:53:17'),
(0, 102, 130, '2026-03-25 15:55:19'),
(0, 102, 126, '2026-03-25 15:55:20'),
(0, 87, 130, '2026-03-25 16:18:02'),
(0, 90, 137, '2026-03-25 16:25:25'),
(0, 87, 126, '2026-03-25 16:31:18');

-- --------------------------------------------------------

--
-- Table structure for table `handshake_sessions`
--

CREATE TABLE `handshake_sessions` (
  `id` int(11) NOT NULL,
  `borrow_id` int(11) NOT NULL,
  `token` varchar(64) NOT NULL COMMENT 'Same as borrows.qr_token for cross-reference',
  `admin_id` int(11) NOT NULL COMMENT 'Admin who initiated the handshake',
  `status` enum('pending','scanned','confirmed','expired','cancelled') DEFAULT 'pending',
  `created_at` datetime DEFAULT current_timestamp(),
  `scanned_at` datetime DEFAULT NULL COMMENT 'When student scanned QR',
  `confirmed_at` datetime DEFAULT NULL COMMENT 'When student clicked confirm',
  `expires_at` datetime NOT NULL,
  `student_ip` varchar(45) DEFAULT NULL COMMENT 'IP of confirming device',
  `student_user_agent` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `handshake_sessions`
--

INSERT INTO `handshake_sessions` (`id`, `borrow_id`, `token`, `admin_id`, `status`, `created_at`, `scanned_at`, `confirmed_at`, `expires_at`, `student_ip`, `student_user_agent`) VALUES
(1, 140, 'baf86cc936edba18cc70582669cda4f12e51438ccc87de98bd7be3eb3424e26f', 36, 'pending', '2026-01-23 16:53:55', NULL, NULL, '2026-01-23 10:08:55', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `holidays`
--

CREATE TABLE `holidays` (
  `id` int(11) NOT NULL,
  `holiday_date` date NOT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `holidays`
--

INSERT INTO `holidays` (`id`, `holiday_date`, `description`) VALUES
(0, '2026-06-17', ''),
(0, '2026-04-17', '');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_read` tinyint(1) DEFAULT 0,
  `is_persistent` tinyint(1) NOT NULL DEFAULT 0,
  `is_mandatory` tinyint(1) NOT NULL DEFAULT 0,
  `related_case_id` int(11) DEFAULT NULL,
  `resolved_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `message`, `created_at`, `is_read`, `is_persistent`, `is_mandatory`, `related_case_id`, `resolved_at`) VALUES
(291, 104, 'Your borrow request for \"Contemporary Social Philosophy\" has been approved. Check your email for the QR code. You have 24 hours to collect the book.', '2026-03-25 17:25:25', 0, 0, 0, NULL, NULL),
(292, 104, 'Your requested book \"Contemporary Social Philosophy\" is now ready to be claimed at the library. Please proceed to the library counter and present the QR code from your email.', '2026-03-25 17:25:25', 0, 0, 0, NULL, NULL),
(293, 104, 'Your borrow request for \"Basic Mathematics\" has been approved. Check your email for the QR code. You have 24 hours to collect the book.', '2026-03-25 17:25:32', 0, 0, 0, NULL, NULL),
(294, 104, 'Your requested book \"Basic Mathematics\" is now ready to be claimed at the library. Please proceed to the library counter and present the QR code from your email.', '2026-03-25 17:25:32', 0, 0, 0, NULL, NULL),
(295, 104, 'Urgent: Liability case opened for \"Contemporary Social Philosophy\" (DAMAGED). Please settle replacement/payment with library staff.', '2026-03-25 17:27:48', 1, 1, 1, 6, '2026-03-26 01:36:07'),
(296, 105, 'Your borrow request for \"Basic Mathematics\" has been approved. Check your email for the QR code. You have 24 hours to collect the book.', '2026-03-26 04:31:48', 0, 0, 0, NULL, NULL),
(297, 105, 'Your requested book \"Basic Mathematics\" is now ready to be claimed at the library. Please proceed to the library counter and present the QR code from your email.', '2026-03-26 04:31:48', 0, 0, 0, NULL, NULL),
(298, 105, 'Your borrow request for \"Introduction to c#\" has been approved. Check your email for the QR code. You have 24 hours to collect the book.', '2026-03-26 04:32:05', 0, 0, 0, NULL, NULL),
(299, 105, 'Your requested book \"Introduction to c#\" is now ready to be claimed at the library. Please proceed to the library counter and present the QR code from your email.', '2026-03-26 04:32:05', 0, 0, 0, NULL, NULL),
(300, 105, 'Urgent: Liability case opened for \"Introduction to c#\" (DAMAGED). Please settle replacement/payment with library staff.', '2026-03-26 04:54:30', 0, 1, 1, 7, NULL),
(301, 104, 'Your borrow request for \"Introduction to c#\" has been approved. Check your email for the QR code. You have 24 hours to collect the book.', '2026-03-26 05:06:09', 0, 0, 0, NULL, NULL),
(302, 104, 'Your requested book \"Introduction to c#\" is now ready to be claimed at the library. Please proceed to the library counter and present the QR code from your email.', '2026-03-26 05:06:09', 0, 0, 0, NULL, NULL),
(303, 104, 'OVERDUE REMINDER: Your book \"Introduction to c#\" is 3 day(s) overdue. Please return it immediately to avoid penalties.', '2026-03-26 05:12:15', 0, 0, 0, NULL, NULL),
(304, 94, '📖 E-Book Request: John Brian F Bautista requested access to \"Angular 2\" for 7 days.', '2026-03-26 05:19:55', 0, 0, 0, NULL, NULL),
(305, 103, '📖 E-Book Request: John Brian F Bautista requested access to \"Angular 2\" for 7 days.', '2026-03-26 05:19:55', 0, 0, 0, NULL, NULL),
(306, 104, '📖 Your e-book access request for \"Angular 2\" has been submitted. Waiting for admin approval.', '2026-03-26 05:19:55', 0, 0, 0, NULL, NULL),
(307, 104, '✅ Your e-book access request for \"Angular 2\" has been approved! You have 7 days to read.', '2026-03-26 05:20:13', 0, 0, 0, NULL, NULL),
(308, 104, 'OVERDUE REMINDER: Your book \"Introduction to c#\" is 7 day(s) overdue. Please return it immediately to avoid penalties.', '2026-03-30 01:27:26', 0, 0, 0, NULL, NULL),
(309, 104, 'OVERDUE REMINDER: Your book \"Basic Mathematics\" is 3 day(s) overdue. Please return it immediately to avoid penalties.', '2026-03-30 01:27:26', 0, 0, 0, NULL, NULL),
(310, 104, '📕 Your e-book access to \"Angular 2\" has expired. You can request access again anytime.', '2026-04-10 15:07:48', 0, 0, 0, NULL, NULL),
(311, 106, 'Your borrow request for \"Basic Mathematics\" has been approved. Check your email for the QR code. You have 24 hours to collect the book.', '2026-04-10 15:13:06', 0, 0, 0, NULL, NULL),
(312, 106, 'Your requested book \"Basic Mathematics\" is now ready to be claimed at the library. Please proceed to the library counter and present the QR code from your email.', '2026-04-10 15:13:06', 0, 0, 0, NULL, NULL),
(313, 106, 'Your borrow request for \"Basic Mathematics\" has been approved. Check your email for the QR code. You have 24 hours to collect the book.', '2026-04-10 15:26:04', 0, 0, 0, NULL, NULL),
(314, 106, 'Your requested book \"Basic Mathematics\" is now ready to be claimed at the library. Please proceed to the library counter and present the QR code from your email.', '2026-04-10 15:26:04', 0, 0, 0, NULL, NULL),
(315, 106, 'Your borrow request for \"Basic Mathematics\" has been automatically cancelled because it was not collected within 24 hours.', '2026-04-10 15:40:05', 0, 0, 0, NULL, NULL),
(316, 106, 'Your borrow request for \"Contemporary Social Philosophy\" has been approved. Check your email for the QR code. You have 24 hours to collect the book.', '2026-04-10 15:42:54', 0, 0, 0, NULL, NULL),
(317, 106, 'Your requested book \"Contemporary Social Philosophy\" is now ready to be claimed at the library. Please proceed to the library counter and present the QR code from your email.', '2026-04-10 15:42:54', 0, 0, 0, NULL, NULL),
(318, 106, 'OVERDUE REMINDER: Your book \"Contemporary Social Philosophy\" is 1 day(s) overdue. Please return it immediately to avoid penalties.', '2026-04-10 15:56:42', 0, 0, 0, NULL, NULL),
(319, 94, '📖 E-Book Request: John Brian F Bautista requested access to \"Object Oriented Programming using Java\" for 7 days.', '2026-04-14 06:50:24', 0, 0, 0, NULL, NULL),
(320, 103, '📖 E-Book Request: John Brian F Bautista requested access to \"Object Oriented Programming using Java\" for 7 days.', '2026-04-14 06:50:24', 0, 0, 0, NULL, NULL),
(321, 104, '📖 Your e-book access request for \"Object Oriented Programming using Java\" has been submitted. Waiting for admin approval.', '2026-04-14 06:50:24', 0, 0, 0, NULL, NULL),
(322, 104, '✅ Your e-book access request for \"Object Oriented Programming using Java\" has been approved! You have 7 days to read.', '2026-04-14 06:50:39', 0, 0, 0, NULL, NULL),
(323, 105, 'Your borrow request for \"Basic Mathematics\" has been automatically cancelled because it was not collected within 24 hours.', '2026-04-14 10:31:37', 0, 0, 0, NULL, NULL),
(324, 105, 'Your borrow request for \"LOL\" has been approved. Check your email for the QR code. You have 24 hours to collect the book.', '2026-04-14 10:32:06', 0, 0, 0, NULL, NULL),
(325, 105, 'Your requested book \"LOL\" is now ready to be claimed at the library. Please proceed to the library counter and present the QR code from your email.', '2026-04-14 10:32:06', 0, 0, 0, NULL, NULL),
(326, 104, '📕 Your e-book access to \"Object Oriented Programming using Java\" has expired. You can request access again anytime.', '2026-04-23 14:29:56', 0, 0, 0, NULL, NULL),
(327, 105, 'OVERDUE REMINDER: Your book \"LOL\" is 3 day(s) overdue. Please return it immediately to avoid penalties.', '2026-04-23 14:44:45', 0, 0, 0, NULL, NULL),
(328, 94, '📖 E-Book Request: Joshua Mendiola requested access to \"Angular 2\" for 7 days.', '2026-04-24 03:55:44', 0, 0, 0, NULL, NULL),
(329, 103, '📖 E-Book Request: Joshua Mendiola requested access to \"Angular 2\" for 7 days.', '2026-04-24 03:55:44', 0, 0, 0, NULL, NULL),
(330, 105, '📖 Your e-book access request for \"Angular 2\" has been submitted. Waiting for admin approval.', '2026-04-24 03:55:44', 0, 0, 0, NULL, NULL),
(331, 105, '✅ Your e-book access request for \"Angular 2\" has been approved! You have 7 days to read.', '2026-04-24 03:55:57', 0, 0, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(128) NOT NULL,
  `expires_at` datetime NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`id`, `user_id`, `token`, `expires_at`, `used`, `created_at`) VALUES
(1, 95, '78c20a8135cad47606ce35c168e3c7467e07f409a3ce1df70da43d92e1ceaace', '2026-02-11 02:16:34', 1, '2026-02-10 17:16:34'),
(0, 87, 'bd1e8992a192e09463c44c4c476471973a0f9b7887be7a1bba2ff0edeb399fee', '2026-03-25 22:55:33', 1, '2026-03-25 13:55:33');

-- --------------------------------------------------------

--
-- Table structure for table `reservations`
--

CREATE TABLE `reservations` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `reserved_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('pending','approved','declined') DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `return_tickets`
--

CREATE TABLE `return_tickets` (
  `id` int(11) NOT NULL,
  `borrow_id` int(11) NOT NULL,
  `ticket_hash` varchar(128) NOT NULL COMMENT 'SHA256 of ticket data',
  `ticket_payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'Encrypted ticket contents for audit' CHECK (json_valid(`ticket_payload`)),
  `image_filename` varchar(255) DEFAULT NULL COMMENT 'PNG filename',
  `generated_at` datetime DEFAULT current_timestamp(),
  `emailed_at` datetime DEFAULT NULL,
  `downloaded_at` datetime DEFAULT NULL,
  `first_scan_at` datetime DEFAULT NULL COMMENT 'First time QR was scanned',
  `validated_at` datetime DEFAULT NULL COMMENT 'When return was processed',
  `is_valid` tinyint(1) DEFAULT 1 COMMENT 'FALSE after return or expiration',
  `scan_count` int(11) DEFAULT 0 COMMENT '0=unused, 1=collected, 2=returned',
  `collected_at` datetime DEFAULT NULL COMMENT 'When book was physically collected',
  `collected_by_admin_id` int(11) DEFAULT NULL COMMENT 'Admin who processed collection',
  `invalidated_reason` varchar(100) DEFAULT NULL,
  `scanned_by_admin_id` int(11) DEFAULT NULL,
  `scan_location` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `return_tickets`
--

INSERT INTO `return_tickets` (`id`, `borrow_id`, `ticket_hash`, `ticket_payload`, `image_filename`, `generated_at`, `emailed_at`, `downloaded_at`, `first_scan_at`, `validated_at`, `is_valid`, `scan_count`, `collected_at`, `collected_by_admin_id`, `invalidated_reason`, `scanned_by_admin_id`, `scan_location`) VALUES
(46, 198, '6f4bb2dddc6cdb395422d7a2b7c09937f34278ba3ba01a10d74367795107886c', '{\"ticket_id\":\"RTK-A3A878C2DDA5\",\"borrow_id\":198,\"book_id\":155,\"user_id\":104,\"due_date\":\"2026-03-27 23:59:59\",\"generated_at\":\"2026-03-26 01:25:21\"}', NULL, '2026-03-26 01:25:21', NULL, NULL, '2026-03-26 01:27:28', '2026-03-26 01:27:48', 0, 2, '2026-03-26 01:27:28', 94, NULL, 94, NULL),
(47, 199, '7cae115841513b117e4878f65f040b479e7161253956cc69221bb025abfac7eb', '{\"ticket_id\":\"RTK-52C386A37447\",\"borrow_id\":199,\"book_id\":156,\"user_id\":104,\"due_date\":\"2026-03-27 23:59:59\",\"generated_at\":\"2026-03-26 01:25:29\"}', NULL, '2026-03-26 01:25:29', NULL, NULL, '2026-03-26 01:30:18', NULL, 1, 1, '2026-03-26 01:30:18', 94, NULL, NULL, NULL),
(48, 200, '1500b9cc009592e6e428e5ae4fde47dcf93e8ae4b952c8c484cb1bc6ac57e202', '{\"ticket_id\":\"RTK-B2D38CC9CEC3\",\"borrow_id\":200,\"book_id\":156,\"user_id\":105,\"due_date\":\"2026-03-27 23:59:59\",\"generated_at\":\"2026-03-26 12:31:46\"}', NULL, '2026-03-26 12:31:46', NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL),
(49, 201, 'cef13c720240ccaca0885817f54ae0ca8c93c7ff393c28747945c2e00bb0fe54', '{\"ticket_id\":\"RTK-A726105360D5\",\"borrow_id\":201,\"book_id\":159,\"user_id\":105,\"due_date\":\"2026-03-27 23:59:59\",\"generated_at\":\"2026-03-26 12:32:02\"}', NULL, '2026-03-26 12:32:02', NULL, NULL, '2026-03-26 12:36:10', '2026-03-26 12:54:30', 0, 2, '2026-03-26 12:36:10', 103, NULL, 103, NULL),
(50, 202, '3034be0e6b0e0a853aa70a234c701b0ea89b003083ead02f7da0d8d30feb7950', '{\"ticket_id\":\"RTK-B85094C38C64\",\"borrow_id\":202,\"book_id\":159,\"user_id\":104,\"due_date\":\"2026-03-27 23:59:59\",\"generated_at\":\"2026-03-26 13:06:06\"}', NULL, '2026-03-26 13:06:06', NULL, NULL, '2026-03-26 13:06:57', NULL, 1, 1, '2026-03-26 13:06:57', 103, NULL, NULL, NULL),
(51, 203, '5ea76a71898ee5fc21f24f6fd43e93dd3cb905af00f65217b88b430ec32d8017', '{\"ticket_id\":\"RTK-A0F401CAE2E4\",\"borrow_id\":203,\"book_id\":156,\"user_id\":106,\"due_date\":\"2026-04-15 23:59:59\",\"generated_at\":\"2026-04-10 23:13:04\"}', NULL, '2026-04-10 23:13:04', NULL, NULL, '2026-04-10 23:15:05', '2026-04-10 23:15:28', 0, 2, '2026-04-10 23:15:05', 94, NULL, 94, NULL),
(52, 204, '7fb5b77f51ad355c656bac568e681920db2a3fb4aaa885833926108622363063', '{\"ticket_id\":\"RTK-0783338E5530\",\"borrow_id\":204,\"book_id\":156,\"user_id\":106,\"due_date\":\"2026-04-16 23:59:59\",\"generated_at\":\"2026-04-10 23:26:02\"}', NULL, '2026-04-10 23:26:02', NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL),
(53, 205, 'a6793596aad7b887e51ed32c9688a469870e47eaf08152821c45e2ae2eac408a', '{\"ticket_id\":\"RTK-916A9CDD7D33\",\"borrow_id\":205,\"book_id\":155,\"user_id\":106,\"due_date\":\"2026-04-16 23:59:59\",\"generated_at\":\"2026-04-10 23:42:52\"}', NULL, '2026-04-10 23:42:52', NULL, NULL, '2026-04-10 23:55:05', NULL, 1, 1, '2026-04-10 23:55:05', 94, NULL, NULL, NULL),
(54, 206, '410e186ec1584b971d2b06fe03af711970959d082ad3315bc3e83e34678c3375', '{\"ticket_id\":\"RTK-CDC50927CFBB\",\"borrow_id\":206,\"book_id\":160,\"user_id\":105,\"due_date\":\"2026-04-20 23:59:59\",\"generated_at\":\"2026-04-14 18:32:04\"}', NULL, '2026-04-14 18:32:04', NULL, NULL, '2026-04-14 18:33:43', NULL, 1, 1, '2026-04-14 18:33:43', 103, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `security_log`
--

CREATE TABLE `security_log` (
  `id` int(11) NOT NULL,
  `event_type` enum('handshake_initiated','handshake_scanned','handshake_confirmed','handshake_expired','handshake_cancelled','ticket_generated','ticket_downloaded','ticket_emailed','book_collected','return_scanned','return_validated','return_rejected','book_returned','invalid_token','tampering_detected','rate_limit_exceeded','qr_email_sent','borrow_auto_expired') NOT NULL,
  `borrow_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `details` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Additional context' CHECK (json_valid(`details`)),
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `security_log`
--

INSERT INTO `security_log` (`id`, `event_type`, `borrow_id`, `user_id`, `admin_id`, `ip_address`, `user_agent`, `details`, `created_at`) VALUES
(121, 'book_collected', 198, 104, 94, '112.207.160.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '{\"book_title\":\"Contemporary Social Philosophy\",\"student_name\":\"John\",\"collected_via\":\"qr_scanner\",\"ticket_hash\":\"6f4bb2dddc6cdb39...\"}', '2026-03-26 01:27:28'),
(122, 'book_returned', 198, 104, 94, '112.207.160.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '{\"book_title\":\"Contemporary Social Philosophy\",\"returned_via\":\"qr_scanner\",\"ticket_hash\":\"6f4bb2dddc6cdb39...\",\"return_condition\":\"damaged\",\"damage_case_id\":6,\"overdue_fee_paid\":false,\"overdue_fee_amount\":0}', '2026-03-26 01:27:48'),
(123, 'book_collected', 199, 104, 94, '112.207.160.3', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '{\"book_title\":\"Basic Mathematics\",\"student_name\":\"John\",\"collected_via\":\"qr_scanner\",\"ticket_hash\":\"7cae115841513b11...\"}', '2026-03-26 01:30:18'),
(124, 'book_collected', 201, 105, 103, '175.176.28.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '{\"book_title\":\"Introduction to c#\",\"student_name\":\"Joshua\",\"collected_via\":\"qr_scanner\",\"ticket_hash\":\"cef13c720240ccac...\"}', '2026-03-26 12:36:10'),
(125, 'book_returned', 201, 105, 103, '175.176.28.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '{\"book_title\":\"Introduction to c#\",\"returned_via\":\"qr_scanner\",\"ticket_hash\":\"cef13c720240ccac...\",\"return_condition\":\"damaged\",\"damage_case_id\":7,\"overdue_fee_paid\":false,\"overdue_fee_amount\":0}', '2026-03-26 12:54:30'),
(126, 'book_collected', 202, 104, 103, '175.176.28.246', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '{\"book_title\":\"Introduction to c#\",\"student_name\":\"John\",\"collected_via\":\"qr_scanner\",\"ticket_hash\":\"3034be0e6b0e0a85...\"}', '2026-03-26 13:06:57'),
(127, '', NULL, 104, NULL, '175.176.28.246', NULL, '{\"book_id\":158,\"book_title\":\"Angular 2\",\"access_id\":46,\"action\":\"view\"}', '2026-03-26 13:20:28'),
(128, '', NULL, 104, NULL, '175.176.28.246', NULL, '{\"book_id\":158,\"book_title\":\"Angular 2\",\"access_id\":46,\"action\":\"view\"}', '2026-03-26 13:20:59'),
(129, '', NULL, 104, NULL, 'system', NULL, '{\"access_id\":46,\"book_title\":\"Angular 2\",\"student\":\"John\",\"expired_at\":\"2026-04-02 13:20:13\",\"processed_by\":\"autoExpireEbookAccess\"}', '2026-04-10 23:07:48'),
(130, 'book_collected', 203, 106, 94, '49.151.172.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', '{\"book_title\":\"Basic Mathematics\",\"student_name\":\"Neo\",\"collected_via\":\"qr_scanner\",\"ticket_hash\":\"5ea76a71898ee5fc...\"}', '2026-04-10 23:15:05'),
(131, 'book_returned', 203, 106, 94, '49.151.172.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', '{\"book_title\":\"Basic Mathematics\",\"returned_via\":\"qr_scanner\",\"ticket_hash\":\"5ea76a71898ee5fc...\",\"return_condition\":\"good\",\"damage_case_id\":null,\"overdue_fee_paid\":false,\"overdue_fee_amount\":0}', '2026-04-10 23:15:28'),
(132, '', NULL, NULL, 94, '49.151.172.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', '{\"year\":2026,\"month\":4,\"added_dates\":[\"2026-04-13\"],\"removed_dates\":[],\"borrows_extended\":0,\"action\":\"holidays_bulk_update\"}', '2026-04-10 23:25:42'),
(133, 'borrow_auto_expired', 204, 106, NULL, 'system', 'borrow_helper.autoRejectExpiredBorrows', '{\"book_title\":\"Basic Mathematics\",\"student\":\"Neo\",\"previous_status\":\"approved\",\"action\":\"auto_rejected_24h_expiry\"}', '2026-04-10 23:40:05'),
(134, 'book_collected', 205, 106, 94, '49.151.172.105', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 OPR/129.0.0.0', '{\"book_title\":\"Contemporary Social Philosophy\",\"student_name\":\"Neo\",\"collected_via\":\"qr_scanner\",\"ticket_hash\":\"a6793596aad7b887...\"}', '2026-04-10 23:55:05'),
(135, '', NULL, NULL, 103, '175.176.28.24', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '{\"year\":2026,\"month\":6,\"added_dates\":[\"2026-06-16\"],\"removed_dates\":[],\"borrows_extended\":0,\"action\":\"holidays_bulk_update\"}', '2026-04-14 14:48:11'),
(136, '', NULL, NULL, 103, '175.176.28.24', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '{\"year\":2026,\"month\":6,\"added_dates\":[],\"removed_dates\":[\"2026-06-16\"],\"borrows_extended\":0,\"action\":\"holidays_bulk_update\"}', '2026-04-14 14:48:18'),
(137, '', NULL, 104, NULL, '175.176.28.24', NULL, '{\"book_id\":157,\"book_title\":\"Object Oriented Programming using Java\",\"access_id\":47,\"action\":\"view\"}', '2026-04-14 14:50:48'),
(138, '', NULL, NULL, 103, '119.93.175.103', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '{\"year\":2026,\"month\":6,\"added_dates\":[\"2026-06-17\"],\"removed_dates\":[],\"borrows_extended\":0,\"action\":\"holidays_bulk_update\"}', '2026-04-14 17:22:53'),
(139, '', NULL, 104, NULL, '216.247.95.145', NULL, '{\"book_id\":157,\"book_title\":\"Object Oriented Programming using Java\",\"access_id\":47,\"action\":\"view\"}', '2026-04-14 17:49:28'),
(140, '', NULL, NULL, 103, '216.247.95.145', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '{\"year\":2026,\"month\":4,\"added_dates\":[\"2026-04-17\"],\"removed_dates\":[],\"borrows_extended\":0,\"action\":\"holidays_bulk_update\"}', '2026-04-14 18:28:42'),
(141, 'borrow_auto_expired', 200, 105, NULL, 'system', 'borrow_helper.autoRejectExpiredBorrows', '{\"book_title\":\"Basic Mathematics\",\"student\":\"Joshua\",\"previous_status\":\"approved\",\"action\":\"auto_rejected_24h_expiry\"}', '2026-04-14 18:31:37'),
(142, 'book_collected', 206, 105, 103, '216.247.95.145', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36 Edg/146.0.0.0', '{\"book_title\":\"LOL\",\"student_name\":\"Joshua\",\"collected_via\":\"qr_scanner\",\"ticket_hash\":\"410e186ec1584b97...\"}', '2026-04-14 18:33:43'),
(143, '', NULL, 104, NULL, 'system', NULL, '{\"access_id\":47,\"book_title\":\"Object Oriented Programming using Java\",\"student\":\"John\",\"expired_at\":\"2026-04-21 14:50:39\",\"processed_by\":\"autoExpireEbookAccess\"}', '2026-04-23 22:29:56');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('student','staff','librarian','admin') NOT NULL DEFAULT 'student',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `student_id` varchar(50) NOT NULL,
  `full_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role`, `created_at`, `email`, `phone`, `status`, `student_id`, `full_name`) VALUES
(94, 'ico', '$2y$10$5VR4NqeL9VDEZt1LR1sRKOU7Fut4Nypo0lppnn7vQ/oRvkvCpZ4Fu', 'admin', '2026-01-23 04:13:09', 'ico@admin.com', NULL, 'active', '', NULL),
(103, 'STIadmin', '$2y$10$9xoBbOstYJG5gonCTI2adesBwUmpTTrQ0Oz7t0hZ2nVNgEIUmUnJ.', 'admin', '2026-03-25 17:10:25', 'stibalagtas2025@gmail.com', '09751897945', 'active', '', NULL),
(104, 'John', '$2y$10$K0A5SEoJdO8UPlnCp9VjsO9ZZTgYRCGu8u6c34t7bfz0XT9cveRy6', 'student', '2026-03-25 17:12:29', 'Johnbrian12121@gmail.com', '9606941233', 'active', '9995601', 'John Brian F Bautista'),
(105, 'Joshua', '$2y$10$1G6vfUe/hgpi99IohL.P8uzesoFQkEXX9Ci7egauzSCNyFfVgawU2', 'student', '2026-03-25 17:12:29', 'joshuamendiola887@gmail.com', '9087034626', 'active', '2025002', 'Joshua Mendiola'),
(106, 'Neo', '$2y$10$GlvlQdiDN5RHlvSSKNijU.mMg.IjFkLSiwYgLRySm.EtSbzMc8g0m', 'student', '2026-04-10 15:12:25', 'neotorcuator1616@gmail.com', '09432548010', 'active', '', NULL);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_active_ebook_access`
-- (See below for the actual view)
--
CREATE TABLE `v_active_ebook_access` (
`access_id` int(11)
,`user_id` int(11)
,`username` varchar(50)
,`student_name` varchar(255)
,`book_id` int(11)
,`book_title` varchar(255)
,`author` varchar(255)
,`pdf_file` varchar(255)
,`status` enum('pending','approved','active','expired','rejected','revoked','cancelled')
,`access_granted_at` datetime
,`expires_at` datetime
,`access_count` int(11)
,`last_accessed_at` datetime
,`days_remaining` int(8)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_pending_ebook_requests`
-- (See below for the actual view)
--
CREATE TABLE `v_pending_ebook_requests` (
`access_id` int(11)
,`user_id` int(11)
,`username` varchar(50)
,`student_name` varchar(255)
,`student_email` varchar(100)
,`book_id` int(11)
,`book_title` varchar(255)
,`author` varchar(255)
,`book_image` varchar(255)
,`requested_at` datetime
,`requested_days` tinyint(3) unsigned
,`hours_pending` bigint(21)
);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `book_copies`
--
ALTER TABLE `book_copies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `borrows`
--
ALTER TABLE `borrows`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_overdue_check` (`status`,`return_date`,`due_date`);

--
-- Indexes for table `borrow_requests`
--
ALTER TABLE `borrow_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `damage_cases`
--
ALTER TABLE `damage_cases`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `damage_case_events`
--
ALTER TABLE `damage_case_events`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `damage_case_payments`
--
ALTER TABLE `damage_case_payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ebook_access`
--
ALTER TABLE `ebook_access`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `return_tickets`
--
ALTER TABLE `return_tickets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `security_log`
--
ALTER TABLE `security_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=161;

--
-- AUTO_INCREMENT for table `book_copies`
--
ALTER TABLE `book_copies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `borrows`
--
ALTER TABLE `borrows`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=207;

--
-- AUTO_INCREMENT for table `borrow_requests`
--
ALTER TABLE `borrow_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `damage_cases`
--
ALTER TABLE `damage_cases`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `damage_case_events`
--
ALTER TABLE `damage_case_events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `damage_case_payments`
--
ALTER TABLE `damage_case_payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `ebook_access`
--
ALTER TABLE `ebook_access`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=332;

--
-- AUTO_INCREMENT for table `return_tickets`
--
ALTER TABLE `return_tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `security_log`
--
ALTER TABLE `security_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=144;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=107;

-- --------------------------------------------------------

--
-- Structure for view `v_active_ebook_access`
--
DROP TABLE IF EXISTS `v_active_ebook_access`;

CREATE ALGORITHM=UNDEFINED DEFINER=`u470144664_root`@`127.0.0.1` SQL SECURITY DEFINER VIEW `v_active_ebook_access`  AS SELECT `ea`.`id` AS `access_id`, `ea`.`user_id` AS `user_id`, `u`.`username` AS `username`, `u`.`full_name` AS `student_name`, `ea`.`book_id` AS `book_id`, `b`.`title` AS `book_title`, `b`.`author` AS `author`, `b`.`pdf_file` AS `pdf_file`, `ea`.`status` AS `status`, `ea`.`access_granted_at` AS `access_granted_at`, `ea`.`expires_at` AS `expires_at`, `ea`.`access_count` AS `access_count`, `ea`.`last_accessed_at` AS `last_accessed_at`, to_days(`ea`.`expires_at`) - to_days(current_timestamp()) AS `days_remaining` FROM ((`ebook_access` `ea` join `users` `u` on(`ea`.`user_id` = `u`.`id`)) join `books` `b` on(`ea`.`book_id` = `b`.`id`)) WHERE `ea`.`status` in ('approved','active') ;

-- --------------------------------------------------------

--
-- Structure for view `v_pending_ebook_requests`
--
DROP TABLE IF EXISTS `v_pending_ebook_requests`;

CREATE ALGORITHM=UNDEFINED DEFINER=`u470144664_root`@`127.0.0.1` SQL SECURITY DEFINER VIEW `v_pending_ebook_requests`  AS SELECT `ea`.`id` AS `access_id`, `ea`.`user_id` AS `user_id`, `u`.`username` AS `username`, `u`.`full_name` AS `student_name`, `u`.`email` AS `student_email`, `ea`.`book_id` AS `book_id`, `b`.`title` AS `book_title`, `b`.`author` AS `author`, `b`.`image` AS `book_image`, `ea`.`requested_at` AS `requested_at`, `ea`.`requested_days` AS `requested_days`, timestampdiff(HOUR,`ea`.`requested_at`,current_timestamp()) AS `hours_pending` FROM ((`ebook_access` `ea` join `users` `u` on(`ea`.`user_id` = `u`.`id`)) join `books` `b` on(`ea`.`book_id` = `b`.`id`)) WHERE `ea`.`status` = 'pending' ORDER BY `ea`.`requested_at` ASC ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
