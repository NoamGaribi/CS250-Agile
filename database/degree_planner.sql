-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: degree-planner-db-degree-planner.d.aivencloud.com    Database: degree_planner
-- ------------------------------------------------------
-- Server version	8.4.8

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '2f9c5290-c35d-11f1-b4f3-c29ca767ff02:1-15,
7fb9f683-c462-11f1-924b-9608390245a8:1-55,
94acb1eb-b6c9-11f1-9e64-c6921846d15b:1-91,
fc9881f2-bc2a-11f1-aab4-7ed40deded06:1-26';

--
-- Table structure for table `audit_imports`
--

DROP TABLE IF EXISTS `audit_imports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_imports` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `imported_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `audit_date` date DEFAULT NULL,
  `status` enum('pending_review','confirmed','rejected') NOT NULL DEFAULT 'pending_review',
  `confirmed_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_audit_owner` (`id`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `audit_imports_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_imports`
--

LOCK TABLES `audit_imports` WRITE;
/*!40000 ALTER TABLE `audit_imports` DISABLE KEYS */;
INSERT INTO `audit_imports` VALUES (1,11,'2026-10-13 23:33:24',NULL,'pending_review',NULL),(2,11,'2026-10-13 23:33:30',NULL,'pending_review',NULL),(3,11,'2026-10-13 23:33:35',NULL,'pending_review',NULL),(4,11,'2026-10-13 23:33:40',NULL,'pending_review',NULL),(5,11,'2026-10-13 23:42:03',NULL,'pending_review',NULL),(6,11,'2026-10-13 23:42:15',NULL,'pending_review',NULL),(7,11,'2026-10-14 00:12:17',NULL,'pending_review',NULL),(8,11,'2026-10-14 00:16:02',NULL,'pending_review',NULL),(9,11,'2026-10-14 00:16:11',NULL,'pending_review',NULL),(10,11,'2026-10-14 00:17:01',NULL,'pending_review',NULL),(11,11,'2026-10-14 00:26:02',NULL,'pending_review',NULL),(12,11,'2026-10-14 00:26:50',NULL,'pending_review',NULL),(13,15,'2026-10-14 04:15:24',NULL,'pending_review',NULL),(14,11,'2026-10-14 04:35:04',NULL,'pending_review',NULL),(15,15,'2026-10-14 04:40:45',NULL,'pending_review',NULL);
/*!40000 ALTER TABLE `audit_imports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `audit_requirement_results`
--

