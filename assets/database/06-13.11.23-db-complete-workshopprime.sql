-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Tempo de geração: 13-Nov-2023 às 14:40
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
CREATE DATABASE IF NOT EXISTS `workshopprime` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `workshopprime`;

DELIMITER $$
--
-- Procedimentos
--
DROP PROCEDURE IF EXISTS `sp_delete_employee`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_employee` (`id_p` INT)   BEGIN   
    
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
        DELETE FROM users WHERE employees_id = id_p COLLATE utf8mb4_0900_ai_ci;
   
        SET track_no = '2/2';
        DELETE FROM employees  WHERE id = id_p COLLATE utf8mb4_0900_ai_ci;
        
        SET track_no = '0/2';
        SET @full_error = 'successfully executed.';
        SELECT track_no, @full_error;
    COMMIT;

END$$

DROP PROCEDURE IF EXISTS `sp_delete_maintenance`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_maintenance` (`id_p` INT)   BEGIN   
    
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
        DELETE FROM services_provided WHERE id_p COLLATE utf8mb4_0900_ai_ci  = services_provided.maintenance_id;
   
        SET track_no = '2/3';
        DELETE FROM maintenance_inventory WHERE id_p COLLATE utf8mb4_0900_ai_ci  = maintenance_inventory.maintenance_id;

        SET track_no = '3/3';
        DELETE FROM maintenance WHERE id_p COLLATE utf8mb4_0900_ai_ci  = maintenance.id;
        
        SET track_no = '0/3';
        SET @full_error = 'successfully executed.';
        SELECT track_no, @full_error;
    COMMIT;

END$$

DROP PROCEDURE IF EXISTS `sp_delete_maintenance_inventory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_maintenance_inventory` (`automotive_parts_id_p` INT, `reference_number_p` VARCHAR(50), `quantity_p` VARCHAR(50))   BEGIN    
    DECLARE inventory_quantity INT DEFAULT 0;
    DECLARE newQuantity INT DEFAULT 0;
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
        SET track_no = '1/2'; 
        SELECT quantity INTO inventory_quantity FROM inventory WHERE reference_number_p COLLATE utf8mb4_general_ci  = inventory.reference_number; 
        
        SET newQuantity = inventory_quantity + quantity_p; 
        SET track_no = '2/2';
        UPDATE inventory SET quantity = newQuantity WHERE inventory.reference_number = reference_number_p COLLATE utf8mb4_general_ci;

        DELETE FROM maintenance_inventory WHERE maintenance_inventory.automotive_parts_id = automotive_parts_id_p COLLATE utf8mb4_general_ci;
        
        SET track_no = '0/2';
        SET @full_error = 'successfully executed.';
        SELECT track_no,@full_error;
    COMMIT;

END$$

DROP PROCEDURE IF EXISTS `sp_delete_part_inventory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_part_inventory` (`reference_number_p` VARCHAR(255), `automotive_parts_id_p` INT)   BEGIN   
    
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
        DELETE FROM vehicles_automotive_parts WHERE automotive_parts_id =  automotive_parts_id_p COLLATE utf8mb4_general_ci;

        SET track_no = '2/4'; 
        DELETE FROM maintenance_inventory WHERE automotive_parts_id = automotive_parts_id_p COLLATE utf8mb4_general_ci;

        SET track_no = '3/4'; 
        DELETE FROM inventory WHERE reference_number = reference_number_p COLLATE utf8mb4_general_ci ;
   
        SET track_no = '4/4';
        DELETE FROM automotive_parts WHERE reference_number = reference_number_p COLLATE utf8mb4_general_ci ;
        
        SET track_no = '0/4';
        SET @full_error = 'successfully executed.';
        SELECT track_no, @full_error;
    COMMIT;

END$$

DROP PROCEDURE IF EXISTS `sp_register_inventory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_register_inventory` (`image_address_P` VARCHAR(255), `reference_number_p` VARCHAR(255), `name_p` VARCHAR(50), `brand_p` VARCHAR(50), `description_p` TEXT, `unit_value_p` DECIMAL, `quantity_p` INT)   BEGIN    
    
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
        SET @full_error = 'successfully executed.';
        SELECT track_no, @full_error;
    COMMIT;

END$$

DROP PROCEDURE IF EXISTS `sp_register_maintenance_inventory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_register_maintenance_inventory` (`automotive_parts_Id_p` INT, `reference_number_p` VARCHAR(100), `maintenance_id_p` INT, `inventory_quantity_p` INT, `maintenance_inventory_quantity_p` INT)   BEGIN    
    
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
        UPDATE  inventory SET quantity = inventory_quantity_p 
        WHERE inventory.reference_number = reference_number_p COLLATE utf8mb4_unicode_ci;

        SET track_no = '2/2'; 
        INSERT INTO maintenance_inventory (automotive_parts_Id, maintenance_id, quantity) 
        VALUES(automotive_parts_Id_p, maintenance_id_p, maintenance_inventory_quantity_p);        
        
        
        SET track_no = '0/2';
        SET @full_error = 'successfully executed.';
        SELECT track_no, @full_error;
    COMMIT;

