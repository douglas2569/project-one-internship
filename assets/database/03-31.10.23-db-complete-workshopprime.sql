-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 01-Nov-2023 às 03:35
-- Versão do servidor: 10.4.16-MariaDB
-- versão do PHP: 7.4.12

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
CREATE DATABASE IF NOT EXISTS `workshopprime` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `workshopprime`;

DELIMITER $$
--
-- Procedimentos
--
DROP PROCEDURE IF EXISTS `sp_delete_maintenance`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_maintenance` (`id_p` INT)  BEGIN   
    
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
        DELETE FROM services_provided WHERE id_p COLLATE latin1_swedish_ci  = services_provided.id_maintenance_fk;
   
        SET track_no = '2/3';
        DELETE FROM maintenance_inventory WHERE id_p COLLATE latin1_swedish_ci  = maintenance_inventory.id_maintenance;

        SET track_no = '3/3';
        DELETE FROM maintenance WHERE id_p COLLATE latin1_swedish_ci  = maintenance.id;
        
        SET track_no = '0/3';
        SET @full_error = 'successfully executed.';
        SELECT track_no, @full_error;
    COMMIT;

END$$

DROP PROCEDURE IF EXISTS `sp_delete_part_inventory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_part_inventory` (`reference_number_p` VARCHAR(255))  BEGIN   
    
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
        DELETE FROM vehicles_automotive_parts WHERE reference_number_p COLLATE utf8mb4_general_ci  = vehicles_automotive_parts.reference_number_automotive_parts;

        SET track_no = '2/4'; 
        DELETE FROM maintenance_inventory WHERE reference_number_p COLLATE utf8mb4_general_ci  = maintenance_inventory .reference_number;

        SET track_no = '3/4'; 
        DELETE FROM inventory WHERE reference_number_p COLLATE utf8mb4_general_ci  = inventory.reference_number;
   
        SET track_no = '4/4';
        DELETE FROM automotive_parts WHERE reference_number_p COLLATE utf8mb4_general_ci  = automotive_parts.reference_number;
        
        SET track_no = '0/2';
        SET @full_error = 'successfully executed.';
        SELECT track_no, @full_error;
    COMMIT;

END$$

DROP PROCEDURE IF EXISTS `sp_register_inventory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_register_inventory` (`image_address_P` VARCHAR(255), `reference_number_p` VARCHAR(255), `name_p` VARCHAR(50), `brand_p` VARCHAR(50), `description_p` TEXT, `unit_value_p` DECIMAL, `quantity_p` INT)  BEGIN    
    
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

DROP PROCEDURE IF EXISTS `sp_register_vehicle_costumer`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_register_vehicle_costumer` (`cpf_p` VARCHAR(50), `name_p` VARCHAR(50), `address_p` VARCHAR(50), `phoneNumber_p` VARCHAR(50), `email_p` VARCHAR(50), `cnpjAutoVehicleWorkstops_p` VARCHAR(255), `license_plate_p` VARCHAR(50), `model_p` VARCHAR(50), `brand_p` VARCHAR(50))  BEGIN    
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
        SELECT COUNT(cpf) INTO count_cpf FROM customers WHERE cpf_p COLLATE utf8mb4_general_ci  = customers.cpf; 
        IF (count_cpf <= 0) THEN      
          INSERT INTO customers (cpf, name, address, phone_number, email, cnpj_auto_vehicle_workstops_fk) 
          VALUES(cpf_p, name_p, address_p, phoneNumber_p, email_p, cnpjAutoVehicleWorkstops_p);
        END IF;
              
        /* model_p COLLATE utf8mb4_general_ci  --> aqui estou fazendo com que o valor da minha variavel tenha o msm  COLLATE da minha tabela, por consequencia dos meu campos, se eu nao forçar iss nao da certo */
        SET track_no = '2/3';  
        SELECT COUNT(model) INTO count_model FROM vehicles WHERE model_p COLLATE utf8mb4_general_ci  = vehicles.model; 
        IF (count_model <= 0) THEN
        	INSERT INTO vehicles(model, brand ) 
        	VALUES(model_p, brand_p);
    	  END IF;
        
        SET track_no = '3/3';
        INSERT INTO vehicles_customer (license_plate, cpf_customer_fk, model_vehicles_fk ) 
        VALUES(license_plate_p, cpf_p, model_p);
        
        SET track_no = '0/3';
        SET @full_error = 'successfully executed.';
        SELECT track_no,@full_error;
    COMMIT;

