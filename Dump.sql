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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `billboard`
--

LOCK TABLES `billboard` WRITE;
/*!40000 ALTER TABLE `billboard` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cast`
--

LOCK TABLES `cast` WRITE;
/*!40000 ALTER TABLE `cast` DISABLE KEYS */;
INSERT INTO `cast` VALUES (1,2,1,'Постановка, сценография и музыкальное оформление',1),(2,2,2,'Ассистент режиссёра',1),(3,2,3,'Лука',0),(4,2,1,'Отец',0),(5,3,3,'Гусь',0),(6,3,4,'Черепашка',0),(7,3,12,'Голос',0);
/*!40000 ALTER TABLE `cast` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gallery`
--

DROP TABLE IF EXISTS `gallery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gallery` (
  `gallery_id` int NOT NULL,
  `repertoire_id` int DEFAULT NULL,
  `image` text COLLATE utf8_bin,
  PRIMARY KEY (`gallery_id`),
  KEY `repertoire_id_idx` (`repertoire_id`),
  CONSTRAINT `repertoire_id` FOREIGN KEY (`repertoire_id`) REFERENCES `repertoire` (`id_repertoire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gallery`
--

LOCK TABLES `gallery` WRITE;
/*!40000 ALTER TABLE `gallery` DISABLE KEYS */;
/*!40000 ALTER TABLE `gallery` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES (1,'Ярослав Щедров',NULL,'2023-09-24',1,'not_found.png'),(2,'Матвей Семагин',NULL,'2023-09-24',1,'not_found.png'),(3,'Станислав Данилов',NULL,'2023-09-24',1,'not_found.png'),(4,'Влад Гончаров',NULL,'2023-09-24',1,'not_found.png'),(5,'Анжела Янтушкина',NULL,'2023-09-24',1,'not_found.png'),(6,'София Кандрашина',NULL,'2023-09-24',1,'not_found.png'),(7,'Варвара Высоцкая',NULL,'2023-09-24',1,'not_found.png'),(8,'Диана Хакимова',NULL,'2023-09-24',1,'not_found.png'),(9,'Виктория Забавчук',NULL,'2023-09-24',1,'not_found.png'),(10,'Тимур Моисеев',NULL,'2023-09-24',1,'not_found.png'),(11,'Илья Бухалов',NULL,'2023-09-24',1,'not_found.png'),(12,'Олег Наливайко',NULL,'2023-09-24',0,'not_found.png');
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repertoire`
--

LOCK TABLES `repertoire` WRITE;
/*!40000 ALTER TABLE `repertoire` DISABLE KEYS */;
INSERT INTO `repertoire` VALUES (1,'ПОЯСНИЦА','по мотивам романа И.А. Гончарова \"Обыкновенная история\"','История провинциала Саши Адуева, покоряющего столицу, актуальна и 200 лет спустя. Почти «обыкновенная история» в современном формате. Молодые артисты расскажут эту историю по-новому.','1695554593457-poyasnica.jpg',95,'2022-10-01 00:00:00'),(2,'Как я познакомился с отцом','Дж. Баттиста','Пытаясь получше узнать долго отсутствующего в его жизни отца, Лука совершает длинный и непростой путь... к себе. Эта дорога без конца полна лёгких разочарований и трудных приобретений. Душевные искания и неожиданные откровения - главные спутники на этой дороге. И всё ради наполненного светлой грусти итога.','1695554507771-father.jpg',75,'2023-04-21 00:00:00'),(3,'ДАВАЙТЕ НЕ БУДЕМ БОЯТЬСЯ, или ПараФраз о величии','по философско-политической пьесе Яны Богдановой','Дети играют, ссорятся, мирятся - всё как у \"нормальных\" людей... Действие разворачивается на детской площадке в то время, пока нет взрослых. У главных героев есть \"кликухи\", \"погоняла\", но нет имён. А на дворе предчувствие, каждый сам решит чего. Да и такие ли уж они дети?','1695554564463-dont_afraid.jpg',40,'2023-02-24 00:00:00');
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

-- Dump completed on 2023-09-25 18:13:03
