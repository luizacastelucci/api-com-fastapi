-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: must_watch
-- ------------------------------------------------------
-- Server version 8.0.35
 
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
-- Table structure for table `ator`
--
 
DROP TABLE IF EXISTS `ator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ator` (
  `idator` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  PRIMARY KEY (`idator`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
 
--
-- Dumping data for table `ator`
--
 
LOCK TABLES `ator` WRITE;
/*!40000 ALTER TABLE `ator` DISABLE KEYS */;
INSERT INTO `ator` VALUES (1,'Pedro Pascal'),(2,'Bella Ramsay');
/*!40000 ALTER TABLE `ator` ENABLE KEYS */;
UNLOCK TABLES;
 
--
-- Table structure for table `ator_serie`
--
 
DROP TABLE IF EXISTS `ator_serie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ator_serie` (
  `idserie` int NOT NULL,
  `idator` int NOT NULL,
  `personagem` varchar(100) NOT NULL,
  PRIMARY KEY (`idserie`,`idator`),
  KEY `idator_idx` (`idator`),
  KEY `idserie_idx` (`idserie`),
  CONSTRAINT `fk_ator_ator_serie` FOREIGN KEY (`idator`) REFERENCES `ator` (`idator`),
  CONSTRAINT `fk_serie_ator_serie` FOREIGN KEY (`idserie`) REFERENCES `serie` (`idserie`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
 
--
-- Dumping data for table `ator_serie`
--
 
LOCK TABLES `ator_serie` WRITE;
/*!40000 ALTER TABLE `ator_serie` DISABLE KEYS */;
INSERT INTO `ator_serie` VALUES (1,1,'Joel'),(1,2,'Ellie');
/*!40000 ALTER TABLE `ator_serie` ENABLE KEYS */;
UNLOCK TABLES;
 
--
-- Table structure for table `avaliacao_serie`
--
 
DROP TABLE IF EXISTS `avaliacao_serie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avaliacao_serie` (
  `idavaliacao_serie` int NOT NULL AUTO_INCREMENT,
  `idserie` int NOT NULL,
  `nota` int NOT NULL,
  `comentario` text,
  `data_avaliacao` date NOT NULL,
  PRIMARY KEY (`idavaliacao_serie`),
  KEY `id_serie__idx` (`idserie`),
  CONSTRAINT `fk_serie_avaliacao` FOREIGN KEY (`idserie`) REFERENCES `serie` (`idserie`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
 
--
-- Dumping data for table `avaliacao_serie`
--
 
LOCK TABLES `avaliacao_serie` WRITE;
/*!40000 ALTER TABLE `avaliacao_serie` DISABLE KEYS */;
INSERT INTO `avaliacao_serie` VALUES (1,1,9,'muito bom, mas o jogo é mehlor','2025-05-05');
/*!40000 ALTER TABLE `avaliacao_serie` ENABLE KEYS */;
UNLOCK TABLES;
 
--
-- Table structure for table `categoria`
--
 
DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `idcategoria` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  PRIMARY KEY (`idcategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
 
--
-- Dumping data for table `categoria`
--
 
LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'Suspense'),(2,'Infantil'),(3,'drama');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;
 
--
-- Table structure for table `motivo_assistir`
--
 
DROP TABLE IF EXISTS `motivo_assistir`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `motivo_assistir` (
  `idmotivo_assistir` int NOT NULL AUTO_INCREMENT,
  `idserie` int NOT NULL,
  `motivo` text NOT NULL,
  PRIMARY KEY (`idmotivo_assistir`),
  KEY `idserie_idx` (`idserie`),
  CONSTRAINT `fk_serie_motivo` FOREIGN KEY (`idserie`) REFERENCES `serie` (`idserie`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
 
--
-- Dumping data for table `motivo_assistir`
--
 
LOCK TABLES `motivo_assistir` WRITE;
/*!40000 ALTER TABLE `motivo_assistir` DISABLE KEYS */;
INSERT INTO `motivo_assistir` VALUES (1,1,'o jogo é legal');
/*!40000 ALTER TABLE `motivo_assistir` ENABLE KEYS */;
UNLOCK TABLES;
 
--
-- Table structure for table `serie`
--
 
DROP TABLE IF EXISTS `serie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `serie` (
  `idserie` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(100) NOT NULL,
  `descricao` text NOT NULL,
  `ano_lancamento` int NOT NULL,
  `idcategoria` int DEFAULT NULL,
  PRIMARY KEY (`idserie`),
  KEY `idcategoria_idx` (`idcategoria`),
  CONSTRAINT `fk_serie_categoria` FOREIGN KEY (`idcategoria`) REFERENCES `categoria` (`idcategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
 
--
-- Dumping data for table `serie`
--
 
LOCK TABLES `serie` WRITE;
/*!40000 ALTER TABLE `serie` DISABLE KEYS */;
INSERT INTO `serie` VALUES (1,'the_last_of_us','The Last of Us retrata Joel e Ellie enfrentando desafios em um mundo pós-apocalíptico devastado por um fungo mortal.',2023,1),(2,'my_little_pony','Pôneis mágicos vivendo aventuras e aprendendo sobre amizade.',1983,2),(4,'backyardigans','Amigos imaginando aventuras no quintal',2004,2);
/*!40000 ALTER TABLE `serie` ENABLE KEYS */;
UNLOCK TABLES;
 
--
-- Dumping events for database 'must_watch'
--
 
--
-- Dumping routines for database 'must_watch'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
 
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
 
-- Dump completed on 2025-05-05 16:19:09
 