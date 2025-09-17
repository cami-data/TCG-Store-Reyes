CREATE DATABASE  IF NOT EXISTS `tcg_store_reyes` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `tcg_store_reyes`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: tcg_store_reyes
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `nombre_cliente` varchar(40) NOT NULL,
  `apellido_cliente` varchar(40) NOT NULL,
  `edad_cliente` int DEFAULT NULL,
  `genero_cliente` varchar(1) NOT NULL,
  `mail_cliente` varchar(50) NOT NULL,
  `telefono_cliente` varchar(8) DEFAULT NULL,
  `suscrito` tinyint(1) NOT NULL,
  `id_empleado_sus` int NOT NULL,
  `cumpleanos_cliente_ss` date DEFAULT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `mail_cliente` (`mail_cliente`),
  UNIQUE KEY `telefono_cliente` (`telefono_cliente`),
  CONSTRAINT `chkgenero` CHECK ((`genero_cliente` in (_utf8mb4'M',_utf8mb4'H',_utf8mb4'O')))
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Rafael','Sana',NULL,'H','rafael@gmail.com','99778888',1,3,NULL),(2,'Pablo','Manuel',30,'H','Pablo@gmail.com','17798888',1,3,'1995-05-26'),(3,'Camila','Kings',NULL,'M','camila@gmail.com','99997777',1,2,NULL),(4,'Paola','Panda',NULL,'O','p.panda@gmail.com','97778888',1,4,NULL),(5,'Anita','Banana',NULL,'M','bananas@gmail.com','99911122',0,4,NULL),(6,'Lucia','Jonas',NULL,'M','l.jonas@gmail.com','97718888',1,3,NULL),(7,'Caterina','Varas',44,'M','ana@gmail.com','99999888',1,3,'1980-10-11'),(8,'Manuel','Montt',38,'H','m.montt@gmail.com','99781111',0,2,'1986-11-10'),(9,'Antonio','Varas',54,'H','a.varas@gmail.com','99991717',1,3,'1970-10-09'),(10,'Robin','Hood',35,'H','r.hood@gmail.com','91199998',0,2,'1990-04-20'),(11,'Judy','Hops',36,'H','juydh@gmail.com','91166888',1,3,'1989-01-30'),(12,'Bruce','Willis',44,'H','brucy@gmail.com','99977777',1,3,'1980-11-30'),(13,'Baity','Bait',40,'H','baity@gmail.com','11118888',1,4,'1985-06-30'),(14,'Christine','Daae',54,'M','christine@gmail.com','99978888',1,4,'1970-11-30');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `calcular_edad_clientes` BEFORE INSERT ON `clientes` FOR EACH ROW -- Comprobar si la fecha de cumpleaños es nula o no
	IF NEW.cumpleanos_cliente_ss IS NOT NULL THEN
		SET NEW.edad_cliente = TIMESTAMPDIFF(YEAR, NEW.cumpleanos_cliente_ss, CURDATE());
	END IF */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `suscripcion_insercion_cliente` AFTER INSERT ON `clientes` FOR EACH ROW BEGIN
	IF NEW.suscrito = 1 THEN
		INSERT INTO suscripciones (id_cliente, fecha_suscripcion, mail_cliente_sus, cumpleanos_cliente, id_empleado)
			VALUES
				(new.id_cliente, CURDATE(), NEW.mail_cliente, NEW.cumpleanos_cliente_ss, NEW.id_empleado_sus);
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `empleados`
--

