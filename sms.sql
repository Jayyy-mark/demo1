/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.8.5-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: sms
-- ------------------------------------------------------
-- Server version	11.8.5-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Current Database: `sms`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `sms` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `sms`;

--
-- Table structure for table `academic_calendars`
--

DROP TABLE IF EXISTS `academic_calendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `academic_calendars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` text DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'Pending',
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academic_calendars`
--

LOCK TABLES `academic_calendars` WRITE;
/*!40000 ALTER TABLE `academic_calendars` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `academic_calendars` VALUES
(6,'For welcoming and orientation to fresh students','Fresher Welcome','On Progress','2026-06-04','2026-06-10'),
(7,'testing','graduaiton','Pending','2026-06-19','2026-06-22'),
(8,'Event where students compete football with their respected class organized teams','football match','Pending','2026-06-29','2026-06-30'),
(9,'','Orientation of Internship Companies','Pending','2026-07-08','2026-07-08'),
(10,'testing','testing','On Progress','2026-07-01','2026-07-01');
/*!40000 ALTER TABLE `academic_calendars` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `activities`
--

DROP TABLE IF EXISTS `activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `activities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `activity_name` varchar(100) NOT NULL,
  `category` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `filename` varchar(225) DEFAULT NULL,
  `filepath` varchar(225) DEFAULT NULL,
  `date` date NOT NULL,
  `activity_type` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `filename` (`filename`),
  UNIQUE KEY `filepath` (`filepath`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activities`
--

LOCK TABLES `activities` WRITE;
/*!40000 ALTER TABLE `activities` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `activities` VALUES
(10,'သင်ကြားသင်ယူ မှု များ','Education','','activity_1_3.jpg','media/activities\\activity_1_3.jpg','2022-06-07','activity'),
(11,'သင်ကြားသင်ယူ မှု များ','Education','','activity_1_4.jpg','media/activities\\activity_1_4.jpg','2022-06-07','activity'),
(12,'သင်ကြားသင်ယူ မှု များ','Education','','activity_1_5.jpg','media/activities\\activity_1_5.jpg','2022-06-07','activity'),
(13,'သင်ကြားသင်ယူ မှု များ','Education','','activity_1_6.jpg','media/activities\\activity_1_6.jpg','2022-06-07','activity'),
(14,'သင်ကြားသင်ယူ မှု များ','Education','','activity_1_7.jpg','media/activities\\activity_1_7.jpg','2022-06-07','activity'),
(15,'သင်ကြားသင်ယူ မှု များ','Education','','activity_1_8.jpg','media/activities\\activity_1_8.jpg','2022-06-07','activity'),
(16,'တောင်ငူခရိုင် လူငယ်များ စာဖတ်ရှိန်မြှင့်တင်ရေးပွဲတော်','Project','တောင်ငူခရိုင် လူငယ်များ စာဖတ်ရှိန်မြှင့်တင်ရေးပွဲတော်တွင် ကွန်ပျူတာတက္ကသိုလ်(တောင်ငူ)မှ AI Project များပါ၀င်ပြသခြင်း','activity_2_1.jpg','media/activities\\activity_2_1.jpg','2025-12-12','activity'),
(17,'တောင်ငူခရိုင် လူငယ်များ စာဖတ်ရှိန်မြှင့်တင်ရေးပွဲတော်','Project','တောင်ငူခရိုင် လူငယ်များ စာဖတ်ရှိန်မြှင့်တင်ရေးပွဲတော်တွင် ကွန်ပျူတာတက္ကသိုလ်(တောင်ငူ)မှ AI Project များပါ၀င်ပြသခြင်း','activity_2_2.jpg','media/activities\\activity_2_2.jpg','2025-12-12','activity'),
(18,'တောင်ငူခရိုင် လူငယ်များ စာဖတ်ရှိန်မြှင့်တင်ရေးပွဲတော်','Project','တောင်ငူခရိုင် လူငယ်များ စာဖတ်ရှိန်မြှင့်တင်ရေးပွဲတော်တွင် ကွန်ပျူတာတက္ကသိုလ်(တောင်ငူ)မှ AI Project များပါ၀င်ပြသခြင်း','activity_2_3.jpg','media/activities\\activity_2_3.jpg','2025-12-12','activity'),
(19,'တောင်ငူခရိုင် လူငယ်များ စာဖတ်ရှိန်မြှင့်တင်ရေးပွဲတော်','Project','တောင်ငူခရိုင် လူငယ်များ စာဖတ်ရှိန်မြှင့်တင်ရေးပွဲတော်တွင် ကွန်ပျူတာတက္ကသိုလ်(တောင်ငူ)မှ AI Project များပါ၀င်ပြသခြင်း','activity_2_4.jpg','media/activities\\activity_2_4.jpg','2025-12-12','activity'),
(20,'တောင်ငူခရိုင် လူငယ်များ စာဖတ်ရှိန်မြှင့်တင်ရေးပွဲတော်','Project','တောင်ငူခရိုင် လူငယ်များ စာဖတ်ရှိန်မြှင့်တင်ရေးပွဲတော်တွင် ကွန်ပျူတာတက္ကသိုလ်(တောင်ငူ)မှ AI Project များပါ၀င်ပြသခြင်း','activity_2_5.jpg','media/activities\\activity_2_5.jpg','2025-12-12','activity'),
(21,'တောင်ငူခရိုင် လူငယ်များ စာဖတ်ရှိန်မြှင့်တင်ရေးပွဲတော်','Project','တောင်ငူခရိုင် လူငယ်များ စာဖတ်ရှိန်မြှင့်တင်ရေးပွဲတော်တွင် ကွန်ပျူတာတက္ကသိုလ်(တောင်ငူ)မှ AI Project များပါ၀င်ပြသခြင်း','activity_2_6.jpg','media/activities\\activity_2_6.jpg','2025-12-12','activity'),
(22,'၀ါဆိုသင်္ကန်းကပ်လှူပူဇော်ပွဲအခမ်းအနား','Religion','ကွန်ပျူတာ တက္ကသိုလ်တောင်ငူမှ ပါမောက္ခချုပ်ကြီးနဲ့ တကွ ဆရာ၊ ဆရာမများ ၊ ကျောင်းသား ၊ကျောင်းသူ များ၊ ၀န်ထမ်းများ ပူးပေါင်း၍ ဝါဆိုသက်န်း ကပ်လှူပူဇော်ခြင်း','activity_3_1.jpg','media/activities\\activity_3_1.jpg','2025-07-19','activity'),
(23,'၀ါဆိုသင်္ကန်းကပ်လှူပူဇော်ပွဲအခမ်းအနား','Religion','ကွန်ပျူတာ တက္ကသိုလ်တောင်ငူမှ ပါမောက္ခချုပ်ကြီးနဲ့ တကွ ဆရာ၊ ဆရာမများ ၊ ကျောင်းသား ၊ကျောင်းသူ များ၊ ၀န်ထမ်းများ ပူးပေါင်း၍ ဝါဆိုသက်န်း ကပ်လှူပူဇော်ခြင်း','activity_3_2.jpg','media/activities\\activity_3_2.jpg','2025-07-19','activity'),
(24,'၀ါဆိုသင်္ကန်းကပ်လှူပူဇော်ပွဲအခမ်းအနား','Religion','ကွန်ပျူတာ တက္ကသိုလ်တောင်ငူမှ ပါမောက္ခချုပ်ကြီးနဲ့ တကွ ဆရာ၊ ဆရာမများ ၊ ကျောင်းသား ၊ကျောင်းသူ များ၊ ၀န်ထမ်းများ ပူးပေါင်း၍ ဝါဆိုသက်န်း ကပ်လှူပူဇော်ခြင်း','activity_3_3.jpg','media/activities\\activity_3_3.jpg','2025-07-19','activity'),
(25,'၀ါဆိုသင်္ကန်းကပ်လှူပူဇော်ပွဲအခမ်းအနား','Religion','ကွန်ပျူတာ တက္ကသိုလ်တောင်ငူမှ ပါမောက္ခချုပ်ကြီးနဲ့ တကွ ဆရာ၊ ဆရာမများ ၊ ကျောင်းသား ၊ကျောင်းသူ များ၊ ၀န်ထမ်းများ ပူးပေါင်း၍ ဝါဆိုသက်န်း ကပ်လှူပူဇော်ခြင်း','activity_3_4.jpg','media/activities\\activity_3_4.jpg','2025-07-19','activity'),
(26,'၀ါဆိုသင်္ကန်းကပ်လှူပူဇော်ပွဲအခမ်းအနား','Religion','ကွန်ပျူတာ တက္ကသိုလ်တောင်ငူမှ ပါမောက္ခချုပ်ကြီးနဲ့ တကွ ဆရာ၊ ဆရာမများ ၊ ကျောင်းသား ၊ကျောင်းသူ များ၊ ၀န်ထမ်းများ ပူးပေါင်း၍ ဝါဆိုသက်န်း ကပ်လှူပူဇော်ခြင်း','activity_3_5.jpg','media/activities\\activity_3_5.jpg','2025-07-19','activity'),
(27,'၀ါဆိုသင်္ကန်းကပ်လှူပူဇော်ပွဲအခမ်းအနား','Religion','ကွန်ပျူတာ တက္ကသိုလ်တောင်ငူမှ ပါမောက္ခချုပ်ကြီးနဲ့ တကွ ဆရာ၊ ဆရာမများ ၊ ကျောင်းသား ၊ကျောင်းသူ များ၊ ၀န်ထမ်းများ ပူးပေါင်း၍ ဝါဆိုသက်န်း ကပ်လှူပူဇော်ခြင်း','activity_3_6.jpg','media/activities\\activity_3_6.jpg','2025-07-19','activity'),
(28,'၀ါဆိုသင်္ကန်းကပ်လှူပူဇော်ပွဲအခမ်းအနား','Religion','ကွန်ပျူတာ တက္ကသိုလ်တောင်ငူမှ ပါမောက္ခချုပ်ကြီးနဲ့ တကွ ဆရာ၊ ဆရာမများ ၊ ကျောင်းသား ၊ကျောင်းသူ များ၊ ၀န်ထမ်းများ ပူးပေါင်း၍ ဝါဆိုသက်န်း ကပ်လှူပူဇော်ခြင်း','activity_3_7.jpg','media/activities\\activity_3_7.jpg','2025-07-19','activity'),
(29,'၀ါဆိုသင်္ကန်းကပ်လှူပူဇော်ပွဲအခမ်းအနား','Religion','ကွန်ပျူတာ တက္ကသိုလ်တောင်ငူမှ ပါမောက္ခချုပ်ကြီးနဲ့ တကွ ဆရာ၊ ဆရာမများ ၊ ကျောင်းသား ၊ကျောင်းသူ များ၊ ၀န်ထမ်းများ ပူးပေါင်း၍ ဝါဆိုသက်န်း ကပ်လှူပူဇော်ခြင်း','activity_3_8.jpg','media/activities\\activity_3_8.jpg','2025-07-19','activity'),
(30,'Fresher Welcome','Activity','','activity_4_1.jpg','media/activities\\activity_4_1.jpg','2024-01-19','activity'),
(31,'Fresher Welcome','Activity','','activity_4_2.jpg','media/activities\\activity_4_2.jpg','2024-01-19','activity'),
(32,'Fresher Welcome','Activity','','activity_4_3.jpg','media/activities\\activity_4_3.jpg','2024-01-19','activity'),
(33,'Fresher Welcome','Activity','','activity_4_4.jpg','media/activities\\activity_4_4.jpg','2024-01-19','activity'),
(34,'Fresher Welcome','Activity','','activity_4_5.jpg','media/activities\\activity_4_5.jpg','2024-01-19','activity'),
(35,'Fresher Welcome','Activity','','activity_4_6.jpg','media/activities\\activity_4_6.jpg','2024-01-19','activity'),
(38,'သင်ကြားသင်ယူ မှု များ','this is for testing','dfsdfsdf',NULL,NULL,'2026-07-16','activity'),
(39,'ကွန်ပျူတာတက္ကသိုလ်(တောင်ငူ) နည်းပညာနှင့်တီထွင်ဆန်းသစ်မှု အထောက်အကူပြု စင်တာ (Technology and Innovati','Academic','this is on test server','activity_001_7_14_2026.jpg','media/activities\\activity_001_7_14_2026.jpg','2026-07-13','activity'),
(40,'ကွန်ပျူတာတက္ကသိုလ်(တောင်ငူ) နည်းပညာနှင့်တီထွင်ဆန်းသစ်မှု အထောက်အကူပြု စင်တာ (Technology and Innovati','Academic','this is on test server','activity_002_7_14_2026.jpg','media/activities\\activity_002_7_14_2026.jpg','2026-07-13','activity'),
(41,'ကွန်ပျူတာတက္ကသိုလ်(တောင်ငူ) နည်းပညာနှင့်တီထွင်ဆန်းသစ်မှု အထောက်အကူပြု စင်တာ (Technology and Innovati','Academic','this is on test server','activity_003_7_14_2026.jpg','media/activities\\activity_003_7_14_2026.jpg','2026-07-13','activity'),
(42,'ကွန်ပျူတာတက္ကသိုလ်(တောင်ငူ) နည်းပညာနှင့်တီထွင်ဆန်းသစ်မှု အထောက်အကူပြု စင်တာ (Technology and Innovati','Academic','this is on test server','activity_004_7_14_2026.jpg','media/activities\\activity_004_7_14_2026.jpg','2026-07-13','activity'),
(43,'ကွန်ပျူတာတက္ကသိုလ်(တောင်ငူ) နည်းပညာနှင့်တီထွင်ဆန်းသစ်မှု အထောက်အကူပြု စင်တာ (Technology and Innovati','Academic','this is on test server','activity_005_7_14_2026.jpg','media/activities\\activity_005_7_14_2026.jpg','2026-07-13','activity'),
(44,'ကွန်ပျူတာတက္ကသိုလ်(တောင်ငူ) နည်းပညာနှင့်တီထွင်ဆန်းသစ်မှု အထောက်အကူပြု စင်တာ (Technology and Innovati','Academic','this is on test server','activity_007_7_14_2026.jpg','media/activities\\activity_007_7_14_2026.jpg','2026-07-13','activity'),
(45,'ကွန်ပျူတာတက္ကသိုလ်(တောင်ငူ) နည်းပညာနှင့်တီထွင်ဆန်းသစ်မှု အထောက်အကူပြု စင်တာ (Technology and Innovati','Academic','this is on test server','activity_008_7_14_2026.jpg','media/activities\\activity_008_7_14_2026.jpg','2026-07-13','activity'),
(46,'ကွန်ပျူတာတက္ကသိုလ်(တောင်ငူ) နည်းပညာနှင့်တီထွင်ဆန်းသစ်မှု အထောက်အကူပြု စင်တာ (Technology and Innovati','Academic','this is on test server','activity_009_7_14_2026.jpg','media/activities\\activity_009_7_14_2026.jpg','2026-07-13','activity');
/*!40000 ALTER TABLE `activities` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `alembic_version`
--

DROP TABLE IF EXISTS `alembic_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alembic_version`
--

LOCK TABLES `alembic_version` WRITE;
/*!40000 ALTER TABLE `alembic_version` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `alembic_version` VALUES
('ec8e64ce4d32');
/*!40000 ALTER TABLE `alembic_version` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `collabroations`
--

DROP TABLE IF EXISTS `collabroations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `collabroations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `logo` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `organization_name` varchar(200) NOT NULL,
  `collaboration_type` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collabroations`
--

LOCK TABLES `collabroations` WRITE;
/*!40000 ALTER TABLE `collabroations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `collabroations` VALUES
(1,'AGBLogo.77b5873b.svg','The First Internet Service Provider (ISP) managed by professionals who have excellent skills of networking and provide better customer supports.','https://www.agbcommunication.com/','AGB COMMUNICATION','company'),
(2,'ucsylogo.png','In 1971, it was founded as UCC, the university Computer Center. In 1988, it was established as an Institute of Computer Science and Technology (ICST). On July 1, 1998, the Institute was changed to the University of Computer Studies, Yangon (UCSY).\r\n\r\nThe University of Computer Studies,Yangon (UCSY) is one of the higher institutions under the Ministry of Science and Technology. UCSY is to conduct teaching and research in various branches of computer science, computer technology, and information technology. To meet the growing need for general and advanced computer education in Myanmar, the university currently offers both undergraduate and postgraduate degrees. Its language of instruction is English.\r\n\r\nBachelor degrees were started in 1986 but Master degrees were offered in 1973. In May 2001, the Ph.D. program was started. For all study programs, each academic year is divided into two terms. Each term has 18 weeks for teaching and practical. Examinations are conducted during the end of each term. Clear attendance, tutorials and practical, class assignments are taken into account as components of the assessment.','https://www.ucsy.edu.mm/','UNIVERSITY OF COMPUTER STUDIES, YANGON (UCSY)','university'),
(3,'cropped-gic-logo.png','GIC Group is composed of our Japan headquarters, along with subsidiaries in Myanmar, the United States, and the Miyazaki Nearshore Center. Our main business areas are IT services (including contract development, SES, and IT Ops), human resources (Myanmar talent), and education. We conduct system development in a hybrid shore model, combining nearshore and offshore development in Japan, Myanmar, and Miyazaki, including lab-style and contract-based development. Additionally, our U.S. branch handles various research activities related to advanced topics such as DX (Digital Transformation) and IoT.\r\n\r\nFounded in April 2011, this year marks our 14th year in business. Initially, our focus was on consulting for overseas expansion in Myanmar, the Philippines, and ASEAN regions. However, we have since expanded our services to include nearshore and offshore development/outsourcing, the dispatch of bilingual IT engineers proficient in both Japanese and English, IT operations services, and overseas human resources businesses such as recruitment and introduction.\r\n\r\nThanks to our successful collaboration with many clients on projects involving DX (Digital Transformation) promotion and system development, we are now the leading company in Myanmar offshore development and Myanmar technical staffing, securing an overwhelming No.1 position in the industry.','https://gicjp.com/','Global Innovation Consulting','company'),
(4,'CBK-LOGO-HD.jpg','Cyber King was founded in 2006, by training of ICT with the aim of developing human resources for ICT sector and has trained around 300 students each year. Based on these resources, we founded a software house in October, 2016 at Mayangone Township, Yangon Division, Republic of Union of Myanmar.','https://www.cyberkingict.com/','Cyber King','company'),
(5,'mtgshop.png','မြန်မာပြည်တွင်စိတ်ချရဆုံး mm Domain ဝန်ဆောင်မှု','https://www.mtg.com.mm/','Myanmar Technology Gateway','company'),
(6,'dcr_logo.jpg','Thank you very much for visiting our company website. Myanmar DCR is a 100% Japanese-owned IT company established in Yangon in 2008. While our primary focus is the Japanese market, we also provide a wide range of IT services to global markets.\r\nGuided by our philosophy of “Contributing to the development of Myanmar through the power of IT,” we strive to deeply understand the needs and expectations of our customers and to deliver services that consistently meet those expectations.\r\nLooking ahead, we will continue to cultivate engineers with strong Japanese language proficiency and advanced IT skills, supporting Japanese companies facing a serious IT talent shortage through both onsite dispatch to Japan and laboratory‑based development.\r\nMyanmar DCR will continue to leverage the power of IT and human resources to serve as a bridge between Myanmar and countries around the world, aiming to remain a company that society genuinely needs. We sincerely appreciate your continued support and patronage.','https://www.myanmardcr.com/','Myanmar DCR','company'),
(7,'BIM-Goc-2.png','We are full stack system integrator, uniquely providing all in one service. Be spoke to the needs of the businesses, we provide fit-for-purpose solutions to each unique customer','https://bimgoc.com/','BIM Group of Comapnies','company');
/*!40000 ALTER TABLE `collabroations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `counts`
--

DROP TABLE IF EXISTS `counts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `counts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `total_student` int(11) NOT NULL,
  `total_staff` int(11) NOT NULL,
  `graduated_student` int(11) NOT NULL,
  `current_student` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `counts`
--

LOCK TABLES `counts` WRITE;
/*!40000 ALTER TABLE `counts` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `counts` VALUES
(1,4200,130,2115,545);
/*!40000 ALTER TABLE `counts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `courses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` varchar(100) NOT NULL,
  `course_name` varchar(200) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `semester_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_courses_semester_id` (`semester_id`),
  KEY `ix_courses_subject_id` (`subject_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `courses` VALUES
(1,'CSE-001','Semester I',1,1),
(2,'CSE-001','Semester I',2,1),
(3,'CSE-001','Semester I',3,1),
(4,'CSE-001','Semester I',4,1),
(5,'CSE-001','Semester I',5,1),
(6,'CSE-001','Semester I',6,1),
(7,'CSE-001','Semester I',7,1),
(8,'CSE-002','Semester II',8,2),
(9,'CSE-002','Semester II',9,2),
(10,'CSE-002','Semester II',10,2),
(11,'CSE-002','Semester II',11,2),
(12,'CSE-002','Semester II',12,2),
(13,'CSE-002','Semester II',13,2),
(14,'CSE-003','Semester III',14,3),
(15,'CSE-003','Semester III',15,3),
(16,'CSE-003','Semester III',16,3),
(17,'CSE-003','Semester III',17,3),
(18,'CSE-003','Semester III',18,3),
(19,'CSE-003','Semester III',19,3),
(20,'CSE-003','Semester III',20,3),
(22,'CSE-004','Semester VIII',33,8),
(23,'CSE-001','Semester I',21,1),
(24,'CSE-002','Semester IV',22,4),
(25,'CSE-002','Semester IV',23,4),
(26,'CSE-002','Semester IV',24,4),
(27,'CSE-002','Semester IV',25,4),
(28,'CSE-002','Semester IV',26,4),
(29,'CSE-002','Semester IV',27,4),
(30,'CSE-002','Semester IV',34,4),
(31,'CSE-002','Semester IV',35,4),
(32,'CSE-003','Semester V',36,5),
(33,'CSE-003','Semester V',37,5),
(34,'CSE-003','Semester V',38,5),
(35,'CSE-003','Semester V',39,5),
(36,'CSE-003','Semester V',40,5),
(37,'CSE-003','Semester V',41,5),
(38,'CSE-003','Semester V',42,5),
(39,'CSE-003','Semester V',43,5),
(40,'CSE-003','Semester V',44,5),
(41,'CSE-004','Semester VI',45,6),
(42,'CSE-004','Semester VI',46,6),
(43,'CSE-004','Semester VI',47,6),
(44,'CSE-004','Semester VI',48,6),
(45,'CSE-004','Semester VI',49,6),
(46,'CSE-004','Semester VI',50,6),
(47,'CSE-004','Semester VI',51,6),
(48,'CSE-004','Semester VI',52,6),
(49,'CSE-003','Semester V',53,5),
(50,'CSE-003','Semester V',54,5),
(51,'CSE-003','Semester V',55,5),
(52,'CSE-004','Semester VI',56,6),
(53,'CSE-004','Semester VI',57,6),
(54,'CSE-004','Semester VI',58,6),
(55,'CSE-004','Semester VI',59,6);
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `dashboards`
--

DROP TABLE IF EXISTS `dashboards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `dashboards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `attr_key` varchar(100) NOT NULL,
  `value` text NOT NULL,
  `file` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `attr_key` (`attr_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dashboards`
--

LOCK TABLES `dashboards` WRITE;
/*!40000 ALTER TABLE `dashboards` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `dashboards` VALUES
(2,'Rector\'s Message','တက္ကသိုလ်ဆိုတာ လူ့ဘဝမှာ ရုန်းကန်လှုပ်ရှား အသက်မွေးဝမ်းကျောင်း ပြုနိုင်ဖို့၊ ရပ်တည်နိုင်ဖို့ လိုအပ်တဲ့ အရည်အချင်းတွေကိုလာရောက်ဖြည့်ဆည်းရာ လေ့ကျင့်ရာ လေ့ကျင့်ရေးကွင်းဖြစ်ပါတယ်။ တက္ကသိုလ်တွေမှာ Knowledge လို့ ခေါ်တဲ့ အသိပညာ/အတတ်ပညာ တွေကို ဆည်းပူးရုံသာမက . Wisdom ဆိုတဲ့ ဉာဏ်ပညာပါရှိအောင် ဖြည့်ဆည်းရတဲ့နေရာပါ … အသိပညာကို ဉာဏ်ပညာနဲ့ ကွပ်ကဲမှသာ မိမိကိုယ်ကို အောင်မြင်အောင် စွမ်းဆောင်နိုင်သူတွေ၊ မိမိပတ်ဝန်းကျင်ကို မြှင့်တင်နိုင်သူ တွေ  ဖြစ်လာမှာပါ။ ယနေ့ခေတ်ရဲ့ တောင်းဆိုချက်အရ အရည်အသွေးရှိတဲ့ ပညာရေးစနစ်ဖြစ်ဖို့ တို့တက္ကသိုလ်က ထွက်သွားတဲ့အခါ Knowledge ကော Wisdom ကော ပြည့်စုံတဲ့ Mature ဖြစ်တဲ့ လူငယ်တွေဖြစ်လာဖို့ရန် IQ/EQ ပြည့်စုံဖို့လိုပါတယ်။\nIQ နဲ့ ပြည်စုံစေဖို့ စာတွေလေ့လာသင်ယူကြရသလို၊ လူမှုကျင့်ဝတ်တွေ သိရှိလိုက်နာဖို့၊ ဆင်ခြင်တုံ တရားနှင့်ကိုယ်ချင်းစာတရားရှိဖို့၊ သည်းခံနိုင်စွမ်းမြင့်ဖို့၊ စုပေါင်းဆောင်ရွက်တတ်ဖို့၊  အသင်းအဖွဲ့ စိတ်ဓာတ်/ခေါင်းဆောင်စိတ်ဓာတ်တွေရှိဖို့ စတဲ့ ကိုယ်စိတ် အရည်အသွေးတွေ မြင့်မားလာပြီး Emotional Quotient တွေပြည့်စုံလာဖို့ လေ့ကျင့်ကြရမယ့်နေရာလဲဖြစ်ပါတယ်… ဒါကြောင့် ဆရာမနေနဲ့ အထူးတိုက်တွန်းမှာကြားလိုတာက စာတော်အောင်လဲ လုပ်ဖို့လိုသလို၊ တကိုယ်ကောင်း မဆန်ဖို့, ကိုယ်ချင်းစာတရားရှိဖို့၊ ဟီရိသြတ္တပ္ပလို့ ခေါ်တဲ့ မကောင်းမှုလုပ်ရမှာ ရှက်တဲ့ကြောက်တဲ့စိတ် တွေရှိဖို့ စတဲ့ စိတ်ခံစားမှု အရည်သွေးတွေ မြင့်တက်အောင်လဲ လေ့ကျင့်ကြပါ..\nKnowledge သာမက wisdom နဲ့ပါ ပြည့်စုံတဲ့ ထူးချွန်ထက်မြတ် ကိုယ်ချင်းစာတရားရှိတဲ့  နောင်တစ်ချိန်မှာ နယ်ပယ်အသီးသီးမှာ  ခေါင်းဆောင်ကြမည့် လူငယ်တွေ ဖြစ်ကြပါစေ။\n',NULL),
(6,'Admission Lists','/assets/media/admission/UCSTgo__.pdf',NULL),
(10,'School Open Date','1.6.2026',NULL),
(11,'Phone Number','09-33606066',NULL),
(12,'Email','ucstgostuaffair@gmail.com',NULL),
(13,'Rector\'s Message (EN)','A university is not merely a place where students acquire academic knowledge and professional skills. It is a training ground where young people prepare themselves with the knowledge, skills, values, and qualities they need to face the challenges of life, pursue their careers, and become capable of standing firmly on their own.\n\nAt university, we should not only acquire Knowledge—the understanding and skills necessary for our professions—but also develop Wisdom. Knowledge, when guided and governed by wisdom, enables us not only to achieve success in our own lives but also to contribute positively to our communities and uplift those around us.\n\nIn response to the demands of the modern world, we need a quality education system that develops young people who are mature, capable, responsible, and well-rounded when they leave the university. To achieve this, it is important that students develop both Intelligence Quotient (IQ) and Emotional Quotient (EQ).\n\nWe study and learn in order to strengthen our IQ. At the same time, the university should also be a place where students cultivate their EQ by learning to understand and practice social ethics, developing sound judgment and empathy, strengthening their patience and resilience, learning to work collaboratively, and developing a spirit of teamwork and leadership.\n\nTherefore, I would like to strongly encourage all of you to work hard not only to excel academically, but also to develop your character and emotional qualities. Do not become self-centered. Learn to understand and empathize with others. Cultivate Hiri-Ottappa—the moral sense of shame and fear of doing wrong—and develop the inner strength to distinguish right from wrong and to refrain from unwholesome actions.\n\nAs you pursue your studies, remember that academic excellence alone does not define a truly successful person. True excellence comes from possessing both Knowledge and Wisdom, together with integrity, compassion, responsibility, and the ability to work with and lead others.\n\nMay all of you grow into outstanding, wise, compassionate, and morally responsible young people, who will one day become leaders in your respective fields and make meaningful contributions to society.',NULL);
/*!40000 ALTER TABLE `dashboards` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `department_name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `department_name` (`department_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `departments` VALUES
(9,'Department of Administration'),
(10,'Department of Finance'),
(6,'Department of Information Technologies Support and Maintenance'),
(3,'Department of Natural Language'),
(8,'Department of Natural Science'),
(2,'Department of Student Affairs'),
(1,'Faculty of Computer Science'),
(4,'Faculty of Computer Systems and Technologies'),
(7,'Faculty of Computing'),
(5,'Faculty of Information Science');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `laboratories`
--

DROP TABLE IF EXISTS `laboratories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `laboratories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `laboratory_name` varchar(100) NOT NULL,
  `category` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `filename` varchar(225) NOT NULL,
  `filepath` varchar(225) NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `filename` (`filename`),
  UNIQUE KEY `filepath` (`filepath`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laboratories`
--

LOCK TABLES `laboratories` WRITE;
/*!40000 ALTER TABLE `laboratories` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `laboratories` VALUES
(2,'Language Lab','Academic','','Language-Lab-1-2.jpg','media/laboratories\\Language-Lab-1-2.jpg','2026-06-05'),
(3,'Language Lab','Academic','','Language-Lab-1-3.jpg','media/laboratories\\Language-Lab-1-3.jpg','2026-06-05'),
(4,'Language Lab','Academic','','Language-Lab-1-4.jpg','media/laboratories\\Language-Lab-1-4.jpg','2026-06-05'),
(5,'Physics Lab','Practical','','Physics-Lab-1-1.jpg','media/laboratories\\Physics-Lab-1-1.jpg','2022-12-14'),
(6,'Physics Lab','Practical','','Physics-Lab-1-2.jpg','media/laboratories\\Physics-Lab-1-2.jpg','2022-12-14');
/*!40000 ALTER TABLE `laboratories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `researches`
--

DROP TABLE IF EXISTS `researches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `researches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `research_name` varchar(100) NOT NULL,
  `category` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `filename` varchar(225) NOT NULL,
  `filepath` varchar(225) NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `filename` (`filename`),
  UNIQUE KEY `filepath` (`filepath`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `researches`
--

LOCK TABLES `researches` WRITE;
/*!40000 ALTER TABLE `researches` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `researches` VALUES
(1,'JITES 2019 December (Natural Science) Part-I','Natural Science','','Natural-Science-Part-1-1.pdf','media/researches\\Natural-Science-Part-1-1.pdf','2019-12-07'),
(2,'JITES 2019 December (Education Science)','Education Science','','Education-Science-2.pdf','media/researches\\Education-Science-2.pdf','2019-12-18'),
(3,'JITES 2019 December (Information Technology)','Information Technology','','Information-Technology-1.pdf','media/researches\\Information-Technology-1.pdf','2019-12-11'),
(4,'JITES 2019 December (Language)','Language','','Language-2.pdf','media/researches\\Language-2.pdf','2019-12-17'),
(5,'JITES 2019 December (Natural Science) Part-II','Natural Science','','Natural-Science-Part-2-1.pdf','media/researches\\Natural-Science-Part-2-1.pdf','2019-12-18'),
(6,'JITES 2020 (Education Science)','Education Science','','JITES_2020-part-1.pdf','media/researches\\JITES_2020-part-1.pdf','2020-12-19'),
(7,'JITES 2020 (Education Science) Part-II','Education Science','','JITES_2020-part-2.pdf','media/researches\\JITES_2020-part-2.pdf','2020-12-10'),
(8,'JITES 2020 (Language)','Language','','JITES_2020-part-5.pdf','media/researches\\JITES_2020-part-5.pdf','2026-06-20');
/*!40000 ALTER TABLE `researches` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `semesters`
--

DROP TABLE IF EXISTS `semesters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `semesters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `semester_name` varchar(100) NOT NULL,
  `semester_term` varchar(100) NOT NULL,
  `year_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `semester_name` (`semester_name`),
  UNIQUE KEY `semester_term` (`semester_term`),
  KEY `year_id` (`year_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `semesters`
--

LOCK TABLES `semesters` WRITE;
/*!40000 ALTER TABLE `semesters` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `semesters` VALUES
(1,'Semester I','First Year (1st Sem)',1),
(2,'Semester II','First Year (2nd Sem)',1),
(3,'Semester III','Second Year (1st Sem)',2),
(4,'Semester IV','Second Year (2nd Sem)',2),
(5,'Semester V','Third Year (1st Sem)',3),
(6,'Semester VI','Third Year (2nd Sem)',3),
(7,'Semester VII','Fourth Year (1st Sem)',4),
(8,'Semester VIII','Fourth Year (2nd Sem)',4),
(9,'Semester IX','Fifth Year (1st Sem)',5),
(10,'Semester X','Fifth Year (2nd Sem)',5);
/*!40000 ALTER TABLE `semesters` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_installed` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `settings` VALUES
(1,1);
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `subjects`
--

DROP TABLE IF EXISTS `subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `subjects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subject_code` varchar(200) DEFAULT NULL,
  `subject_name` varchar(200) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `department_id` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subjects`
--

LOCK TABLES `subjects` WRITE;
/*!40000 ALTER TABLE `subjects` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `subjects` VALUES
(1,'M-1101','Myanmar Language','',3),
(2,'E-1101','English Proficiency I','',3),
(3,'P-1101','College Physics','',8),
(4,'CST-1141','Calculus','',7),
(5,'CST-1102','Principle of Information Technology','',1),
(6,'CST-1123','Basic Data Processing','',5),
(7,'CST-1154','Web Development (HTML5+ CSS)','',6),
(8,'M-1201','Myanmar Language','',3),
(9,'E-1201','English Proficiency II','',3),
(10,'CST-1241','Discrete Mathematics','',7),
(11,'CST-1212','Programming Logic & Design  (Programming in C++)','',1),
(12,'CST-1223','Database Fundamentals','',5),
(13,'CST-1234','Digital and Logic Design','',4),
(14,'E-2101','English Proficiency III','',3),
(15,'CST-2141','Linear Algebra','',7),
(16,'CST-2112','Data Structures and Algorithms','',1),
(17,'CST-2113','Programming Language in Java','',1),
(18,'CST-2123','Software Engineering','',5),
(19,'CST-2135','Computer Architecture & Organization','',4),
(20,'CST-2126','Database Management System','',5),
(21,'E-2201','English Proficiency IV','',3),
(22,'CST-2241','Numerical Analysis and  Differential Equations','',7),
(23,'CST-2212','Artificial Intelligence','',1),
(24,'CST-2213','Operating Systems','',1),
(25,'CST-2224','Software Analysis and Design','',5),
(26,'CST-2235','Data Communication and Networking','',4),
(27,'CS-2256','Web Technology (Java Script)','',6),
(33,'','Internship','',NULL),
(34,'CT-2234','Digital System Design','',4),
(35,'CT-2236','Circuits and Electronics','',4),
(36,'CST-3141','Probability and Statistics','',7),
(37,'CST-3112','Professional Ethics','',1),
(38,'CST-3113','Analysis of Algorithms','',1),
(39,'CS-3124','Software Quality Assurance and Testing','',5),
(40,'CS-3125','Database System Structure','',5),
(41,'CST-3136','Computer Networks','',4),
(42,'CS-3117','Web Programming (J2EE)','',1),
(43,'CS-3157A','Web Programming (PHP)','',6),
(44,'CS-3157B','Web Programming (C#)','',6),
(45,'CS-3241','Operations Research','',7),
(46,'CS-3212','Computer Vision','',1),
(47,'CS-3223','Software Design and Development','',5),
(48,'CST-3254','Human Computer Interaction','',6),
(49,'CS-3215','Advanced Artificial Intelligence','',1),
(50,'CST-3226','Data Mining','',5),
(51,'CST-3217','Emerging Technologies','',1),
(52,'CST-3258','Business Information System ','',6),
(53,'CT-3134','Electronic Devices','',4),
(54,'CT-3135','Control Systems','',4),
(55,'CT-3137','Signals and Systems','',4),
(56,'CT-3231','Embedded and Microprocessor Systems','',4),
(57,'CT-3232','Computer and Network Security','',4),
(58,'CT-3233','Image Processing','',4),
(59,'CT-3235','Digital Signal Processing','',4);
/*!40000 ALTER TABLE `subjects` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `user_email` varchar(150) NOT NULL,
  `user_password` text NOT NULL,
  `user_avatar` varchar(255) NOT NULL DEFAULT '3d-avatar-1.avif',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_email` (`user_email`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `user_name` (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `users` VALUES
(1,'USR-001','Jaycoab','jaycoab2@gmail.com','scrypt:32768:8:1$gx9T0zdVk8moVv9o$b72e5afa38abc6e81328636782a303aedb31d562eb85c6d3990207d0582b178d91df6f7caecb4be18f85d7799cbeb1e5d71e9f9f44938bc7733d5dccaa584d67','3d-avatar-8.avif','2026-06-03 04:01:35','2026-06-30 04:02:28'),
(5,'USR-002','Dr Ei Ei Hlaing','eieihlaing@ucstaungoo.edu.mm','scrypt:32768:8:1$YOsNOup10pYApR9E$bc3fcd7a54d372b96ec3b59423d52b6bdea3c4866653d3a293dd08b13d50743493392b76af151b3f2974ac1ca540a77cbd7a8529bbc73a0b648efef15831db15','3d-avatar-1.avif','2026-07-20 07:55:19','2026-07-20 07:55:19');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `vision_missions`
--

DROP TABLE IF EXISTS `vision_missions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `vision_missions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vision` text NOT NULL,
  `mission` text NOT NULL,
  `department_id` int(11) DEFAULT NULL,
  `language` varchar(20) NOT NULL DEFAULT 'en',
  PRIMARY KEY (`id`),
  KEY `department_id` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vision_missions`
--

LOCK TABLES `vision_missions` WRITE;
/*!40000 ALTER TABLE `vision_missions` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `vision_missions` VALUES
(2,'To develop human resources who can support society by applying Computer science and technology that is capable of life-long learning and powerful problem-solving skills.','To encourage the emergence of students with strong ability in self-motivation, critical thinking and problem solving to succeed in the professional field.\nTo provide the required resources for research.',1,'en'),
(3,'ကွန်ပျူတာသိပ္ပံနည်းပညာရပ်များကိုအသုံးချ၍ လူမှုအဖွဲ့အစည်းကို အကျိုးပြုနိုင်ပြီး စဉ်ဆက်မပြတ် လေ့လာနိုင်စွမ်း ရှိသော၊ နည်းပညာဆိုင်ရာပြဿနာများကို ကျွမ်းကျင်စွာ ကိုင်တွယ်ဖြေရှင်းနိုင်စွမ်းရှိသော လူ့စွမ်းအား အရင်း အမြစ်များ မွေးထုတ်ပေးရန်။ ','အသက်မွေးဝမ်းကြောင်းနယ်ပယ်တွင် အောင်မြင်ရန် လိုအပ်သောပညာရပ်များကို မိမိကိုယ်တိုင် တက်ကြွစွာ ရှာဖွေနိုင်စွမ်းရှိသော၊ ကျိုးကြောင်းဆီလျော်စွာ စဉ်းစားဆုံးဖြတ်နိုင်စွမ်းရှိသော၊ ကြုံတွေ့ရသည့် ပြဿနာများကို ကျွမ်းကျင်စွာ ဖြေရှင်းနိုင်စွမ်းရှိသော ကျောင်းသား၊ ကျောင်းသူများ ပေါ်ထွန်းလာစေရေးအတွက် တွန်းအားပေးရန်။သုတေသနနှင့် ဘာသာရပ်များ လေ့လာသင်ယူရာတွင် လိုအပ်သောအရင်းအမြစ်များကို ဖြည့်ဆည်းပေးနိုင်ရန်။နည်းပညာဆိုင်ရာကျင့်ဝတ်နှင့်အညီ တီထွင်ဖန်တီးနိုင်စွမ်းရှိသော၊ ပြင်ပလုပ်ငန်းခွင်၏ လိုအပ်ချက်များနှင့် ကိုက်ညီသော ကျောင်းသား၊ ကျောင်းသူများ မွေးထုတ်ပေးရန်။',1,'mm'),
(4,'To produce outstanding computer technicians by doing teaching and research.','To create strong research environment by encouraging practical teaching. To increase job opportunities collaboration with IT industry. To be skillful technicians who will support contribution to the society.',4,'en'),
(5,'သင်ကြားရေးနှင့် သုတေသနလုပ်ငန်းများဆောင်ရွက်၍ အရည်အချင်းပြည့်ဝသော ကွန်ပျူတာနည်းပညာရှင်များ ပေါ်ထွန်းလာစေရန် မျှော်မှန်းပါသည်။','လက်တွေ့သင်ကြားမှုများကို အားပေးမြှင့်တင်ရန်နှင့် တီထွင်ဖန်တီးမှု အားကောင်းသော သုတေသနပတ်ဝန်းကျင် ဖန်တီးပေးရန်။ ပြင်ပလုပ်ငန်းခွင်များနှင့် ချိတ်ဆက်၍ အလုပ်အကိုင်အခွင့်အလမ်းများ တိုးမြှင့်ပေးရန်။ လူမှုပတ်ဝန်းကျင်ကို အထောက်အကူပြုစေမည့် ကျွမ်းကျင်သည့်နည်းပညာရှင်များ ဖြစ်စေရန်။',4,'mm'),
(6,'To develop the innovative human resources in Data Science and Information Science to meet with the local needs.','To create positive teaching and learning environments to solve the real problems. To perform the emergence of technicians who can create and analyze successfully in real environment with strong ethics.',5,'en'),
(7,'IT နည်းပညာကို အသုံးပြု၍ ဒေသတွင်းလိုအပ်နေသည့် သတင်းအချက်အလက် ပညာရှင်များမွေးထုတ်ပေးရန်။','IT နည်းပညာဆိုင်ရာ လက်တွေ့ပြဿနာများကို ဖြေရှင်းနိုင်သော စွမ်းရည်တိုးတက်စေသော သင်ကြားမှု၊ သင်ယူမှု ပတ်ဝန်းကျင်ကောင်း ဖန်တီးပေးရန်။ ကျင့်ဝတ်လိုက်နာသော၊ လက်တွေ့နယ်ပယ်တွင် အောင်မြင်ပြီး တီထွင်ဖန်တီး ဆန်းစစ်နိုင်သော ပညာရှင်များ ဖြစ်ထွန်းလာစေရေး ကြိုးပမ်းဆောင်ရွက်ရန်။',5,'mm'),
(8,'To produce innovative technicians for information technology development.','To apply technologies fundamentally in IT industry.',6,'en'),
(9,'To produce innovative technicians for information technology development.','To apply technologies fundamentally in IT industry.',6,'en'),
(10,'သတင်းအချက်အလက်နည်းပညာဖွံ့ဖြိုးတိုးတက်ရေးအတွက် တီထွင်ဖန်တီးနိုင်သော နည်းပညာရှင်များ မွေးထုတ်ပေးရန်။','သတင်းအချက်အလက်နည်းပညာ အသုံးပြုသည့် လုပ်ငန်းခွင်များတွင် အထောက်အကူဖြစ်စေနိုင်သော နည်းပညာများကို အခြေခံမှစ၍ နားလည် တတ်မြောက်ပြီး အသုံးချနိုင်စေရန်။',6,'mm'),
(11,'To produce outstanding students who can use advanced mathematics in ICT and research.','To help a good understanding of mathematics and develop critical thinking skill in the field of ICT and research.',7,'en'),
(12,'ICTဘာသာရပ်များနှင့် သုတေသနလုပ်ငန်းများတွင် အထောက်အပံ့ပေးနိုင်သော သင်္ချာဘာသာရပ်များကို ကျွမ်းကျင်ပိုင်နိုင်စွာ အသုံးချနိုင်သည့် ထူးချွန်ထက်မြက်သောကျောင်းသား/သူများ မွေးထုတ်ပေးရန်။','သင်္ချာဘာသာရပ်ကို ကောင်းစွာနားလည်တတ်မြောက်ပြီး ICT ဆိုင်ရာဘာသာရပ်နယ်ပယ်များနှင့် သုတေသနလုပ်ငန်းများတွင် ဆက်စပ်တွက်ချက်နိုင်စွမ်းကို လေ့ကျင့်သင်ကြားပေးရန်။',7,'mm'),
(13,'To emerge fully-fledged computer technicians who understand and preserve Myanmar Language and Culture.','To be able to write correctly and speak fluently in Myanmar Literacy. To understand and obey Myanmar Culture and Ethics. To improve constantly teaching abilities of teachers.',3,'en'),
(14,'မြန်မာစာပေ မြန်မာဘာသာစကားနှင့်ယဉ်ကျေးမှုကို နားလည်ထိန်းသိမ်းတတ်သော ကိုယ်ကျင့်သိက္ခာပြည့်ဝသော ကွန်ပျူတာပညာရှင်များဖြစ်လာစေရန် မျှော်မှန်းပါသည်။','မြန်မာစာပေ အရေးအသားနှင့် ဘာသာစကားစွမ်းရည်များ စနစ်ကျမှန်ကန်စွာ ရေးသားပြောဆိုနိုင်ရန်။မြန်မာ့ယဉ်ကျေးမှုနှင့် လူမှုကျင့်ဝတ်များကို သိရှိနားလည်လိုက်နာစေရန်။သင်ကြားရေး ဆရာ ဆရာမများ၏ ဘာသာရပ်စွမ်းရည်များ အစဉ်တိုးတက်အောင် ဆောင်ရွက်ရန်။',3,'mm'),
(15,'To be the engine of innovation for UCSTGO, facilitating cutting-edge research that addresses real-world problems through technology.','To foster a research culture that encourages discovery, collaboration, and the translation of theoretical knowledge into practical applications.',8,'en'),
(16,'ကွန်ပျူတာဘာသာရပ်များ၊ သုတေသနလုပ်ငန်းများနှင့်၊ ပြင်ပလုပ်ငန်းခွင်များကို အထောက်အပံ့ပေးနိုင်သည့် အရည်အသွေးမြင့် ရူပဗေဒဘာသာရပ် ဖြစ်စေရန်။','အဆင့်မြင့်သင်ကြားမှုနှင့် ဒေသအကျိုးပြု သုတေသနနယ်ပယ်များတွင် အသုံးချနိုင်သောပညာရပ် ဖြစ်စေရေးအတွက် သင်ရိုးညွှန်းတမ်းများ ပြင်ဆင်ရေးဆွဲရန်။ကျောင်းသားကျောင်းသူများအတွက် သီအိုရီနှင့်လက်တွေ့ဆက်စပ်မှုကို သင်ကြားပေးရန်။သုတေသနနှင့် ဒေသအကျိုးပြုလုပ်ငန်းများတွင် အတူတကွ ပူးပေါင်းဆောင်ရွက်ရန်။',8,'mm'),
(17,'To support well-balanced implementation of teaching and research and to cooperate as qualified and responsible staffs.','To support teaching and research activities in accordance with procedures and to strive to perform well-qualified staffs.',9,'en'),
(18,'သင်ကြားရေးနှင့်သုတေသနကို ဟန်ချက်ညီစွာ အကောင်အထည်ဖော်ဆောင်ရွက်နိုင်ရေးအတွက် ပံ့ပိုးဖြည့်ဆည်းပေးရန်နှင့် အရည်အချင်းပြည့်ဝပြီး တာဝန်သိဝန်ထမ်းကောင်းများအဖြစ် ပူးပေါင်းဆောင်ရွက်နိုင်စေရန်၊၊','သင်ကြားရေးနှင့် သုတေသနလုပ်ငန်းများကို ပံ့ပိုးဖြည့်ဆည်းရာတွင် လုပ်ထုံးလုပ်နည်းများနှင့်အညီ ဆောင်ရွက်ပေးရန်နှင့် အရည်အချင်းပြည့်ဝသော ဝန်ထမ်းကောင်းဖြစ်စေရေးအတွက် ကြိုးပမ်းဆောင်ရွက်ပေးရန်၊၊',9,'mm'),
(19,'To have the financial adequacy necessary to become a developed university To spend nation’s incomes and expenditures systematically without losing according to the financial rules.','To equip students with analytical skills and scientific reasoning capabilities necessary to support the advancement of computer science and engineering disciplines.',10,'en'),
(20,'ဖွံ့ဖြိုးတိုးတက်သော တက္ကသိုလ်ဖြစ်လာစေရေးအတွက် လိုအပ်သော ငွေကြေးကဏ္ဍ ပြည့်စုံလုံလောက်မှု ရှိစေရန်။နိုင်ငံတော်၏ ရငွေများ၊ သုံးငွေများအား လေလွင့်ဆုံးရှုံးမှုမရှိစေရန် ဘဏ္ဍာရေးစည်းမျဉ်းနှင့်အညီ စနစ်တကျသုံးစွဲရန်၊၊','စီမံကိန်းစာရင်းအင်းများနှင့် ရ/သုံးဆိုင်ရာ ငွေစာရင်းများကို ပါမောက္ခချုပ်မှ လမ်းညွှန်သည့်အတိုင်း ဌာနမှူးများနှင့်အတူ ညှိနှိုင်းရေးဆွဲရန်။ဌာနအသီးသီးမှ လိုအပ်ချက်များအား ဖြည့်ဆည်းပေးရန်။',10,'mm'),
(21,'To have the financial adequacy necessary to become a developed university. To spend nation’s incomes and expenditures systematically without losing according to the financial rules','To draw the statistic planning and budgets with head of departments under the rector’s guidance. To fulfill the requirements of departments.',2,'en'),
(22,'ကွန်ပျူတာသိပ္ပံနည်းပညာရပ်များကိုအသုံးချ၍ လူမှုအဖွဲ့အစည်းကို အကျိုးပြုနိုင်ပြီး စဉ်ဆက်မပြတ် လေ့လာနိုင်စွမ်း ရှိသော၊ နည်းပညာဆိုင်ရာပြဿနာများကို ကျွမ်းကျင်စွာ ကိုင်တွယ်ဖြေရှင်းနိုင်စွမ်းရှိသော လူ့စွမ်းအား အရင်း အမြစ်များ မွေးထုတ်ပေးရန်။','အသက်မွေးဝမ်းကြောင်းနယ်ပယ်တွင်အောင်မြင်ရန် လိုအပ်သောပညာရပ်များကို မိမိကိုယ်တိုင် တက်ကြွစွာ ရှာဖွေနိုင်စွမ်းရှိသော၊ ကျိုးကြောင်းဆီလျော်စွာ စဉ်းစားဆုံးဖြတ်နိုင်စွမ်းရှိသော၊ ကြုံတွေ့ရသည့် ပြဿနာများကို ကျွမ်းကျင်စွာ ဖြေရှင်းနိုင်စွမ်းရှိသော ကျောင်းသား၊ ကျောင်းသူများ ပေါ်ထွန်းလာစေရေးအတွက် တွန်းအားပေးရန်။သုတေသနနှင့် ဘာသာရပ်များ လေ့လာသင်ယူရာတွင် လိုအပ်သောအရင်းအမြစ်များကို ဖြည့်ဆည်းပေးနိုင်ရန်။နည်းပညာဆိုင်ရာကျင့်ဝတ်နှင့်အညီ တီထွင်ဖန်တီးနိုင်စွမ်းရှိသော၊ ပြင်ပလုပ်ငန်းလုပ်ငန်းခွင်၏ လိုအပ်ချက်များနှင့်ကိုက်ညီသော ကျောင်းသား၊ ကျောင်းသူများ မွေးထုတ်ပေးရန်။',2,'mm');
/*!40000 ALTER TABLE `vision_missions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `years`
--

DROP TABLE IF EXISTS `years`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `years` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `year_name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `year_name` (`year_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `years`
--

LOCK TABLES `years` WRITE;
/*!40000 ALTER TABLE `years` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `years` VALUES
(5,'Fifth Year'),
(1,'First Year'),
(4,'Fourth Year'),
(2,'Second Year'),
(3,'Third Year');
/*!40000 ALTER TABLE `years` ENABLE KEYS */;
UNLOCK TABLES;
commit;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-08-23 20:35:52
