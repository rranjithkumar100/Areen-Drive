-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Jul 12, 2026 at 08:10 AM
-- Server version: 5.7.39
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `areen`
--
CREATE DATABASE IF NOT EXISTS `areen` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `areen`;

-- --------------------------------------------------------

--
-- Table structure for table `bans`
--

CREATE TABLE `bans` (
  `id` int(10) UNSIGNED NOT NULL,
  `bannable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bannable_id` bigint(20) UNSIGNED NOT NULL,
  `created_by_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci,
  `expired_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `billing_plans`
--

CREATE TABLE `billing_plans` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(13,2) DEFAULT NULL,
  `currency` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency_symbol` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '$',
  `interval` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'month',
  `interval_count` int(11) NOT NULL DEFAULT '1',
  `parent_id` int(11) DEFAULT NULL,
  `legacy_permissions` text COLLATE utf8mb4_unicode_ci,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `paypal_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recommended` tinyint(1) NOT NULL DEFAULT '0',
  `free` tinyint(1) NOT NULL DEFAULT '0',
  `show_permissions` tinyint(1) NOT NULL DEFAULT '0',
  `features` text COLLATE utf8mb4_unicode_ci,
  `position` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `hidden` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int(10) UNSIGNED NOT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` int(10) UNSIGNED DEFAULT NULL,
  `path` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `commentable_id` int(10) UNSIGNED NOT NULL,
  `commentable_type` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `upvotes` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `downvotes` bigint(20) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `comment_reports`
--

CREATE TABLE `comment_reports` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `reason` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `comment_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_ip` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `comment_votes`
--

CREATE TABLE `comment_votes` (
  `id` int(10) UNSIGNED NOT NULL,
  `vote_type` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `comment_id` int(10) UNSIGNED NOT NULL,
  `user_ip` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `css_themes`
--

CREATE TABLE `css_themes` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_dark` tinyint(1) NOT NULL DEFAULT '0',
  `default_light` tinyint(1) NOT NULL DEFAULT '0',
  `default_dark` tinyint(1) NOT NULL DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  `type` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'site',
  `font` text COLLATE utf8mb4_unicode_ci,
  `values` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `css_themes`
--

INSERT INTO `css_themes` (`id`, `name`, `is_dark`, `default_light`, `default_dark`, `user_id`, `type`, `font`, `values`, `created_at`, `updated_at`) VALUES
(1, 'Dark', 1, 0, 1, 1, 'site', NULL, '{\"--be-fg-base\":\"255 255 255\",\"--be-primary-light\":\"239 246 255\",\"--be-primary\":\"191 219 254\",\"--be-primary-dark\":\"147 197 253\",\"--be-on-primary\":\"56 30 114\",\"--be-bg\":\"23 23 23\",\"--be-bg-alt\":\"31 31 31\",\"--be-bg-chip\":\"66 68 74\",\"--be-bg-elevated\":\"29 29 29\",\"--be-disabled-bg-opacity\":\"12%\",\"--be-disabled-fg-opacity\":\"30%\",\"--be-hover-opacity\":\"8%\",\"--be-focus-opacity\":\"12%\",\"--be-selected-opacity\":\"16%\",\"--be-text-main-opacity\":\"100%\",\"--be-text-muted-opacity\":\"70%\",\"--be-divider-opacity\":\"12%\",\"--be-button-radius\":\"1.5rem\",\"--be-input-radius\":\"0.50rem\",\"--be-panel-radius\":\"0.75rem\"}', '2026-06-18 05:59:53', '2026-06-18 05:59:53'),
(2, 'Light', 0, 1, 0, 1, 'site', NULL, '{\"--be-fg-base\":\"0 0 0\",\"--be-primary-light\":\"191 219 254\",\"--be-primary\":\"59 130 246\",\"--be-primary-dark\":\"37 99 235\",\"--be-on-primary\":\"255 255 255\",\"--be-bg\":\"255 255 255\",\"--be-bg-alt\":\"246 248 250\",\"--be-bg-chip\":\"233 236 239\",\"--be-bg-elevated\":\"255 255 255\",\"--be-disabled-bg-opacity\":\"12%\",\"--be-disabled-fg-opacity\":\"26%\",\"--be-hover-opacity\":\"4%\",\"--be-focus-opacity\":\"12%\",\"--be-selected-opacity\":\"8%\",\"--be-text-main-opacity\":\"87%\",\"--be-text-muted-opacity\":\"60%\",\"--be-divider-opacity\":\"12%\",\"--be-button-radius\":\"1.5rem\",\"--be-input-radius\":\"0.50rem\",\"--be-panel-radius\":\"0.75rem\"}', '2026-06-18 05:59:53', '2026-06-18 05:59:53');

-- --------------------------------------------------------

--
-- Table structure for table `csv_exports`
--

CREATE TABLE `csv_exports` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `cache_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `download_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `custom_domains`
--

CREATE TABLE `custom_domains` (
  `id` int(10) UNSIGNED NOT NULL,
  `host` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `global` tinyint(1) NOT NULL DEFAULT '0',
  `resource_id` int(10) UNSIGNED DEFAULT NULL,
  `resource_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `workspace_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `custom_pages`
--

CREATE TABLE `custom_pages` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta` text COLLATE utf8mb4_unicode_ci,
  `type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `hide_nav` tinyint(1) NOT NULL DEFAULT '0',
  `workspace_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `custom_pages`
--

INSERT INTO `custom_pages` (`id`, `title`, `body`, `slug`, `meta`, `type`, `created_at`, `updated_at`, `user_id`, `hide_nav`, `workspace_id`) VALUES
(1, 'Example Privacy Policy', '<p>Welcome to Areen (\"us\", \"we\", or \"our\"). At http://localhost, we value your privacy and strive to protect your personal information. This Privacy Policy outlines the types of data we collect, how we use and protect it, and your rights regarding your personal information.</p><h2>Information We Collect</h2><p>We may collect various types of information from you, including:</p><ol><li><p><strong>Personal Information:</strong> When you register for an account, place an order, subscribe to our newsletter, or interact with our website, we may collect personal information such as your name, email address, postal address, phone number, and payment information.</p></li><li><p><strong>Usage Data:</strong> We may automatically collect information about how you use our website, including your IP address, browser type, operating system, referring URLs, access times, and pages viewed.</p></li><li><p><strong>Cookies and Tracking Technologies:</strong> We use cookies and similar tracking technologies to enhance your browsing experience and collect data about your interactions with our website.</p></li></ol><h2>How We Use Your Information</h2><p>We use the collected information for various purposes, including:</p><ol><li><p>Providing and improving our services to you.</p></li><li><p>Processing your orders and payments.</p></li><li><p>Sending you newsletters and promotional materials.</p></li><li><p>Analyzing website usage and trends to enhance user experience.</p></li><li><p>Responding to your inquiries and providing customer support.</p></li><li><p>Protecting our legal rights and preventing fraud.</p></li></ol><h2>Data Sharing and Disclosure</h2><p>We may share your personal information with:</p><ol><li><p>Third-party service providers who assist us in operating our website and delivering services to you.</p></li><li><p>Legal authorities when required by law or to protect our rights and safety.</p></li></ol><p>We do not sell, rent, or trade your personal information to third parties for marketing purposes.</p><h2>Your Rights</h2><p>You have the right to:</p><ol><li><p>Access, correct, or delete your personal information.</p></li><li><p>Withdraw your consent for processing your data.</p></li><li><p>Object to processing of your personal data.</p></li><li><p>Lodge a complaint with a supervisory authority.</p></li></ol><h2>Security</h2><p>We take reasonable measures to protect your personal information from unauthorized access, alteration, or disclosure. However, no data transmission over the internet or storage system can be guaranteed to be 100% secure.</p><h2>Children\'s Privacy</h2><p>Our services are not intended for children under the age of 13. We do not knowingly collect or maintain personal information from children.</p><h2>Changes to This Privacy Policy</h2><p>We may update our Privacy Policy from time to time. Any changes will be posted on this page, and the \"Last updated\" date will be revised accordingly.</p><h2>Contact Us</h2><p>If you have any questions, concerns, or requests regarding your personal information or our Privacy Policy, please contact us at .</p>', 'privacy-policy', NULL, 'default', '2026-06-18 05:59:53', '2026-06-18 06:28:22', NULL, 0, NULL),
(2, 'Example Terms of Service', '<p>Welcome to Areen (\"us\", \"we\", or \"our\"). By accessing and using our website, you agree to comply with and be bound by the following Terms of Service. Please read these terms carefully before using our services.</p><h2>1. Acceptance of Terms</h2><p>By using our website, you acknowledge that you have read, understood, and agree to abide by these Terms of Service. If you do not agree with these terms, please do not use our services.</p><h2>2. Use of Our Services</h2><p>You may use our website and services only for lawful purposes and in compliance with all applicable laws and regulations. You agree not to engage in any activity that may disrupt or interfere with the functioning of our website.</p><h2>3. User Accounts</h2><p>If you create an account on our website, you are responsible for maintaining the confidentiality of your account information and password. You agree to notify us immediately of any unauthorized use of your account.</p><h2>4. Content</h2><p>Any content you submit to our website, including text, images, and other materials, must comply with our content guidelines. You retain ownership of your content, but you grant us a non-exclusive, royalty-free license to use, reproduce, and distribute your content on our platform.</p><h2>5. Intellectual Property</h2><p>Unless otherwise stated, all content and materials on our website are the property of Areen and are protected by copyright, trademark, and other intellectual property laws.</p><h2>6. Disclaimer of Warranties</h2><p>Our website is provided \"as is\" and \"as available\" without any warranties of any kind, whether express or implied. We do not guarantee the accuracy, completeness, or reliability of any content or materials on our website.</p><h2>7. Limitation of Liability</h2><p>We shall not be liable for any indirect, incidental, special, consequential, or punitive damages arising out of or relating to your use of our website.</p><h2>8. Governing Law</h2><p>These Terms of Service shall be governed by and construed in accordance with the laws of United States, without regard to its conflict of law principles.</p><h2>9. Changes to Terms</h2><p>We reserve the right to modify or update these Terms of Service at any time. It is your responsibility to review these terms periodically. Your continued use of our website after any changes signifies your acceptance of the modified terms.</p><h2>10. Contact Us</h2><p>If you have any questions or concerns regarding these Terms of Service, please contact us at .</p>', 'terms-of-service', NULL, 'default', '2026-06-18 05:59:53', '2026-06-18 06:29:13', NULL, 0, NULL),
(3, 'Example About Us', '<p>\n  The standard Lorem Ipsum passage, used since the 1500s \"Lorem ipsum dolor sit amet, consectetur\n  adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad\n  minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n  Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla\n  pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt\n  mollit anim id est laborum.\"\n</p>\n\n<p>\n  Section 1.10.32 of \"de Finibus Bonorum et Malorum\", written by Cicero in 45 BC \"Sed ut\n  perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam\n  rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta\n  sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed\n  quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam\n  est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius\n  modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima\n  veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea\n  commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam\n  nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?\"\n</p>\n\n<p>\n  1914 translation by H. Rackham \"But I must explain to you how all this mistaken idea of denouncing\n  pleasure and praising pain was born and I will give you a complete account of the system, and\n  expound the actual teachings of the great explorer of the truth, the master-builder of human\n  happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but\n  because those who do not know how to pursue pleasure rationally encounter consequences that are\n  extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of\n  itself, because it is pain, but because occasionally circumstances occur in which toil and pain\n  can procure him some great pleasure. To take a trivial example, which of us ever undertakes\n  laborious physical exercise, except to obtain some advantage from it? But who has any right to\n  find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one\n  who avoids a pain that produces no resultant pleasure?\"\n</p>\n\n<p>\n  Section 1.10.33 of \"de Finibus Bonorum et Malorum\", written by Cicero in 45 BC \"At vero eos et\n  accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque\n  corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident,\n  similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et\n  harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est\n  eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis\n  voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis\n  debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non\n  recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus\n  maiores alias consequatur aut perferendis doloribus asperiores repellat.\"\n</p>\n\n<p>\n  1914 translation by H. Rackham \"On the other hand, we denounce with righteous indignation and\n  dislike men who are so beguiled and demoralized by the charms of pleasure of the moment, so\n  blinded by desire, that they cannot foresee the pain and trouble that are bound to ensue; and\n  equal blame belongs to those who fail in their duty through weakness of will, which is the same as\n  saying through shrinking from toil and pain. These cases are perfectly simple and easy to\n  distinguish. In a free hour, when our power of choice is untrammelled and when nothing prevents\n  our being able to do what we like best, every pleasure is to be welcomed and every pain avoided.\n  But in certain circumstances and owing to the claims of duty or the obligations of business it\n  will frequently occur that pleasures have to be repudiated and annoyances accepted. The wise man\n  therefore always holds in these matters to this principle of selection: he rejects pleasures to\n  secure other greater pleasures, or else he endures pains to avoid worse pains.\"\n</p>\n', 'about-us', NULL, 'default', '2026-06-18 05:59:53', '2026-06-18 05:59:53', NULL, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fcm_tokens`
--

CREATE TABLE `fcm_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `device_id` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `file_entries`
--

CREATE TABLE `file_entries` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mime` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_size` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `user_id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `backend_id` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `upload_type` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `path` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `disk_prefix` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `extension` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `public` tinyint(1) NOT NULL DEFAULT '0',
  `preview_token` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `thumbnail` tinyint(1) NOT NULL DEFAULT '0',
  `workspace_id` int(10) UNSIGNED DEFAULT NULL,
  `owner_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `file_entries`
--

INSERT INTO `file_entries` (`id`, `name`, `description`, `file_name`, `mime`, `file_size`, `user_id`, `parent_id`, `backend_id`, `upload_type`, `created_at`, `updated_at`, `deleted_at`, `path`, `disk_prefix`, `type`, `extension`, `public`, `preview_token`, `thumbnail`, `workspace_id`, `owner_id`) VALUES
(1, 'areen-logo-dark.png', NULL, '06fef740-df07-4f64-96b7-0fd352159269.png', 'image/png', 1195, NULL, NULL, 'PXIbwYUraI', 'brandingImages', '2026-06-18 06:09:58', '2026-06-18 06:09:58', NULL, NULL, NULL, 'image', 'png', 1, NULL, 0, 0, 1),
(2, 'areen-logo-white.png', NULL, 'd79e40a7-6917-4b92-8531-b7cf8dc9bdc7.png', 'image/png', 1092, NULL, NULL, 'PXIbwYUraI', 'brandingImages', '2026-06-18 06:13:02', '2026-06-18 06:13:02', NULL, NULL, NULL, 'image', 'png', 1, NULL, 0, 0, 1),
(3, 'areen-favicon-512.png', NULL, 'afdb8ce3-9203-4628-97b2-7c8c515b875d.png', 'image/png', 5211, NULL, NULL, 'PXIbwYUraI', 'brandingImages', '2026-06-18 06:13:41', '2026-06-18 06:13:41', NULL, NULL, NULL, 'image', 'png', 1, NULL, 0, 0, 1),
(4, 'areen-hero.webp', NULL, '09f5b033-7a3a-4a4b-a3d0-3cb9910c3f71.webp', 'image/webp', 171946, NULL, NULL, 'PXIbwYUraI', 'brandingImages', '2026-06-18 06:36:54', '2026-06-18 06:36:54', NULL, NULL, NULL, 'image', 'webp', 1, NULL, 0, 0, 1),
(5, 'video6.mp4', NULL, '7e2d05f7-107d-41db-8b33-c3177bfe04af', 'video/mp4', 3131156, NULL, NULL, 'PXIbwYUraI', 'bedrive', '2026-06-18 06:48:18', '2026-06-18 06:48:18', NULL, '5', NULL, 'video', 'mp4', 0, NULL, 0, 0, 1),
(6, 'MVU_Plan_TCC.xlsx', NULL, '91b5af55-d114-40c7-84be-27bdb8788ebc', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 19162, NULL, NULL, 'PXIbwYUraI', 'bedrive', '2026-06-18 06:49:01', '2026-06-18 06:49:04', NULL, '6', NULL, 'spreadsheet', 'xlsx', 0, 'dxFAJCkhpP6hXpa', 0, 0, 1),
(7, 'TRAS-408.docx', NULL, 'e5415094-1d9d-4cf7-900a-9536398c5532', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 16859, NULL, NULL, 'PXIbwYUraI', 'bedrive', '2026-06-18 06:49:20', '2026-06-18 06:49:20', NULL, '7', NULL, 'word', 'docx', 0, NULL, 0, 0, 1),
(8, 'Images', NULL, 'Images', NULL, 0, NULL, NULL, NULL, NULL, '2026-06-18 06:49:41', '2026-06-18 06:49:41', NULL, '8', NULL, 'folder', NULL, 0, NULL, 0, 0, 1),
(9, 'sickLeaves 8.pdf', NULL, '39779986-b9b6-471d-8d81-603a5f2ea847', 'application/pdf', 293163, NULL, NULL, 'PXIbwYUraI', 'bedrive', '2026-06-18 06:50:08', '2026-06-18 06:50:08', NULL, '9', NULL, 'pdf', 'pdf', 0, NULL, 0, 0, 1),
(10, 'romantic_gift_card.html', NULL, 'f319cc23-8e06-478e-a2f7-2dc4c0e7a7cf', 'text/html', 9576, NULL, NULL, 'PXIbwYUraI', 'bedrive', '2026-06-18 06:50:38', '2026-06-18 06:50:38', NULL, 'a', NULL, 'text', 'html', 0, NULL, 0, 0, 1),
(11, 'image002.png', NULL, '6515ffdb-549f-40c3-886d-e139200a07be', 'image/png', 389471, NULL, NULL, 'PXIbwYUraI', 'bedrive', '2026-06-18 06:51:09', '2026-06-18 06:51:09', NULL, 'b', NULL, 'image', 'png', 0, NULL, 0, 0, 1),
(12, 'api_data_infographic.svg', NULL, '79ad7eab-87bd-4343-b0ab-8c4b86be5a15', 'image/svg+xml', 8984, NULL, NULL, 'PXIbwYUraI', 'bedrive', '2026-06-18 06:51:36', '2026-06-18 06:51:36', NULL, 'c', NULL, 'image', 'svg', 0, NULL, 0, 0, 1),
(13, 'TCC', NULL, 'TCC', NULL, 0, NULL, NULL, NULL, NULL, '2026-06-29 09:58:43', '2026-06-29 09:58:43', NULL, 'd', NULL, 'folder', NULL, 0, NULL, 0, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `file_entry_models`
--

CREATE TABLE `file_entry_models` (
  `id` int(10) UNSIGNED NOT NULL,
  `file_entry_id` int(10) UNSIGNED NOT NULL,
  `model_id` int(10) UNSIGNED NOT NULL,
  `model_type` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `relation_type` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'access',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `owner` tinyint(1) NOT NULL DEFAULT '0',
  `permissions` text COLLATE utf8mb4_unicode_ci,
  `origin` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'local'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `file_entry_models`
--

INSERT INTO `file_entry_models` (`id`, `file_entry_id`, `model_id`, `model_type`, `relation_type`, `created_at`, `updated_at`, `owner`, `permissions`, `origin`) VALUES
(1, 1, 1, 'user', 'access', '2026-06-18 06:09:58', '2026-06-18 06:09:58', 1, NULL, 'local'),
(2, 2, 1, 'user', 'access', '2026-06-18 06:13:02', '2026-06-18 06:13:02', 1, NULL, 'local'),
(3, 3, 1, 'user', 'access', '2026-06-18 06:13:41', '2026-06-18 06:13:41', 1, NULL, 'local'),
(4, 1, 25, 'setting', 'settings', '2026-06-18 06:14:20', '2026-06-18 06:14:20', 0, NULL, 'local'),
(5, 2, 26, 'setting', 'settings', '2026-06-18 06:14:20', '2026-06-18 06:14:20', 0, NULL, 'local'),
(6, 4, 1, 'user', 'access', '2026-06-18 06:36:54', '2026-06-18 06:36:54', 1, NULL, 'local'),
(7, 4, 29, 'setting', 'settings', '2026-06-18 06:37:30', '2026-06-18 06:37:30', 0, NULL, 'local'),
(8, 5, 1, 'user', 'access', '2026-06-18 06:48:18', '2026-06-18 06:48:18', 1, NULL, 'local'),
(9, 6, 1, 'user', 'access', '2026-06-18 06:49:01', '2026-06-18 06:49:01', 1, NULL, 'local'),
(10, 7, 1, 'user', 'access', '2026-06-18 06:49:20', '2026-06-18 06:49:20', 1, NULL, 'local'),
(11, 8, 1, 'user', 'access', '2026-06-18 06:49:41', '2026-06-18 06:49:41', 1, NULL, 'local'),
(12, 9, 1, 'user', 'access', '2026-06-18 06:50:08', '2026-06-18 06:50:08', 1, NULL, 'local'),
(13, 10, 1, 'user', 'access', '2026-06-18 06:50:38', '2026-06-18 06:50:38', 1, NULL, 'local'),
(14, 11, 1, 'user', 'access', '2026-06-18 06:51:09', '2026-06-18 06:51:09', 1, NULL, 'local'),
(15, 12, 1, 'user', 'access', '2026-06-18 06:51:36', '2026-06-18 06:51:36', 1, NULL, 'local'),
(16, 13, 1, 'user', 'access', '2026-06-29 09:58:43', '2026-06-29 09:58:43', 1, NULL, 'local');

-- --------------------------------------------------------

--
-- Table structure for table `folders`
--

CREATE TABLE `folders` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `path` text COLLATE utf8mb4_unicode_ci,
  `user_id` int(11) DEFAULT NULL,
  `folder_id` int(11) DEFAULT NULL,
  `share_id` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `follows`
--

CREATE TABLE `follows` (
  `id` int(10) UNSIGNED NOT NULL,
  `follower_id` int(11) NOT NULL,
  `followed_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `id` int(10) UNSIGNED NOT NULL,
  `subscription_id` int(11) NOT NULL,
  `amount_paid` int(11) DEFAULT NULL,
  `status` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'paid',
  `currency` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `uuid` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `notified` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `localizations`
--

CREATE TABLE `localizations` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `language` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `localizations`
--

INSERT INTO `localizations` (`id`, `name`, `created_at`, `updated_at`, `language`) VALUES
(1, 'English', '2026-06-18 05:59:53', '2026-06-18 05:59:53', 'en');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2014_10_12_200000_add_two_factor_columns_to_users_table', 1),
(4, '2015_04_127_156842_create_social_profiles_table', 1),
(5, '2015_04_13_140047_create_files_models_table', 1),
(6, '2015_04_18_134312_create_folders_table', 1),
(7, '2015_05_29_131549_create_settings_table', 1),
(8, '2015_10_23_164355_create_follows_table', 1),
(9, '2016_04_06_140017_add_folder_id_index_to_files_table', 1),
(10, '2016_05_12_190852_create_tags_table', 1),
(11, '2016_05_12_190958_create_taggables_table', 1),
(12, '2016_05_26_170044_create_uploads_table', 1),
(13, '2016_05_27_143158_create_uploadables_table', 1),
(14, '2016_07_14_153703_create_groups_table', 1),
(15, '2016_07_14_153921_create_user_group_table', 1),
(16, '2016_10_17_152159_add_space_available_column_to_users_table', 1),
(17, '2017_07_02_120142_create_pages_table', 1),
(18, '2017_07_11_122825_create_localizations_table', 1),
(19, '2017_08_26_131330_add_private_field_to_settings_table', 1),
(20, '2017_09_17_144728_add_columns_to_users_table', 1),
(21, '2017_09_17_152854_make_password_column_nullable', 1),
(22, '2017_09_30_152855_make_settings_value_column_nullable', 1),
(23, '2017_10_01_152897_add_public_column_to_uploads_table', 1),
(24, '2017_12_04_132911_add_avatar_column_to_users_table', 1),
(25, '2018_01_10_140732_create_subscriptions_table', 1),
(26, '2018_01_10_140746_add_billing_to_users_table', 1),
(27, '2018_01_10_161706_create_billing_plans_table', 1),
(28, '2018_06_05_142932_rename_files_table_to_file_entries', 1),
(29, '2018_06_06_141629_rename_file_entries_table_columns', 1),
(30, '2018_06_07_141630_merge_files_and_folders_tables', 1),
(31, '2018_07_03_114346_create_shareable_links_table', 1),
(32, '2018_07_26_142339_rename_groups_to_roles', 1),
(33, '2018_07_26_142842_rename_user_role_table_columns_to_roles', 1),
(34, '2018_08_07_124200_rename_uploads_to_file_entries', 1),
(35, '2018_08_07_124327_refactor_file_entries_columns', 1),
(36, '2018_08_07_130653_add_folder_path_column_to_file_entries_table', 1),
(37, '2018_08_07_140328_delete_legacy_root_folders', 1),
(38, '2018_08_07_140330_move_folders_into_file_entries_table', 1),
(39, '2018_08_07_140440_migrate_file_entry_users_to_many_to_many', 1),
(40, '2018_08_10_142251_update_users_table_to_v2', 1),
(41, '2018_08_15_132225_move_uploads_into_subfolders', 1),
(42, '2018_08_16_111525_transform_file_entries_records_to_v2', 1),
(43, '2018_08_31_104145_rename_uploadables_table', 1),
(44, '2018_08_31_104325_rename_file_entry_models_table_columns', 1),
(45, '2018_11_26_171703_add_type_and_title_columns_to_pages_table', 1),
(46, '2018_12_01_144233_change_unique_index_on_tags_table', 1),
(47, '2019_02_16_150049_delete_old_seo_settings', 1),
(48, '2019_02_24_141457_create_jobs_table', 1),
(49, '2019_03_11_162627_add_preview_token_to_file_entries_table', 1),
(50, '2019_03_12_160803_add_thumbnail_column_to_file_entries_table', 1),
(51, '2019_03_16_161836_add_paypal_id_column_to_billing_plans_table', 1),
(52, '2019_05_14_120930_index_description_column_in_file_entries_table', 1),
(53, '2019_06_08_120504_create_custom_domains_table', 1),
(54, '2019_06_13_140318_add_user_id_column_to_pages_table', 1),
(55, '2019_06_15_114320_rename_pages_table_to_custom_pages', 1),
(56, '2019_06_18_133933_create_permissions_table', 1),
(57, '2019_06_18_134203_create_permissionables_table', 1),
(58, '2019_06_18_135822_rename_permissions_columns', 1),
(59, '2019_07_08_122001_create_css_themes_table', 1),
(60, '2019_07_20_141752_create_invoices_table', 1),
(61, '2019_08_19_121112_add_global_column_to_custom_domains_table', 1),
(62, '2019_09_13_141123_change_plan_amount_to_float', 1),
(63, '2019_10_14_171943_add_index_to_username_column', 1),
(64, '2019_10_20_143522_create_comments_table', 1),
(65, '2019_10_23_134520_create_notifications_table', 1),
(66, '2019_11_21_144956_add_resource_id_and_type_to_custom_domains_table', 1),
(67, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(68, '2019_12_14_194512_rename_public_path_column_to_disk_prefix', 1),
(69, '2019_12_24_165237_change_file_size_column_default_value_to_0', 1),
(70, '2019_12_28_190836_update_file_entry_models_table_to_v2', 1),
(71, '2019_12_28_191105_move_user_file_entry_table_records_to_file_entry_models', 1),
(72, '2020_01_26_143733_create_notification_subscriptions_table', 1),
(73, '2020_03_03_140720_add_language_col_to_localizations_table', 1),
(74, '2020_03_03_143142_add_lang_code_to_existing_localizations', 1),
(75, '2020_04_14_163347_add_hidden_column_to_plans_table', 1),
(76, '2020_06_27_180040_add_verified_at_column_to_users_table', 1),
(77, '2020_06_27_180253_move_confirmed_column_to_email_verified_at', 1),
(78, '2020_07_15_144024_fix_issues_with_migration_to_laravel_7', 1),
(79, '2020_07_22_165126_create_workspaces_table', 1),
(80, '2020_07_23_145652_create_workspace_invites_table', 1),
(81, '2020_07_23_164502_create_workspace_user_table', 1),
(82, '2020_07_26_165349_add_columns_to_roles_table', 1),
(83, '2020_07_29_141418_add_workspace_id_column_to_workspaceable_models', 1),
(84, '2020_07_30_152330_add_type_column_to_permissions_table', 1),
(85, '2020_08_29_165057_add_hide_nav_column_to_custom_pages_table', 1),
(86, '2020_12_14_155112_create_table_fcm_tokens', 1),
(87, '2020_12_17_124109_subscribe_users_to_notifications', 1),
(88, '2021_04_22_172459_add_internal_columm_to_roles_table', 1),
(89, '2021_05_03_173446_add_deleted_column_to_comments_table', 1),
(90, '2021_06_04_143405_add_workspace_id_col_to_custom_domains_table', 1),
(91, '2021_06_04_143406_add_workspace_id_col_to_custom_pages_table', 1),
(92, '2021_06_04_143406_add_workspace_id_col_to_file_entries_table', 1),
(93, '2021_06_05_182202_create_csv_exports_table', 1),
(94, '2021_06_18_161030_rename_gateway_col_in_subscriptions_table', 1),
(95, '2021_06_19_111939_add_owner_id_column_to_file_entries_table', 1),
(96, '2021_06_19_112035_materialize_owner_id_in_file_entries_table', 1),
(97, '2021_07_17_093454_add_created_at_col_to_user_role_table', 1),
(98, '2021_09_30_123758_slugify_tag_name_column', 1),
(99, '2021_10_13_132915_add_token_cols_to_social_profiles_table', 1),
(100, '2022_04_08_122553_change_default_workspace_id_from_null_to_zero', 1),
(101, '2022_04_23_115027_add_id_to_all_menus', 1),
(102, '2022_08_10_200344_add_produce_id_column_to_subscriptions_table', 1),
(103, '2022_08_11_160401_create_prices_table', 1),
(104, '2022_08_11_170041_create_products_table', 1),
(105, '2022_08_11_170117_move_billing_plans_to_products_and_prices_tables', 1),
(106, '2022_08_17_184337_add_card_expires_column_to_users_table', 1),
(107, '2022_08_24_192127_migrate_common_settings_to_v3', 1),
(108, '2022_09_03_164633_add_expires_at_column_to_personal_access_tokens_table', 1),
(109, '2022_09_28_121423_migrate_notif_settings_from_array_to_obj', 1),
(110, '2022_11_06_115107_increase_file_name_column_length', 1),
(111, '2023_03_17_175502_add_user_id_to_tags_table', 1),
(112, '2023_03_17_180355_change_name_index_to_name_user_id_in_tags_table', 1),
(113, '2023_05_09_124348_create_bans_table', 1),
(114, '2023_05_09_133514_add_banned_at_column_to_users_table', 1),
(115, '2023_05_11_200001_add_two_factor_columns_to_users_table', 1),
(116, '2023_05_13_132948_active_sessions_table', 1),
(117, '2023_05_16_150805_change_social_profiles_token_length', 1),
(118, '2023_06_07_000001_create_pulse_tables', 1),
(119, '2023_06_10_131615_add_pos_and_neg_votes_to_comments_table', 1),
(120, '2023_06_10_132135_add_comment_ratings_table', 1),
(121, '2023_06_11_124655_create_comment_reports_table', 1),
(122, '2023_08_08_103123_add_timestamp_indexes_to_comments_table', 1),
(123, '2023_08_31_124910_update_model_types_from_namespace_to_string', 1),
(124, '2023_09_14_172633_create_failed_jobs_table', 1),
(125, '2023_12_10_124446_upgrade_css_themes_table_to_v3', 1),
(126, '2023_12_18_141540_add_search_indices_to_users_table', 1),
(127, '2023_12_19_122804_add_uuid_column_to_failed_jobs_table', 1),
(128, '2023_12_23_121618_encrypt_secret_settings', 1),
(129, '2024_02_05_103042_change_avatar_column_to_text', 1),
(130, '2024_05_08_131134_add_gateway_status_column_to_subscriptions_table', 1),
(131, '2024_05_08_151815_increase_uuid_column_length_in_invoices_table', 1),
(132, '2024_05_10_151600_add_paypal_id_to_users_table', 1),
(133, '2024_05_12_133925_create_schedule_log_table', 1),
(134, '2024_05_15_123455_create_outgoing_email_log_table', 1),
(135, '2024_05_16_142030_create_otp_codes_table', 1),
(136, '2024_05_23_134009_add_logs_menu_item_to_admin_menu', 1),
(137, '2024_06_05_122254_add_notified_column_to_invoices_table', 1),
(138, '2024_06_15_123230_create_jobs_table', 1),
(139, '2024_07_27_153953_add_order_column_to_roles_table', 1),
(140, '2024_08_09_132933_add_type_column_to_css_themes_table', 1),
(141, '2024_08_26_125216_rename_avatar_to_image_in_users_table', 1),
(142, '2024_09_15_134634_make_owner_id_in_file_entries_table_nullable', 1),
(143, '2025_02_14_125923_rename_first_name_to_name_in_users_table', 1),
(144, '2025_02_14_130052_move_last_name_into_name_column', 1),
(145, '2025_02_17_135914_add_technology_columns_to_active_sessions_table', 1),
(146, '2025_02_20_134834_rename_active_sessions_table_to_user_sessions', 1),
(147, '2025_02_20_134834_rename_password_resets_table_to_password_reset_tokens', 1),
(148, '2025_02_21_143813_add_type_column_to_users_table', 1),
(149, '2025_03_01_140056_rename_env_keys_to_laravel_11_version', 1),
(150, '2025_04_24_133112_rename_sitewide_role_type_to_users', 1),
(151, '2025_04_24_153904_remove_unique_index_from_permissions_name', 1),
(152, '2025_04_25_115727_delete_old_permissions', 1),
(153, '2025_05_03_162427_remove_appearance_from_menu_settings', 1),
(154, '2025_05_07_132416_add_index_to_updated_at_in_user_sessions_table', 1),
(155, '2025_09_13_140753_rename-background-colors-to-bg', 1),
(156, '2025_09_18_134252_add_backend_id_and_upload_type_to_file_entries_table', 1),
(157, '2025_09_27_134839_migrate_storage_credentials_to_backends', 1),
(158, '2025_09_30_123336_add_relation_type_column_to_file_entry_models_table', 1),
(159, '2025_10_11_105157_make_country_in_user_sessions_nullable', 1),
(160, '2025_10_18_124509_rename_jpg_thumbnails_to_png', 1),
(161, '2025_10_29_151829_add_allow_direct_to_shareable_links_table', 1),
(162, '2025_11_09_144816_add_description_column_to_roles_table', 1),
(163, '2025_11_11_135628_fix_old_workspace_role_permissions_type', 1),
(164, '2025_11_22_125240_add_files_view_permission_to_workspace_roles', 1),
(165, '2025_12_26_152601_add_trial_days_column_to_products_table', 1),
(166, '2025_12_28_141731_add_amount_paid_and_status_columns_to_invoices_table', 1),
(167, '2025_12_28_142326_migrate_paid_column_to_status_in_invoices_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint(20) UNSIGNED NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notification_subscriptions`
--

CREATE TABLE `notification_subscriptions` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notif_id` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `channels` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `otp_codes`
--

CREATE TABLE `otp_codes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `outgoing_email_log`
--

CREATE TABLE `outgoing_email_log` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `message_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'not-sent',
  `from` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `to` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `mime` mediumblob
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissionables`
--

CREATE TABLE `permissionables` (
  `id` int(10) UNSIGNED NOT NULL,
  `permission_id` int(11) NOT NULL,
  `permissionable_id` int(11) NOT NULL,
  `permissionable_type` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `restrictions` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissionables`
--

INSERT INTO `permissionables` (`id`, `permission_id`, `permissionable_id`, `permissionable_type`, `restrictions`) VALUES
(1, 7, 1, 'user', NULL),
(2, 1, 1, 'role', '[]'),
(3, 2, 1, 'role', '[]'),
(4, 3, 1, 'role', '[]'),
(5, 4, 1, 'role', '[]'),
(6, 5, 1, 'role', '[]'),
(7, 22, 1, 'role', '[]'),
(8, 2, 2, 'role', '[]'),
(9, 1, 3, 'role', '[]'),
(10, 13, 3, 'role', '[]'),
(11, 18, 3, 'role', '[]'),
(12, 19, 3, 'role', '[]'),
(13, 20, 3, 'role', '[]'),
(14, 21, 3, 'role', '[]'),
(15, 22, 3, 'role', '[]'),
(16, 23, 3, 'role', '[]'),
(17, 24, 3, 'role', '[]'),
(18, 25, 3, 'role', '[]'),
(19, 1, 4, 'role', '[]'),
(20, 13, 4, 'role', '[]'),
(21, 21, 4, 'role', '[]'),
(22, 22, 4, 'role', '[]'),
(23, 23, 4, 'role', '[]'),
(24, 24, 4, 'role', '[]'),
(25, 25, 4, 'role', '[]'),
(26, 1, 5, 'role', '[]'),
(27, 22, 5, 'role', '[]'),
(28, 23, 5, 'role', '[]'),
(29, 21, 5, 'role', '[]');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'users'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `created_at`, `updated_at`, `type`) VALUES
(1, 'files.create', '2026-06-18 05:59:52', '2026-06-18 05:59:52', 'users'),
(2, 'links.view', '2026-06-18 05:59:52', '2026-06-18 05:59:52', 'users'),
(3, 'links.create', '2026-06-18 05:59:52', '2026-06-18 05:59:52', 'users'),
(4, 'workspaces.create', '2026-06-18 05:59:52', '2026-06-18 05:59:52', 'users'),
(5, 'api.access', '2026-06-18 05:59:52', '2026-06-18 05:59:52', 'users'),
(6, 'admin.access', '2026-06-18 05:59:52', '2026-06-18 05:59:52', 'users'),
(7, 'admin', '2026-06-18 05:59:52', '2026-06-18 05:59:52', 'users'),
(8, 'reports.view', '2026-06-18 05:59:52', '2026-06-18 05:59:52', 'users'),
(9, 'settings.update', '2026-06-18 05:59:52', '2026-06-18 05:59:52', 'users'),
(10, 'roles.update', '2026-06-18 05:59:52', '2026-06-18 05:59:52', 'users'),
(11, 'subscriptions.update', '2026-06-18 05:59:52', '2026-06-18 05:59:52', 'users'),
(12, 'localizations.update', '2026-06-18 05:59:52', '2026-06-18 05:59:52', 'users'),
(13, 'files.update', '2026-06-18 05:59:52', '2026-06-18 05:59:52', 'users'),
(14, 'tags.update', '2026-06-18 05:59:52', '2026-06-18 05:59:52', 'users'),
(15, 'users.update', '2026-06-18 05:59:52', '2026-06-18 05:59:52', 'users'),
(16, 'workspaces.update', '2026-06-18 05:59:52', '2026-06-18 05:59:52', 'users'),
(17, 'custom_pages.update', '2026-06-18 05:59:52', '2026-06-18 05:59:52', 'users'),
(18, 'workspace_members.invite', '2026-06-18 05:59:52', '2026-06-18 05:59:52', 'workspace'),
(19, 'workspace_members.update', '2026-06-18 05:59:52', '2026-06-18 05:59:52', 'workspace'),
(20, 'workspace_members.delete', '2026-06-18 05:59:52', '2026-06-18 05:59:52', 'workspace'),
(21, 'files.view', '2026-06-18 05:59:52', '2026-06-18 05:59:52', 'workspace'),
(22, 'files.create', '2026-06-18 05:59:52', '2026-06-18 05:59:52', 'workspace'),
(23, 'files.download', '2026-06-18 05:59:52', '2026-06-18 05:59:52', 'workspace'),
(24, 'files.update', '2026-06-18 05:59:52', '2026-06-18 05:59:52', 'workspace'),
(25, 'files.delete', '2026-06-18 05:59:52', '2026-06-18 05:59:52', 'workspace');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `prices`
--

CREATE TABLE `prices` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `amount` decimal(13,2) NOT NULL,
  `currency` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `interval` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'month',
  `interval_count` int(11) NOT NULL DEFAULT '1',
  `product_id` int(11) NOT NULL,
  `stripe_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paypal_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `uuid` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `feature_list` text COLLATE utf8mb4_unicode_ci,
  `position` smallint(6) NOT NULL DEFAULT '0',
  `recommended` tinyint(1) NOT NULL DEFAULT '0',
  `free` tinyint(1) NOT NULL DEFAULT '0',
  `trial_period_days` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `hidden` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pulse_aggregates`
--

CREATE TABLE `pulse_aggregates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `bucket` int(10) UNSIGNED NOT NULL,
  `period` mediumint(8) UNSIGNED NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `key_hash` binary(16) GENERATED ALWAYS AS (unhex(md5(`key`))) VIRTUAL,
  `aggregate` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` decimal(20,2) NOT NULL,
  `count` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pulse_entries`
--

CREATE TABLE `pulse_entries` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `timestamp` int(10) UNSIGNED NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `key_hash` binary(16) GENERATED ALWAYS AS (unhex(md5(`key`))) VIRTUAL,
  `value` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pulse_values`
--

CREATE TABLE `pulse_values` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `timestamp` int(10) UNSIGNED NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `key_hash` binary(16) GENERATED ALWAYS AS (unhex(md5(`key`))) VIRTUAL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `legacy_permissions` text COLLATE utf8mb4_unicode_ci,
  `default` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `guests` tinyint(1) UNSIGNED NOT NULL DEFAULT '0',
  `internal` tinyint(1) NOT NULL DEFAULT '0',
  `order` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'users',
  `permission_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'users'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `description`, `legacy_permissions`, `default`, `guests`, `internal`, `order`, `created_at`, `updated_at`, `type`, `permission_type`) VALUES
(1, 'Users', NULL, NULL, 1, 0, 1, 0, '2026-06-18 05:59:53', '2026-06-18 05:59:53', 'users', 'users'),
(2, 'Guests', NULL, NULL, 0, 1, 1, 0, '2026-06-18 05:59:54', '2026-06-18 05:59:54', 'users', 'users'),
(3, 'Workspace admin', 'Manage workspace content, members, settings and invite new members.', NULL, 0, 0, 0, 0, '2026-06-18 05:59:54', '2026-06-18 05:59:54', 'workspace', 'workspace'),
(4, 'Workspace editor', 'Add, edit, move and delete workspace files.', NULL, 0, 0, 0, 0, '2026-06-18 05:59:54', '2026-06-18 05:59:54', 'workspace', 'workspace'),
(5, 'Workspace contributor', 'View files and add new files to the workspace.', NULL, 0, 0, 0, 0, '2026-06-18 05:59:54', '2026-06-18 05:59:54', 'workspace', 'workspace');

-- --------------------------------------------------------

--
-- Table structure for table `schedule_log`
--

CREATE TABLE `schedule_log` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `command` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `output` text COLLATE utf8mb4_unicode_ci,
  `ran_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `duration` int(10) UNSIGNED NOT NULL,
  `count_in_last_hour` int(11) NOT NULL DEFAULT '1',
  `exit_code` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `private` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `name`, `value`, `created_at`, `updated_at`, `private`) VALUES
(1, 'uploading', 'eyJpdiI6Im9zQjNxNGMrNjAvZm45bDhQMXpVanc9PSIsInZhbHVlIjoiRTBvZGxIVkhCeGRKZTNWdTJVNzd4VC95bWk0Y1lQVE5nNmtkS2h4MEFSSWtmeXdBRG9CbWZlOURlODVKOEU2TDdSM2Zta05va3lIS05UWGN0SDNkc2JlMnkrZ2tlY0VDRUtCaTV4Y0FSVWEyK3BIRzdzMHdXODdyemoyaDVoZk9xSkF4eEVwUjh5N0dROTZ0SUp2NGpBZmIyMTYxZXJmUHFuaENpcDRjR3hrL2s4aHRjR25RRnVTMEVpR1U0VmdPd1JpWnpWZ3pGY3VFVUQ2a0FxTkxDZStIejlHR2hwbFlOQk1qU3FqQ1RtS2ZybFR0Tis4MEtpb21YQ04yb2k2ay9PRFhxZEZUUndjcit5dWZrcFdjSkN3N1hvdEllaCt1bC84ZXVjUFZMVFM2UmtTUnpwZ1BrTDZxYm5uRy9Pa0x0SitnQlRBYW5aaFRzZk5UNmJjK00wNVhnK3ZTeWZGUXI5RHVMYWU2YnZ3c1JpZGp6V1lpcWxvcVZmNUdaeHFYYnlGNFpXQnZmcERBVDlUdC9xMWJkN1JzYTRZdDRvemlGTVVJY2JFckQrQWtPc0l5TVJlbnd5WVJYNTdyOU5vVGdkUFNPcTF1eHFCVnoydWpnK01kTFJZR1gyYXY0QmJaeThnTzZtZHhhVCtBNFU2N05WNlN0czc5Z3lrZVQvQUZzc3hIL0JQQW9JRHJxZkc1OWFnZ2h4K3c3VXBQeUlXd2hWYldIWkFnUkl3Z3piNVhBcjFJbmQvRDJUcWlqcTNsIiwibWFjIjoiZjRjMDAzODk1ZTBiNTJhYmVkYTkzODg1YTZkMmI1YzZiYmQzYWYyZjY1ZmVjZGZkMTY4NGVkMDE4MjM3M2MwZiIsInRhZyI6IiJ9', NULL, NULL, 0),
(2, 'dates.format', 'short', '2026-06-18 05:59:53', '2026-06-18 05:59:53', 0),
(3, 'dates.locale', 'en_US', '2026-06-18 05:59:53', '2026-06-18 05:59:53', 0),
(4, 'dates.default_timezone', 'auto', '2026-06-18 05:59:53', '2026-06-18 05:59:53', 0),
(5, 'locale.default', 'auto', '2026-06-18 05:59:53', '2026-06-18 05:59:53', 0),
(6, 'social.google.enable', 'false', '2026-06-18 05:59:53', '2026-06-18 05:59:53', 0),
(7, 'social.twitter.enable', 'false', '2026-06-18 05:59:53', '2026-06-18 05:59:53', 0),
(8, 'social.facebook.enable', 'false', '2026-06-18 05:59:53', '2026-06-18 05:59:53', 0),
(9, 'social.compact_buttons', 'false', '2026-06-18 05:59:53', '2026-06-18 05:59:53', 0),
(10, 'realtime.enable', 'false', '2026-06-18 05:59:53', '2026-06-18 05:59:53', 0),
(11, 'registration.disable', 'false', '2026-06-18 05:59:53', '2026-06-18 05:59:53', 0),
(12, 'i18n.default_localization', 'en', '2026-06-18 05:59:53', '2026-06-18 05:59:53', 0),
(13, 'i18n.enable', 'true', '2026-06-18 05:59:53', '2026-06-18 05:59:53', 0),
(14, 'logging.sentry_public', '', '2026-06-18 05:59:53', '2026-06-18 05:59:53', 0),
(15, 'realtime.pusher_key', '', '2026-06-18 05:59:53', '2026-06-18 05:59:53', 0),
(16, 'themes.user_change', 'true', '2026-06-18 05:59:53', '2026-06-18 05:59:53', 0),
(17, 'themes.default_id', '0', '2026-06-18 05:59:53', '2026-06-18 05:59:53', 0),
(18, 'billing.enable', 'false', '2026-06-18 05:59:53', '2026-06-18 05:59:53', 0),
(19, 'billing.paypal_test_mode', 'true', '2026-06-18 05:59:53', '2026-06-18 05:59:53', 0),
(20, 'billing.stripe_test_mode', 'true', '2026-06-18 05:59:53', '2026-06-18 05:59:53', 0),
(21, 'billing.stripe.enable', 'false', '2026-06-18 05:59:53', '2026-06-18 05:59:53', 0),
(22, 'billing.paypal.enable', 'false', '2026-06-18 05:59:53', '2026-06-18 05:59:53', 0),
(23, 'cookie_notice.enable', 'false', '2026-06-18 05:59:53', '2026-06-18 05:59:53', 0),
(24, 'cookie_notice.position', 'bottom', '2026-06-18 05:59:53', '2026-06-18 05:59:53', 0),
(25, 'branding.logo_dark', 'storage/branding-images/06fef740-df07-4f64-96b7-0fd352159269.png', '2026-06-18 05:59:53', '2026-06-18 06:14:20', 0),
(26, 'branding.logo_light', 'storage/branding-images/d79e40a7-6917-4b92-8531-b7cf8dc9bdc7.png', '2026-06-18 05:59:53', '2026-06-18 06:14:20', 0),
(27, 'cache.report_minutes', '60', '2026-06-18 05:59:53', '2026-06-18 05:59:53', 0),
(28, 'homepage.type', 'landingPage', '2026-06-18 05:59:53', '2026-06-18 05:59:53', 0),
(29, 'landingPage', '{\"sections\":[{\"name\":\"hero-split-with-screenshot\",\"badge\":\"TCC: This is Areen Demo\",\"title\":\"Areen. A new home for your files.\",\"description\":\"Experience the next generation of cloud storage. Areen provides a secure, fast, and intuitive platform to store, share, and manage all your digital assets.\",\"image\":{\"src\":\"storage\\/branding-images\\/09f5b033-7a3a-4a4b-a3d0-3cb9910c3f71.webp\",\"width\":2432,\"height\":1442},\"buttons\":[{\"color\":\"primary\",\"variant\":\"flat\",\"label\":\"Get started\",\"type\":\"route\",\"action\":\"\\/pricing\"},{\"color\":\"default\",\"variant\":\"outline\",\"label\":\"Login\",\"type\":\"route\",\"action\":\"\\/login\"}],\"bgColors\":{}},{\"name\":\"features-grid\",\"badge\":\"POWERFUL FEATURES\",\"title\":\"Everything you need to manage your files\",\"description\":\"We built Areen with the tools you need to stay organized, efficient, and in control of your data, whether you\'re working alone or as part of a team.\",\"features\":[{\"title\":\"Large file uploads\",\"description\":\"Effortlessly upload massive files. Our resumable upload technology means a dropped connection won\'t stop your progress.\",\"icon\":\"fileUpload\"},{\"title\":\"Modern, intuitive interface\",\"description\":\"Navigate your files with ease. Switch between detailed list and visual grid views to find what you need, fast.\",\"icon\":\"dashboard\"},{\"title\":\"Enterprise-grade security\",\"description\":\"Your files are protected with end-to-end encryption and robust access controls, ensuring your data stays private\",\"icon\":\"lock\"},{\"title\":\"Access anywhere\",\"description\":\"Sync your files across all your devices\\u2014desktop, tablet, and mobile. Your work is always within reach.\",\"icon\":\"sync\"},{\"title\":\"Powerful search\",\"description\":\"Find the exact file you need in seconds with advanced search capabilities and built-in filters.\",\"icon\":\"search\"},{\"title\":\"Developer-friendly API\",\"description\":\"Integrate Areen into your existing workflow. Our robust Rest API allows for powerful custom automations.\",\"icon\":\"code\"}],\"maxColumns\":\"3\",\"iconsOnTop\":true},{\"name\":\"feature-with-screenshot\",\"badge\":\"SEAMLESS SHARING\",\"title\":\"Share your files, your way\",\"description\":\"Move projects forward by sharing files and folders securely with anyone. Set passwords, expiration dates, and permissions to maintain full control over your data.\",\"features\":[{\"title\":\"Invite via email.\",\"description\":\"Grant secure access to specific users or groups by simply entering their email address.\",\"icon\":\"email\"},{\"title\":\"Create shareable links.\",\"description\":\"Generate a secure link to any file or folder for easy sharing with clients, vendors, or external partners.\",\"icon\":\"share\"},{\"title\":\"Get direct links.\",\"description\":\"Link directly to assets like images or documents for easy embedding in websites, reports, or other applications.\",\"icon\":\"link\"}],\"image\":{\"src\":\"images\\/landing\\/share.webp\",\"width\":\"2432\",\"height\":\"1442\"},\"imageSize\":\"lg\",\"wrapIconsInBg\":true},{\"name\":\"feature-with-screenshot\",\"badge\":\"BUILT FOR TEAMS\",\"title\":\"Collaborate in shared workspaces\",\"description\":\"Create centralized, shared folders for your projects, departments, or entire company. Workspaces act as your team\'s single source of truth, ensuring everyone has the latest files.\",\"features\":[{\"title\":\"Centralized ownership.\",\"description\":\"Files remain in the Workspace even if team members change, ensuring business continuity and data retention.\",\"icon\":\"groups\"},{\"title\":\"Granular permissions.\",\"description\":\"Assign specific roles (like Viewer or Uploader) to different members within each Workspace to control who can do what.\",\"icon\":\"lock\"}],\"image\":{\"src\":\"images\\/landing\\/workspace.webp\",\"width\":\"2432\",\"height\":\"1442\"},\"alignLeft\":true,\"wrapIconsInBg\":true},{\"name\":\"feature-with-screenshot\",\"badge\":\"POWERFUL PREVIEWS\",\"title\":\"View your files without downloading\",\"description\":\"Save time and bandwidth with high-fidelity previews for over 100 file types. Review documents, watch videos, and listen to audio right from your browser\\u2014no software required.\",\"image\":{\"src\":\"images\\/landing\\/preview.webp\",\"width\":\"2432\",\"height\":\"1442\"},\"features\":[{\"title\":\"Rich media previews.\",\"description\":\"Stream high-definition video (MP4, MOV) and listen to audio files (MP3, WAV) instantly without waiting for a download.\",\"icon\":\"videoLibrary\"},{\"title\":\"Office & PDF previews.\",\"description\":\"Open and review Microsoft Office documents (Word, Excel, PowerPoint) and Adobe PDFs directly in BeDrive.\",\"icon\":\"pictureAsPdf\"}],\"wrapIconsInBg\":true},{\"name\":\"pricing\",\"title\":\"Find the plan that\'s right for you\",\"description\":\"From a generous free plan for personal use to powerful business plans with advanced collaboration tools and more storage, we have a simple option that fits your needs.\"},{\"name\":\"cta-simple-centered\",\"title\":\"Get started with Areen today\",\"description\":\"Sign up for free and get 10 GB of secure storage, or explore our business plans for advanced collaboration, unlimited space, and powerful admin tools.\",\"buttons\":[{\"color\":\"primary\",\"variant\":\"flat\",\"label\":\"Get started today \\u2192\",\"type\":\"route\",\"action\":\"\\/register\"}]},{\"name\":\"footer\"}]}', '2026-06-18 05:59:53', '2026-06-18 06:37:30', 0),
(30, 'drive.default_view', 'grid', '2026-06-18 05:59:53', '2026-06-18 05:59:53', 0),
(31, 'drive.send_share_notification', 'false', '2026-06-18 05:59:53', '2026-06-18 05:59:53', 0),
(32, 'share.suggest_emails', 'false', '2026-06-18 05:59:53', '2026-06-18 05:59:53', 0),
(33, 'drive.default_available_space', '1073741824', '2026-06-18 05:59:53', '2026-06-18 05:59:53', 0),
(34, 'drive.direct_links', 'true', '2026-06-18 05:59:53', '2026-06-18 05:59:53', 0),
(35, 'menus', '[{\"name\":\"Drive Sidebar\",\"positions\":[\"drive-sidebar\"],\"id\":\"v01akw\",\"items\":[{\"id\":\"wkd771\",\"type\":\"route\",\"order\":1,\"label\":\"Shared with me\",\"action\":\"\\/drive\\/shares\"},{\"id\":\"jo2m1s\",\"type\":\"route\",\"order\":2,\"label\":\"Recent\",\"action\":\"\\/drive\\/recent\"},{\"id\":\"4e6cie\",\"type\":\"route\",\"order\":3,\"label\":\"Starred\",\"action\":\"\\/drive\\/starred\"},{\"id\":\"h5p54n\",\"type\":\"route\",\"order\":4,\"label\":\"Trash\",\"action\":\"\\/drive\\/trash\"}]},{\"name\":\"footer\",\"id\":\"4tbwog\",\"positions\":[\"footer\"],\"items\":[{\"type\":\"route\",\"id\":\"c1sf2g\",\"position\":1,\"label\":\"Developers\",\"action\":\"\\/api-docs\",\"condition\":\"auth\",\"order\":0},{\"type\":\"route\",\"id\":\"rlz27v\",\"position\":2,\"label\":\"Privacy Policy\",\"action\":\"\\/pages\\/privacy-policy\",\"order\":1},{\"type\":\"route\",\"id\":\"p80pvk\",\"position\":3,\"label\":\"Terms of Service\",\"action\":\"\\/pages\\/terms-of-service\",\"order\":2},{\"type\":\"route\",\"id\":\"q8dtht\",\"position\":4,\"label\":\"Contact Us\",\"action\":\"\\/contact\",\"order\":3}]},{\"name\":\"Footer Social\",\"id\":\"odw4ah\",\"positions\":[\"footer-secondary\"],\"items\":[{\"type\":\"link\",\"id\":\"6j747e\",\"position\":1,\"action\":\"https:\\/\\/facebook.com\",\"order\":0},{\"type\":\"link\",\"id\":\"jo96zw\",\"position\":2,\"action\":\"https:\\/\\/twitter.com\",\"order\":1},{\"type\":\"link\",\"id\":\"57dsea\",\"position\":3,\"action\":\"https:\\/\\/instagram.com\",\"order\":2},{\"type\":\"link\",\"id\":\"lzntr2\",\"position\":4,\"action\":\"https:\\/\\/youtube.com\",\"order\":3}]},{\"name\":\"Auth Dropdown\",\"id\":\"h8r6vg\",\"items\":[{\"label\":\"Admin Area\",\"id\":\"upm1rv\",\"action\":\"\\/admin\\/reports\",\"type\":\"route\",\"permissions\":[\"admin.access\"],\"order\":0},{\"label\":\"My Files\",\"id\":\"ehj0uk\",\"action\":\"\\/drive\",\"type\":\"route\",\"order\":1},{\"label\":\"Account Settings\",\"id\":\"6a89z5\",\"action\":\"\\/account-settings\",\"type\":\"route\",\"order\":2}],\"positions\":[\"auth-dropdown\"]},{\"name\":\"Admin Sidebar\",\"id\":\"2d43u1\",\"items\":[{\"label\":\"Analytics\",\"id\":\"886nz4\",\"action\":\"\\/admin\\/reports\",\"type\":\"route\",\"condition\":\"admin\",\"role\":1,\"permissions\":[\"admin.access\"],\"roles\":[],\"order\":0},{\"label\":\"Settings\",\"id\":\"x5k484\",\"action\":\"\\/admin\\/settings\",\"type\":\"route\",\"permissions\":[\"settings.update\"],\"order\":1},{\"label\":\"Plans\",\"id\":\"7o42rt\",\"action\":\"\\/admin\\/plans\",\"type\":\"route\",\"settings\":{\"billing.enable\":true},\"permissions\":[\"plans.update\"],\"order\":2},{\"label\":\"Subscriptions\",\"action\":\"\\/admin\\/subscriptions\",\"type\":\"route\",\"id\":\"sdcb5a\",\"settings\":{\"billing.enable\":true},\"permissions\":[\"subscriptions.update\"],\"order\":3},{\"label\":\"Users\",\"action\":\"\\/admin\\/users\",\"type\":\"route\",\"id\":\"fzfb45\",\"permissions\":[\"users.update\"],\"order\":4},{\"label\":\"Roles\",\"action\":\"\\/admin\\/roles\",\"type\":\"route\",\"id\":\"mwdkf0\",\"permissions\":[\"roles.update\"],\"order\":5},{\"label\":\"Pages\",\"action\":\"\\/admin\\/custom-pages\",\"type\":\"route\",\"id\":\"63bwv9\",\"permissions\":[\"custom_pages.update\"],\"order\":6},{\"label\":\"Tags\",\"action\":\"\\/admin\\/tags\",\"type\":\"route\",\"id\":\"2x0pzq\",\"permissions\":[\"tags.update\"],\"order\":7},{\"label\":\"Files\",\"action\":\"\\/admin\\/files\",\"type\":\"route\",\"id\":\"vguvti\",\"permissions\":[\"files.update\"],\"order\":8},{\"label\":\"Localizations\",\"action\":\"\\/admin\\/localizations\",\"type\":\"route\",\"id\":\"w91yql\",\"permissions\":[\"localizations.update\"],\"order\":9},{\"label\":\"Logs\",\"action\":\"\\/admin\\/logs\",\"type\":\"route\",\"id\":\"8j435f\",\"order\":10}],\"positions\":[\"admin-sidebar\"]}]', '2026-06-18 05:59:53', '2026-06-18 05:59:53', 0),
(36, 'branding.favicon', 'favicon/icon-144x144.png?v=1781774060', '2026-06-18 05:59:54', '2026-06-18 06:14:20', 0);

-- --------------------------------------------------------

--
-- Table structure for table `shareable_links`
--

CREATE TABLE `shareable_links` (
  `id` int(10) UNSIGNED NOT NULL,
  `hash` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `entry_id` int(10) UNSIGNED NOT NULL,
  `allow_edit` tinyint(1) NOT NULL DEFAULT '0',
  `allow_download` tinyint(1) NOT NULL DEFAULT '1',
  `allow_direct` tinyint(1) NOT NULL DEFAULT '0',
  `password` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `social_profiles`
--

CREATE TABLE `social_profiles` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `service_name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_service_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `access_token` text COLLATE utf8mb4_unicode_ci,
  `refresh_token` text COLLATE utf8mb4_unicode_ci,
  `access_expires_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subscriptions`
--

CREATE TABLE `subscriptions` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `price_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gateway_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'none',
  `gateway_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gateway_status` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `quantity` int(11) NOT NULL DEFAULT '1',
  `description` text COLLATE utf8mb4_unicode_ci,
  `trial_ends_at` timestamp NULL DEFAULT NULL,
  `ends_at` timestamp NULL DEFAULT NULL,
  `renews_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `product_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `taggables`
--

CREATE TABLE `taggables` (
  `id` int(10) UNSIGNED NOT NULL,
  `tag_id` int(10) UNSIGNED NOT NULL,
  `taggable_id` int(10) UNSIGNED NOT NULL,
  `taggable_type` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE `tags` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'custom',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tags`
--

INSERT INTO `tags` (`id`, `name`, `display_name`, `type`, `created_at`, `updated_at`, `user_id`) VALUES
(1, 'starred', 'Starred', 'label', '2026-06-18 05:59:54', '2026-06-18 05:59:54', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `uploads`
--

CREATE TABLE `uploads` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_size` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mime` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `extension` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `thumbnail_url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `public` tinyint(1) NOT NULL DEFAULT '0',
  `path` varchar(191) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar_url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `legacy_permissions` text COLLATE utf8mb4_unicode_ci,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `password` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `two_factor_secret` text COLLATE utf8mb4_unicode_ci,
  `two_factor_recovery_codes` text COLLATE utf8mb4_unicode_ci,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `card_brand` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_last_four` varchar(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `space_available` bigint(20) UNSIGNED DEFAULT NULL,
  `language` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `timezone` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` text COLLATE utf8mb4_unicode_ci,
  `stripe_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paypal_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `card_expires` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `banned_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `name`, `avatar_url`, `gender`, `legacy_permissions`, `email`, `type`, `password`, `two_factor_secret`, `two_factor_recovery_codes`, `two_factor_confirmed_at`, `card_brand`, `card_last_four`, `remember_token`, `created_at`, `updated_at`, `space_available`, `language`, `country`, `timezone`, `image`, `stripe_id`, `paypal_id`, `email_verified_at`, `card_expires`, `banned_at`) VALUES
(1, NULL, NULL, NULL, NULL, NULL, 'admin@admin.com', 'user', '$2y$12$AgSXaeMOWC7isuS07hzyXujbSwIKBE174thVjnohtNmB/RM0lhFcS', NULL, NULL, NULL, NULL, NULL, 'Yx51JJ4WJwHU7aXgTTryf3Ju8DWidMCJmDJeuwRtsVq9JRI9NYmr5eUICNkC', '2026-06-18 05:59:53', '2026-06-18 05:59:53', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2026-06-18 05:59:53', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_role`
--

CREATE TABLE `user_role` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_sessions`
--

CREATE TABLE `user_sessions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `session_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `browser` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unknown',
  `platform` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unknown',
  `device` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unknown',
  `country` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_sessions`
--

INSERT INTO `user_sessions` (`id`, `session_id`, `token`, `user_id`, `ip_address`, `browser`, `platform`, `device`, `country`, `city`, `user_agent`, `created_at`, `updated_at`) VALUES
(1, 'lVBJiIwlsyLeIny5YoWSLem6dEJWzcC7c5LQyk7z', NULL, 1, '::1', 'Chrome', 'OS X', 'desktop', '', NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-18 06:00:04', '2026-06-18 06:01:05'),
(2, 'KtFfGEqKNiaeu2HvbpjignHM0WobDsbwwkAF4278', NULL, 1, '::1', 'Chrome', 'OS X', 'desktop', '', NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-18 06:20:55', '2026-06-18 06:29:18'),
(3, 'YxniYFVCVZsZZZIyKCSGFeLzJUJdU1t6gTjEmwdj', NULL, 1, '::1', 'Chrome', 'OS X', 'desktop', '', NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-18 06:36:23', '2026-06-18 06:47:48'),
(4, 'uhF9ZkQUzedJgwob0lvHuUX0wuLrKrW2tcAFfztT', NULL, 1, '::1', 'Chrome', 'OS X', 'desktop', '', NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-18 06:53:52', '2026-06-18 06:53:52'),
(5, 'XIXNpjTGv8ZbPcRN87J2rNkJZWDTJoXpg4Xkb1jA', NULL, 1, '::1', 'Chrome', 'OS X', 'desktop', '', NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-29 09:57:24', '2026-06-29 09:57:24'),
(6, 'Nwb5O1DfdUTylNEAjMPN25RZ0DDiragcjke0MNep', NULL, 1, '::1', 'Chrome', 'OS X', 'desktop', '', NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-06-29 10:07:16', '2026-06-29 10:10:52'),
(7, 'xDDY2B9DhpzkHDqu7nFJFj56nJhgF9kZE6W3BhaP', NULL, 1, '::1', 'Chrome', 'OS X', 'desktop', '', NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36', '2026-07-12 03:50:39', '2026-07-12 05:07:55');

-- --------------------------------------------------------

--
-- Table structure for table `workspaces`
--

CREATE TABLE `workspaces` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `workspace_invites`
--

CREATE TABLE `workspace_invites` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` text COLLATE utf8mb4_unicode_ci,
  `workspace_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `email` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `workspace_user`
--

CREATE TABLE `workspace_user` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `workspace_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED DEFAULT NULL,
  `is_owner` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bans`
--
ALTER TABLE `bans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bans_bannable_type_bannable_id_index` (`bannable_type`,`bannable_id`),
  ADD KEY `bans_created_by_type_created_by_id_index` (`created_by_type`,`created_by_id`),
  ADD KEY `bans_expired_at_index` (`expired_at`);

--
-- Indexes for table `billing_plans`
--
ALTER TABLE `billing_plans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `billing_plans_hidden_index` (`hidden`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comments_parent_id_index` (`parent_id`),
  ADD KEY `comments_path_index` (`path`),
  ADD KEY `comments_user_id_index` (`user_id`),
  ADD KEY `comments_commentable_id_index` (`commentable_id`),
  ADD KEY `comments_commentable_type_index` (`commentable_type`),
  ADD KEY `comments_deleted_index` (`deleted`),
  ADD KEY `comments_upvotes_index` (`upvotes`),
  ADD KEY `comments_downvotes_index` (`downvotes`),
  ADD KEY `comments_created_at_index` (`created_at`),
  ADD KEY `comments_updated_at_index` (`updated_at`);

--
-- Indexes for table `comment_reports`
--
ALTER TABLE `comment_reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comment_reports_user_id_index` (`user_id`),
  ADD KEY `comment_reports_comment_id_index` (`comment_id`);

--
-- Indexes for table `comment_votes`
--
ALTER TABLE `comment_votes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `comment_votes_user_ip_comment_id_unique` (`user_ip`,`comment_id`),
  ADD UNIQUE KEY `comment_votes_user_id_comment_id_unique` (`user_id`,`comment_id`),
  ADD KEY `comment_votes_user_id_index` (`user_id`),
  ADD KEY `comment_votes_comment_id_index` (`comment_id`),
  ADD KEY `comment_votes_user_ip_index` (`user_ip`);

--
-- Indexes for table `css_themes`
--
ALTER TABLE `css_themes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `css_themes_default_light_index` (`default_light`),
  ADD KEY `css_themes_default_dark_index` (`default_dark`),
  ADD KEY `css_themes_user_id_index` (`user_id`),
  ADD KEY `css_themes_type_index` (`type`);

--
-- Indexes for table `csv_exports`
--
ALTER TABLE `csv_exports`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `csv_exports_cache_name_unique` (`cache_name`),
  ADD KEY `csv_exports_user_id_index` (`user_id`);

--
-- Indexes for table `custom_domains`
--
ALTER TABLE `custom_domains`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `custom_domains_host_unique` (`host`),
  ADD KEY `custom_domains_user_id_index` (`user_id`),
  ADD KEY `custom_domains_created_at_index` (`created_at`),
  ADD KEY `custom_domains_updated_at_index` (`updated_at`),
  ADD KEY `custom_domains_global_index` (`global`),
  ADD KEY `custom_domains_resource_id_index` (`resource_id`),
  ADD KEY `custom_domains_resource_type_index` (`resource_type`),
  ADD KEY `custom_domains_workspace_id_index` (`workspace_id`);

--
-- Indexes for table `custom_pages`
--
ALTER TABLE `custom_pages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pages_slug_unique` (`slug`),
  ADD KEY `pages_type_index` (`type`),
  ADD KEY `pages_user_id_index` (`user_id`),
  ADD KEY `custom_pages_workspace_id_index` (`workspace_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `fcm_tokens`
--
ALTER TABLE `fcm_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `fcm_tokens_device_id_user_id_unique` (`device_id`,`user_id`),
  ADD KEY `fcm_tokens_device_id_index` (`device_id`),
  ADD KEY `fcm_tokens_token_index` (`token`),
  ADD KEY `fcm_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `file_entries`
--
ALTER TABLE `file_entries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `files_user_id_index` (`user_id`),
  ADD KEY `files_folder_id_index` (`parent_id`),
  ADD KEY `file_entries_name_index` (`name`),
  ADD KEY `file_entries_path_index` (`path`),
  ADD KEY `file_entries_type_index` (`type`),
  ADD KEY `file_entries_public_index` (`public`),
  ADD KEY `file_entries_description_index` (`description`),
  ADD KEY `file_entries_workspace_id_index` (`workspace_id`),
  ADD KEY `file_entries_owner_id_index` (`owner_id`),
  ADD KEY `file_entries_backend_id_index` (`backend_id`),
  ADD KEY `file_entries_upload_type_index` (`upload_type`);

--
-- Indexes for table `file_entry_models`
--
ALTER TABLE `file_entry_models`
  ADD PRIMARY KEY (`id`),
  ADD KEY `file_entry_models_owner_index` (`owner`),
  ADD KEY `mt_mi_rt_index` (`model_type`,`model_id`,`relation_type`),
  ADD KEY `file_entry_models_relation_type_index` (`relation_type`),
  ADD KEY `file_entry_models_origin_index` (`origin`);

--
-- Indexes for table `folders`
--
ALTER TABLE `folders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `folders_user_id_index` (`user_id`),
  ADD KEY `folders_share_id_index` (`share_id`),
  ADD KEY `folders_folder_id_index` (`folder_id`);

--
-- Indexes for table `follows`
--
ALTER TABLE `follows`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `follows_follower_id_followed_id_unique` (`follower_id`,`followed_id`);

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invoices_subscription_id_index` (`subscription_id`),
  ADD KEY `invoices_uuid_index` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_reserved_at_index` (`queue`,`reserved_at`);

--
-- Indexes for table `localizations`
--
ALTER TABLE `localizations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `localizations_name_index` (`name`),
  ADD KEY `localizations_language_index` (`language`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

--
-- Indexes for table `notification_subscriptions`
--
ALTER TABLE `notification_subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notification_subscriptions_notif_id_index` (`notif_id`),
  ADD KEY `notification_subscriptions_user_id_index` (`user_id`);

--
-- Indexes for table `otp_codes`
--
ALTER TABLE `otp_codes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `otp_codes_user_id_index` (`user_id`),
  ADD KEY `otp_codes_expires_at_index` (`expires_at`);

--
-- Indexes for table `outgoing_email_log`
--
ALTER TABLE `outgoing_email_log`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `outgoing_email_log_message_id_unique` (`message_id`),
  ADD KEY `outgoing_email_log_status_index` (`status`),
  ADD KEY `outgoing_email_log_from_index` (`from`),
  ADD KEY `outgoing_email_log_to_index` (`to`),
  ADD KEY `outgoing_email_log_created_at_index` (`created_at`),
  ADD KEY `outgoing_email_log_updated_at_index` (`updated_at`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `permissionables`
--
ALTER TABLE `permissionables`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissionable_unique` (`permission_id`,`permissionable_id`,`permissionable_type`),
  ADD KEY `permissionables_permission_id_index` (`permission_id`),
  ADD KEY `permissionables_permissionable_id_index` (`permissionable_id`),
  ADD KEY `permissionables_permissionable_type_index` (`permissionable_type`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_type_unique` (`name`,`type`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `prices`
--
ALTER TABLE `prices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `prices_product_id_index` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_position_index` (`position`),
  ADD KEY `products_free_index` (`free`),
  ADD KEY `products_hidden_index` (`hidden`);

--
-- Indexes for table `pulse_aggregates`
--
ALTER TABLE `pulse_aggregates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pulse_b_p_t_a_k_unique` (`bucket`,`period`,`type`,`aggregate`,`key_hash`),
  ADD KEY `pulse_aggregates_period_bucket_index` (`period`,`bucket`),
  ADD KEY `pulse_aggregates_type_index` (`type`),
  ADD KEY `pulse_aggregates_period_type_aggregate_bucket_index` (`period`,`type`,`aggregate`,`bucket`);

--
-- Indexes for table `pulse_entries`
--
ALTER TABLE `pulse_entries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pulse_entries_timestamp_index` (`timestamp`),
  ADD KEY `pulse_entries_type_index` (`type`),
  ADD KEY `pulse_entries_key_hash_index` (`key_hash`),
  ADD KEY `pulse_entries_timestamp_type_key_hash_value_index` (`timestamp`,`type`,`key_hash`,`value`);

--
-- Indexes for table `pulse_values`
--
ALTER TABLE `pulse_values`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pulse_values_type_key_hash_unique` (`type`,`key_hash`),
  ADD KEY `pulse_values_timestamp_index` (`timestamp`),
  ADD KEY `pulse_values_type_index` (`type`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `groups_name_unique` (`name`),
  ADD KEY `groups_default_index` (`default`),
  ADD KEY `groups_guests_index` (`guests`),
  ADD KEY `roles_internal_index` (`internal`),
  ADD KEY `roles_order_index` (`order`),
  ADD KEY `roles_permission_type_index` (`permission_type`);

--
-- Indexes for table `schedule_log`
--
ALTER TABLE `schedule_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `schedule_log_command_index` (`command`),
  ADD KEY `schedule_log_ran_at_index` (`ran_at`),
  ADD KEY `schedule_log_duration_index` (`duration`),
  ADD KEY `schedule_log_exit_code_index` (`exit_code`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `settings_name_unique` (`name`),
  ADD KEY `settings_private_index` (`private`);

--
-- Indexes for table `shareable_links`
--
ALTER TABLE `shareable_links`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `shareable_links_hash_unique` (`hash`),
  ADD KEY `shareable_links_user_id_index` (`user_id`),
  ADD KEY `shareable_links_entry_id_index` (`entry_id`),
  ADD KEY `shareable_links_allow_direct_index` (`allow_direct`);

--
-- Indexes for table `social_profiles`
--
ALTER TABLE `social_profiles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `social_profiles_user_id_service_name_unique` (`user_id`,`service_name`),
  ADD UNIQUE KEY `social_profiles_service_name_user_service_id_unique` (`service_name`,`user_service_id`),
  ADD KEY `social_profiles_user_id_index` (`user_id`);

--
-- Indexes for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `subscriptions_gateway_id_unique` (`gateway_id`),
  ADD KEY `subscriptions_user_id_index` (`user_id`),
  ADD KEY `subscriptions_plan_id_index` (`price_id`),
  ADD KEY `subscriptions_gateway_index` (`gateway_name`),
  ADD KEY `subscriptions_product_id_index` (`product_id`),
  ADD KEY `subscriptions_gateway_status_index` (`gateway_status`);

--
-- Indexes for table `taggables`
--
ALTER TABLE `taggables`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `taggable_unique` (`tag_id`,`taggable_id`,`user_id`,`taggable_type`),
  ADD KEY `taggables_tag_id_index` (`tag_id`),
  ADD KEY `taggables_taggable_id_index` (`taggable_id`),
  ADD KEY `taggables_taggable_type_index` (`taggable_type`),
  ADD KEY `taggables_user_id_index` (`user_id`);

--
-- Indexes for table `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tags_name_user_id_type_unique` (`name`,`user_id`,`type`),
  ADD KEY `tags_type_index` (`type`),
  ADD KEY `tags_created_at_index` (`created_at`),
  ADD KEY `tags_updated_at_index` (`updated_at`),
  ADD KEY `tags_user_id_index` (`user_id`);

--
-- Indexes for table `uploads`
--
ALTER TABLE `uploads`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uploads_file_name_unique` (`file_name`),
  ADD KEY `uploads_name_index` (`name`),
  ADD KEY `uploads_user_id_index` (`user_id`),
  ADD KEY `uploads_public_index` (`public`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_paypal_id_unique` (`paypal_id`),
  ADD KEY `users_created_at_index` (`created_at`),
  ADD KEY `users_updated_at_index` (`updated_at`),
  ADD KEY `users_username_index` (`username`),
  ADD KEY `users_first_name_index` (`name`),
  ADD KEY `users_type_index` (`type`);

--
-- Indexes for table `user_role`
--
ALTER TABLE `user_role`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_group_user_id_group_id_unique` (`user_id`,`role_id`);

--
-- Indexes for table `user_sessions`
--
ALTER TABLE `user_sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `active_sessions_session_id_index` (`session_id`),
  ADD KEY `active_sessions_token_index` (`token`),
  ADD KEY `active_sessions_user_id_index` (`user_id`),
  ADD KEY `active_sessions_browser_index` (`browser`),
  ADD KEY `active_sessions_platform_index` (`platform`),
  ADD KEY `active_sessions_device_index` (`device`),
  ADD KEY `active_sessions_country_index` (`country`),
  ADD KEY `active_sessions_city_index` (`city`),
  ADD KEY `user_sessions_updated_at_index` (`updated_at`);

--
-- Indexes for table `workspaces`
--
ALTER TABLE `workspaces`
  ADD PRIMARY KEY (`id`),
  ADD KEY `workspaces_owner_id_index` (`owner_id`),
  ADD KEY `workspaces_created_at_index` (`created_at`),
  ADD KEY `workspaces_updated_at_index` (`updated_at`);

--
-- Indexes for table `workspace_invites`
--
ALTER TABLE `workspace_invites`
  ADD PRIMARY KEY (`id`),
  ADD KEY `workspace_invites_workspace_id_index` (`workspace_id`),
  ADD KEY `workspace_invites_user_id_index` (`user_id`),
  ADD KEY `workspace_invites_email_index` (`email`),
  ADD KEY `workspace_invites_role_id_index` (`role_id`);

--
-- Indexes for table `workspace_user`
--
ALTER TABLE `workspace_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `workspace_user_workspace_id_user_id_unique` (`workspace_id`,`user_id`),
  ADD KEY `workspace_user_user_id_index` (`user_id`),
  ADD KEY `workspace_user_workspace_id_index` (`workspace_id`),
  ADD KEY `workspace_user_role_id_index` (`role_id`),
  ADD KEY `workspace_user_is_owner_index` (`is_owner`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bans`
--
ALTER TABLE `bans`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `billing_plans`
--
ALTER TABLE `billing_plans`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `comment_reports`
--
ALTER TABLE `comment_reports`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `comment_votes`
--
ALTER TABLE `comment_votes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `css_themes`
--
ALTER TABLE `css_themes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `csv_exports`
--
ALTER TABLE `csv_exports`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `custom_domains`
--
ALTER TABLE `custom_domains`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `custom_pages`
--
ALTER TABLE `custom_pages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fcm_tokens`
--
ALTER TABLE `fcm_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `file_entries`
--
ALTER TABLE `file_entries`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `file_entry_models`
--
ALTER TABLE `file_entry_models`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `folders`
--
ALTER TABLE `folders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `follows`
--
ALTER TABLE `follows`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `localizations`
--
ALTER TABLE `localizations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=168;

--
-- AUTO_INCREMENT for table `otp_codes`
--
ALTER TABLE `otp_codes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `outgoing_email_log`
--
ALTER TABLE `outgoing_email_log`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissionables`
--
ALTER TABLE `permissionables`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `prices`
--
ALTER TABLE `prices`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pulse_aggregates`
--
ALTER TABLE `pulse_aggregates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pulse_entries`
--
ALTER TABLE `pulse_entries`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pulse_values`
--
ALTER TABLE `pulse_values`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `schedule_log`
--
ALTER TABLE `schedule_log`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `shareable_links`
--
ALTER TABLE `shareable_links`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `social_profiles`
--
ALTER TABLE `social_profiles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `taggables`
--
ALTER TABLE `taggables`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `uploads`
--
ALTER TABLE `uploads`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_role`
--
ALTER TABLE `user_role`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_sessions`
--
ALTER TABLE `user_sessions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `workspaces`
--
ALTER TABLE `workspaces`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `workspace_user`
--
ALTER TABLE `workspace_user`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