DROP TABLE IF EXISTS `empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleados` (
  `id_empleado` int NOT NULL AUTO_INCREMENT,
  `nombre_empleado` varchar(40) NOT NULL,
  `apellido_empleado` varchar(40) NOT NULL,
  `mail_empleado` varchar(50) NOT NULL,
  `telefono_empleado` varchar(8) NOT NULL,
  `cargo_empleado` varchar(20) NOT NULL,
  `sueldo_empleado` decimal(10,0) NOT NULL,
  PRIMARY KEY (`id_empleado`),
  UNIQUE KEY `mail_empleado` (`mail_empleado`),
  UNIQUE KEY `telefono_empleado` (`telefono_empleado`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados`
--

LOCK TABLES `empleados` WRITE;
/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
INSERT INTO `empleados` VALUES (1,'Liz','Sherman','lizS@gmail.com','99997766','Jefa de local',2000000),(2,'Hiddeo','Kojima','hideo@gmail.com','99657777','Trabajor',1000000),(3,'Ash','Ketchum','ashk@gmail.com','97893346','Trabajador',1000000),(4,'Bruce','Wayne','notbatman@gmail.com','88779867','Trabajador',1000000),(5,'Laios','Tounden','tabemasu@gmail.com','77658890','Bodeguero',800000);
/*!40000 ALTER TABLE `empleados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `formadepago`
--

DROP TABLE IF EXISTS `formadepago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `formadepago` (
  `id_pago` int NOT NULL AUTO_INCREMENT,
  `nombre_pago` varchar(40) NOT NULL,
  PRIMARY KEY (`id_pago`),
  CONSTRAINT `chkNombre_pago` CHECK ((`nombre_pago` in (_utf8mb4'debito',_utf8mb4'credito',_utf8mb4'efectivo',_utf8mb4'deposito')))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `formadepago`
--

LOCK TABLES `formadepago` WRITE;
/*!40000 ALTER TABLE `formadepago` DISABLE KEYS */;
INSERT INTO `formadepago` VALUES (1,'debito'),(2,'credito'),(3,'deposito'),(4,'efectivo');
/*!40000 ALTER TABLE `formadepago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `franquicia`
--

DROP TABLE IF EXISTS `franquicia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `franquicia` (
  `id_franquicia` int NOT NULL AUTO_INCREMENT,
  `nombre_franquicia` varchar(40) NOT NULL,
  PRIMARY KEY (`id_franquicia`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `franquicia`
--

LOCK TABLES `franquicia` WRITE;
/*!40000 ALTER TABLE `franquicia` DISABLE KEYS */;
INSERT INTO `franquicia` VALUES (1,'Sanrio'),(2,'Pokemon'),(3,'YuGiOh'),(4,'Magic'),(5,'MitosYLeyendas'),(6,'Warhammer'),(7,'Anime');
/*!40000 ALTER TABLE `franquicia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historial_stock`
--

DROP TABLE IF EXISTS `historial_stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historial_stock` (
  `id_stock` int NOT NULL AUTO_INCREMENT,
  `id_producto` int DEFAULT NULL,
  `tipoMovimiento_stock` varchar(40) NOT NULL,
  `cantidad_stock` int NOT NULL,
  `fechaMovimiento_stock` date NOT NULL,
  PRIMARY KEY (`id_stock`),
  KEY `id_producto` (`id_producto`),
  CONSTRAINT `historial_stock_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`),
  CONSTRAINT `chkTipoMovimiento_stock` CHECK ((`tipoMovimiento_stock` in (_utf8mb4'entrada',_utf8mb4'salida')))
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historial_stock`
--

LOCK TABLES `historial_stock` WRITE;
/*!40000 ALTER TABLE `historial_stock` DISABLE KEYS */;
INSERT INTO `historial_stock` VALUES (1,1,'entrada',0,'2025-09-17'),(2,2,'entrada',0,'2025-09-17'),(3,3,'entrada',0,'2025-09-17'),(4,4,'entrada',0,'2025-09-17'),(5,5,'entrada',0,'2025-09-17'),(6,6,'entrada',0,'2025-09-17'),(7,7,'entrada',0,'2025-09-17'),(8,8,'entrada',0,'2025-09-17'),(9,9,'entrada',0,'2025-09-17'),(10,10,'entrada',0,'2025-09-17'),(11,11,'entrada',0,'2025-09-17'),(12,12,'entrada',0,'2025-09-17'),(13,13,'entrada',0,'2025-09-17'),(14,14,'entrada',0,'2025-09-17'),(15,15,'entrada',0,'2025-09-17'),(16,16,'entrada',0,'2025-09-17'),(17,17,'entrada',0,'2025-09-17'),(18,18,'entrada',0,'2025-09-17'),(19,19,'entrada',0,'2025-09-17'),(20,20,'entrada',0,'2025-09-17'),(21,21,'entrada',0,'2025-09-17'),(22,22,'entrada',0,'2025-09-17'),(23,23,'entrada',0,'2025-09-17'),(24,24,'entrada',0,'2025-09-17'),(25,25,'entrada',0,'2025-09-17'),(26,26,'entrada',0,'2025-09-17'),(27,27,'entrada',0,'2025-09-17'),(28,28,'entrada',0,'2025-09-17'),(29,29,'entrada',0,'2025-09-17'),(30,30,'entrada',0,'2025-09-17'),(31,31,'entrada',0,'2025-09-17'),(32,32,'entrada',0,'2025-09-17'),(33,29,'entrada',0,'2025-09-17'),(34,30,'entrada',0,'2025-09-17'),(35,31,'entrada',0,'2025-09-17'),(36,32,'entrada',0,'2025-09-17'),(37,29,'entrada',0,'2025-09-17'),(38,30,'entrada',0,'2025-09-17'),(39,31,'entrada',0,'2025-09-17'),(40,32,'entrada',0,'2025-09-17'),(41,33,'entrada',10,'2025-09-17'),(42,1,'entrada',10,'2025-09-17'),(43,34,'entrada',2,'2025-09-17'),(44,3,'entrada',3,'2025-09-17'),(45,2,'entrada',10,'2025-09-17');
/*!40000 ALTER TABLE `historial_stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `id_producto` int NOT NULL AUTO_INCREMENT,
  `nombre_producto` varchar(40) NOT NULL,
  `precio_producto` decimal(10,0) NOT NULL,
  `tipo_producto` varchar(40) NOT NULL,
  `id_franquicia` int DEFAULT NULL,
  `imagen_URL` varchar(2000) DEFAULT NULL,
  `costo_producto` decimal(10,0) NOT NULL,
  `cantidad_producto` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_producto`),
  KEY `id_franquicia` (`id_franquicia`),
  CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_franquicia`) REFERENCES `franquicia` (`id_franquicia`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'Peluche Cinnamoroll',10000,'Peluche',1,'https://www.sanrio.com/cdn/shop/files/zz-2503835293_CN_--1_800x.jpg?v=1741901342',5000,10),(2,'Peluche Cinnamoroll Matcha',15000,'Peluche',1,'https://www.sanrio.com/cdn/shop/files/839426-Zoom.1_800x.jpg?v=1750896124',10000,10),(3,'Peluche Cinnamoroll',10000,'Peluche',1,'https://www.sanrio.com/cdn/shop/files/zz-2503835293_CN_--1_800x.jpg?v=1741901342',5000,3),(4,'Figura Cinnamoroll',15000,'Figura',1,'https://www.sanrio.com/cdn/shop/files/zz-2501123528_CN_--1_800x.jpg?v=1743734595',4000,0),(5,'Peluche Pompompurin',12000,'Peluche',1,'https://www.sanrio.com/cdn/shop/files/4550624300582-2_800x.jpg?v=1749246623',5000,0),(6,'Peluche Pompompurin',9000,'Peluche',1,'https://www.sanrio.com/cdn/shop/files/zz-2407513989_PN_--1_800x.jpg?v=1721938586',4000,0),(7,'Hello Kitty and Friends',20000,'Figura',1,'https://www.sanrio.com/products/hello-kitty-and-friends-4-ultra-premier-6-pc-figure-set',10000,0),(8,'Figura Kuromi',25000,'Figura',1,'https://www.sanrio.com/cdn/shop/files/zz-2403874027_KU_--1_800x.jpg?v=1719937077',10000,0),(9,'Dobble Sanrio',14990,'Figura',1,NULL,8000,0),(10,'Surging Sparks Cartas Pokemon',5000,'Sobres de cartas',2,'https://sidedeck.cl/cdn/shop/files/Pokemon_TCG_Scarlet_Violet_Surging_Sparks_Booster_Wrap_Pikachu_1.png?v=1754447175',2000,0),(11,'Black Bolt Cartas Pokemon',60000,'Pack cartas',2,'https://http2.mlstatic.com/D_NQ_NP_2X_764487-MLC86738296853_062025-F-pokemon-black-bolt-etb-espanol-elite-trainer-box.webp',30000,0),(12,'Obsidian Flames Cartas Pokemon',4000,'Sobres de cartas',2,'https://sidedeck.cl/cdn/shop/files/Pokemon_TCG_Scarlet_Violet_Obsidian_Flames_Booster_Wrap_Charizard_1.png?v=1754442307',2000,0),(13,'Alakazam-Ex',50000,'Single',2,'https://images.pokemontcg.io/xy10/125_hires.png',40000,0),(14,'Mudkip',2000,'Single',2,'https://images.pokemontcg.io/ex14/58_hires.png',1000,0),(15,'Porta Mazos Pokemon',9990,'Portamazo',2,'https://www.magicsur.cl/29358-large_default/portamazo-ultra-pro-gallery-series-trick-room-full-view-deck-box.jpg',14550,0),(16,'Playmat Eeve Pokemon',19990,'Playmat',2,'https://www.pokemoncenter.com/images/DAMRoot/High/10014/P11488_10-10227-101_01.jpg',14990,0),(17,'Dobble Pokemon',14990,'Juego de mesa',2,NULL,10000,0),(18,'Nexus Duelista YuGiOh',4000,'Sobres de cartas',3,'https://www.updown.cl/producto/yu-gi-oh-nexus-duelista-sobre-espanol/',2000,0),(19,'Rompedores Valientes YuGiOh',4000,'Sobres de cartas',3,'https://www.updown.cl/producto/yu-gi-oh-rompedores-valientes-sobre-espanol/',1000,0),(20,'Playmat YuGiOh',11000,'Playmat',3,'https://www.updown.cl/producto/playmat-yu-gi-oh-dark-magician-girl-game-mat/',2000,0),(21,'Portamazo YuGiOh',4490,'Portamazo',3,'https://www.updown.cl/producto/yu-gi-oh-portamazo-albaz-eccleisa-tri-brigade-card-case/',1000,0),(22,'Crimson King YugiOh',24990,'Pack cartas',3,NULL,12000,0),(23,'Bestias de Cristal YuGiOh',4990,'Sobres de cartas',3,NULL,1000,0),(24,'Set Booster LOTR Cartas Magic',8000,'Sobres de cartas',4,'https://www.magicsur.cl/25597-large_default/mtg-set-boosters-sobres-de-edicion-the-lord-of-the-rings-tales-of-middle-earth.jpg',4000,0),(25,'Sobre Phyrexia Cartas Magic',5000,'Pack cartas',4,NULL,1000,0),(26,'Necrogoyf',1000,'Single',4,NULL,500,0),(27,'Zell Dincht',50000,'Single',4,'https://cards.scryfall.io/large/front/2/5/25d28011-f0a6-4d7b-ab87-aae0fe354d9e.jpg?1748707525',30000,0),(28,'Porta Mazo Magic',9990,'Porta Mazos',4,'https://www.magicsur.cl/portamazos/7514-portamazo-ultra-pro-outlaws-of-thunder-junction-jace-reawakened-alcove-flip-deck-box.html',4500,0),(29,'Rice Shower Figura',39990,'Figura',7,'https://cdnb.artstation.com/p/assets/images/images/042/168/735/large/kaoru-sakaki-img31001.jpg?1633925437',30000,0),(30,'Patamon Figura',24990,'Figura',7,'https://cdn11.bigcommerce.com/s-xs1cevxe43/images/stencil/960w/attribute_rule_images/16506_source_1752623615.jpg',20000,0),(31,'Figura Miku Banpresto',29990,'Figura',7,NULL,20000,0),(32,'One Piece Monopoly',39990,'Juego de Mesa',7,NULL,32000,0),(33,'Carta Articuno',1000,'Single',2,NULL,500,10),(34,'Carta Ditto',10000,'Single',2,NULL,500,2);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `insercion_stock` AFTER INSERT ON `productos` FOR EACH ROW INSERT INTO historial_stock (id_stock, id_producto, tipoMovimiento_stock, cantidad_stock, fechaMovimiento_stock)
	VALUES
	(DEFAULT, NEW.id_producto, 'entrada', COALESCE(NEW.cantidad_producto, 0), CURDATE()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `insercion_stock_existente` AFTER UPDATE ON `productos` FOR EACH ROW INSERT INTO historial_stock (id_stock, id_producto, tipoMovimiento_stock, cantidad_stock, fechaMovimiento_stock)
	VALUES
	(DEFAULT, NEW.id_producto, 'entrada', COALESCE(NEW.cantidad_producto, 0), CURDATE()) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `promociones`
--

DROP TABLE IF EXISTS `promociones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `promociones` (
  `id_promo` int NOT NULL AUTO_INCREMENT,
  `nombre_promo` varchar(40) NOT NULL,
  `porcentaje_promo` decimal(3,2) DEFAULT NULL,
  `fechainicio_promo` date NOT NULL,
  `fechafinal_promo` date NOT NULL,
  `estado` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_promo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promociones`
--

LOCK TABLES `promociones` WRITE;
/*!40000 ALTER TABLE `promociones` DISABLE KEYS */;
INSERT INTO `promociones` VALUES (1,'Black Friday',0.50,'2025-11-20','2025-11-30',0),(2,'Cyber Monday',0.20,'2025-05-20','2025-05-30',0),(3,'Primera Compra',0.10,'2024-01-01','2030-12-30',1),(4,'Cumpleaños',0.30,'2024-01-01','2030-12-30',1);
/*!40000 ALTER TABLE `promociones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suscripciones`
--

DROP TABLE IF EXISTS `suscripciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suscripciones` (
  `id_cliente` int NOT NULL,
  `fecha_suscripcion` date NOT NULL,
  `mail_cliente_sus` varchar(50) NOT NULL,
  `cumpleanos_cliente` date DEFAULT NULL,
  `id_empleado` int DEFAULT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `mail_cliente_sus` (`mail_cliente_sus`),
  KEY `id_empleado` (`id_empleado`),
  CONSTRAINT `suscripciones_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`),
  CONSTRAINT `suscripciones_ibfk_2` FOREIGN KEY (`id_empleado`) REFERENCES `empleados` (`id_empleado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suscripciones`
--

LOCK TABLES `suscripciones` WRITE;
/*!40000 ALTER TABLE `suscripciones` DISABLE KEYS */;
INSERT INTO `suscripciones` VALUES (1,'2025-09-17','rafael@gmail.com',NULL,3),(2,'2025-09-17','Pablo@gmail.com','1995-05-26',3),(3,'2025-09-17','camila@gmail.com',NULL,2),(4,'2025-09-17','p.panda@gmail.com',NULL,4),(6,'2025-09-17','l.jonas@gmail.com',NULL,3),(7,'2025-09-17','ana@gmail.com','1980-10-11',3),(9,'2025-09-17','a.varas@gmail.com','1970-10-09',3),(11,'2025-09-17','juydh@gmail.com','1989-01-30',3),(12,'2025-09-17','brucy@gmail.com','1980-11-30',3),(13,'2025-09-17','baity@gmail.com','1985-06-30',4),(14,'2025-09-17','christine@gmail.com','1970-11-30',4);
/*!40000 ALTER TABLE `suscripciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas`
--

DROP TABLE IF EXISTS `ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventas` (
  `id_venta` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `id_producto` int NOT NULL,
  `cantidad_producto` int NOT NULL,
  `precioOriginal_venta` decimal(10,0) NOT NULL,
  `precioFinal_venta` decimal(10,0) NOT NULL,
  `id_promo` int DEFAULT NULL,
  `fecha_venta` date NOT NULL,
  `id_pago` int NOT NULL,
  `id_empleado` int DEFAULT NULL,
  `descuento_aplicado` decimal(3,2) DEFAULT NULL,
  PRIMARY KEY (`id_venta`),
  KEY `id_cliente` (`id_cliente`),
  KEY `id_producto` (`id_producto`),
  KEY `id_promo` (`id_promo`),
  KEY `id_pago` (`id_pago`),
  KEY `id_empleado` (`id_empleado`),
  CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`),
  CONSTRAINT `ventas_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`),
  CONSTRAINT `ventas_ibfk_3` FOREIGN KEY (`id_promo`) REFERENCES `promociones` (`id_promo`),
  CONSTRAINT `ventas_ibfk_4` FOREIGN KEY (`id_pago`) REFERENCES `formadepago` (`id_pago`),
  CONSTRAINT `ventas_ibfk_5` FOREIGN KEY (`id_empleado`) REFERENCES `empleados` (`id_empleado`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas`
--

LOCK TABLES `ventas` WRITE;
/*!40000 ALTER TABLE `ventas` DISABLE KEYS */;
INSERT INTO `ventas` VALUES (1,5,20,1,11000,9900,3,'2025-09-17',3,4,0.10),(2,5,11,1,60000,60000,NULL,'2025-09-17',1,3,NULL),(3,3,18,1,4000,3600,3,'2025-11-30',1,3,0.10),(4,3,19,1,4000,4000,NULL,'2025-01-10',1,3,NULL),(5,3,26,10,1000,10000,NULL,'2025-05-30',2,2,NULL),(6,12,20,1,11000,9900,3,'2025-01-10',1,3,0.10),(7,12,11,2,60000,108000,3,'2024-02-15',1,4,0.10),(8,2,8,1,25000,25000,NULL,'2024-03-21',2,2,NULL),(9,4,22,3,24990,37485,1,'2024-04-10',4,3,0.50),(10,6,11,1,60000,60000,NULL,'2024-05-05',3,5,NULL),(11,7,5,1,12000,8400,4,'2024-06-18',2,2,0.30),(12,8,19,2,4000,8000,NULL,'2024-07-29',1,4,NULL),(13,9,19,1,4000,4000,NULL,'2024-08-01',4,3,NULL),(14,10,2,5,15000,67500,3,'2024-09-14',1,5,0.10),(15,11,22,1,24990,12495,1,'2024-10-22',2,2,0.50),(16,1,7,2,20000,40000,NULL,'2024-11-03',4,3,NULL),(17,2,1,1,10000,8000,2,'2024-12-09',3,4,0.20),(18,4,11,4,60000,216000,3,'2025-01-12',1,5,0.10),(19,6,28,1,9990,9990,NULL,'2025-02-20',2,2,NULL),(20,7,22,1,24990,17493,4,'2025-03-01',1,3,0.30),(21,8,16,2,19990,19990,1,'2025-04-15',3,4,0.50),(22,9,9,1,14990,10493,4,'2025-05-28',1,5,0.30),(23,10,25,3,5000,15000,NULL,'2025-06-08',2,2,NULL),(24,11,3,1,10000,10000,NULL,'2025-07-19',4,3,NULL),(25,1,22,1,24990,22491,3,'2025-08-25',3,4,0.10),(26,4,14,2,2000,3200,2,'2025-09-01',1,5,0.20),(27,1,2,2,15000,27000,3,'2025-09-17',1,4,0.10),(28,1,1,2,10000,18000,3,'2025-09-17',1,4,0.10);
/*!40000 ALTER TABLE `ventas` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `buscar_descuento_aplicado` BEFORE INSERT ON `ventas` FOR EACH ROW BEGIN
	DECLARE descuento_aplicado_promo DECIMAL (3,2);
    DECLARE v_estado_promo INT;

		SELECT porcentaje_promo, estado
		INTO descuento_aplicado_promo, v_estado_promo
		FROM promociones
		WHERE id_promo = NEW.id_promo;
        
        IF v_estado_promo = 0 THEN
        		SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'ERROR: promoción no activa';
		ELSE 
	SET NEW.descuento_aplicado = descuento_aplicado_promo;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `calcular_precios_venta` BEFORE INSERT ON `ventas` FOR EACH ROW BEGIN 
	DECLARE precio_buscado DECIMAL (10,2);
    
    SELECT 	precio_producto
    INTO precio_buscado
    FROM productos
    WHERE id_producto = NEW.id_producto; 
    
    IF precio_buscado IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: No se puede registrar la venta porque el producto no existe.';
    ELSE
		SET NEW.precioOriginal_venta = precio_buscado;
        SET NEW.precioFinal_venta = (NEW.precioOriginal_venta * (1 - IFNULL(NEW.descuento_aplicado, 0)) * NEW.cantidad_producto);
	END IF; 
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'tcg_store_reyes'
--

--
-- Dumping routines for database 'tcg_store_reyes'
--
/*!50003 DROP FUNCTION IF EXISTS `fn_dias_ultima_compra` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_dias_ultima_compra`(p_id_cliente INT) RETURNS int
    DETERMINISTIC
BEGIN 
		DECLARE dias_ultima_compra INT;
		SELECT DATEDIFF(CURDATE(), MAX(fecha_venta))
		INTO dias_ultima_compra
		FROM ventas
		WHERE p_id_cliente = id_cliente;
    RETURN dias_ultima_compra;
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_ingresos_totales_dia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_ingresos_totales_dia`(p_fecha DATE) RETURNS int
    DETERMINISTIC
BEGIN
		DECLARE ingresos_totales_dia INT;
        SELECT SUM(precioFinal_venta)
        INTO ingresos_totales_dia
        FROM ventas
        WHERE fecha_venta = p_fecha;
	RETURN ingresos_totales_dia;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `fn_ingresos_totales_producto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_ingresos_totales_producto`(p_id_producto INT) RETURNS int
    DETERMINISTIC
BEGIN
	DECLARE v_total_ingresos INT;
    SELECT 
		IFNULL(SUM(precioFinal_venta), 0)
        INTO v_total_ingresos
        FROM ventas
        WHERE 
        id_producto = p_id_producto;
	RETURN v_total_ingresos;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_cambiar_precios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_cambiar_precios`(IN cambio_precio DECIMAL(10,0), IN franquicia_seleccionada_id INT)
BEGIN
	UPDATE productos p
    SET precio_producto = precio_producto + cambio_precio
    WHERE p.id_franquicia = franquicia_seleccionada_id
;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_historial_cliente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_historial_cliente`(IN p_id_cliente INT)
BEGIN
	SELECT c.id_cliente, CONCAT(c.nombre_cliente, ' ', c.apellido_cliente) as 'Nombre_completo', SUM(v.PrecioFinal_venta) as suma_ventas
	FROM ventas v 
	INNER JOIN clientes c on v.id_cliente = c.id_cliente
    WHERE c.id_cliente = p_id_cliente
	GROUP BY c.id_cliente;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ingresar_nuevo_producto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ingresar_nuevo_producto`(IN p_nombre_producto VARCHAR(40), IN p_precio_producto DECIMAL (10,0), p_tipo_producto VARCHAR (40), p_id_franquicia INT, p_imagen_URL VARCHAR(2000), p_costo_producto DECIMAL (10,0), IN p_cantidad_producto INT)
BEGIN
	INSERT INTO productos (nombre_producto, precio_producto, tipo_producto, id_franquicia, imagen_URL, costo_producto, cantidad_producto)
    VALUES
    (p_nombre_producto, p_precio_producto, p_tipo_producto, p_id_franquicia, p_imagen_URL, p_costo_producto, p_cantidad_producto)
;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_ingresar_stock` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ingresar_stock`(IN p_cantidad_producto INT, IN p_id_producto INT)
BEGIN
UPDATE productos p
SET cantidad_producto = cantidad_producto + p_cantidad_producto
WHERE id_producto = p_id_producto
; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-17 17:04:18