END$$

DROP PROCEDURE IF EXISTS `sp_update_inventory`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_inventory` (`reference_number_old_p` VARCHAR(255), `image_address_P` VARCHAR(255), `reference_number_p` VARCHAR(255), `name_p` VARCHAR(50), `brand_p` VARCHAR(50), `description_p` TEXT, `unit_value_p` DECIMAL, `quantity_p` INT, `status_p` TINYINT)  BEGIN    
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

DROP PROCEDURE IF EXISTS `sp_update_vehicle_customer`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_vehicle_customer` (`cpf_p` VARCHAR(50), `name_p` VARCHAR(50), `address_p` VARCHAR(255), `phone_number_p` VARCHAR(50), `email_p` VARCHAR(50), `license_plate_old_p` VARCHAR(50), `license_plate_new_p` VARCHAR(50), `model_p` VARCHAR(50), `brand_p` VARCHAR(50), `cnpj_auto_vehicle_workstops_p` VARCHAR(50))  BEGIN    
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
        UPDATE vehicles_customer 
        SET 
        license_plate = license_plate_new_p,
        cpf_customer_fk = cpf_p,
        model_vehicles_fk = model_p

        WHERE vehicles_customer.license_plate = license_plate_old_p COLLATE utf8mb4_general_ci;

        SET track_no = '2/2';
        UPDATE customers 
        SET         
        name = name_p,
        address = address_p,
        phone_number = phone_number_p,
        email = email_p,
        cnpj_auto_vehicle_workstops_fk = cnpj_auto_vehicle_workstops_p

        WHERE customers.cpf = cpf_p COLLATE utf8mb4_general_ci;

        SET track_no = '0/2';
        SET @full_error = 'successfully executed.';
        SELECT track_no, @full_error;
    COMMIT;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `attendants`
--