END$$

DROP PROCEDURE IF EXISTS `sp_register_vehicle_costumer`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_register_vehicle_costumer` (`cpf_p` VARCHAR(50), `name_p` VARCHAR(50), `address_p` VARCHAR(50), `phoneNumber_p` VARCHAR(50), `email_p` VARCHAR(50), `autoVehicleWorkstops_id_p` INT, `license_plate_p` VARCHAR(50), `model_p` VARCHAR(50), `brand_p` VARCHAR(50))   BEGIN    
    DECLARE count_cpf INT DEFAULT 0;
	  DECLARE count_model INT DEFAULT 0;
    DECLARE customers_id INT DEFAULT 0;
    DECLARE vehicles_id INT DEFAULT 0;
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
        SELECT COUNT(cpf) INTO count_cpf FROM customers WHERE cpf_p COLLATE utf8mb4_general_ci  = customers.cpf; 
        IF (count_cpf <= 0) THEN      
          INSERT INTO customers (cpf, name, address, phone_number, email, auto_vehicle_workstops_id) 
          VALUES(cpf_p, name_p, address_p, phoneNumber_p, email_p, autoVehicleWorkstops_id_p);
          SELECT customers.id INTO customers_id FROM customers  ORDER BY id DESC LIMIT 1;
        ELSE
           SELECT customers.id INTO customers_id FROM customers WHERE cpf_p COLLATE utf8mb4_general_ci  = customers.cpf;
        END IF;
        
        SET track_no = '2/3';  
        SELECT COUNT(model) INTO count_model FROM vehicles WHERE model_p COLLATE utf8mb4_general_ci  = vehicles.model; 
        IF (count_model <= 0) THEN
        	INSERT INTO vehicles(model, brand ) VALUES(model_p, brand_p);
          SELECT MAX(vehicles.id) INTO vehicles_id FROM vehicles;
        ELSE
           SELECT vehicles.id INTO vehicles_id FROM vehicles WHERE model_p COLLATE utf8mb4_general_ci  = vehicles.model;
    	  END IF;
        
        SET track_no = '3/3';

        INSERT INTO vehicles_customer (license_plate, customers_id, vehicles_id ) 
        VALUES(license_plate_p, customers_id, vehicles_id);
        
        SET track_no = '0/3';
        SET @full_error = 'successfully executed.';
        SELECT track_no,@full_error;
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
        WHERE inventory.reference_number = reference_number_old_p COLLATE utf8mb4_general_ci ;

        SET track_no = '2/2';
        UPDATE automotive_parts SET image_address = image_address_p, name = name_p, brand = brand_p, description = description_p, unit_value = unit_value_p, status = status_p, reference_number  = reference_number_p
        WHERE automotive_parts.reference_number = reference_number_old_p COLLATE utf8mb4_general_ci ;

        SET track_no = '0/2';
        SET @full_error = 'successfully executed.';
        SELECT track_no, @full_error;
    COMMIT;

END$$

DROP PROCEDURE IF EXISTS `sp_update_maintenance_inventory_inventory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_maintenance_inventory_inventory` (`maintenance_id_p` INT, `automotive_parts_id_p` INT, `reference_number_p` VARCHAR(50), `quantity_maintenance_inventory_p` INT, `quantity_inventory_p` INT)   BEGIN    
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
        UPDATE inventory 
        SET 
        quantity 	= quantity_inventory_p
        WHERE inventory.reference_number = reference_number_p COLLATE utf8mb4_general_ci;

        SET track_no = '2/2';
        UPDATE maintenance_inventory 
        SET         
        quantity = quantity_maintenance_inventory_p
        WHERE maintenance_inventory.automotive_parts_id = automotive_parts_id_p COLLATE utf8mb4_general_ci 
        AND
        maintenance_inventory.maintenance_id = maintenance_id_p COLLATE utf8mb4_general_ci;

        SET track_no = '0/2';
        SET @full_error = 'successfully executed.';
        SELECT track_no, @full_error;
    COMMIT;

END$$

DROP PROCEDURE IF EXISTS `sp_update_vehicles_customer`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_vehicles_customer` (`cpf_new_p` VARCHAR(50), `cpf_old_p` VARCHAR(50), `name_p` VARCHAR(50), `address_p` VARCHAR(255), `phone_number_p` VARCHAR(50), `email_p` VARCHAR(50), `license_plate_old_p` VARCHAR(50), `license_plate_new_p` VARCHAR(50))   BEGIN    
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
        UPDATE customers 
        SET         
        name = name_p,
        address = address_p,
        cpf = cpf_new_p,
        phone_number = phone_number_p,
        email = email_p

        WHERE customers.cpf = cpf_old_p COLLATE utf8mb4_general_ci;

        SET track_no = '2/2';
        UPDATE vehicles_customer 
        SET 
        license_plate = license_plate_new_p

        WHERE vehicles_customer.license_plate = license_plate_old_p COLLATE utf8mb4_general_ci;

        SET track_no = '0/2';
        SET @full_error = 'successfully executed.';
        SELECT track_no, @full_error;
    COMMIT;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `automotive_parts`
