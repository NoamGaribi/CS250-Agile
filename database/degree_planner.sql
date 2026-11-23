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
