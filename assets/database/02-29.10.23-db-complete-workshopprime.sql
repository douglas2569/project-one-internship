-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Tempo de geração: 30-Out-2023 às 00:53
-- Versão do servidor: 8.0.31
-- versão do PHP: 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `workshopprime`
--

DELIMITER $$
--
-- Procedimentos
--
DROP PROCEDURE IF EXISTS `sp_delete_maintance`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_maintance` (`id_p` INT)   BEGIN   
    
    DECLARE track_no VARCHAR(10) DEFAULT '0/0';
    DECLARE EXIT HANDLER FOR SQLEXCEPTION, NOT FOUND, SQLWARNING
    
    BEGIN    
        GET DIAGNOSTICS CONDITION 1 @`errno` = MYSQL_ERRNO, @`sqlstate` = RETURNED_SQLSTATE, @`text` = MESSAGE_TEXT;
        SET @full_error = CONCAT('ERROR ', @`errno`, ' (', @`sqlstate`, '): ', @`text`);
        SELECT track_no, @full_error;

        ROLLBACK;    
    END;

    START TRANSACTION;
        SET track_no = '1/3'; 
        DELETE FROM services_provided WHERE id_p COLLATE utf8mb4_0900_ai_ci = services_provided.id_maintenance_fk;
   
        SET track_no = '2/3';
        DELETE FROM maintenance_inventory WHERE id_p COLLATE utf8mb4_0900_ai_ci = maintenance_inventory.id_maintenance;

        SET track_no = '3/3';
        DELETE FROM maintenance WHERE id_p COLLATE utf8mb4_0900_ai_ci = maintenance.id;
        
        SET track_no = '0/3';
        SELECT track_no, 'successfully executed.';
    COMMIT;

END$$

DROP PROCEDURE IF EXISTS `sp_delete_part_inventory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_part_inventory` (`reference_number_p` VARCHAR(255))   BEGIN   
    
    DECLARE track_no VARCHAR(10) DEFAULT '0/0';
    DECLARE EXIT HANDLER FOR SQLEXCEPTION, NOT FOUND, SQLWARNING
    
    BEGIN    
        GET DIAGNOSTICS CONDITION 1 @`errno` = MYSQL_ERRNO, @`sqlstate` = RETURNED_SQLSTATE, @`text` = MESSAGE_TEXT;
        SET @full_error = CONCAT('ERROR ', @`errno`, ' (', @`sqlstate`, '): ', @`text`);
        SELECT track_no, @full_error;

        ROLLBACK;    
    END;

    START TRANSACTION;
        SET track_no = '1/4'; 
        DELETE FROM vehicles_automotive_parts WHERE reference_number_p COLLATE utf8mb4_0900_ai_ci = vehicles_automotive_parts.reference_number_automotive_parts;

        SET track_no = '2/4'; 
        DELETE FROM maintenance_inventory WHERE reference_number_p COLLATE utf8mb4_0900_ai_ci = maintenance_inventory .reference_number;

        SET track_no = '3/4'; 
        DELETE FROM inventory WHERE reference_number_p COLLATE utf8mb4_0900_ai_ci = inventory.reference_number;
   
        SET track_no = '4/4';
        DELETE FROM automotive_parts WHERE reference_number_p COLLATE utf8mb4_0900_ai_ci = automotive_parts.reference_number;
        
        SET track_no = '0/2';
        SELECT track_no, 'successfully executed.';
    COMMIT;

END$$

DROP PROCEDURE IF EXISTS `sp_inventory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_inventory` (`image_address_P` VARCHAR(255), `reference_number_p` VARCHAR(255), `name_p` VARCHAR(50), `brand_p` VARCHAR(50), `description_p` TEXT, `unit_value_p` DECIMAL, `quantity_p` INT)   BEGIN    
    
    DECLARE track_no VARCHAR(10) DEFAULT '0/0';
    DECLARE EXIT HANDLER FOR SQLEXCEPTION, NOT FOUND, SQLWARNING
    
    BEGIN    
        GET DIAGNOSTICS CONDITION 1 @`errno` = MYSQL_ERRNO, @`sqlstate` = RETURNED_SQLSTATE, @`text` = MESSAGE_TEXT;
        SET @full_error = CONCAT('ERROR ', @`errno`, ' (', @`sqlstate`, '): ', @`text`);
        SELECT track_no, @full_error;

        ROLLBACK;    
    END;

    START TRANSACTION;
        SET track_no = '1/2'; 
        INSERT INTO automotive_parts(image_address, reference_number, name, brand, description, unit_value) 
        VALUES(image_address_p, reference_number_p, name_p, brand_p, description_p, unit_value_p);
        
        
        SET track_no = '2/2';
        INSERT INTO  inventory (reference_number, quantity) 
        VALUES(reference_number_p, quantity_p);
        
        SET track_no = '0/2';
        SELECT track_no, 'successfully executed.';
    COMMIT;

END$$

DROP PROCEDURE IF EXISTS `sp_update_inventory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_inventory` (`reference_number_old_p` VARCHAR(255), `image_address_P` VARCHAR(255), `reference_number_p` VARCHAR(255), `name_p` VARCHAR(50), `brand_p` VARCHAR(50), `description_p` TEXT, `unit_value_p` DECIMAL, `quantity_p` INT, `status_p` TINYINT)   BEGIN    
    DECLARE track_no VARCHAR(10) DEFAULT '0/0';
    DECLARE EXIT HANDLER FOR SQLEXCEPTION, NOT FOUND, SQLWARNING
    
    BEGIN    
        GET DIAGNOSTICS CONDITION 1 @`errno` = MYSQL_ERRNO, @`sqlstate` = RETURNED_SQLSTATE, @`text` = MESSAGE_TEXT;
        SET @full_error = CONCAT('ERROR ', @`errno`, ' (', @`sqlstate`, '): ', @`text`);
        SELECT track_no, @full_error;

        ROLLBACK;    
    END;

    START TRANSACTION;
        SET track_no = '1/2';
        UPDATE inventory SET quantity = quantity_p
        WHERE inventory.reference_number = reference_number_old_p COLLATE utf8mb4_0900_ai_ci;

        SET track_no = '2/2';
        UPDATE automotive_parts SET image_address = image_address_p, name = name_p, brand = brand_p, description = description_p, unit_value = unit_value_p, status = status_p 
        WHERE automotive_parts.reference_number = reference_number_old_p COLLATE utf8mb4_0900_ai_ci;

        SET track_no = '0/2';
        SELECT track_no, 'successfully executed.';
    COMMIT;

END$$

DROP PROCEDURE IF EXISTS `sp_vehicle_costumer`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_vehicle_costumer` (`cpf_p` VARCHAR(50), `name_p` VARCHAR(50), `address_p` VARCHAR(50), `phoneNumber_p` VARCHAR(50), `email_p` VARCHAR(50), `cnpjAutoVehicleWorkstops_p` VARCHAR(255), `license_plate_p` VARCHAR(50), `model_p` VARCHAR(50), `brand_p` VARCHAR(50))   BEGIN    
    DECLARE count_cpf INT DEFAULT 0;
	  DECLARE count_model INT DEFAULT 0;
    DECLARE track_no VARCHAR(10) DEFAULT '0/0';
    DECLARE EXIT HANDLER FOR SQLEXCEPTION, NOT FOUND, SQLWARNING
    
    BEGIN    
        GET DIAGNOSTICS CONDITION 1 @`errno` = MYSQL_ERRNO, @`sqlstate` = RETURNED_SQLSTATE, @`text` = MESSAGE_TEXT;
        SET @full_error = CONCAT('ERROR ', @`errno`, ' (', @`sqlstate`, '): ', @`text`);
        SELECT track_no, @full_error;

        ROLLBACK;    
    END;

    START TRANSACTION;
        SET track_no = '1/3'; 
        SELECT COUNT(cpf) INTO count_cpf FROM customers WHERE cpf_p COLLATE utf8mb4_0900_ai_ci = customers.cpf; 
        IF (count_cpf <= 0) THEN      
          INSERT INTO customers (cpf, name, address, phone_number, email, cnpj_auto_vehicle_workstops_fk) 
          VALUES(cpf_p, name_p, address_p, phoneNumber_p, email_p, cnpjAutoVehicleWorkstops_p);
        END IF;
              
        /* model_p COLLATE utf8mb4_0900_ai_ci --> aqui estou fazendo com que o valor da minha variavel tenha o msm  COLLATE da minha tabela, por consequencia dos meu campos, se eu nao forçar iss nao da certo */
        SET track_no = '2/3';  
        SELECT COUNT(model) INTO count_model FROM vehicles WHERE model_p COLLATE utf8mb4_0900_ai_ci = vehicles.model; 
        IF (count_model <= 0) THEN
        	INSERT INTO vehicles(model, brand ) 
        	VALUES(model_p, brand_p);
    	  END IF;
        
        SET track_no = '3/3';
        INSERT INTO vehicles_customer (license_plate, cpf_customer_fk, model_vehicles_fk ) 
        VALUES(license_plate_p, cpf_p, model_p);
        
        SET track_no = '0/3';
        SELECT track_no, 'successfully executed.';
    COMMIT;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `attendants`
