-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 16, 2026 at 02:05 PM
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
-- Database: `seo_autopilot`
--

-- --------------------------------------------------------

--
-- Table structure for table `ai_conversations`
--

CREATE TABLE `ai_conversations` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `website_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ai_credit_balances`
--

CREATE TABLE `ai_credit_balances` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `credits` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ai_messages`
--

CREATE TABLE `ai_messages` (
  `id` int(10) UNSIGNED NOT NULL,
  `conversation_id` int(10) UNSIGNED NOT NULL,
  `role` varchar(20) NOT NULL,
  `content` mediumtext NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ai_usage`
--

CREATE TABLE `ai_usage` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `website_id` int(10) UNSIGNED NOT NULL,
  `status` varchar(20) NOT NULL,
  `tokens` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `credits_used` tinyint(3) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `api_logs`
--

CREATE TABLE `api_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `provider` varchar(60) NOT NULL,
  `status` varchar(30) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `action` varchar(100) NOT NULL,
  `context` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`context`)),
  `ip` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `audit_logs`
--

INSERT INTO `audit_logs` (`id`, `user_id`, `action`, `context`, `ip`, `created_at`) VALUES
(3, 2, 'registered', '[]', '::1', '2026-09-09 12:13:07'),
(4, 2, 'website.created', '{\"id\":\"1\"}', '::1', '2026-09-09 12:13:47'),
(10, 2, 'logout', '[]', '::1', '2026-09-09 12:29:36'),
(11, 2, 'login', '[]', '::1', '2026-09-09 12:30:10'),
(12, 2, 'competitors.saved', '{\"id\":1,\"website_id\":1}', '::1', '2026-09-09 12:34:01'),
(13, 2, 'backlinks.saved', '{\"id\":1,\"website_id\":1}', '::1', '2026-09-09 12:35:07'),
(14, 2, 'record.deleted', '{\"module\":\"backlinks\"}', '::1', '2026-09-09 12:35:34'),
(17, 2, 'login', '[]', '::1', '2026-09-09 12:43:14'),
(18, 2, 'logout', '[]', '::1', '2026-09-09 12:43:42'),
(19, 2, 'login', '[]', '::1', '2026-09-10 04:46:50'),
(20, 2, 'keywords.saved', '{\"id\":1,\"website_id\":1}', '::1', '2026-09-10 04:59:45'),
(21, 2, 'keywords.saved', '{\"id\":2,\"website_id\":1}', '::1', '2026-09-10 05:10:33'),
(22, 2, 'record.deleted', '{\"module\":\"tasks\"}', '::1', '2026-09-10 05:36:14'),
(23, 2, 'logout', '[]', '::1', '2026-09-10 05:37:08'),
(24, 2, 'login', '[]', '::1', '2026-09-10 07:13:28'),
(25, 2, 'login', '[]', '::1', '2026-09-10 07:20:12'),
(26, 2, 'login', '[]', '::1', '2026-09-12 04:51:32'),
(27, 2, 'keywords.saved', '{\"id\":3,\"website_id\":1}', '::1', '2026-09-12 04:52:32'),
(28, 2, 'login', '[]', '::1', '2026-09-12 06:32:39'),
(29, 2, 'backlinks.saved', '{\"id\":2,\"website_id\":1}', '::1', '2026-09-12 06:37:05'),
(30, 2, 'login', '[]', '::1', '2026-09-12 07:20:16'),
(31, 2, 'login', '[]', '::1', '2026-09-12 10:17:21'),
(32, 2, 'logout', '[]', '::1', '2026-09-12 10:27:37'),
(33, 2, 'login', '[]', '::1', '2026-09-12 11:03:25'),
(34, 2, 'login', '[]', '::1', '2026-09-12 11:15:15'),
(35, 2, 'login', '[]', '::1', '2026-09-12 11:33:42'),
(36, 2, 'login', '[]', '::1', '2026-09-14 10:18:58'),
(37, 2, 'chat.widget.saved', '{\"id\":1}', '::1', '2026-09-14 10:21:19'),
(38, 2, 'logout', '[]', '::1', '2026-09-14 10:42:45'),
(39, 2, 'login', '[]', '::1', '2026-09-15 08:32:50'),
(40, 2, 'logout', '[]', '::1', '2026-09-15 08:35:39'),
(41, 2, 'login', '[]', '::1', '2026-09-15 09:32:07'),
(42, 2, 'login', '[]', '::1', '2026-09-16 08:39:09'),
(43, 2, 'logout', '[]', '::1', '2026-09-16 08:46:20'),
(44, 2, 'login', '[]', '::1', '2026-09-16 10:19:43'),
(45, 2, 'logout', '[]', '::1', '2026-09-16 11:19:46'),
(46, 2, 'login', '[]', '::1', '2026-09-16 11:24:13');

-- --------------------------------------------------------

--
-- Table structure for table `auth_tokens`
--

CREATE TABLE `auth_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `token_hash` char(64) NOT NULL,
  `purpose` enum('reset','verify','remember') NOT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_tokens`
--

INSERT INTO `auth_tokens` (`id`, `user_id`, `token_hash`, `purpose`, `expires_at`, `created_at`) VALUES
(1, 2, '5140e5c757045cdfef29c4035654252eeb141a24ca676cf6452c01f6c3817836', 'verify', '2026-09-11 17:43:07', '2026-09-09 12:13:07');

-- --------------------------------------------------------

--
-- Table structure for table `automation_rules`
--

CREATE TABLE `automation_rules` (
  `id` int(10) UNSIGNED NOT NULL,
  `website_id` int(10) UNSIGNED NOT NULL,
  `code` varchar(80) NOT NULL,
  `enabled` tinyint(4) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `automation_rules`
--

INSERT INTO `automation_rules` (`id`, `website_id`, `code`, `enabled`) VALUES
(1, 1, 'missing_description', 0);

-- --------------------------------------------------------

--
-- Table structure for table `backlinks`
--

CREATE TABLE `backlinks` (
  `id` int(10) UNSIGNED NOT NULL,
  `website_id` int(10) UNSIGNED NOT NULL,
  `source_url` varchar(1000) NOT NULL,
  `target_url` varchar(1000) NOT NULL,
  `anchor` varchar(255) DEFAULT '',
  `domain` varchar(255) NOT NULL,
  `domain_rating` decimal(5,2) DEFAULT NULL,
  `follow` enum('follow','nofollow') DEFAULT 'follow',
  `first_seen` date NOT NULL,
  `last_seen` date NOT NULL,
  `status` enum('active','lost') DEFAULT 'active',
  `source` varchar(30) DEFAULT 'manual',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `backlinks`
--

INSERT INTO `backlinks` (`id`, `website_id`, `source_url`, `target_url`, `anchor`, `domain`, `domain_rating`, `follow`, `first_seen`, `last_seen`, `status`, `source`, `created_at`) VALUES
(2, 1, 'https://www.opendi.in/new-delhi/500787.html', 'https://viraladsmedia.com/', 'www.viraladsmedia.com', 'www.opendi.in', NULL, 'follow', '2026-09-10', '2026-09-10', 'lost', 'verified', '2026-09-10 05:43:58');

-- --------------------------------------------------------

--
-- Table structure for table `chat_automation_rules`
--

CREATE TABLE `chat_automation_rules` (
  `id` int(10) UNSIGNED NOT NULL,
  `widget_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `keyword` varchar(120) NOT NULL DEFAULT '',
  `min_score` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `target_status` enum('New','Contacted','Qualified','Converted') NOT NULL DEFAULT 'Qualified',
  `enabled` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `chat_conversations`
--

CREATE TABLE `chat_conversations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `widget_id` int(10) UNSIGNED NOT NULL,
  `token_hash` char(64) NOT NULL,
  `origin` varchar(255) NOT NULL,
  `mode` enum('bot','human','closed') NOT NULL DEFAULT 'bot',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `expires_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chat_conversations`
--

INSERT INTO `chat_conversations` (`id`, `widget_id`, `token_hash`, `origin`, `mode`, `created_at`, `updated_at`, `expires_at`) VALUES
(1, 1, '458baf0ae222619b92c799c04dd7ea978c06308c3112ddd78a13c25fe4567131', 'http://localhost', 'bot', '2026-09-16 11:16:48', '2026-09-16 11:19:06', '2026-09-23 16:46:48');

-- --------------------------------------------------------

--
-- Table structure for table `chat_knowledge`
--

CREATE TABLE `chat_knowledge` (
  `id` int(10) UNSIGNED NOT NULL,
  `widget_id` int(10) UNSIGNED NOT NULL,
  `question` varchar(300) NOT NULL,
  `keywords` varchar(500) NOT NULL DEFAULT '',
  `answer` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `chat_leads`
--

CREATE TABLE `chat_leads` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `widget_id` int(10) UNSIGNED NOT NULL,
  `conversation_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL DEFAULT '',
  `phone` varchar(40) NOT NULL DEFAULT '',
  `email` varchar(190) NOT NULL DEFAULT '',
  `service` varchar(190) NOT NULL DEFAULT '',
  `message` text NOT NULL,
  `status` enum('New','Contacted','Qualified','Converted') NOT NULL DEFAULT 'New',
  `score` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `notes` text NOT NULL,
  `consent_at` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chat_leads`
--

INSERT INTO `chat_leads` (`id`, `widget_id`, `conversation_id`, `name`, `phone`, `email`, `service`, `message`, `status`, `score`, `notes`, `consent_at`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'Subham', '07535898638', 'rj9work@gmail.com', 'seo', 'i want to need', 'New', 90, '', '2026-09-16 16:49:06', '2026-09-16 11:19:06', '2026-09-16 11:19:06');

-- --------------------------------------------------------

--
-- Table structure for table `chat_messages`
--

CREATE TABLE `chat_messages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `conversation_id` bigint(20) UNSIGNED NOT NULL,
  `role` enum('visitor','assistant','agent','system') NOT NULL,
  `body` text NOT NULL,
  `client_id` varchar(64) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chat_messages`
--

INSERT INTO `chat_messages` (`id`, `conversation_id`, `role`, `body`, `client_id`, `created_at`) VALUES
(1, 1, 'assistant', 'Welcome! How can we help you today?\n\nComplete Digital marketing agency', NULL, '2026-09-16 11:16:48'),
(2, 1, 'visitor', 'hi', 'd5ab3f1c-5b26-448f-9482-a39654129ca4', '2026-09-16 11:16:54'),
(3, 1, 'assistant', 'Hello! Complete Digital marketing agency', NULL, '2026-09-16 11:16:54'),
(4, 1, 'visitor', 'i want to need website making', 'c079c718-5f66-4360-bb40-746e9ed90813', '2026-09-16 11:18:27'),
(5, 1, 'assistant', 'I don\'t have a confirmed answer to that in our business information. Leave your details and our team can help with your question.', NULL, '2026-09-16 11:18:27'),
(6, 1, 'system', 'Contact request submitted.', NULL, '2026-09-16 11:19:06'),
(7, 1, 'assistant', 'Thank you. Your details have been sent to our team so they can follow up about your request.', NULL, '2026-09-16 11:19:06');

-- --------------------------------------------------------

--
-- Table structure for table `chat_widgets`
--

CREATE TABLE `chat_widgets` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `public_id` char(32) NOT NULL,
  `name` varchar(120) NOT NULL,
  `business_info` text NOT NULL,
  `config` mediumtext NOT NULL,
  `allowed_origins` text NOT NULL,
  `enabled` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chat_widgets`
--

INSERT INTO `chat_widgets` (`id`, `user_id`, `public_id`, `name`, `business_info`, `config`, `allowed_origins`, `enabled`, `created_at`, `updated_at`) VALUES
(1, 2, '92f03f94e3ed8624c0aa930fd6590e1a', 'Viral Ads Media', 'Complete Digital marketing agency', '{\"color\":\"#18634f\",\"position\":\"right\",\"size\":\"standard\",\"button_style\":\"pill\",\"logo\":\"\",\"avatar\":\"Chat\",\"welcome\":\"Welcome! How can we help you today?\",\"placeholder\":\"Ask about our services\\u2026\",\"offline\":\"Our team is away. Leave your details and we will follow up.\",\"online\":true,\"mobile\":true,\"desktop\":true,\"branding\":true,\"notify\":true,\"fields\":{\"name\":\"required\",\"phone\":\"required\",\"email\":\"required\",\"service\":\"required\",\"message\":\"optional\"}}', '[\"http:\\/\\/localhost\"]', 1, '2026-09-14 10:21:19', '2026-09-14 10:21:19');

-- --------------------------------------------------------

--
-- Table structure for table `competitors`
--

CREATE TABLE `competitors` (
  `id` int(10) UNSIGNED NOT NULL,
  `website_id` int(10) UNSIGNED NOT NULL,
  `domain` varchar(500) NOT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `competitors`
--

INSERT INTO `competitors` (`id`, `website_id`, `domain`, `notes`, `created_at`) VALUES
(1, 1, 'https://viralbulls.com/', '', '2026-09-09 12:34:01');

-- --------------------------------------------------------

--
-- Table structure for table `competitor_keywords`
--

CREATE TABLE `competitor_keywords` (
  `id` int(10) UNSIGNED NOT NULL,
  `competitor_id` int(10) UNSIGNED NOT NULL,
  `keyword` varchar(190) NOT NULL,
  `position` int(11) DEFAULT NULL,
  `source` varchar(30) DEFAULT 'manual'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `content_briefs`
--

CREATE TABLE `content_briefs` (
  `id` int(10) UNSIGNED NOT NULL,
  `content_project_id` int(10) UNSIGNED NOT NULL,
  `content` mediumtext NOT NULL,
  `source` varchar(30) DEFAULT 'manual',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `content_projects`
--

CREATE TABLE `content_projects` (
  `id` int(10) UNSIGNED NOT NULL,
  `website_id` int(10) UNSIGNED NOT NULL,
  `topic` varchar(190) NOT NULL,
  `keyword` varchar(190) NOT NULL,
  `audience` varchar(190) DEFAULT '',
  `country` varchar(80) DEFAULT '',
  `language` varchar(40) DEFAULT 'en',
  `status` varchar(30) DEFAULT 'draft',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(60) NOT NULL,
  `type` enum('percentage','fixed') NOT NULL,
  `amount` int(10) UNSIGNED NOT NULL,
  `starts_at` datetime NOT NULL,
  `ends_at` datetime NOT NULL,
  `usage_limit` int(10) UNSIGNED NOT NULL,
  `per_user_limit` int(10) UNSIGNED DEFAULT 1,
  `active` tinyint(4) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `coupon_usage`
--

CREATE TABLE `coupon_usage` (
  `id` int(10) UNSIGNED NOT NULL,
  `coupon_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `payment_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `crawl_jobs`
--

CREATE TABLE `crawl_jobs` (
  `id` int(10) UNSIGNED NOT NULL,
  `website_id` int(10) UNSIGNED NOT NULL,
  `status` enum('queued','running','completed','failed') DEFAULT 'queued',
  `max_pages` int(10) UNSIGNED NOT NULL,
  `processed` int(10) UNSIGNED DEFAULT 0,
  `robots` text DEFAULT NULL,
  `sitemap` text DEFAULT NULL,
  `error` text DEFAULT NULL,
  `heartbeat` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `completed_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `crawl_jobs`
--

INSERT INTO `crawl_jobs` (`id`, `website_id`, `status`, `max_pages`, `processed`, `robots`, `sitemap`, `error`, `heartbeat`, `created_at`, `completed_at`) VALUES
(1, 1, 'completed', 100, 33, '', '{\"status\":404,\"valid\":false}', NULL, '2026-09-09 17:52:29', '2026-09-09 12:13:58', '2026-09-09 17:53:00'),
(4, 1, 'completed', 100, 33, '', '{\"status\":404,\"valid\":false}', NULL, '2026-09-10 11:05:52', '2026-09-09 12:27:54', '2026-09-10 11:06:02');

-- --------------------------------------------------------

--
-- Table structure for table `crawl_urls`
--

CREATE TABLE `crawl_urls` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `job_id` int(10) UNSIGNED NOT NULL,
  `url` text NOT NULL,
  `url_hash` char(64) NOT NULL,
  `status` enum('queued','done','failed','blocked') DEFAULT 'queued',
  `error` text DEFAULT NULL,
  `discovered_via` varchar(20) NOT NULL DEFAULT 'link'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `crawl_urls`
--

INSERT INTO `crawl_urls` (`id`, `job_id`, `url`, `url_hash`, `status`, `error`, `discovered_via`) VALUES
(1, 1, 'https://viraladsmedia.com/', '896cf55f971057033dbf92d009e90354ca40b45770ed9c960795296ed4fa0afd', 'done', NULL, 'link'),
(2, 1, 'https://viraladsmedia.com/index.html', 'e1eac5d7e11d21457cde6715870e9f258d61ea2d91556c91b4b966ae5883f041', 'done', NULL, 'link'),
(3, 1, 'https://viraladsmedia.com/services.html', 'cd28f49b95407450e1609229398a71c49e7e85844cf2e27093406e24588fcca5', 'done', NULL, 'link'),
(4, 1, 'https://viraladsmedia.com/service.html?best-social-media-agency-in-delhi', 'e0d8f9142947f630882834b4609af999fd74051144649f68420b88b6525f1f13', 'done', NULL, 'link'),
(5, 1, 'https://viraladsmedia.com/service.html?best-seo-agency-near-me', '34f525224068b756137d474043d615dd9a21836775f445d7bb5210130077d9e7', 'done', NULL, 'link'),
(6, 1, 'https://viraladsmedia.com/service.html?affordable-web-developer-in-delhi', '2cbc7a4fb98f34b0b8dddd741e8cf88834b8f2ab54dd46eb6b0c222634754e2a', 'done', NULL, 'link'),
(7, 1, 'https://viraladsmedia.com/service.html?best-performance-marketing-in-delhi', 'ff1b689593ef1c2603c1eb160a841a8c4fecaaa61520bd22730b3e3fc2a4bfcf', 'done', NULL, 'link'),
(8, 1, 'https://viraladsmedia.com/service.html?affordable-logo-and-branding-near-me', '51789239190ec419b0a34a9eaa2513eca586526ea6c91d4ceaff81d4770bd438', 'done', NULL, 'link'),
(9, 1, 'https://viraladsmedia.com/service.html?best-influencer-marketing-in-delhi', '79f2581b0295372b6e75f966ea8581dd40a1e729e0d8d7e42fe1bcc1a7ec6b42', 'done', NULL, 'link'),
(10, 1, 'https://viraladsmedia.com/service.html?proffessional-brand-shoots-in-delhi', '8b5b6f1545aceb34d7e7743cd76cb028e98da9202c3de9e2c23d3b7be2525129', 'done', NULL, 'link'),
(11, 1, 'https://viraladsmedia.com/portfolio.html', '289863c9d403d12415f6f2990fc891fab0b98d52e8771b5822f994f8a678af59', 'done', NULL, 'link'),
(12, 1, 'https://viraladsmedia.com/industries.html', '4478f29c623936f4d40a126d58a6589773e7e6a4ccbb1bef813994d9fed4e361', 'done', NULL, 'link'),
(13, 1, 'https://viraladsmedia.com/industry-detail.html?affordable-e-commerce-website-development-services', '453837d6dbea222b66d15ab318022d14fd1ee35e5eb09db82b76b0119314ebda', 'done', NULL, 'link'),
(14, 1, 'https://viraladsmedia.com/industry-detail.html?healthcare-marketing-services', 'adf31cea028938761c0169440bcb495e6371a3d70276718d4b7b16979e953065', 'done', NULL, 'link'),
(15, 1, 'https://viraladsmedia.com/industry-detail.html?manufacturing-marketing-services', '66a1b661356274aecf183b44438b875bc6cbb8870af646de6f35a2bff91bc620', 'done', NULL, 'link'),
(16, 1, 'https://viraladsmedia.com/industry-detail.html?real-estate-marketing-services', 'fa02740cc2e57d3b3ef45e7b84e8da254399be0d153534b2d2e229956cea030f', 'done', NULL, 'link'),
(17, 1, 'https://viraladsmedia.com/industry-detail.html?education-marketing-services', 'e2f42fc8ac1d2e3a50b78068e75176e490a327111553d90e9b64697203b54b12', 'done', NULL, 'link'),
(18, 1, 'https://viraladsmedia.com/industry-detail.html?fashion-marketing-services', '1c5854e2fb39e602539813f7f6e1d9ff145c7a7572dc9fc8bae838db23063f59', 'done', NULL, 'link'),
(19, 1, 'https://viraladsmedia.com/industry-detail.html?travel-marketing-services', '6c3473610a61d1105caa45574fe6726bf27ef6086c677a51805840539978f217', 'done', NULL, 'link'),
(20, 1, 'https://viraladsmedia.com/industry-detail.html?appliances-marketing-service', '3eed6b07e017cf3bc58e7d831382e01e3aba3ad3761dbb3be71bd6c5b2caff57', 'done', NULL, 'link'),
(21, 1, 'https://viraladsmedia.com/industry-detail.html?cosmetics-marketing-service', '216491e41491bf55f2f96e41cf5e79536c4807be274b6796802ea788282d5219', 'done', NULL, 'link'),
(22, 1, 'https://viraladsmedia.com/about.html', '90bd450b4c322ca7cb9c2876960b3a7d6f17c764286fc4e1313ea0e64601113e', 'done', NULL, 'link'),
(23, 1, 'https://viraladsmedia.com/blogs.html', '560736fb3eb6273a35b88a0cfd91010b1be85ab549445fdb25c705c0d4b3f2d6', 'done', NULL, 'link'),
(24, 1, 'https://viraladsmedia.com/career.html', '86e3e1ef116a8b302d055822ece393b7346b5bfba636f9652dd6ee617d6cb1dc', 'done', NULL, 'link'),
(25, 1, 'https://viraladsmedia.com/contact.html', '9a49237a36cb65c096eb2bd78318d96efd480b010114f6b3a4b0691e79bf8043', 'done', NULL, 'link'),
(266, 1, 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'bc0fa68ee99d9f494a2dde26740d59fe77df1921f12a7a64c052aa305a522c4d', 'done', NULL, 'link'),
(267, 1, 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', '048d254c0d3a16f911f68999c6cacc7308a95e3faa76108a72696da36fc0bb34', 'done', NULL, 'link'),
(268, 1, 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'cdbfbf6ad68b7a63622bc4c3a520812422f235d6cd09cfb1250a0f0e1cd87b82', 'done', NULL, 'link'),
(269, 1, 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'ccbb29ac10d09b0add354901a7eac5e5d936bb545da0b09e55fe66439e5c4fda', 'done', NULL, 'link'),
(270, 1, 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'd6e234854c463ad4e9297073848e16182b0239016ca497164bbd2ba6f343e5f4', 'done', NULL, 'link'),
(271, 1, 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'd57e91fa2d5eacab046900a30c14391b036aa955fb1847f5faa99ee22b22184b', 'done', NULL, 'link'),
(272, 1, 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', '3bbdf7d965bbd20e31608275cd6e26cfb9be72dbf6b23f38a67d07c5098de03d', 'done', NULL, 'link'),
(273, 1, 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', '0dea33dbae412c397a198d9f2cf8ef4854f2cd6a7f54771301fe43dc44b052cf', 'done', NULL, 'link'),
(806, 4, 'https://viraladsmedia.com/', '896cf55f971057033dbf92d009e90354ca40b45770ed9c960795296ed4fa0afd', 'done', NULL, 'link'),
(809, 4, 'https://viraladsmedia.com/index.html', 'e1eac5d7e11d21457cde6715870e9f258d61ea2d91556c91b4b966ae5883f041', 'done', NULL, 'link'),
(810, 4, 'https://viraladsmedia.com/services.html', 'cd28f49b95407450e1609229398a71c49e7e85844cf2e27093406e24588fcca5', 'done', NULL, 'link'),
(811, 4, 'https://viraladsmedia.com/service.html?best-social-media-agency-in-delhi', 'e0d8f9142947f630882834b4609af999fd74051144649f68420b88b6525f1f13', 'done', NULL, 'link'),
(812, 4, 'https://viraladsmedia.com/service.html?best-seo-agency-near-me', '34f525224068b756137d474043d615dd9a21836775f445d7bb5210130077d9e7', 'done', NULL, 'link'),
(813, 4, 'https://viraladsmedia.com/service.html?affordable-web-developer-in-delhi', '2cbc7a4fb98f34b0b8dddd741e8cf88834b8f2ab54dd46eb6b0c222634754e2a', 'done', NULL, 'link'),
(814, 4, 'https://viraladsmedia.com/service.html?best-performance-marketing-in-delhi', 'ff1b689593ef1c2603c1eb160a841a8c4fecaaa61520bd22730b3e3fc2a4bfcf', 'done', NULL, 'link'),
(815, 4, 'https://viraladsmedia.com/service.html?affordable-logo-and-branding-near-me', '51789239190ec419b0a34a9eaa2513eca586526ea6c91d4ceaff81d4770bd438', 'done', NULL, 'link'),
(816, 4, 'https://viraladsmedia.com/service.html?best-influencer-marketing-in-delhi', '79f2581b0295372b6e75f966ea8581dd40a1e729e0d8d7e42fe1bcc1a7ec6b42', 'done', NULL, 'link'),
(817, 4, 'https://viraladsmedia.com/service.html?proffessional-brand-shoots-in-delhi', '8b5b6f1545aceb34d7e7743cd76cb028e98da9202c3de9e2c23d3b7be2525129', 'done', NULL, 'link'),
(818, 4, 'https://viraladsmedia.com/portfolio.html', '289863c9d403d12415f6f2990fc891fab0b98d52e8771b5822f994f8a678af59', 'done', NULL, 'link'),
(819, 4, 'https://viraladsmedia.com/industries.html', '4478f29c623936f4d40a126d58a6589773e7e6a4ccbb1bef813994d9fed4e361', 'done', NULL, 'link'),
(820, 4, 'https://viraladsmedia.com/industry-detail.html?affordable-e-commerce-website-development-services', '453837d6dbea222b66d15ab318022d14fd1ee35e5eb09db82b76b0119314ebda', 'done', NULL, 'link'),
(821, 4, 'https://viraladsmedia.com/industry-detail.html?healthcare-marketing-services', 'adf31cea028938761c0169440bcb495e6371a3d70276718d4b7b16979e953065', 'done', NULL, 'link'),
(822, 4, 'https://viraladsmedia.com/industry-detail.html?manufacturing-marketing-services', '66a1b661356274aecf183b44438b875bc6cbb8870af646de6f35a2bff91bc620', 'done', NULL, 'link'),
(823, 4, 'https://viraladsmedia.com/industry-detail.html?real-estate-marketing-services', 'fa02740cc2e57d3b3ef45e7b84e8da254399be0d153534b2d2e229956cea030f', 'done', NULL, 'link'),
(824, 4, 'https://viraladsmedia.com/industry-detail.html?education-marketing-services', 'e2f42fc8ac1d2e3a50b78068e75176e490a327111553d90e9b64697203b54b12', 'done', NULL, 'link'),
(825, 4, 'https://viraladsmedia.com/industry-detail.html?fashion-marketing-services', '1c5854e2fb39e602539813f7f6e1d9ff145c7a7572dc9fc8bae838db23063f59', 'done', NULL, 'link'),
(826, 4, 'https://viraladsmedia.com/industry-detail.html?travel-marketing-services', '6c3473610a61d1105caa45574fe6726bf27ef6086c677a51805840539978f217', 'done', NULL, 'link'),
(827, 4, 'https://viraladsmedia.com/industry-detail.html?appliances-marketing-service', '3eed6b07e017cf3bc58e7d831382e01e3aba3ad3761dbb3be71bd6c5b2caff57', 'done', NULL, 'link'),
(828, 4, 'https://viraladsmedia.com/industry-detail.html?cosmetics-marketing-service', '216491e41491bf55f2f96e41cf5e79536c4807be274b6796802ea788282d5219', 'done', NULL, 'link'),
(829, 4, 'https://viraladsmedia.com/about.html', '90bd450b4c322ca7cb9c2876960b3a7d6f17c764286fc4e1313ea0e64601113e', 'done', NULL, 'link'),
(830, 4, 'https://viraladsmedia.com/blogs.html', '560736fb3eb6273a35b88a0cfd91010b1be85ab549445fdb25c705c0d4b3f2d6', 'done', NULL, 'link'),
(831, 4, 'https://viraladsmedia.com/career.html', '86e3e1ef116a8b302d055822ece393b7346b5bfba636f9652dd6ee617d6cb1dc', 'done', NULL, 'link'),
(832, 4, 'https://viraladsmedia.com/contact.html', '9a49237a36cb65c096eb2bd78318d96efd480b010114f6b3a4b0691e79bf8043', 'done', NULL, 'link'),
(1073, 4, 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'bc0fa68ee99d9f494a2dde26740d59fe77df1921f12a7a64c052aa305a522c4d', 'done', NULL, 'link'),
(1074, 4, 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', '048d254c0d3a16f911f68999c6cacc7308a95e3faa76108a72696da36fc0bb34', 'done', NULL, 'link'),
(1075, 4, 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'cdbfbf6ad68b7a63622bc4c3a520812422f235d6cd09cfb1250a0f0e1cd87b82', 'done', NULL, 'link'),
(1076, 4, 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'ccbb29ac10d09b0add354901a7eac5e5d936bb545da0b09e55fe66439e5c4fda', 'done', NULL, 'link'),
(1077, 4, 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'd6e234854c463ad4e9297073848e16182b0239016ca497164bbd2ba6f343e5f4', 'done', NULL, 'link'),
(1078, 4, 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'd57e91fa2d5eacab046900a30c14391b036aa955fb1847f5faa99ee22b22184b', 'done', NULL, 'link'),
(1079, 4, 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', '3bbdf7d965bbd20e31608275cd6e26cfb9be72dbf6b23f38a67d07c5098de03d', 'done', NULL, 'link'),
(1080, 4, 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', '0dea33dbae412c397a198d9f2cf8ef4854f2cd6a7f54771301fe43dc44b052cf', 'done', NULL, 'link');

-- --------------------------------------------------------

--
-- Table structure for table `email_logs`
--

CREATE TABLE `email_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `recipient` varchar(190) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `body` mediumtext NOT NULL,
  `status` enum('queued','sending','sent','failed') DEFAULT 'queued',
  `attempts` int(11) DEFAULT 0,
  `error` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `sent_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `email_logs`
--

INSERT INTO `email_logs` (`id`, `recipient`, `subject`, `body`, `status`, `attempts`, `error`, `created_at`, `sent_at`) VALUES
(1, 'rj9work@gmail.com', 'Welcome to SEO AutoPilot — verify your email', 'http://localhost/ppso/verify-email?token=5826692d6c82a1957994b281cad7ef9d0f22c01cd711e64c0bb8257db3ee98fe', 'queued', 0, NULL, '2026-09-09 12:13:07', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `human_service_requests`
--

CREATE TABLE `human_service_requests` (
  `id` int(10) UNSIGNED NOT NULL,
  `website_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `service` varchar(100) NOT NULL,
  `budget` int(10) UNSIGNED NOT NULL,
  `description` text NOT NULL,
  `priority` enum('high','medium','low') DEFAULT 'medium',
  `assigned_user` int(10) UNSIGNED DEFAULT NULL,
  `status` enum('new','assigned','in_progress','waiting_for_customer','completed','cancelled') DEFAULT 'new',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `quoted_amount` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `internal_link_suggestions`
--

CREATE TABLE `internal_link_suggestions` (
  `id` int(10) UNSIGNED NOT NULL,
  `website_id` int(10) UNSIGNED NOT NULL,
  `source_url` varchar(1000) NOT NULL,
  `target_url` varchar(1000) NOT NULL,
  `anchor` varchar(190) NOT NULL,
  `status` enum('suggested','accepted','rejected','implemented') DEFAULT 'suggested',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `internal_link_suggestions`
--

INSERT INTO `internal_link_suggestions` (`id`, `website_id`, `source_url`, `target_url`, `anchor`, `status`, `created_at`) VALUES
(1, 1, 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(2, 1, 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(3, 1, 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(4, 1, 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(5, 1, 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(6, 1, 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(7, 1, 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(8, 1, 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(9, 1, 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(10, 1, 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(11, 1, 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(12, 1, 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(13, 1, 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(14, 1, 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(15, 1, 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(16, 1, 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(17, 1, 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(18, 1, 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(19, 1, 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(20, 1, 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(21, 1, 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(22, 1, 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(23, 1, 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(24, 1, 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(25, 1, 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(26, 1, 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(27, 1, 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(28, 1, 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(29, 1, 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(30, 1, 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(31, 1, 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(32, 1, 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(33, 1, 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(34, 1, 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(35, 1, 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(36, 1, 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(37, 1, 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(38, 1, 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(39, 1, 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(40, 1, 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(41, 1, 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(42, 1, 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(43, 1, 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(44, 1, 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(45, 1, 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(46, 1, 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(47, 1, 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(48, 1, 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(49, 1, 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(50, 1, 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(51, 1, 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(52, 1, 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(53, 1, 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(54, 1, 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(55, 1, 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48'),
(56, 1, 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'CATEGORY NOT FOUND', 'suggested', '2026-09-09 12:36:48');

-- --------------------------------------------------------

--
-- Table structure for table `invitations`
--

CREATE TABLE `invitations` (
  `id` int(10) UNSIGNED NOT NULL,
  `owner_id` int(10) UNSIGNED NOT NULL,
  `website_id` int(10) UNSIGNED NOT NULL,
  `email` varchar(190) NOT NULL,
  `token_hash` char(64) NOT NULL,
  `expires_at` datetime NOT NULL,
  `accepted_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `id` int(10) UNSIGNED NOT NULL,
  `payment_id` int(10) UNSIGNED NOT NULL,
  `number` varchar(60) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `keywords`
--

CREATE TABLE `keywords` (
  `id` int(10) UNSIGNED NOT NULL,
  `website_id` int(10) UNSIGNED NOT NULL,
  `keyword` varchar(190) NOT NULL,
  `country` varchar(80) DEFAULT 'India',
  `language` varchar(40) DEFAULT 'en',
  `search_engine` varchar(30) DEFAULT 'google',
  `device` enum('desktop','mobile') DEFAULT 'desktop',
  `target_url` varchar(500) DEFAULT '',
  `intent` varchar(80) DEFAULT '',
  `tags` varchar(190) DEFAULT '',
  `search_volume` int(10) UNSIGNED DEFAULT NULL,
  `difficulty` decimal(5,2) DEFAULT NULL,
  `cpc` decimal(10,2) DEFAULT NULL,
  `source` varchar(30) DEFAULT 'manual',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `keywords`
--

INSERT INTO `keywords` (`id`, `website_id`, `keyword`, `country`, `language`, `search_engine`, `device`, `target_url`, `intent`, `tags`, `search_volume`, `difficulty`, `cpc`, `source`, `created_at`) VALUES
(1, 1, 'Best Digital Marketing Agency in Delhi', 'India', 'en', 'google', 'desktop', 'https://viraladsmedia.com/', '', '', NULL, NULL, NULL, 'manual', '2026-09-10 04:59:45'),
(2, 1, 'Best Digital Marketing Agency in Budhh Vihar', 'India', 'en', 'google', 'desktop', 'https://viraladsmedia.com/', '', '', NULL, NULL, NULL, 'manual', '2026-09-10 05:10:33'),
(3, 1, 'digital marketing agency in Delhi', 'India', 'en', 'google', 'desktop', '', '', '', NULL, NULL, NULL, 'research', '2026-09-12 04:52:32');

-- --------------------------------------------------------

--
-- Table structure for table `keyword_groups`
--

CREATE TABLE `keyword_groups` (
  `id` int(10) UNSIGNED NOT NULL,
  `website_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `keyword_rankings`
--

CREATE TABLE `keyword_rankings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `keyword_id` int(10) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `position` int(10) UNSIGNED DEFAULT NULL,
  `url` text DEFAULT NULL,
  `source` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `keyword_rankings`
--

INSERT INTO `keyword_rankings` (`id`, `keyword_id`, `date`, `position`, `url`, `source`) VALUES
(1, 1, '2026-09-10', NULL, '', 'hasdata_top100'),
(2, 2, '2026-09-10', 26, 'https://www.viraladsmedia.com/', 'hasdata_top100');

-- --------------------------------------------------------

--
-- Table structure for table `leads`
--

CREATE TABLE `leads` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `source_id` tinyint(3) UNSIGNED NOT NULL,
  `business_name` varchar(190) NOT NULL,
  `category` varchar(190) NOT NULL DEFAULT '',
  `city` varchar(120) NOT NULL DEFAULT '',
  `state` varchar(120) NOT NULL DEFAULT '',
  `address` varchar(500) NOT NULL DEFAULT '',
  `website` varchar(500) NOT NULL DEFAULT '',
  `email` varchar(190) NOT NULL DEFAULT '',
  `phone` varchar(40) NOT NULL DEFAULT '',
  `provenance` varchar(1000) NOT NULL,
  `fingerprint` char(64) NOT NULL,
  `score` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `rating` enum('Hot','Warm','Normal') NOT NULL DEFAULT 'Normal',
  `favorite` tinyint(1) NOT NULL DEFAULT 0,
  `demo_slot` tinyint(3) UNSIGNED DEFAULT NULL,
  `seo_score` tinyint(3) UNSIGNED DEFAULT NULL,
  `website_available` tinyint(1) DEFAULT NULL,
  `seo_result` longtext DEFAULT NULL,
  `audited_at` datetime DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ;

-- --------------------------------------------------------

--
-- Table structure for table `lead_activity`
--

CREATE TABLE `lead_activity` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `lead_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `action` varchar(60) NOT NULL,
  `details` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lead_activity`
--

INSERT INTO `lead_activity` (`id`, `lead_id`, `user_id`, `action`, `details`, `created_at`) VALUES
(1, NULL, 2, 'exported', '{\"format\":\"csv\",\"count\":0}', '2026-09-15 15:04:52');

-- --------------------------------------------------------

--
-- Table structure for table `lead_notes`
--

CREATE TABLE `lead_notes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `lead_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `note` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lead_searches`
--

CREATE TABLE `lead_searches` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `keyword` varchar(190) NOT NULL,
  `location` varchar(190) NOT NULL,
  `source_id` tinyint(3) UNSIGNED DEFAULT NULL,
  `result_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `is_public` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lead_searches`
--

INSERT INTO `lead_searches` (`id`, `user_id`, `keyword`, `location`, `source_id`, `result_count`, `is_public`, `created_at`) VALUES
(1, NULL, 'Best Digital Marketing Agency in Delhi', 'mubai', 1, 0, 1, '2026-09-15 14:02:12'),
(2, NULL, 'Best Digital Marketing Agency in Delhi', 'mubai', 1, 0, 1, '2026-09-15 14:02:21'),
(3, NULL, 'Best Digital Marketing Agency in Delhi', 'mubai', 1, 0, 1, '2026-09-15 14:02:22'),
(4, NULL, 'Best Digital Marketing Agency in Delhi', 'mubai', 1, 0, 1, '2026-09-15 14:02:22'),
(5, NULL, 'Best Digital Marketing Agency in Delhi', 'mubai', 1, 0, 1, '2026-09-15 14:02:22'),
(6, NULL, 'Best Digital Marketing Agency in Delhi', 'mubai', 1, 0, 1, '2026-09-15 14:02:22'),
(7, NULL, 'Best Digital Marketing Agency in Delhi', 'mubai', 1, 0, 1, '2026-09-15 14:02:23'),
(8, 2, 'Best Digital Marketing Agency in Delhi', 'mumbai', 1, 0, 0, '2026-09-15 14:03:57'),
(9, 2, 'Best Digital Marketing Agency in Delhi', 'mumbai', 1, 0, 0, '2026-09-15 14:04:12'),
(10, NULL, 'Best Digital Marketing Agency in Delhi', 'mumbai', 1, 0, 1, '2026-09-15 15:01:57'),
(11, 2, 'Best Digital Marketing Agency in Delhi', 'mumbai', NULL, 0, 0, '2026-09-15 15:05:11'),
(12, 2, 'Best Digital Marketing Agency in Delhi', 'mumbai', NULL, 0, 0, '2026-09-15 15:05:25');

-- --------------------------------------------------------

--
-- Table structure for table `lead_sources`
--

CREATE TABLE `lead_sources` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `name` varchar(30) NOT NULL,
  `collection_mode` varchar(40) NOT NULL DEFAULT 'authorized_import',
  `enabled` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lead_sources`
--

INSERT INTO `lead_sources` (`id`, `name`, `collection_mode`, `enabled`) VALUES
(1, 'IndiaMART', 'authorized_import', 1),
(2, 'TradeIndia', 'authorized_import', 1);

-- --------------------------------------------------------

--
-- Table structure for table `lead_tags`
--

CREATE TABLE `lead_tags` (
  `lead_id` bigint(20) UNSIGNED NOT NULL,
  `tag` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `local_seo_audits`
--

CREATE TABLE `local_seo_audits` (
  `id` int(10) UNSIGNED NOT NULL,
  `website_id` int(10) UNSIGNED NOT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `business_name` varchar(190) NOT NULL,
  `score` tinyint(3) UNSIGNED NOT NULL,
  `scoring_version` smallint(5) UNSIGNED NOT NULL DEFAULT 1,
  `snapshot` mediumtext NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `message` varchar(500) NOT NULL,
  `path` varchar(500) NOT NULL,
  `read_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `message`, `path`, `read_at`, `created_at`) VALUES
(1, 2, 'A new SEO report is ready.', '/report?id=1&website_id=1', NULL, '2026-09-09 12:14:49'),
(2, 2, 'Your SEO audit is ready.', '/audit?website_id=1', NULL, '2026-09-09 12:23:00'),
(3, 2, 'Your SEO audit is ready.', '/audit?website_id=1', NULL, '2026-09-10 05:36:02'),
(4, 2, 'New chat lead for Viral Ads Media', '/live-chat?tab=lead&id=1', NULL, '2026-09-16 11:19:06');

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `website_id` int(10) UNSIGNED NOT NULL,
  `job_id` int(10) UNSIGNED NOT NULL,
  `url` text NOT NULL,
  `url_hash` char(64) NOT NULL,
  `http_status` smallint(6) NOT NULL,
  `title` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `h1` text DEFAULT NULL,
  `h2` text DEFAULT NULL,
  `word_count` int(11) DEFAULT 0,
  `image_count` int(11) DEFAULT 0,
  `missing_alt` int(11) DEFAULT 0,
  `internal_links` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`internal_links`)),
  `external_links` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`external_links`)),
  `canonical` text DEFAULT NULL,
  `robots` text DEFAULT NULL,
  `schema_count` int(11) DEFAULT 0,
  `og_count` int(11) DEFAULT 0,
  `noindex` tinyint(4) DEFAULT 0,
  `load_ms` int(11) DEFAULT 0,
  `score` int(11) DEFAULT 0,
  `details` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`details`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`id`, `website_id`, `job_id`, `url`, `url_hash`, `http_status`, `title`, `description`, `h1`, `h2`, `word_count`, `image_count`, `missing_alt`, `internal_links`, `external_links`, `canonical`, `robots`, `schema_count`, `og_count`, `noindex`, `load_ms`, `score`, `details`, `created_at`) VALUES
(1, 1, 1, 'https://viraladsmedia.com/', '896cf55f971057033dbf92d009e90354ca40b45770ed9c960795296ed4fa0afd', 200, 'Best Digital Marketing Agency in Delhi NCR | SEO, Ads, SMM & Viral Growth', 'Build a powerful online presence with Viral Ads Media, a creative digital marketing agency in Delhi NCR offering SEO, social media, paid ads, branding & growth strategies that deliver results.', 'Ideas\r\n        हमारे होते हैं... \r\n        Viral Moment\r\n        आपका होता है!', 'WebsiteDesigning | Performance Marketing | Logo &Branding | InfluencerMarketing | SEOManagement | ADSCampaign | Graphics & Video Editing | Crafted for\r\n            इम्पैक्ट. | Our क्लाइंट्स. | From brief to\r\n            एक्ज़ीक्यूशन. | Results That Speak \r\n          लाउडर\r\n          Than Promises.', 468, 65, 8, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 476, 84, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/services\\/web.jpg\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/services\\/performance.jpg\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/services\\/logo.jpg\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/services\\/influence.jpg\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/services\\/seo.jpg\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/services\\/ads.jpg\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/services\\/graphic.jpg\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Project\\/20.jpg\",\"alt\":\"Topson\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Project\\/21.jpg\",\"alt\":\"Lumen Skincare\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Project\\/22.png\",\"alt\":\"Pulse Fitness\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Project\\/23.jpg\",\"alt\":\"Stratos Sportswear\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/saptron.png\",\"alt\":\"Client 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/allied.png\",\"alt\":\"Client 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/aryan.png\",\"alt\":\"Client 3\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/bakery.png\",\"alt\":\"Client 4\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/balaji.png\",\"alt\":\"Client 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/component.png\",\"alt\":\"Client 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/delmont.png\",\"alt\":\"Client 9\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/drapple.png\",\"alt\":\"Client 10\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/eltons.png\",\"alt\":\"Client 12\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/franklite.png\",\"alt\":\"Client 13\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/frendz_forever.png\",\"alt\":\"Client 14\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/gboss.png\",\"alt\":\"Client 15\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/glamfam.png\",\"alt\":\"Client 16\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/guruji.png\",\"alt\":\"Client 17\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/jbj.png\",\"alt\":\"Client 26\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/jyoti.png\",\"alt\":\"Client 27\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/kamal.png\",\"alt\":\"Client 28\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/sketch.png\",\"alt\":\"Client 29\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/mango.png\",\"alt\":\"Client 30\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/medyra.png\",\"alt\":\"Client 31\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/minar.png\",\"alt\":\"Client 32\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/navigator.png\",\"alt\":\"Client 33\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/nipex.png\",\"alt\":\"Client 34\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/nippon.png\",\"alt\":\"Client 35\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/nugraj.png\",\"alt\":\"Client 36\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/allied.png\",\"alt\":\"1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/allied.png\",\"alt\":\"2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/pixel-cable.png\",\"alt\":\"4\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/presco.png\",\"alt\":\"5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/saptron.png\",\"alt\":\"6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/savele.png\",\"alt\":\"7\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/shri-shyam.png\",\"alt\":\"8\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/sketch.png\",\"alt\":\"9\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/tdii.png\",\"alt\":\"10\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/tiptop.png\",\"alt\":\"11\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/topson.png\",\"alt\":\"12\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/trophy.png\",\"alt\":\"13\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/bakery.png\",\"alt\":\"14\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/jbj.png\",\"alt\":\"16\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/jyoti.png\",\"alt\":\"17\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/nipex.png\",\"alt\":\"18\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/nippon.png\",\"alt\":\"19\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/frendz_forever.png\",\"alt\":\"20\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/gboss.png\",\"alt\":\"21\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/kamal.png\",\"alt\":\"22\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/minar.png\",\"alt\":\"23\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":1,\"viewport\":\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/\"],\"text\":\"Best Digital Marketing Agency in Delhi NCR | SEO, Ads, SMM & Viral Growth Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00e2\\u2020\\u2019 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u00e2\\u2020\\u2019 Company Blogs Career Let\'s Talk Pay Now Who We are? Ideas \\u0939\\u092e\\u093e\\u0930\\u0947 \\u0939\\u094b\\u0924\\u0947 \\u0939\\u0948\\u0902... Viral Moment \\u0906\\u092a\\u0915\\u093e \\u0939\\u094b\\u0924\\u093e \\u0939\\u0948! Transforming Brands with Creative Digital Solutions - From Social Media to Web, We Make Your Presence Viral! Let\'s Start Watch Showreel Result Driven Strategies Creative That Performs Brands That Grow WebsiteDesigning Engineered for absolute digital conversion Performance Marketing Data driven results for scaling brands Logo &Branding Identity design for market leading growth InfluencerMarketing Authentic voices driving massive organic reach SEOManagement Identity design for market leading growth ADSCampaign Authentic voices driving massive organic reach Graphics & Video Editing Identity design for market leading growth [02] Selected Work \\/ Portfolio Crafted for \\u0907\\u092e\\u094d\\u092a\\u0948\\u0915\\u094d\\u091f. High-performance creative productions, viral campaigns, and digital architecture built for scaling brands. Brand Launch \\u00b7 2026 TOPSON PLAST Content Series \\u00b7 2026 DRAPPLE Social Campaign \\u00b7 2025 ALLIED TAPS Global Launch \\u00b7 2026 OCEAN BEAUTY Explore All Case Studies Our \\u0915\\u094d\\u0932\\u093e\\u0907\\u0902\\u091f\\u094d\\u0938. Helping new brands start up and old ones start over. View All Clients [04] Process \\/ How We Work From brief to \\u090f\\u0915\\u094d\\u091c\\u093c\\u0940\\u0915\\u094d\\u092f\\u0942\\u0936\\u0928. Our structural engineering methodology turns bold strategies into lightning-fast interactive architectures with complete step-by-step transparency. Phase 01 Discovery Strategic Alignment We align directly with your core vision, target demographic goals, and technical limitations. 01 Phase 02 Blueprints Interactive Wireframing Translating raw requirements into sleek high-contrast mockups and custom typography layouts. 02 Phase 03 Engineering Development & Optimization Coding clean systems using top-tier performance tech stacks to achieve lightning-fast speed. 03 Phase 04 Deployment Seamless Launch Rigorous quality assurance audits followed by server deployment and analytics setup. 04 OUR ACHIEVEMENTS Results That Speak \\u0932\\u093e\\u0909\\u0921\\u0930 Than Promises. Real numbers. Real growth. Real impact for our clients. 300+ BRANDS SCALED From startups to established businesses. 500+ SUCCESSFUL CAMPAIGNS Data-driven campaigns that deliver results. 10M+ ORGANIC & PAID REACH Across platforms that drive real engagement. 95% CLIENT RETENTION RATE Long-term partnerships built on trust. 12 MONTHS OF GROWTH JOURNEY Consistent Growth.Real Results. 100K 75K 50K 25K 0 Campaign Launch SEO Growth Paid Ads Optimization Revenue Growth JANFEBMARAPRMAYJUNJULAUGSEPOCTNOVDEC DIGITAL SOLUTIONS BUILT FOR GROWTH Performance Marketing ROI-focused campaigns that generate leads and boost sales. SEO Strategy Rank higher on Google and attract high intent organic traffic. Creative Branding Unique designs that build brand identity and recognition. Data Driven Marketing Smart insights and analytics to make better marketing decisions. TRUSTED BY BUSINESSES ACROSS INDUSTRIES E-COMMERCE HEALTHCARE MANUFACTURING REAL ESTATE EDUCATION FASHION TRAVEL APPLIANCES COSMETICS Let\'s Grow Your Business Together. Book a quick consultation call to see how we can scale your brand. Enquire Now\"}', '2026-09-09 12:21:04'),
(2, 1, 1, 'https://viraladsmedia.com/index.html', 'e1eac5d7e11d21457cde6715870e9f258d61ea2d91556c91b4b966ae5883f041', 200, 'Best Digital Marketing Agency in Delhi NCR | SEO, Ads, SMM & Viral Growth', 'Build a powerful online presence with Viral Ads Media, a creative digital marketing agency in Delhi NCR offering SEO, social media, paid ads, branding & growth strategies that deliver results.', 'Ideas\r\n        हमारे होते हैं... \r\n        Viral Moment\r\n        आपका होता है!', 'WebsiteDesigning | Performance Marketing | Logo &Branding | InfluencerMarketing | SEOManagement | ADSCampaign | Graphics & Video Editing | Crafted for\r\n            इम्पैक्ट. | Our क्लाइंट्स. | From brief to\r\n            एक्ज़ीक्यूशन. | Results That Speak \r\n          लाउडर\r\n          Than Promises.', 468, 65, 8, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 435, 84, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/services\\/web.jpg\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/services\\/performance.jpg\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/services\\/logo.jpg\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/services\\/influence.jpg\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/services\\/seo.jpg\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/services\\/ads.jpg\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/services\\/graphic.jpg\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Project\\/20.jpg\",\"alt\":\"Topson\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Project\\/21.jpg\",\"alt\":\"Lumen Skincare\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Project\\/22.png\",\"alt\":\"Pulse Fitness\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Project\\/23.jpg\",\"alt\":\"Stratos Sportswear\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/saptron.png\",\"alt\":\"Client 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/allied.png\",\"alt\":\"Client 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/aryan.png\",\"alt\":\"Client 3\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/bakery.png\",\"alt\":\"Client 4\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/balaji.png\",\"alt\":\"Client 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/component.png\",\"alt\":\"Client 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/delmont.png\",\"alt\":\"Client 9\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/drapple.png\",\"alt\":\"Client 10\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/eltons.png\",\"alt\":\"Client 12\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/franklite.png\",\"alt\":\"Client 13\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/frendz_forever.png\",\"alt\":\"Client 14\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/gboss.png\",\"alt\":\"Client 15\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/glamfam.png\",\"alt\":\"Client 16\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/guruji.png\",\"alt\":\"Client 17\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/jbj.png\",\"alt\":\"Client 26\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/jyoti.png\",\"alt\":\"Client 27\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/kamal.png\",\"alt\":\"Client 28\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/sketch.png\",\"alt\":\"Client 29\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/mango.png\",\"alt\":\"Client 30\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/medyra.png\",\"alt\":\"Client 31\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/minar.png\",\"alt\":\"Client 32\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/navigator.png\",\"alt\":\"Client 33\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/nipex.png\",\"alt\":\"Client 34\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/nippon.png\",\"alt\":\"Client 35\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/nugraj.png\",\"alt\":\"Client 36\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/allied.png\",\"alt\":\"1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/allied.png\",\"alt\":\"2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/pixel-cable.png\",\"alt\":\"4\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/presco.png\",\"alt\":\"5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/saptron.png\",\"alt\":\"6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/savele.png\",\"alt\":\"7\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/shri-shyam.png\",\"alt\":\"8\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/sketch.png\",\"alt\":\"9\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/tdii.png\",\"alt\":\"10\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/tiptop.png\",\"alt\":\"11\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/topson.png\",\"alt\":\"12\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/trophy.png\",\"alt\":\"13\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/bakery.png\",\"alt\":\"14\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/jbj.png\",\"alt\":\"16\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/jyoti.png\",\"alt\":\"17\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/nipex.png\",\"alt\":\"18\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/nippon.png\",\"alt\":\"19\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/frendz_forever.png\",\"alt\":\"20\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/gboss.png\",\"alt\":\"21\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/kamal.png\",\"alt\":\"22\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/minar.png\",\"alt\":\"23\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":1,\"viewport\":\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/index.html\"],\"text\":\"Best Digital Marketing Agency in Delhi NCR | SEO, Ads, SMM & Viral Growth Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00e2\\u2020\\u2019 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u00e2\\u2020\\u2019 Company Blogs Career Let\'s Talk Pay Now Who We are? Ideas \\u0939\\u092e\\u093e\\u0930\\u0947 \\u0939\\u094b\\u0924\\u0947 \\u0939\\u0948\\u0902... Viral Moment \\u0906\\u092a\\u0915\\u093e \\u0939\\u094b\\u0924\\u093e \\u0939\\u0948! Transforming Brands with Creative Digital Solutions - From Social Media to Web, We Make Your Presence Viral! Let\'s Start Watch Showreel Result Driven Strategies Creative That Performs Brands That Grow WebsiteDesigning Engineered for absolute digital conversion Performance Marketing Data driven results for scaling brands Logo &Branding Identity design for market leading growth InfluencerMarketing Authentic voices driving massive organic reach SEOManagement Identity design for market leading growth ADSCampaign Authentic voices driving massive organic reach Graphics & Video Editing Identity design for market leading growth [02] Selected Work \\/ Portfolio Crafted for \\u0907\\u092e\\u094d\\u092a\\u0948\\u0915\\u094d\\u091f. High-performance creative productions, viral campaigns, and digital architecture built for scaling brands. Brand Launch \\u00b7 2026 TOPSON PLAST Content Series \\u00b7 2026 DRAPPLE Social Campaign \\u00b7 2025 ALLIED TAPS Global Launch \\u00b7 2026 OCEAN BEAUTY Explore All Case Studies Our \\u0915\\u094d\\u0932\\u093e\\u0907\\u0902\\u091f\\u094d\\u0938. Helping new brands start up and old ones start over. View All Clients [04] Process \\/ How We Work From brief to \\u090f\\u0915\\u094d\\u091c\\u093c\\u0940\\u0915\\u094d\\u092f\\u0942\\u0936\\u0928. Our structural engineering methodology turns bold strategies into lightning-fast interactive architectures with complete step-by-step transparency. Phase 01 Discovery Strategic Alignment We align directly with your core vision, target demographic goals, and technical limitations. 01 Phase 02 Blueprints Interactive Wireframing Translating raw requirements into sleek high-contrast mockups and custom typography layouts. 02 Phase 03 Engineering Development & Optimization Coding clean systems using top-tier performance tech stacks to achieve lightning-fast speed. 03 Phase 04 Deployment Seamless Launch Rigorous quality assurance audits followed by server deployment and analytics setup. 04 OUR ACHIEVEMENTS Results That Speak \\u0932\\u093e\\u0909\\u0921\\u0930 Than Promises. Real numbers. Real growth. Real impact for our clients. 300+ BRANDS SCALED From startups to established businesses. 500+ SUCCESSFUL CAMPAIGNS Data-driven campaigns that deliver results. 10M+ ORGANIC & PAID REACH Across platforms that drive real engagement. 95% CLIENT RETENTION RATE Long-term partnerships built on trust. 12 MONTHS OF GROWTH JOURNEY Consistent Growth.Real Results. 100K 75K 50K 25K 0 Campaign Launch SEO Growth Paid Ads Optimization Revenue Growth JANFEBMARAPRMAYJUNJULAUGSEPOCTNOVDEC DIGITAL SOLUTIONS BUILT FOR GROWTH Performance Marketing ROI-focused campaigns that generate leads and boost sales. SEO Strategy Rank higher on Google and attract high intent organic traffic. Creative Branding Unique designs that build brand identity and recognition. Data Driven Marketing Smart insights and analytics to make better marketing decisions. TRUSTED BY BUSINESSES ACROSS INDUSTRIES E-COMMERCE HEALTHCARE MANUFACTURING REAL ESTATE EDUCATION FASHION TRAVEL APPLIANCES COSMETICS Let\'s Grow Your Business Together. Book a quick consultation call to see how we can scale your brand. Enquire Now\"}', '2026-09-09 12:21:06'),
(3, 1, 1, 'https://viraladsmedia.com/services.html', 'cd28f49b95407450e1609229398a71c49e7e85844cf2e27093406e24588fcca5', 200, 'Services | Viral Ads Media', 'Explore Viral Ads Media services including social media marketing, SEO, website design, performance marketing, branding, influencer campaigns and brand shoots in Delhi NCR.', 'हम Ads \n        नहीं चलाते...  \n        हम Attention Capture \n        करते हैं!', '', 70, 0, 0, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 423, 86, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":1,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/services.html\"],\"text\":\"Services | Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now \\u0939\\u092e Ads \\u0928\\u0939\\u0940\\u0902 \\u091a\\u0932\\u093e\\u0924\\u0947... \\u0939\\u092e Attention Capture \\u0915\\u0930\\u0924\\u0947 \\u0939\\u0948\\u0902! Unlock elevated, measurable growth through tailored strategies, seamless campaign execution and beautiful purpose-built web experiences.\"}', '2026-09-09 12:21:07'),
(4, 1, 1, 'https://viraladsmedia.com/service.html?best-social-media-agency-in-delhi', 'e0d8f9142947f630882834b4609af999fd74051144649f68420b88b6525f1f13', 200, 'Service Details — Viral Ads Media', 'Explore Viral Ads Media services across social media, SEO, websites, paid ads, branding, influencer campaigns and brand shoots for business growth in Delhi NCR.', 'SERVICE SPECIFICATION NOT FOUND', 'Clients we work with | Tools we use | Client Portfolio Showcase | Frequently Asked Questions | Other Core Services', 118, 0, 0, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/viraladsmedia.comservices.html\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 459, 86, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\"],\"text\":\"Service Details \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 Error SERVICE SPECIFICATION NOT FOUND Return to Services Hub \\u2192 [ VAM SERVICE SOLUTION ] Clients we work with Tools we use [ Client Spotlight ] Client Portfolio Showcase Explore interactive hero imagery and project executions tailored for this service. [ Got Questions? ] Frequently Asked Questions Everything you need to know about our workflow, deliverables, and service execution. [ Explore More ] Other Core Services Services Hub \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2\"}', '2026-09-09 12:21:09'),
(5, 1, 1, 'https://viraladsmedia.com/service.html?best-seo-agency-near-me', '34f525224068b756137d474043d615dd9a21836775f445d7bb5210130077d9e7', 200, 'Service Details — Viral Ads Media', 'Explore Viral Ads Media services across social media, SEO, websites, paid ads, branding, influencer campaigns and brand shoots for business growth in Delhi NCR.', 'SERVICE SPECIFICATION NOT FOUND', 'Clients we work with | Tools we use | Client Portfolio Showcase | Frequently Asked Questions | Other Core Services', 118, 0, 0, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/viraladsmedia.comservices.html\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 446, 86, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\"],\"text\":\"Service Details \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 Error SERVICE SPECIFICATION NOT FOUND Return to Services Hub \\u2192 [ VAM SERVICE SOLUTION ] Clients we work with Tools we use [ Client Spotlight ] Client Portfolio Showcase Explore interactive hero imagery and project executions tailored for this service. [ Got Questions? ] Frequently Asked Questions Everything you need to know about our workflow, deliverables, and service execution. [ Explore More ] Other Core Services Services Hub \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2\"}', '2026-09-09 12:21:10'),
(6, 1, 1, 'https://viraladsmedia.com/service.html?affordable-web-developer-in-delhi', '2cbc7a4fb98f34b0b8dddd741e8cf88834b8f2ab54dd46eb6b0c222634754e2a', 200, 'Service Details — Viral Ads Media', 'Explore Viral Ads Media services across social media, SEO, websites, paid ads, branding, influencer campaigns and brand shoots for business growth in Delhi NCR.', 'SERVICE SPECIFICATION NOT FOUND', 'Clients we work with | Tools we use | Client Portfolio Showcase | Frequently Asked Questions | Other Core Services', 118, 0, 0, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/viraladsmedia.comservices.html\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 514, 86, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\"],\"text\":\"Service Details \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 Error SERVICE SPECIFICATION NOT FOUND Return to Services Hub \\u2192 [ VAM SERVICE SOLUTION ] Clients we work with Tools we use [ Client Spotlight ] Client Portfolio Showcase Explore interactive hero imagery and project executions tailored for this service. [ Got Questions? ] Frequently Asked Questions Everything you need to know about our workflow, deliverables, and service execution. [ Explore More ] Other Core Services Services Hub \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2\"}', '2026-09-09 12:21:12');
INSERT INTO `pages` (`id`, `website_id`, `job_id`, `url`, `url_hash`, `http_status`, `title`, `description`, `h1`, `h2`, `word_count`, `image_count`, `missing_alt`, `internal_links`, `external_links`, `canonical`, `robots`, `schema_count`, `og_count`, `noindex`, `load_ms`, `score`, `details`, `created_at`) VALUES
(7, 1, 1, 'https://viraladsmedia.com/service.html?best-performance-marketing-in-delhi', 'ff1b689593ef1c2603c1eb160a841a8c4fecaaa61520bd22730b3e3fc2a4bfcf', 200, 'Service Details — Viral Ads Media', 'Explore Viral Ads Media services across social media, SEO, websites, paid ads, branding, influencer campaigns and brand shoots for business growth in Delhi NCR.', 'SERVICE SPECIFICATION NOT FOUND', 'Clients we work with | Tools we use | Client Portfolio Showcase | Frequently Asked Questions | Other Core Services', 118, 0, 0, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/viraladsmedia.comservices.html\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 433, 86, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\"],\"text\":\"Service Details \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 Error SERVICE SPECIFICATION NOT FOUND Return to Services Hub \\u2192 [ VAM SERVICE SOLUTION ] Clients we work with Tools we use [ Client Spotlight ] Client Portfolio Showcase Explore interactive hero imagery and project executions tailored for this service. [ Got Questions? ] Frequently Asked Questions Everything you need to know about our workflow, deliverables, and service execution. [ Explore More ] Other Core Services Services Hub \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2\"}', '2026-09-09 12:21:14'),
(8, 1, 1, 'https://viraladsmedia.com/service.html?affordable-logo-and-branding-near-me', '51789239190ec419b0a34a9eaa2513eca586526ea6c91d4ceaff81d4770bd438', 200, 'Service Details — Viral Ads Media', 'Explore Viral Ads Media services across social media, SEO, websites, paid ads, branding, influencer campaigns and brand shoots for business growth in Delhi NCR.', 'SERVICE SPECIFICATION NOT FOUND', 'Clients we work with | Tools we use | Client Portfolio Showcase | Frequently Asked Questions | Other Core Services', 118, 0, 0, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/viraladsmedia.comservices.html\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 427, 86, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\"],\"text\":\"Service Details \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 Error SERVICE SPECIFICATION NOT FOUND Return to Services Hub \\u2192 [ VAM SERVICE SOLUTION ] Clients we work with Tools we use [ Client Spotlight ] Client Portfolio Showcase Explore interactive hero imagery and project executions tailored for this service. [ Got Questions? ] Frequently Asked Questions Everything you need to know about our workflow, deliverables, and service execution. [ Explore More ] Other Core Services Services Hub \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2\"}', '2026-09-09 12:21:15'),
(9, 1, 1, 'https://viraladsmedia.com/service.html?best-influencer-marketing-in-delhi', '79f2581b0295372b6e75f966ea8581dd40a1e729e0d8d7e42fe1bcc1a7ec6b42', 200, 'Service Details — Viral Ads Media', 'Explore Viral Ads Media services across social media, SEO, websites, paid ads, branding, influencer campaigns and brand shoots for business growth in Delhi NCR.', 'SERVICE SPECIFICATION NOT FOUND', 'Clients we work with | Tools we use | Client Portfolio Showcase | Frequently Asked Questions | Other Core Services', 118, 0, 0, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/viraladsmedia.comservices.html\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 430, 86, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\"],\"text\":\"Service Details \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 Error SERVICE SPECIFICATION NOT FOUND Return to Services Hub \\u2192 [ VAM SERVICE SOLUTION ] Clients we work with Tools we use [ Client Spotlight ] Client Portfolio Showcase Explore interactive hero imagery and project executions tailored for this service. [ Got Questions? ] Frequently Asked Questions Everything you need to know about our workflow, deliverables, and service execution. [ Explore More ] Other Core Services Services Hub \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2\"}', '2026-09-09 12:21:17'),
(10, 1, 1, 'https://viraladsmedia.com/service.html?proffessional-brand-shoots-in-delhi', '8b5b6f1545aceb34d7e7743cd76cb028e98da9202c3de9e2c23d3b7be2525129', 200, 'Service Details — Viral Ads Media', 'Explore Viral Ads Media services across social media, SEO, websites, paid ads, branding, influencer campaigns and brand shoots for business growth in Delhi NCR.', 'SERVICE SPECIFICATION NOT FOUND', 'Clients we work with | Tools we use | Client Portfolio Showcase | Frequently Asked Questions | Other Core Services', 118, 0, 0, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/viraladsmedia.comservices.html\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 424, 86, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\"],\"text\":\"Service Details \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 Error SERVICE SPECIFICATION NOT FOUND Return to Services Hub \\u2192 [ VAM SERVICE SOLUTION ] Clients we work with Tools we use [ Client Spotlight ] Client Portfolio Showcase Explore interactive hero imagery and project executions tailored for this service. [ Got Questions? ] Frequently Asked Questions Everything you need to know about our workflow, deliverables, and service execution. [ Explore More ] Other Core Services Services Hub \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2\"}', '2026-09-09 12:21:18'),
(11, 1, 1, 'https://viraladsmedia.com/portfolio.html', '289863c9d403d12415f6f2990fc891fab0b98d52e8771b5822f994f8a678af59', 200, 'Viral Ads Media — Our Services & Categories', 'Browse Viral Ads Media work across social media, SEO, websites, paid ads, branding, influencer marketing and creative campaigns.', 'छोटे Business को \n        बड़ा  Brand\n         बनाने का जुनून।', 'SERVICECATEGORIES', 170, 8, 0, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\",\"https:\\/\\/viraladsmedia.com\\/category-records.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/category-records.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/category-records.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/category-records.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/category-records.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR\",\"https:\\/\\/viraladsmedia.com\\/category-records.html?proffessional-video-editor-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/category-records.html?best-social-media-agency-in-delhi\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 452, 88, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/portfolio\\/web.png\",\"alt\":\"Website Designing\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/portfolio\\/performance.png\",\"alt\":\"Performance Marketing\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/portfolio\\/logo-branding.png\",\"alt\":\"Logo & Branding\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/portfolio\\/influencer.png\",\"alt\":\"Influencer Marketing\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/portfolio\\/seo.png\",\"alt\":\"SEO Management\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/portfolio\\/ad.png\",\"alt\":\"Ads Campaign\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/portfolio\\/graphic.png\",\"alt\":\"Graphics & Video Editing\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/portfolio\\/social.png\",\"alt\":\"Social Media Marketing\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":1,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/portfolio.html\"],\"text\":\"Viral Ads Media \\u2014 Our Services & Categories Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now \\u091b\\u094b\\u091f\\u0947 Business \\u0915\\u094b \\u092c\\u0921\\u093c\\u093e Brand \\u092c\\u0928\\u093e\\u0928\\u0947 \\u0915\\u093e \\u091c\\u0941\\u0928\\u0942\\u0928\\u0964 From concept to campaign, we help ambitious businesses like yours turn big dreams into iconic brands - with creativity, strategy, and impact that inspires. Explore All Categories Viral Ads Media \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2\\u009d Categories SERVICECATEGORIES 01 \\/ CATEGORY WEBSITE DESIGNING View Client Records \\u2192 02 \\/ CATEGORY Performance Marketing View Client Records \\u2192 03 \\/ CATEGORY LOGO & BRANDING View Client Records \\u2192 04 \\/ CATEGORY INFLUENCER MARKETING View Client Records \\u2192 05 \\/ CATEGORY SEO MANAGEMENT View Client Records \\u2192 06 \\/ CATEGORY ADS CAMPAIGN View Client Records \\u2192 07 \\/ CATEGORY GRAPHICS & VIDEO EDITING View Client Records \\u2192 08 \\/ CATEGORY SOCIAL MEDIA MARKETING View Client Records \\u2192 Scroll horizontally 7 Categories\"}', '2026-09-09 12:21:20'),
(12, 1, 1, 'https://viraladsmedia.com/industries.html', '4478f29c623936f4d40a126d58a6589773e7e6a4ccbb1bef813994d9fed4e361', 200, 'Industries We Serve — Viral Ads Media', 'See how Viral Ads Media supports brands across industries with social media, SEO, paid ads, websites and creative growth strategies.', 'हर इंडस्ट्री में \n        डिफ़रेंस Create \n        करने की क्षमता।', 'Select Industry Ecosystem', 127, 0, 0, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 432, 88, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":1,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/industries.html\"],\"text\":\"Industries We Serve \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now [ HIERARCHICAL DOMAINS ] \\u0939\\u0930 \\u0907\\u0902\\u0921\\u0938\\u094d\\u091f\\u094d\\u0930\\u0940 \\u092e\\u0947\\u0902 \\u0921\\u093f\\u092b\\u093c\\u0930\\u0947\\u0902\\u0938 Create \\u0915\\u0930\\u0928\\u0947 \\u0915\\u0940 \\u0915\\u094d\\u0937\\u092e\\u0924\\u093e\\u0964 Explore our dynamic industry matrix. Select any sector below to inspect deep vertical strategies, service deployments, and verified client records. Home \\/ Portfolio \\/ Industries Matrix [ SECTOR DIRECTORY ] Select Industry Ecosystem Dynamically links to tailored category records, case studies, and cross-platform growth services. Need a cross-sector custom strategy? Seamlessly pivot across multiple services and industry verticals with our expert architects. View All Services Let\'s Talk\"}', '2026-09-09 12:21:21'),
(13, 1, 1, 'https://viraladsmedia.com/industry-detail.html?affordable-e-commerce-website-development-services', '453837d6dbea222b66d15ab318022d14fd1ee35e5eb09db82b76b0119314ebda', 200, 'Industry Niche Records — Viral Ads Media', 'Discover industry-specific marketing solutions from Viral Ads Media for growth-focused brands in Delhi NCR and beyond.', 'INDUSTRY SECTOR NOT FOUND', 'EXCLUSIVE PORTFOLIO OF BRANDS | CASE STUDIES | EXPLORE OTHER INDUSTRIES', 104, 1, 1, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 437, 80, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\"],\"text\":\"Industry Niche Records \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 INDUSTRY SECTOR NOT FOUND Back to Industries Directory Niche Specialty \\u2190 All Industries \\u2192 Sector Impact & Performance [ Verified Ecosystem ] EXCLUSIVE PORTFOLIO OF BRANDS Verified client logos representing successful campaigns and digital executions in this sector. [ Proven Execution ] CASE STUDIES [ Directory Matrix ] EXPLORE OTHER INDUSTRIES All Industries \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2\"}', '2026-09-09 12:21:23'),
(14, 1, 1, 'https://viraladsmedia.com/industry-detail.html?healthcare-marketing-services', 'adf31cea028938761c0169440bcb495e6371a3d70276718d4b7b16979e953065', 200, 'Industry Niche Records — Viral Ads Media', 'Discover industry-specific marketing solutions from Viral Ads Media for growth-focused brands in Delhi NCR and beyond.', 'INDUSTRY SECTOR NOT FOUND', 'EXCLUSIVE PORTFOLIO OF BRANDS | CASE STUDIES | EXPLORE OTHER INDUSTRIES', 104, 1, 1, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 425, 80, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\"],\"text\":\"Industry Niche Records \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 INDUSTRY SECTOR NOT FOUND Back to Industries Directory Niche Specialty \\u2190 All Industries \\u2192 Sector Impact & Performance [ Verified Ecosystem ] EXCLUSIVE PORTFOLIO OF BRANDS Verified client logos representing successful campaigns and digital executions in this sector. [ Proven Execution ] CASE STUDIES [ Directory Matrix ] EXPLORE OTHER INDUSTRIES All Industries \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2\"}', '2026-09-09 12:21:24'),
(15, 1, 1, 'https://viraladsmedia.com/industry-detail.html?manufacturing-marketing-services', '66a1b661356274aecf183b44438b875bc6cbb8870af646de6f35a2bff91bc620', 200, 'Industry Niche Records — Viral Ads Media', 'Discover industry-specific marketing solutions from Viral Ads Media for growth-focused brands in Delhi NCR and beyond.', 'INDUSTRY SECTOR NOT FOUND', 'EXCLUSIVE PORTFOLIO OF BRANDS | CASE STUDIES | EXPLORE OTHER INDUSTRIES', 104, 1, 1, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 438, 80, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\"],\"text\":\"Industry Niche Records \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 INDUSTRY SECTOR NOT FOUND Back to Industries Directory Niche Specialty \\u2190 All Industries \\u2192 Sector Impact & Performance [ Verified Ecosystem ] EXCLUSIVE PORTFOLIO OF BRANDS Verified client logos representing successful campaigns and digital executions in this sector. [ Proven Execution ] CASE STUDIES [ Directory Matrix ] EXPLORE OTHER INDUSTRIES All Industries \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2\"}', '2026-09-09 12:21:26');
INSERT INTO `pages` (`id`, `website_id`, `job_id`, `url`, `url_hash`, `http_status`, `title`, `description`, `h1`, `h2`, `word_count`, `image_count`, `missing_alt`, `internal_links`, `external_links`, `canonical`, `robots`, `schema_count`, `og_count`, `noindex`, `load_ms`, `score`, `details`, `created_at`) VALUES
(16, 1, 1, 'https://viraladsmedia.com/industry-detail.html?real-estate-marketing-services', 'fa02740cc2e57d3b3ef45e7b84e8da254399be0d153534b2d2e229956cea030f', 200, 'Industry Niche Records — Viral Ads Media', 'Discover industry-specific marketing solutions from Viral Ads Media for growth-focused brands in Delhi NCR and beyond.', 'INDUSTRY SECTOR NOT FOUND', 'EXCLUSIVE PORTFOLIO OF BRANDS | CASE STUDIES | EXPLORE OTHER INDUSTRIES', 104, 1, 1, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 444, 80, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\"],\"text\":\"Industry Niche Records \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 INDUSTRY SECTOR NOT FOUND Back to Industries Directory Niche Specialty \\u2190 All Industries \\u2192 Sector Impact & Performance [ Verified Ecosystem ] EXCLUSIVE PORTFOLIO OF BRANDS Verified client logos representing successful campaigns and digital executions in this sector. [ Proven Execution ] CASE STUDIES [ Directory Matrix ] EXPLORE OTHER INDUSTRIES All Industries \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2\"}', '2026-09-09 12:21:27'),
(17, 1, 1, 'https://viraladsmedia.com/industry-detail.html?education-marketing-services', 'e2f42fc8ac1d2e3a50b78068e75176e490a327111553d90e9b64697203b54b12', 200, 'Industry Niche Records — Viral Ads Media', 'Discover industry-specific marketing solutions from Viral Ads Media for growth-focused brands in Delhi NCR and beyond.', 'INDUSTRY SECTOR NOT FOUND', 'EXCLUSIVE PORTFOLIO OF BRANDS | CASE STUDIES | EXPLORE OTHER INDUSTRIES', 104, 1, 1, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 427, 80, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\"],\"text\":\"Industry Niche Records \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 INDUSTRY SECTOR NOT FOUND Back to Industries Directory Niche Specialty \\u2190 All Industries \\u2192 Sector Impact & Performance [ Verified Ecosystem ] EXCLUSIVE PORTFOLIO OF BRANDS Verified client logos representing successful campaigns and digital executions in this sector. [ Proven Execution ] CASE STUDIES [ Directory Matrix ] EXPLORE OTHER INDUSTRIES All Industries \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2\"}', '2026-09-09 12:21:29'),
(18, 1, 1, 'https://viraladsmedia.com/industry-detail.html?fashion-marketing-services', '1c5854e2fb39e602539813f7f6e1d9ff145c7a7572dc9fc8bae838db23063f59', 200, 'Industry Niche Records — Viral Ads Media', 'Discover industry-specific marketing solutions from Viral Ads Media for growth-focused brands in Delhi NCR and beyond.', 'INDUSTRY SECTOR NOT FOUND', 'EXCLUSIVE PORTFOLIO OF BRANDS | CASE STUDIES | EXPLORE OTHER INDUSTRIES', 104, 1, 1, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 458, 80, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\"],\"text\":\"Industry Niche Records \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 INDUSTRY SECTOR NOT FOUND Back to Industries Directory Niche Specialty \\u2190 All Industries \\u2192 Sector Impact & Performance [ Verified Ecosystem ] EXCLUSIVE PORTFOLIO OF BRANDS Verified client logos representing successful campaigns and digital executions in this sector. [ Proven Execution ] CASE STUDIES [ Directory Matrix ] EXPLORE OTHER INDUSTRIES All Industries \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2\"}', '2026-09-09 12:21:30'),
(19, 1, 1, 'https://viraladsmedia.com/industry-detail.html?travel-marketing-services', '6c3473610a61d1105caa45574fe6726bf27ef6086c677a51805840539978f217', 200, 'Industry Niche Records — Viral Ads Media', 'Discover industry-specific marketing solutions from Viral Ads Media for growth-focused brands in Delhi NCR and beyond.', 'INDUSTRY SECTOR NOT FOUND', 'EXCLUSIVE PORTFOLIO OF BRANDS | CASE STUDIES | EXPLORE OTHER INDUSTRIES', 104, 1, 1, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 430, 80, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\"],\"text\":\"Industry Niche Records \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 INDUSTRY SECTOR NOT FOUND Back to Industries Directory Niche Specialty \\u2190 All Industries \\u2192 Sector Impact & Performance [ Verified Ecosystem ] EXCLUSIVE PORTFOLIO OF BRANDS Verified client logos representing successful campaigns and digital executions in this sector. [ Proven Execution ] CASE STUDIES [ Directory Matrix ] EXPLORE OTHER INDUSTRIES All Industries \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2\"}', '2026-09-09 12:21:32'),
(20, 1, 1, 'https://viraladsmedia.com/industry-detail.html?appliances-marketing-service', '3eed6b07e017cf3bc58e7d831382e01e3aba3ad3761dbb3be71bd6c5b2caff57', 200, 'Industry Niche Records — Viral Ads Media', 'Discover industry-specific marketing solutions from Viral Ads Media for growth-focused brands in Delhi NCR and beyond.', 'INDUSTRY SECTOR NOT FOUND', 'EXCLUSIVE PORTFOLIO OF BRANDS | CASE STUDIES | EXPLORE OTHER INDUSTRIES', 104, 1, 1, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 449, 80, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\"],\"text\":\"Industry Niche Records \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 INDUSTRY SECTOR NOT FOUND Back to Industries Directory Niche Specialty \\u2190 All Industries \\u2192 Sector Impact & Performance [ Verified Ecosystem ] EXCLUSIVE PORTFOLIO OF BRANDS Verified client logos representing successful campaigns and digital executions in this sector. [ Proven Execution ] CASE STUDIES [ Directory Matrix ] EXPLORE OTHER INDUSTRIES All Industries \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2\"}', '2026-09-09 12:21:34'),
(21, 1, 1, 'https://viraladsmedia.com/industry-detail.html?cosmetics-marketing-service', '216491e41491bf55f2f96e41cf5e79536c4807be274b6796802ea788282d5219', 200, 'Industry Niche Records — Viral Ads Media', 'Discover industry-specific marketing solutions from Viral Ads Media for growth-focused brands in Delhi NCR and beyond.', 'INDUSTRY SECTOR NOT FOUND', 'EXCLUSIVE PORTFOLIO OF BRANDS | CASE STUDIES | EXPLORE OTHER INDUSTRIES', 104, 1, 1, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 448, 80, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\"],\"text\":\"Industry Niche Records \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 INDUSTRY SECTOR NOT FOUND Back to Industries Directory Niche Specialty \\u2190 All Industries \\u2192 Sector Impact & Performance [ Verified Ecosystem ] EXCLUSIVE PORTFOLIO OF BRANDS Verified client logos representing successful campaigns and digital executions in this sector. [ Proven Execution ] CASE STUDIES [ Directory Matrix ] EXPLORE OTHER INDUSTRIES All Industries \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2\"}', '2026-09-09 12:21:35'),
(22, 1, 1, 'https://viraladsmedia.com/about.html', '90bd450b4c322ca7cb9c2876960b3a7d6f17c764286fc4e1313ea0e64601113e', 200, 'Viral Ads Media | Responsive', 'Learn about Viral Ads Media, a creative digital marketing agency in Delhi NCR focused on growth strategy, content, branding, paid ads and performance-driven execution.', '', 'We’re the digital architects behind\n        bold, viral,\n        \n          memorable work\n        .\n        \n        \n          Pushing creative limits for brands that dare to stand out. | Where We Contribute | See more Projects', 271, 7, 5, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 430, 68, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Graphics\\/14.jpg\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Graphics\\/11.jpg\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Graphics\\/12.jpg\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Graphics\\/13.jpg\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/office.png\",\"alt\":\"Office Environment\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/about.html\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":0,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/about.html\"],\"text\":\"Viral Ads Media | Responsive Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u201a\\u00c2 \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u20ac\\u017e\\u00c2\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now SCROLL DOWN \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00a2 EXPERIENCE DEPTH \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00a2 SCROLL DOWN \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00a2 EXPERIENCE DEPTH \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00a2 Tiptop Frensz Forever Allied Taps Drapple Hoot Beauty JPI SS Light Ro\'s Backery Belmont Eltons Tiptop Frensz Forever Allied Taps Drapple Hoot Beauty JPI SS Light Ro\'s Backery Belmont Eltons We\\u2019re the digital architects behind bold, viral, memorable work . Pushing creative limits for brands that dare to stand out. We deliberately take no shortcuts in our work. Every client goes through the same process - brand workshop, competitive research, moodboard, identity system - because skipping steps is how you end up with a logo instead of a brand. The answer is built around three things: the soul of the founder, the truth of the market, and the trust of the people we\'re all trying to reach. When those three align, a brand stops being visual and starts being visceral. View Services View Portfolio Where We Contribute Brand Strategy & Identity 01 Web Design & Development 02 UX\\/UI Product Design 03 Motion & Content Design 04 Let\'s Connect \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00a2 Let\'s Connect \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00a2 Let\'s Connect \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00a2 Let\'s Connect Let\'s Connect \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00a2 Let\'s Connect \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00a2 Let\'s Connect \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00a2 Let\'s Connect Let\'s Connect \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00a2 Let\'s Connect \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00a2 Let\'s Connect \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00a2 Let\'s Connect Let\'s Connect \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00a2 Let\'s Connect \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00a2 Let\'s Connect \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00a2 Let\'s Connect See more Projects BACK TO TOP \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u201a\\u00c2 \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u2039\\u00c5\\u201c Nolana VIEW Acquisition AI VIEW\"}', '2026-09-09 12:21:37'),
(23, 1, 1, 'https://viraladsmedia.com/blogs.html', '560736fb3eb6273a35b88a0cfd91010b1be85ab549445fdb25c705c0d4b3f2d6', 200, 'The Journal — Viral Ads Media', 'Read insights from Viral Ads Media on social media marketing, SEO, paid ads, website strategy, branding and business growth.', 'सोच आपकी...  Impact हमारा!', 'DON\'T MISS THE NEXT ONE', 117, 0, 0, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 453, 88, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":1,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/blogs.html\"],\"text\":\"The Journal \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u2020\\u00e2\\u20ac\\u2122\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2 \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00be\\u00c3\\u201a\\u00c2\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now Viral Ads Media - Insights \\u0938\\u094b\\u091a \\u0906\\u092a\\u0915\\u0940... Impact \\u0939\\u092e\\u093e\\u0930\\u093e! Notes on production, strategy, and the campaigns that actually moved people - written by the people who made them. Featured NO ARTICLES FOUND Try a different search term or category. Reset filters Load More Articles DON\'T MISS THE NEXT ONE One email a month. No recap of every social trend \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u2020\\u00e2\\u20ac\\u2122\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u2026\\u00c2\\u00a1\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u009d just what we learned making the work. Subscribe Subscribed -\"}', '2026-09-09 12:21:38');
INSERT INTO `pages` (`id`, `website_id`, `job_id`, `url`, `url_hash`, `http_status`, `title`, `description`, `h1`, `h2`, `word_count`, `image_count`, `missing_alt`, `internal_links`, `external_links`, `canonical`, `robots`, `schema_count`, `og_count`, `noindex`, `load_ms`, `score`, `details`, `created_at`) VALUES
(24, 1, 1, 'https://viraladsmedia.com/career.html', '86e3e1ef116a8b302d055822ece393b7346b5bfba636f9652dd6ee617d6cb1dc', 200, 'Careers | Viral Ads Media - Digital Creative Agency', 'Join Viral Ads Media and build campaigns across social media, SEO, paid ads, content, branding and digital growth.', 'जहाँ सोच बनती है\n         Strategy, \n        और\n        Strategy बनती\n          है Success.', 'Advertising with the \n          वायरल\n            की शक्ति। | Open पोज़िशन्स | Apply For Any रोल | Agency हेडक्वार्टर्स', 478, 0, 0, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 442, 94, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":1,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/career.html\"],\"text\":\"Careers | Viral Ads Media - Digital Creative Agency Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u201a\\u00c2 \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u20ac\\u017e\\u00c2\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now JOIN OUR CREATIVE FORCE \\u091c\\u0939\\u093e\\u0901 \\u0938\\u094b\\u091a \\u092c\\u0928\\u0924\\u0940 \\u0939\\u0948 Strategy, \\u0914\\u0930 Strategy \\u092c\\u0928\\u0924\\u0940 \\u0939\\u0948 Success. We\'re looking for fearless creators, master engineers, and performance-driven minds ready to push boundaries at Viral Ads Media. Explore Open Roles Direct Application Form [01] Our Core Philosophy Advertising with the \\u0935\\u093e\\u092f\\u0930\\u0932 \\u0915\\u0940 \\u0936\\u0915\\u094d\\u0924\\u093f\\u0964 At Viral Ads Media, we don\'t just run standard campaigns - we engineer digital architecture, high-end commercial concepts, and organic momentum that captures consumer attention on a massive scale. Scale-Driven Execution Transforming brand presence into high-volume leads. AI & Tech Integrated Leveraging cutting-edge automation and analytics systems. [02] Current Open Positions Open \\u092a\\u094b\\u091c\\u093c\\u093f\\u0936\\u0928\\u094d\\u0938 Select any role below to instantly apply or submit via our universal lead form. Full-Time Delhi \\/ Hybrid Graphic Designer Create stunning branding visuals, social media creatives, high-end pitch decks, and advertising assets that grab instant attention. Apply For This Role Internship Delhi \\/ Stipend Video Editor Intern Edit high-retention short-form reels, TikToks, YouTube shorts, and commercial video edits using Premiere Pro and After Effects. Apply For This Role Internship Delhi \\/ Stipend Digital Marketing Intern Assist in managing Meta & Google ad campaigns, SEO keyword audits, social media tracking reports, and organic growth strategies. Apply For This Role Full-Time Delhi \\/ Hybrid Senior Frontend Developer Lead high-performance web experiences using modern Tailwind CSS, GSAP animations, and interactive component architectures. Apply For This Role Full-Time Delhi \\/ Remote Performance Marketing Specialist Scale high-budget Google and Meta ads campaigns, audit funnel metrics, and optimize conversions for scaling e-commerce brands. Apply For This Role Full-Time \\/ Contract Delhi Video Editor & Motion Designer Craft high-conversion promotional video reels, brand commercials, and dynamic motion graphic assets for viral campaigns. Apply For This Role [03] Direct Submissions Apply For Any \\u0930\\u094b\\u0932 Fill out the form below, select your desired position from the dropdown menu, and attach your portfolio. Full Name * Email Address * Phone Number * Select Position \\/ Role * -- Choose Desired Position -- Graphic Designer Video Editor Intern Digital Marketing Intern Senior Frontend Developer Performance Marketing Specialist Video Editor & Motion Designer General Open Application Portfolio \\/ GitHub \\/ LinkedIn URL * Cover Note \\/ Why Viral Ads Media? * Submit Application [04] Reach Out Agency \\u0939\\u0947\\u0921\\u0915\\u094d\\u0935\\u093e\\u0930\\u094d\\u091f\\u0930\\u094d\\u0938 Have specific inquiries regarding career paths or partnerships? Contact our team directly. WhatsApp Support +91 93544 91934 Email Inquiries info@viraladsmedia.com Headquarters B-33, Khatu Shyam Mandir Road, near Max Bazar, Budh Vihar Phase I, Delhi, 110086 Application Portal Apply for Role Full Name * Email Address * Phone Number * Portfolio \\/ LinkedIn URL Cover Note \\/ Why You? Submit Application\"}', '2026-09-09 12:21:40'),
(25, 1, 1, 'https://viraladsmedia.com/contact.html', '9a49237a36cb65c096eb2bd78318d96efd480b010114f6b3a4b0691e79bf8043', 200, 'Contact Us | Digital Marketing Agency', 'Contact our digital marketing agency for social media marketing, SEO, ads, website design and lead generation services.', 'हर \n            Brand\n            के पीछे एक story\n            होती है... \n            \n            हम उसे।\n            duniya\n            तक पहुँचाते हैं।', 'Share your  \n            प्रोजेक्ट\n            details. | We’re available \n            ऑनलाइन \n            and in-person. | Before you \n            कॉन्टैक्ट \n            us.', 367, 0, 0, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 480, 94, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":1,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/contact.html\"],\"text\":\"Contact Us | Digital Marketing Agency Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u201a\\u00c2 \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u20ac\\u017e\\u00c2\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now Contact our growth team \\u0939\\u0930 Brand \\u0915\\u0947 \\u092a\\u0940\\u091b\\u0947 \\u090f\\u0915 story \\u0939\\u094b\\u0924\\u0940 \\u0939\\u0948... \\u0939\\u092e \\u0909\\u0938\\u0947\\u0964 duniya \\u0924\\u0915 \\u092a\\u0939\\u0941\\u0901\\u091a\\u093e\\u0924\\u0947 \\u0939\\u0948\\u0902\\u0964 Tell us your goals, challenges and project requirements. We\'ll help you choose the right strategy for ads, SEO, social media, website design and lead generation. Send Enquiry \\u2192 Call Now Email info@viraladsmedia.com Phone +91 93544 91934 Location B-33, Khatu shyam Mandir Road, near Max Bazar, Budh Vihar Phase I, Delhi, 110086 Hours Mon-Sat, 10 AM-7 PM Meta Ads\\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2\\u009d\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u008fSEO\\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2\\u009d\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u008fWebsite Design\\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2\\u009d\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u008fSocial Media\\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2\\u009d\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u008fLead Generation\\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2\\u009d\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u008f Meta Ads\\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2\\u009d\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u008fSEO\\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2\\u009d\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u008fWebsite Design\\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2\\u009d\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u008fSocial Media\\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2\\u009d\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u008fLead Generation\\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2\\u009d\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u008f Start a conversation Share your \\u092a\\u094d\\u0930\\u094b\\u091c\\u0947\\u0915\\u094d\\u091f details. Fill out the form and our team will get back to you with the right next step. You can also contact us directly through phone, email or WhatsApp. WhatsApp Chat with our team \\u2192 Email info@viraladsmedia.com \\u2192 Full Name * Phone Number * Email Address Company \\/ Brand Service Required * Select service Social Media Marketing Meta Ads \\/ Google Ads SEO & Content Website Design Lead Generation Complete Digital Marketing Budget Range Select budget Below \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u2026\\u00c2\\u00a1\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00b925,000 \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u2026\\u00c2\\u00a1\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00b925,000 \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u2026\\u00e2\\u20ac\\u0153 \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u2026\\u00c2\\u00a1\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00b950,000 \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u2026\\u00c2\\u00a1\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00b950,000 \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u2026\\u00e2\\u20ac\\u0153 \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u2026\\u00c2\\u00a1\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00b91,00,000 \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u2026\\u00c2\\u00a1\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00b91,00,000+ Message * Submit Enquiry \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u201a\\u00c2 \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u20ac\\u017e\\u00c2\\u00a2 Location Map B-33, Khatu shyam Mandir Road, near Max Bazar, Budh Vihar Phase I, Delhi, 110086 Replace this area with your Google Map embed code. Visit \\/ Connect We\\u2019re available \\u0911\\u0928\\u0932\\u093e\\u0907\\u0928 and in-person. Book a consultation call or send your brief. We\'ll understand your business and suggest the best digital growth plan. Office B-33, Khatu shyam Mandir Road, near Max Bazar, Budh Vihar Phase I, Delhi, 110086 Response Time Within 24 hours FAQs Before you \\u0915\\u0949\\u0928\\u094d\\u091f\\u0948\\u0915\\u094d\\u091f us. How soon will you reply? + Usually within 24 hours on working days. For urgent projects, WhatsApp is the fastest option. Can you handle complete digital marketing? + Yes. We can manage social media, ads, SEO, creative design, landing pages, reporting and strategy. Do you work on monthly retainers? + Yes. We offer monthly retainers, one-time campaigns, website projects and growth sprints.\"}', '2026-09-09 12:21:41'),
(26, 1, 1, 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'bc0fa68ee99d9f494a2dde26740d59fe77df1921f12a7a64c052aa305a522c4d', 200, 'Service Category Records — Viral Ads Media', 'Explore Viral Ads Media service categories and creative marketing capabilities built for growth-focused brands.', 'CATEGORY NOT FOUND', 'BRANDS WE SERVED IN THIS CATEGORY | FEATURED CASE STUDIES | OUR OTHER SERVICES', 99, 1, 1, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 424, 80, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/category-records.html?affordable-web-developer-in-delhi\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/category-records.html?affordable-web-developer-in-delhi\"],\"text\":\"Service Category Records \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All \\u2192 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 CATEGORY NOT FOUND Back to all categories Service Specialty Milestones & Track Record [ Verified Deployments ] BRANDS WE SERVED IN THIS CATEGORY Companies and enterprise partners who successfully scaled using this specific solution. [ Proven Execution ] FEATURED CASE STUDIES [ Explore More ] OUR OTHER SERVICES View All \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u201a\\u00c2 \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u20ac\\u017e\\u00c2\\u00a2\"}', '2026-09-09 12:21:43'),
(27, 1, 1, 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', '048d254c0d3a16f911f68999c6cacc7308a95e3faa76108a72696da36fc0bb34', 200, 'Service Category Records — Viral Ads Media', 'Explore Viral Ads Media service categories and creative marketing capabilities built for growth-focused brands.', 'CATEGORY NOT FOUND', 'BRANDS WE SERVED IN THIS CATEGORY | FEATURED CASE STUDIES | OUR OTHER SERVICES', 99, 1, 1, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 436, 80, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/category-records.html?best-performance-marketing-in-delhi\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/category-records.html?best-performance-marketing-in-delhi\"],\"text\":\"Service Category Records \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All \\u2192 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 CATEGORY NOT FOUND Back to all categories Service Specialty Milestones & Track Record [ Verified Deployments ] BRANDS WE SERVED IN THIS CATEGORY Companies and enterprise partners who successfully scaled using this specific solution. [ Proven Execution ] FEATURED CASE STUDIES [ Explore More ] OUR OTHER SERVICES View All \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u201a\\u00c2 \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u20ac\\u017e\\u00c2\\u00a2\"}', '2026-09-09 12:21:44'),
(28, 1, 1, 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'cdbfbf6ad68b7a63622bc4c3a520812422f235d6cd09cfb1250a0f0e1cd87b82', 200, 'Service Category Records — Viral Ads Media', 'Explore Viral Ads Media service categories and creative marketing capabilities built for growth-focused brands.', 'CATEGORY NOT FOUND', 'BRANDS WE SERVED IN THIS CATEGORY | FEATURED CASE STUDIES | OUR OTHER SERVICES', 99, 1, 1, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 440, 80, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/category-records.html?affordable-logo-and-branding-near-me\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/category-records.html?affordable-logo-and-branding-near-me\"],\"text\":\"Service Category Records \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All \\u2192 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 CATEGORY NOT FOUND Back to all categories Service Specialty Milestones & Track Record [ Verified Deployments ] BRANDS WE SERVED IN THIS CATEGORY Companies and enterprise partners who successfully scaled using this specific solution. [ Proven Execution ] FEATURED CASE STUDIES [ Explore More ] OUR OTHER SERVICES View All \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u201a\\u00c2 \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u20ac\\u017e\\u00c2\\u00a2\"}', '2026-09-09 12:21:46'),
(29, 1, 1, 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'ccbb29ac10d09b0add354901a7eac5e5d936bb545da0b09e55fe66439e5c4fda', 200, 'Service Category Records — Viral Ads Media', 'Explore Viral Ads Media service categories and creative marketing capabilities built for growth-focused brands.', 'CATEGORY NOT FOUND', 'BRANDS WE SERVED IN THIS CATEGORY | FEATURED CASE STUDIES | OUR OTHER SERVICES', 99, 1, 1, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 434, 80, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/category-records.html?best-influencer-marketing-in-delhi\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/category-records.html?best-influencer-marketing-in-delhi\"],\"text\":\"Service Category Records \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All \\u2192 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 CATEGORY NOT FOUND Back to all categories Service Specialty Milestones & Track Record [ Verified Deployments ] BRANDS WE SERVED IN THIS CATEGORY Companies and enterprise partners who successfully scaled using this specific solution. [ Proven Execution ] FEATURED CASE STUDIES [ Explore More ] OUR OTHER SERVICES View All \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u201a\\u00c2 \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u20ac\\u017e\\u00c2\\u00a2\"}', '2026-09-09 12:21:47'),
(30, 1, 1, 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'd6e234854c463ad4e9297073848e16182b0239016ca497164bbd2ba6f343e5f4', 200, 'Service Category Records — Viral Ads Media', 'Explore Viral Ads Media service categories and creative marketing capabilities built for growth-focused brands.', 'CATEGORY NOT FOUND', 'BRANDS WE SERVED IN THIS CATEGORY | FEATURED CASE STUDIES | OUR OTHER SERVICES', 99, 1, 1, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 440, 80, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/category-records.html?best-seo-agency-near-me\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/category-records.html?best-seo-agency-near-me\"],\"text\":\"Service Category Records \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All \\u2192 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 CATEGORY NOT FOUND Back to all categories Service Specialty Milestones & Track Record [ Verified Deployments ] BRANDS WE SERVED IN THIS CATEGORY Companies and enterprise partners who successfully scaled using this specific solution. [ Proven Execution ] FEATURED CASE STUDIES [ Explore More ] OUR OTHER SERVICES View All \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u201a\\u00c2 \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u20ac\\u017e\\u00c2\\u00a2\"}', '2026-09-09 12:21:49'),
(31, 1, 1, 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'd57e91fa2d5eacab046900a30c14391b036aa955fb1847f5faa99ee22b22184b', 200, 'Service Category Records — Viral Ads Media', 'Explore Viral Ads Media service categories and creative marketing capabilities built for growth-focused brands.', 'CATEGORY NOT FOUND', 'BRANDS WE SERVED IN THIS CATEGORY | FEATURED CASE STUDIES | OUR OTHER SERVICES', 99, 1, 1, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 686, 80, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR\"],\"text\":\"Service Category Records \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All \\u2192 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 CATEGORY NOT FOUND Back to all categories Service Specialty Milestones & Track Record [ Verified Deployments ] BRANDS WE SERVED IN THIS CATEGORY Companies and enterprise partners who successfully scaled using this specific solution. [ Proven Execution ] FEATURED CASE STUDIES [ Explore More ] OUR OTHER SERVICES View All \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u201a\\u00c2 \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u20ac\\u017e\\u00c2\\u00a2\"}', '2026-09-09 12:22:25');
INSERT INTO `pages` (`id`, `website_id`, `job_id`, `url`, `url_hash`, `http_status`, `title`, `description`, `h1`, `h2`, `word_count`, `image_count`, `missing_alt`, `internal_links`, `external_links`, `canonical`, `robots`, `schema_count`, `og_count`, `noindex`, `load_ms`, `score`, `details`, `created_at`) VALUES
(32, 1, 1, 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', '3bbdf7d965bbd20e31608275cd6e26cfb9be72dbf6b23f38a67d07c5098de03d', 200, 'Service Category Records — Viral Ads Media', 'Explore Viral Ads Media service categories and creative marketing capabilities built for growth-focused brands.', 'CATEGORY NOT FOUND', 'BRANDS WE SERVED IN THIS CATEGORY | FEATURED CASE STUDIES | OUR OTHER SERVICES', 99, 1, 1, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 557, 80, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/category-records.html?proffessional-video-editor-in-delhi\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/category-records.html?proffessional-video-editor-in-delhi\"],\"text\":\"Service Category Records \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All \\u2192 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 CATEGORY NOT FOUND Back to all categories Service Specialty Milestones & Track Record [ Verified Deployments ] BRANDS WE SERVED IN THIS CATEGORY Companies and enterprise partners who successfully scaled using this specific solution. [ Proven Execution ] FEATURED CASE STUDIES [ Explore More ] OUR OTHER SERVICES View All \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u201a\\u00c2 \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u20ac\\u017e\\u00c2\\u00a2\"}', '2026-09-09 12:22:27'),
(33, 1, 1, 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', '0dea33dbae412c397a198d9f2cf8ef4854f2cd6a7f54771301fe43dc44b052cf', 200, 'Service Category Records — Viral Ads Media', 'Explore Viral Ads Media service categories and creative marketing capabilities built for growth-focused brands.', 'CATEGORY NOT FOUND', 'BRANDS WE SERVED IN THIS CATEGORY | FEATURED CASE STUDIES | OUR OTHER SERVICES', 99, 1, 1, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 542, 80, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/category-records.html?best-social-media-agency-in-delhi\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/category-records.html?best-social-media-agency-in-delhi\"],\"text\":\"Service Category Records \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All \\u2192 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 CATEGORY NOT FOUND Back to all categories Service Specialty Milestones & Track Record [ Verified Deployments ] BRANDS WE SERVED IN THIS CATEGORY Companies and enterprise partners who successfully scaled using this specific solution. [ Proven Execution ] FEATURED CASE STUDIES [ Explore More ] OUR OTHER SERVICES View All \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u201a\\u00c2 \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u20ac\\u017e\\u00c2\\u00a2\"}', '2026-09-09 12:22:29'),
(34, 1, 4, 'https://viraladsmedia.com/', '896cf55f971057033dbf92d009e90354ca40b45770ed9c960795296ed4fa0afd', 200, 'Best Digital Marketing Agency in Delhi NCR | SEO, Ads, SMM & Viral Growth', 'Build a powerful online presence with Viral Ads Media, a creative digital marketing agency in Delhi NCR offering SEO, social media, paid ads, branding & growth strategies that deliver results.', 'Ideas\r\n        हमारे होते हैं... \r\n        Viral Moment\r\n        आपका होता है!', 'WebsiteDesigning | Performance Marketing | Logo &Branding | InfluencerMarketing | SEOManagement | ADSCampaign | Graphics & Video Editing | Crafted for\r\n            इम्पैक्ट. | Our क्लाइंट्स. | From brief to\r\n            एक्ज़ीक्यूशन. | Results That Speak \r\n          लाउडर\r\n          Than Promises.', 468, 65, 8, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 467, 84, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/services\\/web.jpg\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/services\\/performance.jpg\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/services\\/logo.jpg\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/services\\/influence.jpg\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/services\\/seo.jpg\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/services\\/ads.jpg\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/services\\/graphic.jpg\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Project\\/20.jpg\",\"alt\":\"Topson\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Project\\/21.jpg\",\"alt\":\"Lumen Skincare\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Project\\/22.png\",\"alt\":\"Pulse Fitness\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Project\\/23.jpg\",\"alt\":\"Stratos Sportswear\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/saptron.png\",\"alt\":\"Client 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/allied.png\",\"alt\":\"Client 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/aryan.png\",\"alt\":\"Client 3\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/bakery.png\",\"alt\":\"Client 4\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/balaji.png\",\"alt\":\"Client 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/component.png\",\"alt\":\"Client 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/delmont.png\",\"alt\":\"Client 9\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/drapple.png\",\"alt\":\"Client 10\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/eltons.png\",\"alt\":\"Client 12\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/franklite.png\",\"alt\":\"Client 13\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/frendz_forever.png\",\"alt\":\"Client 14\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/gboss.png\",\"alt\":\"Client 15\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/glamfam.png\",\"alt\":\"Client 16\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/guruji.png\",\"alt\":\"Client 17\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/jbj.png\",\"alt\":\"Client 26\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/jyoti.png\",\"alt\":\"Client 27\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/kamal.png\",\"alt\":\"Client 28\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/sketch.png\",\"alt\":\"Client 29\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/mango.png\",\"alt\":\"Client 30\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/medyra.png\",\"alt\":\"Client 31\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/minar.png\",\"alt\":\"Client 32\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/navigator.png\",\"alt\":\"Client 33\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/nipex.png\",\"alt\":\"Client 34\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/nippon.png\",\"alt\":\"Client 35\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/nugraj.png\",\"alt\":\"Client 36\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/allied.png\",\"alt\":\"1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/allied.png\",\"alt\":\"2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/pixel-cable.png\",\"alt\":\"4\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/presco.png\",\"alt\":\"5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/saptron.png\",\"alt\":\"6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/savele.png\",\"alt\":\"7\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/shri-shyam.png\",\"alt\":\"8\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/sketch.png\",\"alt\":\"9\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/tdii.png\",\"alt\":\"10\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/tiptop.png\",\"alt\":\"11\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/topson.png\",\"alt\":\"12\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/trophy.png\",\"alt\":\"13\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/bakery.png\",\"alt\":\"14\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/jbj.png\",\"alt\":\"16\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/jyoti.png\",\"alt\":\"17\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/nipex.png\",\"alt\":\"18\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/nippon.png\",\"alt\":\"19\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/frendz_forever.png\",\"alt\":\"20\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/gboss.png\",\"alt\":\"21\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/kamal.png\",\"alt\":\"22\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/minar.png\",\"alt\":\"23\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":1,\"viewport\":\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/\"],\"text\":\"Best Digital Marketing Agency in Delhi NCR | SEO, Ads, SMM & Viral Growth Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00e2\\u2020\\u2019 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u00e2\\u2020\\u2019 Company Blogs Career Let\'s Talk Pay Now Who We are? Ideas \\u0939\\u092e\\u093e\\u0930\\u0947 \\u0939\\u094b\\u0924\\u0947 \\u0939\\u0948\\u0902... Viral Moment \\u0906\\u092a\\u0915\\u093e \\u0939\\u094b\\u0924\\u093e \\u0939\\u0948! Transforming Brands with Creative Digital Solutions - From Social Media to Web, We Make Your Presence Viral! Let\'s Start Watch Showreel Result Driven Strategies Creative That Performs Brands That Grow WebsiteDesigning Engineered for absolute digital conversion Performance Marketing Data driven results for scaling brands Logo &Branding Identity design for market leading growth InfluencerMarketing Authentic voices driving massive organic reach SEOManagement Identity design for market leading growth ADSCampaign Authentic voices driving massive organic reach Graphics & Video Editing Identity design for market leading growth [02] Selected Work \\/ Portfolio Crafted for \\u0907\\u092e\\u094d\\u092a\\u0948\\u0915\\u094d\\u091f. High-performance creative productions, viral campaigns, and digital architecture built for scaling brands. Brand Launch \\u00b7 2026 TOPSON PLAST Content Series \\u00b7 2026 DRAPPLE Social Campaign \\u00b7 2025 ALLIED TAPS Global Launch \\u00b7 2026 OCEAN BEAUTY Explore All Case Studies Our \\u0915\\u094d\\u0932\\u093e\\u0907\\u0902\\u091f\\u094d\\u0938. Helping new brands start up and old ones start over. View All Clients [04] Process \\/ How We Work From brief to \\u090f\\u0915\\u094d\\u091c\\u093c\\u0940\\u0915\\u094d\\u092f\\u0942\\u0936\\u0928. Our structural engineering methodology turns bold strategies into lightning-fast interactive architectures with complete step-by-step transparency. Phase 01 Discovery Strategic Alignment We align directly with your core vision, target demographic goals, and technical limitations. 01 Phase 02 Blueprints Interactive Wireframing Translating raw requirements into sleek high-contrast mockups and custom typography layouts. 02 Phase 03 Engineering Development & Optimization Coding clean systems using top-tier performance tech stacks to achieve lightning-fast speed. 03 Phase 04 Deployment Seamless Launch Rigorous quality assurance audits followed by server deployment and analytics setup. 04 OUR ACHIEVEMENTS Results That Speak \\u0932\\u093e\\u0909\\u0921\\u0930 Than Promises. Real numbers. Real growth. Real impact for our clients. 300+ BRANDS SCALED From startups to established businesses. 500+ SUCCESSFUL CAMPAIGNS Data-driven campaigns that deliver results. 10M+ ORGANIC & PAID REACH Across platforms that drive real engagement. 95% CLIENT RETENTION RATE Long-term partnerships built on trust. 12 MONTHS OF GROWTH JOURNEY Consistent Growth.Real Results. 100K 75K 50K 25K 0 Campaign Launch SEO Growth Paid Ads Optimization Revenue Growth JANFEBMARAPRMAYJUNJULAUGSEPOCTNOVDEC DIGITAL SOLUTIONS BUILT FOR GROWTH Performance Marketing ROI-focused campaigns that generate leads and boost sales. SEO Strategy Rank higher on Google and attract high intent organic traffic. Creative Branding Unique designs that build brand identity and recognition. Data Driven Marketing Smart insights and analytics to make better marketing decisions. TRUSTED BY BUSINESSES ACROSS INDUSTRIES E-COMMERCE HEALTHCARE MANUFACTURING REAL ESTATE EDUCATION FASHION TRAVEL APPLIANCES COSMETICS Let\'s Grow Your Business Together. Book a quick consultation call to see how we can scale your brand. Enquire Now\"}', '2026-09-10 04:47:02'),
(35, 1, 4, 'https://viraladsmedia.com/index.html', 'e1eac5d7e11d21457cde6715870e9f258d61ea2d91556c91b4b966ae5883f041', 200, 'Best Digital Marketing Agency in Delhi NCR | SEO, Ads, SMM & Viral Growth', 'Build a powerful online presence with Viral Ads Media, a creative digital marketing agency in Delhi NCR offering SEO, social media, paid ads, branding & growth strategies that deliver results.', 'Ideas\r\n        हमारे होते हैं... \r\n        Viral Moment\r\n        आपका होता है!', 'WebsiteDesigning | Performance Marketing | Logo &Branding | InfluencerMarketing | SEOManagement | ADSCampaign | Graphics & Video Editing | Crafted for\r\n            इम्पैक्ट. | Our क्लाइंट्स. | From brief to\r\n            एक्ज़ीक्यूशन. | Results That Speak \r\n          लाउडर\r\n          Than Promises.', 468, 65, 8, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 478, 84, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/services\\/web.jpg\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/services\\/performance.jpg\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/services\\/logo.jpg\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/services\\/influence.jpg\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/services\\/seo.jpg\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/services\\/ads.jpg\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/services\\/graphic.jpg\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Project\\/20.jpg\",\"alt\":\"Topson\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Project\\/21.jpg\",\"alt\":\"Lumen Skincare\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Project\\/22.png\",\"alt\":\"Pulse Fitness\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Project\\/23.jpg\",\"alt\":\"Stratos Sportswear\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/saptron.png\",\"alt\":\"Client 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/allied.png\",\"alt\":\"Client 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/aryan.png\",\"alt\":\"Client 3\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/bakery.png\",\"alt\":\"Client 4\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/balaji.png\",\"alt\":\"Client 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/component.png\",\"alt\":\"Client 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/delmont.png\",\"alt\":\"Client 9\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/drapple.png\",\"alt\":\"Client 10\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/eltons.png\",\"alt\":\"Client 12\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/franklite.png\",\"alt\":\"Client 13\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/frendz_forever.png\",\"alt\":\"Client 14\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/gboss.png\",\"alt\":\"Client 15\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/glamfam.png\",\"alt\":\"Client 16\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/guruji.png\",\"alt\":\"Client 17\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/jbj.png\",\"alt\":\"Client 26\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/jyoti.png\",\"alt\":\"Client 27\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/kamal.png\",\"alt\":\"Client 28\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/sketch.png\",\"alt\":\"Client 29\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/mango.png\",\"alt\":\"Client 30\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/medyra.png\",\"alt\":\"Client 31\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/minar.png\",\"alt\":\"Client 32\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/navigator.png\",\"alt\":\"Client 33\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/nipex.png\",\"alt\":\"Client 34\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/nippon.png\",\"alt\":\"Client 35\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/nugraj.png\",\"alt\":\"Client 36\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/allied.png\",\"alt\":\"1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/allied.png\",\"alt\":\"2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/pixel-cable.png\",\"alt\":\"4\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/presco.png\",\"alt\":\"5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/saptron.png\",\"alt\":\"6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/savele.png\",\"alt\":\"7\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/shri-shyam.png\",\"alt\":\"8\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/sketch.png\",\"alt\":\"9\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/tdii.png\",\"alt\":\"10\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/tiptop.png\",\"alt\":\"11\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/topson.png\",\"alt\":\"12\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/trophy.png\",\"alt\":\"13\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/bakery.png\",\"alt\":\"14\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/jbj.png\",\"alt\":\"16\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/jyoti.png\",\"alt\":\"17\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/nipex.png\",\"alt\":\"18\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/nippon.png\",\"alt\":\"19\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/frendz_forever.png\",\"alt\":\"20\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/gboss.png\",\"alt\":\"21\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/kamal.png\",\"alt\":\"22\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/brands\\/minar.png\",\"alt\":\"23\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":1,\"viewport\":\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/index.html\"],\"text\":\"Best Digital Marketing Agency in Delhi NCR | SEO, Ads, SMM & Viral Growth Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00e2\\u2020\\u2019 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u00e2\\u2020\\u2019 Company Blogs Career Let\'s Talk Pay Now Who We are? Ideas \\u0939\\u092e\\u093e\\u0930\\u0947 \\u0939\\u094b\\u0924\\u0947 \\u0939\\u0948\\u0902... Viral Moment \\u0906\\u092a\\u0915\\u093e \\u0939\\u094b\\u0924\\u093e \\u0939\\u0948! Transforming Brands with Creative Digital Solutions - From Social Media to Web, We Make Your Presence Viral! Let\'s Start Watch Showreel Result Driven Strategies Creative That Performs Brands That Grow WebsiteDesigning Engineered for absolute digital conversion Performance Marketing Data driven results for scaling brands Logo &Branding Identity design for market leading growth InfluencerMarketing Authentic voices driving massive organic reach SEOManagement Identity design for market leading growth ADSCampaign Authentic voices driving massive organic reach Graphics & Video Editing Identity design for market leading growth [02] Selected Work \\/ Portfolio Crafted for \\u0907\\u092e\\u094d\\u092a\\u0948\\u0915\\u094d\\u091f. High-performance creative productions, viral campaigns, and digital architecture built for scaling brands. Brand Launch \\u00b7 2026 TOPSON PLAST Content Series \\u00b7 2026 DRAPPLE Social Campaign \\u00b7 2025 ALLIED TAPS Global Launch \\u00b7 2026 OCEAN BEAUTY Explore All Case Studies Our \\u0915\\u094d\\u0932\\u093e\\u0907\\u0902\\u091f\\u094d\\u0938. Helping new brands start up and old ones start over. View All Clients [04] Process \\/ How We Work From brief to \\u090f\\u0915\\u094d\\u091c\\u093c\\u0940\\u0915\\u094d\\u092f\\u0942\\u0936\\u0928. Our structural engineering methodology turns bold strategies into lightning-fast interactive architectures with complete step-by-step transparency. Phase 01 Discovery Strategic Alignment We align directly with your core vision, target demographic goals, and technical limitations. 01 Phase 02 Blueprints Interactive Wireframing Translating raw requirements into sleek high-contrast mockups and custom typography layouts. 02 Phase 03 Engineering Development & Optimization Coding clean systems using top-tier performance tech stacks to achieve lightning-fast speed. 03 Phase 04 Deployment Seamless Launch Rigorous quality assurance audits followed by server deployment and analytics setup. 04 OUR ACHIEVEMENTS Results That Speak \\u0932\\u093e\\u0909\\u0921\\u0930 Than Promises. Real numbers. Real growth. Real impact for our clients. 300+ BRANDS SCALED From startups to established businesses. 500+ SUCCESSFUL CAMPAIGNS Data-driven campaigns that deliver results. 10M+ ORGANIC & PAID REACH Across platforms that drive real engagement. 95% CLIENT RETENTION RATE Long-term partnerships built on trust. 12 MONTHS OF GROWTH JOURNEY Consistent Growth.Real Results. 100K 75K 50K 25K 0 Campaign Launch SEO Growth Paid Ads Optimization Revenue Growth JANFEBMARAPRMAYJUNJULAUGSEPOCTNOVDEC DIGITAL SOLUTIONS BUILT FOR GROWTH Performance Marketing ROI-focused campaigns that generate leads and boost sales. SEO Strategy Rank higher on Google and attract high intent organic traffic. Creative Branding Unique designs that build brand identity and recognition. Data Driven Marketing Smart insights and analytics to make better marketing decisions. TRUSTED BY BUSINESSES ACROSS INDUSTRIES E-COMMERCE HEALTHCARE MANUFACTURING REAL ESTATE EDUCATION FASHION TRAVEL APPLIANCES COSMETICS Let\'s Grow Your Business Together. Book a quick consultation call to see how we can scale your brand. Enquire Now\"}', '2026-09-10 04:47:05'),
(36, 1, 4, 'https://viraladsmedia.com/services.html', 'cd28f49b95407450e1609229398a71c49e7e85844cf2e27093406e24588fcca5', 200, 'Services | Viral Ads Media', 'Explore Viral Ads Media services including social media marketing, SEO, website design, performance marketing, branding, influencer campaigns and brand shoots in Delhi NCR.', 'हम Ads \n        नहीं चलाते...  \n        हम Attention Capture \n        करते हैं!', '', 70, 0, 0, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 404, 86, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":1,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/services.html\"],\"text\":\"Services | Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now \\u0939\\u092e Ads \\u0928\\u0939\\u0940\\u0902 \\u091a\\u0932\\u093e\\u0924\\u0947... \\u0939\\u092e Attention Capture \\u0915\\u0930\\u0924\\u0947 \\u0939\\u0948\\u0902! Unlock elevated, measurable growth through tailored strategies, seamless campaign execution and beautiful purpose-built web experiences.\"}', '2026-09-10 04:47:08'),
(37, 1, 4, 'https://viraladsmedia.com/service.html?best-social-media-agency-in-delhi', 'e0d8f9142947f630882834b4609af999fd74051144649f68420b88b6525f1f13', 200, 'Service Details — Viral Ads Media', 'Explore Viral Ads Media services across social media, SEO, websites, paid ads, branding, influencer campaigns and brand shoots for business growth in Delhi NCR.', 'SERVICE SPECIFICATION NOT FOUND', 'Clients we work with | Tools we use | Client Portfolio Showcase | Frequently Asked Questions | Other Core Services', 118, 0, 0, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/viraladsmedia.comservices.html\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 475, 86, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\"],\"text\":\"Service Details \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 Error SERVICE SPECIFICATION NOT FOUND Return to Services Hub \\u2192 [ VAM SERVICE SOLUTION ] Clients we work with Tools we use [ Client Spotlight ] Client Portfolio Showcase Explore interactive hero imagery and project executions tailored for this service. [ Got Questions? ] Frequently Asked Questions Everything you need to know about our workflow, deliverables, and service execution. [ Explore More ] Other Core Services Services Hub \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2\"}', '2026-09-10 04:47:11');
INSERT INTO `pages` (`id`, `website_id`, `job_id`, `url`, `url_hash`, `http_status`, `title`, `description`, `h1`, `h2`, `word_count`, `image_count`, `missing_alt`, `internal_links`, `external_links`, `canonical`, `robots`, `schema_count`, `og_count`, `noindex`, `load_ms`, `score`, `details`, `created_at`) VALUES
(38, 1, 4, 'https://viraladsmedia.com/service.html?best-seo-agency-near-me', '34f525224068b756137d474043d615dd9a21836775f445d7bb5210130077d9e7', 200, 'Service Details — Viral Ads Media', 'Explore Viral Ads Media services across social media, SEO, websites, paid ads, branding, influencer campaigns and brand shoots for business growth in Delhi NCR.', 'SERVICE SPECIFICATION NOT FOUND', 'Clients we work with | Tools we use | Client Portfolio Showcase | Frequently Asked Questions | Other Core Services', 118, 0, 0, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/viraladsmedia.comservices.html\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 413, 86, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\"],\"text\":\"Service Details \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 Error SERVICE SPECIFICATION NOT FOUND Return to Services Hub \\u2192 [ VAM SERVICE SOLUTION ] Clients we work with Tools we use [ Client Spotlight ] Client Portfolio Showcase Explore interactive hero imagery and project executions tailored for this service. [ Got Questions? ] Frequently Asked Questions Everything you need to know about our workflow, deliverables, and service execution. [ Explore More ] Other Core Services Services Hub \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2\"}', '2026-09-10 04:47:14'),
(39, 1, 4, 'https://viraladsmedia.com/service.html?affordable-web-developer-in-delhi', '2cbc7a4fb98f34b0b8dddd741e8cf88834b8f2ab54dd46eb6b0c222634754e2a', 200, 'Service Details — Viral Ads Media', 'Explore Viral Ads Media services across social media, SEO, websites, paid ads, branding, influencer campaigns and brand shoots for business growth in Delhi NCR.', 'SERVICE SPECIFICATION NOT FOUND', 'Clients we work with | Tools we use | Client Portfolio Showcase | Frequently Asked Questions | Other Core Services', 118, 0, 0, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/viraladsmedia.comservices.html\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 438, 86, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\"],\"text\":\"Service Details \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 Error SERVICE SPECIFICATION NOT FOUND Return to Services Hub \\u2192 [ VAM SERVICE SOLUTION ] Clients we work with Tools we use [ Client Spotlight ] Client Portfolio Showcase Explore interactive hero imagery and project executions tailored for this service. [ Got Questions? ] Frequently Asked Questions Everything you need to know about our workflow, deliverables, and service execution. [ Explore More ] Other Core Services Services Hub \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2\"}', '2026-09-10 04:47:17'),
(40, 1, 4, 'https://viraladsmedia.com/service.html?best-performance-marketing-in-delhi', 'ff1b689593ef1c2603c1eb160a841a8c4fecaaa61520bd22730b3e3fc2a4bfcf', 200, 'Service Details — Viral Ads Media', 'Explore Viral Ads Media services across social media, SEO, websites, paid ads, branding, influencer campaigns and brand shoots for business growth in Delhi NCR.', 'SERVICE SPECIFICATION NOT FOUND', 'Clients we work with | Tools we use | Client Portfolio Showcase | Frequently Asked Questions | Other Core Services', 118, 0, 0, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/viraladsmedia.comservices.html\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 437, 86, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\"],\"text\":\"Service Details \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 Error SERVICE SPECIFICATION NOT FOUND Return to Services Hub \\u2192 [ VAM SERVICE SOLUTION ] Clients we work with Tools we use [ Client Spotlight ] Client Portfolio Showcase Explore interactive hero imagery and project executions tailored for this service. [ Got Questions? ] Frequently Asked Questions Everything you need to know about our workflow, deliverables, and service execution. [ Explore More ] Other Core Services Services Hub \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2\"}', '2026-09-10 04:47:20'),
(41, 1, 4, 'https://viraladsmedia.com/service.html?affordable-logo-and-branding-near-me', '51789239190ec419b0a34a9eaa2513eca586526ea6c91d4ceaff81d4770bd438', 200, 'Service Details — Viral Ads Media', 'Explore Viral Ads Media services across social media, SEO, websites, paid ads, branding, influencer campaigns and brand shoots for business growth in Delhi NCR.', 'SERVICE SPECIFICATION NOT FOUND', 'Clients we work with | Tools we use | Client Portfolio Showcase | Frequently Asked Questions | Other Core Services', 118, 0, 0, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/viraladsmedia.comservices.html\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 440, 86, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\"],\"text\":\"Service Details \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 Error SERVICE SPECIFICATION NOT FOUND Return to Services Hub \\u2192 [ VAM SERVICE SOLUTION ] Clients we work with Tools we use [ Client Spotlight ] Client Portfolio Showcase Explore interactive hero imagery and project executions tailored for this service. [ Got Questions? ] Frequently Asked Questions Everything you need to know about our workflow, deliverables, and service execution. [ Explore More ] Other Core Services Services Hub \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2\"}', '2026-09-10 04:48:27'),
(42, 1, 4, 'https://viraladsmedia.com/service.html?best-influencer-marketing-in-delhi', '79f2581b0295372b6e75f966ea8581dd40a1e729e0d8d7e42fe1bcc1a7ec6b42', 200, 'Service Details — Viral Ads Media', 'Explore Viral Ads Media services across social media, SEO, websites, paid ads, branding, influencer campaigns and brand shoots for business growth in Delhi NCR.', 'SERVICE SPECIFICATION NOT FOUND', 'Clients we work with | Tools we use | Client Portfolio Showcase | Frequently Asked Questions | Other Core Services', 118, 0, 0, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/viraladsmedia.comservices.html\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 425, 86, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\"],\"text\":\"Service Details \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 Error SERVICE SPECIFICATION NOT FOUND Return to Services Hub \\u2192 [ VAM SERVICE SOLUTION ] Clients we work with Tools we use [ Client Spotlight ] Client Portfolio Showcase Explore interactive hero imagery and project executions tailored for this service. [ Got Questions? ] Frequently Asked Questions Everything you need to know about our workflow, deliverables, and service execution. [ Explore More ] Other Core Services Services Hub \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2\"}', '2026-09-10 04:48:30'),
(43, 1, 4, 'https://viraladsmedia.com/service.html?proffessional-brand-shoots-in-delhi', '8b5b6f1545aceb34d7e7743cd76cb028e98da9202c3de9e2c23d3b7be2525129', 200, 'Service Details — Viral Ads Media', 'Explore Viral Ads Media services across social media, SEO, websites, paid ads, branding, influencer campaigns and brand shoots for business growth in Delhi NCR.', 'SERVICE SPECIFICATION NOT FOUND', 'Clients we work with | Tools we use | Client Portfolio Showcase | Frequently Asked Questions | Other Core Services', 118, 0, 0, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/viraladsmedia.comservices.html\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 435, 86, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\"],\"text\":\"Service Details \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 Error SERVICE SPECIFICATION NOT FOUND Return to Services Hub \\u2192 [ VAM SERVICE SOLUTION ] Clients we work with Tools we use [ Client Spotlight ] Client Portfolio Showcase Explore interactive hero imagery and project executions tailored for this service. [ Got Questions? ] Frequently Asked Questions Everything you need to know about our workflow, deliverables, and service execution. [ Explore More ] Other Core Services Services Hub \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2\"}', '2026-09-10 04:48:32'),
(44, 1, 4, 'https://viraladsmedia.com/portfolio.html', '289863c9d403d12415f6f2990fc891fab0b98d52e8771b5822f994f8a678af59', 200, 'Viral Ads Media — Our Services & Categories', 'Browse Viral Ads Media work across social media, SEO, websites, paid ads, branding, influencer marketing and creative campaigns.', 'छोटे Business को \n        बड़ा  Brand\n         बनाने का जुनून।', 'SERVICECATEGORIES', 170, 8, 0, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\",\"https:\\/\\/viraladsmedia.com\\/category-records.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/category-records.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/category-records.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/category-records.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/category-records.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR\",\"https:\\/\\/viraladsmedia.com\\/category-records.html?proffessional-video-editor-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/category-records.html?best-social-media-agency-in-delhi\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 439, 88, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/portfolio\\/web.png\",\"alt\":\"Website Designing\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/portfolio\\/performance.png\",\"alt\":\"Performance Marketing\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/portfolio\\/logo-branding.png\",\"alt\":\"Logo & Branding\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/portfolio\\/influencer.png\",\"alt\":\"Influencer Marketing\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/portfolio\\/seo.png\",\"alt\":\"SEO Management\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/portfolio\\/ad.png\",\"alt\":\"Ads Campaign\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/portfolio\\/graphic.png\",\"alt\":\"Graphics & Video Editing\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/portfolio\\/social.png\",\"alt\":\"Social Media Marketing\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":1,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/portfolio.html\"],\"text\":\"Viral Ads Media \\u2014 Our Services & Categories Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now \\u091b\\u094b\\u091f\\u0947 Business \\u0915\\u094b \\u092c\\u0921\\u093c\\u093e Brand \\u092c\\u0928\\u093e\\u0928\\u0947 \\u0915\\u093e \\u091c\\u0941\\u0928\\u0942\\u0928\\u0964 From concept to campaign, we help ambitious businesses like yours turn big dreams into iconic brands - with creativity, strategy, and impact that inspires. Explore All Categories Viral Ads Media \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2\\u009d Categories SERVICECATEGORIES 01 \\/ CATEGORY WEBSITE DESIGNING View Client Records \\u2192 02 \\/ CATEGORY Performance Marketing View Client Records \\u2192 03 \\/ CATEGORY LOGO & BRANDING View Client Records \\u2192 04 \\/ CATEGORY INFLUENCER MARKETING View Client Records \\u2192 05 \\/ CATEGORY SEO MANAGEMENT View Client Records \\u2192 06 \\/ CATEGORY ADS CAMPAIGN View Client Records \\u2192 07 \\/ CATEGORY GRAPHICS & VIDEO EDITING View Client Records \\u2192 08 \\/ CATEGORY SOCIAL MEDIA MARKETING View Client Records \\u2192 Scroll horizontally 7 Categories\"}', '2026-09-10 04:48:35'),
(45, 1, 4, 'https://viraladsmedia.com/industries.html', '4478f29c623936f4d40a126d58a6589773e7e6a4ccbb1bef813994d9fed4e361', 200, 'Industries We Serve — Viral Ads Media', 'See how Viral Ads Media supports brands across industries with social media, SEO, paid ads, websites and creative growth strategies.', 'हर इंडस्ट्री में \n        डिफ़रेंस Create \n        करने की क्षमता।', 'Select Industry Ecosystem', 127, 0, 0, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 461, 88, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":1,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/industries.html\"],\"text\":\"Industries We Serve \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now [ HIERARCHICAL DOMAINS ] \\u0939\\u0930 \\u0907\\u0902\\u0921\\u0938\\u094d\\u091f\\u094d\\u0930\\u0940 \\u092e\\u0947\\u0902 \\u0921\\u093f\\u092b\\u093c\\u0930\\u0947\\u0902\\u0938 Create \\u0915\\u0930\\u0928\\u0947 \\u0915\\u0940 \\u0915\\u094d\\u0937\\u092e\\u0924\\u093e\\u0964 Explore our dynamic industry matrix. Select any sector below to inspect deep vertical strategies, service deployments, and verified client records. Home \\/ Portfolio \\/ Industries Matrix [ SECTOR DIRECTORY ] Select Industry Ecosystem Dynamically links to tailored category records, case studies, and cross-platform growth services. Need a cross-sector custom strategy? Seamlessly pivot across multiple services and industry verticals with our expert architects. View All Services Let\'s Talk\"}', '2026-09-10 04:48:37'),
(46, 1, 4, 'https://viraladsmedia.com/industry-detail.html?affordable-e-commerce-website-development-services', '453837d6dbea222b66d15ab318022d14fd1ee35e5eb09db82b76b0119314ebda', 200, 'Industry Niche Records — Viral Ads Media', 'Discover industry-specific marketing solutions from Viral Ads Media for growth-focused brands in Delhi NCR and beyond.', 'INDUSTRY SECTOR NOT FOUND', 'EXCLUSIVE PORTFOLIO OF BRANDS | CASE STUDIES | EXPLORE OTHER INDUSTRIES', 104, 1, 1, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 447, 80, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\"],\"text\":\"Industry Niche Records \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 INDUSTRY SECTOR NOT FOUND Back to Industries Directory Niche Specialty \\u2190 All Industries \\u2192 Sector Impact & Performance [ Verified Ecosystem ] EXCLUSIVE PORTFOLIO OF BRANDS Verified client logos representing successful campaigns and digital executions in this sector. [ Proven Execution ] CASE STUDIES [ Directory Matrix ] EXPLORE OTHER INDUSTRIES All Industries \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2\"}', '2026-09-10 04:48:40');
INSERT INTO `pages` (`id`, `website_id`, `job_id`, `url`, `url_hash`, `http_status`, `title`, `description`, `h1`, `h2`, `word_count`, `image_count`, `missing_alt`, `internal_links`, `external_links`, `canonical`, `robots`, `schema_count`, `og_count`, `noindex`, `load_ms`, `score`, `details`, `created_at`) VALUES
(47, 1, 4, 'https://viraladsmedia.com/industry-detail.html?healthcare-marketing-services', 'adf31cea028938761c0169440bcb495e6371a3d70276718d4b7b16979e953065', 200, 'Industry Niche Records — Viral Ads Media', 'Discover industry-specific marketing solutions from Viral Ads Media for growth-focused brands in Delhi NCR and beyond.', 'INDUSTRY SECTOR NOT FOUND', 'EXCLUSIVE PORTFOLIO OF BRANDS | CASE STUDIES | EXPLORE OTHER INDUSTRIES', 104, 1, 1, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 416, 80, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\"],\"text\":\"Industry Niche Records \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 INDUSTRY SECTOR NOT FOUND Back to Industries Directory Niche Specialty \\u2190 All Industries \\u2192 Sector Impact & Performance [ Verified Ecosystem ] EXCLUSIVE PORTFOLIO OF BRANDS Verified client logos representing successful campaigns and digital executions in this sector. [ Proven Execution ] CASE STUDIES [ Directory Matrix ] EXPLORE OTHER INDUSTRIES All Industries \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2\"}', '2026-09-10 04:48:43'),
(48, 1, 4, 'https://viraladsmedia.com/industry-detail.html?manufacturing-marketing-services', '66a1b661356274aecf183b44438b875bc6cbb8870af646de6f35a2bff91bc620', 200, 'Industry Niche Records — Viral Ads Media', 'Discover industry-specific marketing solutions from Viral Ads Media for growth-focused brands in Delhi NCR and beyond.', 'INDUSTRY SECTOR NOT FOUND', 'EXCLUSIVE PORTFOLIO OF BRANDS | CASE STUDIES | EXPLORE OTHER INDUSTRIES', 104, 1, 1, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 403, 80, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\"],\"text\":\"Industry Niche Records \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 INDUSTRY SECTOR NOT FOUND Back to Industries Directory Niche Specialty \\u2190 All Industries \\u2192 Sector Impact & Performance [ Verified Ecosystem ] EXCLUSIVE PORTFOLIO OF BRANDS Verified client logos representing successful campaigns and digital executions in this sector. [ Proven Execution ] CASE STUDIES [ Directory Matrix ] EXPLORE OTHER INDUSTRIES All Industries \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2\"}', '2026-09-10 04:48:47'),
(49, 1, 4, 'https://viraladsmedia.com/industry-detail.html?real-estate-marketing-services', 'fa02740cc2e57d3b3ef45e7b84e8da254399be0d153534b2d2e229956cea030f', 200, 'Industry Niche Records — Viral Ads Media', 'Discover industry-specific marketing solutions from Viral Ads Media for growth-focused brands in Delhi NCR and beyond.', 'INDUSTRY SECTOR NOT FOUND', 'EXCLUSIVE PORTFOLIO OF BRANDS | CASE STUDIES | EXPLORE OTHER INDUSTRIES', 104, 1, 1, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 442, 80, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\"],\"text\":\"Industry Niche Records \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 INDUSTRY SECTOR NOT FOUND Back to Industries Directory Niche Specialty \\u2190 All Industries \\u2192 Sector Impact & Performance [ Verified Ecosystem ] EXCLUSIVE PORTFOLIO OF BRANDS Verified client logos representing successful campaigns and digital executions in this sector. [ Proven Execution ] CASE STUDIES [ Directory Matrix ] EXPLORE OTHER INDUSTRIES All Industries \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2\"}', '2026-09-10 04:48:49'),
(50, 1, 4, 'https://viraladsmedia.com/industry-detail.html?education-marketing-services', 'e2f42fc8ac1d2e3a50b78068e75176e490a327111553d90e9b64697203b54b12', 200, 'Industry Niche Records — Viral Ads Media', 'Discover industry-specific marketing solutions from Viral Ads Media for growth-focused brands in Delhi NCR and beyond.', 'INDUSTRY SECTOR NOT FOUND', 'EXCLUSIVE PORTFOLIO OF BRANDS | CASE STUDIES | EXPLORE OTHER INDUSTRIES', 104, 1, 1, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 448, 80, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\"],\"text\":\"Industry Niche Records \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 INDUSTRY SECTOR NOT FOUND Back to Industries Directory Niche Specialty \\u2190 All Industries \\u2192 Sector Impact & Performance [ Verified Ecosystem ] EXCLUSIVE PORTFOLIO OF BRANDS Verified client logos representing successful campaigns and digital executions in this sector. [ Proven Execution ] CASE STUDIES [ Directory Matrix ] EXPLORE OTHER INDUSTRIES All Industries \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2\"}', '2026-09-10 04:48:52'),
(51, 1, 4, 'https://viraladsmedia.com/industry-detail.html?fashion-marketing-services', '1c5854e2fb39e602539813f7f6e1d9ff145c7a7572dc9fc8bae838db23063f59', 200, 'Industry Niche Records — Viral Ads Media', 'Discover industry-specific marketing solutions from Viral Ads Media for growth-focused brands in Delhi NCR and beyond.', 'INDUSTRY SECTOR NOT FOUND', 'EXCLUSIVE PORTFOLIO OF BRANDS | CASE STUDIES | EXPLORE OTHER INDUSTRIES', 104, 1, 1, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 467, 80, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\"],\"text\":\"Industry Niche Records \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 INDUSTRY SECTOR NOT FOUND Back to Industries Directory Niche Specialty \\u2190 All Industries \\u2192 Sector Impact & Performance [ Verified Ecosystem ] EXCLUSIVE PORTFOLIO OF BRANDS Verified client logos representing successful campaigns and digital executions in this sector. [ Proven Execution ] CASE STUDIES [ Directory Matrix ] EXPLORE OTHER INDUSTRIES All Industries \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2\"}', '2026-09-10 04:48:54'),
(52, 1, 4, 'https://viraladsmedia.com/industry-detail.html?travel-marketing-services', '6c3473610a61d1105caa45574fe6726bf27ef6086c677a51805840539978f217', 200, 'Industry Niche Records — Viral Ads Media', 'Discover industry-specific marketing solutions from Viral Ads Media for growth-focused brands in Delhi NCR and beyond.', 'INDUSTRY SECTOR NOT FOUND', 'EXCLUSIVE PORTFOLIO OF BRANDS | CASE STUDIES | EXPLORE OTHER INDUSTRIES', 104, 1, 1, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 459, 80, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\"],\"text\":\"Industry Niche Records \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 INDUSTRY SECTOR NOT FOUND Back to Industries Directory Niche Specialty \\u2190 All Industries \\u2192 Sector Impact & Performance [ Verified Ecosystem ] EXCLUSIVE PORTFOLIO OF BRANDS Verified client logos representing successful campaigns and digital executions in this sector. [ Proven Execution ] CASE STUDIES [ Directory Matrix ] EXPLORE OTHER INDUSTRIES All Industries \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2\"}', '2026-09-10 04:58:45'),
(53, 1, 4, 'https://viraladsmedia.com/industry-detail.html?appliances-marketing-service', '3eed6b07e017cf3bc58e7d831382e01e3aba3ad3761dbb3be71bd6c5b2caff57', 200, 'Industry Niche Records — Viral Ads Media', 'Discover industry-specific marketing solutions from Viral Ads Media for growth-focused brands in Delhi NCR and beyond.', 'INDUSTRY SECTOR NOT FOUND', 'EXCLUSIVE PORTFOLIO OF BRANDS | CASE STUDIES | EXPLORE OTHER INDUSTRIES', 104, 1, 1, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 453, 80, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\"],\"text\":\"Industry Niche Records \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 INDUSTRY SECTOR NOT FOUND Back to Industries Directory Niche Specialty \\u2190 All Industries \\u2192 Sector Impact & Performance [ Verified Ecosystem ] EXCLUSIVE PORTFOLIO OF BRANDS Verified client logos representing successful campaigns and digital executions in this sector. [ Proven Execution ] CASE STUDIES [ Directory Matrix ] EXPLORE OTHER INDUSTRIES All Industries \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2\"}', '2026-09-10 04:58:48'),
(54, 1, 4, 'https://viraladsmedia.com/industry-detail.html?cosmetics-marketing-service', '216491e41491bf55f2f96e41cf5e79536c4807be274b6796802ea788282d5219', 200, 'Industry Niche Records — Viral Ads Media', 'Discover industry-specific marketing solutions from Viral Ads Media for growth-focused brands in Delhi NCR and beyond.', 'INDUSTRY SECTOR NOT FOUND', 'EXCLUSIVE PORTFOLIO OF BRANDS | CASE STUDIES | EXPLORE OTHER INDUSTRIES', 104, 1, 1, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 447, 80, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\"],\"text\":\"Industry Niche Records \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 INDUSTRY SECTOR NOT FOUND Back to Industries Directory Niche Specialty \\u2190 All Industries \\u2192 Sector Impact & Performance [ Verified Ecosystem ] EXCLUSIVE PORTFOLIO OF BRANDS Verified client logos representing successful campaigns and digital executions in this sector. [ Proven Execution ] CASE STUDIES [ Directory Matrix ] EXPLORE OTHER INDUSTRIES All Industries \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2 \\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00e2\\u201e\\u00a2\"}', '2026-09-10 05:30:40');
INSERT INTO `pages` (`id`, `website_id`, `job_id`, `url`, `url_hash`, `http_status`, `title`, `description`, `h1`, `h2`, `word_count`, `image_count`, `missing_alt`, `internal_links`, `external_links`, `canonical`, `robots`, `schema_count`, `og_count`, `noindex`, `load_ms`, `score`, `details`, `created_at`) VALUES
(55, 1, 4, 'https://viraladsmedia.com/about.html', '90bd450b4c322ca7cb9c2876960b3a7d6f17c764286fc4e1313ea0e64601113e', 200, 'Viral Ads Media | Responsive', 'Learn about Viral Ads Media, a creative digital marketing agency in Delhi NCR focused on growth strategy, content, branding, paid ads and performance-driven execution.', '', 'We’re the digital architects behind\n        bold, viral,\n        \n          memorable work\n        .\n        \n        \n          Pushing creative limits for brands that dare to stand out. | Where We Contribute | See more Projects', 271, 7, 5, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 447, 68, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Graphics\\/14.jpg\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Graphics\\/11.jpg\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Graphics\\/12.jpg\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Graphics\\/13.jpg\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/office.png\",\"alt\":\"Office Environment\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/about.html\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":0,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/about.html\"],\"text\":\"Viral Ads Media | Responsive Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u201a\\u00c2 \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u20ac\\u017e\\u00c2\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now SCROLL DOWN \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00a2 EXPERIENCE DEPTH \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00a2 SCROLL DOWN \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00a2 EXPERIENCE DEPTH \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00a2 Tiptop Frensz Forever Allied Taps Drapple Hoot Beauty JPI SS Light Ro\'s Backery Belmont Eltons Tiptop Frensz Forever Allied Taps Drapple Hoot Beauty JPI SS Light Ro\'s Backery Belmont Eltons We\\u2019re the digital architects behind bold, viral, memorable work . Pushing creative limits for brands that dare to stand out. We deliberately take no shortcuts in our work. Every client goes through the same process - brand workshop, competitive research, moodboard, identity system - because skipping steps is how you end up with a logo instead of a brand. The answer is built around three things: the soul of the founder, the truth of the market, and the trust of the people we\'re all trying to reach. When those three align, a brand stops being visual and starts being visceral. View Services View Portfolio Where We Contribute Brand Strategy & Identity 01 Web Design & Development 02 UX\\/UI Product Design 03 Motion & Content Design 04 Let\'s Connect \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00a2 Let\'s Connect \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00a2 Let\'s Connect \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00a2 Let\'s Connect Let\'s Connect \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00a2 Let\'s Connect \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00a2 Let\'s Connect \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00a2 Let\'s Connect Let\'s Connect \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00a2 Let\'s Connect \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00a2 Let\'s Connect \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00a2 Let\'s Connect Let\'s Connect \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00a2 Let\'s Connect \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00a2 Let\'s Connect \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00a2 Let\'s Connect See more Projects BACK TO TOP \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u201a\\u00c2 \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u2039\\u00c5\\u201c Nolana VIEW Acquisition AI VIEW\"}', '2026-09-10 05:30:43'),
(56, 1, 4, 'https://viraladsmedia.com/blogs.html', '560736fb3eb6273a35b88a0cfd91010b1be85ab549445fdb25c705c0d4b3f2d6', 200, 'The Journal — Viral Ads Media', 'Read insights from Viral Ads Media on social media marketing, SEO, paid ads, website strategy, branding and business growth.', 'सोच आपकी...  Impact हमारा!', 'DON\'T MISS THE NEXT ONE', 117, 0, 0, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 469, 88, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":1,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/blogs.html\"],\"text\":\"The Journal \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u2020\\u00e2\\u20ac\\u2122\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2 \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00be\\u00c3\\u201a\\u00c2\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now Viral Ads Media - Insights \\u0938\\u094b\\u091a \\u0906\\u092a\\u0915\\u0940... Impact \\u0939\\u092e\\u093e\\u0930\\u093e! Notes on production, strategy, and the campaigns that actually moved people - written by the people who made them. Featured NO ARTICLES FOUND Try a different search term or category. Reset filters Load More Articles DON\'T MISS THE NEXT ONE One email a month. No recap of every social trend \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u2020\\u00e2\\u20ac\\u2122\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u2026\\u00c2\\u00a1\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u009d just what we learned making the work. Subscribe Subscribed -\"}', '2026-09-10 05:30:46'),
(57, 1, 4, 'https://viraladsmedia.com/career.html', '86e3e1ef116a8b302d055822ece393b7346b5bfba636f9652dd6ee617d6cb1dc', 200, 'Careers | Viral Ads Media - Digital Creative Agency', 'Join Viral Ads Media and build campaigns across social media, SEO, paid ads, content, branding and digital growth.', 'जहाँ सोच बनती है\n         Strategy, \n        और\n        Strategy बनती\n          है Success.', 'Advertising with the \n          वायरल\n            की शक्ति। | Open पोज़िशन्स | Apply For Any रोल | Agency हेडक्वार्टर्स', 478, 0, 0, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 433, 94, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":1,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/career.html\"],\"text\":\"Careers | Viral Ads Media - Digital Creative Agency Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u201a\\u00c2 \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u20ac\\u017e\\u00c2\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now JOIN OUR CREATIVE FORCE \\u091c\\u0939\\u093e\\u0901 \\u0938\\u094b\\u091a \\u092c\\u0928\\u0924\\u0940 \\u0939\\u0948 Strategy, \\u0914\\u0930 Strategy \\u092c\\u0928\\u0924\\u0940 \\u0939\\u0948 Success. We\'re looking for fearless creators, master engineers, and performance-driven minds ready to push boundaries at Viral Ads Media. Explore Open Roles Direct Application Form [01] Our Core Philosophy Advertising with the \\u0935\\u093e\\u092f\\u0930\\u0932 \\u0915\\u0940 \\u0936\\u0915\\u094d\\u0924\\u093f\\u0964 At Viral Ads Media, we don\'t just run standard campaigns - we engineer digital architecture, high-end commercial concepts, and organic momentum that captures consumer attention on a massive scale. Scale-Driven Execution Transforming brand presence into high-volume leads. AI & Tech Integrated Leveraging cutting-edge automation and analytics systems. [02] Current Open Positions Open \\u092a\\u094b\\u091c\\u093c\\u093f\\u0936\\u0928\\u094d\\u0938 Select any role below to instantly apply or submit via our universal lead form. Full-Time Delhi \\/ Hybrid Graphic Designer Create stunning branding visuals, social media creatives, high-end pitch decks, and advertising assets that grab instant attention. Apply For This Role Internship Delhi \\/ Stipend Video Editor Intern Edit high-retention short-form reels, TikToks, YouTube shorts, and commercial video edits using Premiere Pro and After Effects. Apply For This Role Internship Delhi \\/ Stipend Digital Marketing Intern Assist in managing Meta & Google ad campaigns, SEO keyword audits, social media tracking reports, and organic growth strategies. Apply For This Role Full-Time Delhi \\/ Hybrid Senior Frontend Developer Lead high-performance web experiences using modern Tailwind CSS, GSAP animations, and interactive component architectures. Apply For This Role Full-Time Delhi \\/ Remote Performance Marketing Specialist Scale high-budget Google and Meta ads campaigns, audit funnel metrics, and optimize conversions for scaling e-commerce brands. Apply For This Role Full-Time \\/ Contract Delhi Video Editor & Motion Designer Craft high-conversion promotional video reels, brand commercials, and dynamic motion graphic assets for viral campaigns. Apply For This Role [03] Direct Submissions Apply For Any \\u0930\\u094b\\u0932 Fill out the form below, select your desired position from the dropdown menu, and attach your portfolio. Full Name * Email Address * Phone Number * Select Position \\/ Role * -- Choose Desired Position -- Graphic Designer Video Editor Intern Digital Marketing Intern Senior Frontend Developer Performance Marketing Specialist Video Editor & Motion Designer General Open Application Portfolio \\/ GitHub \\/ LinkedIn URL * Cover Note \\/ Why Viral Ads Media? * Submit Application [04] Reach Out Agency \\u0939\\u0947\\u0921\\u0915\\u094d\\u0935\\u093e\\u0930\\u094d\\u091f\\u0930\\u094d\\u0938 Have specific inquiries regarding career paths or partnerships? Contact our team directly. WhatsApp Support +91 93544 91934 Email Inquiries info@viraladsmedia.com Headquarters B-33, Khatu Shyam Mandir Road, near Max Bazar, Budh Vihar Phase I, Delhi, 110086 Application Portal Apply for Role Full Name * Email Address * Phone Number * Portfolio \\/ LinkedIn URL Cover Note \\/ Why You? Submit Application\"}', '2026-09-10 05:30:49'),
(58, 1, 4, 'https://viraladsmedia.com/contact.html', '9a49237a36cb65c096eb2bd78318d96efd480b010114f6b3a4b0691e79bf8043', 200, 'Contact Us | Digital Marketing Agency', 'Contact our digital marketing agency for social media marketing, SEO, ads, website design and lead generation services.', 'हर \n            Brand\n            के पीछे एक story\n            होती है... \n            \n            हम उसे।\n            duniya\n            तक पहुँचाते हैं।', 'Share your  \n            प्रोजेक्ट\n            details. | We’re available \n            ऑनलाइन \n            and in-person. | Before you \n            कॉन्टैक्ट \n            us.', 367, 0, 0, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 481, 94, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":1,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/contact.html\"],\"text\":\"Contact Us | Digital Marketing Agency Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All Services \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u201a\\u00c2 \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u20ac\\u017e\\u00c2\\u00a2 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now Contact our growth team \\u0939\\u0930 Brand \\u0915\\u0947 \\u092a\\u0940\\u091b\\u0947 \\u090f\\u0915 story \\u0939\\u094b\\u0924\\u0940 \\u0939\\u0948... \\u0939\\u092e \\u0909\\u0938\\u0947\\u0964 duniya \\u0924\\u0915 \\u092a\\u0939\\u0941\\u0901\\u091a\\u093e\\u0924\\u0947 \\u0939\\u0948\\u0902\\u0964 Tell us your goals, challenges and project requirements. We\'ll help you choose the right strategy for ads, SEO, social media, website design and lead generation. Send Enquiry \\u2192 Call Now Email info@viraladsmedia.com Phone +91 93544 91934 Location B-33, Khatu shyam Mandir Road, near Max Bazar, Budh Vihar Phase I, Delhi, 110086 Hours Mon-Sat, 10 AM-7 PM Meta Ads\\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2\\u009d\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u008fSEO\\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2\\u009d\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u008fWebsite Design\\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2\\u009d\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u008fSocial Media\\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2\\u009d\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u008fLead Generation\\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2\\u009d\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u008f Meta Ads\\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2\\u009d\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u008fSEO\\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2\\u009d\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u008fWebsite Design\\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2\\u009d\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u008fSocial Media\\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2\\u009d\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u008fLead Generation\\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c2\\u009d\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u008f Start a conversation Share your \\u092a\\u094d\\u0930\\u094b\\u091c\\u0947\\u0915\\u094d\\u091f details. Fill out the form and our team will get back to you with the right next step. You can also contact us directly through phone, email or WhatsApp. WhatsApp Chat with our team \\u2192 Email info@viraladsmedia.com \\u2192 Full Name * Phone Number * Email Address Company \\/ Brand Service Required * Select service Social Media Marketing Meta Ads \\/ Google Ads SEO & Content Website Design Lead Generation Complete Digital Marketing Budget Range Select budget Below \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u2026\\u00c2\\u00a1\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00b925,000 \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u2026\\u00c2\\u00a1\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00b925,000 \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u2026\\u00e2\\u20ac\\u0153 \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u2026\\u00c2\\u00a1\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00b950,000 \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u2026\\u00c2\\u00a1\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00b950,000 \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u201a\\u00ac\\u00c5\\u00a1\\u00c3\\u201a\\u00c2\\u00ac\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u2026\\u00e2\\u20ac\\u0153 \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u2026\\u00c2\\u00a1\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00b91,00,000 \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u2026\\u00c2\\u00a1\\u00c3\\u0192\\u00e2\\u20ac\\u0161\\u00c3\\u201a\\u00c2\\u00b91,00,000+ Message * Submit Enquiry \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u201a\\u00c2 \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u20ac\\u017e\\u00c2\\u00a2 Location Map B-33, Khatu shyam Mandir Road, near Max Bazar, Budh Vihar Phase I, Delhi, 110086 Replace this area with your Google Map embed code. Visit \\/ Connect We\\u2019re available \\u0911\\u0928\\u0932\\u093e\\u0907\\u0928 and in-person. Book a consultation call or send your brief. We\'ll understand your business and suggest the best digital growth plan. Office B-33, Khatu shyam Mandir Road, near Max Bazar, Budh Vihar Phase I, Delhi, 110086 Response Time Within 24 hours FAQs Before you \\u0915\\u0949\\u0928\\u094d\\u091f\\u0948\\u0915\\u094d\\u091f us. How soon will you reply? + Usually within 24 hours on working days. For urgent projects, WhatsApp is the fastest option. Can you handle complete digital marketing? + Yes. We can manage social media, ads, SEO, creative design, landing pages, reporting and strategy. Do you work on monthly retainers? + Yes. We offer monthly retainers, one-time campaigns, website projects and growth sprints.\"}', '2026-09-10 05:30:52'),
(59, 1, 4, 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'bc0fa68ee99d9f494a2dde26740d59fe77df1921f12a7a64c052aa305a522c4d', 200, 'Service Category Records — Viral Ads Media', 'Explore Viral Ads Media service categories and creative marketing capabilities built for growth-focused brands.', 'CATEGORY NOT FOUND', 'BRANDS WE SERVED IN THIS CATEGORY | FEATURED CASE STUDIES | OUR OTHER SERVICES', 99, 1, 1, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 447, 80, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/category-records.html?affordable-web-developer-in-delhi\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/category-records.html?affordable-web-developer-in-delhi\"],\"text\":\"Service Category Records \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All \\u2192 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 CATEGORY NOT FOUND Back to all categories Service Specialty Milestones & Track Record [ Verified Deployments ] BRANDS WE SERVED IN THIS CATEGORY Companies and enterprise partners who successfully scaled using this specific solution. [ Proven Execution ] FEATURED CASE STUDIES [ Explore More ] OUR OTHER SERVICES View All \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u201a\\u00c2 \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u20ac\\u017e\\u00c2\\u00a2\"}', '2026-09-10 05:30:55'),
(60, 1, 4, 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', '048d254c0d3a16f911f68999c6cacc7308a95e3faa76108a72696da36fc0bb34', 200, 'Service Category Records — Viral Ads Media', 'Explore Viral Ads Media service categories and creative marketing capabilities built for growth-focused brands.', 'CATEGORY NOT FOUND', 'BRANDS WE SERVED IN THIS CATEGORY | FEATURED CASE STUDIES | OUR OTHER SERVICES', 99, 1, 1, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 490, 80, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/category-records.html?best-performance-marketing-in-delhi\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/category-records.html?best-performance-marketing-in-delhi\"],\"text\":\"Service Category Records \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All \\u2192 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 CATEGORY NOT FOUND Back to all categories Service Specialty Milestones & Track Record [ Verified Deployments ] BRANDS WE SERVED IN THIS CATEGORY Companies and enterprise partners who successfully scaled using this specific solution. [ Proven Execution ] FEATURED CASE STUDIES [ Explore More ] OUR OTHER SERVICES View All \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u201a\\u00c2 \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u20ac\\u017e\\u00c2\\u00a2\"}', '2026-09-10 05:35:36');
INSERT INTO `pages` (`id`, `website_id`, `job_id`, `url`, `url_hash`, `http_status`, `title`, `description`, `h1`, `h2`, `word_count`, `image_count`, `missing_alt`, `internal_links`, `external_links`, `canonical`, `robots`, `schema_count`, `og_count`, `noindex`, `load_ms`, `score`, `details`, `created_at`) VALUES
(61, 1, 4, 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'cdbfbf6ad68b7a63622bc4c3a520812422f235d6cd09cfb1250a0f0e1cd87b82', 200, 'Service Category Records — Viral Ads Media', 'Explore Viral Ads Media service categories and creative marketing capabilities built for growth-focused brands.', 'CATEGORY NOT FOUND', 'BRANDS WE SERVED IN THIS CATEGORY | FEATURED CASE STUDIES | OUR OTHER SERVICES', 99, 1, 1, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 421, 80, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/category-records.html?affordable-logo-and-branding-near-me\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/category-records.html?affordable-logo-and-branding-near-me\"],\"text\":\"Service Category Records \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All \\u2192 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 CATEGORY NOT FOUND Back to all categories Service Specialty Milestones & Track Record [ Verified Deployments ] BRANDS WE SERVED IN THIS CATEGORY Companies and enterprise partners who successfully scaled using this specific solution. [ Proven Execution ] FEATURED CASE STUDIES [ Explore More ] OUR OTHER SERVICES View All \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u201a\\u00c2 \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u20ac\\u017e\\u00c2\\u00a2\"}', '2026-09-10 05:35:40'),
(62, 1, 4, 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'ccbb29ac10d09b0add354901a7eac5e5d936bb545da0b09e55fe66439e5c4fda', 200, 'Service Category Records — Viral Ads Media', 'Explore Viral Ads Media service categories and creative marketing capabilities built for growth-focused brands.', 'CATEGORY NOT FOUND', 'BRANDS WE SERVED IN THIS CATEGORY | FEATURED CASE STUDIES | OUR OTHER SERVICES', 99, 1, 1, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 492, 80, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/category-records.html?best-influencer-marketing-in-delhi\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/category-records.html?best-influencer-marketing-in-delhi\"],\"text\":\"Service Category Records \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All \\u2192 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 CATEGORY NOT FOUND Back to all categories Service Specialty Milestones & Track Record [ Verified Deployments ] BRANDS WE SERVED IN THIS CATEGORY Companies and enterprise partners who successfully scaled using this specific solution. [ Proven Execution ] FEATURED CASE STUDIES [ Explore More ] OUR OTHER SERVICES View All \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u201a\\u00c2 \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u20ac\\u017e\\u00c2\\u00a2\"}', '2026-09-10 05:35:43'),
(63, 1, 4, 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'd6e234854c463ad4e9297073848e16182b0239016ca497164bbd2ba6f343e5f4', 200, 'Service Category Records — Viral Ads Media', 'Explore Viral Ads Media service categories and creative marketing capabilities built for growth-focused brands.', 'CATEGORY NOT FOUND', 'BRANDS WE SERVED IN THIS CATEGORY | FEATURED CASE STUDIES | OUR OTHER SERVICES', 99, 1, 1, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 439, 80, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/category-records.html?best-seo-agency-near-me\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/category-records.html?best-seo-agency-near-me\"],\"text\":\"Service Category Records \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All \\u2192 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 CATEGORY NOT FOUND Back to all categories Service Specialty Milestones & Track Record [ Verified Deployments ] BRANDS WE SERVED IN THIS CATEGORY Companies and enterprise partners who successfully scaled using this specific solution. [ Proven Execution ] FEATURED CASE STUDIES [ Explore More ] OUR OTHER SERVICES View All \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u201a\\u00c2 \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u20ac\\u017e\\u00c2\\u00a2\"}', '2026-09-10 05:35:44'),
(64, 1, 4, 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'd57e91fa2d5eacab046900a30c14391b036aa955fb1847f5faa99ee22b22184b', 200, 'Service Category Records — Viral Ads Media', 'Explore Viral Ads Media service categories and creative marketing capabilities built for growth-focused brands.', 'CATEGORY NOT FOUND', 'BRANDS WE SERVED IN THIS CATEGORY | FEATURED CASE STUDIES | OUR OTHER SERVICES', 99, 1, 1, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 453, 80, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR\"],\"text\":\"Service Category Records \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All \\u2192 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 CATEGORY NOT FOUND Back to all categories Service Specialty Milestones & Track Record [ Verified Deployments ] BRANDS WE SERVED IN THIS CATEGORY Companies and enterprise partners who successfully scaled using this specific solution. [ Proven Execution ] FEATURED CASE STUDIES [ Explore More ] OUR OTHER SERVICES View All \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u201a\\u00c2 \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u20ac\\u017e\\u00c2\\u00a2\"}', '2026-09-10 05:35:47'),
(65, 1, 4, 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', '3bbdf7d965bbd20e31608275cd6e26cfb9be72dbf6b23f38a67d07c5098de03d', 200, 'Service Category Records — Viral Ads Media', 'Explore Viral Ads Media service categories and creative marketing capabilities built for growth-focused brands.', 'CATEGORY NOT FOUND', 'BRANDS WE SERVED IN THIS CATEGORY | FEATURED CASE STUDIES | OUR OTHER SERVICES', 99, 1, 1, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 412, 80, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/category-records.html?proffessional-video-editor-in-delhi\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/category-records.html?proffessional-video-editor-in-delhi\"],\"text\":\"Service Category Records \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All \\u2192 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 CATEGORY NOT FOUND Back to all categories Service Specialty Milestones & Track Record [ Verified Deployments ] BRANDS WE SERVED IN THIS CATEGORY Companies and enterprise partners who successfully scaled using this specific solution. [ Proven Execution ] FEATURED CASE STUDIES [ Explore More ] OUR OTHER SERVICES View All \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u201a\\u00c2 \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u20ac\\u017e\\u00c2\\u00a2\"}', '2026-09-10 05:35:50'),
(66, 1, 4, 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', '0dea33dbae412c397a198d9f2cf8ef4854f2cd6a7f54771301fe43dc44b052cf', 200, 'Service Category Records — Viral Ads Media', 'Explore Viral Ads Media service categories and creative marketing capabilities built for growth-focused brands.', 'CATEGORY NOT FOUND', 'BRANDS WE SERVED IN THIS CATEGORY | FEATURED CASE STUDIES | OUR OTHER SERVICES', 99, 1, 1, '[\"https:\\/\\/viraladsmedia.com\\/index.html\",\"https:\\/\\/viraladsmedia.com\\/services.html\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-social-media-agency-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-seo-agency-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-web-developer-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-performance-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?affordable-logo-and-branding-near-me\",\"https:\\/\\/viraladsmedia.com\\/service.html?best-influencer-marketing-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/service.html?proffessional-brand-shoots-in-delhi\",\"https:\\/\\/viraladsmedia.com\\/portfolio.html\",\"https:\\/\\/viraladsmedia.com\\/industries.html\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?affordable-e-commerce-website-development-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?healthcare-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?manufacturing-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?real-estate-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?education-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?fashion-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?travel-marketing-services\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?appliances-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/industry-detail.html?cosmetics-marketing-service\",\"https:\\/\\/viraladsmedia.com\\/about.html\",\"https:\\/\\/viraladsmedia.com\\/blogs.html\",\"https:\\/\\/viraladsmedia.com\\/career.html\",\"https:\\/\\/viraladsmedia.com\\/contact.html\"]', '[\"https:\\/\\/razorpay.me\\/@viraladsmedia9256\",\"https:\\/\\/wa.me\\/919354491934\",\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.instagram.com\\/theviraladsmedia\\/\",\"https:\\/\\/www.behance.net\\/viraladsmedia\\/\",\"https:\\/\\/www.linkedin.com\\/in\\/viral-ads-media-34ba19280\\/\",\"https:\\/\\/www.youtube.com\\/@ViralAdsMedia\\/\",\"https:\\/\\/x.com\\/viraladsmedia\\/\",\"https:\\/\\/www.dmca.com\\/r\\/prddr50\"]', '', '', 0, 0, 0, 451, 80, '{\"images\":[{\"url\":\"https:\\/\\/viraladsmedia.com\\/category-records.html?best-social-media-agency-in-delhi\",\"alt\":\"\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/36.png\",\"alt\":\"Google Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/37.png\",\"alt\":\"Facebook Marketing Partner\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/38.png\",\"alt\":\"ISO Certification\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/39.png\",\"alt\":\"Sponsor 1\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/40.png\",\"alt\":\"Certification 5\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/41.png\",\"alt\":\"Sponsor 2\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/42.png\",\"alt\":\"Certification 6\"},{\"url\":\"https:\\/\\/viraladsmedia.com\\/Assets\\/Certification\\/43.png\",\"alt\":\"DMCA Protected\"}],\"hreflang_valid\":true,\"h1_count\":2,\"viewport\":\"width=device-width, initial-scale=1.0\",\"language\":\"en\",\"hreflang\":0,\"twitter\":0,\"mixed_content\":0,\"redirects\":[\"https:\\/\\/viraladsmedia.com\\/category-records.html?best-social-media-agency-in-delhi\"],\"text\":\"Service Category Records \\u2014 Viral Ads Media Home Services Social Media Marketing Search Engine Optimization Website Designing Performance Marketing View All \\u2192 Portfolio Industries E-Commerce Healthcare Manufacturing Real Estate Education Fashion Travel Appliances Cosmetics View All Industries Matrix \\u2192 Company Blogs Career Let\'s Talk Pay Now 404 CATEGORY NOT FOUND Back to all categories Service Specialty Milestones & Track Record [ Verified Deployments ] BRANDS WE SERVED IN THIS CATEGORY Companies and enterprise partners who successfully scaled using this specific solution. [ Proven Execution ] FEATURED CASE STUDIES [ Explore More ] OUR OTHER SERVICES View All \\u00c3\\u0192\\u00c6\\u2019\\u00c3\\u201a\\u00c2\\u00a2\\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u201a\\u00c2 \\u00c3\\u0192\\u00c2\\u00a2\\u00c3\\u00a2\\u00e2\\u20ac\\u0161\\u00c2\\u00ac\\u00c3\\u00a2\\u00e2\\u20ac\\u017e\\u00c2\\u00a2\"}', '2026-09-10 05:35:52');

-- --------------------------------------------------------

--
-- Table structure for table `page_recommendations`
--

CREATE TABLE `page_recommendations` (
  `id` int(10) UNSIGNED NOT NULL,
  `page_id` bigint(20) UNSIGNED NOT NULL,
  `website_id` int(10) UNSIGNED NOT NULL,
  `content` mediumtext NOT NULL,
  `source` varchar(20) NOT NULL DEFAULT 'manual',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `plan_id` int(10) UNSIGNED NOT NULL,
  `order_id` varchar(100) DEFAULT NULL,
  `provider_payment_id` varchar(100) DEFAULT NULL,
  `amount` int(10) UNSIGNED NOT NULL,
  `currency` char(3) DEFAULT 'INR',
  `status` enum('pending','paid','failed') DEFAULT 'pending',
  `coupon_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `paid_at` datetime DEFAULT NULL,
  `purpose` enum('subscription','service','ai_credits') NOT NULL DEFAULT 'subscription',
  `service_request_id` int(10) UNSIGNED DEFAULT NULL,
  `ai_credits` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`) VALUES
(4, 'billing.manage'),
(3, 'projects.assigned'),
(2, 'projects.manage'),
(1, 'system.manage');

-- --------------------------------------------------------

--
-- Table structure for table `plans`
--

CREATE TABLE `plans` (
  `id` int(10) UNSIGNED NOT NULL,
  `slug` varchar(40) NOT NULL,
  `name` varchar(80) NOT NULL,
  `price` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `websites` int(11) NOT NULL,
  `keywords` int(11) NOT NULL,
  `crawl_pages` int(11) NOT NULL,
  `reports` int(11) NOT NULL,
  `ai_requests` int(11) NOT NULL DEFAULT 0,
  `team_members` int(11) NOT NULL DEFAULT 0,
  `white_label` tinyint(4) NOT NULL DEFAULT 0,
  `active` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `plans`
--

INSERT INTO `plans` (`id`, `slug`, `name`, `price`, `websites`, `keywords`, `crawl_pages`, `reports`, `ai_requests`, `team_members`, `white_label`, `active`) VALUES
(1, 'free', 'Free', 0, 1, 50, 100, 1, 0, 0, 0, 1),
(2, 'starter', 'Starter', 199900, 3, 250, 1000, 10, 100, 0, 0, 1),
(3, 'growth', 'Growth', 599900, 10, 1000, 5000, -1, 500, 0, 0, 1),
(4, 'agency', 'Agency', 1499900, 50, 5000, 25000, -1, 2000, 20, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `plan_features`
--

CREATE TABLE `plan_features` (
  `id` int(10) UNSIGNED NOT NULL,
  `plan_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(80) NOT NULL,
  `value` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rate_limits`
--

CREATE TABLE `rate_limits` (
  `bucket` char(64) NOT NULL,
  `hits` int(10) UNSIGNED NOT NULL,
  `expires_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rate_limits`
--

INSERT INTO `rate_limits` (`bucket`, `hits`, `expires_at`) VALUES
('0d9c8cc07b5f1055b28046bd27378a6676a6e3de199571c9ad10c212fd23c70b', 1, '2026-09-14 15:43:54'),
('151de3a2b388ab9c0f5439537ba353a2264dc59c9448b1601a35ad57b3e4d570', 11, '2026-09-16 17:00:52'),
('1a1c8fa12ea370da6c387d27eec5f17d578b1a8facf23b96398617e912ccd399', 1, '2026-09-16 17:09:13'),
('28401d6af3b9ded2318658807eeced4c161d333ae473fe80f651fa1ac5e95991', 9, '2026-09-16 14:22:28'),
('2b728ea8a8b1d4ac3b7b44d0890a60c3f5c467289a48bfe888d0eb6b049e96cd', 2, '2026-09-09 17:54:58'),
('4feafa3b5a54ccd0ecd9211ee7f37de68ee41b814b27899abffb7d84892988e8', 4, '2026-09-16 17:00:36'),
('52c1e67d3330457b5c42328717fb1c2d7f312c096f778970626b62703c7ab21a', 1, '2026-09-09 18:07:35'),
('5cf1302cf5fd4e0b84841ab4de068cdf1dc931345745828f21f70ad37877b913', 8, '2026-09-16 16:58:49'),
('6965398ae3668f98bafe37d93131d887a8e7063239276a99573618b57308ac6a', 1, '2026-09-16 16:56:48'),
('71dbaaa350ca9b54e672d67e74bd7a4cfcc3fd413c369ef91084f20cb8cc98f7', 1, '2026-09-16 16:49:27'),
('8c01bd32caf28ecf1a5829e5e685b42c74494fca2d182c098c9b2113d2e8dcfe', 1, '2026-09-15 15:11:57'),
('92a499ee61423a9968463bae5d762fc1e10586d776d14dadba87244b76e0d423', 1, '2026-09-16 17:46:48'),
('963b84815ca6c5031aaf7a1abff344e212e9653591e46a58d5851134b4dd2a4a', 1, '2026-09-16 16:46:51'),
('a023002d1d787309daf646bfe1457d2702e93b8ba578fc9bb53fdf8875ec0eb4', 1, '2026-09-16 16:50:06'),
('ab3b977badb0b7ab52a9d95f98eccb59d87b09e7e15f77952f495a53e3a20f8c', 1, '2026-09-09 18:09:12'),
('b0804c317e79508b803ac37ef7502ca99c645ba8a65b94bf9a1aa54866d63ab5', 1, '2026-09-09 17:58:07'),
('b1e9c1ef0bef5eb07bc42f43b1ee5af8eb3f700fb71283854e693142a2b02de8', 5, '2026-09-16 16:50:03'),
('d1594e9befb48fcc8ab2e4e55c6ef865acdade16e251146450422e0ed73054b6', 1, '2026-09-16 17:09:13'),
('d9835cc1f3081ad857de5271209c49c2be04f84889072201fc50cd82b5df821b', 1, '2026-09-15 15:09:52'),
('dc2499e9bab21ef835c4b67dd0ad6979860d225857e0ba3735e251eab20ee4c4', 5, '2026-09-09 17:55:13'),
('e15b339237f1cff799c75a99e8e60e8205b71f75f8980ddf98a0e3370ee85725', 1, '2026-09-14 15:35:18'),
('eed9b700fbec572695c2319fb21255461cf9a212da8408acc460c15f5b8584b6', 1, '2026-09-09 18:23:47'),
('f51424d7f4d030d543800fef67754fc824e81854a43210ed3f9494a393a0dae7', 1, '2026-09-16 17:04:46'),
('f6e5ecfb188cdc3cee7fab6e3a2ce306c695d0d547df0a52164635ebd58d5416', 5, '2026-09-09 18:09:47'),
('f9304c8f9f9816fd288669943dd0777527852db18db0853982ccd805b98d5979', 1, '2026-09-09 17:57:05'),
('f943848e3b1ea0c4b34905c9efbf35e4e23afd2555902ff379bc652d83a5613b', 1, '2026-09-09 18:08:57');

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
  `id` int(10) UNSIGNED NOT NULL,
  `website_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(190) NOT NULL,
  `snapshot` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`snapshot`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reports`
--

INSERT INTO `reports` (`id`, `website_id`, `user_id`, `title`, `snapshot`, `created_at`) VALUES
(1, 1, 2, 'SEO report · 09 Sep 2026', '{\"website\":{\"id\":1,\"user_id\":2,\"name\":\"Viral Ads Media\",\"domain\":\"https:\\/\\/viraladsmedia.com\\/\",\"domain_hash\":\"dff16fa4c24f361b86ac5982ac7539c666f374a740e85072b6c57fc240651148\",\"country\":\"India\",\"language\":\"en\",\"search_engine\":\"google\",\"timezone\":\"Asia\\/Kolkata\",\"created_at\":\"2026-09-09 17:43:47\"},\"audit\":null,\"issues\":[],\"keywords\":[],\"backlinks\":[],\"competitors\":[],\"tasks\":[],\"branding\":[]}', '2026-09-09 12:14:49');

-- --------------------------------------------------------

--
-- Table structure for table `resource_checks`
--

CREATE TABLE `resource_checks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `job_id` int(10) UNSIGNED NOT NULL,
  `url` text NOT NULL,
  `url_hash` char(64) NOT NULL,
  `kind` enum('external','image') NOT NULL,
  `http_status` smallint(6) DEFAULT NULL,
  `content_type` varchar(190) DEFAULT NULL,
  `size_bytes` bigint(20) DEFAULT NULL,
  `error` text DEFAULT NULL,
  `checked_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `resource_checks`
--

INSERT INTO `resource_checks` (`id`, `job_id`, `url`, `url_hash`, `kind`, `http_status`, `content_type`, `size_bytes`, `error`, `checked_at`) VALUES
(1, 1, 'https://razorpay.me/@viraladsmedia9256', '355f62e83801a6a501932f460dda204b07f2a0e49701ea25f39fee1ebe72a7d8', 'external', 200, '', 0, NULL, '2026-09-09 17:52:31'),
(2, 1, 'https://wa.me/919354491934', '5428bbaadf2736fd7917420c1b7c646fb1bcf71f482d81779748ff353418fa01', 'external', NULL, NULL, NULL, 'Provider redirects are not permitted.', '2026-09-09 17:52:33'),
(3, 1, 'https://www.facebook.com/theviraladsmedia/', 'ff3a03b82dc6f5fad79900542b54878a7e3f3f05796a68b0914f73f2bea8fbaa', 'external', NULL, NULL, NULL, 'Resource check blocked by robots.txt or robots availability.', '2026-09-09 17:52:33'),
(4, 1, 'https://www.instagram.com/theviraladsmedia/', '985f964fdafbf5770cef4c1da0a71dc9fceca2b1b1f8acd310f97901a13829a5', 'external', NULL, NULL, NULL, 'Resource check blocked by robots.txt or robots availability.', '2026-09-09 17:52:34'),
(5, 1, 'https://www.behance.net/viraladsmedia/', '63644d346e6d72e8891f04911d8f98e0024d5ac28be84e14d3fd970fd23e1559', 'external', NULL, NULL, NULL, 'Network request failed: transfer closed with 496996 bytes remaining to read', '2026-09-09 17:52:36'),
(6, 1, 'https://www.linkedin.com/in/viral-ads-media-34ba19280/', 'b84b019cc9a66d1d8b16186fc19614aca3f48d7b3d5db6f65a2b4e594d01044c', 'external', NULL, NULL, NULL, 'Resource check blocked by robots.txt or robots availability.', '2026-09-09 17:52:37'),
(7, 1, 'https://www.youtube.com/@ViralAdsMedia/', '1932b2e11d3721fd8e61335d78e457f2a7097acb9f572c32a18afee2ac8d5e19', 'external', 200, 'text/html; charset=utf-8', 0, NULL, '2026-09-09 17:52:38'),
(8, 1, 'https://x.com/viraladsmedia/', '668d2626fdf27480413b5e14979d0fb2507ef65f9ade0c085f26c8b0aec4c17f', 'external', NULL, NULL, NULL, 'Resource check blocked by robots.txt or robots availability.', '2026-09-09 17:52:39'),
(9, 1, 'https://www.dmca.com/r/prddr50', 'b99f16506fa9ca2523562a85c66695cf3561d491b60a3e53dab9bd148e4ffd81', 'external', NULL, NULL, NULL, 'Network request failed: Operation timed out after 20007 milliseconds with 0 out of 243 bytes received', '2026-09-09 17:53:00'),
(10, 1, 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', '048d254c0d3a16f911f68999c6cacc7308a95e3faa76108a72696da36fc0bb34', 'image', NULL, NULL, NULL, NULL, NULL),
(11, 1, 'https://viraladsmedia.com/Assets/Certification/36.png', 'cdff5cb51ff2bb99c941a91b53a2b98efa457ad983fcf1f57a3c8f482a01af08', 'image', NULL, NULL, NULL, NULL, NULL),
(12, 1, 'https://viraladsmedia.com/Assets/Certification/37.png', 'e378396802a6be93a8b67ecc0837c972558c9996e72b0bd122d09ba4358c8a99', 'image', NULL, NULL, NULL, NULL, NULL),
(13, 1, 'https://viraladsmedia.com/Assets/Certification/38.png', '238037d884fcc0bf27bd99cd2ed5dc8f508d4487ce167692acb5722e709893e7', 'image', NULL, NULL, NULL, NULL, NULL),
(14, 1, 'https://viraladsmedia.com/Assets/Certification/39.png', '2eb4ceb2faeafc2cb261eb1ab02b3f0e6d4fb159318ca13168e935d0ae6f29c4', 'image', NULL, NULL, NULL, NULL, NULL),
(15, 1, 'https://viraladsmedia.com/Assets/Certification/40.png', '0c7e7a235c25539bd0edd8f7e38342ba9b309a6388715dbdc5623c6a3b8c12f9', 'image', NULL, NULL, NULL, NULL, NULL),
(16, 1, 'https://viraladsmedia.com/Assets/Certification/41.png', '9309c5ae7b36613e562d5aacb8c86d539046f23f7810440cca7a9a242445736e', 'image', NULL, NULL, NULL, NULL, NULL),
(17, 1, 'https://viraladsmedia.com/Assets/Certification/42.png', 'e1827e8646185badbe37f941e1d6c13d47e36fc9a026f747ac17ce9a108d88bd', 'image', NULL, NULL, NULL, NULL, NULL),
(18, 1, 'https://viraladsmedia.com/Assets/Certification/43.png', 'b94ef2eadec60c0150b22e0caeebb723d82211a8d8906b7c5ddf3c35ebd3f381', 'image', NULL, NULL, NULL, NULL, NULL),
(19, 1, 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', '0dea33dbae412c397a198d9f2cf8ef4854f2cd6a7f54771301fe43dc44b052cf', 'image', NULL, NULL, NULL, NULL, NULL),
(20, 1, 'https://viraladsmedia.com/industry-detail.html?fashion-marketing-services', '1c5854e2fb39e602539813f7f6e1d9ff145c7a7572dc9fc8bae838db23063f59', 'image', NULL, NULL, NULL, NULL, NULL),
(21, 1, 'https://viraladsmedia.com/industry-detail.html?cosmetics-marketing-service', '216491e41491bf55f2f96e41cf5e79536c4807be274b6796802ea788282d5219', 'image', NULL, NULL, NULL, NULL, NULL),
(22, 1, 'https://viraladsmedia.com/Assets/portfolio/web.png', '0d40035acabf562fb78ae909f3db9cbdb7b993daf97dc52a1d70ed549c4242ff', 'image', NULL, NULL, NULL, NULL, NULL),
(23, 1, 'https://viraladsmedia.com/Assets/portfolio/performance.png', '373487cf0257a68da7d555582bc865473d62d70365c834ee45c227a3ba433326', 'image', NULL, NULL, NULL, NULL, NULL),
(24, 1, 'https://viraladsmedia.com/Assets/portfolio/logo-branding.png', '4704d79a1c931e65e77c08d5b0f83490cd07e59692c19d6f00a34dd025b58227', 'image', NULL, NULL, NULL, NULL, NULL),
(25, 1, 'https://viraladsmedia.com/Assets/portfolio/influencer.png', '7f51b287748af9a6998807633bcabc8eaac4b5de10fb43680ec9d43fb828d2c9', 'image', NULL, NULL, NULL, NULL, NULL),
(26, 1, 'https://viraladsmedia.com/Assets/portfolio/seo.png', '4c25f453d1107e31768583e3fad244cad46562080206cd378254be6277164962', 'image', NULL, NULL, NULL, NULL, NULL),
(27, 1, 'https://viraladsmedia.com/Assets/portfolio/ad.png', '774e74773298b9e702c23b726c4a2736681af48b24d98b98dde8bf05ecad579a', 'image', NULL, NULL, NULL, NULL, NULL),
(28, 1, 'https://viraladsmedia.com/Assets/portfolio/graphic.png', '374a48d00362751a90044c3bca110a1f1ae69b3ad11cc2bf750f2962f9d69e26', 'image', NULL, NULL, NULL, NULL, NULL),
(29, 1, 'https://viraladsmedia.com/Assets/portfolio/social.png', '33785d10db82937da28baee610558bd0e7d2b3d2c49ae1e6308c50f8d1cc516b', 'image', NULL, NULL, NULL, NULL, NULL),
(30, 1, 'https://viraladsmedia.comservices.html', '8e25041e9b02b3b6985e03fd945344e93c09ec6e19cd3a47eb1f1d7902e4b981', 'external', NULL, NULL, NULL, NULL, NULL),
(31, 1, 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', '3bbdf7d965bbd20e31608275cd6e26cfb9be72dbf6b23f38a67d07c5098de03d', 'image', NULL, NULL, NULL, NULL, NULL),
(32, 1, 'https://viraladsmedia.com/industry-detail.html?appliances-marketing-service', '3eed6b07e017cf3bc58e7d831382e01e3aba3ad3761dbb3be71bd6c5b2caff57', 'image', NULL, NULL, NULL, NULL, NULL),
(33, 1, 'https://viraladsmedia.com/industry-detail.html?affordable-e-commerce-website-development-services', '453837d6dbea222b66d15ab318022d14fd1ee35e5eb09db82b76b0119314ebda', 'image', NULL, NULL, NULL, NULL, NULL),
(34, 1, 'https://viraladsmedia.com/industry-detail.html?manufacturing-marketing-services', '66a1b661356274aecf183b44438b875bc6cbb8870af646de6f35a2bff91bc620', 'image', NULL, NULL, NULL, NULL, NULL),
(35, 1, 'https://viraladsmedia.com/industry-detail.html?travel-marketing-services', '6c3473610a61d1105caa45574fe6726bf27ef6086c677a51805840539978f217', 'image', NULL, NULL, NULL, NULL, NULL),
(36, 1, 'https://viraladsmedia.com/Assets/services/web.jpg', '5aef50f7e4c35953a312ae97c5ef7c3b4461cbec797dc75e79dafbcf6cc7451c', 'image', NULL, NULL, NULL, NULL, NULL),
(37, 1, 'https://viraladsmedia.com/Assets/services/performance.jpg', 'fb85f09af4e889bd0e9b87990ed5b42c9cc0df0a70b2c780cae7815e81c7a5a1', 'image', NULL, NULL, NULL, NULL, NULL),
(38, 1, 'https://viraladsmedia.com/Assets/services/logo.jpg', '582c9249e7b1c4286f0fbcb96b3d5ed4d15671d3c225b633d8dd8d793a7087d1', 'image', NULL, NULL, NULL, NULL, NULL),
(39, 1, 'https://viraladsmedia.com/Assets/services/influence.jpg', 'bee586f90e68d9f6dbc322dede57ddcf276a971da0e11400b253af1b57e5c9a2', 'image', NULL, NULL, NULL, NULL, NULL),
(40, 1, 'https://viraladsmedia.com/Assets/services/seo.jpg', 'b21871ac1f9bfd92c456e117548fe13d6e8966e93c0236f1d8782212d190940c', 'image', NULL, NULL, NULL, NULL, NULL),
(41, 1, 'https://viraladsmedia.com/Assets/services/ads.jpg', 'c270872ac613e9b1af173688bdc4c868c41c3826275b3ed57f7ecad5816e47a9', 'image', NULL, NULL, NULL, NULL, NULL),
(42, 1, 'https://viraladsmedia.com/Assets/services/graphic.jpg', '253063d6f8b0caeb04e9136438ec7a094bfc2b8557fa683304cec3796e383911', 'image', NULL, NULL, NULL, NULL, NULL),
(43, 1, 'https://viraladsmedia.com/Assets/Project/20.jpg', '14dd4cdb1b99396a36ccee1537f5acec9b25887db19cf96ea85428addad4aa88', 'image', NULL, NULL, NULL, NULL, NULL),
(44, 1, 'https://viraladsmedia.com/Assets/Project/21.jpg', '5c48b7b567d8ce051e79011e7af710addae9c48dab96275d94dc299d6574d2f0', 'image', NULL, NULL, NULL, NULL, NULL),
(45, 1, 'https://viraladsmedia.com/Assets/Project/22.png', '5a82d342886ff23f018a0e46694f781ffe83d3a921828f85c2b1f10083269456', 'image', NULL, NULL, NULL, NULL, NULL),
(46, 1, 'https://viraladsmedia.com/Assets/Project/23.jpg', '996f20b0da38340d7ae183b6d9d85e1919a799b1ce4ee09eb17212bb31e37f7f', 'image', NULL, NULL, NULL, NULL, NULL),
(47, 1, 'https://viraladsmedia.com/Assets/brands/saptron.png', 'ed2cd48162fb1d804a53daf3e33d0008b256a9f2f54d72700b1c6dde35ef58d3', 'image', NULL, NULL, NULL, NULL, NULL),
(48, 1, 'https://viraladsmedia.com/Assets/brands/allied.png', '80a18a2d082f7d9c2e2ddc3f2e7b2dd5b5d4a8829fbd6b363dd658780b7b1a5c', 'image', NULL, NULL, NULL, NULL, NULL),
(49, 1, 'https://viraladsmedia.com/Assets/brands/aryan.png', '967e334b44fa1024c9945da39bdc5918f8db8a448bae40233ec956da544e912c', 'image', NULL, NULL, NULL, NULL, NULL),
(50, 1, 'https://viraladsmedia.com/Assets/brands/bakery.png', '834774f18a306ba85847deac6c3f86b661d142d62abcaac2987f78fcf9aab0cd', 'image', NULL, NULL, NULL, NULL, NULL),
(51, 1, 'https://viraladsmedia.com/Assets/brands/balaji.png', 'b7347c9b530b5cccd6ade65644215835d229890c6e583eb74cca924841ebcf30', 'image', NULL, NULL, NULL, NULL, NULL),
(52, 1, 'https://viraladsmedia.com/Assets/brands/component.png', 'c3918ad66cdfc84273bba58b8d0403be699e63c5425487a18df97c12b17a6f93', 'image', NULL, NULL, NULL, NULL, NULL),
(53, 1, 'https://viraladsmedia.com/Assets/brands/delmont.png', 'cc050bacea0e90a9dfde1552ce573ecb8aae3e66b46fca556c57b92c3ada3ff7', 'image', NULL, NULL, NULL, NULL, NULL),
(54, 1, 'https://viraladsmedia.com/Assets/brands/drapple.png', '567f1db3a6cc5abdeb10f92022dd9ce3569f8e64143b9858c9b22314d866c84a', 'image', NULL, NULL, NULL, NULL, NULL),
(55, 1, 'https://viraladsmedia.com/Assets/brands/eltons.png', '38b7008106781314e2003064c25b5ab2a788e15bfb5a68ceceb2c7324db3e205', 'image', NULL, NULL, NULL, NULL, NULL),
(56, 1, 'https://viraladsmedia.com/Assets/brands/franklite.png', '2a63da894b18439f17341bd2dc1b1a85952fe68be262bf764514dab7e6823a99', 'image', NULL, NULL, NULL, NULL, NULL),
(57, 1, 'https://viraladsmedia.com/Assets/brands/frendz_forever.png', '676dabaaf6ed567fe7c2f20b16a8633b74586da47ca2a883e0d32ab0fc47d406', 'image', NULL, NULL, NULL, NULL, NULL),
(58, 1, 'https://viraladsmedia.com/Assets/brands/gboss.png', '225eb10c1ef7dbb0cf5918b7ad26db306cf30a8049067d5accffbd0711e599f3', 'image', NULL, NULL, NULL, NULL, NULL),
(59, 1, 'https://viraladsmedia.com/Assets/brands/glamfam.png', 'e12563668302e477c88185d36130163e2d824142941e4ab1b55328eaaad3701a', 'image', NULL, NULL, NULL, NULL, NULL),
(60, 1, 'https://viraladsmedia.com/Assets/brands/guruji.png', '3ef5a7c0202fe49c7c5e36ed6469f5c83b61542ef1b9eb8460d373199173ca84', 'image', NULL, NULL, NULL, NULL, NULL),
(61, 1, 'https://viraladsmedia.com/Assets/brands/jbj.png', '5d03af6167ae7e80a0784cf6e500f7bd49fe7219112785f08775c5340eb9d86c', 'image', NULL, NULL, NULL, NULL, NULL),
(62, 1, 'https://viraladsmedia.com/Assets/brands/jyoti.png', '1ff1445de6eb918b30c0a22142f2a8c1e184d0d954f5d78fcabdb36b64502211', 'image', NULL, NULL, NULL, NULL, NULL),
(63, 1, 'https://viraladsmedia.com/Assets/brands/kamal.png', '21492630f84221fc38d283abfe942c9d23d34e879b00bc7e518d41b680a64b9e', 'image', NULL, NULL, NULL, NULL, NULL),
(64, 1, 'https://viraladsmedia.com/Assets/brands/sketch.png', '68d3e2bfce183f8638cc3d73918eb3ee1f4cfa6986f630c4438cdfec389955d1', 'image', NULL, NULL, NULL, NULL, NULL),
(65, 1, 'https://viraladsmedia.com/Assets/brands/mango.png', '9fd1974f20bed59ed78334e3c5a026c03a42a9243f8c0c069033e149da5bccd2', 'image', NULL, NULL, NULL, NULL, NULL),
(66, 1, 'https://viraladsmedia.com/Assets/brands/medyra.png', '0095cd58526224960ac15471fb139a552bf6fadf89325b5622baf7f77dfd33d6', 'image', NULL, NULL, NULL, NULL, NULL),
(67, 1, 'https://viraladsmedia.com/Assets/brands/minar.png', '013676f63135f5993fc7ab4446a7a87bde6315798f169e427b350842641d338f', 'image', NULL, NULL, NULL, NULL, NULL),
(68, 1, 'https://viraladsmedia.com/Assets/brands/navigator.png', '59dff6295012f628ec13c02df9a55e9f0f8898d3bb67de45e18a55adac30b4d3', 'image', NULL, NULL, NULL, NULL, NULL),
(69, 1, 'https://viraladsmedia.com/Assets/brands/nipex.png', '7e0e7845ac7f3456afa9e10cc137156179f040606262dcf195256d028b25a588', 'image', NULL, NULL, NULL, NULL, NULL),
(70, 1, 'https://viraladsmedia.com/Assets/brands/nippon.png', 'e4eca2864fde6e9e81df449e1bae903f4a101e2198eb8e024369524ecce33433', 'image', NULL, NULL, NULL, NULL, NULL),
(71, 1, 'https://viraladsmedia.com/Assets/brands/nugraj.png', '1196629fab89235af256b615e53cb096231c0932e1bb29549f38fd3d3dcc86c4', 'image', NULL, NULL, NULL, NULL, NULL),
(72, 1, 'https://viraladsmedia.com/Assets/brands/pixel-cable.png', '52fff5fe23a38a49d4fcc47f00c68311e98ca084ce8b01b0e5656374d7d8d589', 'image', NULL, NULL, NULL, NULL, NULL),
(73, 1, 'https://viraladsmedia.com/Assets/brands/presco.png', 'da02418c5872ba5425dc26665897308c8ef50d19eda7cd37492d895e9e81c641', 'image', NULL, NULL, NULL, NULL, NULL),
(74, 1, 'https://viraladsmedia.com/Assets/brands/savele.png', '294ba47b16b4b249255a15cd3bcf9c9e490eea30ec904ef42a89244f2e2f06a6', 'image', NULL, NULL, NULL, NULL, NULL),
(75, 1, 'https://viraladsmedia.com/Assets/brands/shri-shyam.png', '161aa5cbe48bf1c2bb300b4deb85d32c6e32abad6d99d604d8ec037410cfe732', 'image', NULL, NULL, NULL, NULL, NULL),
(76, 1, 'https://viraladsmedia.com/Assets/brands/tdii.png', 'efc091afb2c655c5f4e5ada68c4a45a4f29d6f4c02064628f7569eeaa55d20ad', 'image', NULL, NULL, NULL, NULL, NULL),
(77, 1, 'https://viraladsmedia.com/Assets/brands/tiptop.png', '83d578f648d24f2193310b5921845d9bcaffbcf911b541732048bb1e3f16b9e9', 'image', NULL, NULL, NULL, NULL, NULL),
(78, 1, 'https://viraladsmedia.com/Assets/brands/topson.png', 'e9df2b59b8137cced55833e07b00b9cfa1c6433046d752045f0912c5b5938091', 'image', NULL, NULL, NULL, NULL, NULL),
(79, 1, 'https://viraladsmedia.com/Assets/brands/trophy.png', '92a456e74f5d0a244907f13afe2d259822ec38fe0823311ecfc815f539243eb9', 'image', NULL, NULL, NULL, NULL, NULL),
(80, 1, 'https://viraladsmedia.com/Assets/Graphics/14.jpg', '6b82bf0d26ff3d039e4b5fd4dd33246f2d08185050c42eed28a606d02d6bf520', 'image', NULL, NULL, NULL, NULL, NULL),
(81, 1, 'https://viraladsmedia.com/Assets/Graphics/11.jpg', '337838162a420ca837330318e0c9fb93f68a47699c817287c74d05057827fc11', 'image', NULL, NULL, NULL, NULL, NULL),
(82, 1, 'https://viraladsmedia.com/Assets/Graphics/12.jpg', '4f400fb6b3db45c905d197c207bd76c05aeee532ee5b2ee5184f16388b120370', 'image', NULL, NULL, NULL, NULL, NULL),
(83, 1, 'https://viraladsmedia.com/Assets/Graphics/13.jpg', 'd0226c4371aff0af00f0ff2694454f9ef078a7cfd46dc28ba64a943982a62dee', 'image', NULL, NULL, NULL, NULL, NULL),
(84, 1, 'https://viraladsmedia.com/Assets/office.png', 'd140930258d90b03bf591bf8e5f658553a05eb281025657608d2ffd902bf16a6', 'image', NULL, NULL, NULL, NULL, NULL),
(85, 1, 'https://viraladsmedia.com/about.html', '90bd450b4c322ca7cb9c2876960b3a7d6f17c764286fc4e1313ea0e64601113e', 'image', NULL, NULL, NULL, NULL, NULL),
(86, 1, 'https://viraladsmedia.com/industry-detail.html?healthcare-marketing-services', 'adf31cea028938761c0169440bcb495e6371a3d70276718d4b7b16979e953065', 'image', NULL, NULL, NULL, NULL, NULL),
(87, 1, 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'bc0fa68ee99d9f494a2dde26740d59fe77df1921f12a7a64c052aa305a522c4d', 'image', NULL, NULL, NULL, NULL, NULL),
(88, 1, 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'ccbb29ac10d09b0add354901a7eac5e5d936bb545da0b09e55fe66439e5c4fda', 'image', NULL, NULL, NULL, NULL, NULL),
(89, 1, 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'cdbfbf6ad68b7a63622bc4c3a520812422f235d6cd09cfb1250a0f0e1cd87b82', 'image', NULL, NULL, NULL, NULL, NULL),
(90, 1, 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'd57e91fa2d5eacab046900a30c14391b036aa955fb1847f5faa99ee22b22184b', 'image', NULL, NULL, NULL, NULL, NULL),
(91, 1, 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'd6e234854c463ad4e9297073848e16182b0239016ca497164bbd2ba6f343e5f4', 'image', NULL, NULL, NULL, NULL, NULL),
(92, 1, 'https://viraladsmedia.com/industry-detail.html?education-marketing-services', 'e2f42fc8ac1d2e3a50b78068e75176e490a327111553d90e9b64697203b54b12', 'image', NULL, NULL, NULL, NULL, NULL),
(93, 1, 'https://viraladsmedia.com/industry-detail.html?real-estate-marketing-services', 'fa02740cc2e57d3b3ef45e7b84e8da254399be0d153534b2d2e229956cea030f', 'image', NULL, NULL, NULL, NULL, NULL),
(94, 4, 'https://razorpay.me/@viraladsmedia9256', '355f62e83801a6a501932f460dda204b07f2a0e49701ea25f39fee1ebe72a7d8', 'external', NULL, NULL, NULL, NULL, NULL),
(95, 4, 'https://wa.me/919354491934', '5428bbaadf2736fd7917420c1b7c646fb1bcf71f482d81779748ff353418fa01', 'external', NULL, NULL, NULL, NULL, NULL),
(96, 4, 'https://www.facebook.com/theviraladsmedia/', 'ff3a03b82dc6f5fad79900542b54878a7e3f3f05796a68b0914f73f2bea8fbaa', 'external', NULL, NULL, NULL, NULL, NULL),
(97, 4, 'https://www.instagram.com/theviraladsmedia/', '985f964fdafbf5770cef4c1da0a71dc9fceca2b1b1f8acd310f97901a13829a5', 'external', NULL, NULL, NULL, NULL, NULL),
(98, 4, 'https://www.behance.net/viraladsmedia/', '63644d346e6d72e8891f04911d8f98e0024d5ac28be84e14d3fd970fd23e1559', 'external', NULL, NULL, NULL, NULL, NULL),
(99, 4, 'https://www.linkedin.com/in/viral-ads-media-34ba19280/', 'b84b019cc9a66d1d8b16186fc19614aca3f48d7b3d5db6f65a2b4e594d01044c', 'external', NULL, NULL, NULL, NULL, NULL),
(100, 4, 'https://www.youtube.com/@ViralAdsMedia/', '1932b2e11d3721fd8e61335d78e457f2a7097acb9f572c32a18afee2ac8d5e19', 'external', 200, 'text/html; charset=utf-8', 0, NULL, '2026-09-10 11:06:02'),
(101, 4, 'https://x.com/viraladsmedia/', '668d2626fdf27480413b5e14979d0fb2507ef65f9ade0c085f26c8b0aec4c17f', 'external', NULL, NULL, NULL, NULL, NULL),
(102, 4, 'https://www.dmca.com/r/prddr50', 'b99f16506fa9ca2523562a85c66695cf3561d491b60a3e53dab9bd148e4ffd81', 'external', NULL, NULL, NULL, NULL, NULL),
(103, 4, 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', '048d254c0d3a16f911f68999c6cacc7308a95e3faa76108a72696da36fc0bb34', 'image', NULL, NULL, NULL, 'Network request failed: transfer closed with 43156 bytes remaining to read', '2026-09-10 11:05:56'),
(104, 4, 'https://viraladsmedia.com/Assets/Certification/36.png', 'cdff5cb51ff2bb99c941a91b53a2b98efa457ad983fcf1f57a3c8f482a01af08', 'image', NULL, NULL, NULL, NULL, NULL),
(105, 4, 'https://viraladsmedia.com/Assets/Certification/37.png', 'e378396802a6be93a8b67ecc0837c972558c9996e72b0bd122d09ba4358c8a99', 'image', NULL, NULL, NULL, NULL, NULL),
(106, 4, 'https://viraladsmedia.com/Assets/Certification/38.png', '238037d884fcc0bf27bd99cd2ed5dc8f508d4487ce167692acb5722e709893e7', 'image', NULL, NULL, NULL, NULL, NULL),
(107, 4, 'https://viraladsmedia.com/Assets/Certification/39.png', '2eb4ceb2faeafc2cb261eb1ab02b3f0e6d4fb159318ca13168e935d0ae6f29c4', 'image', NULL, NULL, NULL, NULL, NULL),
(108, 4, 'https://viraladsmedia.com/Assets/Certification/40.png', '0c7e7a235c25539bd0edd8f7e38342ba9b309a6388715dbdc5623c6a3b8c12f9', 'image', NULL, NULL, NULL, 'Network request failed: transfer closed with 144505 bytes remaining to read', '2026-09-10 11:05:57'),
(109, 4, 'https://viraladsmedia.com/Assets/Certification/41.png', '9309c5ae7b36613e562d5aacb8c86d539046f23f7810440cca7a9a242445736e', 'image', NULL, NULL, NULL, NULL, NULL),
(110, 4, 'https://viraladsmedia.com/Assets/Certification/42.png', 'e1827e8646185badbe37f941e1d6c13d47e36fc9a026f747ac17ce9a108d88bd', 'image', NULL, NULL, NULL, NULL, NULL),
(111, 4, 'https://viraladsmedia.com/Assets/Certification/43.png', 'b94ef2eadec60c0150b22e0caeebb723d82211a8d8906b7c5ddf3c35ebd3f381', 'image', NULL, NULL, NULL, NULL, NULL),
(112, 4, 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', '0dea33dbae412c397a198d9f2cf8ef4854f2cd6a7f54771301fe43dc44b052cf', 'image', NULL, NULL, NULL, 'Network request failed: transfer closed with 43156 bytes remaining to read', '2026-09-10 11:05:58'),
(113, 4, 'https://viraladsmedia.com/industry-detail.html?fashion-marketing-services', '1c5854e2fb39e602539813f7f6e1d9ff145c7a7572dc9fc8bae838db23063f59', 'image', NULL, NULL, NULL, NULL, NULL),
(114, 4, 'https://viraladsmedia.com/industry-detail.html?cosmetics-marketing-service', '216491e41491bf55f2f96e41cf5e79536c4807be274b6796802ea788282d5219', 'image', NULL, NULL, NULL, NULL, NULL),
(115, 4, 'https://viraladsmedia.com/Assets/portfolio/web.png', '0d40035acabf562fb78ae909f3db9cbdb7b993daf97dc52a1d70ed549c4242ff', 'image', NULL, NULL, NULL, 'Network request failed: transfer closed with 1044942 bytes remaining to read', '2026-09-10 11:05:58'),
(116, 4, 'https://viraladsmedia.com/Assets/portfolio/performance.png', '373487cf0257a68da7d555582bc865473d62d70365c834ee45c227a3ba433326', 'image', NULL, NULL, NULL, NULL, NULL),
(117, 4, 'https://viraladsmedia.com/Assets/portfolio/logo-branding.png', '4704d79a1c931e65e77c08d5b0f83490cd07e59692c19d6f00a34dd025b58227', 'image', NULL, NULL, NULL, NULL, NULL),
(118, 4, 'https://viraladsmedia.com/Assets/portfolio/influencer.png', '7f51b287748af9a6998807633bcabc8eaac4b5de10fb43680ec9d43fb828d2c9', 'image', NULL, NULL, NULL, NULL, NULL),
(119, 4, 'https://viraladsmedia.com/Assets/portfolio/seo.png', '4c25f453d1107e31768583e3fad244cad46562080206cd378254be6277164962', 'image', NULL, NULL, NULL, NULL, NULL),
(120, 4, 'https://viraladsmedia.com/Assets/portfolio/ad.png', '774e74773298b9e702c23b726c4a2736681af48b24d98b98dde8bf05ecad579a', 'image', NULL, NULL, NULL, NULL, NULL),
(121, 4, 'https://viraladsmedia.com/Assets/portfolio/graphic.png', '374a48d00362751a90044c3bca110a1f1ae69b3ad11cc2bf750f2962f9d69e26', 'image', NULL, NULL, NULL, NULL, NULL),
(122, 4, 'https://viraladsmedia.com/Assets/portfolio/social.png', '33785d10db82937da28baee610558bd0e7d2b3d2c49ae1e6308c50f8d1cc516b', 'image', NULL, NULL, NULL, NULL, NULL),
(123, 4, 'https://viraladsmedia.comservices.html', '8e25041e9b02b3b6985e03fd945344e93c09ec6e19cd3a47eb1f1d7902e4b981', 'external', NULL, NULL, NULL, NULL, NULL),
(124, 4, 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', '3bbdf7d965bbd20e31608275cd6e26cfb9be72dbf6b23f38a67d07c5098de03d', 'image', NULL, NULL, NULL, NULL, NULL),
(125, 4, 'https://viraladsmedia.com/industry-detail.html?appliances-marketing-service', '3eed6b07e017cf3bc58e7d831382e01e3aba3ad3761dbb3be71bd6c5b2caff57', 'image', NULL, NULL, NULL, NULL, NULL),
(126, 4, 'https://viraladsmedia.com/industry-detail.html?affordable-e-commerce-website-development-services', '453837d6dbea222b66d15ab318022d14fd1ee35e5eb09db82b76b0119314ebda', 'image', NULL, NULL, NULL, NULL, NULL),
(127, 4, 'https://viraladsmedia.com/industry-detail.html?manufacturing-marketing-services', '66a1b661356274aecf183b44438b875bc6cbb8870af646de6f35a2bff91bc620', 'image', NULL, NULL, NULL, NULL, NULL),
(128, 4, 'https://viraladsmedia.com/industry-detail.html?travel-marketing-services', '6c3473610a61d1105caa45574fe6726bf27ef6086c677a51805840539978f217', 'image', NULL, NULL, NULL, NULL, NULL),
(129, 4, 'https://viraladsmedia.com/Assets/services/web.jpg', '5aef50f7e4c35953a312ae97c5ef7c3b4461cbec797dc75e79dafbcf6cc7451c', 'image', NULL, NULL, NULL, NULL, NULL),
(130, 4, 'https://viraladsmedia.com/Assets/services/performance.jpg', 'fb85f09af4e889bd0e9b87990ed5b42c9cc0df0a70b2c780cae7815e81c7a5a1', 'image', NULL, NULL, NULL, NULL, NULL),
(131, 4, 'https://viraladsmedia.com/Assets/services/logo.jpg', '582c9249e7b1c4286f0fbcb96b3d5ed4d15671d3c225b633d8dd8d793a7087d1', 'image', NULL, NULL, NULL, NULL, NULL),
(132, 4, 'https://viraladsmedia.com/Assets/services/influence.jpg', 'bee586f90e68d9f6dbc322dede57ddcf276a971da0e11400b253af1b57e5c9a2', 'image', NULL, NULL, NULL, NULL, NULL),
(133, 4, 'https://viraladsmedia.com/Assets/services/seo.jpg', 'b21871ac1f9bfd92c456e117548fe13d6e8966e93c0236f1d8782212d190940c', 'image', NULL, NULL, NULL, NULL, NULL),
(134, 4, 'https://viraladsmedia.com/Assets/services/ads.jpg', 'c270872ac613e9b1af173688bdc4c868c41c3826275b3ed57f7ecad5816e47a9', 'image', NULL, NULL, NULL, NULL, NULL),
(135, 4, 'https://viraladsmedia.com/Assets/services/graphic.jpg', '253063d6f8b0caeb04e9136438ec7a094bfc2b8557fa683304cec3796e383911', 'image', NULL, NULL, NULL, NULL, NULL),
(136, 4, 'https://viraladsmedia.com/Assets/Project/20.jpg', '14dd4cdb1b99396a36ccee1537f5acec9b25887db19cf96ea85428addad4aa88', 'image', NULL, NULL, NULL, 'Network request failed: transfer closed with 290796 bytes remaining to read', '2026-09-10 11:06:00'),
(137, 4, 'https://viraladsmedia.com/Assets/Project/21.jpg', '5c48b7b567d8ce051e79011e7af710addae9c48dab96275d94dc299d6574d2f0', 'image', NULL, NULL, NULL, NULL, NULL),
(138, 4, 'https://viraladsmedia.com/Assets/Project/22.png', '5a82d342886ff23f018a0e46694f781ffe83d3a921828f85c2b1f10083269456', 'image', NULL, NULL, NULL, NULL, NULL),
(139, 4, 'https://viraladsmedia.com/Assets/Project/23.jpg', '996f20b0da38340d7ae183b6d9d85e1919a799b1ce4ee09eb17212bb31e37f7f', 'image', NULL, NULL, NULL, NULL, NULL),
(140, 4, 'https://viraladsmedia.com/Assets/brands/saptron.png', 'ed2cd48162fb1d804a53daf3e33d0008b256a9f2f54d72700b1c6dde35ef58d3', 'image', NULL, NULL, NULL, NULL, NULL),
(141, 4, 'https://viraladsmedia.com/Assets/brands/allied.png', '80a18a2d082f7d9c2e2ddc3f2e7b2dd5b5d4a8829fbd6b363dd658780b7b1a5c', 'image', NULL, NULL, NULL, NULL, NULL),
(142, 4, 'https://viraladsmedia.com/Assets/brands/aryan.png', '967e334b44fa1024c9945da39bdc5918f8db8a448bae40233ec956da544e912c', 'image', NULL, NULL, NULL, NULL, NULL),
(143, 4, 'https://viraladsmedia.com/Assets/brands/bakery.png', '834774f18a306ba85847deac6c3f86b661d142d62abcaac2987f78fcf9aab0cd', 'image', NULL, NULL, NULL, NULL, NULL),
(144, 4, 'https://viraladsmedia.com/Assets/brands/balaji.png', 'b7347c9b530b5cccd6ade65644215835d229890c6e583eb74cca924841ebcf30', 'image', NULL, NULL, NULL, NULL, NULL),
(145, 4, 'https://viraladsmedia.com/Assets/brands/component.png', 'c3918ad66cdfc84273bba58b8d0403be699e63c5425487a18df97c12b17a6f93', 'image', NULL, NULL, NULL, NULL, NULL),
(146, 4, 'https://viraladsmedia.com/Assets/brands/delmont.png', 'cc050bacea0e90a9dfde1552ce573ecb8aae3e66b46fca556c57b92c3ada3ff7', 'image', NULL, NULL, NULL, NULL, NULL),
(147, 4, 'https://viraladsmedia.com/Assets/brands/drapple.png', '567f1db3a6cc5abdeb10f92022dd9ce3569f8e64143b9858c9b22314d866c84a', 'image', NULL, NULL, NULL, NULL, NULL),
(148, 4, 'https://viraladsmedia.com/Assets/brands/eltons.png', '38b7008106781314e2003064c25b5ab2a788e15bfb5a68ceceb2c7324db3e205', 'image', NULL, NULL, NULL, NULL, NULL),
(149, 4, 'https://viraladsmedia.com/Assets/brands/franklite.png', '2a63da894b18439f17341bd2dc1b1a85952fe68be262bf764514dab7e6823a99', 'image', NULL, NULL, NULL, NULL, NULL),
(150, 4, 'https://viraladsmedia.com/Assets/brands/frendz_forever.png', '676dabaaf6ed567fe7c2f20b16a8633b74586da47ca2a883e0d32ab0fc47d406', 'image', NULL, NULL, NULL, NULL, NULL),
(151, 4, 'https://viraladsmedia.com/Assets/brands/gboss.png', '225eb10c1ef7dbb0cf5918b7ad26db306cf30a8049067d5accffbd0711e599f3', 'image', NULL, NULL, NULL, NULL, NULL),
(152, 4, 'https://viraladsmedia.com/Assets/brands/glamfam.png', 'e12563668302e477c88185d36130163e2d824142941e4ab1b55328eaaad3701a', 'image', NULL, NULL, NULL, NULL, NULL),
(153, 4, 'https://viraladsmedia.com/Assets/brands/guruji.png', '3ef5a7c0202fe49c7c5e36ed6469f5c83b61542ef1b9eb8460d373199173ca84', 'image', NULL, NULL, NULL, NULL, NULL),
(154, 4, 'https://viraladsmedia.com/Assets/brands/jbj.png', '5d03af6167ae7e80a0784cf6e500f7bd49fe7219112785f08775c5340eb9d86c', 'image', NULL, NULL, NULL, NULL, NULL),
(155, 4, 'https://viraladsmedia.com/Assets/brands/jyoti.png', '1ff1445de6eb918b30c0a22142f2a8c1e184d0d954f5d78fcabdb36b64502211', 'image', NULL, NULL, NULL, NULL, NULL),
(156, 4, 'https://viraladsmedia.com/Assets/brands/kamal.png', '21492630f84221fc38d283abfe942c9d23d34e879b00bc7e518d41b680a64b9e', 'image', NULL, NULL, NULL, NULL, NULL),
(157, 4, 'https://viraladsmedia.com/Assets/brands/sketch.png', '68d3e2bfce183f8638cc3d73918eb3ee1f4cfa6986f630c4438cdfec389955d1', 'image', NULL, NULL, NULL, NULL, NULL),
(158, 4, 'https://viraladsmedia.com/Assets/brands/mango.png', '9fd1974f20bed59ed78334e3c5a026c03a42a9243f8c0c069033e149da5bccd2', 'image', NULL, NULL, NULL, NULL, NULL),
(159, 4, 'https://viraladsmedia.com/Assets/brands/medyra.png', '0095cd58526224960ac15471fb139a552bf6fadf89325b5622baf7f77dfd33d6', 'image', NULL, NULL, NULL, 'Network request failed: transfer closed with 377004 bytes remaining to read', '2026-09-10 11:05:54'),
(160, 4, 'https://viraladsmedia.com/Assets/brands/minar.png', '013676f63135f5993fc7ab4446a7a87bde6315798f169e427b350842641d338f', 'image', NULL, NULL, NULL, 'Network request failed: transfer closed with 1114014 bytes remaining to read', '2026-09-10 11:05:55'),
(161, 4, 'https://viraladsmedia.com/Assets/brands/navigator.png', '59dff6295012f628ec13c02df9a55e9f0f8898d3bb67de45e18a55adac30b4d3', 'image', NULL, NULL, NULL, NULL, NULL),
(162, 4, 'https://viraladsmedia.com/Assets/brands/nipex.png', '7e0e7845ac7f3456afa9e10cc137156179f040606262dcf195256d028b25a588', 'image', NULL, NULL, NULL, NULL, NULL),
(163, 4, 'https://viraladsmedia.com/Assets/brands/nippon.png', 'e4eca2864fde6e9e81df449e1bae903f4a101e2198eb8e024369524ecce33433', 'image', NULL, NULL, NULL, NULL, NULL),
(164, 4, 'https://viraladsmedia.com/Assets/brands/nugraj.png', '1196629fab89235af256b615e53cb096231c0932e1bb29549f38fd3d3dcc86c4', 'image', NULL, NULL, NULL, 'Network request failed: transfer closed with 331620 bytes remaining to read', '2026-09-10 11:05:59'),
(165, 4, 'https://viraladsmedia.com/Assets/brands/pixel-cable.png', '52fff5fe23a38a49d4fcc47f00c68311e98ca084ce8b01b0e5656374d7d8d589', 'image', NULL, NULL, NULL, NULL, NULL),
(166, 4, 'https://viraladsmedia.com/Assets/brands/presco.png', 'da02418c5872ba5425dc26665897308c8ef50d19eda7cd37492d895e9e81c641', 'image', NULL, NULL, NULL, NULL, NULL),
(167, 4, 'https://viraladsmedia.com/Assets/brands/savele.png', '294ba47b16b4b249255a15cd3bcf9c9e490eea30ec904ef42a89244f2e2f06a6', 'image', NULL, NULL, NULL, NULL, NULL),
(168, 4, 'https://viraladsmedia.com/Assets/brands/shri-shyam.png', '161aa5cbe48bf1c2bb300b4deb85d32c6e32abad6d99d604d8ec037410cfe732', 'image', NULL, NULL, NULL, 'Network request failed: transfer closed with 381357 bytes remaining to read', '2026-09-10 11:06:01'),
(169, 4, 'https://viraladsmedia.com/Assets/brands/tdii.png', 'efc091afb2c655c5f4e5ada68c4a45a4f29d6f4c02064628f7569eeaa55d20ad', 'image', NULL, NULL, NULL, NULL, NULL),
(170, 4, 'https://viraladsmedia.com/Assets/brands/tiptop.png', '83d578f648d24f2193310b5921845d9bcaffbcf911b541732048bb1e3f16b9e9', 'image', NULL, NULL, NULL, NULL, NULL),
(171, 4, 'https://viraladsmedia.com/Assets/brands/topson.png', 'e9df2b59b8137cced55833e07b00b9cfa1c6433046d752045f0912c5b5938091', 'image', NULL, NULL, NULL, NULL, NULL),
(172, 4, 'https://viraladsmedia.com/Assets/brands/trophy.png', '92a456e74f5d0a244907f13afe2d259822ec38fe0823311ecfc815f539243eb9', 'image', NULL, NULL, NULL, NULL, NULL),
(173, 4, 'https://viraladsmedia.com/Assets/Graphics/14.jpg', '6b82bf0d26ff3d039e4b5fd4dd33246f2d08185050c42eed28a606d02d6bf520', 'image', NULL, NULL, NULL, NULL, NULL),
(174, 4, 'https://viraladsmedia.com/Assets/Graphics/11.jpg', '337838162a420ca837330318e0c9fb93f68a47699c817287c74d05057827fc11', 'image', NULL, NULL, NULL, NULL, NULL),
(175, 4, 'https://viraladsmedia.com/Assets/Graphics/12.jpg', '4f400fb6b3db45c905d197c207bd76c05aeee532ee5b2ee5184f16388b120370', 'image', NULL, NULL, NULL, NULL, NULL),
(176, 4, 'https://viraladsmedia.com/Assets/Graphics/13.jpg', 'd0226c4371aff0af00f0ff2694454f9ef078a7cfd46dc28ba64a943982a62dee', 'image', NULL, NULL, NULL, NULL, NULL),
(177, 4, 'https://viraladsmedia.com/Assets/office.png', 'd140930258d90b03bf591bf8e5f658553a05eb281025657608d2ffd902bf16a6', 'image', NULL, NULL, NULL, NULL, NULL),
(178, 4, 'https://viraladsmedia.com/about.html', '90bd450b4c322ca7cb9c2876960b3a7d6f17c764286fc4e1313ea0e64601113e', 'image', NULL, NULL, NULL, NULL, NULL),
(179, 4, 'https://viraladsmedia.com/industry-detail.html?healthcare-marketing-services', 'adf31cea028938761c0169440bcb495e6371a3d70276718d4b7b16979e953065', 'image', NULL, NULL, NULL, NULL, NULL),
(180, 4, 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'bc0fa68ee99d9f494a2dde26740d59fe77df1921f12a7a64c052aa305a522c4d', 'image', NULL, NULL, NULL, NULL, NULL),
(181, 4, 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'ccbb29ac10d09b0add354901a7eac5e5d936bb545da0b09e55fe66439e5c4fda', 'image', NULL, NULL, NULL, NULL, NULL),
(182, 4, 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'cdbfbf6ad68b7a63622bc4c3a520812422f235d6cd09cfb1250a0f0e1cd87b82', 'image', NULL, NULL, NULL, NULL, NULL),
(183, 4, 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'd57e91fa2d5eacab046900a30c14391b036aa955fb1847f5faa99ee22b22184b', 'image', NULL, NULL, NULL, NULL, NULL),
(184, 4, 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'd6e234854c463ad4e9297073848e16182b0239016ca497164bbd2ba6f343e5f4', 'image', NULL, NULL, NULL, NULL, NULL),
(185, 4, 'https://viraladsmedia.com/industry-detail.html?education-marketing-services', 'e2f42fc8ac1d2e3a50b78068e75176e490a327111553d90e9b64697203b54b12', 'image', NULL, NULL, NULL, NULL, NULL),
(186, 4, 'https://viraladsmedia.com/industry-detail.html?real-estate-marketing-services', 'fa02740cc2e57d3b3ef45e7b84e8da254399be0d153534b2d2e229956cea030f', 'image', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`) VALUES
(2, 'admin'),
(4, 'customer'),
(1, 'super_admin'),
(3, 'team_member');

-- --------------------------------------------------------

--
-- Table structure for table `seo_audits`
--

CREATE TABLE `seo_audits` (
  `id` int(10) UNSIGNED NOT NULL,
  `website_id` int(10) UNSIGNED NOT NULL,
  `job_id` int(10) UNSIGNED NOT NULL,
  `score` int(11) NOT NULL,
  `technical` int(11) NOT NULL,
  `onpage` int(11) NOT NULL,
  `content` int(11) NOT NULL,
  `performance` int(11) NOT NULL,
  `linking` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `seo_audits`
--

INSERT INTO `seo_audits` (`id`, `website_id`, `job_id`, `score`, `technical`, `onpage`, `content`, `performance`, `linking`, `created_at`) VALUES
(1, 1, 1, 93, 94, 86, 95, 100, 100, '2026-09-09 12:23:00'),
(2, 1, 4, 93, 94, 86, 95, 100, 100, '2026-09-10 05:36:02');

-- --------------------------------------------------------

--
-- Table structure for table `seo_expert_clients`
--

CREATE TABLE `seo_expert_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `enquiry_id` bigint(20) UNSIGNED NOT NULL,
  `website` varchar(500) NOT NULL,
  `plan` enum('starter','growth','pro') NOT NULL,
  `duration` tinyint(3) UNSIGNED NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `assigned_expert` int(10) UNSIGNED DEFAULT NULL,
  `target_keywords` text NOT NULL,
  `target_location` varchar(190) NOT NULL,
  `notes` text NOT NULL,
  `status` enum('Active','Completed','On Hold') NOT NULL DEFAULT 'Active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `seo_expert_enquiries`
--

CREATE TABLE `seo_expert_enquiries` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reference` char(12) NOT NULL,
  `request_key` char(64) NOT NULL,
  `request_type` enum('audit','hire','plan') NOT NULL DEFAULT 'hire',
  `full_name` varchar(120) NOT NULL,
  `business_name` varchar(190) NOT NULL,
  `website` varchar(500) NOT NULL,
  `phone` varchar(40) NOT NULL,
  `email` varchar(190) NOT NULL,
  `target_location` varchar(190) NOT NULL,
  `target_keywords` text NOT NULL,
  `plan` enum('undecided','starter','growth','pro') NOT NULL DEFAULT 'undecided',
  `duration` tinyint(3) UNSIGNED NOT NULL DEFAULT 3,
  `listed_amount` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `current_problem` text NOT NULL,
  `message` text NOT NULL,
  `status` enum('New','Contacted','Audit','Proposal','Payment Pending','Active','Completed','Lost') NOT NULL DEFAULT 'New',
  `assigned_expert` int(10) UNSIGNED DEFAULT NULL,
  `follow_up_at` datetime DEFAULT NULL,
  `proposal_amount` int(10) UNSIGNED DEFAULT NULL,
  `payment_status` varchar(20) NOT NULL DEFAULT 'Unpaid',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `seo_expert_notes`
--

CREATE TABLE `seo_expert_notes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `enquiry_id` bigint(20) UNSIGNED NOT NULL,
  `author_id` int(10) UNSIGNED DEFAULT NULL,
  `body` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `seo_expert_payments`
--

CREATE TABLE `seo_expert_payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `enquiry_id` bigint(20) UNSIGNED NOT NULL,
  `request_key` char(64) NOT NULL,
  `kind` enum('payment','refund') NOT NULL DEFAULT 'payment',
  `amount` int(10) UNSIGNED NOT NULL,
  `status` enum('pending','paid','failed','cancelled') NOT NULL,
  `method` varchar(80) NOT NULL,
  `reference` varchar(190) NOT NULL DEFAULT '',
  `paid_on` date NOT NULL,
  `recorded_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `seo_expert_rankings`
--

CREATE TABLE `seo_expert_rankings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `keyword` varchar(190) NOT NULL,
  `checked_on` date NOT NULL,
  `position` smallint(5) UNSIGNED DEFAULT NULL,
  `target_url` varchar(500) NOT NULL DEFAULT '',
  `source` varchar(50) NOT NULL DEFAULT 'Manual entry'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `seo_expert_reports`
--

CREATE TABLE `seo_expert_reports` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(190) NOT NULL,
  `report_month` date NOT NULL,
  `url` varchar(1000) NOT NULL DEFAULT '',
  `summary` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `seo_expert_tasks`
--

CREATE TABLE `seo_expert_tasks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `month_number` tinyint(3) UNSIGNED NOT NULL,
  `title` varchar(300) NOT NULL,
  `status` enum('Todo','In Progress','Done') NOT NULL DEFAULT 'Todo',
  `due_date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `seo_issues`
--

CREATE TABLE `seo_issues` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `website_id` int(10) UNSIGNED NOT NULL,
  `audit_id` int(10) UNSIGNED NOT NULL,
  `page_id` bigint(20) UNSIGNED DEFAULT NULL,
  `code` varchar(80) NOT NULL,
  `title` varchar(190) NOT NULL,
  `severity` varchar(30) NOT NULL,
  `category` varchar(30) NOT NULL,
  `explanation` text DEFAULT NULL,
  `recommendation` text DEFAULT NULL,
  `url` text DEFAULT NULL,
  `status` enum('open','resolved','ignored') DEFAULT 'open',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `seo_issues`
--

INSERT INTO `seo_issues` (`id`, `website_id`, `audit_id`, `page_id`, `code`, `title`, `severity`, `category`, `explanation`, `recommendation`, `url`, `status`, `created_at`) VALUES
(1, 1, 1, 27, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(2, 1, 1, 27, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(3, 1, 1, 27, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(4, 1, 1, 27, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(5, 1, 1, 27, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(6, 1, 1, 27, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(7, 1, 1, 27, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(8, 1, 1, 33, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', 'open', '2026-09-09 12:23:00'),
(9, 1, 1, 33, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', 'open', '2026-09-09 12:23:00'),
(10, 1, 1, 33, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', 'open', '2026-09-09 12:23:00'),
(11, 1, 1, 33, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', 'open', '2026-09-09 12:23:00'),
(12, 1, 1, 33, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', 'open', '2026-09-09 12:23:00'),
(13, 1, 1, 33, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', 'open', '2026-09-09 12:23:00'),
(14, 1, 1, 33, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', 'open', '2026-09-09 12:23:00'),
(15, 1, 1, 18, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/industry-detail.html?fashion-marketing-services', 'open', '2026-09-09 12:23:00'),
(16, 1, 1, 18, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/industry-detail.html?fashion-marketing-services', 'open', '2026-09-09 12:23:00'),
(17, 1, 1, 18, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/industry-detail.html?fashion-marketing-services', 'open', '2026-09-09 12:23:00'),
(18, 1, 1, 18, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/industry-detail.html?fashion-marketing-services', 'open', '2026-09-09 12:23:00'),
(19, 1, 1, 18, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/industry-detail.html?fashion-marketing-services', 'open', '2026-09-09 12:23:00'),
(20, 1, 1, 18, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/industry-detail.html?fashion-marketing-services', 'open', '2026-09-09 12:23:00'),
(21, 1, 1, 18, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/industry-detail.html?fashion-marketing-services', 'open', '2026-09-09 12:23:00'),
(22, 1, 1, 21, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/industry-detail.html?cosmetics-marketing-service', 'open', '2026-09-09 12:23:00'),
(23, 1, 1, 21, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/industry-detail.html?cosmetics-marketing-service', 'open', '2026-09-09 12:23:00'),
(24, 1, 1, 21, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/industry-detail.html?cosmetics-marketing-service', 'open', '2026-09-09 12:23:00'),
(25, 1, 1, 21, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/industry-detail.html?cosmetics-marketing-service', 'open', '2026-09-09 12:23:00'),
(26, 1, 1, 21, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/industry-detail.html?cosmetics-marketing-service', 'open', '2026-09-09 12:23:00'),
(27, 1, 1, 21, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/industry-detail.html?cosmetics-marketing-service', 'open', '2026-09-09 12:23:00'),
(28, 1, 1, 21, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/industry-detail.html?cosmetics-marketing-service', 'open', '2026-09-09 12:23:00'),
(29, 1, 1, 11, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/portfolio.html', 'open', '2026-09-09 12:23:00'),
(30, 1, 1, 11, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/portfolio.html', 'open', '2026-09-09 12:23:00'),
(31, 1, 1, 11, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/portfolio.html', 'open', '2026-09-09 12:23:00'),
(32, 1, 1, 11, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/portfolio.html', 'open', '2026-09-09 12:23:00'),
(33, 1, 1, 11, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/portfolio.html', 'open', '2026-09-09 12:23:00'),
(34, 1, 1, 6, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/service.html?affordable-web-developer-in-delhi', 'open', '2026-09-09 12:23:00'),
(35, 1, 1, 6, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/service.html?affordable-web-developer-in-delhi', 'open', '2026-09-09 12:23:00'),
(36, 1, 1, 6, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/service.html?affordable-web-developer-in-delhi', 'open', '2026-09-09 12:23:00'),
(37, 1, 1, 6, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/service.html?affordable-web-developer-in-delhi', 'open', '2026-09-09 12:23:00'),
(38, 1, 1, 6, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/service.html?affordable-web-developer-in-delhi', 'open', '2026-09-09 12:23:00'),
(39, 1, 1, 6, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/service.html?affordable-web-developer-in-delhi', 'open', '2026-09-09 12:23:00'),
(40, 1, 1, 5, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/service.html?best-seo-agency-near-me', 'open', '2026-09-09 12:23:00'),
(41, 1, 1, 5, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/service.html?best-seo-agency-near-me', 'open', '2026-09-09 12:23:00'),
(42, 1, 1, 5, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/service.html?best-seo-agency-near-me', 'open', '2026-09-09 12:23:00'),
(43, 1, 1, 5, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/service.html?best-seo-agency-near-me', 'open', '2026-09-09 12:23:00'),
(44, 1, 1, 5, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/service.html?best-seo-agency-near-me', 'open', '2026-09-09 12:23:00'),
(45, 1, 1, 5, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/service.html?best-seo-agency-near-me', 'open', '2026-09-09 12:23:00'),
(46, 1, 1, 32, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', 'open', '2026-09-09 12:23:00'),
(47, 1, 1, 32, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', 'open', '2026-09-09 12:23:00'),
(48, 1, 1, 32, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', 'open', '2026-09-09 12:23:00'),
(49, 1, 1, 32, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', 'open', '2026-09-09 12:23:00'),
(50, 1, 1, 32, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', 'open', '2026-09-09 12:23:00'),
(51, 1, 1, 32, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', 'open', '2026-09-09 12:23:00'),
(52, 1, 1, 32, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', 'open', '2026-09-09 12:23:00'),
(53, 1, 1, 20, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/industry-detail.html?appliances-marketing-service', 'open', '2026-09-09 12:23:00'),
(54, 1, 1, 20, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/industry-detail.html?appliances-marketing-service', 'open', '2026-09-09 12:23:00'),
(55, 1, 1, 20, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/industry-detail.html?appliances-marketing-service', 'open', '2026-09-09 12:23:00'),
(56, 1, 1, 20, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/industry-detail.html?appliances-marketing-service', 'open', '2026-09-09 12:23:00'),
(57, 1, 1, 20, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/industry-detail.html?appliances-marketing-service', 'open', '2026-09-09 12:23:00'),
(58, 1, 1, 20, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/industry-detail.html?appliances-marketing-service', 'open', '2026-09-09 12:23:00'),
(59, 1, 1, 20, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/industry-detail.html?appliances-marketing-service', 'open', '2026-09-09 12:23:00'),
(60, 1, 1, 12, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/industries.html', 'open', '2026-09-09 12:23:00'),
(61, 1, 1, 12, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/industries.html', 'open', '2026-09-09 12:23:00'),
(62, 1, 1, 12, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/industries.html', 'open', '2026-09-09 12:23:00'),
(63, 1, 1, 12, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/industries.html', 'open', '2026-09-09 12:23:00'),
(64, 1, 1, 12, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/industries.html', 'open', '2026-09-09 12:23:00'),
(65, 1, 1, 13, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/industry-detail.html?affordable-e-commerce-website-development-services', 'open', '2026-09-09 12:23:00'),
(66, 1, 1, 13, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/industry-detail.html?affordable-e-commerce-website-development-services', 'open', '2026-09-09 12:23:00'),
(67, 1, 1, 13, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/industry-detail.html?affordable-e-commerce-website-development-services', 'open', '2026-09-09 12:23:00'),
(68, 1, 1, 13, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/industry-detail.html?affordable-e-commerce-website-development-services', 'open', '2026-09-09 12:23:00'),
(69, 1, 1, 13, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/industry-detail.html?affordable-e-commerce-website-development-services', 'open', '2026-09-09 12:23:00'),
(70, 1, 1, 13, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/industry-detail.html?affordable-e-commerce-website-development-services', 'open', '2026-09-09 12:23:00'),
(71, 1, 1, 13, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/industry-detail.html?affordable-e-commerce-website-development-services', 'open', '2026-09-09 12:23:00'),
(72, 1, 1, 8, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/service.html?affordable-logo-and-branding-near-me', 'open', '2026-09-09 12:23:00'),
(73, 1, 1, 8, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/service.html?affordable-logo-and-branding-near-me', 'open', '2026-09-09 12:23:00'),
(74, 1, 1, 8, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/service.html?affordable-logo-and-branding-near-me', 'open', '2026-09-09 12:23:00'),
(75, 1, 1, 8, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/service.html?affordable-logo-and-branding-near-me', 'open', '2026-09-09 12:23:00'),
(76, 1, 1, 8, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/service.html?affordable-logo-and-branding-near-me', 'open', '2026-09-09 12:23:00'),
(77, 1, 1, 8, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/service.html?affordable-logo-and-branding-near-me', 'open', '2026-09-09 12:23:00'),
(78, 1, 1, 23, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/blogs.html', 'open', '2026-09-09 12:23:00'),
(79, 1, 1, 23, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/blogs.html', 'open', '2026-09-09 12:23:00'),
(80, 1, 1, 23, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/blogs.html', 'open', '2026-09-09 12:23:00'),
(81, 1, 1, 23, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/blogs.html', 'open', '2026-09-09 12:23:00'),
(82, 1, 1, 23, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/blogs.html', 'open', '2026-09-09 12:23:00'),
(83, 1, 1, 15, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/industry-detail.html?manufacturing-marketing-services', 'open', '2026-09-09 12:23:00'),
(84, 1, 1, 15, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/industry-detail.html?manufacturing-marketing-services', 'open', '2026-09-09 12:23:00'),
(85, 1, 1, 15, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/industry-detail.html?manufacturing-marketing-services', 'open', '2026-09-09 12:23:00'),
(86, 1, 1, 15, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/industry-detail.html?manufacturing-marketing-services', 'open', '2026-09-09 12:23:00'),
(87, 1, 1, 15, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/industry-detail.html?manufacturing-marketing-services', 'open', '2026-09-09 12:23:00'),
(88, 1, 1, 15, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/industry-detail.html?manufacturing-marketing-services', 'open', '2026-09-09 12:23:00'),
(89, 1, 1, 15, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/industry-detail.html?manufacturing-marketing-services', 'open', '2026-09-09 12:23:00'),
(90, 1, 1, 19, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/industry-detail.html?travel-marketing-services', 'open', '2026-09-09 12:23:00'),
(91, 1, 1, 19, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/industry-detail.html?travel-marketing-services', 'open', '2026-09-09 12:23:00'),
(92, 1, 1, 19, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/industry-detail.html?travel-marketing-services', 'open', '2026-09-09 12:23:00'),
(93, 1, 1, 19, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/industry-detail.html?travel-marketing-services', 'open', '2026-09-09 12:23:00'),
(94, 1, 1, 19, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/industry-detail.html?travel-marketing-services', 'open', '2026-09-09 12:23:00'),
(95, 1, 1, 19, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/industry-detail.html?travel-marketing-services', 'open', '2026-09-09 12:23:00'),
(96, 1, 1, 19, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/industry-detail.html?travel-marketing-services', 'open', '2026-09-09 12:23:00'),
(97, 1, 1, 9, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/service.html?best-influencer-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(98, 1, 1, 9, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/service.html?best-influencer-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(99, 1, 1, 9, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/service.html?best-influencer-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(100, 1, 1, 9, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/service.html?best-influencer-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(101, 1, 1, 9, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/service.html?best-influencer-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(102, 1, 1, 9, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/service.html?best-influencer-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(103, 1, 1, 24, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/career.html', 'open', '2026-09-09 12:23:00'),
(104, 1, 1, 24, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/career.html', 'open', '2026-09-09 12:23:00'),
(105, 1, 1, 24, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/career.html', 'open', '2026-09-09 12:23:00'),
(106, 1, 1, 24, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/career.html', 'open', '2026-09-09 12:23:00'),
(107, 1, 1, 1, 'long_title', 'Long title', 'low', 'onpage', 'Long titles may be truncated.', 'Aim for a concise title around 30–60 characters; display width varies.', 'https://viraladsmedia.com/', 'open', '2026-09-09 12:23:00'),
(108, 1, 1, 1, 'long_description', 'Long meta description', 'low', 'onpage', 'The summary may be truncated.', 'Make the description concise and specific.', 'https://viraladsmedia.com/', 'open', '2026-09-09 12:23:00'),
(109, 1, 1, 1, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/', 'open', '2026-09-09 12:23:00'),
(110, 1, 1, 1, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/', 'open', '2026-09-09 12:23:00'),
(111, 1, 1, 1, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/', 'open', '2026-09-09 12:23:00'),
(112, 1, 1, 1, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/', 'open', '2026-09-09 12:23:00'),
(113, 1, 1, 1, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/', 'open', '2026-09-09 12:23:00'),
(114, 1, 1, 10, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/service.html?proffessional-brand-shoots-in-delhi', 'open', '2026-09-09 12:23:00'),
(115, 1, 1, 10, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/service.html?proffessional-brand-shoots-in-delhi', 'open', '2026-09-09 12:23:00'),
(116, 1, 1, 10, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/service.html?proffessional-brand-shoots-in-delhi', 'open', '2026-09-09 12:23:00'),
(117, 1, 1, 10, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/service.html?proffessional-brand-shoots-in-delhi', 'open', '2026-09-09 12:23:00'),
(118, 1, 1, 10, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/service.html?proffessional-brand-shoots-in-delhi', 'open', '2026-09-09 12:23:00'),
(119, 1, 1, 10, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/service.html?proffessional-brand-shoots-in-delhi', 'open', '2026-09-09 12:23:00'),
(120, 1, 1, 22, 'long_description', 'Long meta description', 'low', 'onpage', 'The summary may be truncated.', 'Make the description concise and specific.', 'https://viraladsmedia.com/about.html', 'open', '2026-09-09 12:23:00'),
(121, 1, 1, 22, 'missing_h1', 'Missing H1', 'high', 'onpage', 'A main heading helps readers understand the page.', 'Add one clear main heading.', 'https://viraladsmedia.com/about.html', 'open', '2026-09-09 12:23:00'),
(122, 1, 1, 22, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/about.html', 'open', '2026-09-09 12:23:00'),
(123, 1, 1, 22, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/about.html', 'open', '2026-09-09 12:23:00'),
(124, 1, 1, 22, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/about.html', 'open', '2026-09-09 12:23:00'),
(125, 1, 1, 22, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/about.html', 'open', '2026-09-09 12:23:00'),
(126, 1, 1, 22, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/about.html', 'open', '2026-09-09 12:23:00'),
(127, 1, 1, 22, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/about.html', 'open', '2026-09-09 12:23:00'),
(128, 1, 1, 25, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/contact.html', 'open', '2026-09-09 12:23:00'),
(129, 1, 1, 25, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/contact.html', 'open', '2026-09-09 12:23:00'),
(130, 1, 1, 25, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/contact.html', 'open', '2026-09-09 12:23:00'),
(131, 1, 1, 25, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/contact.html', 'open', '2026-09-09 12:23:00'),
(132, 1, 1, 14, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/industry-detail.html?healthcare-marketing-services', 'open', '2026-09-09 12:23:00'),
(133, 1, 1, 14, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/industry-detail.html?healthcare-marketing-services', 'open', '2026-09-09 12:23:00'),
(134, 1, 1, 14, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/industry-detail.html?healthcare-marketing-services', 'open', '2026-09-09 12:23:00'),
(135, 1, 1, 14, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/industry-detail.html?healthcare-marketing-services', 'open', '2026-09-09 12:23:00'),
(136, 1, 1, 14, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/industry-detail.html?healthcare-marketing-services', 'open', '2026-09-09 12:23:00'),
(137, 1, 1, 14, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/industry-detail.html?healthcare-marketing-services', 'open', '2026-09-09 12:23:00'),
(138, 1, 1, 14, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/industry-detail.html?healthcare-marketing-services', 'open', '2026-09-09 12:23:00'),
(139, 1, 1, 26, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'open', '2026-09-09 12:23:00'),
(140, 1, 1, 26, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'open', '2026-09-09 12:23:00'),
(141, 1, 1, 26, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'open', '2026-09-09 12:23:00'),
(142, 1, 1, 26, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'open', '2026-09-09 12:23:00'),
(143, 1, 1, 26, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'open', '2026-09-09 12:23:00'),
(144, 1, 1, 26, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'open', '2026-09-09 12:23:00'),
(145, 1, 1, 26, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'open', '2026-09-09 12:23:00'),
(146, 1, 1, 29, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(147, 1, 1, 29, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(148, 1, 1, 29, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(149, 1, 1, 29, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(150, 1, 1, 29, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(151, 1, 1, 29, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(152, 1, 1, 29, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(153, 1, 1, 3, 'long_description', 'Long meta description', 'low', 'onpage', 'The summary may be truncated.', 'Make the description concise and specific.', 'https://viraladsmedia.com/services.html', 'open', '2026-09-09 12:23:00'),
(154, 1, 1, 3, 'missing_h2', 'No section headings', 'opportunity', 'content', 'Sections improve navigation through longer content.', 'Use descriptive H2 headings where appropriate.', 'https://viraladsmedia.com/services.html', 'open', '2026-09-09 12:23:00'),
(155, 1, 1, 3, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/services.html', 'open', '2026-09-09 12:23:00'),
(156, 1, 1, 3, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/services.html', 'open', '2026-09-09 12:23:00'),
(157, 1, 1, 3, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/services.html', 'open', '2026-09-09 12:23:00'),
(158, 1, 1, 3, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/services.html', 'open', '2026-09-09 12:23:00'),
(159, 1, 1, 3, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/services.html', 'open', '2026-09-09 12:23:00'),
(160, 1, 1, 28, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'open', '2026-09-09 12:23:00'),
(161, 1, 1, 28, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'open', '2026-09-09 12:23:00'),
(162, 1, 1, 28, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'open', '2026-09-09 12:23:00'),
(163, 1, 1, 28, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'open', '2026-09-09 12:23:00'),
(164, 1, 1, 28, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'open', '2026-09-09 12:23:00'),
(165, 1, 1, 28, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'open', '2026-09-09 12:23:00'),
(166, 1, 1, 28, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'open', '2026-09-09 12:23:00'),
(167, 1, 1, 31, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'open', '2026-09-09 12:23:00'),
(168, 1, 1, 31, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'open', '2026-09-09 12:23:00'),
(169, 1, 1, 31, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'open', '2026-09-09 12:23:00'),
(170, 1, 1, 31, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'open', '2026-09-09 12:23:00'),
(171, 1, 1, 31, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'open', '2026-09-09 12:23:00'),
(172, 1, 1, 31, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'open', '2026-09-09 12:23:00'),
(173, 1, 1, 31, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'open', '2026-09-09 12:23:00'),
(174, 1, 1, 30, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'open', '2026-09-09 12:23:00'),
(175, 1, 1, 30, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'open', '2026-09-09 12:23:00'),
(176, 1, 1, 30, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'open', '2026-09-09 12:23:00');
INSERT INTO `seo_issues` (`id`, `website_id`, `audit_id`, `page_id`, `code`, `title`, `severity`, `category`, `explanation`, `recommendation`, `url`, `status`, `created_at`) VALUES
(177, 1, 1, 30, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'open', '2026-09-09 12:23:00'),
(178, 1, 1, 30, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'open', '2026-09-09 12:23:00'),
(179, 1, 1, 30, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'open', '2026-09-09 12:23:00'),
(180, 1, 1, 30, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'open', '2026-09-09 12:23:00'),
(181, 1, 1, 4, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/service.html?best-social-media-agency-in-delhi', 'open', '2026-09-09 12:23:00'),
(182, 1, 1, 4, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/service.html?best-social-media-agency-in-delhi', 'open', '2026-09-09 12:23:00'),
(183, 1, 1, 4, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/service.html?best-social-media-agency-in-delhi', 'open', '2026-09-09 12:23:00'),
(184, 1, 1, 4, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/service.html?best-social-media-agency-in-delhi', 'open', '2026-09-09 12:23:00'),
(185, 1, 1, 4, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/service.html?best-social-media-agency-in-delhi', 'open', '2026-09-09 12:23:00'),
(186, 1, 1, 4, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/service.html?best-social-media-agency-in-delhi', 'open', '2026-09-09 12:23:00'),
(187, 1, 1, 2, 'long_title', 'Long title', 'low', 'onpage', 'Long titles may be truncated.', 'Aim for a concise title around 30–60 characters; display width varies.', 'https://viraladsmedia.com/index.html', 'open', '2026-09-09 12:23:00'),
(188, 1, 1, 2, 'long_description', 'Long meta description', 'low', 'onpage', 'The summary may be truncated.', 'Make the description concise and specific.', 'https://viraladsmedia.com/index.html', 'open', '2026-09-09 12:23:00'),
(189, 1, 1, 2, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/index.html', 'open', '2026-09-09 12:23:00'),
(190, 1, 1, 2, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/index.html', 'open', '2026-09-09 12:23:00'),
(191, 1, 1, 2, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/index.html', 'open', '2026-09-09 12:23:00'),
(192, 1, 1, 2, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/index.html', 'open', '2026-09-09 12:23:00'),
(193, 1, 1, 2, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/index.html', 'open', '2026-09-09 12:23:00'),
(194, 1, 1, 17, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/industry-detail.html?education-marketing-services', 'open', '2026-09-09 12:23:00'),
(195, 1, 1, 17, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/industry-detail.html?education-marketing-services', 'open', '2026-09-09 12:23:00'),
(196, 1, 1, 17, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/industry-detail.html?education-marketing-services', 'open', '2026-09-09 12:23:00'),
(197, 1, 1, 17, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/industry-detail.html?education-marketing-services', 'open', '2026-09-09 12:23:00'),
(198, 1, 1, 17, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/industry-detail.html?education-marketing-services', 'open', '2026-09-09 12:23:00'),
(199, 1, 1, 17, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/industry-detail.html?education-marketing-services', 'open', '2026-09-09 12:23:00'),
(200, 1, 1, 17, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/industry-detail.html?education-marketing-services', 'open', '2026-09-09 12:23:00'),
(201, 1, 1, 16, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/industry-detail.html?real-estate-marketing-services', 'open', '2026-09-09 12:23:00'),
(202, 1, 1, 16, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/industry-detail.html?real-estate-marketing-services', 'open', '2026-09-09 12:23:00'),
(203, 1, 1, 16, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/industry-detail.html?real-estate-marketing-services', 'open', '2026-09-09 12:23:00'),
(204, 1, 1, 16, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/industry-detail.html?real-estate-marketing-services', 'open', '2026-09-09 12:23:00'),
(205, 1, 1, 16, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/industry-detail.html?real-estate-marketing-services', 'open', '2026-09-09 12:23:00'),
(206, 1, 1, 16, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/industry-detail.html?real-estate-marketing-services', 'open', '2026-09-09 12:23:00'),
(207, 1, 1, 16, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/industry-detail.html?real-estate-marketing-services', 'open', '2026-09-09 12:23:00'),
(208, 1, 1, 7, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/service.html?best-performance-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(209, 1, 1, 7, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/service.html?best-performance-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(210, 1, 1, 7, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/service.html?best-performance-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(211, 1, 1, 7, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/service.html?best-performance-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(212, 1, 1, 7, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/service.html?best-performance-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(213, 1, 1, 7, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/service.html?best-performance-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(214, 1, 1, 33, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', 'open', '2026-09-09 12:23:00'),
(215, 1, 1, 21, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/industry-detail.html?cosmetics-marketing-service', 'open', '2026-09-09 12:23:00'),
(216, 1, 1, 5, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/service.html?best-seo-agency-near-me', 'open', '2026-09-09 12:23:00'),
(217, 1, 1, 32, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', 'open', '2026-09-09 12:23:00'),
(218, 1, 1, 20, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/industry-detail.html?appliances-marketing-service', 'open', '2026-09-09 12:23:00'),
(219, 1, 1, 13, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/industry-detail.html?affordable-e-commerce-website-development-services', 'open', '2026-09-09 12:23:00'),
(220, 1, 1, 8, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/service.html?affordable-logo-and-branding-near-me', 'open', '2026-09-09 12:23:00'),
(221, 1, 1, 15, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/industry-detail.html?manufacturing-marketing-services', 'open', '2026-09-09 12:23:00'),
(222, 1, 1, 19, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/industry-detail.html?travel-marketing-services', 'open', '2026-09-09 12:23:00'),
(223, 1, 1, 9, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/service.html?best-influencer-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(224, 1, 1, 10, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/service.html?proffessional-brand-shoots-in-delhi', 'open', '2026-09-09 12:23:00'),
(225, 1, 1, 14, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/industry-detail.html?healthcare-marketing-services', 'open', '2026-09-09 12:23:00'),
(226, 1, 1, 26, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'open', '2026-09-09 12:23:00'),
(227, 1, 1, 29, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(228, 1, 1, 28, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'open', '2026-09-09 12:23:00'),
(229, 1, 1, 31, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'open', '2026-09-09 12:23:00'),
(230, 1, 1, 30, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'open', '2026-09-09 12:23:00'),
(231, 1, 1, 4, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/service.html?best-social-media-agency-in-delhi', 'open', '2026-09-09 12:23:00'),
(232, 1, 1, 2, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/index.html', 'open', '2026-09-09 12:23:00'),
(233, 1, 1, 17, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/industry-detail.html?education-marketing-services', 'open', '2026-09-09 12:23:00'),
(234, 1, 1, 16, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/industry-detail.html?real-estate-marketing-services', 'open', '2026-09-09 12:23:00'),
(235, 1, 1, 7, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/service.html?best-performance-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(236, 1, 1, 33, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', 'open', '2026-09-09 12:23:00'),
(237, 1, 1, 21, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/industry-detail.html?cosmetics-marketing-service', 'open', '2026-09-09 12:23:00'),
(238, 1, 1, 5, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/service.html?best-seo-agency-near-me', 'open', '2026-09-09 12:23:00'),
(239, 1, 1, 32, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', 'open', '2026-09-09 12:23:00'),
(240, 1, 1, 20, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/industry-detail.html?appliances-marketing-service', 'open', '2026-09-09 12:23:00'),
(241, 1, 1, 13, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/industry-detail.html?affordable-e-commerce-website-development-services', 'open', '2026-09-09 12:23:00'),
(242, 1, 1, 8, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/service.html?affordable-logo-and-branding-near-me', 'open', '2026-09-09 12:23:00'),
(243, 1, 1, 15, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/industry-detail.html?manufacturing-marketing-services', 'open', '2026-09-09 12:23:00'),
(244, 1, 1, 19, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/industry-detail.html?travel-marketing-services', 'open', '2026-09-09 12:23:00'),
(245, 1, 1, 9, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/service.html?best-influencer-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(246, 1, 1, 10, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/service.html?proffessional-brand-shoots-in-delhi', 'open', '2026-09-09 12:23:00'),
(247, 1, 1, 14, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/industry-detail.html?healthcare-marketing-services', 'open', '2026-09-09 12:23:00'),
(248, 1, 1, 26, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'open', '2026-09-09 12:23:00'),
(249, 1, 1, 29, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(250, 1, 1, 28, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'open', '2026-09-09 12:23:00'),
(251, 1, 1, 31, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'open', '2026-09-09 12:23:00'),
(252, 1, 1, 30, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'open', '2026-09-09 12:23:00'),
(253, 1, 1, 4, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/service.html?best-social-media-agency-in-delhi', 'open', '2026-09-09 12:23:00'),
(254, 1, 1, 2, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/index.html', 'open', '2026-09-09 12:23:00'),
(255, 1, 1, 17, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/industry-detail.html?education-marketing-services', 'open', '2026-09-09 12:23:00'),
(256, 1, 1, 16, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/industry-detail.html?real-estate-marketing-services', 'open', '2026-09-09 12:23:00'),
(257, 1, 1, 7, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/service.html?best-performance-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(258, 1, 1, 27, 'sitemap', 'Valid sitemap not found at /sitemap.xml', 'medium', 'technical', 'A sitemap helps discover URLs; other sitemap locations were not checked.', 'Publish a valid XML sitemap and declare its location in robots.txt.', 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(259, 1, 1, 27, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(260, 1, 1, 33, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', 'open', '2026-09-09 12:23:00'),
(261, 1, 1, 18, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/industry-detail.html?fashion-marketing-services', 'open', '2026-09-09 12:23:00'),
(262, 1, 1, 21, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/industry-detail.html?cosmetics-marketing-service', 'open', '2026-09-09 12:23:00'),
(263, 1, 1, 6, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/service.html?affordable-web-developer-in-delhi', 'open', '2026-09-09 12:23:00'),
(264, 1, 1, 5, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/service.html?best-seo-agency-near-me', 'open', '2026-09-09 12:23:00'),
(265, 1, 1, 32, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', 'open', '2026-09-09 12:23:00'),
(266, 1, 1, 20, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/industry-detail.html?appliances-marketing-service', 'open', '2026-09-09 12:23:00'),
(267, 1, 1, 13, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/industry-detail.html?affordable-e-commerce-website-development-services', 'open', '2026-09-09 12:23:00'),
(268, 1, 1, 8, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/service.html?affordable-logo-and-branding-near-me', 'open', '2026-09-09 12:23:00'),
(269, 1, 1, 15, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/industry-detail.html?manufacturing-marketing-services', 'open', '2026-09-09 12:23:00'),
(270, 1, 1, 19, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/industry-detail.html?travel-marketing-services', 'open', '2026-09-09 12:23:00'),
(271, 1, 1, 9, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/service.html?best-influencer-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(272, 1, 1, 10, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/service.html?proffessional-brand-shoots-in-delhi', 'open', '2026-09-09 12:23:00'),
(273, 1, 1, 14, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/industry-detail.html?healthcare-marketing-services', 'open', '2026-09-09 12:23:00'),
(274, 1, 1, 26, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'open', '2026-09-09 12:23:00'),
(275, 1, 1, 29, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(276, 1, 1, 28, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'open', '2026-09-09 12:23:00'),
(277, 1, 1, 31, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'open', '2026-09-09 12:23:00'),
(278, 1, 1, 30, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'open', '2026-09-09 12:23:00'),
(279, 1, 1, 4, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/service.html?best-social-media-agency-in-delhi', 'open', '2026-09-09 12:23:00'),
(280, 1, 1, 17, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/industry-detail.html?education-marketing-services', 'open', '2026-09-09 12:23:00'),
(281, 1, 1, 16, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/industry-detail.html?real-estate-marketing-services', 'open', '2026-09-09 12:23:00'),
(282, 1, 1, 7, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/service.html?best-performance-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(283, 1, 1, 27, 'robots', 'No robots.txt rules available', 'opportunity', 'technical', 'No robots rules were returned from the standard location. An absent file allows crawling.', 'Publish robots.txt when you need crawl directives or a sitemap declaration.', 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', 'open', '2026-09-09 12:23:00'),
(284, 1, 2, 60, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', 'open', '2026-09-10 05:36:02'),
(285, 1, 2, 60, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', 'open', '2026-09-10 05:36:02'),
(286, 1, 2, 60, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', 'open', '2026-09-10 05:36:02'),
(287, 1, 2, 60, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', 'open', '2026-09-10 05:36:02'),
(288, 1, 2, 60, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', 'open', '2026-09-10 05:36:02'),
(289, 1, 2, 60, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', 'open', '2026-09-10 05:36:02'),
(290, 1, 2, 60, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', 'open', '2026-09-10 05:36:02'),
(291, 1, 2, 66, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', 'open', '2026-09-10 05:36:02'),
(292, 1, 2, 66, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', 'open', '2026-09-10 05:36:02'),
(293, 1, 2, 66, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', 'open', '2026-09-10 05:36:02'),
(294, 1, 2, 66, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', 'open', '2026-09-10 05:36:02'),
(295, 1, 2, 66, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', 'open', '2026-09-10 05:36:02'),
(296, 1, 2, 66, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', 'open', '2026-09-10 05:36:02'),
(297, 1, 2, 66, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', 'open', '2026-09-10 05:36:02'),
(298, 1, 2, 51, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/industry-detail.html?fashion-marketing-services', 'open', '2026-09-10 05:36:02'),
(299, 1, 2, 51, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/industry-detail.html?fashion-marketing-services', 'open', '2026-09-10 05:36:02'),
(300, 1, 2, 51, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/industry-detail.html?fashion-marketing-services', 'open', '2026-09-10 05:36:02'),
(301, 1, 2, 51, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/industry-detail.html?fashion-marketing-services', 'open', '2026-09-10 05:36:02'),
(302, 1, 2, 51, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/industry-detail.html?fashion-marketing-services', 'open', '2026-09-10 05:36:02'),
(303, 1, 2, 51, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/industry-detail.html?fashion-marketing-services', 'open', '2026-09-10 05:36:02'),
(304, 1, 2, 51, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/industry-detail.html?fashion-marketing-services', 'open', '2026-09-10 05:36:02'),
(305, 1, 2, 54, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/industry-detail.html?cosmetics-marketing-service', 'open', '2026-09-10 05:36:02'),
(306, 1, 2, 54, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/industry-detail.html?cosmetics-marketing-service', 'open', '2026-09-10 05:36:02'),
(307, 1, 2, 54, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/industry-detail.html?cosmetics-marketing-service', 'open', '2026-09-10 05:36:02'),
(308, 1, 2, 54, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/industry-detail.html?cosmetics-marketing-service', 'open', '2026-09-10 05:36:02'),
(309, 1, 2, 54, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/industry-detail.html?cosmetics-marketing-service', 'open', '2026-09-10 05:36:02'),
(310, 1, 2, 54, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/industry-detail.html?cosmetics-marketing-service', 'open', '2026-09-10 05:36:02'),
(311, 1, 2, 54, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/industry-detail.html?cosmetics-marketing-service', 'open', '2026-09-10 05:36:02'),
(312, 1, 2, 44, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/portfolio.html', 'open', '2026-09-10 05:36:02'),
(313, 1, 2, 44, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/portfolio.html', 'open', '2026-09-10 05:36:02'),
(314, 1, 2, 44, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/portfolio.html', 'open', '2026-09-10 05:36:02'),
(315, 1, 2, 44, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/portfolio.html', 'open', '2026-09-10 05:36:02'),
(316, 1, 2, 44, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/portfolio.html', 'open', '2026-09-10 05:36:02'),
(317, 1, 2, 39, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/service.html?affordable-web-developer-in-delhi', 'open', '2026-09-10 05:36:02'),
(318, 1, 2, 39, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/service.html?affordable-web-developer-in-delhi', 'open', '2026-09-10 05:36:02'),
(319, 1, 2, 39, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/service.html?affordable-web-developer-in-delhi', 'open', '2026-09-10 05:36:02'),
(320, 1, 2, 39, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/service.html?affordable-web-developer-in-delhi', 'open', '2026-09-10 05:36:02'),
(321, 1, 2, 39, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/service.html?affordable-web-developer-in-delhi', 'open', '2026-09-10 05:36:02'),
(322, 1, 2, 39, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/service.html?affordable-web-developer-in-delhi', 'open', '2026-09-10 05:36:02'),
(323, 1, 2, 38, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/service.html?best-seo-agency-near-me', 'open', '2026-09-10 05:36:02'),
(324, 1, 2, 38, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/service.html?best-seo-agency-near-me', 'open', '2026-09-10 05:36:02'),
(325, 1, 2, 38, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/service.html?best-seo-agency-near-me', 'open', '2026-09-10 05:36:02'),
(326, 1, 2, 38, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/service.html?best-seo-agency-near-me', 'open', '2026-09-10 05:36:02'),
(327, 1, 2, 38, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/service.html?best-seo-agency-near-me', 'open', '2026-09-10 05:36:02'),
(328, 1, 2, 38, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/service.html?best-seo-agency-near-me', 'open', '2026-09-10 05:36:02'),
(329, 1, 2, 65, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', 'open', '2026-09-10 05:36:02'),
(330, 1, 2, 65, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', 'open', '2026-09-10 05:36:02'),
(331, 1, 2, 65, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', 'open', '2026-09-10 05:36:02'),
(332, 1, 2, 65, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', 'open', '2026-09-10 05:36:02'),
(333, 1, 2, 65, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', 'open', '2026-09-10 05:36:02'),
(334, 1, 2, 65, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', 'open', '2026-09-10 05:36:02'),
(335, 1, 2, 65, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', 'open', '2026-09-10 05:36:02'),
(336, 1, 2, 53, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/industry-detail.html?appliances-marketing-service', 'open', '2026-09-10 05:36:02'),
(337, 1, 2, 53, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/industry-detail.html?appliances-marketing-service', 'open', '2026-09-10 05:36:02'),
(338, 1, 2, 53, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/industry-detail.html?appliances-marketing-service', 'open', '2026-09-10 05:36:02'),
(339, 1, 2, 53, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/industry-detail.html?appliances-marketing-service', 'open', '2026-09-10 05:36:02'),
(340, 1, 2, 53, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/industry-detail.html?appliances-marketing-service', 'open', '2026-09-10 05:36:02'),
(341, 1, 2, 53, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/industry-detail.html?appliances-marketing-service', 'open', '2026-09-10 05:36:02'),
(342, 1, 2, 53, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/industry-detail.html?appliances-marketing-service', 'open', '2026-09-10 05:36:02'),
(343, 1, 2, 45, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/industries.html', 'open', '2026-09-10 05:36:02'),
(344, 1, 2, 45, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/industries.html', 'open', '2026-09-10 05:36:02');
INSERT INTO `seo_issues` (`id`, `website_id`, `audit_id`, `page_id`, `code`, `title`, `severity`, `category`, `explanation`, `recommendation`, `url`, `status`, `created_at`) VALUES
(345, 1, 2, 45, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/industries.html', 'open', '2026-09-10 05:36:02'),
(346, 1, 2, 45, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/industries.html', 'open', '2026-09-10 05:36:02'),
(347, 1, 2, 45, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/industries.html', 'open', '2026-09-10 05:36:02'),
(348, 1, 2, 46, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/industry-detail.html?affordable-e-commerce-website-development-services', 'open', '2026-09-10 05:36:02'),
(349, 1, 2, 46, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/industry-detail.html?affordable-e-commerce-website-development-services', 'open', '2026-09-10 05:36:02'),
(350, 1, 2, 46, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/industry-detail.html?affordable-e-commerce-website-development-services', 'open', '2026-09-10 05:36:02'),
(351, 1, 2, 46, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/industry-detail.html?affordable-e-commerce-website-development-services', 'open', '2026-09-10 05:36:02'),
(352, 1, 2, 46, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/industry-detail.html?affordable-e-commerce-website-development-services', 'open', '2026-09-10 05:36:02'),
(353, 1, 2, 46, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/industry-detail.html?affordable-e-commerce-website-development-services', 'open', '2026-09-10 05:36:02'),
(354, 1, 2, 46, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/industry-detail.html?affordable-e-commerce-website-development-services', 'open', '2026-09-10 05:36:02'),
(355, 1, 2, 41, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/service.html?affordable-logo-and-branding-near-me', 'open', '2026-09-10 05:36:02'),
(356, 1, 2, 41, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/service.html?affordable-logo-and-branding-near-me', 'open', '2026-09-10 05:36:02'),
(357, 1, 2, 41, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/service.html?affordable-logo-and-branding-near-me', 'open', '2026-09-10 05:36:02'),
(358, 1, 2, 41, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/service.html?affordable-logo-and-branding-near-me', 'open', '2026-09-10 05:36:02'),
(359, 1, 2, 41, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/service.html?affordable-logo-and-branding-near-me', 'open', '2026-09-10 05:36:02'),
(360, 1, 2, 41, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/service.html?affordable-logo-and-branding-near-me', 'open', '2026-09-10 05:36:02'),
(361, 1, 2, 56, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/blogs.html', 'open', '2026-09-10 05:36:02'),
(362, 1, 2, 56, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/blogs.html', 'open', '2026-09-10 05:36:02'),
(363, 1, 2, 56, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/blogs.html', 'open', '2026-09-10 05:36:02'),
(364, 1, 2, 56, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/blogs.html', 'open', '2026-09-10 05:36:02'),
(365, 1, 2, 56, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/blogs.html', 'open', '2026-09-10 05:36:02'),
(366, 1, 2, 48, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/industry-detail.html?manufacturing-marketing-services', 'open', '2026-09-10 05:36:02'),
(367, 1, 2, 48, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/industry-detail.html?manufacturing-marketing-services', 'open', '2026-09-10 05:36:02'),
(368, 1, 2, 48, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/industry-detail.html?manufacturing-marketing-services', 'open', '2026-09-10 05:36:02'),
(369, 1, 2, 48, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/industry-detail.html?manufacturing-marketing-services', 'open', '2026-09-10 05:36:02'),
(370, 1, 2, 48, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/industry-detail.html?manufacturing-marketing-services', 'open', '2026-09-10 05:36:02'),
(371, 1, 2, 48, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/industry-detail.html?manufacturing-marketing-services', 'open', '2026-09-10 05:36:02'),
(372, 1, 2, 48, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/industry-detail.html?manufacturing-marketing-services', 'open', '2026-09-10 05:36:02'),
(373, 1, 2, 52, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/industry-detail.html?travel-marketing-services', 'open', '2026-09-10 05:36:02'),
(374, 1, 2, 52, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/industry-detail.html?travel-marketing-services', 'open', '2026-09-10 05:36:02'),
(375, 1, 2, 52, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/industry-detail.html?travel-marketing-services', 'open', '2026-09-10 05:36:02'),
(376, 1, 2, 52, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/industry-detail.html?travel-marketing-services', 'open', '2026-09-10 05:36:02'),
(377, 1, 2, 52, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/industry-detail.html?travel-marketing-services', 'open', '2026-09-10 05:36:02'),
(378, 1, 2, 52, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/industry-detail.html?travel-marketing-services', 'open', '2026-09-10 05:36:02'),
(379, 1, 2, 52, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/industry-detail.html?travel-marketing-services', 'open', '2026-09-10 05:36:02'),
(380, 1, 2, 42, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/service.html?best-influencer-marketing-in-delhi', 'open', '2026-09-10 05:36:02'),
(381, 1, 2, 42, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/service.html?best-influencer-marketing-in-delhi', 'open', '2026-09-10 05:36:02'),
(382, 1, 2, 42, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/service.html?best-influencer-marketing-in-delhi', 'open', '2026-09-10 05:36:02'),
(383, 1, 2, 42, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/service.html?best-influencer-marketing-in-delhi', 'open', '2026-09-10 05:36:02'),
(384, 1, 2, 42, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/service.html?best-influencer-marketing-in-delhi', 'open', '2026-09-10 05:36:02'),
(385, 1, 2, 42, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/service.html?best-influencer-marketing-in-delhi', 'open', '2026-09-10 05:36:02'),
(386, 1, 2, 57, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/career.html', 'open', '2026-09-10 05:36:02'),
(387, 1, 2, 57, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/career.html', 'open', '2026-09-10 05:36:02'),
(388, 1, 2, 57, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/career.html', 'open', '2026-09-10 05:36:02'),
(389, 1, 2, 57, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/career.html', 'open', '2026-09-10 05:36:02'),
(390, 1, 2, 34, 'long_title', 'Long title', 'low', 'onpage', 'Long titles may be truncated.', 'Aim for a concise title around 30–60 characters; display width varies.', 'https://viraladsmedia.com/', 'open', '2026-09-10 05:36:02'),
(391, 1, 2, 34, 'long_description', 'Long meta description', 'low', 'onpage', 'The summary may be truncated.', 'Make the description concise and specific.', 'https://viraladsmedia.com/', 'open', '2026-09-10 05:36:02'),
(392, 1, 2, 34, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/', 'open', '2026-09-10 05:36:02'),
(393, 1, 2, 34, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/', 'open', '2026-09-10 05:36:02'),
(394, 1, 2, 34, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/', 'open', '2026-09-10 05:36:02'),
(395, 1, 2, 34, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/', 'open', '2026-09-10 05:36:02'),
(396, 1, 2, 34, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/', 'open', '2026-09-10 05:36:02'),
(397, 1, 2, 43, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/service.html?proffessional-brand-shoots-in-delhi', 'open', '2026-09-10 05:36:02'),
(398, 1, 2, 43, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/service.html?proffessional-brand-shoots-in-delhi', 'open', '2026-09-10 05:36:02'),
(399, 1, 2, 43, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/service.html?proffessional-brand-shoots-in-delhi', 'open', '2026-09-10 05:36:02'),
(400, 1, 2, 43, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/service.html?proffessional-brand-shoots-in-delhi', 'open', '2026-09-10 05:36:02'),
(401, 1, 2, 43, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/service.html?proffessional-brand-shoots-in-delhi', 'open', '2026-09-10 05:36:02'),
(402, 1, 2, 43, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/service.html?proffessional-brand-shoots-in-delhi', 'open', '2026-09-10 05:36:02'),
(403, 1, 2, 55, 'long_description', 'Long meta description', 'low', 'onpage', 'The summary may be truncated.', 'Make the description concise and specific.', 'https://viraladsmedia.com/about.html', 'open', '2026-09-10 05:36:02'),
(404, 1, 2, 55, 'missing_h1', 'Missing H1', 'high', 'onpage', 'A main heading helps readers understand the page.', 'Add one clear main heading.', 'https://viraladsmedia.com/about.html', 'open', '2026-09-10 05:36:02'),
(405, 1, 2, 55, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/about.html', 'open', '2026-09-10 05:36:02'),
(406, 1, 2, 55, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/about.html', 'open', '2026-09-10 05:36:02'),
(407, 1, 2, 55, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/about.html', 'open', '2026-09-10 05:36:02'),
(408, 1, 2, 55, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/about.html', 'open', '2026-09-10 05:36:02'),
(409, 1, 2, 55, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/about.html', 'open', '2026-09-10 05:36:02'),
(410, 1, 2, 55, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/about.html', 'open', '2026-09-10 05:36:02'),
(411, 1, 2, 58, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/contact.html', 'open', '2026-09-10 05:36:02'),
(412, 1, 2, 58, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/contact.html', 'open', '2026-09-10 05:36:02'),
(413, 1, 2, 58, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/contact.html', 'open', '2026-09-10 05:36:02'),
(414, 1, 2, 58, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/contact.html', 'open', '2026-09-10 05:36:02'),
(415, 1, 2, 47, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/industry-detail.html?healthcare-marketing-services', 'open', '2026-09-10 05:36:02'),
(416, 1, 2, 47, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/industry-detail.html?healthcare-marketing-services', 'open', '2026-09-10 05:36:02'),
(417, 1, 2, 47, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/industry-detail.html?healthcare-marketing-services', 'open', '2026-09-10 05:36:02'),
(418, 1, 2, 47, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/industry-detail.html?healthcare-marketing-services', 'open', '2026-09-10 05:36:02'),
(419, 1, 2, 47, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/industry-detail.html?healthcare-marketing-services', 'open', '2026-09-10 05:36:02'),
(420, 1, 2, 47, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/industry-detail.html?healthcare-marketing-services', 'open', '2026-09-10 05:36:02'),
(421, 1, 2, 47, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/industry-detail.html?healthcare-marketing-services', 'open', '2026-09-10 05:36:02'),
(422, 1, 2, 59, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'open', '2026-09-10 05:36:02'),
(423, 1, 2, 59, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'open', '2026-09-10 05:36:02'),
(424, 1, 2, 59, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'open', '2026-09-10 05:36:02'),
(425, 1, 2, 59, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'open', '2026-09-10 05:36:02'),
(426, 1, 2, 59, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'open', '2026-09-10 05:36:02'),
(427, 1, 2, 59, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'open', '2026-09-10 05:36:02'),
(428, 1, 2, 59, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'open', '2026-09-10 05:36:02'),
(429, 1, 2, 62, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'open', '2026-09-10 05:36:02'),
(430, 1, 2, 62, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'open', '2026-09-10 05:36:02'),
(431, 1, 2, 62, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'open', '2026-09-10 05:36:02'),
(432, 1, 2, 62, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'open', '2026-09-10 05:36:02'),
(433, 1, 2, 62, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'open', '2026-09-10 05:36:02'),
(434, 1, 2, 62, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'open', '2026-09-10 05:36:02'),
(435, 1, 2, 62, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'open', '2026-09-10 05:36:02'),
(436, 1, 2, 36, 'long_description', 'Long meta description', 'low', 'onpage', 'The summary may be truncated.', 'Make the description concise and specific.', 'https://viraladsmedia.com/services.html', 'open', '2026-09-10 05:36:02'),
(437, 1, 2, 36, 'missing_h2', 'No section headings', 'opportunity', 'content', 'Sections improve navigation through longer content.', 'Use descriptive H2 headings where appropriate.', 'https://viraladsmedia.com/services.html', 'open', '2026-09-10 05:36:02'),
(438, 1, 2, 36, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/services.html', 'open', '2026-09-10 05:36:02'),
(439, 1, 2, 36, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/services.html', 'open', '2026-09-10 05:36:02'),
(440, 1, 2, 36, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/services.html', 'open', '2026-09-10 05:36:02'),
(441, 1, 2, 36, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/services.html', 'open', '2026-09-10 05:36:02'),
(442, 1, 2, 36, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/services.html', 'open', '2026-09-10 05:36:02'),
(443, 1, 2, 61, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'open', '2026-09-10 05:36:02'),
(444, 1, 2, 61, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'open', '2026-09-10 05:36:02'),
(445, 1, 2, 61, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'open', '2026-09-10 05:36:02'),
(446, 1, 2, 61, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'open', '2026-09-10 05:36:02'),
(447, 1, 2, 61, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'open', '2026-09-10 05:36:02'),
(448, 1, 2, 61, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'open', '2026-09-10 05:36:02'),
(449, 1, 2, 61, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'open', '2026-09-10 05:36:02'),
(450, 1, 2, 64, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'open', '2026-09-10 05:36:02'),
(451, 1, 2, 64, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'open', '2026-09-10 05:36:02'),
(452, 1, 2, 64, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'open', '2026-09-10 05:36:02'),
(453, 1, 2, 64, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'open', '2026-09-10 05:36:02'),
(454, 1, 2, 64, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'open', '2026-09-10 05:36:02'),
(455, 1, 2, 64, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'open', '2026-09-10 05:36:02'),
(456, 1, 2, 64, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'open', '2026-09-10 05:36:02'),
(457, 1, 2, 63, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'open', '2026-09-10 05:36:02'),
(458, 1, 2, 63, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'open', '2026-09-10 05:36:02'),
(459, 1, 2, 63, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'open', '2026-09-10 05:36:02'),
(460, 1, 2, 63, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'open', '2026-09-10 05:36:02'),
(461, 1, 2, 63, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'open', '2026-09-10 05:36:02'),
(462, 1, 2, 63, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'open', '2026-09-10 05:36:02'),
(463, 1, 2, 63, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'open', '2026-09-10 05:36:02'),
(464, 1, 2, 37, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/service.html?best-social-media-agency-in-delhi', 'open', '2026-09-10 05:36:02'),
(465, 1, 2, 37, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/service.html?best-social-media-agency-in-delhi', 'open', '2026-09-10 05:36:02'),
(466, 1, 2, 37, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/service.html?best-social-media-agency-in-delhi', 'open', '2026-09-10 05:36:02'),
(467, 1, 2, 37, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/service.html?best-social-media-agency-in-delhi', 'open', '2026-09-10 05:36:02'),
(468, 1, 2, 37, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/service.html?best-social-media-agency-in-delhi', 'open', '2026-09-10 05:36:02'),
(469, 1, 2, 37, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/service.html?best-social-media-agency-in-delhi', 'open', '2026-09-10 05:36:02'),
(470, 1, 2, 35, 'long_title', 'Long title', 'low', 'onpage', 'Long titles may be truncated.', 'Aim for a concise title around 30–60 characters; display width varies.', 'https://viraladsmedia.com/index.html', 'open', '2026-09-10 05:36:02'),
(471, 1, 2, 35, 'long_description', 'Long meta description', 'low', 'onpage', 'The summary may be truncated.', 'Make the description concise and specific.', 'https://viraladsmedia.com/index.html', 'open', '2026-09-10 05:36:02'),
(472, 1, 2, 35, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/index.html', 'open', '2026-09-10 05:36:02'),
(473, 1, 2, 35, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/index.html', 'open', '2026-09-10 05:36:02'),
(474, 1, 2, 35, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/index.html', 'open', '2026-09-10 05:36:02'),
(475, 1, 2, 35, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/index.html', 'open', '2026-09-10 05:36:02'),
(476, 1, 2, 35, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/index.html', 'open', '2026-09-10 05:36:02'),
(477, 1, 2, 50, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/industry-detail.html?education-marketing-services', 'open', '2026-09-10 05:36:02'),
(478, 1, 2, 50, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/industry-detail.html?education-marketing-services', 'open', '2026-09-10 05:36:02'),
(479, 1, 2, 50, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/industry-detail.html?education-marketing-services', 'open', '2026-09-10 05:36:02'),
(480, 1, 2, 50, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/industry-detail.html?education-marketing-services', 'open', '2026-09-10 05:36:02'),
(481, 1, 2, 50, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/industry-detail.html?education-marketing-services', 'open', '2026-09-10 05:36:02'),
(482, 1, 2, 50, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/industry-detail.html?education-marketing-services', 'open', '2026-09-10 05:36:02'),
(483, 1, 2, 50, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/industry-detail.html?education-marketing-services', 'open', '2026-09-10 05:36:02'),
(484, 1, 2, 49, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/industry-detail.html?real-estate-marketing-services', 'open', '2026-09-10 05:36:02'),
(485, 1, 2, 49, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/industry-detail.html?real-estate-marketing-services', 'open', '2026-09-10 05:36:02'),
(486, 1, 2, 49, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/industry-detail.html?real-estate-marketing-services', 'open', '2026-09-10 05:36:02'),
(487, 1, 2, 49, 'missing_alt', 'Images missing descriptive alt text', 'medium', 'onpage', 'Alternative text helps accessibility and image understanding.', 'Describe informative images; keep decorative image alt empty.', 'https://viraladsmedia.com/industry-detail.html?real-estate-marketing-services', 'open', '2026-09-10 05:36:02'),
(488, 1, 2, 49, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/industry-detail.html?real-estate-marketing-services', 'open', '2026-09-10 05:36:02'),
(489, 1, 2, 49, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/industry-detail.html?real-estate-marketing-services', 'open', '2026-09-10 05:36:02'),
(490, 1, 2, 49, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/industry-detail.html?real-estate-marketing-services', 'open', '2026-09-10 05:36:02'),
(491, 1, 2, 40, 'multiple_h1', 'Multiple H1 headings', 'low', 'onpage', 'The main topic may be unclear.', 'Review the heading hierarchy.', 'https://viraladsmedia.com/service.html?best-performance-marketing-in-delhi', 'open', '2026-09-10 05:36:02'),
(492, 1, 2, 40, 'thin_content', 'Low word count', 'medium', 'content', 'Limited copy may not satisfy intent; some page types need little text.', 'Review whether the content fully answers the visitor’s question.', 'https://viraladsmedia.com/service.html?best-performance-marketing-in-delhi', 'open', '2026-09-10 05:36:02'),
(493, 1, 2, 40, 'missing_canonical', 'Canonical not declared', 'medium', 'technical', 'Canonical hints help consolidate equivalent URLs.', 'Declare the preferred indexable URL.', 'https://viraladsmedia.com/service.html?best-performance-marketing-in-delhi', 'open', '2026-09-10 05:36:02'),
(494, 1, 2, 40, 'open_graph', 'Open Graph tags missing', 'opportunity', 'onpage', 'Shared links may have less useful previews.', 'Add og:title, og:description and og:image.', 'https://viraladsmedia.com/service.html?best-performance-marketing-in-delhi', 'open', '2026-09-10 05:36:02'),
(495, 1, 2, 40, 'twitter', 'Twitter card metadata missing', 'opportunity', 'onpage', 'Social previews may be incomplete.', 'Add appropriate card metadata.', 'https://viraladsmedia.com/service.html?best-performance-marketing-in-delhi', 'open', '2026-09-10 05:36:02'),
(496, 1, 2, 40, 'schema', 'No JSON-LD detected', 'opportunity', 'onpage', 'Structured data can explain eligible page entities.', 'Add relevant, valid schema; rich results are not guaranteed.', 'https://viraladsmedia.com/service.html?best-performance-marketing-in-delhi', 'open', '2026-09-10 05:36:02'),
(497, 1, 2, 66, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', 'open', '2026-09-10 05:36:02'),
(498, 1, 2, 54, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/industry-detail.html?cosmetics-marketing-service', 'open', '2026-09-10 05:36:02'),
(499, 1, 2, 38, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/service.html?best-seo-agency-near-me', 'open', '2026-09-10 05:36:02'),
(500, 1, 2, 65, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', 'open', '2026-09-10 05:36:02'),
(501, 1, 2, 53, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/industry-detail.html?appliances-marketing-service', 'open', '2026-09-10 05:36:02'),
(502, 1, 2, 46, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/industry-detail.html?affordable-e-commerce-website-development-services', 'open', '2026-09-10 05:36:02'),
(503, 1, 2, 41, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/service.html?affordable-logo-and-branding-near-me', 'open', '2026-09-10 05:36:02'),
(504, 1, 2, 48, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/industry-detail.html?manufacturing-marketing-services', 'open', '2026-09-10 05:36:02'),
(505, 1, 2, 52, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/industry-detail.html?travel-marketing-services', 'open', '2026-09-10 05:36:02'),
(506, 1, 2, 42, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/service.html?best-influencer-marketing-in-delhi', 'open', '2026-09-10 05:36:02'),
(507, 1, 2, 43, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/service.html?proffessional-brand-shoots-in-delhi', 'open', '2026-09-10 05:36:02'),
(508, 1, 2, 47, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/industry-detail.html?healthcare-marketing-services', 'open', '2026-09-10 05:36:02'),
(509, 1, 2, 59, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'open', '2026-09-10 05:36:02'),
(510, 1, 2, 62, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'open', '2026-09-10 05:36:02'),
(511, 1, 2, 61, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'open', '2026-09-10 05:36:02'),
(512, 1, 2, 64, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'open', '2026-09-10 05:36:02'),
(513, 1, 2, 63, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'open', '2026-09-10 05:36:02'),
(514, 1, 2, 37, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/service.html?best-social-media-agency-in-delhi', 'open', '2026-09-10 05:36:02'),
(515, 1, 2, 35, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/index.html', 'open', '2026-09-10 05:36:02'),
(516, 1, 2, 50, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/industry-detail.html?education-marketing-services', 'open', '2026-09-10 05:36:02'),
(517, 1, 2, 49, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/industry-detail.html?real-estate-marketing-services', 'open', '2026-09-10 05:36:02'),
(518, 1, 2, 40, 'duplicate_title', 'Duplicate title', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/service.html?best-performance-marketing-in-delhi', 'open', '2026-09-10 05:36:02'),
(519, 1, 2, 66, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', 'open', '2026-09-10 05:36:02'),
(520, 1, 2, 54, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/industry-detail.html?cosmetics-marketing-service', 'open', '2026-09-10 05:36:02'),
(521, 1, 2, 38, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/service.html?best-seo-agency-near-me', 'open', '2026-09-10 05:36:02');
INSERT INTO `seo_issues` (`id`, `website_id`, `audit_id`, `page_id`, `code`, `title`, `severity`, `category`, `explanation`, `recommendation`, `url`, `status`, `created_at`) VALUES
(522, 1, 2, 65, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', 'open', '2026-09-10 05:36:02'),
(523, 1, 2, 53, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/industry-detail.html?appliances-marketing-service', 'open', '2026-09-10 05:36:02'),
(524, 1, 2, 46, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/industry-detail.html?affordable-e-commerce-website-development-services', 'open', '2026-09-10 05:36:02'),
(525, 1, 2, 41, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/service.html?affordable-logo-and-branding-near-me', 'open', '2026-09-10 05:36:02'),
(526, 1, 2, 48, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/industry-detail.html?manufacturing-marketing-services', 'open', '2026-09-10 05:36:02'),
(527, 1, 2, 52, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/industry-detail.html?travel-marketing-services', 'open', '2026-09-10 05:36:02'),
(528, 1, 2, 42, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/service.html?best-influencer-marketing-in-delhi', 'open', '2026-09-10 05:36:02'),
(529, 1, 2, 43, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/service.html?proffessional-brand-shoots-in-delhi', 'open', '2026-09-10 05:36:02'),
(530, 1, 2, 47, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/industry-detail.html?healthcare-marketing-services', 'open', '2026-09-10 05:36:02'),
(531, 1, 2, 59, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'open', '2026-09-10 05:36:02'),
(532, 1, 2, 62, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'open', '2026-09-10 05:36:02'),
(533, 1, 2, 61, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'open', '2026-09-10 05:36:02'),
(534, 1, 2, 64, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'open', '2026-09-10 05:36:02'),
(535, 1, 2, 63, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'open', '2026-09-10 05:36:02'),
(536, 1, 2, 37, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/service.html?best-social-media-agency-in-delhi', 'open', '2026-09-10 05:36:02'),
(537, 1, 2, 35, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/index.html', 'open', '2026-09-10 05:36:02'),
(538, 1, 2, 50, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/industry-detail.html?education-marketing-services', 'open', '2026-09-10 05:36:02'),
(539, 1, 2, 49, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/industry-detail.html?real-estate-marketing-services', 'open', '2026-09-10 05:36:02'),
(540, 1, 2, 40, 'duplicate_description', 'Duplicate description', 'medium', 'onpage', 'Identical metadata may obscure page differences.', 'Write distinct metadata for unique pages.', 'https://viraladsmedia.com/service.html?best-performance-marketing-in-delhi', 'open', '2026-09-10 05:36:02'),
(541, 1, 2, 60, 'sitemap', 'Valid sitemap not found at /sitemap.xml', 'medium', 'technical', 'A sitemap helps discover URLs; other sitemap locations were not checked.', 'Publish a valid XML sitemap and declare its location in robots.txt.', 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', 'open', '2026-09-10 05:36:02'),
(542, 1, 2, 60, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', 'open', '2026-09-10 05:36:02'),
(543, 1, 2, 66, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/category-records.html?best-social-media-agency-in-delhi', 'open', '2026-09-10 05:36:02'),
(544, 1, 2, 51, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/industry-detail.html?fashion-marketing-services', 'open', '2026-09-10 05:36:02'),
(545, 1, 2, 54, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/industry-detail.html?cosmetics-marketing-service', 'open', '2026-09-10 05:36:02'),
(546, 1, 2, 39, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/service.html?affordable-web-developer-in-delhi', 'open', '2026-09-10 05:36:02'),
(547, 1, 2, 38, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/service.html?best-seo-agency-near-me', 'open', '2026-09-10 05:36:02'),
(548, 1, 2, 65, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/category-records.html?proffessional-video-editor-in-delhi', 'open', '2026-09-10 05:36:02'),
(549, 1, 2, 53, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/industry-detail.html?appliances-marketing-service', 'open', '2026-09-10 05:36:02'),
(550, 1, 2, 46, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/industry-detail.html?affordable-e-commerce-website-development-services', 'open', '2026-09-10 05:36:02'),
(551, 1, 2, 41, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/service.html?affordable-logo-and-branding-near-me', 'open', '2026-09-10 05:36:02'),
(552, 1, 2, 48, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/industry-detail.html?manufacturing-marketing-services', 'open', '2026-09-10 05:36:02'),
(553, 1, 2, 52, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/industry-detail.html?travel-marketing-services', 'open', '2026-09-10 05:36:02'),
(554, 1, 2, 42, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/service.html?best-influencer-marketing-in-delhi', 'open', '2026-09-10 05:36:02'),
(555, 1, 2, 43, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/service.html?proffessional-brand-shoots-in-delhi', 'open', '2026-09-10 05:36:02'),
(556, 1, 2, 47, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/industry-detail.html?healthcare-marketing-services', 'open', '2026-09-10 05:36:02'),
(557, 1, 2, 59, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/category-records.html?affordable-web-developer-in-delhi', 'open', '2026-09-10 05:36:02'),
(558, 1, 2, 62, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/category-records.html?best-influencer-marketing-in-delhi', 'open', '2026-09-10 05:36:02'),
(559, 1, 2, 61, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/category-records.html?affordable-logo-and-branding-near-me', 'open', '2026-09-10 05:36:02'),
(560, 1, 2, 64, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/category-records.html?affordable-ads-campaign-agency-in-delhi-NCR', 'open', '2026-09-10 05:36:02'),
(561, 1, 2, 63, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/category-records.html?best-seo-agency-near-me', 'open', '2026-09-10 05:36:02'),
(562, 1, 2, 37, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/service.html?best-social-media-agency-in-delhi', 'open', '2026-09-10 05:36:02'),
(563, 1, 2, 50, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/industry-detail.html?education-marketing-services', 'open', '2026-09-10 05:36:02'),
(564, 1, 2, 49, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/industry-detail.html?real-estate-marketing-services', 'open', '2026-09-10 05:36:02'),
(565, 1, 2, 40, 'url_structure', 'Review URL structure', 'opportunity', 'technical', 'Parameters or inconsistent URL naming can create duplicate variants.', 'Prefer stable, descriptive URLs; do not change URLs without a redirect plan.', 'https://viraladsmedia.com/service.html?best-performance-marketing-in-delhi', 'open', '2026-09-10 05:36:02'),
(566, 1, 2, 60, 'robots', 'No robots.txt rules available', 'opportunity', 'technical', 'No robots rules were returned from the standard location. An absent file allows crawling.', 'Publish robots.txt when you need crawl directives or a sitemap declaration.', 'https://viraladsmedia.com/category-records.html?best-performance-marketing-in-delhi', 'open', '2026-09-10 05:36:02');

-- --------------------------------------------------------

--
-- Table structure for table `seo_issue_types`
--

CREATE TABLE `seo_issue_types` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(80) NOT NULL,
  `title` varchar(190) NOT NULL,
  `severity` varchar(30) NOT NULL,
  `explanation` text DEFAULT NULL,
  `recommendation` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `seo_tasks`
--

CREATE TABLE `seo_tasks` (
  `id` int(10) UNSIGNED NOT NULL,
  `website_id` int(10) UNSIGNED NOT NULL,
  `title` varchar(190) NOT NULL,
  `url` text DEFAULT NULL,
  `issue_id` bigint(20) UNSIGNED DEFAULT NULL,
  `priority` enum('critical','high','medium','low') DEFAULT 'medium',
  `assigned_user` int(10) UNSIGNED DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `status` enum('open','in_progress','waiting','completed','rejected') DEFAULT 'open',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `name` varchar(100) NOT NULL,
  `value` mediumtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`name`, `value`) VALUES
('ai_pack_credits', '100'),
('ai_pack_price', '49900'),
('crawl_delay_ms', '1000'),
('grace_days', '0'),
('maintenance', 'false'),
('migration_002', 'true'),
('migration_003', 'true'),
('migration_004', 'true'),
('migration_005', 'true'),
('migration_006', 'true'),
('ranking_frequency_hours', '24'),
('registration', 'true'),
('report_frequency_days', '30'),
('require_verification', 'false'),
('score_weights', '{\"technical\":30,\"onpage\":30,\"content\":20,\"performance\":10,\"linking\":10}'),
('site_name', '\"SEO AutoPilot\"'),
('trial_days', '0'),
('trial_plan_id', '2');

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions`
--

CREATE TABLE `subscriptions` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `plan_id` int(10) UNSIGNED NOT NULL,
  `status` enum('active','cancelled','expired') DEFAULT 'active',
  `starts_at` datetime NOT NULL,
  `ends_at` datetime DEFAULT NULL,
  `cancelled_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_trial` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subscriptions`
--

INSERT INTO `subscriptions` (`id`, `user_id`, `plan_id`, `status`, `starts_at`, `ends_at`, `cancelled_at`, `created_at`, `is_trial`) VALUES
(1, 2, 1, 'active', '2026-09-09 17:43:07', NULL, NULL, '2026-09-09 12:13:07', 0);

-- --------------------------------------------------------

--
-- Table structure for table `system_logs`
--

CREATE TABLE `system_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `level` varchar(20) NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `team_members`
--

CREATE TABLE `team_members` (
  `id` int(10) UNSIGNED NOT NULL,
  `owner_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `website_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `email` varchar(190) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('super_admin','admin','team_member','customer') NOT NULL DEFAULT 'customer',
  `company` varchar(190) DEFAULT '',
  `phone` varchar(40) DEFAULT '',
  `timezone` varchar(60) DEFAULT 'UTC',
  `country` varchar(80) DEFAULT '',
  `active` tinyint(4) NOT NULL DEFAULT 1,
  `verified_at` datetime DEFAULT NULL,
  `notification_email` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `session_version` int(10) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`, `company`, `phone`, `timezone`, `country`, `active`, `verified_at`, `notification_email`, `created_at`, `session_version`) VALUES
(2, 'Rj Developer', 'rj9work@gmail.com', '$2y$10$FSfMaN8hHl/l2.CztPitFuvfgdBXyIcIbUXTdmPsQOtpN4T/gtZcy', 'super_admin', '', '', 'UTC', '', 1, NULL, 1, '2026-09-09 12:13:07', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_roles`
--

INSERT INTO `user_roles` (`user_id`, `role_id`) VALUES
(2, 4);

-- --------------------------------------------------------

--
-- Table structure for table `websites`
--

CREATE TABLE `websites` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(120) NOT NULL,
  `domain` varchar(500) NOT NULL,
  `domain_hash` char(64) NOT NULL,
  `country` varchar(80) DEFAULT 'India',
  `language` varchar(40) DEFAULT 'en',
  `search_engine` varchar(30) DEFAULT 'google',
  `timezone` varchar(60) DEFAULT 'UTC',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `websites`
--

INSERT INTO `websites` (`id`, `user_id`, `name`, `domain`, `domain_hash`, `country`, `language`, `search_engine`, `timezone`, `created_at`) VALUES
(1, 2, 'Viral Ads Media', 'https://viraladsmedia.com/', 'dff16fa4c24f361b86ac5982ac7539c666f374a740e85072b6c57fc240651148', 'India', 'en', 'google', 'Asia/Kolkata', '2026-09-09 12:13:47');

-- --------------------------------------------------------

--
-- Table structure for table `website_settings`
--

CREATE TABLE `website_settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `website_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(80) NOT NULL,
  `value` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `website_settings`
--

INSERT INTO `website_settings` (`id`, `website_id`, `name`, `value`) VALUES
(1, 1, 'keyword_research', '{\"key\":\"4bffce52a10c5e53e99869c71ad2d6b3b3b56fc7a584a19d4e528bd954516508\",\"seed\":\"digital marketing agency in Delhi\",\"date\":\"2026-09-12\",\"checked_at\":\"2026-09-12 06:34:11\",\"country\":\"India\",\"language\":\"en\",\"source\":\"HasData Google SERP\",\"corrected\":\"\",\"ideas\":[{\"keyword\":\"digital marketing agency in Delhi\",\"type\":\"Seed keyword\"},{\"keyword\":\"Top 10 digital marketing agency in delhi\",\"type\":\"Related Google search\"},{\"keyword\":\"Top digital marketing agency in delhi\",\"type\":\"Related Google search\"},{\"keyword\":\"Top 5 digital marketing agency in delhi\",\"type\":\"Related Google search\"},{\"keyword\":\"Digital Marketing agency in Delhi for internship\",\"type\":\"Related Google search\"},{\"keyword\":\"Digital marketing agency in Gurgaon\",\"type\":\"Related Google search\"},{\"keyword\":\"Digital marketing agency in Delhi Instagram\",\"type\":\"Related Google search\"},{\"keyword\":\"Digital marketing agency in Noida\",\"type\":\"Related Google search\"},{\"keyword\":\"Best marketing agency in Delhi\",\"type\":\"Related Google search\"},{\"keyword\":\"Which is the best digital marketing agency in Delhi?\",\"type\":\"People also ask\"},{\"keyword\":\"How much does digital marketing cost in Delhi?\",\"type\":\"People also ask\"},{\"keyword\":\"How much does it cost to hire a digital marketing agency in India?\",\"type\":\"People also ask\"},{\"keyword\":\"Which agency is best for digital marketing?\",\"type\":\"People also ask\"}],\"organic\":[{\"position\":1,\"title\":\"WeBeeSocial | Creative Digital Marketing Agency in New ...\",\"url\":\"https:\\/\\/webeesocial.com\\/\",\"snippet\":\"We\'re an award-winning digital marketing & Social Media agency in New Delhi India. We offer 360°digital solutions that enrich your online presence.\"},{\"position\":2,\"title\":\"Delhi Digital Co. | 360° Marketing Agency (@delhidigitalco)\",\"url\":\"https:\\/\\/www.instagram.com\\/delhidigitalco\\/?hl=en\",\"snippet\":\"E-commerce, Performance Marketing, Visual Design,Social Media,Photography … contact us on 9205110208— Contact: 9205110208. Our Services: marketing, website ...\"},{\"position\":3,\"title\":\"Digital Ultras: Digital Marketing Agency in Delhi\",\"url\":\"https:\\/\\/digitalultras.com\\/\",\"snippet\":\"Digital Ultras is a trusted Digital Marketing Agency in delhi helping businesses grow through SEO, Google Ads, Meta Ads, and a premier Social Media Marketing ...\"},{\"position\":4,\"title\":\"15 Best Digital Marketing Agencies in Delhi NCR in 2026\",\"url\":\"https:\\/\\/www.fruitbowldigital.com\\/blog\\/digital-marketing-agencies-in-delhi\\/\",\"snippet\":\"Agencies like Fruitbowl Digital, Webchutney, iProspect, Techmagnate, and PageTraffic are known for blending strategy with execution to deliver ...Read more\"},{\"position\":5,\"title\":\"Partner with the Best Digital Marketing Agency in Delhi\",\"url\":\"https:\\/\\/www.techmagnate.com\\/india\\/delhi-ncr\\/digital-marketing-company-delhi.html\",\"snippet\":\"As a leading digital marketing agency in Delhi, Techmagnate specializes in SEO, PPC, content marketing, and full-spectrum digital solutions tailored for Delhi- ...Read more\"},{\"position\":6,\"title\":\"The Best Digital Marketing Companies in Delhi - Sep 2026\",\"url\":\"https:\\/\\/themanifest.com\\/in\\/digital-marketing\\/agencies\\/delhi\",\"snippet\":\"Highly reviewed Digital Marketing companies in Delhi include PageTraffic, Incrementors, Studio Mosaic, Gigde Global Solutions Private Limited, We4Digital, ...\"},{\"position\":7,\"title\":\"Best Digital Marketing Companies in Delhi NCR 2026\",\"url\":\"https:\\/\\/www.roihunt.in\\/best-digital-marketing-companies-in-delhi-ncr-2026\\/\",\"snippet\":\"Top 20 Digital Marketing Companies in Delhi NCR · 1. ROI Hunt · 2. Honcho Metrics · 3. Socio Labs · 4. Innovative Digital Marketing · 5. Vibes Communication · 6 ...Read more\"},{\"position\":8,\"title\":\"Best Digital Marketing Agency in Delhi | Digital Marketing ...\",\"url\":\"https:\\/\\/hovodigital.com\\/\",\"snippet\":\"HOVO Digital is the best digital marketing agency\\/company in Delhi NCR. We provide the digital marketing services like SEO, SMO, PPC, Social Media, ...\"},{\"position\":9,\"title\":\"Top 10 Digital Marketing Agencies in Delhi 2025\",\"url\":\"https:\\/\\/www.linkedin.com\\/pulse\\/top-10-digital-marketing-agencies-delhi-2025-treasure-creatives-nrgtc\",\"snippet\":\"Pulp Strategy is a certified Digital marketing agency. Some of their services include strategy creation, social media management, website design ...Read more\"}]}'),
(2, 1, 'backlink_discovery', '{\"date\":\"2026-09-12\",\"domain\":\"https:\\/\\/viraladsmedia.com\\/\",\"candidates\":[{\"position\":1,\"title\":\"Viral Ads Media- Leading Digital Marketing Agency in ...\",\"url\":\"https:\\/\\/in.linkedin.com\\/company\\/viraladsmedia\",\"snippet\":\"Contact: +91 9354491934 hr@viraladsmedia.com www.viraladsmedia.com Join us and be a part of a creative journey where ideas turn into powerful stories.Read more\"},{\"position\":2,\"title\":\"Viral Ads Media | New Delhi\",\"url\":\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/\",\"snippet\":\"Contact: +91 9354491934 hr@viraladsmedia.com www.viraladsmedia.com Join us and be a part of a creative journey where ideas turn into powerful stories.Read more\"},{\"position\":3,\"title\":\"Viral Ads Media Company Profile & Overview\",\"url\":\"https:\\/\\/internshala.com\\/company\\/viral-ads-media-1734521261\\/\",\"snippet\":\"About Viral Ads Media. http:\\/\\/viraladsmedia.com. A Complete digital marketing agency.Empower your brand with our digital marketing and website development ...\"},{\"position\":4,\"title\":\"Viral Ads Media (@viraladsmedia_) · Delhi\",\"url\":\"https:\\/\\/www.instagram.com\\/viraladsmedia_\\/\",\"snippet\":\"Visit www.viraladsmedia.com today! #EmpowerYourBrand #BrandEmpowerment ... www.viraladsmedia.com #brand #branding #socialmedia #websitedesign ...\"},{\"position\":5,\"title\":\"Life at Viral Ads Media: Culture, Salary, Reviews ...\",\"url\":\"https:\\/\\/www.ambitionbox.com\\/overview\\/viral-ads-media-overview\",\"snippet\":\"New Delhi. Website. viraladsmedia.com. Primary Industry. info icon. Primary industry refers to the industry from which a company drives its maximum revenue ...Read more\"},{\"position\":6,\"title\":\"Viral Ads Media (viraladsmedia) – Profile\",\"url\":\"https:\\/\\/in.pinterest.com\\/infoviraladsmedia\\/\",\"snippet\":\"... impactful digital marketing strategies. Our team is dedicated to helping brands grow and engage with… more. viraladsmedia.com. ; Opens a new tab. Follow.Read more\"},{\"position\":7,\"title\":\"We\'re Hiring | Join Viral Ads Media\'s Creative Team ...\",\"url\":\"https:\\/\\/www.facebook.com\\/theviraladsmedia\\/videos\\/-were-hiring-join-viral-ads-medias-creative-teamviral-ads-media-is-looking-for-p\\/1578624550276828\\/\",\"snippet\":\"Interested candidates can apply by sharing their Portfolio & Resume. Contact: +91 9354491934 hr@viraladsmedia.com www.viraladsmedia.\"},{\"position\":8,\"title\":\"Viral Ads Media - Digital Marketing Agency in Delhi , Website ...\",\"url\":\"https:\\/\\/delhi.infoisinfo.co.in\\/card\\/viral-ads-media-digital-marketing-agency-in-delhi-website-development-company-\\/3618978\",\"snippet\":\"Viral Ads Media - Digital Marketing Agency in Delhi , Website Development Company . Marketing in Delhi. https:\\/\\/www.viraladsmedia.com\\/. Show phone number.\"},{\"position\":9,\"title\":\"Viral Ads Media Company Profile\",\"url\":\"https:\\/\\/www.datanyze.com\\/companies\\/viral-ads-media\\/1339726657\",\"snippet\":\"Viral Ads Media. Main Industry. Advertising & Marketing, Business Services. Website. www.viraladsmedia.com. Contact Information. Headquarters. b-27 Khatu Shyam ...Read more\"},{\"position\":10,\"title\":\"Viral Ads Media - Marketing Company in new delhi - Opendi\",\"url\":\"https:\\/\\/www.opendi.in\\/new-delhi\\/500787.html\",\"snippet\":\"www.viraladsmedia.com · Delhi · Business Pages New Delhi · Categories With M · Marketing Company In New Delhi · Viral Ads Media - Digital Marketing Agency In ...Read more\"}]}');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ai_conversations`
--
ALTER TABLE `ai_conversations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `website_id` (`website_id`);

--
-- Indexes for table `ai_credit_balances`
--
ALTER TABLE `ai_credit_balances`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `ai_messages`
--
ALTER TABLE `ai_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `conversation_id` (`conversation_id`);

--
-- Indexes for table `ai_usage`
--
ALTER TABLE `ai_usage`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`,`created_at`),
  ADD KEY `website_id` (`website_id`);

--
-- Indexes for table `api_logs`
--
ALTER TABLE `api_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_at` (`created_at`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `auth_tokens`
--
ALTER TABLE `auth_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token_hash` (`token_hash`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `automation_rules`
--
ALTER TABLE `automation_rules`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `website_id` (`website_id`,`code`);

--
-- Indexes for table `backlinks`
--
ALTER TABLE `backlinks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `website_id` (`website_id`,`status`);

--
-- Indexes for table `chat_automation_rules`
--
ALTER TABLE `chat_automation_rules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `widget_id` (`widget_id`);

--
-- Indexes for table `chat_conversations`
--
ALTER TABLE `chat_conversations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token_hash` (`token_hash`),
  ADD KEY `widget_id` (`widget_id`,`updated_at`);

--
-- Indexes for table `chat_knowledge`
--
ALTER TABLE `chat_knowledge`
  ADD PRIMARY KEY (`id`),
  ADD KEY `widget_id` (`widget_id`);

--
-- Indexes for table `chat_leads`
--
ALTER TABLE `chat_leads`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `conversation_id` (`conversation_id`),
  ADD KEY `widget_id` (`widget_id`,`status`);

--
-- Indexes for table `chat_messages`
--
ALTER TABLE `chat_messages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `conversation_id` (`conversation_id`,`client_id`),
  ADD KEY `conversation_id_2` (`conversation_id`,`id`);

--
-- Indexes for table `chat_widgets`
--
ALTER TABLE `chat_widgets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `public_id` (`public_id`),
  ADD KEY `user_id` (`user_id`,`id`);

--
-- Indexes for table `competitors`
--
ALTER TABLE `competitors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `website_id` (`website_id`);

--
-- Indexes for table `competitor_keywords`
--
ALTER TABLE `competitor_keywords`
  ADD PRIMARY KEY (`id`),
  ADD KEY `competitor_id` (`competitor_id`);

--
-- Indexes for table `content_briefs`
--
ALTER TABLE `content_briefs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `content_project_id` (`content_project_id`);

--
-- Indexes for table `content_projects`
--
ALTER TABLE `content_projects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `website_id` (`website_id`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `coupon_usage`
--
ALTER TABLE `coupon_usage`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `payment_id` (`payment_id`),
  ADD KEY `coupon_id` (`coupon_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `crawl_jobs`
--
ALTER TABLE `crawl_jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `status` (`status`,`heartbeat`),
  ADD KEY `website_id` (`website_id`);

--
-- Indexes for table `crawl_urls`
--
ALTER TABLE `crawl_urls`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `job_id` (`job_id`,`url_hash`),
  ADD KEY `job_id_2` (`job_id`,`status`);

--
-- Indexes for table `email_logs`
--
ALTER TABLE `email_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `status` (`status`,`created_at`);

--
-- Indexes for table `human_service_requests`
--
ALTER TABLE `human_service_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `website_id` (`website_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `assigned_user` (`assigned_user`);

--
-- Indexes for table `internal_link_suggestions`
--
ALTER TABLE `internal_link_suggestions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `website_id` (`website_id`);

--
-- Indexes for table `invitations`
--
ALTER TABLE `invitations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token_hash` (`token_hash`),
  ADD KEY `owner_id` (`owner_id`),
  ADD KEY `website_id` (`website_id`);

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `payment_id` (`payment_id`),
  ADD UNIQUE KEY `number` (`number`);

--
-- Indexes for table `keywords`
--
ALTER TABLE `keywords`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `website_id` (`website_id`,`keyword`,`country`,`device`);

--
-- Indexes for table `keyword_groups`
--
ALTER TABLE `keyword_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `website_id` (`website_id`,`name`);

--
-- Indexes for table `keyword_rankings`
--
ALTER TABLE `keyword_rankings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `keyword_id` (`keyword_id`,`date`);

--
-- Indexes for table `leads`
--
ALTER TABLE `leads`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `fingerprint` (`fingerprint`),
  ADD UNIQUE KEY `demo_slot` (`demo_slot`),
  ADD KEY `lead_source_date` (`source_id`,`created_at`),
  ADD KEY `lead_score` (`score`),
  ADD KEY `lead_location` (`city`,`state`),
  ADD KEY `lead_created` (`created_at`),
  ADD KEY `lead_email` (`email`),
  ADD KEY `lead_phone` (`phone`),
  ADD KEY `lead_website` (`website`(190));

--
-- Indexes for table `lead_activity`
--
ALTER TABLE `lead_activity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lead_id` (`lead_id`),
  ADD KEY `lead_activity_date` (`created_at`);

--
-- Indexes for table `lead_notes`
--
ALTER TABLE `lead_notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lead_id` (`lead_id`);

--
-- Indexes for table `lead_searches`
--
ALTER TABLE `lead_searches`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lead_search_date` (`created_at`);

--
-- Indexes for table `lead_sources`
--
ALTER TABLE `lead_sources`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `lead_tags`
--
ALTER TABLE `lead_tags`
  ADD PRIMARY KEY (`lead_id`,`tag`);

--
-- Indexes for table `local_seo_audits`
--
ALTER TABLE `local_seo_audits`
  ADD PRIMARY KEY (`id`),
  ADD KEY `local_seo_history` (`website_id`,`id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`,`read_at`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `job_id` (`job_id`,`url_hash`),
  ADD KEY `website_id` (`website_id`,`job_id`);

--
-- Indexes for table `page_recommendations`
--
ALTER TABLE `page_recommendations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `page_id` (`page_id`),
  ADD KEY `website_id` (`website_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_id` (`order_id`),
  ADD UNIQUE KEY `provider_payment_id` (`provider_payment_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `plan_id` (`plan_id`),
  ADD KEY `coupon_id` (`coupon_id`),
  ADD KEY `service_request_id` (`service_request_id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `plans`
--
ALTER TABLE `plans`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `plan_features`
--
ALTER TABLE `plan_features`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `plan_id` (`plan_id`,`name`);

--
-- Indexes for table `rate_limits`
--
ALTER TABLE `rate_limits`
  ADD PRIMARY KEY (`bucket`);

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`,`created_at`),
  ADD KEY `website_id` (`website_id`);

--
-- Indexes for table `resource_checks`
--
ALTER TABLE `resource_checks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `job_id` (`job_id`,`url_hash`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `seo_audits`
--
ALTER TABLE `seo_audits`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `job_id` (`job_id`),
  ADD KEY `website_id` (`website_id`);

--
-- Indexes for table `seo_expert_clients`
--
ALTER TABLE `seo_expert_clients`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `enquiry_id` (`enquiry_id`),
  ADD KEY `status` (`status`,`end_date`),
  ADD KEY `assigned_expert` (`assigned_expert`);

--
-- Indexes for table `seo_expert_enquiries`
--
ALTER TABLE `seo_expert_enquiries`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `reference` (`reference`),
  ADD UNIQUE KEY `request_key` (`request_key`),
  ADD KEY `status` (`status`,`created_at`),
  ADD KEY `plan` (`plan`,`duration`),
  ADD KEY `follow_up_at` (`follow_up_at`),
  ADD KEY `assigned_expert` (`assigned_expert`);

--
-- Indexes for table `seo_expert_notes`
--
ALTER TABLE `seo_expert_notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `enquiry_id` (`enquiry_id`,`id`),
  ADD KEY `author_id` (`author_id`);

--
-- Indexes for table `seo_expert_payments`
--
ALTER TABLE `seo_expert_payments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `request_key` (`request_key`),
  ADD KEY `enquiry_id` (`enquiry_id`,`paid_on`),
  ADD KEY `status` (`status`,`paid_on`),
  ADD KEY `recorded_by` (`recorded_by`);

--
-- Indexes for table `seo_expert_rankings`
--
ALTER TABLE `seo_expert_rankings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `client_id` (`client_id`,`keyword`,`checked_on`);

--
-- Indexes for table `seo_expert_reports`
--
ALTER TABLE `seo_expert_reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `client_id` (`client_id`,`report_month`);

--
-- Indexes for table `seo_expert_tasks`
--
ALTER TABLE `seo_expert_tasks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `client_id` (`client_id`,`month_number`);

--
-- Indexes for table `seo_issues`
--
ALTER TABLE `seo_issues`
  ADD PRIMARY KEY (`id`),
  ADD KEY `website_id` (`website_id`,`status`,`severity`),
  ADD KEY `audit_id` (`audit_id`),
  ADD KEY `page_id` (`page_id`);

--
-- Indexes for table `seo_issue_types`
--
ALTER TABLE `seo_issue_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `seo_tasks`
--
ALTER TABLE `seo_tasks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `issue_id` (`issue_id`),
  ADD KEY `website_id` (`website_id`,`status`),
  ADD KEY `assigned_user` (`assigned_user`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`,`status`,`ends_at`),
  ADD KEY `plan_id` (`plan_id`);

--
-- Indexes for table `system_logs`
--
ALTER TABLE `system_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `team_members`
--
ALTER TABLE `team_members`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`,`website_id`),
  ADD KEY `owner_id` (`owner_id`),
  ADD KEY `website_id` (`website_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`user_id`,`role_id`),
  ADD KEY `role_id` (`role_id`);

--
-- Indexes for table `websites`
--
ALTER TABLE `websites`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`,`domain_hash`);

--
-- Indexes for table `website_settings`
--
ALTER TABLE `website_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `website_id` (`website_id`,`name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ai_conversations`
--
ALTER TABLE `ai_conversations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ai_messages`
--
ALTER TABLE `ai_messages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ai_usage`
--
ALTER TABLE `ai_usage`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `api_logs`
--
ALTER TABLE `api_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `auth_tokens`
--
ALTER TABLE `auth_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `automation_rules`
--
ALTER TABLE `automation_rules`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `backlinks`
--
ALTER TABLE `backlinks`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `chat_automation_rules`
--
ALTER TABLE `chat_automation_rules`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chat_conversations`
--
ALTER TABLE `chat_conversations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `chat_knowledge`
--
ALTER TABLE `chat_knowledge`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chat_leads`
--
ALTER TABLE `chat_leads`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `chat_messages`
--
ALTER TABLE `chat_messages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `chat_widgets`
--
ALTER TABLE `chat_widgets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `competitors`
--
ALTER TABLE `competitors`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `competitor_keywords`
--
ALTER TABLE `competitor_keywords`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `content_briefs`
--
ALTER TABLE `content_briefs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `content_projects`
--
ALTER TABLE `content_projects`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `coupon_usage`
--
ALTER TABLE `coupon_usage`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `crawl_jobs`
--
ALTER TABLE `crawl_jobs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `crawl_urls`
--
ALTER TABLE `crawl_urls`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1609;

--
-- AUTO_INCREMENT for table `email_logs`
--
ALTER TABLE `email_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `human_service_requests`
--
ALTER TABLE `human_service_requests`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `internal_link_suggestions`
--
ALTER TABLE `internal_link_suggestions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `invitations`
--
ALTER TABLE `invitations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `keywords`
--
ALTER TABLE `keywords`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `keyword_groups`
--
ALTER TABLE `keyword_groups`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `keyword_rankings`
--
ALTER TABLE `keyword_rankings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `leads`
--
ALTER TABLE `leads`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lead_activity`
--
ALTER TABLE `lead_activity`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `lead_notes`
--
ALTER TABLE `lead_notes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lead_searches`
--
ALTER TABLE `lead_searches`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `local_seo_audits`
--
ALTER TABLE `local_seo_audits`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT for table `page_recommendations`
--
ALTER TABLE `page_recommendations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `plans`
--
ALTER TABLE `plans`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `plan_features`
--
ALTER TABLE `plan_features`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reports`
--
ALTER TABLE `reports`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `resource_checks`
--
ALTER TABLE `resource_checks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=187;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `seo_audits`
--
ALTER TABLE `seo_audits`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `seo_expert_clients`
--
ALTER TABLE `seo_expert_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `seo_expert_enquiries`
--
ALTER TABLE `seo_expert_enquiries`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `seo_expert_notes`
--
ALTER TABLE `seo_expert_notes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `seo_expert_payments`
--
ALTER TABLE `seo_expert_payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `seo_expert_rankings`
--
ALTER TABLE `seo_expert_rankings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `seo_expert_reports`
--
ALTER TABLE `seo_expert_reports`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `seo_expert_tasks`
--
ALTER TABLE `seo_expert_tasks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `seo_issues`
--
ALTER TABLE `seo_issues`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=567;

--
-- AUTO_INCREMENT for table `seo_issue_types`
--
ALTER TABLE `seo_issue_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `seo_tasks`
--
ALTER TABLE `seo_tasks`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `system_logs`
--
ALTER TABLE `system_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `team_members`
--
ALTER TABLE `team_members`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `websites`
--
ALTER TABLE `websites`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `website_settings`
--
ALTER TABLE `website_settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ai_conversations`
--
ALTER TABLE `ai_conversations`
  ADD CONSTRAINT `ai_conversations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `ai_conversations_ibfk_2` FOREIGN KEY (`website_id`) REFERENCES `websites` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ai_credit_balances`
--
ALTER TABLE `ai_credit_balances`
  ADD CONSTRAINT `ai_credit_balances_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `ai_messages`
--
ALTER TABLE `ai_messages`
  ADD CONSTRAINT `ai_messages_ibfk_1` FOREIGN KEY (`conversation_id`) REFERENCES `ai_conversations` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ai_usage`
--
ALTER TABLE `ai_usage`
  ADD CONSTRAINT `ai_usage_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `ai_usage_ibfk_2` FOREIGN KEY (`website_id`) REFERENCES `websites` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `audit_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `auth_tokens`
--
ALTER TABLE `auth_tokens`
  ADD CONSTRAINT `auth_tokens_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `automation_rules`
--
ALTER TABLE `automation_rules`
  ADD CONSTRAINT `automation_rules_ibfk_1` FOREIGN KEY (`website_id`) REFERENCES `websites` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `backlinks`
--
ALTER TABLE `backlinks`
  ADD CONSTRAINT `backlinks_ibfk_1` FOREIGN KEY (`website_id`) REFERENCES `websites` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `chat_automation_rules`
--
ALTER TABLE `chat_automation_rules`
  ADD CONSTRAINT `chat_automation_rules_ibfk_1` FOREIGN KEY (`widget_id`) REFERENCES `chat_widgets` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `chat_conversations`
--
ALTER TABLE `chat_conversations`
  ADD CONSTRAINT `chat_conversations_ibfk_1` FOREIGN KEY (`widget_id`) REFERENCES `chat_widgets` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `chat_knowledge`
--
ALTER TABLE `chat_knowledge`
  ADD CONSTRAINT `chat_knowledge_ibfk_1` FOREIGN KEY (`widget_id`) REFERENCES `chat_widgets` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `chat_leads`
--
ALTER TABLE `chat_leads`
  ADD CONSTRAINT `chat_leads_ibfk_1` FOREIGN KEY (`widget_id`) REFERENCES `chat_widgets` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `chat_leads_ibfk_2` FOREIGN KEY (`conversation_id`) REFERENCES `chat_conversations` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `chat_messages`
--
ALTER TABLE `chat_messages`
  ADD CONSTRAINT `chat_messages_ibfk_1` FOREIGN KEY (`conversation_id`) REFERENCES `chat_conversations` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `chat_widgets`
--
ALTER TABLE `chat_widgets`
  ADD CONSTRAINT `chat_widgets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `competitors`
--
ALTER TABLE `competitors`
  ADD CONSTRAINT `competitors_ibfk_1` FOREIGN KEY (`website_id`) REFERENCES `websites` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `competitor_keywords`
--
ALTER TABLE `competitor_keywords`
  ADD CONSTRAINT `competitor_keywords_ibfk_1` FOREIGN KEY (`competitor_id`) REFERENCES `competitors` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `content_briefs`
--
ALTER TABLE `content_briefs`
  ADD CONSTRAINT `content_briefs_ibfk_1` FOREIGN KEY (`content_project_id`) REFERENCES `content_projects` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `content_projects`
--
ALTER TABLE `content_projects`
  ADD CONSTRAINT `content_projects_ibfk_1` FOREIGN KEY (`website_id`) REFERENCES `websites` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `coupon_usage`
--
ALTER TABLE `coupon_usage`
  ADD CONSTRAINT `coupon_usage_ibfk_1` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`),
  ADD CONSTRAINT `coupon_usage_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `coupon_usage_ibfk_3` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`);

--
-- Constraints for table `crawl_jobs`
--
ALTER TABLE `crawl_jobs`
  ADD CONSTRAINT `crawl_jobs_ibfk_1` FOREIGN KEY (`website_id`) REFERENCES `websites` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `crawl_urls`
--
ALTER TABLE `crawl_urls`
  ADD CONSTRAINT `crawl_urls_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `crawl_jobs` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `human_service_requests`
--
ALTER TABLE `human_service_requests`
  ADD CONSTRAINT `human_service_requests_ibfk_1` FOREIGN KEY (`website_id`) REFERENCES `websites` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `human_service_requests_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `human_service_requests_ibfk_3` FOREIGN KEY (`assigned_user`) REFERENCES `users` (`id`);

--
-- Constraints for table `internal_link_suggestions`
--
ALTER TABLE `internal_link_suggestions`
  ADD CONSTRAINT `internal_link_suggestions_ibfk_1` FOREIGN KEY (`website_id`) REFERENCES `websites` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `invitations`
--
ALTER TABLE `invitations`
  ADD CONSTRAINT `invitations_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `invitations_ibfk_2` FOREIGN KEY (`website_id`) REFERENCES `websites` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `invoices`
--
ALTER TABLE `invoices`
  ADD CONSTRAINT `invoices_ibfk_1` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`);

--
-- Constraints for table `keywords`
--
ALTER TABLE `keywords`
  ADD CONSTRAINT `keywords_ibfk_1` FOREIGN KEY (`website_id`) REFERENCES `websites` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `keyword_groups`
--
ALTER TABLE `keyword_groups`
  ADD CONSTRAINT `keyword_groups_ibfk_1` FOREIGN KEY (`website_id`) REFERENCES `websites` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `keyword_rankings`
--
ALTER TABLE `keyword_rankings`
  ADD CONSTRAINT `keyword_rankings_ibfk_1` FOREIGN KEY (`keyword_id`) REFERENCES `keywords` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `leads`
--
ALTER TABLE `leads`
  ADD CONSTRAINT `leads_ibfk_1` FOREIGN KEY (`source_id`) REFERENCES `lead_sources` (`id`);

--
-- Constraints for table `lead_activity`
--
ALTER TABLE `lead_activity`
  ADD CONSTRAINT `lead_activity_ibfk_1` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `lead_notes`
--
ALTER TABLE `lead_notes`
  ADD CONSTRAINT `lead_notes_ibfk_1` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `lead_tags`
--
ALTER TABLE `lead_tags`
  ADD CONSTRAINT `lead_tags_ibfk_1` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `local_seo_audits`
--
ALTER TABLE `local_seo_audits`
  ADD CONSTRAINT `local_seo_audits_ibfk_1` FOREIGN KEY (`website_id`) REFERENCES `websites` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `local_seo_audits_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `pages`
--
ALTER TABLE `pages`
  ADD CONSTRAINT `pages_ibfk_1` FOREIGN KEY (`website_id`) REFERENCES `websites` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `pages_ibfk_2` FOREIGN KEY (`job_id`) REFERENCES `crawl_jobs` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `page_recommendations`
--
ALTER TABLE `page_recommendations`
  ADD CONSTRAINT `page_recommendations_ibfk_1` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `page_recommendations_ibfk_2` FOREIGN KEY (`website_id`) REFERENCES `websites` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `payments_ibfk_2` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`),
  ADD CONSTRAINT `payments_ibfk_3` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`),
  ADD CONSTRAINT `payments_ibfk_4` FOREIGN KEY (`service_request_id`) REFERENCES `human_service_requests` (`id`);

--
-- Constraints for table `plan_features`
--
ALTER TABLE `plan_features`
  ADD CONSTRAINT `plan_features_ibfk_1` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `reports`
--
ALTER TABLE `reports`
  ADD CONSTRAINT `reports_ibfk_1` FOREIGN KEY (`website_id`) REFERENCES `websites` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reports_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `resource_checks`
--
ALTER TABLE `resource_checks`
  ADD CONSTRAINT `resource_checks_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `crawl_jobs` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `seo_audits`
--
ALTER TABLE `seo_audits`
  ADD CONSTRAINT `seo_audits_ibfk_1` FOREIGN KEY (`website_id`) REFERENCES `websites` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `seo_audits_ibfk_2` FOREIGN KEY (`job_id`) REFERENCES `crawl_jobs` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `seo_expert_clients`
--
ALTER TABLE `seo_expert_clients`
  ADD CONSTRAINT `seo_expert_clients_ibfk_1` FOREIGN KEY (`enquiry_id`) REFERENCES `seo_expert_enquiries` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `seo_expert_clients_ibfk_2` FOREIGN KEY (`assigned_expert`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `seo_expert_enquiries`
--
ALTER TABLE `seo_expert_enquiries`
  ADD CONSTRAINT `seo_expert_enquiries_ibfk_1` FOREIGN KEY (`assigned_expert`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `seo_expert_notes`
--
ALTER TABLE `seo_expert_notes`
  ADD CONSTRAINT `seo_expert_notes_ibfk_1` FOREIGN KEY (`enquiry_id`) REFERENCES `seo_expert_enquiries` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `seo_expert_notes_ibfk_2` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `seo_expert_payments`
--
ALTER TABLE `seo_expert_payments`
  ADD CONSTRAINT `seo_expert_payments_ibfk_1` FOREIGN KEY (`enquiry_id`) REFERENCES `seo_expert_enquiries` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `seo_expert_payments_ibfk_2` FOREIGN KEY (`recorded_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `seo_expert_rankings`
--
ALTER TABLE `seo_expert_rankings`
  ADD CONSTRAINT `seo_expert_rankings_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `seo_expert_clients` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `seo_expert_reports`
--
ALTER TABLE `seo_expert_reports`
  ADD CONSTRAINT `seo_expert_reports_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `seo_expert_clients` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `seo_expert_tasks`
--
ALTER TABLE `seo_expert_tasks`
  ADD CONSTRAINT `seo_expert_tasks_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `seo_expert_clients` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `seo_issues`
--
ALTER TABLE `seo_issues`
  ADD CONSTRAINT `seo_issues_ibfk_1` FOREIGN KEY (`website_id`) REFERENCES `websites` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `seo_issues_ibfk_2` FOREIGN KEY (`audit_id`) REFERENCES `seo_audits` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `seo_issues_ibfk_3` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `seo_tasks`
--
ALTER TABLE `seo_tasks`
  ADD CONSTRAINT `seo_tasks_ibfk_1` FOREIGN KEY (`website_id`) REFERENCES `websites` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `seo_tasks_ibfk_2` FOREIGN KEY (`assigned_user`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `seo_tasks_ibfk_3` FOREIGN KEY (`issue_id`) REFERENCES `seo_issues` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD CONSTRAINT `subscriptions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `subscriptions_ibfk_2` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`);

--
-- Constraints for table `team_members`
--
ALTER TABLE `team_members`
  ADD CONSTRAINT `team_members_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `team_members_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `team_members_ibfk_3` FOREIGN KEY (`website_id`) REFERENCES `websites` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD CONSTRAINT `user_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_roles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);

--
-- Constraints for table `websites`
--
ALTER TABLE `websites`
  ADD CONSTRAINT `websites_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `website_settings`
--
ALTER TABLE `website_settings`
  ADD CONSTRAINT `website_settings_ibfk_1` FOREIGN KEY (`website_id`) REFERENCES `websites` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
