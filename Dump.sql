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
  `name` text COLLATE utf8_bin,
  `date_create` date DEFAULT NULL,
  PRIMARY KEY (`id_awards`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `awards`
--

LOCK TABLES `awards` WRITE;
/*!40000 ALTER TABLE `awards` DISABLE KEYS */;
INSERT INTO `awards` VALUES (1,'1693724777737-ZdW2KkzlPUs.jpg','1gjzcybwf',NULL),(2,'1693724777737-ZdW2KkzlPUs.jpg','2asd',NULL),(3,'1693724777737-ZdW2KkzlPUs.jpg','3asd','2023-09-08'),(4,'1693724777737-ZdW2KkzlPUs.jpg','4ss',NULL),(5,'1693724777737-ZdW2KkzlPUs.jpg','5geea',NULL),(6,'1693724777737-ZdW2KkzlPUs.jpg','6',NULL),(7,'1693724777737-ZdW2KkzlPUs.jpg','7','2023-09-09');
/*!40000 ALTER TABLE `awards` ENABLE KEYS */;
UNLOCK TABLES;

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
  PRIMARY KEY (`id_billboard`),
  KEY `id_repertoire_idx` (`id_repertoire`),
  CONSTRAINT `id_repertoire` FOREIGN KEY (`id_repertoire`) REFERENCES `repertoire` (`id_repertoire`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `billboard`
--

LOCK TABLES `billboard` WRITE;
/*!40000 ALTER TABLE `billboard` DISABLE KEYS */;
INSERT INTO `billboard` VALUES (1,2,'2023-09-06 20:31:00','ул, Пушкина','3Ae9b9fb91d381c327105aefacfae0dd342eeb6ee2336488891e223bea1d2edec3'),(2,1,'2023-09-06 20:42:00','ss',NULL),(3,5,'2023-09-07 15:26:00','ss',NULL);
/*!40000 ALTER TABLE `billboard` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cast`
--

LOCK TABLES `cast` WRITE;
/*!40000 ALTER TABLE `cast` DISABLE KEYS */;
INSERT INTO `cast` VALUES (52,5,33,NULL,0),(53,5,33,'jj',0),(54,5,33,'kkk',1),(55,5,33,'kkkk',0);
/*!40000 ALTER TABLE `cast` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES (33,'asd','vf','2021-08-31',1,'1693764081701-PO2zS6j6eUg.jpg'),(34,'Владимир Кротких','asdfaffffffffffffffffffffffffffff\r\nsssssssssssssss\r\n  asdas df asd aasf as asdas df asd aasf as asdas df asd aasf as asdas df asd aasf as asdas df asd aasf asasdas df asd aasf as asdas df asd aasf asasdas df asd aasf as  asdas df asd aasf asasdas df asd aasf as','2006-11-22',1,'1694174886009-spXN4qOWQ5I.jpg');
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repertoire`
--

LOCK TABLES `repertoire` WRITE;
/*!40000 ALTER TABLE `repertoire` DISABLE KEYS */;
INSERT INTO `repertoire` VALUES (1,'Как я познакомился с отцом','Джанибек Джанибекович','Пытаясь получше узнать долго отсутствующего в его жизни отца, Лука совершает длинный и непростой путь... к себе. Эта дорога без конца полна лёгких разочарований и трудных приобретений. Душевные искания и неожиданные откровения - главные спутники на этой дороге. И всё ради наполненного светлой грусти итога.','1693724803743-5EdhPC9TuuY.jpg',65,'1970-01-01 04:00:00'),(2,'ДАВАЙТЕ НЕ БУДЕМ БОЯТЬСЯ, или ПараФраз о величии','(по философско-политической пьесе Яны Богдановой)','Дети играют, ссорятся, мирятся - всё как у \"нормальных\" людей... Действие разворачивается на детской площадке в то время, пока нет взрослых. У главных героев есть \"кликухи\", \"погоняла\", но нет имён. А на дворе предчувствие, каждый сам решит чего. Да и такие ли уж они дети?','1693724818638-175OXtk37sA.jpg',35,'1970-01-01 04:00:00'),(3,'ИВАН КРЕСТЬЯНСКИЙ СЫН И ПРИНЦЕССА ВАСИЛИСА','Дмитрий Татаринов','asd','1694018507826-FFk-w7s6Zfc.jpg',25,'2023-08-27 14:29:00'),(4,'Поясница','по мотивам романа И.А. Гончарова обыкновенная история','История провинциала Саши Адуева, покоряющего столицу, актуальна и 200 лет спустя. Почти «обыкновенная история» в современном формате. Молодые артисты расскажут эту историю по-новому.','1693724777737-ZdW2KkzlPUs.jpg',100,'2023-08-28 14:29:00'),(5,'Молоток','по одноименной пьесе Павла Павлова','11-летний легкоатлет Женька готовится к важным в своей жизни соревнованиям. Но мечта превращается в сверхидею и, как это часто бывает в таких случаях, разрушает внутренний мир подростка. А вместе с ним и мир, который снаружи...','1693724792916-PO2zS6j6eUg.jpg',100,'2023-08-28 14:36:00');
/*!40000 ALTER TABLE `repertoire` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-09-20 21:44:35