--

DROP TABLE IF EXISTS `attendants`;
CREATE TABLE IF NOT EXISTS `attendants` (
  `cpf` varchar(50) NOT NULL,
  PRIMARY KEY (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `attendants`
--

INSERT INTO `attendants` (`cpf`) VALUES
('01069520055'),
('82178774083');

-- --------------------------------------------------------

--
-- Estrutura da tabela `automotive_parts`
--

DROP TABLE IF EXISTS `automotive_parts`;
CREATE TABLE IF NOT EXISTS `automotive_parts` (
  `reference_number` varchar(50) NOT NULL,
  `image_address` varchar(255) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `description` text,
  `unit_value` float DEFAULT NULL,
  `brand` varchar(50) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`reference_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `automotive_parts`
--

INSERT INTO `automotive_parts` (`reference_number`, `image_address`, `name`, `description`, `unit_value`, `brand`, `status`) VALUES
('sdfsd3453453', '', 'TESTE', '', 11, 'Plymouth', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `auto_vehicle_workshops`
--

DROP TABLE IF EXISTS `auto_vehicle_workshops`;
CREATE TABLE IF NOT EXISTS `auto_vehicle_workshops` (
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

--
-- Extraindo dados da tabela `auto_vehicle_workshops`
--

INSERT INTO `auto_vehicle_workshops` (`cnpj`, `name`, `business_name`, `address`, `phone_number`, `email`) VALUES
('01187817000183', 'Workshop Prime', 'Workshop Prime', 'Rua 24, n° 1234, Automóvel Central, Cidade dos Motores-CE, Brasil', '8587965433', 'workshopprime@gmail.com');

-- --------------------------------------------------------

--
-- Estrutura da tabela `customers`
--

DROP TABLE IF EXISTS `customers`;
CREATE TABLE IF NOT EXISTS `customers` (
  `cpf` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone_number` varchar(50) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `cnpj_auto_vehicle_workstops_fk` varchar(50) NOT NULL,
  PRIMARY KEY (`cpf`),
  UNIQUE KEY `phone_number` (`phone_number`),
  UNIQUE KEY `email` (`email`),
  KEY `cnpj_auto_vehicle_workstops_fk` (`cnpj_auto_vehicle_workstops_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `customers`
--

INSERT INTO `customers` (`cpf`, `name`, `address`, `phone_number`, `email`, `cnpj_auto_vehicle_workstops_fk`) VALUES
('03966183080', 'Juliano Pasquim', 'Rua T, n° 10,Chico da Doca, Cidade Paçoca-CE, Brasil', '8588873217', 'julianopasquim@outlook.com', '01187817000183'),
('09044491555', 'Varanda Baixa', 'Rua T, n° 33,Chico da Doca, Cidade Paçoca-CE, Bras', '8588873211', 'varanda@outlook.com', '01187817000183'),
('09048491045', 'Mario Coiso', 'Rua T, n° 33,Chico da Doca, Cidade Paçoca-CE, Bras', '8584473211', 'mariocoiso@outlook.com', '01187817000183'),
('09048491555', 'Mariana Alta', 'Rua T, n° 33,Chico da Doca, Cidade Paçoca-CE, Bras', '8584773211', 'mariana@outlook.com', '01187817000183'),
('11924265095', 'Ivan Nildo', 'Rua C, n° 11, Tata Tico, Cidade Pamanha-CE, Brasil', '8587779917', 'ivannildo@outlook.com', '01187817000183'),
('29012056071', 'Paula Abreu', 'Rua B, n° 10,Chico Tico, Cidade Paçoca-CE, Brasil', '8588879917', 'paulaabreu@outlook.com', '01187817000183'),
('77038134000', 'Carlos', '', '85999876544', 'carlos@gmail.com', '01187817000183'),
('77118134000', 'Maurissio de sousa', '', '85119876544', 'maurissio@gmail.com', '01187817000183'),
('85643380099', 'Julio Mautinho', 'Rua T, n° 33,Chico da Doca, Cidade Paçoca-CE, Bras', '8584473217', 'julio@outlook.com', '01187817000183');

-- --------------------------------------------------------

--
-- Estrutura da tabela `employees`
--

DROP TABLE IF EXISTS `employees`;
CREATE TABLE IF NOT EXISTS `employees` (
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
  KEY `cnpj_auto_vehicle_workshops_fk` (`cnpj_auto_vehicle_workshops_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `employees`
--

INSERT INTO `employees` (`cpf`, `name`, `address`, `phone_number`, `email`, `position`, `cnpj_auto_vehicle_workshops_fk`) VALUES
('01069520055', 'Leticia Juliana', 'Rua 64, n° 03, Parque Jardim, Cidade Media-CE, Brasil', '8590765833', 'leticiajuliana@gmail.com', 'atendente', '01187817000183'),
('31685403077', 'Antonio Ferreira', 'Rua Z, n° 98, Parque alvoras, Cidade Normal-CE, Brasil', '8597788833', 'antonioferreia@yahoo.com', 'mecânico', '01187817000183'),
('41740738055', 'João Juliano', 'Rua 64, n° 03, Parque Jardim, Cidade Media-CE, Brasil', '8590665833', 'joaojuliano@gmail.com', 'mecânico', '01187817000183'),
('46899032040', 'Pedro Gustavo', 'Rua A, n° 11, Parque Jardim, Cidade Media-CE, Brasil', '8597765833', 'pedrogustavo@gmail.com', 'mecânico', '01187817000183'),
('62565411030', 'Cassio Malvarisco', 'Rua F, n° 1634, Parque das flores, Cidade dos Altos-CE, Brasil', '8588965833', 'cassiomalvarisco@hotmail.com', 'gerente', '01187817000183'),
('82178774083', 'Angelo Tavares', 'Rua 22, n° 34, Bom Jardim, Cidade Baixa-CE, Brasil', '8599465833', 'angelotavares@outlook.com', 'atendente', '01187817000183');

-- --------------------------------------------------------

--
-- Estrutura da tabela `inventory`
--

DROP TABLE IF EXISTS `inventory`;
CREATE TABLE IF NOT EXISTS `inventory` (
  `reference_number` varchar(50) NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`reference_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `inventory`
--

INSERT INTO `inventory` (`reference_number`, `quantity`) VALUES
('sdfsd3453453', 2);

-- --------------------------------------------------------

--
-- Estrutura da tabela `maintenance`
--

DROP TABLE IF EXISTS `maintenance`;
CREATE TABLE IF NOT EXISTS `maintenance` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reason` varchar(50) NOT NULL,
  `description` text,
  `status` tinyint DEFAULT '0',
  `initialDate` datetime DEFAULT NULL,
  `finalDate` datetime DEFAULT NULL,
  `license_plate_vehicles_customer_fk` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `license_plate_vehicles_customer_fk` (`license_plate_vehicles_customer_fk`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `maintenance`
--

INSERT INTO `maintenance` (`id`, `reason`, `description`, `status`, `initialDate`, `finalDate`, `license_plate_vehicles_customer_fk`) VALUES
(36, 'Painel nao liga', 'Depois de cair agua nele', 0, NULL, NULL, 'LST5307'),
(37, 'Carro sem folego', 'Fica cansado rapido', 0, NULL, NULL, 'HPP2304'),
(38, 'Todo coisado', 'asdasdasdasdasdasd', 0, NULL, NULL, 'HPP2304'),
(39, 'muito brulho', '', 0, NULL, NULL, 'LST5307');

-- --------------------------------------------------------

--
-- Estrutura da tabela `maintenance_inventory`
--

DROP TABLE IF EXISTS `maintenance_inventory`;
CREATE TABLE IF NOT EXISTS `maintenance_inventory` (
  `reference_number` varchar(50) NOT NULL,
  `id_maintenance` int NOT NULL,
  PRIMARY KEY (`reference_number`,`id_maintenance`),
  KEY `id_maintenance` (`id_maintenance`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `manages`
--

DROP TABLE IF EXISTS `manages`;
CREATE TABLE IF NOT EXISTS `manages` (
  `cpf` varchar(50) NOT NULL,
  PRIMARY KEY (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `manages`
--

INSERT INTO `manages` (`cpf`) VALUES
('62565411030');

-- --------------------------------------------------------

--
-- Estrutura da tabela `mechanics`
--

DROP TABLE IF EXISTS `mechanics`;
CREATE TABLE IF NOT EXISTS `mechanics` (
  `cpf` varchar(50) NOT NULL,
  PRIMARY KEY (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `mechanics`
--

INSERT INTO `mechanics` (`cpf`) VALUES
('31685403077'),
('41740738055'),
('46899032040');

-- --------------------------------------------------------

--
-- Estrutura da tabela `services`
--

DROP TABLE IF EXISTS `services`;
CREATE TABLE IF NOT EXISTS `services` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` text,
  `estimatedTime` varchar(50) DEFAULT NULL,
  `cost` decimal(10,0) NOT NULL,
  `satus` tinyint(1) NOT NULL DEFAULT '1',
  `cnpj_auto_vehicle_workstops_fk` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `cnpj_auto_vehicle_workstops_fk` (`cnpj_auto_vehicle_workstops_fk`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `services`
--

INSERT INTO `services` (`id`, `name`, `description`, `estimatedTime`, `cost`, `satus`, `cnpj_auto_vehicle_workstops_fk`) VALUES
(35, 'Troca de vela de ingnição de carro', 'Pego a vela, tiro a antiga, coloco a nova', '10', '50', 1, '01187817000183'),
(36, 'Troca filtro de ar', 'Pego a filtro, tiro a antigo, coloco a novo', '30', '100', 1, '01187817000183');

-- --------------------------------------------------------

--
-- Estrutura da tabela `services_provided`
--

DROP TABLE IF EXISTS `services_provided`;
CREATE TABLE IF NOT EXISTS `services_provided` (
  `id` int NOT NULL AUTO_INCREMENT,
  `initial_date` datetime DEFAULT NULL,
  `final_date` datetime DEFAULT NULL,
  `id_maintenance_fk` int NOT NULL,
  `cpf_mechanics_fk` varchar(50) NOT NULL,
  `id_services_fk` int NOT NULL,
  `quantity_service` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `id_maintenance_fk` (`id_maintenance_fk`),
  KEY `cpf_mechanics_fk` (`cpf_mechanics_fk`),
  KEY `id_services_fk` (`id_services_fk`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `services_provided`
--

INSERT INTO `services_provided` (`id`, `initial_date`, `final_date`, `id_maintenance_fk`, `cpf_mechanics_fk`, `id_services_fk`, `quantity_service`) VALUES
(36, NULL, NULL, 36, '46899032040', 35, 1),
(37, NULL, NULL, 37, '31685403077', 36, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
CREATE TABLE IF NOT EXISTS `suppliers` (
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
  KEY `cnpj_auto_vehicle_workstops_fk` (`cnpj_auto_vehicle_workstops_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `suppliers`
--

INSERT INTO `suppliers` (`cnpj`, `name`, `business_name`, `address`, `phone_number`, `email`, `brachActivity`, `cnpj_auto_vehicle_workstops_fk`) VALUES
('12557378000170', 'Pirelli', 'Pirelli Pneus Ltda', 'Rua P, n° 11, Maga, Cidade Pacajus-CE, Brasil', '8588006544', 'pirelli@yempresa.com', 'fabricante de pneus automotivos', '01187817000183'),
('60655945000173', 'Bosch', 'Robert Bosch Ltda', 'Rua W, n° 98, Parque Tocas, Cidade Normal-CE, Brasil', '8588873266', 'bosch@yahoo.com', 'Fabricante de equipamentos automotivos e peças', '01187817000183'),
('82804111000115', '3M', '3M do Brasil Ltda', 'Rua Y, n° 55, Sola Aí, Cidade Fortaleza-CE, Brasil', '8588776544', '3M@yempresa.com', 'ornecedora de produtos automotivos, como lixas, adesivos e polidores', '01187817000183');

-- --------------------------------------------------------

--
-- Estrutura da tabela `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `cpf` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `status` tinyint UNSIGNED NOT NULL DEFAULT '1',
  PRIMARY KEY (`cpf`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `users`
--

INSERT INTO `users` (`cpf`, `username`, `password`, `status`) VALUES
('01069520055', 'leticia66', '$2y$10$.0URBGQDyTW77ezc/iy.FOD9zVODmuQIE0HuRSeW9cocuEso3Uzye', 1),
('31685403077', 'antonioo01', '$2y$10$.0URBGQDyTW77ezc/iy.FOD9zVODmuQIE0HuRSeW9cocuEso3Uzye', 1),
('41740738055', 'joao01', '$2y$10$.0URBGQDyTW77ezc/iy.FOD9zVODmuQIE0HuRSeW9cocuEso3Uzye', 1),
('46899032040', 'pedro01', '$2y$10$.0URBGQDyTW77ezc/iy.FOD9zVODmuQIE0HuRSeW9cocuEso3Uzye', 1),
('62565411030', 'cassio00', '$2y$10$.0URBGQDyTW77ezc/iy.FOD9zVODmuQIE0HuRSeW9cocuEso3Uzye', 1),
('82178774083', 'angelo24', '$2y$10$.0URBGQDyTW77ezc/iy.FOD9zVODmuQIE0HuRSeW9cocuEso3Uzye', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `vehicles`
--

DROP TABLE IF EXISTS `vehicles`;
CREATE TABLE IF NOT EXISTS `vehicles` (
  `model` varchar(50) NOT NULL,
  `brand` varchar(50) NOT NULL,
  PRIMARY KEY (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `vehicles`
--

INSERT INTO `vehicles` (`model`, `brand`) VALUES
('Chairman 3.2 V6 220cv Aut.', 'SSANGYONG'),
('CT200h F-Sport 1.8 16V HIBRID Aut.', 'Lexus'),
('Gran Voyager LE 2.5', 'Plymouth'),
('Grand Cherokee Limited LX 5.9', 'Jeep'),
('Mystique GS 2.5 V6 Mec.', 'Mercury'),
('Ranger Splash CE', 'Ford'),
('Ranger XLS 3.0 PSE 163cv 4x2 CD TB Dies', 'Ford'),
('Sorento 3.5 V6 24V 278cv 4x2 Aut.', 'Kia Motors');

-- --------------------------------------------------------

--
-- Estrutura da tabela `vehicles_automotive_parts`
--

DROP TABLE IF EXISTS `vehicles_automotive_parts`;
CREATE TABLE IF NOT EXISTS `vehicles_automotive_parts` (
  `reference_number_automotive_parts` varchar(50) NOT NULL,
  `model_vehicles` varchar(50) NOT NULL,
  PRIMARY KEY (`reference_number_automotive_parts`,`model_vehicles`),
  KEY `model_vehicles` (`model_vehicles`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `vehicles_customer`
--

DROP TABLE IF EXISTS `vehicles_customer`;
CREATE TABLE IF NOT EXISTS `vehicles_customer` (
  `license_plate` varchar(50) NOT NULL,
  `cpf_customer_fk` varchar(50) NOT NULL,
  `model_vehicles_fk` varchar(50) NOT NULL,
  PRIMARY KEY (`license_plate`),
  KEY `cpf_customer_fk` (`cpf_customer_fk`),
  KEY `model_vehicles_fk` (`model_vehicles_fk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `vehicles_customer`
--

INSERT INTO `vehicles_customer` (`license_plate`, `cpf_customer_fk`, `model_vehicles_fk`) VALUES
('HPP2304', '11924265095', 'Mystique GS 2.5 V6 Mec.'),
('JJB1269', '77038134000', 'Gran Voyager LE 2.5'),
('JKB1116', '09044491555', 'Sorento 3.5 V6 24V 278cv 4x2 Aut.'),
('LRR3766', '09048491045', 'Chairman 3.2 V6 220cv Aut.'),
('LST5307', '29012056071', 'CT200h F-Sport 1.8 16V HIBRID Aut.'),
('MUC4384', '77118134000', 'Ranger Splash CE'),
('MUC4388', '77118134000', 'Ranger Splash CE'),
('MXQ9131', '03966183080', 'Grand Cherokee Limited LX 5.9'),
('NAY5700', '85643380099', 'Ranger XLS 3.0 PSE 163cv 4x2 CD TB Dies');

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `v_inventory`
-- (Veja abaixo para a view atual)
--
DROP VIEW IF EXISTS `v_inventory`;
CREATE TABLE IF NOT EXISTS `v_inventory` (
`reference_number` varchar(50)
,`image_address` varchar(255)
,`name` varchar(50)
,`quantity` int
,`brand` varchar(50)
,`unit_value` float
,`description` text
,`status` tinyint(1)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `v_users`
-- (Veja abaixo para a view atual)
--
DROP VIEW IF EXISTS `v_users`;
CREATE TABLE IF NOT EXISTS `v_users` (
`cpf` varchar(50)
,`username` varchar(50)
,`password` varchar(255)
,`name` varchar(50)
,`position` varchar(255)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `v_vehicles`
-- (Veja abaixo para a view atual)
--
DROP VIEW IF EXISTS `v_vehicles`;
CREATE TABLE IF NOT EXISTS `v_vehicles` (
`cpf` varchar(50)
,`name` varchar(50)
,`address` varchar(255)
,`phone_number` varchar(50)
,`email` varchar(255)
,`model_vehicles_fk` varchar(50)
,`license_plate` varchar(50)
,`brand` varchar(50)
);

-- --------------------------------------------------------

--
-- Estrutura da tabela `work_orders`
--

DROP TABLE IF EXISTS `work_orders`;
CREATE TABLE IF NOT EXISTS `work_orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `warranty` varchar(50) NOT NULL,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  `total` decimal(10,0) NOT NULL,
  `id_maintenance_fk` int NOT NULL,
  `status` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_maintenance_fk` (`id_maintenance_fk`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estrutura para vista `v_inventory`
--
DROP TABLE IF EXISTS `v_inventory`;

DROP VIEW IF EXISTS `v_inventory`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_inventory`  AS SELECT `automotive_parts`.`reference_number` AS `reference_number`, `automotive_parts`.`image_address` AS `image_address`, `automotive_parts`.`name` AS `name`, `inventory`.`quantity` AS `quantity`, `automotive_parts`.`brand` AS `brand`, `automotive_parts`.`unit_value` AS `unit_value`, `automotive_parts`.`description` AS `description`, `automotive_parts`.`status` AS `status` FROM (`automotive_parts` join `inventory` on((`automotive_parts`.`reference_number` = `inventory`.`reference_number`))) WHERE (`automotive_parts`.`status` = '1')  ;

-- --------------------------------------------------------

--
-- Estrutura para vista `v_users`
--
DROP TABLE IF EXISTS `v_users`;

DROP VIEW IF EXISTS `v_users`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_users`  AS SELECT `users`.`cpf` AS `cpf`, `users`.`username` AS `username`, `users`.`password` AS `password`, `employees`.`name` AS `name`, `employees`.`position` AS `position` FROM (`users` join `employees` on((`users`.`cpf` = `employees`.`cpf`)))  ;

-- --------------------------------------------------------

--
-- Estrutura para vista `v_vehicles`
--
DROP TABLE IF EXISTS `v_vehicles`;

DROP VIEW IF EXISTS `v_vehicles`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_vehicles`  AS SELECT `customers`.`cpf` AS `cpf`, `customers`.`name` AS `name`, `customers`.`address` AS `address`, `customers`.`phone_number` AS `phone_number`, `customers`.`email` AS `email`, `vehicles_customer`.`model_vehicles_fk` AS `model_vehicles_fk`, `vehicles_customer`.`license_plate` AS `license_plate`, `vehicles`.`brand` AS `brand` FROM ((`vehicles_customer` join `vehicles` on((`vehicles_customer`.`model_vehicles_fk` = `vehicles`.`model`))) join `customers` on((`customers`.`cpf` = `vehicles_customer`.`cpf_customer_fk`)))  ;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `attendants`
--
ALTER TABLE `attendants`
  ADD CONSTRAINT `attendants_ibfk_1` FOREIGN KEY (`cpf`) REFERENCES `employees` (`cpf`);

--
-- Limitadores para a tabela `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`cnpj_auto_vehicle_workstops_fk`) REFERENCES `auto_vehicle_workshops` (`cnpj`);

--
-- Limitadores para a tabela `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`cnpj_auto_vehicle_workshops_fk`) REFERENCES `auto_vehicle_workshops` (`cnpj`);

--
-- Limitadores para a tabela `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`reference_number`) REFERENCES `automotive_parts` (`reference_number`);

--
-- Limitadores para a tabela `maintenance`
--
ALTER TABLE `maintenance`
  ADD CONSTRAINT `maintenance_ibfk_1` FOREIGN KEY (`license_plate_vehicles_customer_fk`) REFERENCES `vehicles_customer` (`license_plate`);

--
-- Limitadores para a tabela `maintenance_inventory`
--
ALTER TABLE `maintenance_inventory`
  ADD CONSTRAINT `maintenance_inventory_ibfk_1` FOREIGN KEY (`reference_number`) REFERENCES `automotive_parts` (`reference_number`),
  ADD CONSTRAINT `maintenance_inventory_ibfk_2` FOREIGN KEY (`id_maintenance`) REFERENCES `maintenance` (`id`);

--
-- Limitadores para a tabela `manages`
--
ALTER TABLE `manages`
  ADD CONSTRAINT `manages_ibfk_1` FOREIGN KEY (`cpf`) REFERENCES `employees` (`cpf`);

--
-- Limitadores para a tabela `mechanics`
--
ALTER TABLE `mechanics`
  ADD CONSTRAINT `mechanics_ibfk_1` FOREIGN KEY (`cpf`) REFERENCES `employees` (`cpf`);

--
-- Limitadores para a tabela `services`
--
ALTER TABLE `services`
  ADD CONSTRAINT `services_ibfk_1` FOREIGN KEY (`cnpj_auto_vehicle_workstops_fk`) REFERENCES `auto_vehicle_workshops` (`cnpj`);

--
-- Limitadores para a tabela `services_provided`
--
ALTER TABLE `services_provided`
  ADD CONSTRAINT `services_provided_ibfk_1` FOREIGN KEY (`id_maintenance_fk`) REFERENCES `maintenance` (`id`),
  ADD CONSTRAINT `services_provided_ibfk_2` FOREIGN KEY (`cpf_mechanics_fk`) REFERENCES `mechanics` (`cpf`),
  ADD CONSTRAINT `services_provided_ibfk_3` FOREIGN KEY (`id_services_fk`) REFERENCES `services` (`id`);

--
-- Limitadores para a tabela `suppliers`
--
ALTER TABLE `suppliers`
  ADD CONSTRAINT `suppliers_ibfk_1` FOREIGN KEY (`cnpj_auto_vehicle_workstops_fk`) REFERENCES `auto_vehicle_workshops` (`cnpj`);

--
-- Limitadores para a tabela `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`cpf`) REFERENCES `employees` (`cpf`);

--
-- Limitadores para a tabela `vehicles_automotive_parts`
--
ALTER TABLE `vehicles_automotive_parts`
  ADD CONSTRAINT `vehicles_automotive_parts_ibfk_1` FOREIGN KEY (`reference_number_automotive_parts`) REFERENCES `automotive_parts` (`reference_number`),
  ADD CONSTRAINT `vehicles_automotive_parts_ibfk_2` FOREIGN KEY (`model_vehicles`) REFERENCES `vehicles` (`model`);

--
-- Limitadores para a tabela `vehicles_customer`
--
ALTER TABLE `vehicles_customer`
  ADD CONSTRAINT `vehicles_customer_ibfk_1` FOREIGN KEY (`cpf_customer_fk`) REFERENCES `customers` (`cpf`),
  ADD CONSTRAINT `vehicles_customer_ibfk_2` FOREIGN KEY (`model_vehicles_fk`) REFERENCES `vehicles` (`model`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