--

DROP TABLE IF EXISTS `automotive_parts`;
CREATE TABLE IF NOT EXISTS `automotive_parts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `image_address` varchar(255) DEFAULT NULL,
  `reference_number` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text,
  `unit_value` float NOT NULL,
  `brand` varchar(50) NOT NULL,
  `status` tinyint DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `reference_number` (`reference_number`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `automotive_parts`
--

INSERT INTO `automotive_parts` (`id`, `image_address`, `reference_number`, `name`, `description`, `unit_value`, `brand`, `status`) VALUES
(1, NULL, '12345', 'Filtro de Óleo', 'Este filtro de óleo Fram possui uma classificação de eficiência de filtração de 98%, com uma capacidade de retenção de partículas de até 10 micra, protegendo o motor contra desgaste prematuro.', 15, 'Fram', 1),
(2, NULL, '67890', 'Pastilhas de Freio', 'Pastilhas de freio Brembo são componentes do sistema de freio que fornecem frenagem segura e eficaz.', 50, 'Brembo', 1),
(3, NULL, '54321', 'Bateria de Carro', 'A bateria AC Delco é uma bateria de chumbo-ácido de 12 volts, com uma capacidade nominal de 60 ampères-hora (Ah) e uma resistência INTerna baixa, fornecendo uma corrente de partida confiável', 150, 'AC Delco', 1),
(4, NULL, '98765', 'Filtro de Ar', 'O filtro de ar K&N é um filtro de alto fluxo, projetado para aumentar a capacidade de fluxo de ar em até 50%, mantendo uma eficiência de filtração de 99%, com uma capacidade de retenção de partículas de até 2 micra.', 20, 'NGK', 1),
(5, NULL, '23456', 'Vela de Ignição', 'As velas de ignição NGK são fabricadas com eletrodos de níquel-cromo e possuem uma faixa térmica de calor médio, garantindo ignição precisa e confiável em uma ampla gama de temperaturas e condições.', 90, 'K&N', 1),
(6, NULL, 'M78901', 'Corrente de Transmissão', 'A corrente de transmissão DID é uma corrente de rolos selada com uma classificação de resistência à tração de 8.000 libras, projetada para transmitir potência eficientemente com uma vida útil prolongada.', 300, 'DID', 1),
(7, NULL, 'M23456', 'Disco de Freio', 'Os discos de freio EBC são feitos de aço inoxidável endurecido e possuem ranhuras para dissipação de calor, proporcionando um desempenho de frenagem consistente e eficiente.', 200, 'EBC', 1),
(8, NULL, 'M65432', 'Vela de Ignição', 'As velas de ignição Denso são feitas de cerâmica isolante e possuem uma resistência de 0,8 ohms, garantindo ignição eficaz e redução do consumo de combustível.', 10, 'Denso', 1),
(9, NULL, 'M12345', 'Filtro de Ar', 'Os filtros de ar K&N possuem uma capacidade de fluxo de ar de 1.000 CFM (pés cúbicos por minuto) a uma restrição de 1 polegada de água, proporcionando um aumento significativo no fluxo de ar.', 80, 'K&N', 1),
(10, NULL, 'M87654', 'Pneu Traseiro', 'O pneu traseiro Michelin possui uma construção radial com uma classificação de velocidade de até 180 km/h, oferecendo aderência excepcional em uma variedade de condições de pilotagem.', 50, 'Michelin', 1),
(11, '', '1111111111110', 'Flanela de Nilons', '', 6, 'Rover', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `auto_vehicle_workshops`
--

DROP TABLE IF EXISTS `auto_vehicle_workshops`;
CREATE TABLE IF NOT EXISTS `auto_vehicle_workshops` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cnpj` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `business_name` varchar(50) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone_number` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cnpj` (`cnpj`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `business_name` (`business_name`),
  UNIQUE KEY `phone_number` (`phone_number`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `auto_vehicle_workshops`
--

INSERT INTO `auto_vehicle_workshops` (`id`, `cnpj`, `name`, `business_name`, `address`, `phone_number`, `email`) VALUES
(1, '01187817000183', 'Workshop Prime', 'Workshop Prime', 'Rua 24, n° 1234, Automóvel Central, Cidade dos Motores-CE, Brasil', '8587965433', 'workshopprime@gmail.com');

-- --------------------------------------------------------

--
-- Estrutura da tabela `customers`
--

DROP TABLE IF EXISTS `customers`;
CREATE TABLE IF NOT EXISTS `customers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cpf` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone_number` varchar(50) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `auto_vehicle_workstops_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cpf` (`cpf`),
  UNIQUE KEY `phone_number` (`phone_number`),
  UNIQUE KEY `email` (`email`),
  KEY `auto_vehicle_workstops_id` (`auto_vehicle_workstops_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `customers`
--

INSERT INTO `customers` (`id`, `cpf`, `name`, `address`, `phone_number`, `email`, `auto_vehicle_workstops_id`) VALUES
(1, '03966183080', 'Juliano Pasquims', 'Rua T, n° 10,Chico da Doca, Cidade Paçoca-CE, Brasil', '8588873217', 'julianopasquim@outlook.com', 1),
(2, '29012056071', 'Paula Abreu', 'Rua B, n° 10,Chico Tico, Cidade Paçoca-CE, Brasil', '8588879917', 'paulaabreu@outlook.com', 1),
(3, '11924265095', 'Ivan Nildo', 'Rua C, n° 11, Tata Tico, Cidade Pamanha-CE, Brasil', '8587779917', 'ivannildo@outlook.com', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `employees`
--

DROP TABLE IF EXISTS `employees`;
CREATE TABLE IF NOT EXISTS `employees` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cpf` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone_number` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `auto_vehicle_workshops_id` int NOT NULL,
  `positions_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cpf` (`cpf`),
  UNIQUE KEY `phone_number` (`phone_number`),
  UNIQUE KEY `email` (`email`),
  KEY `positions_id` (`positions_id`),
  KEY `auto_vehicle_workshops_id` (`auto_vehicle_workshops_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `employees`
--

INSERT INTO `employees` (`id`, `cpf`, `name`, `address`, `phone_number`, `email`, `auto_vehicle_workshops_id`, `positions_id`) VALUES
(1, '62565411030', 'Cassio Malvarisco', 'Rua F, n° 1634, Parque das flores, Cidade dos Altos-CE, Brasil', '8588965833', 'cassiomalvarisco@hotmail.com', 1, 3),
(2, '82178774083', 'Angelo Tavares', 'Rua 22, n° 34, Bom Jardim, Cidade Baixa-CE, Brasil', '8599465833', 'angelotavares@outlook.com', 1, 1),
(3, '01069520055', 'Leticia Juliana', 'Rua 64, n° 03, Parque Jardim, Cidade Media-CE, Brasil', '8590765833', 'leticiajuliana@gmail.com', 1, 1),
(4, '41740738055', 'João Juliano', 'Rua 64, n° 03, Parque Jardim, Cidade Media-CE, Brasil', '8590665833', 'joaojuliano@gmail.com', 1, 2),
(5, '46899032040', 'Pedro Gustavo', 'Rua A, n° 11, Parque Jardim, Cidade Media-CE, Brasil', '8597765833', 'pedrogustavo@gmail.com', 1, 2),
(6, '31685403077', 'Antonio Ferreiras', 'Rua Z, n° 98, Parque alvoras, Cidade Normal-CE, Brasil', '8597788833', 'antonioferreia@yahoo.com', 1, 1),
(7, '00000000000', 'Root', NULL, '00000000000', '', 1, 4);

-- --------------------------------------------------------

--
-- Estrutura da tabela `features`
--

DROP TABLE IF EXISTS `features`;
CREATE TABLE IF NOT EXISTS `features` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `features`
--

INSERT INTO `features` (`id`, `name`) VALUES
(9, 'employees'),
(1, 'inventory'),
(2, 'maintenance'),
(7, 'permissions_features'),
(3, 'services'),
(6, 'services_provided'),
(4, 'users'),
(5, 'vehicles_customer'),
(8, 'work_on_maintaining');

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
('1111111111110', 4);

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
  `initial_date` datetime DEFAULT NULL,
  `final_date` datetime DEFAULT NULL,
  `vehicles_customer_license_plate` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `vehicles_customer_license_plate` (`vehicles_customer_license_plate`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `maintenance`
--

INSERT INTO `maintenance` (`id`, `reason`, `description`, `status`, `initial_date`, `final_date`, `vehicles_customer_license_plate`) VALUES
(1, 'Carro não liga', 'Quando giro a chave ele faz tantaaaatanes', 0, NULL, NULL, 'IAK7872');

-- --------------------------------------------------------

--
-- Estrutura da tabela `maintenance_inventory`
--

DROP TABLE IF EXISTS `maintenance_inventory`;
CREATE TABLE IF NOT EXISTS `maintenance_inventory` (
  `automotive_parts_id` int NOT NULL,
  `maintenance_id` int NOT NULL,
  `quantity` int DEFAULT '1',
  PRIMARY KEY (`automotive_parts_id`,`maintenance_id`),
  KEY `maintenance_id` (`maintenance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `maintenance_inventory`
--

INSERT INTO `maintenance_inventory` (`automotive_parts_id`, `maintenance_id`, `quantity`) VALUES
(11, 1, 2);

-- --------------------------------------------------------

--
-- Estrutura da tabela `permissions`
--

DROP TABLE IF EXISTS `permissions`;
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `create` tinyint DEFAULT '0',
  `read` tinyint DEFAULT '0',
  `update` tinyint DEFAULT '0',
  `delete` tinyint DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `permissions`
--

INSERT INTO `permissions` (`id`, `create`, `read`, `update`, `delete`) VALUES
(1, 0, 0, 0, 0),
(2, 1, 1, 1, 1),
(3, 0, 1, 0, 0),
(4, 1, 1, 0, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `permissions_features`
--

DROP TABLE IF EXISTS `permissions_features`;
CREATE TABLE IF NOT EXISTS `permissions_features` (
  `positions_id` int NOT NULL,
  `features_id` int NOT NULL,
  `permissions_id` int NOT NULL,
  PRIMARY KEY (`positions_id`,`features_id`,`permissions_id`),
  KEY `features_id` (`features_id`),
  KEY `permissions_id` (`permissions_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `permissions_features`
--

INSERT INTO `permissions_features` (`positions_id`, `features_id`, `permissions_id`) VALUES
(1, 1, 3),
(2, 1, 3),
(3, 1, 2),
(4, 1, 2),
(1, 2, 2),
(2, 2, 3),
(3, 2, 3),
(4, 2, 2),
(1, 3, 3),
(2, 3, 3),
(3, 3, 2),
(4, 3, 2),
(1, 4, 1),
(2, 4, 1),
(3, 4, 2),
(4, 4, 2),
(1, 5, 2),
(2, 5, 1),
(3, 5, 3),
(4, 5, 2),
(1, 6, 1),
(2, 6, 2),
(3, 6, 3),
(4, 6, 2),
(1, 7, 1),
(2, 7, 1),
(3, 7, 2),
(4, 7, 2),
(1, 8, 3),
(2, 8, 2),
(3, 8, 3),
(4, 8, 2),
(1, 9, 1),
(2, 9, 1),
(3, 9, 2),
(4, 9, 2);

-- --------------------------------------------------------

--
-- Estrutura da tabela `positions`
--

DROP TABLE IF EXISTS `positions`;
CREATE TABLE IF NOT EXISTS `positions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `positions`
--

INSERT INTO `positions` (`id`, `name`) VALUES
(1, 'atendente'),
(3, 'gerente'),
(2, 'mecânico'),
(4, 'root');

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
  `status` tinyint DEFAULT '1',
  `auto_vehicle_workstops_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `auto_vehicle_workstops_id` (`auto_vehicle_workstops_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `services`
--

INSERT INTO `services` (`id`, `name`, `description`, `estimatedTime`, `cost`, `status`, `auto_vehicle_workstops_id`) VALUES
(1, 'Troca de Pneu', 'Troca basica', '20', '20', 1, 1),
(2, 'Troca de retrovisor', 'Troca basica', '10', '10', 1, 1),
(3, 'Lampada do farol', 'Troca basica', '15', '21', 0, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `services_provided`
--

DROP TABLE IF EXISTS `services_provided`;
CREATE TABLE IF NOT EXISTS `services_provided` (
  `id` int NOT NULL AUTO_INCREMENT,
  `initial_date` datetime DEFAULT NULL,
  `final_date` datetime DEFAULT NULL,
  `quantity` int DEFAULT '1',
  `maintenance_id` int NOT NULL,
  `employees_id` int NOT NULL,
  `services_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `maintenance_id` (`maintenance_id`),
  KEY `employees_id` (`employees_id`),
  KEY `services_id` (`services_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `services_provided`
--

INSERT INTO `services_provided` (`id`, `initial_date`, `final_date`, `quantity`, `maintenance_id`, `employees_id`, `services_id`) VALUES
(1, NULL, NULL, 1, 1, 7, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
CREATE TABLE IF NOT EXISTS `suppliers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cnpj` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `business_name` varchar(50) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone_number` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `brach_activity` varchar(255) DEFAULT NULL,
  `auto_vehicle_workstops_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cnpj` (`cnpj`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `business_name` (`business_name`),
  UNIQUE KEY `phone_number` (`phone_number`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `brach_activity` (`brach_activity`),
  KEY `auto_vehicle_workstops_id` (`auto_vehicle_workstops_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `suppliers`
--

INSERT INTO `suppliers` (`id`, `cnpj`, `name`, `business_name`, `address`, `phone_number`, `email`, `brach_activity`, `auto_vehicle_workstops_id`) VALUES
(1, '60655945000173', 'Bosch', 'Robert Bosch Ltda', 'Rua W, n° 98, Parque Tocas, Cidade Normal-CE, Brasil', '8588873266', 'bosch@yahoo.com', 'Fabricante de equipamentos automotivos e peças', 1),
(2, '82804111000115', '3M', '3M do Brasil Ltda', 'Rua Y, n° 55, Sola Aí, Cidade Fortaleza-CE, Brasil', '8588776544', '3M@yempresa.com', 'ornecedora de produtos automotivos, como lixas, adesivos e polidores', 1),
(3, '12557378000170', 'Pirelli', 'Pirelli Pneus Ltda', 'Rua P, n° 11, Maga, Cidade Pacajus-CE, Brasil', '8588006544', 'pirelli@yempresa.com', 'fabricante de pneus automotivos', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `status` tinyint(1) DEFAULT '1',
  `employees_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `employees_id` (`employees_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `status`, `employees_id`) VALUES
(1, 'cassio00', '$2y$10$.0URBGQDyTW77ezc/iy.FOD9zVODmuQIE0HuRSeW9cocuEso3Uzye', 1, 1),
(2, 'angelo02', '$2y$10$.0URBGQDyTW77ezc/iy.FOD9zVODmuQIE0HuRSeW9cocuEso3Uzye', 1, 2),
(3, 'leticia02', '$2y$10$.0URBGQDyTW77ezc/iy.FOD9zVODmuQIE0HuRSeW9cocuEso3Uzye', 1, 3),
(4, 'joao01', '$2y$10$.0URBGQDyTW77ezc/iy.FOD9zVODmuQIE0HuRSeW9cocuEso3Uzye', 1, 4),
(5, 'pedro01', '$2y$10$.0URBGQDyTW77ezc/iy.FOD9zVODmuQIE0HuRSeW9cocuEso3Uzye', 1, 5),
(6, 'antonio01', '$2y$10$.0URBGQDyTW77ezc/iy.FOD9zVODmuQIE0HuRSeW9cocuEso3Uzye', 1, 6),
(7, 'Root', '$2y$10$.0URBGQDyTW77ezc/iy.FOD9zVODmuQIE0HuRSeW9cocuEso3Uzye', 1, 7);

-- --------------------------------------------------------

--
-- Estrutura da tabela `vehicles`
--

DROP TABLE IF EXISTS `vehicles`;
CREATE TABLE IF NOT EXISTS `vehicles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `model` varchar(50) NOT NULL,
  `brand` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `model` (`model`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `vehicles`
--

INSERT INTO `vehicles` (`id`, `model`, `brand`) VALUES
(1, 'Mystique GS 2.5 V6 Mec.', 'Mercury'),
(2, 'Grand Cherokee Limited LX 5.9', 'Jeep'),
(3, 'CT200h F-Sport 1.8 16V HIBRID Aut.', 'Lexus');

-- --------------------------------------------------------

--
-- Estrutura da tabela `vehicles_automotive_parts`
--

DROP TABLE IF EXISTS `vehicles_automotive_parts`;
CREATE TABLE IF NOT EXISTS `vehicles_automotive_parts` (
  `automotive_parts_id` int NOT NULL,
  `vehicles_id` int NOT NULL,
  PRIMARY KEY (`automotive_parts_id`,`vehicles_id`),
  KEY `vehicles_id` (`vehicles_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `vehicles_customer`
--

DROP TABLE IF EXISTS `vehicles_customer`;
CREATE TABLE IF NOT EXISTS `vehicles_customer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `license_plate` varchar(50) NOT NULL,
  `customers_id` int NOT NULL,
  `vehicles_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `license_plate` (`license_plate`),
  KEY `customers_id` (`customers_id`),
  KEY `vehicles_id` (`vehicles_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Extraindo dados da tabela `vehicles_customer`
--

INSERT INTO `vehicles_customer` (`id`, `license_plate`, `customers_id`, `vehicles_id`) VALUES
(1, 'IAK7872', 1, 3),
(2, 'KDM0428', 3, 2),
(3, 'LWP1328', 2, 3);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `v_employees`
-- (Veja abaixo para a view atual)
--
DROP VIEW IF EXISTS `v_employees`;
CREATE TABLE IF NOT EXISTS `v_employees` (
`id` int
,`cpf` varchar(50)
,`name` varchar(50)
,`address` varchar(255)
,`phone_number` varchar(50)
,`email` varchar(255)
,`auto_vehicle_workshops_id` int
,`positions_id` int
,`position_name` varchar(50)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `v_inventory_automotive_parts`
-- (Veja abaixo para a view atual)
--
DROP VIEW IF EXISTS `v_inventory_automotive_parts`;
CREATE TABLE IF NOT EXISTS `v_inventory_automotive_parts` (
`image_address` varchar(255)
,`reference_number` varchar(50)
,`name` varchar(50)
,`description` text
,`brand` varchar(50)
,`unit_value` float
,`status` tinyint
,`automotive_parts_id` int
,`quantity` int
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `v_maintenance_inventory`
-- (Veja abaixo para a view atual)
--
DROP VIEW IF EXISTS `v_maintenance_inventory`;
CREATE TABLE IF NOT EXISTS `v_maintenance_inventory` (
`maintenance_id` int
,`reason` varchar(50)
,`description` text
,`status` tinyint
,`initial_date` datetime
,`final_date` datetime
,`vehicles_customer_license_plate` varchar(50)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `v_maintenance_inventory_parts`
-- (Veja abaixo para a view atual)
--
DROP VIEW IF EXISTS `v_maintenance_inventory_parts`;
CREATE TABLE IF NOT EXISTS `v_maintenance_inventory_parts` (
`automotive_parts_id` int
,`maintenance_id` int
,`quantity` int
,`reference_number` varchar(50)
,`image_address` varchar(255)
,`name` varchar(50)
,`description` text
,`unit_value` float
,`brand` varchar(50)
,`status` tinyint
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `v_permissions_features`
-- (Veja abaixo para a view atual)
--
DROP VIEW IF EXISTS `v_permissions_features`;
CREATE TABLE IF NOT EXISTS `v_permissions_features` (
`positions_id` int
,`position_name` varchar(50)
,`features_id` int
,`features_name` varchar(50)
,`permissions_id` int
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `v_services_provided_mechanics`
-- (Veja abaixo para a view atual)
--
DROP VIEW IF EXISTS `v_services_provided_mechanics`;
CREATE TABLE IF NOT EXISTS `v_services_provided_mechanics` (
`services_provided_id` int
,`services_id` int
,`quantity_service` int
,`maintenance_id` int
,`service_name` varchar(50)
,`mechanic_name` varchar(50)
,`cpf` varchar(50)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `v_users`
-- (Veja abaixo para a view atual)
--
DROP VIEW IF EXISTS `v_users`;
CREATE TABLE IF NOT EXISTS `v_users` (
`user_id` int
,`username` varchar(50)
,`password` varchar(255)
,`status` tinyint(1)
,`employees_id` int
,`employee_name` varchar(50)
,`cpf` varchar(50)
,`positions_id` int
,`position_name` varchar(50)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `v_vehicles_customers`
-- (Veja abaixo para a view atual)
--
DROP VIEW IF EXISTS `v_vehicles_customers`;
CREATE TABLE IF NOT EXISTS `v_vehicles_customers` (
`customers_id` int
,`cpf` varchar(50)
,`name` varchar(50)
,`address` varchar(255)
,`phone_number` varchar(50)
,`email` varchar(255)
,`brand` varchar(50)
,`model` varchar(50)
,`license_plate` varchar(50)
,`vehicles_id` int
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
  `maintenance_id` int NOT NULL,
  `status` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `maintenance_id` (`maintenance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estrutura da view `v_employees` exportado como tabela
--
DROP TABLE IF EXISTS `v_employees`;
CREATE TABLE IF NOT EXISTS `v_employees`(
    `id` int NOT NULL DEFAULT '0',
    `cpf` varchar(50) COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `name` varchar(50) COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `address` varchar(255) COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
    `phone_number` varchar(50) COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `email` varchar(255) COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `auto_vehicle_workshops_id` int NOT NULL,
    `positions_id` int NOT NULL,
    `position_name` varchar(50) COLLATE utf8mb4_0900_ai_ci NOT NULL
);

-- --------------------------------------------------------

--
-- Estrutura da view `v_inventory_automotive_parts` exportado como tabela
--
DROP TABLE IF EXISTS `v_inventory_automotive_parts`;
CREATE TABLE IF NOT EXISTS `v_inventory_automotive_parts`(
    `image_address` varchar(255) COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
    `reference_number` varchar(50) COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `name` varchar(50) COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `description` text COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
    `brand` varchar(50) COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `unit_value` float NOT NULL,
    `status` tinyint DEFAULT '1',
    `automotive_parts_id` int NOT NULL DEFAULT '0',
    `quantity` int NOT NULL
);

-- --------------------------------------------------------

--
-- Estrutura da view `v_maintenance_inventory` exportado como tabela
--
DROP TABLE IF EXISTS `v_maintenance_inventory`;
CREATE TABLE IF NOT EXISTS `v_maintenance_inventory`(
    `maintenance_id` int NOT NULL DEFAULT '0',
    `reason` varchar(50) COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `description` text COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
    `status` tinyint DEFAULT '0',
    `initial_date` datetime DEFAULT NULL,
    `final_date` datetime DEFAULT NULL,
    `vehicles_customer_license_plate` varchar(50) COLLATE utf8mb4_0900_ai_ci NOT NULL
);

-- --------------------------------------------------------

--
-- Estrutura da view `v_maintenance_inventory_parts` exportado como tabela
--
DROP TABLE IF EXISTS `v_maintenance_inventory_parts`;
CREATE TABLE IF NOT EXISTS `v_maintenance_inventory_parts`(
    `automotive_parts_id` int NOT NULL,
    `maintenance_id` int NOT NULL,
    `quantity` int DEFAULT '1',
    `reference_number` varchar(50) COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `image_address` varchar(255) COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
    `name` varchar(50) COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `description` text COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
    `unit_value` float NOT NULL,
    `brand` varchar(50) COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `status` tinyint DEFAULT '1'
);

-- --------------------------------------------------------

--
-- Estrutura da view `v_permissions_features` exportado como tabela
--
DROP TABLE IF EXISTS `v_permissions_features`;
CREATE TABLE IF NOT EXISTS `v_permissions_features`(
    `positions_id` int NOT NULL,
    `position_name` varchar(50) COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `features_id` int NOT NULL,
    `features_name` varchar(50) COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `permissions_id` int NOT NULL
);

-- --------------------------------------------------------

--
-- Estrutura da view `v_services_provided_mechanics` exportado como tabela
--
DROP TABLE IF EXISTS `v_services_provided_mechanics`;
CREATE TABLE IF NOT EXISTS `v_services_provided_mechanics`(
    `services_provided_id` int NOT NULL DEFAULT '0',
    `services_id` int NOT NULL,
    `quantity_service` int DEFAULT '1',
    `maintenance_id` int NOT NULL,
    `service_name` varchar(50) COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `mechanic_name` varchar(50) COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `cpf` varchar(50) COLLATE utf8mb4_0900_ai_ci NOT NULL
);

-- --------------------------------------------------------

--
-- Estrutura da view `v_users` exportado como tabela
--
DROP TABLE IF EXISTS `v_users`;
CREATE TABLE IF NOT EXISTS `v_users`(
    `user_id` int NOT NULL DEFAULT '0',
    `username` varchar(50) COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `password` varchar(255) COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `status` tinyint(1) DEFAULT '1',
    `employees_id` int NOT NULL,
    `employee_name` varchar(50) COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `cpf` varchar(50) COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `positions_id` int NOT NULL,
    `position_name` varchar(50) COLLATE utf8mb4_0900_ai_ci NOT NULL
);

-- --------------------------------------------------------

--
-- Estrutura da view `v_vehicles_customers` exportado como tabela
--
DROP TABLE IF EXISTS `v_vehicles_customers`;
CREATE TABLE IF NOT EXISTS `v_vehicles_customers`(
    `customers_id` int NOT NULL DEFAULT '0',
    `cpf` varchar(50) COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `name` varchar(50) COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `address` varchar(255) COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
    `phone_number` varchar(50) COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `email` varchar(255) COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
    `brand` varchar(50) COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `model` varchar(50) COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `license_plate` varchar(50) COLLATE utf8mb4_0900_ai_ci NOT NULL,
    `vehicles_id` int NOT NULL
);

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`auto_vehicle_workstops_id`) REFERENCES `auto_vehicle_workshops` (`id`);

--
-- Limitadores para a tabela `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`positions_id`) REFERENCES `positions` (`id`),
  ADD CONSTRAINT `employees_ibfk_2` FOREIGN KEY (`auto_vehicle_workshops_id`) REFERENCES `auto_vehicle_workshops` (`id`);

--
-- Limitadores para a tabela `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`reference_number`) REFERENCES `automotive_parts` (`reference_number`);

--
-- Limitadores para a tabela `maintenance`
--
ALTER TABLE `maintenance`
  ADD CONSTRAINT `maintenance_ibfk_1` FOREIGN KEY (`vehicles_customer_license_plate`) REFERENCES `vehicles_customer` (`license_plate`);

--
-- Limitadores para a tabela `maintenance_inventory`
--
ALTER TABLE `maintenance_inventory`
  ADD CONSTRAINT `maintenance_inventory_ibfk_1` FOREIGN KEY (`automotive_parts_id`) REFERENCES `automotive_parts` (`id`),
  ADD CONSTRAINT `maintenance_inventory_ibfk_2` FOREIGN KEY (`maintenance_id`) REFERENCES `maintenance` (`id`);

--
-- Limitadores para a tabela `permissions_features`
--
ALTER TABLE `permissions_features`
  ADD CONSTRAINT `permissions_features_ibfk_1` FOREIGN KEY (`positions_id`) REFERENCES `positions` (`id`),
  ADD CONSTRAINT `permissions_features_ibfk_2` FOREIGN KEY (`features_id`) REFERENCES `features` (`id`),
  ADD CONSTRAINT `permissions_features_ibfk_3` FOREIGN KEY (`permissions_id`) REFERENCES `permissions` (`id`);

--
-- Limitadores para a tabela `services`
--
ALTER TABLE `services`
  ADD CONSTRAINT `services_ibfk_1` FOREIGN KEY (`auto_vehicle_workstops_id`) REFERENCES `auto_vehicle_workshops` (`id`);

--
-- Limitadores para a tabela `services_provided`
--
ALTER TABLE `services_provided`
  ADD CONSTRAINT `services_provided_ibfk_1` FOREIGN KEY (`maintenance_id`) REFERENCES `maintenance` (`id`),
  ADD CONSTRAINT `services_provided_ibfk_2` FOREIGN KEY (`employees_id`) REFERENCES `employees` (`id`),
  ADD CONSTRAINT `services_provided_ibfk_3` FOREIGN KEY (`services_id`) REFERENCES `services` (`id`);

--
-- Limitadores para a tabela `suppliers`
--
ALTER TABLE `suppliers`
  ADD CONSTRAINT `suppliers_ibfk_1` FOREIGN KEY (`auto_vehicle_workstops_id`) REFERENCES `auto_vehicle_workshops` (`id`);

--
-- Limitadores para a tabela `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`employees_id`) REFERENCES `employees` (`id`);

--
-- Limitadores para a tabela `vehicles_automotive_parts`
--
ALTER TABLE `vehicles_automotive_parts`
  ADD CONSTRAINT `vehicles_automotive_parts_ibfk_1` FOREIGN KEY (`automotive_parts_id`) REFERENCES `automotive_parts` (`id`),
  ADD CONSTRAINT `vehicles_automotive_parts_ibfk_2` FOREIGN KEY (`vehicles_id`) REFERENCES `vehicles` (`id`);

--
-- Limitadores para a tabela `vehicles_customer`
--
ALTER TABLE `vehicles_customer`
  ADD CONSTRAINT `vehicles_customer_ibfk_1` FOREIGN KEY (`customers_id`) REFERENCES `customers` (`id`),
  ADD CONSTRAINT `vehicles_customer_ibfk_2` FOREIGN KEY (`vehicles_id`) REFERENCES `vehicles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