DROP TABLE IF EXISTS `audit_requirement_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_requirement_results` (
  `id` int NOT NULL AUTO_INCREMENT,
  `audit_import_id` int NOT NULL,
  `requirement_id` int DEFAULT NULL,
  `audit_requirement_name` varchar(255) NOT NULL,
  `status` enum('satisfied','in_progress','not_satisfied','unknown') NOT NULL DEFAULT 'unknown',
  `remaining_units` decimal(5,2) DEFAULT NULL,
  `remaining_course_count` int DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  KEY `idx_audit_requirement` (`audit_import_id`,`requirement_id`),
  KEY `requirement_id` (`requirement_id`),
  CONSTRAINT `audit_requirement_results_ibfk_1` FOREIGN KEY (`audit_import_id`) REFERENCES `audit_imports` (`id`),
  CONSTRAINT `audit_requirement_results_ibfk_2` FOREIGN KEY (`requirement_id`) REFERENCES `degree_requirements` (`id`),
  CONSTRAINT `audit_requirement_results_chk_1` CHECK (((`remaining_units` is null) or (`remaining_units` >= 0))),
  CONSTRAINT `audit_requirement_results_chk_2` CHECK (((`remaining_course_count` is null) or (`remaining_course_count` >= 0)))
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_requirement_results`
--

LOCK TABLES `audit_requirement_results` WRITE;
/*!40000 ALTER TABLE `audit_requirement_results` DISABLE KEYS */;
INSERT INTO `audit_requirement_results` VALUES (1,1,4,'Cultural Diversity','unknown',NULL,NULL,NULL),(2,1,5,'Graduation Writing Assessment','not_satisfied',NULL,NULL,NULL),(3,1,7,'Computer Science Electives','not_satisfied',NULL,NULL,NULL),(4,1,10,'Upper Division Major Residency','not_satisfied',NULL,NULL,NULL),(5,1,16,'Preparation for the Major','satisfied',NULL,NULL,NULL),(6,2,4,'Cultural Diversity','unknown',NULL,NULL,NULL),(7,2,5,'Graduation Writing Assessment','not_satisfied',NULL,NULL,NULL),(8,2,7,'Computer Science Electives','not_satisfied',NULL,NULL,NULL),(9,2,10,'Upper Division Major Residency','not_satisfied',NULL,NULL,NULL),(10,2,16,'Preparation for the Major','satisfied',NULL,NULL,NULL),(11,3,4,'Cultural Diversity','unknown',NULL,NULL,NULL),(12,3,5,'Graduation Writing Assessment','not_satisfied',NULL,NULL,NULL),(13,3,7,'Computer Science Electives','not_satisfied',NULL,NULL,NULL),(14,3,10,'Upper Division Major Residency','not_satisfied',NULL,NULL,NULL),(15,3,16,'Preparation for the Major','satisfied',NULL,NULL,NULL),(16,4,4,'Cultural Diversity','unknown',NULL,NULL,NULL),(17,4,5,'Graduation Writing Assessment','not_satisfied',NULL,NULL,NULL),(18,4,7,'Computer Science Electives','not_satisfied',NULL,NULL,NULL),(19,4,10,'Upper Division Major Residency','not_satisfied',NULL,NULL,NULL),(20,4,16,'Preparation for the Major','satisfied',NULL,NULL,NULL),(21,5,4,'Cultural Diversity','unknown',NULL,NULL,NULL),(22,5,5,'Graduation Writing Assessment','not_satisfied',NULL,NULL,NULL),(23,5,7,'Computer Science Electives','not_satisfied',NULL,NULL,NULL),(24,5,10,'Upper Division Major Residency','not_satisfied',NULL,NULL,NULL),(25,5,16,'Preparation for the Major','satisfied',NULL,NULL,NULL),(26,6,4,'Cultural Diversity','unknown',NULL,NULL,NULL),(27,6,5,'Graduation Writing Assessment','not_satisfied',NULL,NULL,NULL),(28,6,7,'Computer Science Electives','not_satisfied',NULL,NULL,NULL),(29,6,10,'Upper Division Major Residency','not_satisfied',NULL,NULL,NULL),(30,6,16,'Preparation for the Major','satisfied',NULL,NULL,NULL),(31,7,4,'Cultural Diversity','unknown',NULL,NULL,NULL),(32,7,5,'Graduation Writing Assessment','not_satisfied',NULL,NULL,NULL),(33,7,7,'Computer Science Electives','not_satisfied',NULL,NULL,NULL),(34,7,10,'Upper Division Major Residency','not_satisfied',NULL,NULL,NULL),(35,7,16,'Preparation for the Major','satisfied',NULL,NULL,NULL),(36,8,4,'Cultural Diversity','unknown',NULL,NULL,NULL),(37,8,5,'Graduation Writing Assessment','not_satisfied',NULL,NULL,NULL),(38,8,7,'Computer Science Electives','not_satisfied',NULL,NULL,NULL),(39,8,10,'Upper Division Major Residency','not_satisfied',NULL,NULL,NULL),(40,8,16,'Preparation for the Major','satisfied',NULL,NULL,NULL),(41,9,4,'Cultural Diversity','unknown',NULL,NULL,NULL),(42,9,5,'Graduation Writing Assessment','not_satisfied',NULL,NULL,NULL),(43,9,7,'Computer Science Electives','not_satisfied',NULL,NULL,NULL),(44,9,10,'Upper Division Major Residency','not_satisfied',NULL,NULL,NULL),(45,9,16,'Preparation for the Major','satisfied',NULL,NULL,NULL),(46,11,4,'Cultural Diversity','unknown',NULL,NULL,NULL),(47,11,5,'Graduation Writing Assessment','not_satisfied',NULL,NULL,NULL),(48,11,7,'Computer Science Electives','not_satisfied',NULL,NULL,NULL),(49,11,10,'Upper Division Major Residency','not_satisfied',NULL,NULL,NULL),(50,11,16,'Preparation for the Major','satisfied',NULL,NULL,NULL),(51,12,4,'Cultural Diversity','unknown',NULL,NULL,NULL),(52,12,5,'Graduation Writing Assessment','not_satisfied',NULL,NULL,NULL),(53,12,7,'Computer Science Electives','not_satisfied',NULL,NULL,NULL),(54,12,10,'Upper Division Major Residency','not_satisfied',NULL,NULL,NULL),(55,12,16,'Preparation for the Major','satisfied',NULL,NULL,NULL),(56,15,4,'Cultural Diversity','unknown',NULL,NULL,NULL),(57,15,5,'Graduation Writing Assessment','in_progress',NULL,NULL,NULL),(58,15,7,'Computer Science Electives','not_satisfied',NULL,NULL,NULL),(59,15,10,'Upper Division Major Residency','not_satisfied',NULL,NULL,NULL),(60,15,16,'Preparation for the Major','satisfied',NULL,NULL,NULL);
/*!40000 ALTER TABLE `audit_requirement_results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_prerequisites`
--

DROP TABLE IF EXISTS `course_prerequisites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_prerequisites` (
  `course_id` int NOT NULL,
  `prerequisite_course_id` int NOT NULL,
  PRIMARY KEY (`course_id`,`prerequisite_course_id`),
  KEY `prerequisite_course_id` (`prerequisite_course_id`),
  CONSTRAINT `course_prerequisites_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`),
  CONSTRAINT `course_prerequisites_ibfk_2` FOREIGN KEY (`prerequisite_course_id`) REFERENCES `courses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_prerequisites`
--

LOCK TABLES `course_prerequisites` WRITE;
/*!40000 ALTER TABLE `course_prerequisites` DISABLE KEYS */;
INSERT INTO `course_prerequisites` VALUES (3,1),(4,1),(5,3),(6,3),(7,3),(20,5),(24,5),(25,5),(27,5),(32,5),(40,5),(41,5),(43,5),(45,5),(47,5),(48,5),(49,5),(50,5),(52,5),(17,6),(25,6),(26,7),(9,8),(12,8),(11,9),(14,9),(22,9),(19,10),(28,10),(30,10),(47,10),(48,10),(18,11),(22,11),(40,11),(41,11),(43,11),(50,11),(14,12),(20,17),(23,17),(29,17),(44,18),(30,20),(49,22),(55,54);
/*!40000 ALTER TABLE `course_prerequisites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_sections`
--

DROP TABLE IF EXISTS `course_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_sections` (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_id` int NOT NULL,
  `term_id` int NOT NULL,
  `section_number` varchar(20) NOT NULL,
  `instruction_mode` enum('in_person','online','hybrid','unknown') NOT NULL DEFAULT 'unknown',
  `schedule_status` enum('scheduled','asynchronous','unknown') NOT NULL DEFAULT 'unknown',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_course_term_section` (`course_id`,`term_id`,`section_number`),
  KEY `term_id` (`term_id`),
  CONSTRAINT `course_sections_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`),
  CONSTRAINT `course_sections_ibfk_2` FOREIGN KEY (`term_id`) REFERENCES `terms` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_sections`
--

LOCK TABLES `course_sections` WRITE;
/*!40000 ALTER TABLE `course_sections` DISABLE KEYS */;
INSERT INTO `course_sections` VALUES (1,1,1,'5834','in_person','scheduled'),(2,1,1,'5836','in_person','scheduled'),(3,2,1,'5837','hybrid','scheduled'),(4,2,1,'5838','hybrid','scheduled'),(5,2,1,'5839','hybrid','scheduled'),(6,2,1,'5841','hybrid','scheduled'),(7,3,1,'5843','in_person','scheduled'),(8,3,1,'5844','in_person','scheduled'),(9,3,1,'6386','in_person','scheduled'),(10,4,1,'5846','hybrid','scheduled'),(11,4,1,'5847','hybrid','scheduled'),(12,4,1,'5848','hybrid','scheduled'),(13,4,1,'6387','hybrid','scheduled'),(14,4,1,'9168','hybrid','scheduled'),(15,4,1,'9169','hybrid','scheduled'),(16,5,1,'6146','in_person','scheduled'),(17,5,1,'7602','in_person','scheduled'),(18,6,1,'6151','in_person','scheduled'),(19,6,1,'6152','in_person','scheduled'),(20,7,1,'10095','in_person','scheduled'),(21,7,1,'10096','in_person','scheduled'),(22,7,1,'11623','in_person','scheduled'),(23,7,1,'8480','in_person','scheduled'),(24,17,1,'6144','in_person','scheduled'),(25,17,1,'6145','in_person','scheduled'),(26,21,1,'6148','in_person','scheduled'),(27,21,1,'8555','in_person','scheduled'),(28,21,1,'9157','online','scheduled'),(29,18,1,'10073','in_person','scheduled'),(30,18,1,'6405','in_person','scheduled'),(31,19,1,'6153','in_person','scheduled'),(32,19,1,'6154','in_person','scheduled'),(33,19,1,'8557','in_person','scheduled'),(34,19,1,'9325','in_person','scheduled'),(35,23,1,'6997','in_person','scheduled'),(36,20,1,'6149','in_person','scheduled'),(37,20,1,'6150','in_person','scheduled'),(38,48,1,'5903','in_person','scheduled'),(39,48,1,'5904','online','scheduled'),(40,48,1,'5905','online','scheduled'),(41,48,1,'8404','in_person','scheduled'),(42,25,1,'8356','in_person','scheduled'),(43,40,1,'5906','in_person','scheduled'),(44,40,1,'6996','in_person','scheduled'),(45,40,1,'8993','in_person','scheduled'),(46,42,1,'9156','in_person','scheduled'),(47,44,1,'10484','online','scheduled'),(48,31,1,'8305','in_person','scheduled'),(49,50,1,'10106','in_person','scheduled'),(50,50,1,'10551','in_person','scheduled'),(51,50,1,'8495','online','scheduled'),(52,32,1,'7306','in_person','scheduled'),(53,51,1,'5907','in_person','scheduled'),(54,52,1,'7258','online','scheduled'),(55,45,1,'10071','in_person','scheduled'),(56,58,1,'11906','in_person','scheduled'),(57,59,1,'11822','in_person','scheduled'),(58,60,1,'11901','in_person','scheduled'),(59,9,1,'11655','in_person','scheduled'),(60,9,1,'4638','in_person','scheduled'),(61,9,1,'4642','in_person','scheduled'),(62,9,1,'4647','in_person','scheduled'),(63,9,1,'8407','in_person','scheduled'),(64,10,1,'4717','in_person','scheduled'),(65,16,1,'10771','in_person','scheduled'),(66,16,1,'5304','online','asynchronous'),(67,22,1,'8915','in_person','scheduled'),(68,22,1,'9046','in_person','scheduled'),(69,22,1,'9095','in_person','scheduled'),(128,64,1,'1362','in_person','scheduled'),(129,64,1,'8525','in_person','scheduled'),(130,62,1,'9456','in_person','scheduled'),(131,66,1,'11266','in_person','scheduled'),(132,67,1,'11096','hybrid','scheduled'),(133,67,1,'11098','online','asynchronous'),(134,63,1,'4966','in_person','scheduled'),(135,61,1,'1027','online','asynchronous'),(136,61,1,'1028','online','asynchronous'),(137,61,1,'8452','hybrid','scheduled'),(138,61,1,'9084','in_person','scheduled'),(139,61,1,'10139','online','asynchronous'),(140,61,1,'10564','online','asynchronous'),(141,61,1,'11628','in_person','scheduled'),(142,65,1,'10024','online','asynchronous');
/*!40000 ALTER TABLE `course_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_code` varchar(20) NOT NULL,
  `course_name` varchar(150) NOT NULL,
  `units` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_code` (`course_code`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES (1,'CS 150','Intro Computer Programming',3),(2,'CS 150L','Intro Computer Progrm Lab',1),(3,'CS 160','Int Computer Programming',3),(4,'CS 160L','Int Computr Progammng Lab',1),(5,'CS 210','Data Structures',3),(6,'CS 240','Computer Organization',3),(7,'CS 250','Intro to Software Systems',3),(8,'MATH 150','Calculus I',4),(9,'MATH 151','Calculus II',4),(10,'MATH 245','Discrete Mathematics',3),(11,'MATH 254','Introduction to Linear Algebra',3),(12,'PHYS 195','Principles of Physics',3),(13,'PHYS 195L','Principles of Physics Laboratory',1),(14,'PHYS 196','Principles of Physics',3),(15,'PHYS 196L','Principles of Physics Laboratory',1),(16,'STAT 250','Stat Principles & Practice',3),(17,'CS 370','Computer Architecture',3),(18,'CS 450','Intro Artificial Intellig',3),(19,'CS 460','Algorithms',3),(20,'CS 480','Operating Systems',3),(21,'CS 420','Adv Programming Langs',3),(22,'STAT 550','Applied Probability',3),(23,'CS 470','Unix System Admin',3),(24,'CS 521','Internet of Things - Software and Systems',3),(25,'CS 530','Systems Programming',3),(26,'CS 532','Software Engineering',3),(27,'CS 545','Introduction to Web Application Development',3),(28,'CS 562','Automata Theory',3),(29,'CS 572','Microprocessor Architecture',3),(30,'CS 574','Computer Security',3),(31,'CS 576','Networks & Distrib Syst',3),(32,'CS 578','Wireless Networks',3),(33,'CY 302','Fundamentals of Digital Security and Privacy',3),(34,'CY 531','Software Security',3),(35,'CY 533','Wireless Security',3),(36,'CY 534','Blockchain and Decentralized Cybersecurity',3),(37,'CY 542','Data Privacy',3),(38,'CY 569','Applied Cybersecurity Management',3),(39,'CY 575','Advanced Data Network Security and Privacy',3),(40,'CS 549','Machine Learning',3),(41,'CS 553','Neural Networks',3),(42,'CS 556','Robotics',3),(43,'CS 559','Computer Vision',3),(44,'CS 561','Deep Learnng Natural Lang',3),(45,'CS 583','3d Game Programming',3),(46,'CY 541','AI in Cybersecurity',3),(47,'CS 503','Scientific Database Techniques',3),(48,'CS 514','Database Theory Implement',3),(49,'CS 558','Computer Simulation',3),(50,'CS 577','Prin&Technqs Data Science',3),(51,'CS 581','Computational Linguistics',3),(52,'CS 582','Intro Speech Processing',3),(53,'CS 496','Experimental Topics',NULL),(54,'CS 497','Undergraduate Research Seminar',3),(55,'CS 498','Undergraduate Honors Thesis',3),(56,'CS 499','Special Study',NULL),(57,'CS 596','Advanced Topics in Computer Science',NULL),(58,'CY 342','Fund Security & Privacy',3),(59,'CY 601','Software Security',3),(60,'CY 642','Code Privacy',3),(61,'ANTH 101','Human Biocultural Origin',3),(62,'HUM 322','LGBT History and Culture',3),(63,'MATH 110','Math for Life',3),(64,'MATH 303','History of Mathematics',3),(65,'REL S 101','World Religions',3),(66,'REL S 310','The Qur\'an',3),(67,'WGSS 382','Gender, Science and Technology',3);
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `degree_requirements`
--

DROP TABLE IF EXISTS `degree_requirements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `degree_requirements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `degree_id` int NOT NULL,
  `requirement_name` varchar(150) NOT NULL,
  `requirement_type` varchar(50) DEFAULT NULL,
  `required_units` decimal(5,2) DEFAULT NULL,
  `required_course_count` int DEFAULT NULL,
  `selection_rule` enum('all','choose') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `degree_id` (`degree_id`),
  CONSTRAINT `degree_requirements_ibfk_1` FOREIGN KEY (`degree_id`) REFERENCES `degrees` (`id`),
  CONSTRAINT `chk_requirement_count` CHECK (((`required_course_count` is null) or (`required_course_count` >= 0))),
  CONSTRAINT `chk_requirement_units` CHECK (((`required_units` is null) or (`required_units` >= 0)))
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `degree_requirements`
--

LOCK TABLES `degree_requirements` WRITE;
/*!40000 ALTER TABLE `degree_requirements` DISABLE KEYS */;
INSERT INTO `degree_requirements` VALUES (1,1,'UD 2/5 Explorations - Physical, Biological, Math/Quantitative','ge',3.00,1,'choose'),(2,1,'UD 3 Explorations - Arts and Humanities','ge',3.00,1,'choose'),(3,1,'UD 4 Explorations - Social and Behavioral Sciences','ge',3.00,1,'choose'),(4,1,'Cultural Diversity','ge',NULL,1,'choose'),(5,1,'Graduation Writing Assessment','university',3.00,1,'choose'),(6,1,'Required CS Courses','major',15.00,5,'all'),(7,1,'Computer Science Electives','major',18.00,NULL,'choose'),(8,1,'Minimum SDSU Units','university',30.00,NULL,NULL),(9,1,'Minimum Upper Division SDSU Units','university',24.00,NULL,NULL),(10,1,'Upper Division Major Residency','major',18.00,NULL,NULL),(16,1,'Preparation for the Major','major_preparation',42.00,16,'all');
/*!40000 ALTER TABLE `degree_requirements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `degrees`
--

DROP TABLE IF EXISTS `degrees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `degrees` (
  `id` int NOT NULL AUTO_INCREMENT,
  `degree_name` varchar(150) NOT NULL,
  `degree_type` varchar(50) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `catalog_year` int DEFAULT NULL,
  `total_units_required` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `degrees`
--

LOCK TABLES `degrees` WRITE;
/*!40000 ALTER TABLE `degrees` DISABLE KEYS */;
INSERT INTO `degrees` VALUES (1,'Computer Science','B.S','Sciences',2026,120);
/*!40000 ALTER TABLE `degrees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instructors`
--

DROP TABLE IF EXISTS `instructors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `instructors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `instructor_name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instructors`
--

LOCK TABLES `instructors` WRITE;
/*!40000 ALTER TABLE `instructors` DISABLE KEYS */;
INSERT INTO `instructors` VALUES (1,'Lokeshwari Anamalamudi'),(2,'Rylie Foster'),(3,'To be Announced'),(4,'Patricia Kraft'),(5,'Siddhi Amilkanthwar'),(6,'Wenyu Peng'),(7,'Samvedhya Bendapudi'),(8,'Yahui Jiang'),(9,'FNU Manju Muralidharan Priya'),(10,'Dominic Dabish'),(11,'Rakshitha Arun Kumar'),(12,'Gus Hanna'),(13,'Tao Xie'),(14,'Shams Al Ajrawi'),(15,'Xiaobai Liu'),(16,'Xuanji Yu'),(17,'Hyunjong Choi'),(18,'Peter Bartoli'),(19,'Ben Shen'),(20,'Jianshu Liu'),(21,'Hau Nguyen'),(22,'James Gappy'),(23,'Guy Leonard'),(24,'Irfan Khan'),(25,'Joann Chen'),(26,'Wei Wang'),(27,'Hajar Homayouni'),(28,'Alireza Abdoli'),(29,'Md Rakibul Hasan'),(30,'Mark Gawron'),(31,'Courtney Konopka'),(32,'Dan Houston'),(33,'Yifan Zhang'),(34,'Jian Chen'),(35,'Shahir Sikder'),(36,'Nicholas Slinglend'),(37,'Christopher O\'Neill'),(38,'Huan Qin'),(39,'Kristin Duncan'),(40,'Laura Scott'),(64,'Thamira Jarjees'),(65,'Kori Pacyniak'),(66,'Esra Tunc'),(67,'Christine Payne'),(68,'Christine Knott'),(69,'Corey Manchester'),(70,'Sam Kobari'),(71,'Shannon Black'),(72,'Oliver Paine'),(73,'Arion Mayes'),(74,'Angela Feres');
/*!40000 ALTER TABLE `instructors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `requirement_courses`
--

DROP TABLE IF EXISTS `requirement_courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `requirement_courses` (
  `requirement_id` int NOT NULL,
  `course_id` int NOT NULL,
  PRIMARY KEY (`requirement_id`,`course_id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `requirement_courses_ibfk_1` FOREIGN KEY (`requirement_id`) REFERENCES `degree_requirements` (`id`),
  CONSTRAINT `requirement_courses_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `requirement_courses`
--

LOCK TABLES `requirement_courses` WRITE;
/*!40000 ALTER TABLE `requirement_courses` DISABLE KEYS */;
INSERT INTO `requirement_courses` VALUES (16,1),(16,2),(16,3),(16,4),(16,5),(16,6),(16,7),(16,8),(16,9),(16,10),(16,11),(16,12),(16,13),(16,14),(16,15),(16,16),(6,18),(6,19),(6,20),(6,21),(6,22),(7,23),(7,25),(7,31),(7,32),(7,40),(7,42),(7,44),(7,45),(7,48),(7,50),(7,51),(7,52),(2,62),(4,62),(1,64),(4,64),(2,66),(4,66),(1,67),(4,67);
/*!40000 ALTER TABLE `requirement_courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `section_instructors`
--

DROP TABLE IF EXISTS `section_instructors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `section_instructors` (
  `section_id` int NOT NULL,
  `instructor_id` int NOT NULL,
  PRIMARY KEY (`section_id`,`instructor_id`),
  KEY `instructor_id` (`instructor_id`),
  CONSTRAINT `section_instructors_ibfk_1` FOREIGN KEY (`section_id`) REFERENCES `course_sections` (`id`),
  CONSTRAINT `section_instructors_ibfk_2` FOREIGN KEY (`instructor_id`) REFERENCES `instructors` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `section_instructors`
--

LOCK TABLES `section_instructors` WRITE;
/*!40000 ALTER TABLE `section_instructors` DISABLE KEYS */;
INSERT INTO `section_instructors` VALUES (1,1),(2,2),(3,3),(4,3),(5,3),(6,3),(18,3),(26,3),(43,3),(46,3),(47,3),(59,3),(7,4),(8,4),(16,4),(9,5),(10,6),(11,6),(12,6),(13,7),(14,8),(15,8),(17,9),(32,9),(33,9),(50,9),(19,10),(27,10),(20,11),(21,11),(22,12),(23,12),(24,13),(25,13),(28,14),(29,15),(30,16),(31,17),(34,17),(35,18),(56,18),(36,19),(37,19),(38,20),(39,21),(40,21),(41,22),(42,23),(44,24),(45,25),(48,26),(49,27),(51,28),(52,29),(53,30),(54,31),(55,32),(57,33),(58,34),(69,34),(60,35),(62,35),(63,35),(61,36),(64,37),(65,38),(66,39),(67,40),(68,40),(128,64),(129,64),(130,65),(131,66),(132,67),(133,68),(134,69),(135,70),(136,70),(137,71),(139,71),(138,72),(141,72),(140,73),(142,74);
/*!40000 ALTER TABLE `section_instructors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `section_meetings`
--

DROP TABLE IF EXISTS `section_meetings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `section_meetings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `section_id` int NOT NULL,
  `day_of_week` tinyint NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `meeting_type` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_section_meeting` (`section_id`,`day_of_week`,`start_time`,`end_time`),
  CONSTRAINT `section_meetings_ibfk_1` FOREIGN KEY (`section_id`) REFERENCES `course_sections` (`id`),
  CONSTRAINT `section_meetings_chk_1` CHECK ((`day_of_week` between 1 and 7)),
  CONSTRAINT `section_meetings_chk_2` CHECK (((`start_time` >= _utf8mb4'00:00:00') and (`end_time` < _utf8mb4'24:00:00') and (`end_time` > `start_time`)))
) ENGINE=InnoDB AUTO_INCREMENT=287 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `section_meetings`
--

LOCK TABLES `section_meetings` WRITE;
/*!40000 ALTER TABLE `section_meetings` DISABLE KEYS */;
INSERT INTO `section_meetings` VALUES (1,1,2,'09:30:00','10:45:00','Lecture'),(2,1,4,'09:30:00','10:45:00','Lecture'),(3,2,1,'14:00:00','15:15:00','Lecture'),(4,2,3,'14:00:00','15:15:00','Lecture'),(5,3,1,'17:30:00','18:45:00','Laboratory'),(6,4,2,'08:00:00','09:15:00','Laboratory'),(7,5,3,'17:30:00','18:45:00','Laboratory'),(8,6,2,'17:30:00','18:45:00','Laboratory'),(9,7,1,'14:00:00','15:15:00','Lecture'),(10,7,3,'14:00:00','15:15:00','Lecture'),(11,8,1,'16:00:00','17:15:00','Lecture'),(12,8,3,'16:00:00','17:15:00','Lecture'),(13,9,2,'08:00:00','09:15:00','Lecture'),(14,9,4,'08:00:00','09:15:00','Lecture'),(15,10,1,'17:30:00','18:45:00','Laboratory'),(16,12,2,'08:00:00','09:15:00','Laboratory'),(17,13,2,'09:30:00','10:45:00','Laboratory'),(18,14,1,'11:00:00','12:15:00','Laboratory'),(19,15,3,'11:00:00','12:15:00','Laboratory'),(20,11,3,'17:30:00','18:45:00','Laboratory'),(21,17,2,'19:00:00','20:15:00','Lecture'),(22,17,4,'19:00:00','20:15:00','Lecture'),(23,16,2,'08:00:00','09:15:00','Lecture'),(24,16,4,'08:00:00','09:15:00','Lecture'),(25,18,2,'14:00:00','15:15:00','Lecture'),(26,18,4,'14:00:00','15:15:00','Lecture'),(27,19,1,'17:30:00','18:45:00','Lecture'),(28,19,3,'17:30:00','18:45:00','Lecture'),(29,20,1,'11:00:00','11:50:00','Lecture'),(30,20,3,'11:00:00','11:50:00','Lecture'),(31,20,5,'11:00:00','11:50:00','Lecture'),(32,23,4,'16:00:00','18:40:00','Lecture'),(33,22,3,'19:00:00','21:40:00','Lecture'),(34,21,1,'12:00:00','12:50:00','Lecture'),(35,21,3,'12:00:00','12:50:00','Lecture'),(36,21,5,'12:00:00','12:50:00','Lecture'),(37,59,1,'10:00:00','10:50:00','Discussion'),(38,59,2,'10:00:00','10:50:00','Discussion'),(39,59,3,'10:00:00','10:50:00','Discussion'),(40,60,1,'09:00:00','09:50:00','Discussion'),(41,60,3,'09:00:00','09:50:00','Discussion'),(42,60,5,'09:00:00','09:50:00','Discussion'),(43,61,2,'14:00:00','15:15:00','Discussion'),(44,61,4,'14:00:00','15:15:00','Discussion'),(45,62,1,'12:00:00','12:50:00','Discussion'),(46,62,3,'12:00:00','12:50:00','Discussion'),(47,62,5,'12:00:00','12:50:00','Discussion'),(48,63,1,'10:00:00','10:50:00','Discussion'),(49,63,3,'10:00:00','10:50:00','Discussion'),(50,63,5,'10:00:00','10:50:00','Discussion'),(51,64,1,'10:00:00','10:50:00','Discussion'),(52,64,3,'10:00:00','10:50:00','Discussion'),(53,64,5,'10:00:00','10:50:00','Discussion'),(54,65,1,'09:00:00','10:50:00','Activity'),(55,24,1,'14:00:00','15:15:00','Discussion'),(56,24,3,'14:00:00','15:15:00','Discussion'),(57,25,1,'16:00:00','17:15:00','Discussion'),(58,25,3,'16:00:00','17:15:00','Discussion'),(59,26,2,'11:00:00','12:15:00','Discussion'),(60,26,4,'11:00:00','12:15:00','Discussion'),(61,28,1,'12:00:00','12:50:00','Discussion'),(62,28,3,'12:00:00','12:50:00','Discussion'),(63,28,5,'12:00:00','12:50:00','Discussion'),(64,27,3,'19:00:00','21:40:00','Discussion'),(65,29,2,'15:30:00','16:45:00','Lecture'),(66,29,4,'15:30:00','16:45:00','Lecture'),(67,30,1,'19:00:00','20:15:00','Lecture'),(68,30,3,'19:00:00','20:15:00','Lecture'),(69,31,2,'14:00:00','15:15:00','Lecture'),(70,31,4,'14:00:00','15:15:00','Lecture'),(71,33,2,'12:30:00','13:45:00','Lecture'),(72,33,4,'12:30:00','13:45:00','Lecture'),(73,34,2,'17:30:00','18:45:00','Lecture'),(74,34,4,'17:30:00','18:45:00','Lecture'),(75,32,2,'17:30:00','18:45:00','Lecture'),(76,32,4,'17:30:00','18:45:00','Lecture'),(77,35,1,'19:00:00','21:40:00','Discussion'),(78,37,2,'17:30:00','18:45:00','Lecture'),(79,37,4,'17:30:00','18:45:00','Lecture'),(80,36,2,'16:00:00','17:15:00','Lecture'),(81,36,4,'16:00:00','17:15:00','Lecture'),(82,38,2,'17:30:00','18:45:00','Discussion'),(83,38,4,'17:30:00','18:45:00','Discussion'),(84,39,2,'14:00:00','15:15:00','Discussion'),(85,39,4,'14:00:00','15:15:00','Discussion'),(86,41,2,'19:00:00','20:15:00','Discussion'),(87,41,4,'19:00:00','20:15:00','Discussion'),(88,40,2,'12:30:00','13:45:00','Discussion'),(89,40,4,'12:30:00','13:45:00','Discussion'),(90,42,2,'17:30:00','18:45:00','Discussion'),(91,42,4,'17:30:00','18:45:00','Discussion'),(92,43,2,'17:30:00','18:45:00','Lecture'),(93,43,4,'17:30:00','18:45:00','Lecture'),(94,44,2,'17:30:00','18:45:00','Lecture'),(95,44,4,'17:30:00','18:45:00','Lecture'),(96,45,2,'14:00:00','15:15:00','Lecture'),(97,45,4,'14:00:00','15:15:00','Lecture'),(98,46,2,'16:00:00','17:15:00','Discussion'),(99,46,4,'16:00:00','17:15:00','Discussion'),(100,47,1,'19:00:00','20:15:00','Lecture'),(101,47,3,'19:00:00','20:15:00','Lecture'),(102,48,1,'14:00:00','15:15:00','Discussion'),(103,48,3,'14:00:00','15:15:00','Discussion'),(104,51,2,'19:00:00','21:40:00','Discussion'),(105,50,2,'14:00:00','15:15:00','Discussion'),(106,50,4,'14:00:00','15:15:00','Discussion'),(107,49,1,'13:00:00','13:50:00','Discussion'),(108,49,3,'13:00:00','13:50:00','Discussion'),(109,49,5,'13:00:00','13:50:00','Discussion'),(110,52,1,'17:30:00','18:45:00','Lecture'),(111,52,3,'17:30:00','18:45:00','Lecture'),(112,53,2,'11:00:00','12:15:00','Discussion'),(113,53,4,'11:00:00','12:15:00','Discussion'),(114,54,1,'14:00:00','15:15:00','Discussion'),(115,54,3,'14:00:00','15:15:00','Discussion'),(116,55,1,'19:00:00','20:15:00','Discussion'),(117,55,3,'19:00:00','20:15:00','Discussion'),(118,69,2,'17:30:00','18:45:00','Discussion'),(119,69,4,'17:30:00','18:45:00','Discussion'),(120,67,1,'17:30:00','18:45:00','Discussion'),(121,67,3,'17:30:00','18:45:00','Discussion'),(122,68,1,'14:00:00','15:15:00','Discussion'),(123,68,3,'14:00:00','15:15:00','Discussion'),(124,56,3,'19:00:00','21:40:00','Lecture'),(125,57,2,'18:30:00','19:45:00','Lecture'),(126,57,4,'18:30:00','19:45:00','Lecture'),(127,58,2,'15:30:00','16:45:00','Lecture'),(128,58,4,'15:30:00','16:45:00','Lecture'),(256,128,1,'11:00:00','11:50:00','Discussion'),(257,128,3,'11:00:00','11:50:00','Discussion'),(258,128,5,'11:00:00','11:50:00','Discussion'),(259,129,1,'15:30:00','16:45:00','Discussion'),(260,129,3,'15:30:00','16:45:00','Discussion'),(261,130,2,'17:30:00','18:45:00','Lecture'),(262,130,4,'17:30:00','18:45:00','Lecture'),(263,131,2,'11:00:00','12:15:00','Discussion'),(264,131,4,'11:00:00','12:15:00','Discussion'),(265,132,1,'10:00:00','10:50:00','Lecture'),(266,132,3,'10:00:00','10:50:00','Lecture'),(267,134,2,'15:30:00','16:45:00','Lecture'),(268,134,4,'15:30:00','16:45:00','Lecture'),(269,137,1,'10:00:00','10:50:00','Lecture'),(270,137,3,'10:00:00','10:50:00','Lecture'),(271,138,2,'12:30:00','13:45:00','Lecture'),(272,138,4,'12:30:00','13:45:00','Lecture'),(273,141,2,'14:00:00','15:15:00','Lecture'),(274,141,4,'14:00:00','15:15:00','Lecture');
/*!40000 ALTER TABLE `section_meetings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `terms`
--

DROP TABLE IF EXISTS `terms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `terms` (
  `id` int NOT NULL AUTO_INCREMENT,
  `term_name` varchar(50) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_term_name` (`term_name`),
  CONSTRAINT `terms_chk_1` CHECK (((`start_date` is null) or (`end_date` is null) or (`end_date` >= `start_date`)))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `terms`
--

LOCK TABLES `terms` WRITE;
/*!40000 ALTER TABLE `terms` DISABLE KEYS */;
INSERT INTO `terms` VALUES (1,'Spring 2027','2027-01-21','2027-05-06');
/*!40000 ALTER TABLE `terms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `google_id` varchar(255) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_user_email` (`email`),
  UNIQUE KEY `google_id` (`google_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'test@example.com','google-test-123','Test','User',NULL),(11,'noamgaribi@gmail.com',NULL,'Noam','Garibi','$2b$12$XqA0RODzDptuUoExTEb3DuIhkcTnMs88kuevOXhIly/..BELscOgu'),(13,'jramosgracia4630@sdsu.edu',NULL,'Jacobo','Ramos','$2b$12$/RnBJ0tLvsE1/h5aQpAaw.BTHoIOmHCy6dI0D5Bu0/XG8bTp9WlOK'),(15,'jacobokirigaya@gmail.com',NULL,'Jaykov','R','$2b$12$E7XB8NESYuz8JV3Gcdzlw./m1MBJ4cX5edfczyEN2wdmH.l1PnHUC');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_courses`
--

DROP TABLE IF EXISTS `user_courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_courses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `course_code` varchar(20) NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  `course_id` int DEFAULT NULL,
  `audit_import_id` int DEFAULT NULL,
  `source_institution` varchar(150) DEFAULT NULL,
  `term_label` varchar(50) DEFAULT NULL,
  `grade` varchar(10) DEFAULT NULL,
  `earned_units` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `fk_user_course_catalog` (`course_id`),
  KEY `fk_user_course_audit_owner` (`audit_import_id`,`user_id`),
  CONSTRAINT `fk_user_course_audit_owner` FOREIGN KEY (`audit_import_id`, `user_id`) REFERENCES `audit_imports` (`id`, `user_id`),
  CONSTRAINT `fk_user_course_catalog` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`),
  CONSTRAINT `user_courses_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `chk_user_course_units` CHECK (((`earned_units` is null) or (`earned_units` >= 0)))
) ENGINE=InnoDB AUTO_INCREMENT=908 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_courses`
--

LOCK TABLES `user_courses` WRITE;
/*!40000 ALTER TABLE `user_courses` DISABLE KEYS */;
INSERT INTO `user_courses` VALUES (1,11,'ACCTG 390W','completed',NULL,1,NULL,NULL,NULL,NULL),(2,11,'AFRAS 305W','completed',NULL,1,NULL,NULL,NULL,NULL),(3,11,'CCS 300W','completed',NULL,1,NULL,NULL,NULL,NULL),(4,11,'CCS 396W','completed',NULL,1,NULL,NULL,NULL,NULL),(5,11,'CIV E 495W','completed',NULL,1,NULL,NULL,NULL,NULL),(6,11,'COMPE 491W','completed',NULL,1,NULL,NULL,NULL,NULL),(7,11,'CON M 495W','completed',NULL,1,NULL,NULL,NULL,NULL),(8,11,'DANCE 481W','completed',NULL,1,NULL,NULL,NULL,NULL),(9,11,'ECON 449W','completed',NULL,1,NULL,NULL,NULL,NULL),(10,11,'ECL 306W','completed',NULL,1,NULL,NULL,NULL,NULL),(11,11,'ECL 308W','completed',NULL,1,NULL,NULL,NULL,NULL),(12,11,'HIST 390W','completed',NULL,1,NULL,NULL,NULL,NULL),(13,11,'JMS 310W','completed',NULL,1,NULL,NULL,NULL,NULL),(14,11,'LING 305W','completed',NULL,1,NULL,NULL,NULL,NULL),(15,11,'MIS 396W','completed',NULL,1,NULL,NULL,NULL,NULL),(16,11,'MUSIC 409W','completed',NULL,1,NULL,NULL,NULL,NULL),(17,11,'NURS 307W','completed',NULL,1,NULL,NULL,NULL,NULL),(18,11,'POL S 390W','completed',NULL,1,NULL,NULL,NULL,NULL),(19,11,'PSFA 305W','completed',NULL,1,NULL,NULL,NULL,NULL),(20,11,'PUB 350W','completed',NULL,1,NULL,NULL,NULL,NULL),(21,11,'REL S 396W','completed',NULL,1,NULL,NULL,NULL,NULL),(22,11,'RTM 396W','completed',NULL,1,NULL,NULL,NULL,NULL),(23,11,'RWS 305W','completed',NULL,1,NULL,NULL,NULL,NULL),(24,11,'RWS 503W','completed',NULL,1,NULL,NULL,NULL,NULL),(25,11,'TE 405W','completed',NULL,1,NULL,NULL,NULL,NULL),(26,11,'TFM 390W','completed',NULL,1,NULL,NULL,NULL,NULL),(27,11,'HIST 109','completed',NULL,1,NULL,NULL,NULL,NULL),(28,11,'HIST 110','completed',NULL,1,NULL,NULL,NULL,NULL),(29,11,'AMIND 141','completed',NULL,1,NULL,NULL,NULL,NULL),(30,11,'AFRAS 140','completed',NULL,1,NULL,NULL,NULL,NULL),(31,11,'AFRAS 120','completed',NULL,1,NULL,NULL,NULL,NULL),(32,11,'RWS 200','completed',NULL,1,NULL,NULL,NULL,NULL),(33,11,'PHYS 195','completed',12,1,NULL,NULL,NULL,NULL),(34,11,'ANTH 101','completed',61,1,NULL,NULL,NULL,NULL),(35,11,'PHYS 182A','completed',NULL,1,NULL,NULL,NULL,NULL),(36,11,'MATH 150','completed',8,1,NULL,NULL,NULL,NULL),(37,11,'ECON 101','completed',NULL,1,NULL,NULL,NULL,NULL),(38,11,'ECON 102','completed',NULL,1,NULL,NULL,NULL,NULL),(39,11,'TFM 160','completed',NULL,1,NULL,NULL,NULL,NULL),(40,11,'ART 133','completed',NULL,1,NULL,NULL,NULL,NULL),(41,11,'HIST 101','completed',NULL,1,NULL,NULL,NULL,NULL),(42,11,'CSP 150','completed',NULL,1,NULL,NULL,NULL,NULL),(43,11,'CS 150','completed',1,1,NULL,NULL,NULL,NULL),(44,11,'CISC 190','completed',NULL,1,NULL,NULL,NULL,NULL),(45,11,'CS 150L','completed',2,1,NULL,NULL,NULL,NULL),(46,11,'CS 160','completed',3,1,NULL,NULL,NULL,NULL),(47,11,'CISC 192','completed',NULL,1,NULL,NULL,NULL,NULL),(48,11,'CS 160L','completed',4,1,NULL,NULL,NULL,NULL),(49,11,'CS 210','completed',5,1,NULL,NULL,NULL,NULL),(50,11,'CS 240','in_progress',6,1,NULL,NULL,NULL,NULL),(51,11,'CS 250','in_progress',7,1,NULL,NULL,NULL,NULL),(52,11,'MATH 151','completed',9,1,NULL,NULL,NULL,NULL),(53,11,'MATH 245','completed',10,1,NULL,NULL,NULL,NULL),(54,11,'MATH 254','completed',11,1,NULL,NULL,NULL,NULL),(55,11,'PHYS 196','completed',14,1,NULL,NULL,NULL,NULL),(56,11,'PHYS 196L','completed',15,1,NULL,NULL,NULL,NULL),(57,11,'STAT 250','completed',16,1,NULL,NULL,NULL,NULL),(58,11,'CS 370','in_progress',17,1,NULL,NULL,NULL,NULL),(59,11,'CS 420','in_progress',21,1,NULL,NULL,NULL,NULL),(60,11,'CS 450','completed',18,1,NULL,NULL,NULL,NULL),(61,11,'STAT 550','completed',22,1,NULL,NULL,NULL,NULL),(62,11,'CS 470','completed',23,1,NULL,NULL,NULL,NULL),(63,11,'CS 562','completed',28,1,NULL,NULL,NULL,NULL),(64,11,'CY 575','completed',39,1,NULL,NULL,NULL,NULL),(65,11,'CS 576','completed',31,1,NULL,NULL,NULL,NULL),(66,11,'CY 302','completed',33,1,NULL,NULL,NULL,NULL),(67,11,'CS 549','completed',40,1,NULL,NULL,NULL,NULL),(68,11,'CS 583','completed',45,1,NULL,NULL,NULL,NULL),(69,11,'CY 541','completed',46,1,NULL,NULL,NULL,NULL),(70,11,'CS 503','completed',47,1,NULL,NULL,NULL,NULL),(71,11,'CS 496','completed',53,1,NULL,NULL,NULL,NULL),(72,11,'CS 100','completed',NULL,1,NULL,NULL,NULL,NULL),(73,11,'CS 299','completed',NULL,1,NULL,NULL,NULL,NULL),(74,11,'GEN S 100C','completed',NULL,1,NULL,NULL,NULL,NULL),(75,11,'MATH 141','completed',NULL,1,NULL,NULL,NULL,NULL),(76,11,'PHYS 180A','completed',NULL,1,NULL,NULL,NULL,NULL),(77,11,'POL S 299','completed',NULL,1,NULL,NULL,NULL,NULL),(78,11,'CISC 211','in_progress',NULL,1,NULL,NULL,NULL,NULL),(79,11,'ACCTG 390W','completed',NULL,2,NULL,NULL,NULL,NULL),(80,11,'AFRAS 305W','completed',NULL,2,NULL,NULL,NULL,NULL),(81,11,'CCS 300W','completed',NULL,2,NULL,NULL,NULL,NULL),(82,11,'CCS 396W','completed',NULL,2,NULL,NULL,NULL,NULL),(83,11,'CIV E 495W','completed',NULL,2,NULL,NULL,NULL,NULL),(84,11,'COMPE 491W','completed',NULL,2,NULL,NULL,NULL,NULL),(85,11,'CON M 495W','completed',NULL,2,NULL,NULL,NULL,NULL),(86,11,'DANCE 481W','completed',NULL,2,NULL,NULL,NULL,NULL),(87,11,'ECON 449W','completed',NULL,2,NULL,NULL,NULL,NULL),(88,11,'ECL 306W','completed',NULL,2,NULL,NULL,NULL,NULL),(89,11,'ECL 308W','completed',NULL,2,NULL,NULL,NULL,NULL),(90,11,'HIST 390W','completed',NULL,2,NULL,NULL,NULL,NULL),(91,11,'JMS 310W','completed',NULL,2,NULL,NULL,NULL,NULL),(92,11,'LING 305W','completed',NULL,2,NULL,NULL,NULL,NULL),(93,11,'MIS 396W','completed',NULL,2,NULL,NULL,NULL,NULL),(94,11,'MUSIC 409W','completed',NULL,2,NULL,NULL,NULL,NULL),(95,11,'NURS 307W','completed',NULL,2,NULL,NULL,NULL,NULL),(96,11,'POL S 390W','completed',NULL,2,NULL,NULL,NULL,NULL),(97,11,'PSFA 305W','completed',NULL,2,NULL,NULL,NULL,NULL),(98,11,'PUB 350W','completed',NULL,2,NULL,NULL,NULL,NULL),(99,11,'REL S 396W','completed',NULL,2,NULL,NULL,NULL,NULL),(100,11,'RTM 396W','completed',NULL,2,NULL,NULL,NULL,NULL),(101,11,'RWS 305W','completed',NULL,2,NULL,NULL,NULL,NULL),(102,11,'RWS 503W','completed',NULL,2,NULL,NULL,NULL,NULL),(103,11,'TE 405W','completed',NULL,2,NULL,NULL,NULL,NULL),(104,11,'TFM 390W','completed',NULL,2,NULL,NULL,NULL,NULL),(105,11,'HIST 109','completed',NULL,2,NULL,NULL,NULL,NULL),(106,11,'HIST 110','completed',NULL,2,NULL,NULL,NULL,NULL),(107,11,'AMIND 141','completed',NULL,2,NULL,NULL,NULL,NULL),(108,11,'AFRAS 140','completed',NULL,2,NULL,NULL,NULL,NULL),(109,11,'AFRAS 120','completed',NULL,2,NULL,NULL,NULL,NULL),(110,11,'RWS 200','completed',NULL,2,NULL,NULL,NULL,NULL),(111,11,'PHYS 195','completed',12,2,NULL,NULL,NULL,NULL),(112,11,'ANTH 101','completed',61,2,NULL,NULL,NULL,NULL),(113,11,'PHYS 182A','completed',NULL,2,NULL,NULL,NULL,NULL),(114,11,'MATH 150','completed',8,2,NULL,NULL,NULL,NULL),(115,11,'ECON 101','completed',NULL,2,NULL,NULL,NULL,NULL),(116,11,'ECON 102','completed',NULL,2,NULL,NULL,NULL,NULL),(117,11,'TFM 160','completed',NULL,2,NULL,NULL,NULL,NULL),(118,11,'ART 133','completed',NULL,2,NULL,NULL,NULL,NULL),(119,11,'HIST 101','completed',NULL,2,NULL,NULL,NULL,NULL),(120,11,'CSP 150','completed',NULL,2,NULL,NULL,NULL,NULL),(121,11,'CS 150','completed',1,2,NULL,NULL,NULL,NULL),(122,11,'CISC 190','completed',NULL,2,NULL,NULL,NULL,NULL),(123,11,'CS 150L','completed',2,2,NULL,NULL,NULL,NULL),(124,11,'CS 160','completed',3,2,NULL,NULL,NULL,NULL),(125,11,'CISC 192','completed',NULL,2,NULL,NULL,NULL,NULL),(126,11,'CS 160L','completed',4,2,NULL,NULL,NULL,NULL),(127,11,'CS 210','completed',5,2,NULL,NULL,NULL,NULL),(128,11,'CS 240','in_progress',6,2,NULL,NULL,NULL,NULL),(129,11,'CS 250','in_progress',7,2,NULL,NULL,NULL,NULL),(130,11,'MATH 151','completed',9,2,NULL,NULL,NULL,NULL),(131,11,'MATH 245','completed',10,2,NULL,NULL,NULL,NULL),(132,11,'MATH 254','completed',11,2,NULL,NULL,NULL,NULL),(133,11,'PHYS 196','completed',14,2,NULL,NULL,NULL,NULL),(134,11,'PHYS 196L','completed',15,2,NULL,NULL,NULL,NULL),(135,11,'STAT 250','completed',16,2,NULL,NULL,NULL,NULL),(136,11,'CS 370','in_progress',17,2,NULL,NULL,NULL,NULL),(137,11,'CS 420','in_progress',21,2,NULL,NULL,NULL,NULL),(138,11,'CS 450','completed',18,2,NULL,NULL,NULL,NULL),(139,11,'STAT 550','completed',22,2,NULL,NULL,NULL,NULL),(140,11,'CS 470','completed',23,2,NULL,NULL,NULL,NULL),(141,11,'CS 562','completed',28,2,NULL,NULL,NULL,NULL),(142,11,'CY 575','completed',39,2,NULL,NULL,NULL,NULL),(143,11,'CS 576','completed',31,2,NULL,NULL,NULL,NULL),(144,11,'CY 302','completed',33,2,NULL,NULL,NULL,NULL),(145,11,'CS 549','completed',40,2,NULL,NULL,NULL,NULL),(146,11,'CS 583','completed',45,2,NULL,NULL,NULL,NULL),(147,11,'CY 541','completed',46,2,NULL,NULL,NULL,NULL),(148,11,'CS 503','completed',47,2,NULL,NULL,NULL,NULL),(149,11,'CS 496','completed',53,2,NULL,NULL,NULL,NULL),(150,11,'CS 100','completed',NULL,2,NULL,NULL,NULL,NULL),(151,11,'CS 299','completed',NULL,2,NULL,NULL,NULL,NULL),(152,11,'GEN S 100C','completed',NULL,2,NULL,NULL,NULL,NULL),(153,11,'MATH 141','completed',NULL,2,NULL,NULL,NULL,NULL),(154,11,'PHYS 180A','completed',NULL,2,NULL,NULL,NULL,NULL),(155,11,'POL S 299','completed',NULL,2,NULL,NULL,NULL,NULL),(156,11,'CISC 211','in_progress',NULL,2,NULL,NULL,NULL,NULL),(157,11,'ACCTG 390W','completed',NULL,3,NULL,NULL,NULL,NULL),(158,11,'AFRAS 305W','completed',NULL,3,NULL,NULL,NULL,NULL),(159,11,'CCS 300W','completed',NULL,3,NULL,NULL,NULL,NULL),(160,11,'CCS 396W','completed',NULL,3,NULL,NULL,NULL,NULL),(161,11,'CIV E 495W','completed',NULL,3,NULL,NULL,NULL,NULL),(162,11,'COMPE 491W','completed',NULL,3,NULL,NULL,NULL,NULL),(163,11,'CON M 495W','completed',NULL,3,NULL,NULL,NULL,NULL),(164,11,'DANCE 481W','completed',NULL,3,NULL,NULL,NULL,NULL),(165,11,'ECON 449W','completed',NULL,3,NULL,NULL,NULL,NULL),(166,11,'ECL 306W','completed',NULL,3,NULL,NULL,NULL,NULL),(167,11,'ECL 308W','completed',NULL,3,NULL,NULL,NULL,NULL),(168,11,'HIST 390W','completed',NULL,3,NULL,NULL,NULL,NULL),(169,11,'JMS 310W','completed',NULL,3,NULL,NULL,NULL,NULL),(170,11,'LING 305W','completed',NULL,3,NULL,NULL,NULL,NULL),(171,11,'MIS 396W','completed',NULL,3,NULL,NULL,NULL,NULL),(172,11,'MUSIC 409W','completed',NULL,3,NULL,NULL,NULL,NULL),(173,11,'NURS 307W','completed',NULL,3,NULL,NULL,NULL,NULL),(174,11,'POL S 390W','completed',NULL,3,NULL,NULL,NULL,NULL),(175,11,'PSFA 305W','completed',NULL,3,NULL,NULL,NULL,NULL),(176,11,'PUB 350W','completed',NULL,3,NULL,NULL,NULL,NULL),(177,11,'REL S 396W','completed',NULL,3,NULL,NULL,NULL,NULL),(178,11,'RTM 396W','completed',NULL,3,NULL,NULL,NULL,NULL),(179,11,'RWS 305W','completed',NULL,3,NULL,NULL,NULL,NULL),(180,11,'RWS 503W','completed',NULL,3,NULL,NULL,NULL,NULL),(181,11,'TE 405W','completed',NULL,3,NULL,NULL,NULL,NULL),(182,11,'TFM 390W','completed',NULL,3,NULL,NULL,NULL,NULL),(183,11,'HIST 109','completed',NULL,3,NULL,NULL,NULL,NULL),(184,11,'HIST 110','completed',NULL,3,NULL,NULL,NULL,NULL),(185,11,'AMIND 141','completed',NULL,3,NULL,NULL,NULL,NULL),(186,11,'AFRAS 140','completed',NULL,3,NULL,NULL,NULL,NULL),(187,11,'AFRAS 120','completed',NULL,3,NULL,NULL,NULL,NULL),(188,11,'RWS 200','completed',NULL,3,NULL,NULL,NULL,NULL),(189,11,'PHYS 195','completed',12,3,NULL,NULL,NULL,NULL),(190,11,'ANTH 101','completed',61,3,NULL,NULL,NULL,NULL),(191,11,'PHYS 182A','completed',NULL,3,NULL,NULL,NULL,NULL),(192,11,'MATH 150','completed',8,3,NULL,NULL,NULL,NULL),(193,11,'ECON 101','completed',NULL,3,NULL,NULL,NULL,NULL),(194,11,'ECON 102','completed',NULL,3,NULL,NULL,NULL,NULL),(195,11,'TFM 160','completed',NULL,3,NULL,NULL,NULL,NULL),(196,11,'ART 133','completed',NULL,3,NULL,NULL,NULL,NULL),(197,11,'HIST 101','completed',NULL,3,NULL,NULL,NULL,NULL),(198,11,'CSP 150','completed',NULL,3,NULL,NULL,NULL,NULL),(199,11,'CS 150','completed',1,3,NULL,NULL,NULL,NULL),(200,11,'CISC 190','completed',NULL,3,NULL,NULL,NULL,NULL),(201,11,'CS 150L','completed',2,3,NULL,NULL,NULL,NULL),(202,11,'CS 160','completed',3,3,NULL,NULL,NULL,NULL),(203,11,'CISC 192','completed',NULL,3,NULL,NULL,NULL,NULL),(204,11,'CS 160L','completed',4,3,NULL,NULL,NULL,NULL),(205,11,'CS 210','completed',5,3,NULL,NULL,NULL,NULL),(206,11,'CS 240','in_progress',6,3,NULL,NULL,NULL,NULL),(207,11,'CS 250','in_progress',7,3,NULL,NULL,NULL,NULL),(208,11,'MATH 151','completed',9,3,NULL,NULL,NULL,NULL),(209,11,'MATH 245','completed',10,3,NULL,NULL,NULL,NULL),(210,11,'MATH 254','completed',11,3,NULL,NULL,NULL,NULL),(211,11,'PHYS 196','completed',14,3,NULL,NULL,NULL,NULL),(212,11,'PHYS 196L','completed',15,3,NULL,NULL,NULL,NULL),(213,11,'STAT 250','completed',16,3,NULL,NULL,NULL,NULL),(214,11,'CS 370','in_progress',17,3,NULL,NULL,NULL,NULL),(215,11,'CS 420','in_progress',21,3,NULL,NULL,NULL,NULL),(216,11,'CS 450','completed',18,3,NULL,NULL,NULL,NULL),(217,11,'STAT 550','completed',22,3,NULL,NULL,NULL,NULL),(218,11,'CS 470','completed',23,3,NULL,NULL,NULL,NULL),(219,11,'CS 562','completed',28,3,NULL,NULL,NULL,NULL),(220,11,'CY 575','completed',39,3,NULL,NULL,NULL,NULL),(221,11,'CS 576','completed',31,3,NULL,NULL,NULL,NULL),(222,11,'CY 302','completed',33,3,NULL,NULL,NULL,NULL),(223,11,'CS 549','completed',40,3,NULL,NULL,NULL,NULL),(224,11,'CS 583','completed',45,3,NULL,NULL,NULL,NULL),(225,11,'CY 541','completed',46,3,NULL,NULL,NULL,NULL),(226,11,'CS 503','completed',47,3,NULL,NULL,NULL,NULL),(227,11,'CS 496','completed',53,3,NULL,NULL,NULL,NULL),(228,11,'CS 100','completed',NULL,3,NULL,NULL,NULL,NULL),(229,11,'CS 299','completed',NULL,3,NULL,NULL,NULL,NULL),(230,11,'GEN S 100C','completed',NULL,3,NULL,NULL,NULL,NULL),(231,11,'MATH 141','completed',NULL,3,NULL,NULL,NULL,NULL),(232,11,'PHYS 180A','completed',NULL,3,NULL,NULL,NULL,NULL),(233,11,'POL S 299','completed',NULL,3,NULL,NULL,NULL,NULL),(234,11,'CISC 211','in_progress',NULL,3,NULL,NULL,NULL,NULL),(235,11,'ACCTG 390W','completed',NULL,4,NULL,NULL,NULL,NULL),(236,11,'AFRAS 305W','completed',NULL,4,NULL,NULL,NULL,NULL),(237,11,'CCS 300W','completed',NULL,4,NULL,NULL,NULL,NULL),(238,11,'CCS 396W','completed',NULL,4,NULL,NULL,NULL,NULL),(239,11,'CIV E 495W','completed',NULL,4,NULL,NULL,NULL,NULL),(240,11,'COMPE 491W','completed',NULL,4,NULL,NULL,NULL,NULL),(241,11,'CON M 495W','completed',NULL,4,NULL,NULL,NULL,NULL),(242,11,'DANCE 481W','completed',NULL,4,NULL,NULL,NULL,NULL),(243,11,'ECON 449W','completed',NULL,4,NULL,NULL,NULL,NULL),(244,11,'ECL 306W','completed',NULL,4,NULL,NULL,NULL,NULL),(245,11,'ECL 308W','completed',NULL,4,NULL,NULL,NULL,NULL),(246,11,'HIST 390W','completed',NULL,4,NULL,NULL,NULL,NULL),(247,11,'JMS 310W','completed',NULL,4,NULL,NULL,NULL,NULL),(248,11,'LING 305W','completed',NULL,4,NULL,NULL,NULL,NULL),(249,11,'MIS 396W','completed',NULL,4,NULL,NULL,NULL,NULL),(250,11,'MUSIC 409W','completed',NULL,4,NULL,NULL,NULL,NULL),(251,11,'NURS 307W','completed',NULL,4,NULL,NULL,NULL,NULL),(252,11,'POL S 390W','completed',NULL,4,NULL,NULL,NULL,NULL),(253,11,'PSFA 305W','completed',NULL,4,NULL,NULL,NULL,NULL),(254,11,'PUB 350W','completed',NULL,4,NULL,NULL,NULL,NULL),(255,11,'REL S 396W','completed',NULL,4,NULL,NULL,NULL,NULL),(256,11,'RTM 396W','completed',NULL,4,NULL,NULL,NULL,NULL),(257,11,'RWS 305W','completed',NULL,4,NULL,NULL,NULL,NULL),(258,11,'RWS 503W','completed',NULL,4,NULL,NULL,NULL,NULL),(259,11,'TE 405W','completed',NULL,4,NULL,NULL,NULL,NULL),(260,11,'TFM 390W','completed',NULL,4,NULL,NULL,NULL,NULL),(261,11,'HIST 109','completed',NULL,4,NULL,NULL,NULL,NULL),(262,11,'HIST 110','completed',NULL,4,NULL,NULL,NULL,NULL),(263,11,'AMIND 141','completed',NULL,4,NULL,NULL,NULL,NULL),(264,11,'AFRAS 140','completed',NULL,4,NULL,NULL,NULL,NULL),(265,11,'AFRAS 120','completed',NULL,4,NULL,NULL,NULL,NULL),(266,11,'RWS 200','completed',NULL,4,NULL,NULL,NULL,NULL),(267,11,'PHYS 195','completed',12,4,NULL,NULL,NULL,NULL),(268,11,'ANTH 101','completed',61,4,NULL,NULL,NULL,NULL),(269,11,'PHYS 182A','completed',NULL,4,NULL,NULL,NULL,NULL),(270,11,'MATH 150','completed',8,4,NULL,NULL,NULL,NULL),(271,11,'ECON 101','completed',NULL,4,NULL,NULL,NULL,NULL),(272,11,'ECON 102','completed',NULL,4,NULL,NULL,NULL,NULL),(273,11,'TFM 160','completed',NULL,4,NULL,NULL,NULL,NULL),(274,11,'ART 133','completed',NULL,4,NULL,NULL,NULL,NULL),(275,11,'HIST 101','completed',NULL,4,NULL,NULL,NULL,NULL),(276,11,'CSP 150','completed',NULL,4,NULL,NULL,NULL,NULL),(277,11,'CS 150','completed',1,4,NULL,NULL,NULL,NULL),(278,11,'CISC 190','completed',NULL,4,NULL,NULL,NULL,NULL),(279,11,'CS 150L','completed',2,4,NULL,NULL,NULL,NULL),(280,11,'CS 160','completed',3,4,NULL,NULL,NULL,NULL),(281,11,'CISC 192','completed',NULL,4,NULL,NULL,NULL,NULL),(282,11,'CS 160L','completed',4,4,NULL,NULL,NULL,NULL),(283,11,'CS 210','completed',5,4,NULL,NULL,NULL,NULL),(284,11,'CS 240','in_progress',6,4,NULL,NULL,NULL,NULL),(285,11,'CS 250','in_progress',7,4,NULL,NULL,NULL,NULL),(286,11,'MATH 151','completed',9,4,NULL,NULL,NULL,NULL),(287,11,'MATH 245','completed',10,4,NULL,NULL,NULL,NULL),(288,11,'MATH 254','completed',11,4,NULL,NULL,NULL,NULL),(289,11,'PHYS 196','completed',14,4,NULL,NULL,NULL,NULL),(290,11,'PHYS 196L','completed',15,4,NULL,NULL,NULL,NULL),(291,11,'STAT 250','completed',16,4,NULL,NULL,NULL,NULL),(292,11,'CS 370','in_progress',17,4,NULL,NULL,NULL,NULL),(293,11,'CS 420','in_progress',21,4,NULL,NULL,NULL,NULL),(294,11,'CS 450','completed',18,4,NULL,NULL,NULL,NULL),(295,11,'STAT 550','completed',22,4,NULL,NULL,NULL,NULL),(296,11,'CS 470','completed',23,4,NULL,NULL,NULL,NULL),(297,11,'CS 562','completed',28,4,NULL,NULL,NULL,NULL),(298,11,'CY 575','completed',39,4,NULL,NULL,NULL,NULL),(299,11,'CS 576','completed',31,4,NULL,NULL,NULL,NULL),(300,11,'CY 302','completed',33,4,NULL,NULL,NULL,NULL),(301,11,'CS 549','completed',40,4,NULL,NULL,NULL,NULL),(302,11,'CS 583','completed',45,4,NULL,NULL,NULL,NULL),(303,11,'CY 541','completed',46,4,NULL,NULL,NULL,NULL),(304,11,'CS 503','completed',47,4,NULL,NULL,NULL,NULL),(305,11,'CS 496','completed',53,4,NULL,NULL,NULL,NULL),(306,11,'CS 100','completed',NULL,4,NULL,NULL,NULL,NULL),(307,11,'CS 299','completed',NULL,4,NULL,NULL,NULL,NULL),(308,11,'GEN S 100C','completed',NULL,4,NULL,NULL,NULL,NULL),(309,11,'MATH 141','completed',NULL,4,NULL,NULL,NULL,NULL),(310,11,'PHYS 180A','completed',NULL,4,NULL,NULL,NULL,NULL),(311,11,'POL S 299','completed',NULL,4,NULL,NULL,NULL,NULL),(312,11,'CISC 211','in_progress',NULL,4,NULL,NULL,NULL,NULL),(313,11,'ACCTG 390W','completed',NULL,5,NULL,NULL,NULL,NULL),(314,11,'AFRAS 305W','completed',NULL,5,NULL,NULL,NULL,NULL),(315,11,'CCS 300W','completed',NULL,5,NULL,NULL,NULL,NULL),(316,11,'CCS 396W','completed',NULL,5,NULL,NULL,NULL,NULL),(317,11,'CIV E 495W','completed',NULL,5,NULL,NULL,NULL,NULL),(318,11,'COMPE 491W','completed',NULL,5,NULL,NULL,NULL,NULL),(319,11,'CON M 495W','completed',NULL,5,NULL,NULL,NULL,NULL),(320,11,'DANCE 481W','completed',NULL,5,NULL,NULL,NULL,NULL),(321,11,'ECON 449W','completed',NULL,5,NULL,NULL,NULL,NULL),(322,11,'ECL 306W','completed',NULL,5,NULL,NULL,NULL,NULL),(323,11,'ECL 308W','completed',NULL,5,NULL,NULL,NULL,NULL),(324,11,'HIST 390W','completed',NULL,5,NULL,NULL,NULL,NULL),(325,11,'JMS 310W','completed',NULL,5,NULL,NULL,NULL,NULL),(326,11,'LING 305W','completed',NULL,5,NULL,NULL,NULL,NULL),(327,11,'MIS 396W','completed',NULL,5,NULL,NULL,NULL,NULL),(328,11,'MUSIC 409W','completed',NULL,5,NULL,NULL,NULL,NULL),(329,11,'NURS 307W','completed',NULL,5,NULL,NULL,NULL,NULL),(330,11,'POL S 390W','completed',NULL,5,NULL,NULL,NULL,NULL),(331,11,'PSFA 305W','completed',NULL,5,NULL,NULL,NULL,NULL),(332,11,'PUB 350W','completed',NULL,5,NULL,NULL,NULL,NULL),(333,11,'REL S 396W','completed',NULL,5,NULL,NULL,NULL,NULL),(334,11,'RTM 396W','completed',NULL,5,NULL,NULL,NULL,NULL),(335,11,'RWS 305W','completed',NULL,5,NULL,NULL,NULL,NULL),(336,11,'RWS 503W','completed',NULL,5,NULL,NULL,NULL,NULL),(337,11,'TE 405W','completed',NULL,5,NULL,NULL,NULL,NULL),(338,11,'TFM 390W','completed',NULL,5,NULL,NULL,NULL,NULL),(339,11,'HIST 109','completed',NULL,5,NULL,NULL,NULL,NULL),(340,11,'HIST 110','completed',NULL,5,NULL,NULL,NULL,NULL),(341,11,'AMIND 141','completed',NULL,5,NULL,NULL,NULL,NULL),(342,11,'AFRAS 140','completed',NULL,5,NULL,NULL,NULL,NULL),(343,11,'AFRAS 120','completed',NULL,5,NULL,NULL,NULL,NULL),(344,11,'RWS 200','completed',NULL,5,NULL,NULL,NULL,NULL),(345,11,'PHYS 195','completed',12,5,NULL,NULL,NULL,NULL),(346,11,'ANTH 101','completed',61,5,NULL,NULL,NULL,NULL),(347,11,'PHYS 182A','completed',NULL,5,NULL,NULL,NULL,NULL),(348,11,'MATH 150','completed',8,5,NULL,NULL,NULL,NULL),(349,11,'ECON 101','completed',NULL,5,NULL,NULL,NULL,NULL),(350,11,'ECON 102','completed',NULL,5,NULL,NULL,NULL,NULL),(351,11,'TFM 160','completed',NULL,5,NULL,NULL,NULL,NULL),(352,11,'ART 133','completed',NULL,5,NULL,NULL,NULL,NULL),(353,11,'HIST 101','completed',NULL,5,NULL,NULL,NULL,NULL),(354,11,'CSP 150','completed',NULL,5,NULL,NULL,NULL,NULL),(355,11,'CS 150','completed',1,5,NULL,NULL,NULL,NULL),(356,11,'CISC 190','completed',NULL,5,NULL,NULL,NULL,NULL),(357,11,'CS 150L','completed',2,5,NULL,NULL,NULL,NULL),(358,11,'CS 160','completed',3,5,NULL,NULL,NULL,NULL),(359,11,'CISC 192','completed',NULL,5,NULL,NULL,NULL,NULL),(360,11,'CS 160L','completed',4,5,NULL,NULL,NULL,NULL),(361,11,'CS 210','completed',5,5,NULL,NULL,NULL,NULL),(362,11,'CS 240','in_progress',6,5,NULL,NULL,NULL,NULL),(363,11,'CS 250','in_progress',7,5,NULL,NULL,NULL,NULL),(364,11,'MATH 151','completed',9,5,NULL,NULL,NULL,NULL),(365,11,'MATH 245','completed',10,5,NULL,NULL,NULL,NULL),(366,11,'MATH 254','completed',11,5,NULL,NULL,NULL,NULL),(367,11,'PHYS 196','completed',14,5,NULL,NULL,NULL,NULL),(368,11,'PHYS 196L','completed',15,5,NULL,NULL,NULL,NULL),(369,11,'STAT 250','completed',16,5,NULL,NULL,NULL,NULL),(370,11,'CS 370','in_progress',17,5,NULL,NULL,NULL,NULL),(371,11,'CS 420','in_progress',21,5,NULL,NULL,NULL,NULL),(372,11,'CS 450','completed',18,5,NULL,NULL,NULL,NULL),(373,11,'STAT 550','completed',22,5,NULL,NULL,NULL,NULL),(374,11,'CS 470','completed',23,5,NULL,NULL,NULL,NULL),(375,11,'CS 562','completed',28,5,NULL,NULL,NULL,NULL),(376,11,'CY 575','completed',39,5,NULL,NULL,NULL,NULL),(377,11,'CS 576','completed',31,5,NULL,NULL,NULL,NULL),(378,11,'CY 302','completed',33,5,NULL,NULL,NULL,NULL),(379,11,'CS 549','completed',40,5,NULL,NULL,NULL,NULL),(380,11,'CS 583','completed',45,5,NULL,NULL,NULL,NULL),(381,11,'CY 541','completed',46,5,NULL,NULL,NULL,NULL),(382,11,'CS 503','completed',47,5,NULL,NULL,NULL,NULL),(383,11,'CS 496','completed',53,5,NULL,NULL,NULL,NULL),(384,11,'CS 100','completed',NULL,5,NULL,NULL,NULL,NULL),(385,11,'CS 299','completed',NULL,5,NULL,NULL,NULL,NULL),(386,11,'GEN S 100C','completed',NULL,5,NULL,NULL,NULL,NULL),(387,11,'MATH 141','completed',NULL,5,NULL,NULL,NULL,NULL),(388,11,'PHYS 180A','completed',NULL,5,NULL,NULL,NULL,NULL),(389,11,'POL S 299','completed',NULL,5,NULL,NULL,NULL,NULL),(390,11,'CISC 211','in_progress',NULL,5,NULL,NULL,NULL,NULL),(391,11,'ACCTG 390W','completed',NULL,6,NULL,NULL,NULL,NULL),(392,11,'AFRAS 305W','completed',NULL,6,NULL,NULL,NULL,NULL),(393,11,'CCS 300W','completed',NULL,6,NULL,NULL,NULL,NULL),(394,11,'CCS 396W','completed',NULL,6,NULL,NULL,NULL,NULL),(395,11,'CIV E 495W','completed',NULL,6,NULL,NULL,NULL,NULL),(396,11,'COMPE 491W','completed',NULL,6,NULL,NULL,NULL,NULL),(397,11,'CON M 495W','completed',NULL,6,NULL,NULL,NULL,NULL),(398,11,'DANCE 481W','completed',NULL,6,NULL,NULL,NULL,NULL),(399,11,'ECON 449W','completed',NULL,6,NULL,NULL,NULL,NULL),(400,11,'ECL 306W','completed',NULL,6,NULL,NULL,NULL,NULL),(401,11,'ECL 308W','completed',NULL,6,NULL,NULL,NULL,NULL),(402,11,'HIST 390W','completed',NULL,6,NULL,NULL,NULL,NULL),(403,11,'JMS 310W','completed',NULL,6,NULL,NULL,NULL,NULL),(404,11,'LING 305W','completed',NULL,6,NULL,NULL,NULL,NULL),(405,11,'MIS 396W','completed',NULL,6,NULL,NULL,NULL,NULL),(406,11,'MUSIC 409W','completed',NULL,6,NULL,NULL,NULL,NULL),(407,11,'NURS 307W','completed',NULL,6,NULL,NULL,NULL,NULL),(408,11,'POL S 390W','completed',NULL,6,NULL,NULL,NULL,NULL),(409,11,'PSFA 305W','completed',NULL,6,NULL,NULL,NULL,NULL),(410,11,'PUB 350W','completed',NULL,6,NULL,NULL,NULL,NULL),(411,11,'REL S 396W','completed',NULL,6,NULL,NULL,NULL,NULL),(412,11,'RTM 396W','completed',NULL,6,NULL,NULL,NULL,NULL),(413,11,'RWS 305W','completed',NULL,6,NULL,NULL,NULL,NULL),(414,11,'RWS 503W','completed',NULL,6,NULL,NULL,NULL,NULL),(415,11,'TE 405W','completed',NULL,6,NULL,NULL,NULL,NULL),(416,11,'TFM 390W','completed',NULL,6,NULL,NULL,NULL,NULL),(417,11,'HIST 109','completed',NULL,6,NULL,NULL,NULL,NULL),(418,11,'HIST 110','completed',NULL,6,NULL,NULL,NULL,NULL),(419,11,'AMIND 141','completed',NULL,6,NULL,NULL,NULL,NULL),(420,11,'AFRAS 140','completed',NULL,6,NULL,NULL,NULL,NULL),(421,11,'AFRAS 120','completed',NULL,6,NULL,NULL,NULL,NULL),(422,11,'RWS 200','completed',NULL,6,NULL,NULL,NULL,NULL),(423,11,'PHYS 195','completed',12,6,NULL,NULL,NULL,NULL),(424,11,'ANTH 101','completed',61,6,NULL,NULL,NULL,NULL),(425,11,'PHYS 182A','completed',NULL,6,NULL,NULL,NULL,NULL),(426,11,'MATH 150','completed',8,6,NULL,NULL,NULL,NULL),(427,11,'ECON 101','completed',NULL,6,NULL,NULL,NULL,NULL),(428,11,'ECON 102','completed',NULL,6,NULL,NULL,NULL,NULL),(429,11,'TFM 160','completed',NULL,6,NULL,NULL,NULL,NULL),(430,11,'ART 133','completed',NULL,6,NULL,NULL,NULL,NULL),(431,11,'HIST 101','completed',NULL,6,NULL,NULL,NULL,NULL),(432,11,'CSP 150','completed',NULL,6,NULL,NULL,NULL,NULL),(433,11,'CS 150','completed',1,6,NULL,NULL,NULL,NULL),(434,11,'CISC 190','completed',NULL,6,NULL,NULL,NULL,NULL),(435,11,'CS 150L','completed',2,6,NULL,NULL,NULL,NULL),(436,11,'CS 160','completed',3,6,NULL,NULL,NULL,NULL),(437,11,'CISC 192','completed',NULL,6,NULL,NULL,NULL,NULL),(438,11,'CS 160L','completed',4,6,NULL,NULL,NULL,NULL),(439,11,'CS 210','completed',5,6,NULL,NULL,NULL,NULL),(440,11,'CS 240','in_progress',6,6,NULL,NULL,NULL,NULL),(441,11,'CS 250','in_progress',7,6,NULL,NULL,NULL,NULL),(442,11,'MATH 151','completed',9,6,NULL,NULL,NULL,NULL),(443,11,'MATH 245','completed',10,6,NULL,NULL,NULL,NULL),(444,11,'MATH 254','completed',11,6,NULL,NULL,NULL,NULL),(445,11,'PHYS 196','completed',14,6,NULL,NULL,NULL,NULL),(446,11,'PHYS 196L','completed',15,6,NULL,NULL,NULL,NULL),(447,11,'STAT 250','completed',16,6,NULL,NULL,NULL,NULL),(448,11,'CS 370','in_progress',17,6,NULL,NULL,NULL,NULL),(449,11,'CS 420','in_progress',21,6,NULL,NULL,NULL,NULL),(450,11,'CS 450','completed',18,6,NULL,NULL,NULL,NULL),(451,11,'STAT 550','completed',22,6,NULL,NULL,NULL,NULL),(452,11,'CS 470','completed',23,6,NULL,NULL,NULL,NULL),(453,11,'CS 562','completed',28,6,NULL,NULL,NULL,NULL),(454,11,'CY 575','completed',39,6,NULL,NULL,NULL,NULL),(455,11,'CS 576','completed',31,6,NULL,NULL,NULL,NULL),(456,11,'CY 302','completed',33,6,NULL,NULL,NULL,NULL),(457,11,'CS 549','completed',40,6,NULL,NULL,NULL,NULL),(458,11,'CS 583','completed',45,6,NULL,NULL,NULL,NULL),(459,11,'CY 541','completed',46,6,NULL,NULL,NULL,NULL),(460,11,'CS 503','completed',47,6,NULL,NULL,NULL,NULL),(461,11,'CS 496','completed',53,6,NULL,NULL,NULL,NULL),(462,11,'CS 100','completed',NULL,6,NULL,NULL,NULL,NULL),(463,11,'CS 299','completed',NULL,6,NULL,NULL,NULL,NULL),(464,11,'GEN S 100C','completed',NULL,6,NULL,NULL,NULL,NULL),(465,11,'MATH 141','completed',NULL,6,NULL,NULL,NULL,NULL),(466,11,'PHYS 180A','completed',NULL,6,NULL,NULL,NULL,NULL),(467,11,'POL S 299','completed',NULL,6,NULL,NULL,NULL,NULL),(468,11,'CISC 211','in_progress',NULL,6,NULL,NULL,NULL,NULL),(469,11,'ACCTG 390W','completed',NULL,7,NULL,NULL,NULL,NULL),(470,11,'AFRAS 305W','completed',NULL,7,NULL,NULL,NULL,NULL),(471,11,'CCS 300W','completed',NULL,7,NULL,NULL,NULL,NULL),(472,11,'CCS 396W','completed',NULL,7,NULL,NULL,NULL,NULL),(473,11,'CIV E 495W','completed',NULL,7,NULL,NULL,NULL,NULL),(474,11,'COMPE 491W','completed',NULL,7,NULL,NULL,NULL,NULL),(475,11,'CON M 495W','completed',NULL,7,NULL,NULL,NULL,NULL),(476,11,'DANCE 481W','completed',NULL,7,NULL,NULL,NULL,NULL),(477,11,'ECON 449W','completed',NULL,7,NULL,NULL,NULL,NULL),(478,11,'ECL 306W','completed',NULL,7,NULL,NULL,NULL,NULL),(479,11,'ECL 308W','completed',NULL,7,NULL,NULL,NULL,NULL),(480,11,'HIST 390W','completed',NULL,7,NULL,NULL,NULL,NULL),(481,11,'JMS 310W','completed',NULL,7,NULL,NULL,NULL,NULL),(482,11,'LING 305W','completed',NULL,7,NULL,NULL,NULL,NULL),(483,11,'MIS 396W','completed',NULL,7,NULL,NULL,NULL,NULL),(484,11,'MUSIC 409W','completed',NULL,7,NULL,NULL,NULL,NULL),(485,11,'NURS 307W','completed',NULL,7,NULL,NULL,NULL,NULL),(486,11,'POL S 390W','completed',NULL,7,NULL,NULL,NULL,NULL),(487,11,'PSFA 305W','completed',NULL,7,NULL,NULL,NULL,NULL),(488,11,'PUB 350W','completed',NULL,7,NULL,NULL,NULL,NULL),(489,11,'REL S 396W','completed',NULL,7,NULL,NULL,NULL,NULL),(490,11,'RTM 396W','completed',NULL,7,NULL,NULL,NULL,NULL),(491,11,'RWS 305W','completed',NULL,7,NULL,NULL,NULL,NULL),(492,11,'RWS 503W','completed',NULL,7,NULL,NULL,NULL,NULL),(493,11,'TE 405W','completed',NULL,7,NULL,NULL,NULL,NULL),(494,11,'TFM 390W','completed',NULL,7,NULL,NULL,NULL,NULL),(495,11,'HIST 109','completed',NULL,7,NULL,NULL,NULL,NULL),(496,11,'HIST 110','completed',NULL,7,NULL,NULL,NULL,NULL),(497,11,'AMIND 141','completed',NULL,7,NULL,NULL,NULL,NULL),(498,11,'AFRAS 140','completed',NULL,7,NULL,NULL,NULL,NULL),(499,11,'AFRAS 120','completed',NULL,7,NULL,NULL,NULL,NULL),(500,11,'RWS 200','completed',NULL,7,NULL,NULL,NULL,NULL),(501,11,'PHYS 195','completed',12,7,NULL,NULL,NULL,NULL),(502,11,'ANTH 101','completed',61,7,NULL,NULL,NULL,NULL),(503,11,'PHYS 182A','completed',NULL,7,NULL,NULL,NULL,NULL),(504,11,'MATH 150','completed',8,7,NULL,NULL,NULL,NULL),(505,11,'ECON 101','completed',NULL,7,NULL,NULL,NULL,NULL),(506,11,'ECON 102','completed',NULL,7,NULL,NULL,NULL,NULL),(507,11,'TFM 160','completed',NULL,7,NULL,NULL,NULL,NULL),(508,11,'ART 133','completed',NULL,7,NULL,NULL,NULL,NULL),(509,11,'HIST 101','completed',NULL,7,NULL,NULL,NULL,NULL),(510,11,'CSP 150','completed',NULL,7,NULL,NULL,NULL,NULL),(511,11,'CS 150','completed',1,7,NULL,NULL,NULL,NULL),(512,11,'CISC 190','completed',NULL,7,NULL,NULL,NULL,NULL),(513,11,'CS 150L','completed',2,7,NULL,NULL,NULL,NULL),(514,11,'CS 160','completed',3,7,NULL,NULL,NULL,NULL),(515,11,'CISC 192','completed',NULL,7,NULL,NULL,NULL,NULL),(516,11,'CS 160L','completed',4,7,NULL,NULL,NULL,NULL),(517,11,'CS 210','completed',5,7,NULL,NULL,NULL,NULL),(518,11,'CS 240','in_progress',6,7,NULL,NULL,NULL,NULL),(519,11,'CS 250','in_progress',7,7,NULL,NULL,NULL,NULL),(520,11,'MATH 151','completed',9,7,NULL,NULL,NULL,NULL),(521,11,'MATH 245','completed',10,7,NULL,NULL,NULL,NULL),(522,11,'MATH 254','completed',11,7,NULL,NULL,NULL,NULL),(523,11,'PHYS 196','completed',14,7,NULL,NULL,NULL,NULL),(524,11,'PHYS 196L','completed',15,7,NULL,NULL,NULL,NULL),(525,11,'STAT 250','completed',16,7,NULL,NULL,NULL,NULL),(526,11,'CS 370','in_progress',17,7,NULL,NULL,NULL,NULL),(527,11,'CS 420','in_progress',21,7,NULL,NULL,NULL,NULL),(528,11,'CS 450','completed',18,7,NULL,NULL,NULL,NULL),(529,11,'STAT 550','completed',22,7,NULL,NULL,NULL,NULL),(530,11,'CS 470','completed',23,7,NULL,NULL,NULL,NULL),(531,11,'CS 562','completed',28,7,NULL,NULL,NULL,NULL),(532,11,'CY 575','completed',39,7,NULL,NULL,NULL,NULL),(533,11,'CS 576','completed',31,7,NULL,NULL,NULL,NULL),(534,11,'CY 302','completed',33,7,NULL,NULL,NULL,NULL),(535,11,'CS 549','completed',40,7,NULL,NULL,NULL,NULL),(536,11,'CS 583','completed',45,7,NULL,NULL,NULL,NULL),(537,11,'CY 541','completed',46,7,NULL,NULL,NULL,NULL),(538,11,'CS 503','completed',47,7,NULL,NULL,NULL,NULL),(539,11,'CS 496','completed',53,7,NULL,NULL,NULL,NULL),(540,11,'CS 100','completed',NULL,7,NULL,NULL,NULL,NULL),(541,11,'CS 299','completed',NULL,7,NULL,NULL,NULL,NULL),(542,11,'GEN S 100C','completed',NULL,7,NULL,NULL,NULL,NULL),(543,11,'MATH 141','completed',NULL,7,NULL,NULL,NULL,NULL),(544,11,'PHYS 180A','completed',NULL,7,NULL,NULL,NULL,NULL),(545,11,'POL S 299','completed',NULL,7,NULL,NULL,NULL,NULL),(546,11,'CISC 211','in_progress',NULL,7,NULL,NULL,NULL,NULL),(547,11,'ACCTG 390W','completed',NULL,8,NULL,NULL,NULL,NULL),(548,11,'AFRAS 305W','completed',NULL,8,NULL,NULL,NULL,NULL),(549,11,'CCS 300W','completed',NULL,8,NULL,NULL,NULL,NULL),(550,11,'CCS 396W','completed',NULL,8,NULL,NULL,NULL,NULL),(551,11,'CIV E 495W','completed',NULL,8,NULL,NULL,NULL,NULL),(552,11,'COMPE 491W','completed',NULL,8,NULL,NULL,NULL,NULL),(553,11,'CON M 495W','completed',NULL,8,NULL,NULL,NULL,NULL),(554,11,'DANCE 481W','completed',NULL,8,NULL,NULL,NULL,NULL),(555,11,'ECON 449W','completed',NULL,8,NULL,NULL,NULL,NULL),(556,11,'ECL 306W','completed',NULL,8,NULL,NULL,NULL,NULL),(557,11,'ECL 308W','completed',NULL,8,NULL,NULL,NULL,NULL),(558,11,'HIST 390W','completed',NULL,8,NULL,NULL,NULL,NULL),(559,11,'JMS 310W','completed',NULL,8,NULL,NULL,NULL,NULL),(560,11,'LING 305W','completed',NULL,8,NULL,NULL,NULL,NULL),(561,11,'MIS 396W','completed',NULL,8,NULL,NULL,NULL,NULL),(562,11,'MUSIC 409W','completed',NULL,8,NULL,NULL,NULL,NULL),(563,11,'NURS 307W','completed',NULL,8,NULL,NULL,NULL,NULL),(564,11,'POL S 390W','completed',NULL,8,NULL,NULL,NULL,NULL),(565,11,'PSFA 305W','completed',NULL,8,NULL,NULL,NULL,NULL),(566,11,'PUB 350W','completed',NULL,8,NULL,NULL,NULL,NULL),(567,11,'REL S 396W','completed',NULL,8,NULL,NULL,NULL,NULL),(568,11,'RTM 396W','completed',NULL,8,NULL,NULL,NULL,NULL),(569,11,'RWS 305W','completed',NULL,8,NULL,NULL,NULL,NULL),(570,11,'RWS 503W','completed',NULL,8,NULL,NULL,NULL,NULL),(571,11,'TE 405W','completed',NULL,8,NULL,NULL,NULL,NULL),(572,11,'TFM 390W','completed',NULL,8,NULL,NULL,NULL,NULL),(573,11,'HIST 109','completed',NULL,8,NULL,NULL,NULL,NULL),(574,11,'HIST 110','completed',NULL,8,NULL,NULL,NULL,NULL),(575,11,'AMIND 141','completed',NULL,8,NULL,NULL,NULL,NULL),(576,11,'AFRAS 140','completed',NULL,8,NULL,NULL,NULL,NULL),(577,11,'AFRAS 120','completed',NULL,8,NULL,NULL,NULL,NULL),(578,11,'RWS 200','completed',NULL,8,NULL,NULL,NULL,NULL),(579,11,'PHYS 195','completed',12,8,NULL,NULL,NULL,NULL),(580,11,'ANTH 101','completed',61,8,NULL,NULL,NULL,NULL),(581,11,'PHYS 182A','completed',NULL,8,NULL,NULL,NULL,NULL),(582,11,'MATH 150','completed',8,8,NULL,NULL,NULL,NULL),(583,11,'ECON 101','completed',NULL,8,NULL,NULL,NULL,NULL),(584,11,'ECON 102','completed',NULL,8,NULL,NULL,NULL,NULL),(585,11,'TFM 160','completed',NULL,8,NULL,NULL,NULL,NULL),(586,11,'ART 133','completed',NULL,8,NULL,NULL,NULL,NULL),(587,11,'HIST 101','completed',NULL,8,NULL,NULL,NULL,NULL),(588,11,'CSP 150','completed',NULL,8,NULL,NULL,NULL,NULL),(589,11,'CS 150','completed',1,8,NULL,NULL,NULL,NULL),(590,11,'CISC 190','completed',NULL,8,NULL,NULL,NULL,NULL),(591,11,'CS 150L','completed',2,8,NULL,NULL,NULL,NULL),(592,11,'CS 160','completed',3,8,NULL,NULL,NULL,NULL),(593,11,'CISC 192','completed',NULL,8,NULL,NULL,NULL,NULL),(594,11,'CS 160L','completed',4,8,NULL,NULL,NULL,NULL),(595,11,'CS 210','completed',5,8,NULL,NULL,NULL,NULL),(596,11,'CS 240','in_progress',6,8,NULL,NULL,NULL,NULL),(597,11,'CS 250','in_progress',7,8,NULL,NULL,NULL,NULL),(598,11,'MATH 151','completed',9,8,NULL,NULL,NULL,NULL),(599,11,'MATH 245','completed',10,8,NULL,NULL,NULL,NULL),(600,11,'MATH 254','completed',11,8,NULL,NULL,NULL,NULL),(601,11,'PHYS 196','completed',14,8,NULL,NULL,NULL,NULL),(602,11,'PHYS 196L','completed',15,8,NULL,NULL,NULL,NULL),(603,11,'STAT 250','completed',16,8,NULL,NULL,NULL,NULL),(604,11,'CS 370','in_progress',17,8,NULL,NULL,NULL,NULL),(605,11,'CS 420','in_progress',21,8,NULL,NULL,NULL,NULL),(606,11,'CS 450','completed',18,8,NULL,NULL,NULL,NULL),(607,11,'STAT 550','completed',22,8,NULL,NULL,NULL,NULL),(608,11,'CS 470','completed',23,8,NULL,NULL,NULL,NULL),(609,11,'CS 562','completed',28,8,NULL,NULL,NULL,NULL),(610,11,'CY 575','completed',39,8,NULL,NULL,NULL,NULL),(611,11,'CS 576','completed',31,8,NULL,NULL,NULL,NULL),(612,11,'CY 302','completed',33,8,NULL,NULL,NULL,NULL),(613,11,'CS 549','completed',40,8,NULL,NULL,NULL,NULL),(614,11,'CS 583','completed',45,8,NULL,NULL,NULL,NULL),(615,11,'CY 541','completed',46,8,NULL,NULL,NULL,NULL),(616,11,'CS 503','completed',47,8,NULL,NULL,NULL,NULL),(617,11,'CS 496','completed',53,8,NULL,NULL,NULL,NULL),(618,11,'CS 100','completed',NULL,8,NULL,NULL,NULL,NULL),(619,11,'CS 299','completed',NULL,8,NULL,NULL,NULL,NULL),(620,11,'GEN S 100C','completed',NULL,8,NULL,NULL,NULL,NULL),(621,11,'MATH 141','completed',NULL,8,NULL,NULL,NULL,NULL),(622,11,'PHYS 180A','completed',NULL,8,NULL,NULL,NULL,NULL),(623,11,'POL S 299','completed',NULL,8,NULL,NULL,NULL,NULL),(624,11,'CISC 211','in_progress',NULL,8,NULL,NULL,NULL,NULL),(625,11,'ACCTG 390W','completed',NULL,9,NULL,NULL,NULL,NULL),(626,11,'AFRAS 305W','completed',NULL,9,NULL,NULL,NULL,NULL),(627,11,'CCS 300W','completed',NULL,9,NULL,NULL,NULL,NULL),(628,11,'CCS 396W','completed',NULL,9,NULL,NULL,NULL,NULL),(629,11,'CIV E 495W','completed',NULL,9,NULL,NULL,NULL,NULL),(630,11,'COMPE 491W','completed',NULL,9,NULL,NULL,NULL,NULL),(631,11,'CON M 495W','completed',NULL,9,NULL,NULL,NULL,NULL),(632,11,'DANCE 481W','completed',NULL,9,NULL,NULL,NULL,NULL),(633,11,'ECON 449W','completed',NULL,9,NULL,NULL,NULL,NULL),(634,11,'ECL 306W','completed',NULL,9,NULL,NULL,NULL,NULL),(635,11,'ECL 308W','completed',NULL,9,NULL,NULL,NULL,NULL),(636,11,'HIST 390W','completed',NULL,9,NULL,NULL,NULL,NULL),(637,11,'JMS 310W','completed',NULL,9,NULL,NULL,NULL,NULL),(638,11,'LING 305W','completed',NULL,9,NULL,NULL,NULL,NULL),(639,11,'MIS 396W','completed',NULL,9,NULL,NULL,NULL,NULL),(640,11,'MUSIC 409W','completed',NULL,9,NULL,NULL,NULL,NULL),(641,11,'NURS 307W','completed',NULL,9,NULL,NULL,NULL,NULL),(642,11,'POL S 390W','completed',NULL,9,NULL,NULL,NULL,NULL),(643,11,'PSFA 305W','completed',NULL,9,NULL,NULL,NULL,NULL),(644,11,'PUB 350W','completed',NULL,9,NULL,NULL,NULL,NULL),(645,11,'REL S 396W','completed',NULL,9,NULL,NULL,NULL,NULL),(646,11,'RTM 396W','completed',NULL,9,NULL,NULL,NULL,NULL),(647,11,'RWS 305W','completed',NULL,9,NULL,NULL,NULL,NULL),(648,11,'RWS 503W','completed',NULL,9,NULL,NULL,NULL,NULL),(649,11,'TE 405W','completed',NULL,9,NULL,NULL,NULL,NULL),(650,11,'TFM 390W','completed',NULL,9,NULL,NULL,NULL,NULL),(651,11,'HIST 109','completed',NULL,9,NULL,NULL,NULL,NULL),(652,11,'HIST 110','completed',NULL,9,NULL,NULL,NULL,NULL),(653,11,'AMIND 141','completed',NULL,9,NULL,NULL,NULL,NULL),(654,11,'AFRAS 140','completed',NULL,9,NULL,NULL,NULL,NULL),(655,11,'AFRAS 120','completed',NULL,9,NULL,NULL,NULL,NULL),(656,11,'RWS 200','completed',NULL,9,NULL,NULL,NULL,NULL),(657,11,'PHYS 195','completed',12,9,NULL,NULL,NULL,NULL),(658,11,'ANTH 101','completed',61,9,NULL,NULL,NULL,NULL),(659,11,'PHYS 182A','completed',NULL,9,NULL,NULL,NULL,NULL),(660,11,'MATH 150','completed',8,9,NULL,NULL,NULL,NULL),(661,11,'ECON 101','completed',NULL,9,NULL,NULL,NULL,NULL),(662,11,'ECON 102','completed',NULL,9,NULL,NULL,NULL,NULL),(663,11,'TFM 160','completed',NULL,9,NULL,NULL,NULL,NULL),(664,11,'ART 133','completed',NULL,9,NULL,NULL,NULL,NULL),(665,11,'HIST 101','completed',NULL,9,NULL,NULL,NULL,NULL),(666,11,'CSP 150','completed',NULL,9,NULL,NULL,NULL,NULL),(667,11,'CS 150','completed',1,9,NULL,NULL,NULL,NULL),(668,11,'CISC 190','completed',NULL,9,NULL,NULL,NULL,NULL),(669,11,'CS 150L','completed',2,9,NULL,NULL,NULL,NULL),(670,11,'CS 160','completed',3,9,NULL,NULL,NULL,NULL),(671,11,'CISC 192','completed',NULL,9,NULL,NULL,NULL,NULL),(672,11,'CS 160L','completed',4,9,NULL,NULL,NULL,NULL),(673,11,'CS 210','completed',5,9,NULL,NULL,NULL,NULL),(674,11,'CS 240','in_progress',6,9,NULL,NULL,NULL,NULL),(675,11,'CS 250','in_progress',7,9,NULL,NULL,NULL,NULL),(676,11,'MATH 151','completed',9,9,NULL,NULL,NULL,NULL),(677,11,'MATH 245','completed',10,9,NULL,NULL,NULL,NULL),(678,11,'MATH 254','completed',11,9,NULL,NULL,NULL,NULL),(679,11,'PHYS 196','completed',14,9,NULL,NULL,NULL,NULL),(680,11,'PHYS 196L','completed',15,9,NULL,NULL,NULL,NULL),(681,11,'STAT 250','completed',16,9,NULL,NULL,NULL,NULL),(682,11,'CS 370','in_progress',17,9,NULL,NULL,NULL,NULL),(683,11,'CS 420','in_progress',21,9,NULL,NULL,NULL,NULL),(684,11,'CS 450','completed',18,9,NULL,NULL,NULL,NULL),(685,11,'STAT 550','completed',22,9,NULL,NULL,NULL,NULL),(686,11,'CS 470','completed',23,9,NULL,NULL,NULL,NULL),(687,11,'CS 562','completed',28,9,NULL,NULL,NULL,NULL),(688,11,'CY 575','completed',39,9,NULL,NULL,NULL,NULL),(689,11,'CS 576','completed',31,9,NULL,NULL,NULL,NULL),(690,11,'CY 302','completed',33,9,NULL,NULL,NULL,NULL),(691,11,'CS 549','completed',40,9,NULL,NULL,NULL,NULL),(692,11,'CS 583','completed',45,9,NULL,NULL,NULL,NULL),(693,11,'CY 541','completed',46,9,NULL,NULL,NULL,NULL),(694,11,'CS 503','completed',47,9,NULL,NULL,NULL,NULL),(695,11,'CS 496','completed',53,9,NULL,NULL,NULL,NULL),(696,11,'CS 100','completed',NULL,9,NULL,NULL,NULL,NULL),(697,11,'CS 299','completed',NULL,9,NULL,NULL,NULL,NULL),(698,11,'GEN S 100C','completed',NULL,9,NULL,NULL,NULL,NULL),(699,11,'MATH 141','completed',NULL,9,NULL,NULL,NULL,NULL),(700,11,'PHYS 180A','completed',NULL,9,NULL,NULL,NULL,NULL),(701,11,'POL S 299','completed',NULL,9,NULL,NULL,NULL,NULL),(702,11,'CISC 211','in_progress',NULL,9,NULL,NULL,NULL,NULL),(703,11,'ACCTG 390W','completed',NULL,11,NULL,NULL,NULL,NULL),(704,11,'AFRAS 305W','completed',NULL,11,NULL,NULL,NULL,NULL),(705,11,'CCS 300W','completed',NULL,11,NULL,NULL,NULL,NULL),(706,11,'CCS 396W','completed',NULL,11,NULL,NULL,NULL,NULL),(707,11,'CIV E 495W','completed',NULL,11,NULL,NULL,NULL,NULL),(708,11,'COMPE 491W','completed',NULL,11,NULL,NULL,NULL,NULL),(709,11,'CON M 495W','completed',NULL,11,NULL,NULL,NULL,NULL),(710,11,'DANCE 481W','completed',NULL,11,NULL,NULL,NULL,NULL),(711,11,'ECON 449W','completed',NULL,11,NULL,NULL,NULL,NULL),(712,11,'ECL 306W','completed',NULL,11,NULL,NULL,NULL,NULL),(713,11,'ECL 308W','completed',NULL,11,NULL,NULL,NULL,NULL),(714,11,'HIST 390W','completed',NULL,11,NULL,NULL,NULL,NULL),(715,11,'JMS 310W','completed',NULL,11,NULL,NULL,NULL,NULL),(716,11,'LING 305W','completed',NULL,11,NULL,NULL,NULL,NULL),(717,11,'MIS 396W','completed',NULL,11,NULL,NULL,NULL,NULL),(718,11,'MUSIC 409W','completed',NULL,11,NULL,NULL,NULL,NULL),(719,11,'NURS 307W','completed',NULL,11,NULL,NULL,NULL,NULL),(720,11,'POL S 390W','completed',NULL,11,NULL,NULL,NULL,NULL),(721,11,'PSFA 305W','completed',NULL,11,NULL,NULL,NULL,NULL),(722,11,'PUB 350W','completed',NULL,11,NULL,NULL,NULL,NULL),(723,11,'REL S 396W','completed',NULL,11,NULL,NULL,NULL,NULL),(724,11,'RTM 396W','completed',NULL,11,NULL,NULL,NULL,NULL),(725,11,'RWS 305W','completed',NULL,11,NULL,NULL,NULL,NULL),(726,11,'RWS 503W','completed',NULL,11,NULL,NULL,NULL,NULL),(727,11,'TE 405W','completed',NULL,11,NULL,NULL,NULL,NULL),(728,11,'TFM 390W','completed',NULL,11,NULL,NULL,NULL,NULL),(729,11,'HIST 109','completed',NULL,11,NULL,NULL,NULL,NULL),(730,11,'HIST 110','completed',NULL,11,NULL,NULL,NULL,NULL),(731,11,'AMIND 141','completed',NULL,11,NULL,NULL,NULL,NULL),(732,11,'AFRAS 140','completed',NULL,11,NULL,NULL,NULL,NULL),(733,11,'AFRAS 120','completed',NULL,11,NULL,NULL,NULL,NULL),(734,11,'RWS 200','completed',NULL,11,NULL,NULL,NULL,NULL),(735,11,'PHYS 195','completed',12,11,NULL,NULL,NULL,NULL),(736,11,'ANTH 101','completed',61,11,NULL,NULL,NULL,NULL),(737,11,'PHYS 182A','completed',NULL,11,NULL,NULL,NULL,NULL),(738,11,'MATH 150','completed',8,11,NULL,NULL,NULL,NULL),(739,11,'ECON 101','completed',NULL,11,NULL,NULL,NULL,NULL),(740,11,'ECON 102','completed',NULL,11,NULL,NULL,NULL,NULL),(741,11,'TFM 160','completed',NULL,11,NULL,NULL,NULL,NULL),(742,11,'ART 133','completed',NULL,11,NULL,NULL,NULL,NULL),(743,11,'HIST 101','completed',NULL,11,NULL,NULL,NULL,NULL),(744,11,'CSP 150','completed',NULL,11,NULL,NULL,NULL,NULL),(745,11,'CS 150','completed',1,11,NULL,NULL,NULL,NULL),(746,11,'CISC 190','completed',NULL,11,NULL,NULL,NULL,NULL),(747,11,'CS 150L','completed',2,11,NULL,NULL,NULL,NULL),(748,11,'CS 160','completed',3,11,NULL,NULL,NULL,NULL),(749,11,'CISC 192','completed',NULL,11,NULL,NULL,NULL,NULL),(750,11,'CS 160L','completed',4,11,NULL,NULL,NULL,NULL),(751,11,'CS 210','completed',5,11,NULL,NULL,NULL,NULL),(752,11,'CS 240','in_progress',6,11,NULL,NULL,NULL,NULL),(753,11,'CS 250','in_progress',7,11,NULL,NULL,NULL,NULL),(754,11,'MATH 151','completed',9,11,NULL,NULL,NULL,NULL),(755,11,'MATH 245','completed',10,11,NULL,NULL,NULL,NULL),(756,11,'MATH 254','completed',11,11,NULL,NULL,NULL,NULL),(757,11,'PHYS 196','completed',14,11,NULL,NULL,NULL,NULL),(758,11,'PHYS 196L','completed',15,11,NULL,NULL,NULL,NULL),(759,11,'STAT 250','completed',16,11,NULL,NULL,NULL,NULL),(760,11,'CS 370','in_progress',17,11,NULL,NULL,NULL,NULL),(761,11,'CS 420','in_progress',21,11,NULL,NULL,NULL,NULL),(762,11,'CS 450','completed',18,11,NULL,NULL,NULL,NULL),(763,11,'STAT 550','completed',22,11,NULL,NULL,NULL,NULL),(764,11,'CS 470','completed',23,11,NULL,NULL,NULL,NULL),(765,11,'CS 562','completed',28,11,NULL,NULL,NULL,NULL),(766,11,'CY 575','completed',39,11,NULL,NULL,NULL,NULL),(767,11,'CS 576','completed',31,11,NULL,NULL,NULL,NULL),(768,11,'CY 302','completed',33,11,NULL,NULL,NULL,NULL),(769,11,'CS 549','completed',40,11,NULL,NULL,NULL,NULL),(770,11,'CS 583','completed',45,11,NULL,NULL,NULL,NULL),(771,11,'CY 541','completed',46,11,NULL,NULL,NULL,NULL),(772,11,'CS 503','completed',47,11,NULL,NULL,NULL,NULL),(773,11,'CS 496','completed',53,11,NULL,NULL,NULL,NULL),(774,11,'CS 100','completed',NULL,11,NULL,NULL,NULL,NULL),(775,11,'CS 299','completed',NULL,11,NULL,NULL,NULL,NULL),(776,11,'GEN S 100C','completed',NULL,11,NULL,NULL,NULL,NULL),(777,11,'MATH 141','completed',NULL,11,NULL,NULL,NULL,NULL),(778,11,'PHYS 180A','completed',NULL,11,NULL,NULL,NULL,NULL),(779,11,'POL S 299','completed',NULL,11,NULL,NULL,NULL,NULL),(780,11,'CISC 211','in_progress',NULL,11,NULL,NULL,NULL,NULL),(781,11,'ACCTG 390W','completed',NULL,12,NULL,NULL,NULL,NULL),(782,11,'AFRAS 305W','completed',NULL,12,NULL,NULL,NULL,NULL),(783,11,'CCS 300W','completed',NULL,12,NULL,NULL,NULL,NULL),(784,11,'CCS 396W','completed',NULL,12,NULL,NULL,NULL,NULL),(785,11,'CIV E 495W','completed',NULL,12,NULL,NULL,NULL,NULL),(786,11,'COMPE 491W','completed',NULL,12,NULL,NULL,NULL,NULL),(787,11,'CON M 495W','completed',NULL,12,NULL,NULL,NULL,NULL),(788,11,'DANCE 481W','completed',NULL,12,NULL,NULL,NULL,NULL),(789,11,'ECON 449W','completed',NULL,12,NULL,NULL,NULL,NULL),(790,11,'ECL 306W','completed',NULL,12,NULL,NULL,NULL,NULL),(791,11,'ECL 308W','completed',NULL,12,NULL,NULL,NULL,NULL),(792,11,'HIST 390W','completed',NULL,12,NULL,NULL,NULL,NULL),(793,11,'JMS 310W','completed',NULL,12,NULL,NULL,NULL,NULL),(794,11,'LING 305W','completed',NULL,12,NULL,NULL,NULL,NULL),(795,11,'MIS 396W','completed',NULL,12,NULL,NULL,NULL,NULL),(796,11,'MUSIC 409W','completed',NULL,12,NULL,NULL,NULL,NULL),(797,11,'NURS 307W','completed',NULL,12,NULL,NULL,NULL,NULL),(798,11,'POL S 390W','completed',NULL,12,NULL,NULL,NULL,NULL),(799,11,'PSFA 305W','completed',NULL,12,NULL,NULL,NULL,NULL),(800,11,'PUB 350W','completed',NULL,12,NULL,NULL,NULL,NULL),(801,11,'REL S 396W','completed',NULL,12,NULL,NULL,NULL,NULL),(802,11,'RTM 396W','completed',NULL,12,NULL,NULL,NULL,NULL),(803,11,'RWS 305W','completed',NULL,12,NULL,NULL,NULL,NULL),(804,11,'RWS 503W','completed',NULL,12,NULL,NULL,NULL,NULL),(805,11,'TE 405W','completed',NULL,12,NULL,NULL,NULL,NULL),(806,11,'TFM 390W','completed',NULL,12,NULL,NULL,NULL,NULL),(807,11,'HIST 109','completed',NULL,12,NULL,NULL,NULL,NULL),(808,11,'HIST 110','completed',NULL,12,NULL,NULL,NULL,NULL),(809,11,'AMIND 141','completed',NULL,12,NULL,NULL,NULL,NULL),(810,11,'AFRAS 140','completed',NULL,12,NULL,NULL,NULL,NULL),(811,11,'AFRAS 120','completed',NULL,12,NULL,NULL,NULL,NULL),(812,11,'RWS 200','completed',NULL,12,NULL,NULL,NULL,NULL),(813,11,'PHYS 195','completed',12,12,NULL,NULL,NULL,NULL),(814,11,'ANTH 101','completed',61,12,NULL,NULL,NULL,NULL),(815,11,'PHYS 182A','completed',NULL,12,NULL,NULL,NULL,NULL),(816,11,'MATH 150','completed',8,12,NULL,NULL,NULL,NULL),(817,11,'ECON 101','completed',NULL,12,NULL,NULL,NULL,NULL),(818,11,'ECON 102','completed',NULL,12,NULL,NULL,NULL,NULL),(819,11,'TFM 160','completed',NULL,12,NULL,NULL,NULL,NULL),(820,11,'ART 133','completed',NULL,12,NULL,NULL,NULL,NULL),(821,11,'HIST 101','completed',NULL,12,NULL,NULL,NULL,NULL),(822,11,'CSP 150','completed',NULL,12,NULL,NULL,NULL,NULL),(823,11,'CS 150','completed',1,12,NULL,NULL,NULL,NULL),(824,11,'CISC 190','completed',NULL,12,NULL,NULL,NULL,NULL),(825,11,'CS 150L','completed',2,12,NULL,NULL,NULL,NULL),(826,11,'CS 160','completed',3,12,NULL,NULL,NULL,NULL),(827,11,'CISC 192','completed',NULL,12,NULL,NULL,NULL,NULL),(828,11,'CS 160L','completed',4,12,NULL,NULL,NULL,NULL),(829,11,'CS 210','completed',5,12,NULL,NULL,NULL,NULL),(830,11,'CS 240','in_progress',6,12,NULL,NULL,NULL,NULL),(831,11,'CS 250','in_progress',7,12,NULL,NULL,NULL,NULL),(832,11,'MATH 151','completed',9,12,NULL,NULL,NULL,NULL),(833,11,'MATH 245','completed',10,12,NULL,NULL,NULL,NULL),(834,11,'MATH 254','completed',11,12,NULL,NULL,NULL,NULL),(835,11,'PHYS 196','completed',14,12,NULL,NULL,NULL,NULL),(836,11,'PHYS 196L','completed',15,12,NULL,NULL,NULL,NULL),(837,11,'STAT 250','completed',16,12,NULL,NULL,NULL,NULL),(838,11,'CS 370','in_progress',17,12,NULL,NULL,NULL,NULL),(839,11,'CS 420','in_progress',21,12,NULL,NULL,NULL,NULL),(840,11,'CS 450','completed',18,12,NULL,NULL,NULL,NULL),(841,11,'STAT 550','completed',22,12,NULL,NULL,NULL,NULL),(842,11,'CS 470','completed',23,12,NULL,NULL,NULL,NULL),(843,11,'CS 562','completed',28,12,NULL,NULL,NULL,NULL),(844,11,'CY 575','completed',39,12,NULL,NULL,NULL,NULL),(845,11,'CS 576','completed',31,12,NULL,NULL,NULL,NULL),(846,11,'CY 302','completed',33,12,NULL,NULL,NULL,NULL),(847,11,'CS 549','completed',40,12,NULL,NULL,NULL,NULL),(848,11,'CS 583','completed',45,12,NULL,NULL,NULL,NULL),(849,11,'CY 541','completed',46,12,NULL,NULL,NULL,NULL),(850,11,'CS 503','completed',47,12,NULL,NULL,NULL,NULL),(851,11,'CS 496','completed',53,12,NULL,NULL,NULL,NULL),(852,11,'CS 100','completed',NULL,12,NULL,NULL,NULL,NULL),(853,11,'CS 299','completed',NULL,12,NULL,NULL,NULL,NULL),(854,11,'GEN S 100C','completed',NULL,12,NULL,NULL,NULL,NULL),(855,11,'MATH 141','completed',NULL,12,NULL,NULL,NULL,NULL),(856,11,'PHYS 180A','completed',NULL,12,NULL,NULL,NULL,NULL),(857,11,'POL S 299','completed',NULL,12,NULL,NULL,NULL,NULL),(858,11,'CISC 211','in_progress',NULL,12,NULL,NULL,NULL,NULL),(859,15,'RWS 305W','in_progress',NULL,15,NULL,NULL,NULL,NULL),(860,15,'HIST 109','completed',NULL,15,NULL,NULL,NULL,NULL),(861,15,'HIST 110','completed',NULL,15,NULL,NULL,NULL,NULL),(862,15,'HIST 113','completed',NULL,15,NULL,NULL,NULL,NULL),(863,15,'ANTH 360','completed',NULL,15,NULL,NULL,NULL,NULL),(864,15,'CCS 310','completed',NULL,15,NULL,NULL,NULL,NULL),(865,15,'CCS 350B','completed',NULL,15,NULL,NULL,NULL,NULL),(866,15,'CCS 376','completed',NULL,15,NULL,NULL,NULL,NULL),(867,15,'JAPAN 332','completed',NULL,15,NULL,NULL,NULL,NULL),(868,15,'CCS 301','completed',NULL,15,NULL,NULL,NULL,NULL),(869,15,'CCS 320','completed',NULL,15,NULL,NULL,NULL,NULL),(870,15,'KOR 429','completed',NULL,15,NULL,NULL,NULL,NULL),(871,15,'LGBT 350','completed',NULL,15,NULL,NULL,NULL,NULL),(872,15,'LING 354','in_progress',NULL,15,NULL,NULL,NULL,NULL),(873,15,'CS 210','in_progress',5,15,NULL,NULL,NULL,NULL),(874,15,'CS 250','in_progress',7,15,NULL,NULL,NULL,NULL),(875,15,'MATH 254','in_progress',11,15,NULL,NULL,NULL,NULL),(876,15,'CS 370','in_progress',17,15,NULL,NULL,NULL,NULL),(877,15,'MATH 141','completed',NULL,15,NULL,NULL,NULL,NULL),(878,15,'ENGL 220','completed',NULL,15,NULL,NULL,NULL,NULL),(879,15,'MATH 150','completed',8,15,NULL,NULL,NULL,NULL),(880,15,'DANCE 181','completed',NULL,15,NULL,NULL,NULL,NULL),(881,15,'ECON 101','completed',NULL,15,NULL,NULL,NULL,NULL),(882,15,'MATH 151','completed',9,15,NULL,NULL,NULL,NULL),(883,15,'ENS 104A','completed',NULL,15,NULL,NULL,NULL,NULL),(884,15,'JPN 102','completed',NULL,15,NULL,NULL,NULL,NULL),(885,15,'PHYS 195','completed',12,15,NULL,NULL,NULL,NULL),(886,15,'MATH 245','completed',10,15,NULL,NULL,NULL,NULL),(887,15,'PHYS 196L','completed',15,15,NULL,NULL,NULL,NULL),(888,15,'CIS 146','completed',NULL,15,NULL,NULL,NULL,NULL),(889,15,'MATH 252','completed',NULL,15,NULL,NULL,NULL,NULL),(890,15,'NTRNS 005','completed',NULL,15,NULL,NULL,NULL,NULL),(891,15,'NTRNS 006','completed',NULL,15,NULL,NULL,NULL,NULL),(892,15,'NTRNS 007','completed',NULL,15,NULL,NULL,NULL,NULL),(893,15,'NTRNS 008','completed',NULL,15,NULL,NULL,NULL,NULL),(894,15,'CS 150','completed',1,15,NULL,NULL,NULL,NULL),(895,15,'CS 150L','completed',2,15,NULL,NULL,NULL,NULL),(896,15,'RWS 100','completed',NULL,15,NULL,NULL,NULL,NULL),(897,15,'RDG 158','completed',NULL,15,NULL,NULL,NULL,NULL),(898,15,'ART 157','completed',NULL,15,NULL,NULL,NULL,NULL),(899,15,'CS 160','completed',3,15,NULL,NULL,NULL,NULL),(900,15,'CS 160L','completed',4,15,NULL,NULL,NULL,NULL),(901,15,'CS 240','completed',6,15,NULL,NULL,NULL,NULL),(902,15,'PHIL 200','completed',NULL,15,NULL,NULL,NULL,NULL),(903,15,'COMM 103','completed',NULL,15,NULL,NULL,NULL,NULL),(904,15,'ANTH 101','completed',61,15,NULL,NULL,NULL,NULL),(905,15,'JPN 101','completed',NULL,15,NULL,NULL,NULL,NULL),(906,15,'PHYS 195L','completed',13,15,NULL,NULL,NULL,NULL),(907,15,'PHYS 196','completed',14,15,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `user_courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_degree`
--

DROP TABLE IF EXISTS `user_degree`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_degree` (
  `user_id` int NOT NULL,
  `degree_id` int NOT NULL,
  `catalog_year` int DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `degree_id` (`degree_id`),
  CONSTRAINT `user_degree_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `user_degree_ibfk_2` FOREIGN KEY (`degree_id`) REFERENCES `degrees` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_degree`
--

LOCK TABLES `user_degree` WRITE;
/*!40000 ALTER TABLE `user_degree` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_degree` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_preferences`
--

DROP TABLE IF EXISTS `user_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_preferences` (
  `user_id` int NOT NULL,
  `preferred_start_time` time DEFAULT NULL,
  `preferred_end_time` time DEFAULT NULL,
  `preferred_days` varchar(50) DEFAULT NULL,
  `credits_per_semester` int DEFAULT NULL,
  `elective_interests` text,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `user_preferences_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `chk_preferences_credits` CHECK (((`credits_per_semester` is null) or (`credits_per_semester` > 0)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_preferences`
--

LOCK TABLES `user_preferences` WRITE;
/*!40000 ALTER TABLE `user_preferences` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_preferences` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-14  8:13:17
