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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `awards`
--

LOCK TABLES `awards` WRITE;
/*!40000 ALTER TABLE `awards` DISABLE KEYS */;
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
  `marker` text COLLATE utf8_bin,
  PRIMARY KEY (`id_billboard`),
  KEY `id_repertoire_idx` (`id_repertoire`),
  CONSTRAINT `id_repertoire` FOREIGN KEY (`id_repertoire`) REFERENCES `repertoire` (`id_repertoire`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `billboard`
--

LOCK TABLES `billboard` WRITE;
/*!40000 ALTER TABLE `billboard` DISABLE KEYS */;
INSERT INTO `billboard` VALUES (1,1,'2023-11-06 19:00:00','ул. Ленина, 78, Ульяновск','3Ae9b9fb91d381c327105aefacfae0dd342eeb6ee2336488891e223bea1d2edec3',NULL),(2,2,'2023-11-09 19:00:00','ул. Ленина, 78, Ульяновск','3Ae9b9fb91d381c327105aefacfae0dd342eeb6ee2336488891e223bea1d2edec3',NULL),(3,3,'2023-11-15 18:30:00','ул. Ленина, 78, Ульяновск','3Ae9b9fb91d381c327105aefacfae0dd342eeb6ee2',NULL),(4,4,'2023-11-20 18:30:00','ул. Ленина, 78, Ульяновск','3Ae9b9fb91d381c327105aefacfae0dd342eeb6ee2',NULL),(5,2,'2023-10-31 19:00:00','Ульяновск, проспект 50-летия ВЛКСМ, 15','3A46ed1ea6aacd6dbb622e501ffcb05bb46afcb5758b22afe5912576d912cfd496',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cast`
--

LOCK TABLES `cast` WRITE;
/*!40000 ALTER TABLE `cast` DISABLE KEYS */;
INSERT INTO `cast` VALUES (1,3,7,'Наденька',0),(2,3,10,'Наденька',0),(3,3,13,'Наденька',0);
/*!40000 ALTER TABLE `cast` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES (1,'Ярослав Щедров','Родился 26 марта 1970 года в Ленинграде\r\nЗакончил Российскую Академию театрального искусства (РАТИ) по специальности \"театральный и кинокритик\"\r\nАвтор и ведущий телевизионной программы \"Парк культуры\"\r\nСлужит в Димитровградском драматическом театре им. А. Н. Островского','1970-03-26',1,'not_found.png'),(2,'Евгения Жукова','Родилась 27 сентября в Казани\r\nОкончила актёрское отделение факультета культуры и искусства Ульяновского государственного университета (курс народного артиста России, лауреата Государственной премии РФ Бориса Владимировича Александрова)\r\nШесть лет работала ассистентом режиссёра по актёрам в Москве на на телепроектах \"Ранетки\", \"Моя прекрасная няня\", \"Воронины\" и многих других.\r\nВ настоящее время педагог по актёрскому мастерству, художественный руководитель руководитель творческой театральной мастерской \"ЕЖ\" в Ульяновске.\r\nАктёрский агент и кастинг-директор (\"Великолепная пятёрка\", \"Пять минут тишины\", \"Первый отдел\", \"Выстрел в спину\", \"Одна ложь на двоих\" и другие фильмы и сериалы)','2023-09-27',1,'not_found.png'),(3,'Алексей Жуков','Родился 27 мая 2011 года в Ульяновске\r\nУчится в 6 классе ульяновской гимназии № 2\r\nУчастник творческой театральной мастерской \"ЕЖ\" (г. Ульяновск)\r\nИграет и поёт в группе \"Доброе утро\"','2011-05-27',1,'not_found.png'),(4,'Стас Данилов','Родился 14 июня 2006 года в Ульяновске\r\nУчится в 11 классе ульяновского многопрофильного лицея № 11 им. В. Г. Мендельсона','2006-06-14',1,'not_found.png'),(5,'Влад Гончаров','Родился 26 марта 2006 года в Ульяновске\r\nУчится в 11 классе ульяновской средней школы № 53 имени заслуженного учителя РФ И. В. Исакова\r\nМодель в агентстве TERMINAL-MODELS\r\nЗанимается кикбоксингом','2006-03-26',1,'not_found.png'),(6,'Анжела Янтушкина','Родилась 27 октября в Ульяновске\r\nСтудентка театрального факультета Самарского государственного института культуры (СГИК) по специальности \"Актёр драматического театра и кино\"','2023-10-27',1,'not_found.png'),(7,'Виктория Забавчук','Родилась 10 мая в Ульяновске\r\nСтудентка факультета иностранных языков Ульяновского государственного педагогического университета им. И. Н. Ульянова (кафедра английского языка)\r\nУчаствует в создании творческих проектов Актива университета.','2023-05-10',1,'not_found.png'),(8,'Илья Бухалов','Родился 25 марта 2008 года в Орске\r\nУчится в 9 классе ульяновской гимназии № 2\r\nИз актёрской семьи. Родители - ведущие актёры Ульяновского театра драмы им. И. А. Гончарова Денис Бухалов и Кристина Каминская.\r\nУчастник творческого проекта \"СТРИТ-КУЛЬТУРА\"\r\nФронтмэн и ритм-вокалист группы \"Доброе утро\"\r\nПишет стихи и музыку','2008-03-25',1,'not_found.png'),(9,'Лилиана Бакеева','Родилась 19 октября в Ульяновске\r\nУчится в 10 классе ульяновской гимназии № 6 им. И. Н. Ульянова','2023-10-19',1,'not_found.png'),(10,'Варвара Высоцкая','Родилась 29 августа в Златоусте\r\nУчится в 9 классе лицея № 40 при Ульяновском государственном университете\r\nУчастница творческой театральной мастерской \"ЕЖ\" (г. Ульяновск)','2023-08-29',1,'not_found.png'),(11,'Алия Багдеева','Родилась 7 мая в селе Старое Дрожжаное (Татарстан)\r\nУчится в 9 классе ульяновской гимназии № 13','2023-05-07',1,'not_found.png'),(12,'София Кандрашина','Родилась 5 октября в Ульяновске\r\nУчится в 10 классе ульяновской средней школы № 31 имени Героев Свири','2023-10-05',1,'not_found.png'),(13,'Диана Хакимова','Родилась 26 августа в Ульяновске\r\nУчится в 9 классе ульяновской гимназии № 2','2023-08-26',1,'not_found.png'),(14,'Анастасия Терехина','Родилась 1 марта 2006 года в Ульяновске\r\nУчится в 11 классе ульяновской средней школы № 53 имени заслуженного учителя РФ И. В. Исакова\r\nЗанимается в народном коллективе детско-юношеском театре «Дебют» под руководством актёра Ульяновского ТЮЗа Александра Сухомлинова','2023-03-01',1,'not_found.png'),(15,'Матвей Семагин',NULL,'0001-01-01',0,'not_found.png');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repertoire`
--

LOCK TABLES `repertoire` WRITE;
/*!40000 ALTER TABLE `repertoire` DISABLE KEYS */;
INSERT INTO `repertoire` VALUES (1,'Давайте не будем бояться, или ПараФраз о величии','(по философско-политической пьесе Яны Богдановой)','Дети играют, ссорятся, мирятся - всё как у \"нормальных\" людей... Действие разворачивается на детской площадке в то время, пока нет взрослых. У главных героев есть \"кликухи\", \"погоняла\", но нет имён. А на дворе предчувствие, каждый сам решит чего. Да и такие ли уж они дети?','not_found.png',40,'2023-02-24 00:00:00'),(2,'Как я познакомился с отцом','Дж. Баттиста','Пытаясь получше узнать долго отсутствующего в его жизни отца, Лука совершает длинный и непростой путь... к себе. Эта дорога без конца полна лёгких разочарований и трудных приобретений. Душевные искания и неожиданные откровения - главные спутники на этой дороге. И всё ради наполненного светлой грусти итога.','not_found.png',75,'2023-04-21 00:00:00'),(3,'Поясница','(по мотивам романа И.А. Гончарова \"Обыкновенная история\")','История провинциала Саши Адуева, покоряющего столицу, актуальна и 200 лет спустя. Почти «обыкновенная история» в современном формате. Молодые артисты расскажут эту историю по-новому.','not_found.png',95,'2022-10-01 00:00:00'),(4,'Мой маленький О. Моя Маленькая О...','(По мотивам романа И.А. Гончарова \"Обломов\")','А что если бы Илья Обломов, Андрей Штольц и Оля Ильинская встретились на 15 лет раньше? Героям по 18-20 лет. Они амбициозны и влюблены... И предлагают зрителю погрузиться в свою историю и пройти свой путь вместе с ними. Буквально. И узнать, чем болен юный Илья Ильич...','not_found.png',NULL,'2023-11-20 18:30:00');
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

-- Dump completed on 2023-10-21 15:48:06
