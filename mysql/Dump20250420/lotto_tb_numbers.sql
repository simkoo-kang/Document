CREATE DATABASE  IF NOT EXISTS `mydb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `mydb`;
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `tb_numbers`
--

DROP TABLE IF EXISTS `tb_numbers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_numbers` (
  `round` int NOT NULL DEFAULT '0' COMMENT 'round',
  `lt_date` varchar(10) NOT NULL DEFAULT '0000-00-00' COMMENT 'lotted date',
  `n1` int NOT NULL DEFAULT '0' COMMENT 'number 1',
  `n2` int NOT NULL DEFAULT '0' COMMENT 'number 2',
  `n3` int NOT NULL DEFAULT '0' COMMENT 'number 3',
  `n4` int NOT NULL DEFAULT '0' COMMENT 'number 4',
  `n5` int NOT NULL DEFAULT '0' COMMENT 'number 5',
  `n6` int NOT NULL DEFAULT '0' COMMENT 'number 6',
  `bonus` int NOT NULL DEFAULT '0' COMMENT 'bonus number',
  `total` int(3) unsigned zerofill DEFAULT '000' COMMENT 'sum of numbers',
  `ac` int(2) unsigned zerofill DEFAULT '00' COMMENT 'ac value',
  `L05` int(1) unsigned zerofill DEFAULT '0' COMMENT 'last 05 count',
  `L10` int(1) unsigned zerofill DEFAULT '0' COMMENT 'last 10 count',
  `n1_count` int(5) unsigned zerofill DEFAULT '00000' COMMENT 'first rank count',
  `n1_amount` int(11) unsigned zerofill DEFAULT '00000000000' COMMENT 'first rank amount',
  `n2_count` int(5) unsigned zerofill DEFAULT '00000' COMMENT 'second rank count',
  `n2_amount` int(11) unsigned zerofill DEFAULT '00000000000' COMMENT 'second rank amount',
  `n3_count` int(5) unsigned zerofill DEFAULT '00000' COMMENT 'third rank count',
  `n3_amount` int(11) unsigned zerofill DEFAULT '00000000000' COMMENT 'third rank amount',
  `n4_count` int(8) unsigned zerofill DEFAULT '00000000' COMMENT 'fourth rank count',
  `n4_amount` int(6) unsigned zerofill DEFAULT '000000' COMMENT 'fourth rank amount',
  `n5_count` int(8) unsigned zerofill DEFAULT '00000000' COMMENT 'fifth rank count',
  `n5_amount` int(5) unsigned zerofill DEFAULT '00000' COMMENT 'fifth rank amount',
  `n1_auto` int(2) unsigned zerofill DEFAULT '00' COMMENT 'first rank auto count',
  `n1_manu` int(2) unsigned zerofill DEFAULT '00' COMMENT 'first rank manu count',
  `n1_half` int(2) unsigned zerofill DEFAULT '00' COMMENT 'first rank half count',
  PRIMARY KEY (`round`),
  UNIQUE KEY `lt_date_UNIQUE` (`lt_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='lotto numbers';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_numbers`
--

LOCK TABLES `tb_numbers` WRITE;
/*!40000 ALTER TABLE `tb_numbers` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_numbers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-20 17:58:29