DROP TABLE IF EXISTS `attendants`;
CREATE TABLE `attendants` (
  `cpf` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
CREATE TABLE `automotive_parts` (
  `image_address` varchar(255) DEFAULT NULL,
  `reference_number` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `unit_value` float NOT NULL,
  `brand` varchar(50) NOT NULL,
  `status` tinyint(4) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `automotive_parts`
--

INSERT INTO `automotive_parts` (`image_address`, `reference_number`, `name`, `description`, `unit_value`, `brand`, `status`) VALUES
('', '7777777777', 'Teste', '', 5, 'CBT Jipe', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `auto_vehicle_workshops`
--

DROP TABLE IF EXISTS `auto_vehicle_workshops`;
CREATE TABLE `auto_vehicle_workshops` (
  `cnpj` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `business_name` varchar(50) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone_number` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
CREATE TABLE `customers` (
  `cpf` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone_number` varchar(50) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `cnpj_auto_vehicle_workstops_fk` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `customers`
--

INSERT INTO `customers` (`cpf`, `name`, `address`, `phone_number`, `email`, `cnpj_auto_vehicle_workstops_fk`) VALUES
('09534398720', 'DAVIDS', '', '86988564733', 'DAVIDcarlos@gmail.com', '01187817000183'),
('17090217610', 'Carlos', '', '85986676533', 'carlos@gmail.com', '01187817000183'),
('222.222.222-22', 'Denies', '', '44444444444', 'tworeba@gmail.com', '01187817000183'),
('77038134400', 'Betinha', '', '85989996544', 'bete@gmail.com', '01187817000183');

-- --------------------------------------------------------

--
-- Estrutura da tabela `employees`
--

DROP TABLE IF EXISTS `employees`;
CREATE TABLE `employees` (
  `cpf` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone_number` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `position` varchar(255) DEFAULT NULL,
  `cnpj_auto_vehicle_workshops_fk` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
CREATE TABLE `inventory` (
  `reference_number` varchar(50) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `inventory`
--

INSERT INTO `inventory` (`reference_number`, `quantity`) VALUES
('7777777777', 5);

-- --------------------------------------------------------

--
-- Estrutura da tabela `maintenance`
--

DROP TABLE IF EXISTS `maintenance`;
CREATE TABLE `maintenance` (
  `id` int(11) NOT NULL,
  `reason` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `status` tinyint(4) DEFAULT 0,
  `initial_date` datetime DEFAULT NULL,
  `final_date` datetime DEFAULT NULL,
  `license_plate_vehicles_customer_fk` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `maintenance`
--

INSERT INTO `maintenance` (`id`, `reason`, `description`, `status`, `initial_date`, `final_date`, `license_plate_vehicles_customer_fk`) VALUES
(49, 'Celta é doido msm', '', 0, NULL, NULL, 'HRJ2841');

-- --------------------------------------------------------

--
-- Estrutura da tabela `maintenance_inventory`
--

DROP TABLE IF EXISTS `maintenance_inventory`;
CREATE TABLE `maintenance_inventory` (
  `reference_number` varchar(50) NOT NULL,
  `id_maintenance` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `maintenance_inventory`
--

INSERT INTO `maintenance_inventory` (`reference_number`, `id_maintenance`) VALUES
('7777777777', 49);

-- --------------------------------------------------------

--
-- Estrutura da tabela `manages`
--

DROP TABLE IF EXISTS `manages`;
CREATE TABLE `manages` (
  `cpf` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
CREATE TABLE `mechanics` (
  `cpf` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
CREATE TABLE `services` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `estimatedTime` varchar(50) DEFAULT NULL,
  `cost` decimal(10,0) NOT NULL,
  `status` tinyint(4) DEFAULT 1,
  `cnpj_auto_vehicle_workstops_fk` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `services`
--

INSERT INTO `services` (`id`, `name`, `description`, `estimatedTime`, `cost`, `status`, `cnpj_auto_vehicle_workstops_fk`) VALUES
(35, 'Colocar parabrisa', NULL, NULL, '50', 1, '01187817000183'),
(36, 'Colocar ar no pneu', NULL, NULL, '5', 1, '01187817000183');

-- --------------------------------------------------------

--
-- Estrutura da tabela `services_provided`
--

DROP TABLE IF EXISTS `services_provided`;
CREATE TABLE `services_provided` (
  `id` int(11) NOT NULL,
  `initial_date` datetime DEFAULT NULL,
  `final_date` datetime DEFAULT NULL,
  `id_maintenance_fk` int(11) NOT NULL,
  `cpf_mechanics_fk` varchar(50) NOT NULL,
  `id_services_fk` int(11) NOT NULL,
  `quantity_service` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
CREATE TABLE `suppliers` (
  `cnpj` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `business_name` varchar(50) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone_number` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `brachActivity` varchar(255) DEFAULT NULL,
  `cnpj_auto_vehicle_workstops_fk` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
CREATE TABLE `users` (
  `cpf` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `status` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
CREATE TABLE `vehicles` (
  `model` varchar(50) NOT NULL,
  `brand` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `vehicles`
--

INSERT INTO `vehicles` (`model`, `brand`) VALUES
('9000 CD 2.3 Turbo', 'Saab'),
('Javali 3.0 4x4 Diesel', 'CBT Jipe'),
('Mini Cooper 1.3', 'Rover');

-- --------------------------------------------------------

--
-- Estrutura da tabela `vehicles_automotive_parts`
--

DROP TABLE IF EXISTS `vehicles_automotive_parts`;
CREATE TABLE `vehicles_automotive_parts` (
  `reference_number_automotive_parts` varchar(50) NOT NULL,
  `model_vehicles` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `vehicles_customer`
--

DROP TABLE IF EXISTS `vehicles_customer`;
CREATE TABLE `vehicles_customer` (
  `license_plate` varchar(50) NOT NULL,
  `cpf_customer_fk` varchar(50) NOT NULL,
  `model_vehicles_fk` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `vehicles_customer`
--

INSERT INTO `vehicles_customer` (`license_plate`, `cpf_customer_fk`, `model_vehicles_fk`) VALUES
('HRJ2841', '222.222.222-22', 'Javali 3.0 4x4 Diesel'),
('HRJ2842', '222.222.222-22', 'Javali 3.0 4x4 Diesel');

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `v_inventory`
-- (Veja abaixo para a view atual)
--
DROP VIEW IF EXISTS `v_inventory`;
CREATE TABLE `v_inventory` (
`reference_number` varchar(50)
,`image_address` varchar(255)
,`name` varchar(50)
,`quantity` int(11)
,`brand` varchar(50)
,`unit_value` float
,`description` text
,`status` tinyint(4)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `v_maintenance_inventory_parts`
-- (Veja abaixo para a view atual)
--
DROP VIEW IF EXISTS `v_maintenance_inventory_parts`;
CREATE TABLE `v_maintenance_inventory_parts` (
`reference_number` varchar(50)
,`id_maintenance` int(11)
,`image_address` varchar(255)
,`name` varchar(50)
,`description` text
,`unit_value` float
,`brand` varchar(50)
,`status` tinyint(4)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `v_services_provided_mechanics`
-- (Veja abaixo para a view atual)
--
DROP VIEW IF EXISTS `v_services_provided_mechanics`;
CREATE TABLE `v_services_provided_mechanics` (
`id_services_fk` int(11)
,`quantity_service` int(11)
,`id_maintenance_fk` int(11)
,`service_name` varchar(50)
,`mechanic_name` varchar(50)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `v_users`
-- (Veja abaixo para a view atual)
--
DROP VIEW IF EXISTS `v_users`;
CREATE TABLE `v_users` (
`cpf` varchar(50)
,`username` varchar(50)
,`password` varchar(255)
,`name` varchar(50)
,`position` varchar(255)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para vista `v_vehicles_customers`
-- (Veja abaixo para a view atual)
--
DROP VIEW IF EXISTS `v_vehicles_customers`;
CREATE TABLE `v_vehicles_customers` (
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
CREATE TABLE `work_orders` (
  `id` int(11) NOT NULL,
  `warranty` varchar(50) NOT NULL,
  `date` datetime DEFAULT current_timestamp(),
  `total` decimal(10,0) NOT NULL,
  `id_maintenance_fk` int(11) NOT NULL,
  `status` tinyint(4) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura para vista `v_inventory`
--
DROP TABLE IF EXISTS `v_inventory`;

DROP VIEW IF EXISTS `v_inventory`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_inventory`  AS SELECT `automotive_parts`.`reference_number` AS `reference_number`, `automotive_parts`.`image_address` AS `image_address`, `automotive_parts`.`name` AS `name`, `inventory`.`quantity` AS `quantity`, `automotive_parts`.`brand` AS `brand`, `automotive_parts`.`unit_value` AS `unit_value`, `automotive_parts`.`description` AS `description`, `automotive_parts`.`status` AS `status` FROM (`automotive_parts` join `inventory` on(`automotive_parts`.`reference_number` = `inventory`.`reference_number`)) WHERE `automotive_parts`.`status` = '1' ;

-- --------------------------------------------------------

--
-- Estrutura para vista `v_maintenance_inventory_parts`
--
DROP TABLE IF EXISTS `v_maintenance_inventory_parts`;

DROP VIEW IF EXISTS `v_maintenance_inventory_parts`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_maintenance_inventory_parts`  AS SELECT `maintenance_inventory`.`reference_number` AS `reference_number`, `maintenance_inventory`.`id_maintenance` AS `id_maintenance`, `automotive_parts`.`image_address` AS `image_address`, `automotive_parts`.`name` AS `name`, `automotive_parts`.`description` AS `description`, `automotive_parts`.`unit_value` AS `unit_value`, `automotive_parts`.`brand` AS `brand`, `automotive_parts`.`status` AS `status` FROM (`maintenance_inventory` join `automotive_parts` on(`maintenance_inventory`.`reference_number` = `automotive_parts`.`reference_number`)) ;

-- --------------------------------------------------------

--
-- Estrutura para vista `v_services_provided_mechanics`
--
DROP TABLE IF EXISTS `v_services_provided_mechanics`;

DROP VIEW IF EXISTS `v_services_provided_mechanics`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_services_provided_mechanics`  AS SELECT `services_provided`.`id_services_fk` AS `id_services_fk`, `services_provided`.`quantity_service` AS `quantity_service`, `services_provided`.`id_maintenance_fk` AS `id_maintenance_fk`, `services`.`name` AS `service_name`, `employees`.`name` AS `mechanic_name` FROM ((`services_provided` join `services` on(`services`.`id` = `services_provided`.`id_services_fk`)) join `employees` on(`employees`.`cpf` = `services_provided`.`cpf_mechanics_fk`)) ;

-- --------------------------------------------------------

--
-- Estrutura para vista `v_users`
--
DROP TABLE IF EXISTS `v_users`;

DROP VIEW IF EXISTS `v_users`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_users`  AS SELECT `users`.`cpf` AS `cpf`, `users`.`username` AS `username`, `users`.`password` AS `password`, `employees`.`name` AS `name`, `employees`.`position` AS `position` FROM (`users` join `employees` on(`users`.`cpf` = `employees`.`cpf`)) ;

-- --------------------------------------------------------

--
-- Estrutura para vista `v_vehicles_customers`
--
DROP TABLE IF EXISTS `v_vehicles_customers`;

DROP VIEW IF EXISTS `v_vehicles_customers`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_vehicles_customers`  AS SELECT `customers`.`cpf` AS `cpf`, `customers`.`name` AS `name`, `customers`.`address` AS `address`, `customers`.`phone_number` AS `phone_number`, `customers`.`email` AS `email`, `vehicles_customer`.`model_vehicles_fk` AS `model_vehicles_fk`, `vehicles_customer`.`license_plate` AS `license_plate`, `vehicles`.`brand` AS `brand` FROM ((`vehicles_customer` join `vehicles` on(`vehicles_customer`.`model_vehicles_fk` = `vehicles`.`model`)) join `customers` on(`customers`.`cpf` = `vehicles_customer`.`cpf_customer_fk`)) ;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `attendants`
--
ALTER TABLE `attendants`
  ADD PRIMARY KEY (`cpf`);

--
-- Índices para tabela `automotive_parts`
--
ALTER TABLE `automotive_parts`
  ADD PRIMARY KEY (`reference_number`);

--
-- Índices para tabela `auto_vehicle_workshops`
--
ALTER TABLE `auto_vehicle_workshops`
  ADD PRIMARY KEY (`cnpj`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `business_name` (`business_name`),
  ADD UNIQUE KEY `phone_number` (`phone_number`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Índices para tabela `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`cpf`),
  ADD UNIQUE KEY `phone_number` (`phone_number`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `cnpj_auto_vehicle_workstops_fk` (`cnpj_auto_vehicle_workstops_fk`);

--
-- Índices para tabela `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`cpf`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `phone_number` (`phone_number`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `cnpj_auto_vehicle_workshops_fk` (`cnpj_auto_vehicle_workshops_fk`);

--
-- Índices para tabela `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`reference_number`);

--
-- Índices para tabela `maintenance`
--
ALTER TABLE `maintenance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `license_plate_vehicles_customer_fk` (`license_plate_vehicles_customer_fk`);

--
-- Índices para tabela `maintenance_inventory`
--
ALTER TABLE `maintenance_inventory`
  ADD PRIMARY KEY (`reference_number`,`id_maintenance`),
  ADD KEY `id_maintenance` (`id_maintenance`);

--
-- Índices para tabela `manages`
--
ALTER TABLE `manages`
  ADD PRIMARY KEY (`cpf`);

--
-- Índices para tabela `mechanics`
--
ALTER TABLE `mechanics`
  ADD PRIMARY KEY (`cpf`);

--
-- Índices para tabela `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `cnpj_auto_vehicle_workstops_fk` (`cnpj_auto_vehicle_workstops_fk`);

--
-- Índices para tabela `services_provided`
--
ALTER TABLE `services_provided`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_maintenance_fk` (`id_maintenance_fk`),
  ADD KEY `cpf_mechanics_fk` (`cpf_mechanics_fk`),
  ADD KEY `id_services_fk` (`id_services_fk`);

--
-- Índices para tabela `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`cnpj`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `business_name` (`business_name`),
  ADD UNIQUE KEY `phone_number` (`phone_number`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `brachActivity` (`brachActivity`),
  ADD KEY `cnpj_auto_vehicle_workstops_fk` (`cnpj_auto_vehicle_workstops_fk`);

--
-- Índices para tabela `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`cpf`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Índices para tabela `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`model`);

--
-- Índices para tabela `vehicles_automotive_parts`
--
ALTER TABLE `vehicles_automotive_parts`
  ADD PRIMARY KEY (`reference_number_automotive_parts`,`model_vehicles`),
  ADD KEY `model_vehicles` (`model_vehicles`);

--
-- Índices para tabela `vehicles_customer`
--
ALTER TABLE `vehicles_customer`
  ADD PRIMARY KEY (`license_plate`),
  ADD KEY `cpf_customer_fk` (`cpf_customer_fk`),
  ADD KEY `model_vehicles_fk` (`model_vehicles_fk`);

--
-- Índices para tabela `work_orders`
--
ALTER TABLE `work_orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_maintenance_fk` (`id_maintenance_fk`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `maintenance`
--
ALTER TABLE `maintenance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT de tabela `services`
--
ALTER TABLE `services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de tabela `services_provided`
--
ALTER TABLE `services_provided`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT de tabela `work_orders`
--
ALTER TABLE `work_orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

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
