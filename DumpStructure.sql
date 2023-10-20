-- MySQL dump 10.13  Distrib 8.0.25, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: dram
-- ------------------------------------------------------
-- Server version	8.0.25

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

--
-- Table structure for table `awards`
--

DROP TABLE IF EXISTS `awards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `awards` (
  `id_awards` int NOT NULL AUTO_INCREMENT,
  `image` longtext COLLATE utf8_bin,
  `description` text COLLATE utf8_bin,
  PRIMARY KEY (`id_awards`)
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billboard`
--

DROP TABLE IF EXISTS `billboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billboard` (
  `id_billboard` int NOT NULL AUTO_INCREMENT,
  `id_repertoire` int DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  `place` tinytext COLLATE utf8_bin,
  `src_on_map` text COLLATE utf8_bin,
  `marker` text COLLATE utf8_bin,
  PRIMARY KEY (`id_billboard`),
  KEY `id_repertoire_idx` (`id_repertoire`),
  CONSTRAINT `id_repertoire` FOREIGN KEY (`id_repertoire`) REFERENCES `repertoire` (`id_repertoire`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cast`
--

DROP TABLE IF EXISTS `cast`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cast` (
  `id_cast` int NOT NULL AUTO_INCREMENT,
  `id_repertoire` int DEFAULT NULL,
  `id_person` int DEFAULT NULL,
  `role_person` tinytext COLLATE utf8_bin,
  `is_head` tinyint DEFAULT '0',
  PRIMARY KEY (`id_cast`),
  KEY `id_person_idx` (`id_person`),
  KEY `id_repertoire_cast_idx` (`id_repertoire`),
  CONSTRAINT `id_person` FOREIGN KEY (`id_person`) REFERENCES `person` (`id_person`),
  CONSTRAINT `id_repertoire_cast` FOREIGN KEY (`id_repertoire`) REFERENCES `repertoire` (`id_repertoire`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gallery`
--

DROP TABLE IF EXISTS `gallery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gallery` (
  `id_gallery` int NOT NULL AUTO_INCREMENT,
  `id_repertoire` int DEFAULT NULL,
  `image_gallery` text COLLATE utf8_bin,
  PRIMARY KEY (`id_gallery`),
  KEY `repertoire_id_idx` (`id_repertoire`),
  CONSTRAINT `id_repertoire_gallery` FOREIGN KEY (`id_repertoire`) REFERENCES `repertoire` (`id_repertoire`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `news` (
  `id_news` int NOT NULL AUTO_INCREMENT,
  `description` text COLLATE utf8_bin,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id_news`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person` (
  `id_person` int NOT NULL AUTO_INCREMENT,
  `name` tinytext COLLATE utf8_bin,
  `description` text COLLATE utf8_bin,
  `birthday` date DEFAULT NULL,
  `real` tinyint DEFAULT NULL,
  `image` text COLLATE utf8_bin,
  PRIMARY KEY (`id_person`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `repertoire`
--

DROP TABLE IF EXISTS `repertoire`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `repertoire` (
  `id_repertoire` int NOT NULL AUTO_INCREMENT,
  `title` tinytext CHARACTER SET utf8 COLLATE utf8_bin,
  `author` tinytext CHARACTER SET utf8 COLLATE utf8_bin,
  `description` text CHARACTER SET utf8 COLLATE utf8_bin,
  `image` longtext CHARACTER SET utf8 COLLATE utf8_bin,
  `duration` tinyint unsigned DEFAULT NULL,
  `creation_time_repertoire` datetime DEFAULT NULL,
  PRIMARY KEY (`id_repertoire`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-20 21:57:43
