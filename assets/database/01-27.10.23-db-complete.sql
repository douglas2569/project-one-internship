-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: workshopprime
-- ------------------------------------------------------
-- Server version	8.0.34

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
-- Table structure for table `attendants`
--

DROP TABLE IF EXISTS `attendants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendants` (
  `cpf` varchar(50) NOT NULL,
  PRIMARY KEY (`cpf`),
  CONSTRAINT `attendants_ibfk_1` FOREIGN KEY (`cpf`) REFERENCES `employees` (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendants`
--

LOCK TABLES `attendants` WRITE;
/*!40000 ALTER TABLE `attendants` DISABLE KEYS */;
INSERT INTO `attendants` VALUES ('01069520055'),('82178774083');
/*!40000 ALTER TABLE `attendants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auto_vehicle_workshops`
--

DROP TABLE IF EXISTS `auto_vehicle_workshops`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auto_vehicle_workshops` (
  `cnpj` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `business_name` varchar(50) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone_number` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`cnpj`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `business_name` (`business_name`),
  UNIQUE KEY `phone_number` (`phone_number`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auto_vehicle_workshops`
--

LOCK TABLES `auto_vehicle_workshops` WRITE;
/*!40000 ALTER TABLE `auto_vehicle_workshops` DISABLE KEYS */;
INSERT INTO `auto_vehicle_workshops` VALUES ('01187817000183','Workshop Prime','Workshop Prime','Rua 24, n° 1234, Automóvel Central, Cidade dos Motores-CE, Brasil','8587965433','workshopprime@gmail.com');
/*!40000 ALTER TABLE `auto_vehicle_workshops` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `automotive_parts`
--

DROP TABLE IF EXISTS `automotive_parts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `automotive_parts` (
  `image_address` varchar(255),
  `reference_number` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text,
  `unit_value` decimal(10,0) NOT NULL,
  `brand` varchar(50) NOT NULL,
  PRIMARY KEY (`reference_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `automotive_parts`
--

LOCK TABLES `automotive_parts` WRITE;
/*!40000 ALTER TABLE `automotive_parts` DISABLE KEYS */;
INSERT INTO `automotive_parts` VALUES ('12345','Filtro de Óleo','Este filtro de óleo Fram possui uma classificação de eficiência de filtração de 98%, com uma capacidade de retenção de partículas de até 10 micra, protegendo o motor contra desgaste prematuro.',15,'Fram'),('23456','Vela de Ignição','As velas de ignição NGK são fabricadas com eletrodos de níquel-cromo e possuem uma faixa térmica de calor médio, garantindo ignição precisa e confiável em uma ampla gama de temperaturas e condições.',90,'K&N'),('54321','Bateria de Carro','A bateria AC Delco é uma bateria de chumbo-ácido de 12 volts, com uma capacidade nominal de 60 ampères-hora (Ah) e uma resistência interna baixa, fornecendo uma corrente de partida confiável',150,'AC Delco'),('67890','Pastilhas de Freio','Pastilhas de freio Brembo são componentes do sistema de freio que fornecem frenagem segura e eficaz.',50,'Brembo'),('98765','Filtro de Ar','O filtro de ar K&N é um filtro de alto fluxo, projetado para aumentar a capacidade de fluxo de ar em até 50%, mantendo uma eficiência de filtração de 99%, com uma capacidade de retenção de partículas de até 2 micra.',20,'NGK'),('M12345','Filtro de Ar','Os filtros de ar K&N possuem uma capacidade de fluxo de ar de 1.000 CFM (pés cúbicos por minuto) a uma restrição de 1 polegada de água, proporcionando um aumento significativo no fluxo de ar.',80,'K&N'),('M23456','Disco de Freio','Os discos de freio EBC são feitos de aço inoxidável endurecido e possuem ranhuras para dissipação de calor, proporcionando um desempenho de frenagem consistente e eficiente.',200,'EBC'),('M65432','Vela de Ignição','As velas de ignição Denso são feitas de cerâmica isolante e possuem uma resistência de 0,8 ohms, garantindo ignição eficaz e redução do consumo de combustível.',10,'Denso'),('M78901','Corrente de Transmissão','A corrente de transmissão DID é uma corrente de rolos selada com uma classificação de resistência à tração de 8.000 libras, projetada para transmitir potência eficientemente com uma vida útil prolongada.',300,'DID'),('M87654','Pneu Traseiro','O pneu traseiro Michelin possui uma construção radial com uma classificação de velocidade de até 180 km/h, oferecendo aderência excepcional em uma variedade de condições de pilotagem.',50,'Michelin');
/*!40000 ALTER TABLE `automotive_parts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `cpf` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone_number` varchar(50) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `cnpj_auto_vehicle_workstops_fk` varchar(50) NOT NULL,
  PRIMARY KEY (`cpf`),
  UNIQUE KEY `phone_number` (`phone_number`),
  UNIQUE KEY `email` (`email`),
  KEY `cnpj_auto_vehicle_workstops_fk` (`cnpj_auto_vehicle_workstops_fk`),
  CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`cnpj_auto_vehicle_workstops_fk`) REFERENCES `auto_vehicle_workshops` (`cnpj`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES ('03966183080','Juliano Pasquim','Rua T, n° 10,Chico da Doca, Cidade Paçoca-CE, Brasil','8588873217','julianopasquim@outlook.com','01187817000183'),('11924265095','Ivan Nildo','Rua C, n° 11, Tata Tico, Cidade Pamanha-CE, Brasil','8587779917','ivannildo@outlook.com','01187817000183'),('29012056071','Paula Abreu','Rua B, n° 10,Chico Tico, Cidade Paçoca-CE, Brasil','8588879917','paulaabreu@outlook.com','01187817000183');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `cpf` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone_number` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `position` varchar(255) DEFAULT NULL,
  `cnpj_auto_vehicle_workshops_fk` varchar(50) NOT NULL,
  PRIMARY KEY (`cpf`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `phone_number` (`phone_number`),
  UNIQUE KEY `email` (`email`),
  KEY `cnpj_auto_vehicle_workshops_fk` (`cnpj_auto_vehicle_workshops_fk`),
  CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`cnpj_auto_vehicle_workshops_fk`) REFERENCES `auto_vehicle_workshops` (`cnpj`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES ('01069520055','Leticia Juliana','Rua 64, n° 03, Parque Jardim, Cidade Media-CE, Brasil','8590765833','leticiajuliana@gmail.com','atendente','01187817000183'),('31685403077','Antonio Ferreira','Rua Z, n° 98, Parque alvoras, Cidade Normal-CE, Brasil','8597788833','antonioferreia@yahoo.com','mecânico','01187817000183'),('41740738055','João Juliano','Rua 64, n° 03, Parque Jardim, Cidade Media-CE, Brasil','8590665833','joaojuliano@gmail.com','mecânico','01187817000183'),('46899032040','Pedro Gustavo','Rua A, n° 11, Parque Jardim, Cidade Media-CE, Brasil','8597765833','pedrogustavo@gmail.com','mecânico','01187817000183'),('62565411030','Cassio Malvarisco','Rua F, n° 1634, Parque das flores, Cidade dos Altos-CE, Brasil','8588965833','cassiomalvarisco@hotmail.com','gerente','01187817000183'),('82178774083','Angelo Tavares','Rua 22, n° 34, Bom Jardim, Cidade Baixa-CE, Brasil','8599465833','angelotavares@outlook.com','atendente','01187817000183');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory` (
  `reference_number` varchar(50) NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`reference_number`),
  CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`reference_number`) REFERENCES `automotive_parts` (`reference_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
INSERT INTO `inventory` VALUES ('12345',200),('23456',5),('54321',100),('67890',30),('98765',250),('M12345',10),('M23456',0),('M65432',35),('M78901',1),('M87654',13);
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenance`
--

DROP TABLE IF EXISTS `maintenance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maintenance` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reason` varchar(50) NOT NULL,
  `description` text,
  `status` tinyint DEFAULT '0',
  `initialDate` datetime DEFAULT NULL,
  `finalDate` datetime DEFAULT NULL,
  `license_plate_vehicles_customer_fk` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `license_plate_vehicles_customer_fk` (`license_plate_vehicles_customer_fk`),
  CONSTRAINT `maintenance_ibfk_1` FOREIGN KEY (`license_plate_vehicles_customer_fk`) REFERENCES `vehicles_customer` (`license_plate`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenance`
--

LOCK TABLES `maintenance` WRITE;
/*!40000 ALTER TABLE `maintenance` DISABLE KEYS */;
INSERT INTO `maintenance` VALUES (35,'Carro não liga','Quando giro a chave ele faz tantaaaatan',0,NULL,NULL,'MXQ9131'),(36,'Painel nao liga','Depois de cair agua nele',0,NULL,NULL,'LST5307'),(37,'Carro sem folego','Fica cansado rapido',0,NULL,NULL,'HPP2304');
/*!40000 ALTER TABLE `maintenance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenance_inventory`
--

DROP TABLE IF EXISTS `maintenance_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maintenance_inventory` (
  `reference_number` varchar(50) NOT NULL,
  `id_maintenance` int NOT NULL,
  PRIMARY KEY (`reference_number`,`id_maintenance`),
  KEY `id_maintenance` (`id_maintenance`),
  CONSTRAINT `maintenance_inventory_ibfk_1` FOREIGN KEY (`reference_number`) REFERENCES `automotive_parts` (`reference_number`),
  CONSTRAINT `maintenance_inventory_ibfk_2` FOREIGN KEY (`id_maintenance`) REFERENCES `maintenance` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenance_inventory`
--

LOCK TABLES `maintenance_inventory` WRITE;
/*!40000 ALTER TABLE `maintenance_inventory` DISABLE KEYS */;
INSERT INTO `maintenance_inventory` VALUES ('23456',35),('23456',36),('98765',37);
/*!40000 ALTER TABLE `maintenance_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manages`
--

DROP TABLE IF EXISTS `manages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manages` (
  `cpf` varchar(50) NOT NULL,
  PRIMARY KEY (`cpf`),
  CONSTRAINT `manages_ibfk_1` FOREIGN KEY (`cpf`) REFERENCES `employees` (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manages`
--

LOCK TABLES `manages` WRITE;
/*!40000 ALTER TABLE `manages` DISABLE KEYS */;
INSERT INTO `manages` VALUES ('62565411030');
/*!40000 ALTER TABLE `manages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mechanics`
--

DROP TABLE IF EXISTS `mechanics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mechanics` (
  `cpf` varchar(50) NOT NULL,
  PRIMARY KEY (`cpf`),
  CONSTRAINT `mechanics_ibfk_1` FOREIGN KEY (`cpf`) REFERENCES `employees` (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mechanics`
--

LOCK TABLES `mechanics` WRITE;
/*!40000 ALTER TABLE `mechanics` DISABLE KEYS */;
INSERT INTO `mechanics` VALUES ('31685403077'),('41740738055'),('46899032040');
/*!40000 ALTER TABLE `mechanics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `services` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` text,
  `estimatedTime` varchar(50) DEFAULT NULL,
  `cost` decimal(10,0) NOT NULL,
  `cnpj_auto_vehicle_workstops_fk` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `cnpj_auto_vehicle_workstops_fk` (`cnpj_auto_vehicle_workstops_fk`),
  CONSTRAINT `services_ibfk_1` FOREIGN KEY (`cnpj_auto_vehicle_workstops_fk`) REFERENCES `auto_vehicle_workshops` (`cnpj`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (35,'Troca de vela de ingnição de carro','Pego a vela, tiro a antiga, coloco a nova','10',50,'01187817000183'),(36,'Troca filtro de ar','Pego a filtro, tiro a antigo, coloco a novo','30',100,'01187817000183');
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services_provided`
--

DROP TABLE IF EXISTS `services_provided`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `services_provided` (
  `id` int NOT NULL AUTO_INCREMENT,
  `initial_date` datetime DEFAULT NULL,
  `final_date` datetime DEFAULT NULL,
  `id_maintenance_fk` int NOT NULL,
  `cpf_mechanics_fk` varchar(50) NOT NULL,
  `id_services_fk` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_maintenance_fk` (`id_maintenance_fk`),
  KEY `cpf_mechanics_fk` (`cpf_mechanics_fk`),
  KEY `id_services_fk` (`id_services_fk`),
  CONSTRAINT `services_provided_ibfk_1` FOREIGN KEY (`id_maintenance_fk`) REFERENCES `maintenance` (`id`),
  CONSTRAINT `services_provided_ibfk_2` FOREIGN KEY (`cpf_mechanics_fk`) REFERENCES `mechanics` (`cpf`),
  CONSTRAINT `services_provided_ibfk_3` FOREIGN KEY (`id_services_fk`) REFERENCES `services` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services_provided`
--

LOCK TABLES `services_provided` WRITE;
/*!40000 ALTER TABLE `services_provided` DISABLE KEYS */;
INSERT INTO `services_provided` VALUES (35,NULL,NULL,35,'41740738055',35),(36,NULL,NULL,36,'46899032040',35),(37,NULL,NULL,37,'31685403077',36);
/*!40000 ALTER TABLE `services_provided` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suppliers` (
  `cnpj` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `business_name` varchar(50) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone_number` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `brachActivity` varchar(255) DEFAULT NULL,
  `cnpj_auto_vehicle_workstops_fk` varchar(50) NOT NULL,
  PRIMARY KEY (`cnpj`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `business_name` (`business_name`),
  UNIQUE KEY `phone_number` (`phone_number`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `brachActivity` (`brachActivity`),
  KEY `cnpj_auto_vehicle_workstops_fk` (`cnpj_auto_vehicle_workstops_fk`),
  CONSTRAINT `suppliers_ibfk_1` FOREIGN KEY (`cnpj_auto_vehicle_workstops_fk`) REFERENCES `auto_vehicle_workshops` (`cnpj`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suppliers`
--

LOCK TABLES `suppliers` WRITE;
/*!40000 ALTER TABLE `suppliers` DISABLE KEYS */;
INSERT INTO `suppliers` VALUES ('12557378000170','Pirelli','Pirelli Pneus Ltda','Rua P, n° 11, Maga, Cidade Pacajus-CE, Brasil','8588006544','pirelli@yempresa.com','fabricante de pneus automotivos','01187817000183'),('60655945000173','Bosch','Robert Bosch Ltda','Rua W, n° 98, Parque Tocas, Cidade Normal-CE, Brasil','8588873266','bosch@yahoo.com','Fabricante de equipamentos automotivos e peças','01187817000183'),('82804111000115','3M','3M do Brasil Ltda','Rua Y, n° 55, Sola Aí, Cidade Fortaleza-CE, Brasil','8588776544','3M@yempresa.com','ornecedora de produtos automotivos, como lixas, adesivos e polidores','01187817000183');
/*!40000 ALTER TABLE `suppliers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `cpf` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `status` tinyint(1) default 1, 
  PRIMARY KEY (`cpf`),
  UNIQUE KEY `username` (`username`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`cpf`) REFERENCES `employees` (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('01069520055','leticia66','$2y$10$.0URBGQDyTW77ezc/iy.FOD9zVODmuQIE0HuRSeW9cocuEso3Uzye'),('31685403077','antonioo01','$2y$10$.0URBGQDyTW77ezc/iy.FOD9zVODmuQIE0HuRSeW9cocuEso3Uzye'),('41740738055','joao01','$2y$10$.0URBGQDyTW77ezc/iy.FOD9zVODmuQIE0HuRSeW9cocuEso3Uzye'),('46899032040','pedro01','$2y$10$.0URBGQDyTW77ezc/iy.FOD9zVODmuQIE0HuRSeW9cocuEso3Uzye'),('62565411030','cassio00','$2y$10$.0URBGQDyTW77ezc/iy.FOD9zVODmuQIE0HuRSeW9cocuEso3Uzye'),('82178774083','angelo24','$2y$10$.0URBGQDyTW77ezc/iy.FOD9zVODmuQIE0HuRSeW9cocuEso3Uzye');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicles`
--

DROP TABLE IF EXISTS `vehicles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicles` (
  `model` varchar(50) NOT NULL,
  `brand` varchar(50) NOT NULL,
  PRIMARY KEY (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicles`
--

LOCK TABLES `vehicles` WRITE;
/*!40000 ALTER TABLE `vehicles` DISABLE KEYS */;
INSERT INTO `vehicles` VALUES ('CT200h F-Sport 1.8 16V HIBRID Aut.','Lexus'),('Grand Cherokee Limited LX 5.9','Jeep'),('Mystique GS 2.5 V6 Mec.','Mercury');
/*!40000 ALTER TABLE `vehicles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicles_automotive_parts`
--

DROP TABLE IF EXISTS `vehicles_automotive_parts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicles_automotive_parts` (
  `reference_number_automotive_parts` varchar(50) NOT NULL,
  `model_vehicles` varchar(50) NOT NULL,
  PRIMARY KEY (`reference_number_automotive_parts`,`model_vehicles`),
  KEY `model_vehicles` (`model_vehicles`),
  CONSTRAINT `vehicles_automotive_parts_ibfk_1` FOREIGN KEY (`reference_number_automotive_parts`) REFERENCES `automotive_parts` (`reference_number`),
  CONSTRAINT `vehicles_automotive_parts_ibfk_2` FOREIGN KEY (`model_vehicles`) REFERENCES `vehicles` (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicles_automotive_parts`
--

LOCK TABLES `vehicles_automotive_parts` WRITE;
/*!40000 ALTER TABLE `vehicles_automotive_parts` DISABLE KEYS */;
INSERT INTO `vehicles_automotive_parts` VALUES ('67890','CT200h F-Sport 1.8 16V HIBRID Aut.'),('12345','Grand Cherokee Limited LX 5.9'),('54321','Grand Cherokee Limited LX 5.9'),('54321','Mystique GS 2.5 V6 Mec.'),('67890','Mystique GS 2.5 V6 Mec.');
/*!40000 ALTER TABLE `vehicles_automotive_parts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicles_customer`
--

DROP TABLE IF EXISTS `vehicles_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicles_customer` (
  `license_plate` varchar(50) NOT NULL,
  `cpf_customer_fk` varchar(50) NOT NULL,
  `model_vehicles_fk` varchar(50) NOT NULL,
  PRIMARY KEY (`license_plate`),
  KEY `cpf_customer_fk` (`cpf_customer_fk`),
  KEY `model_vehicles_fk` (`model_vehicles_fk`),
  CONSTRAINT `vehicles_customer_ibfk_1` FOREIGN KEY (`cpf_customer_fk`) REFERENCES `customers` (`cpf`),
  CONSTRAINT `vehicles_customer_ibfk_2` FOREIGN KEY (`model_vehicles_fk`) REFERENCES `vehicles` (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicles_customer`
--

LOCK TABLES `vehicles_customer` WRITE;
/*!40000 ALTER TABLE `vehicles_customer` DISABLE KEYS */;
INSERT INTO `vehicles_customer` VALUES ('HPP2304','11924265095','Mystique GS 2.5 V6 Mec.'),('LST5307','29012056071','CT200h F-Sport 1.8 16V HIBRID Aut.'),('MXQ9131','03966183080','Grand Cherokee Limited LX 5.9');
/*!40000 ALTER TABLE `vehicles_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `work_orders`
--

DROP TABLE IF EXISTS `work_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `work_orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `warranty` varchar(50) NOT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  `total` decimal(10,0) NOT NULL,
  `id_maintenance_fk` int NOT NULL,
  `status` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_maintenance_fk` (`id_maintenance_fk`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `work_orders`
--

LOCK TABLES `work_orders` WRITE;
/*!40000 ALTER TABLE `work_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `work_orders` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-10-27 20:08:47
