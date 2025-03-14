CREATE DATABASE  IF NOT EXISTS `piedrasmagicas` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `piedrasmagicas`;
-- MySQL dump 10.13  Distrib 8.0.41, for macos15 (x86_64)
--
-- Host: localhost    Database: piedrasmagicas
-- ------------------------------------------------------
-- Server version	9.2.0

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
-- Table structure for table `compatibilidades`
--

DROP TABLE IF EXISTS `compatibilidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compatibilidades` (
  `id` int NOT NULL AUTO_INCREMENT,
  `razon` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compatibilidades`
--

LOCK TABLES `compatibilidades` WRITE;
/*!40000 ALTER TABLE `compatibilidades` DISABLE KEYS */;
INSERT INTO `compatibilidades` VALUES (1,'Amatista y Lapislázuli potencian la intuición y la sabiduría.'),(2,'Cuarzo Rosa y Turmalina Negra equilibran amor y protección.'),(3,'Turmalina Negra y Amatista ofrecen una fuerte protección energética.'),(4,'Lapislázuli y Citrino aumentan la claridad mental y la prosperidad.'),(5,'Ónix y Esmeralda combinan fuerza y sabiduría.'),(6,'Citrino y Obsidiana aportan protección mientras atraen prosperidad.'),(7,'Jade y Cuarzo Cristal ayudan a equilibrar la energía y la claridad.'),(8,'Ojo de Tigre y Aguamarina proporcionan equilibrio entre acción y calma.'),(9,'Selenita y Rodonita ayudan a sanar energías del corazón y equilibrar emociones.'),(13,'Fluorita y Granate aumentan la concentración y la vitalidad.'),(15,'Turmalina Negra y Malaquita limpian energías negativas y transforman.');
/*!40000 ALTER TABLE `compatibilidades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compatibilidades_tienen_piedras`
--

DROP TABLE IF EXISTS `compatibilidades_tienen_piedras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compatibilidades_tienen_piedras` (
  `compatibilidades_id` int NOT NULL,
  `piedras_id` int NOT NULL,
  PRIMARY KEY (`compatibilidades_id`,`piedras_id`),
  KEY `fk_compatibilidades_has_piedras_piedras1_idx` (`piedras_id`),
  KEY `fk_compatibilidades_has_piedras_compatibilidades1_idx` (`compatibilidades_id`),
  CONSTRAINT `fk_compatibilidades_has_piedras_compatibilidades1` FOREIGN KEY (`compatibilidades_id`) REFERENCES `compatibilidades` (`id`),
  CONSTRAINT `fk_compatibilidades_has_piedras_piedras1` FOREIGN KEY (`piedras_id`) REFERENCES `piedras` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compatibilidades_tienen_piedras`
--

LOCK TABLES `compatibilidades_tienen_piedras` WRITE;
/*!40000 ALTER TABLE `compatibilidades_tienen_piedras` DISABLE KEYS */;
INSERT INTO `compatibilidades_tienen_piedras` VALUES (1,2),(5,9);
/*!40000 ALTER TABLE `compatibilidades_tienen_piedras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `piedras`
--

DROP TABLE IF EXISTS `piedras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `piedras` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(300) NOT NULL,
  `color` varchar(45) DEFAULT NULL,
  `elemento` varchar(300) DEFAULT NULL,
  `propiedades` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `piedras`
--

LOCK TABLES `piedras` WRITE;
/*!40000 ALTER TABLE `piedras` DISABLE KEYS */;
INSERT INTO `piedras` VALUES (1,'Amatista','Violeta','Aire','Calma la mente y protege de energías negativas.'),(2,'Cuarzo Rosa','Rosa','Agua','Fomenta el amor y la sanación emocional.'),(3,'Turmalina Negra','Negra','Tierra','Absorbe energías negativas.'),(4,'Lapislázuli','Azul','Agua','Potencia la sabiduría y la comunicación.'),(5,'Ónix','Negro','Tierra','Aporta fuerza, autocontrol y protección.'),(6,'Citrino','Amarillo','Fuego','Atrae la prosperidad y la alegría.'),(7,'Esmeralda','Verde','Tierra','Simboliza el amor verdadero y la abundancia.'),(8,'Jade','Verde','Tierra','Fomenta la armonía, la paz y la sabiduría.'),(9,'Obsidiana','Negra','Fuego','Bloquea la negatividad y potencia la introspección.'),(10,'Cuarzo Cristal','Transparente','Aire','Amplifica la energía y la claridad mental.'),(11,'Ojo de Tigre','Dorado','Fuego','Aumenta la confianza y la protección.');
/*!40000 ALTER TABLE `piedras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `piedras_tienen_usos_magicos`
--

DROP TABLE IF EXISTS `piedras_tienen_usos_magicos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `piedras_tienen_usos_magicos` (
  `piedras_id` int NOT NULL,
  `usos_magicos_id` int NOT NULL,
  PRIMARY KEY (`piedras_id`,`usos_magicos_id`),
  KEY `fk_piedras_has_usos_magicos_usos_magicos1_idx` (`usos_magicos_id`),
  KEY `fk_piedras_has_usos_magicos_piedras_idx` (`piedras_id`),
  CONSTRAINT `fk_piedras_has_usos_magicos_piedras` FOREIGN KEY (`piedras_id`) REFERENCES `piedras` (`id`),
  CONSTRAINT `fk_piedras_has_usos_magicos_usos_magicos1` FOREIGN KEY (`usos_magicos_id`) REFERENCES `usos_magicos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `piedras_tienen_usos_magicos`
--

LOCK TABLES `piedras_tienen_usos_magicos` WRITE;
/*!40000 ALTER TABLE `piedras_tienen_usos_magicos` DISABLE KEYS */;
INSERT INTO `piedras_tienen_usos_magicos` VALUES (1,2),(2,3),(5,6);
/*!40000 ALTER TABLE `piedras_tienen_usos_magicos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usos_magicos`
--

DROP TABLE IF EXISTS `usos_magicos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usos_magicos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uso` varchar(300) NOT NULL,
  `descripcion` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usos_magicos`
--

LOCK TABLES `usos_magicos` WRITE;
/*!40000 ALTER TABLE `usos_magicos` DISABLE KEYS */;
INSERT INTO `usos_magicos` VALUES (1,'Protección','Protege contra energías negativas y malas vibraciones.'),(2,'Meditación','Ayuda a la concentración y al equilibrio mental.'),(3,'Amor','Fomenta el amor propio, de pareja y la armonía en relaciones.'),(4,'Sanación','Facilita la sanación emocional y física.'),(5,'Limpieza energética','Elimina energías negativas del entorno y del aura.'),(6,'Abundancia','Atrae prosperidad, dinero y éxito en los negocios.'),(7,'Intuición','Potencia la percepción y la conexión espiritual.'),(8,'Confianza','Aumenta la seguridad en uno mismo y la autoestima.'),(9,'Sueños lúcidos','Favorece los sueños lúcidos y la conexión con el subconsciente.'),(10,'Fuerza y vitalidad','Aporta energía, resistencia y motivación.'),(11,'Equilibrio emocional','Ayuda a gestionar emociones y alcanzar la paz interior.');
/*!40000 ALTER TABLE `usos_magicos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-14 15:43:35
