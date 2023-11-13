/* Primeiro veja o colocation  */
/* CREATE DATABASE 'workshopprime' */
/* VER QUAL COLOCATION PARA VC COLOCAR  VARIAVEIS */
#COLLATE
#SHOW VARIABLES LIKE '%char%' 
#SHOW VARIABLES LIKE '%collation%'

# Configuração para funcionar esse codigo
# collation_connection:  utf8mb4_unicode_ci 
# collation_database:  utf8mb4_0900_ai_ci 
# collation_server:  utf8mb4_0900_ai_ci 
# default_collation_for_utf8mb4:  utf8mb4_0900_ai_ci 

DROP TABLE IF EXISTS `auto_vehicle_workshops`;
CREATE TABLE IF NOT EXISTS `auto_vehicle_workshops` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cnpj` VARCHAR(50) NOT NULL UNIQUE,
  `name` VARCHAR(50) NOT NULL UNIQUE,
  `business_name` VARCHAR(50) NOT NULL UNIQUE,
  `address` VARCHAR(255),  
  `phone_number` VARCHAR(50) NOT NULL UNIQUE,
  `email` VARCHAR(255) NOT NULL UNIQUE,  
  PRIMARY KEY (`id`)  
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `positions`;
CREATE TABLE IF NOT EXISTS `positions` (
  `id` INT NOT NULL AUTO_INCREMENT,  
  `name` VARCHAR(50) NOT NULL UNIQUE,  

  PRIMARY KEY (`id`)  
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `employees`;
CREATE TABLE IF NOT EXISTS `employees` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cpf` VARCHAR(50) NOT NULL UNIQUE,
  `name` VARCHAR(50) NOT NULL,  
  `address` VARCHAR(255),  
  `phone_number` VARCHAR(50) NOT NULL UNIQUE,
  `email` VARCHAR(255) NOT NULL UNIQUE,     

  `auto_vehicle_workshops_id` INT NOT NULL,  
  `positions_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`positions_id`) REFERENCES `positions`(`id`),
  FOREIGN KEY (`auto_vehicle_workshops_id`) REFERENCES `auto_vehicle_workshops`(`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `features`;
CREATE TABLE IF NOT EXISTS `features` (
  `id` INT NOT NULL AUTO_INCREMENT,  
  `name` VARCHAR(50) NOT NULL UNIQUE, 
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `permissions`;
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` INT NOT NULL AUTO_INCREMENT,  
  `create` tinyint DEFAULT 0,  
  `read` tinyint DEFAULT 0,  
  `update` tinyint DEFAULT 0,  
  `delete` tinyint DEFAULT 0,
  
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `permissions_features`;
CREATE TABLE IF NOT EXISTS `permissions_features` (
  `positions_id` INT NOT NULL,  
  `features_id` INT NOT NULL,  
  `permissions_id` INT NOT NULL,      
   
  PRIMARY KEY (`positions_id`, `features_id`, `permissions_id`),  
  FOREIGN KEY (`positions_id`) REFERENCES `positions`(`id`),
  FOREIGN KEY (`features_id`) REFERENCES `features`(`id`),
  FOREIGN KEY (`permissions_id`) REFERENCES `permissions`(`id`)
  
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` INT NOT NULL AUTO_INCREMENT, 
  `username` VARCHAR(50) NOT NULL UNIQUE,   
  `password` VARCHAR(255) NOT NULL, 
  `status` tinyint(1) default 1, 
  `employees_id` INT NOT NULL UNIQUE,
	
  PRIMARY KEY (`id`),
  FOREIGN KEY (`employees_id`) REFERENCES `employees`(`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `suppliers`;
CREATE TABLE IF NOT EXISTS `suppliers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cnpj` VARCHAR(50) NOT NULL UNIQUE,
  `name` VARCHAR(50) NOT NULL UNIQUE,
  `business_name` VARCHAR(50) NOT NULL UNIQUE,
  `address` VARCHAR(255),  
  `phone_number` VARCHAR(50) NOT NULL UNIQUE,
  `email` VARCHAR(255) NOT NULL UNIQUE,  
  `brach_activity` VARCHAR(255) UNIQUE, 
  `auto_vehicle_workstops_id`INT NOT NULL,
  
  PRIMARY KEY (`id`),
  FOREIGN KEY (`auto_vehicle_workstops_id`) REFERENCES `auto_vehicle_workshops`(`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `customers`;
CREATE TABLE IF NOT EXISTS `customers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cpf` VARCHAR(50) NOT NULL UNIQUE,
  `name` VARCHAR(50) NOT NULL,  
  `address` VARCHAR(255),  
  `phone_number` VARCHAR(50) NOT NULL UNIQUE,
  `email` VARCHAR(255) UNIQUE,    
  `auto_vehicle_workstops_id` INT NOT NULL,
  
  PRIMARY KEY (`id`),
  FOREIGN KEY (`auto_vehicle_workstops_id`) REFERENCES `auto_vehicle_workshops`(`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `vehicles`;
CREATE TABLE IF NOT EXISTS `vehicles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `model` VARCHAR(50) NOT NULL UNIQUE,
  `brand` VARCHAR(50) NOT NULL,  
  
  PRIMARY KEY (`id`) 
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `vehicles_customer`;
CREATE TABLE IF NOT EXISTS `vehicles_customer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `license_plate` VARCHAR(50) NOT NULL UNIQUE,
  `customers_id` INT NOT NULL,  
  `vehicles_id` INT NOT NULL,
  
  PRIMARY KEY (`id`),
  FOREIGN KEY (`customers_id`) REFERENCES `customers`(`id`) ,
  FOREIGN KEY (`vehicles_id`) REFERENCES `vehicles`(`id`) 

) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `automotive_parts`;
CREATE TABLE IF NOT EXISTS `automotive_parts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `image_address` VARCHAR(255),
  `reference_number` VARCHAR(50) NOT NULL UNIQUE,
  `name` VARCHAR(50) NOT NULL,
  `description` text,    
  `unit_value` FLOAT NOT NULL,
  `brand` VARCHAR(50) NOT NULL, 
  `status` tinyint default 1, 
  
  PRIMARY KEY (`id`) 
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `vehicles_automotive_parts`;
CREATE TABLE IF NOT EXISTS `vehicles_automotive_parts` (
  `automotive_parts_id` INT NOT NULL,
  `vehicles_id` INT NOT NULL,  
  
  PRIMARY KEY (`automotive_parts_id`, `vehicles_id`),   
  FOREIGN KEY (`automotive_parts_id`) REFERENCES `automotive_parts`(`id`),
  FOREIGN KEY (`vehicles_id`) REFERENCES `vehicles`(`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `maintenance`;
CREATE TABLE IF NOT EXISTS `maintenance` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `reason` VARCHAR(50) NOT NULL,
  `description` text,
  `status` tinyint default 0,  
  `initial_date` DATETIME,
  `final_date` DATETIME,
  `vehicles_customer_license_plate` VARCHAR(50) NOT NULL,
  
  PRIMARY KEY (`id`),   
  FOREIGN KEY (`vehicles_customer_license_plate`) REFERENCES `vehicles_customer`(`license_plate`)  
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `inventory`;
CREATE TABLE IF NOT EXISTS `inventory` (
  `reference_number` VARCHAR(50) NOT NULL,
  `quantity` INT NOT NULL,  
  
  PRIMARY KEY (`reference_number`),   
  FOREIGN KEY (`reference_number`) REFERENCES `automotive_parts`(`reference_number`)  
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `maintenance_inventory`;
CREATE TABLE IF NOT EXISTS `maintenance_inventory` (
  `automotive_parts_id` INT NOT NULL,
  `maintenance_id` INT NOT NULL,  
  `quantity` INT(11) DEFAULT 1,  
  
  PRIMARY KEY (`automotive_parts_id`,`maintenance_id`),   
  FOREIGN KEY (`automotive_parts_id`) REFERENCES `automotive_parts`(`id`),  
  FOREIGN KEY (`maintenance_id`) REFERENCES `maintenance`(`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `services`;
CREATE TABLE IF NOT EXISTS `services` (
  `id` INT NOT NULL AUTO_INCREMENT,   
  `name` VARCHAR(50) UNIQUE NOT NULL,
  `description` text,
  `estimatedTime` VARCHAR(50),
  `cost` decimal NOT NULL,
  `status` tinyint default 1, 
  `auto_vehicle_workstops_id` INT NOT NULL, 
  
  PRIMARY KEY (`id`),   
  FOREIGN KEY (`auto_vehicle_workstops_id`) REFERENCES `auto_vehicle_workshops`(`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `services_provided`;
CREATE TABLE IF NOT EXISTS `services_provided` (
  `id` INT NOT NULL AUTO_INCREMENT,   
  `initial_date` DATETIME,
  `final_date` DATETIME,
  `quantity` INT DEFAULT 1, 
  `maintenance_id` INT NOT NULL,  
  `employees_id` INT NOT NULL,
  `services_id` INT NOT NULL, 
  
  PRIMARY KEY (`id`),   
  FOREIGN KEY (`maintenance_id`) REFERENCES `maintenance`(`id`),
  FOREIGN KEY (`employees_id`) REFERENCES `employees`(`id`),
  FOREIGN KEY (`services_id`) REFERENCES `services`(`id`)  
  
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `work_orders`;
CREATE TABLE IF NOT EXISTS `work_orders` (
  `id` INT NOT NULL AUTO_INCREMENT,   
  `warranty` VARCHAR(50) NOT NULL,
  `date` DATETIME default now(),
  `total` decimal NOT NULL,
  `maintenance_id` INT NOT NULL UNIQUE, 
  `status` tinyint default 0, 
  
  PRIMARY KEY (`id`) 
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;



/* populating the database */

INSERT INTO auto_vehicle_workshops (cnpj, name, business_name,address, phone_number, email) values('01187817000183', 'Workshop Prime', 'Workshop Prime', 'Rua 24, n° 1234, Automóvel Central, Cidade dos Motores-CE, Brasil', '8587965433', 'workshopprime@gmail.com');

INSERT INTO positions (name) values ('atendente');
INSERT INTO positions (name) values ('mecânico');
INSERT INTO positions (name) values ('gerente');
INSERT INTO positions (name) VALUES ('root');

INSERT INTO `employees` (`cpf`, `name`, `address`, `phone_number`, `email`, `auto_vehicle_workshops_id`, `positions_id`) VALUES ('62565411030', 'Cassio Malvarisco', 'Rua F, n° 1634, Parque das flores, Cidade dos Altos-CE, Brasil', '8588965833', 'cassiomalvarisco@hotmail.com', 1, 3),
('82178774083', 'Angelo Tavares', 'Rua 22, n° 34, Bom Jardim, Cidade Baixa-CE, Brasil', 
'8599465833', 'angelotavares@outlook.com', 1, 1),
('01069520055', 'Leticia Juliana', 'Rua 64, n° 03, Parque Jardim, Cidade Media-CE, Brasil', 
'8590765833', 'leticiajuliana@gmail.com', 1, 1),
('41740738055', 'João Juliano', 'Rua 64, n° 03, Parque Jardim, Cidade Media-CE, Brasil', 
'8590665833', 'joaojuliano@gmail.com', 1, 2),
('46899032040', 'Pedro Gustavo', 'Rua A, n° 11, Parque Jardim, Cidade Media-CE, Brasil', 
'8597765833', 'pedrogustavo@gmail.com', 1, 2),
('31685403077', 'Antonio Ferreira', 'Rua Z, n° 98, Parque alvoras, Cidade Normal-CE, Brasil', 
'8597788833', 'antonioferreia@yahoo.com', 1, 2),
('00000000000', 'Root', NULL, '00000000000', '', 1, 4);

INSERT INTO users (username, password, employees_id) values
('cassio00', '$2y$10$.0URBGQDyTW77ezc/iy.FOD9zVODmuQIE0HuRSeW9cocuEso3Uzye', 1),
('angelo02', '$2y$10$.0URBGQDyTW77ezc/iy.FOD9zVODmuQIE0HuRSeW9cocuEso3Uzye', 2),
('leticia02', '$2y$10$.0URBGQDyTW77ezc/iy.FOD9zVODmuQIE0HuRSeW9cocuEso3Uzye', 3),
('joao01', '$2y$10$.0URBGQDyTW77ezc/iy.FOD9zVODmuQIE0HuRSeW9cocuEso3Uzye', 4),
('pedro01', '$2y$10$.0URBGQDyTW77ezc/iy.FOD9zVODmuQIE0HuRSeW9cocuEso3Uzye', 5),
('antonio01', '$2y$10$.0URBGQDyTW77ezc/iy.FOD9zVODmuQIE0HuRSeW9cocuEso3Uzye', 6),
('Root', '$2y$10$.0URBGQDyTW77ezc/iy.FOD9zVODmuQIE0HuRSeW9cocuEso3Uzye', 7);

INSERT INTO features (name) values('inventory'), ('maintenance'), ('services'), ('users'), ('vehicles_customer'), ('services_provided'),('permissions_features'), ('work_on_maintaining'), ('employees');

INSERT INTO `permissions` (`create`, `read`, `update`, `delete`) VALUES(0, 0, 0, 0), (1, 1, 1, 1), (0, 1, 0, 0), (1, 1, 0, 1);

#atendente
INSERT INTO `permissions_features` (`positions_id`, `features_id`, `permissions_id`) VALUES ('1', '9', '1'), ('1', '1', '3'), ('1', '2', '2'), ('1', '7', '1'), ('1', '3', '3'), ('1', '6', '1'), ('1', '4', '1'), ('1', '5', '2'), ('1', '8', '3');

#gerente
INSERT INTO `permissions_features` (`positions_id`, `features_id`, `permissions_id`) VALUES ('3', '9', '2'), ('3', '1', '2'), ('3', '2', '3'), ('3', '7', '2'), ('3', '3', '2'), ('3', '6', '3'), ('3', '4', '2'), ('3', '5', '3'), ('3', '8', '3');

#mecanico
INSERT INTO `permissions_features` (`positions_id`, `features_id`, `permissions_id`) VALUES ('2', '9', '1'), ('2', '1', '3'), ('2', '2', '3'), ('2', '7', '1'), ('2', '3', '3'), ('2', '6', '2'), ('2', '4', '1'), ('2', '5', '1'), ('2', '8', '2');

#root
INSERT INTO `permissions_features` (`positions_id`, `features_id`, `permissions_id`) VALUES ('4', '9', '2'), ('4', '1', '2'), ('4', '2', '2'), ('4', '7', '2'), ('4', '3', '2'), ('4', '6', '2'), ('4', '4', '2'), ('4', '5', '2'), ('4', '8', '2');

INSERT INTO suppliers (cnpj, name, business_name, address, phone_number, email, brach_activity, auto_vehicle_workstops_id) 
values('60655945000173','Bosch','Robert Bosch Ltda','Rua W, n° 98, Parque Tocas, Cidade Normal-CE, Brasil','8588873266',
'bosch@yahoo.com','Fabricante de equipamentos automotivos e peças',1);

INSERT INTO suppliers (cnpj, name, business_name, address, phone_number, email, brach_activity, auto_vehicle_workstops_id) 
values('82804111000115','3M','3M do Brasil Ltda','Rua Y, n° 55, Sola Aí, Cidade Fortaleza-CE, Brasil','8588776544',
'3M@yempresa.com','ornecedora de produtos automotivos, como lixas, adesivos e polidores',1);

INSERT INTO suppliers (cnpj, name, business_name, address, phone_number, email, brach_activity, auto_vehicle_workstops_id) 
values('12557378000170','Pirelli','Pirelli Pneus Ltda','Rua P, n° 11, Maga, Cidade Pacajus-CE, Brasil','8588006544',
'pirelli@yempresa.com','fabricante de pneus automotivos',1);

INSERT INTO customers (cpf, name, address, phone_number, email, auto_vehicle_workstops_id) 
values('03966183080','Juliano Pasquim','Rua T, n° 10,Chico da Doca, Cidade Paçoca-CE, Brasil','8588873217',
'julianopasquim@outlook.com',1);

INSERT INTO customers (cpf, name, address, phone_number, email, auto_vehicle_workstops_id) 
values('29012056071','Paula Abreu','Rua B, n° 10,Chico Tico, Cidade Paçoca-CE, Brasil','8588879917',
'paulaabreu@outlook.com',1);

INSERT INTO customers (cpf, name, address, phone_number, email, auto_vehicle_workstops_id) 
values('11924265095','Ivan Nildo','Rua C, n° 11, Tata Tico, Cidade Pamanha-CE, Brasil','8587779917',
'ivannildo@outlook.com',1);

INSERT INTO vehicles (model, brand) 
values('Mystique GS 2.5 V6 Mec.','Mercury');

INSERT INTO vehicles (model, brand) 
values('Grand Cherokee Limited LX 5.9','Jeep');

INSERT INTO vehicles (model, brand) 
values('CT200h F-Sport 1.8 16V HIBRID Aut.','Lexus');

INSERT INTO `vehicles_customer` (`license_plate`, `customers_id`, `vehicles_id`) VALUES ('IAK7872', '1', '3'), ('KDM0428', '3', '2'), ('LWP1328', '2', '3');

INSERT INTO automotive_parts (reference_number, name, brand, description, unit_value) 
values('12345','Filtro de Óleo','Fram','Este filtro de óleo Fram possui uma classificação de eficiência de filtração de 98%, com uma capacidade de retenção de partículas de até 10 micra, protegendo o motor contra desgaste prematuro.', 15.00);

INSERT INTO automotive_parts (reference_number, name, brand, description, unit_value) 
values('67890','Pastilhas de Freio','Brembo','Pastilhas de freio Brembo são componentes do sistema de freio que fornecem frenagem segura e eficaz.', 50.00);

INSERT INTO automotive_parts (reference_number, name, brand, description, unit_value) 
values('54321','Bateria de Carro','AC Delco','A bateria AC Delco é uma bateria de chumbo-ácido de 12 volts, com uma capacidade nominal de 60 ampères-hora (Ah) e uma resistência INTerna baixa, fornecendo uma corrente de partida confiável', 150.00);

INSERT INTO automotive_parts (reference_number, name, brand, description, unit_value) 
values('98765','Filtro de Ar','NGK', 'O filtro de ar K&N é um filtro de alto fluxo, projetado para aumentar a capacidade de fluxo de ar em até 50%, mantendo uma eficiência de filtração de 99%, com uma capacidade de retenção de partículas de até 2 micra.', 20.00);

INSERT INTO automotive_parts (reference_number, name, brand, description, unit_value) 
values('23456','Vela de Ignição','K&N', 'As velas de ignição NGK são fabricadas com eletrodos de níquel-cromo e possuem uma faixa térmica de calor médio, garantindo ignição precisa e confiável em uma ampla gama de temperaturas e condições.', 90.00);

INSERT INTO automotive_parts (reference_number, name, brand, description, unit_value) 
values('M78901','Corrente de Transmissão','DID','A corrente de transmissão DID é uma corrente de rolos selada com uma classificação de resistência à tração de 8.000 libras, projetada para transmitir potência eficientemente com uma vida útil prolongada.', 300.00);

INSERT INTO automotive_parts (reference_number, name, brand, description, unit_value) 
values('M23456','Disco de Freio','EBC','Os discos de freio EBC são feitos de aço inoxidável endurecido e possuem ranhuras para dissipação de calor, proporcionando um desempenho de frenagem consistente e eficiente.', 200.00);

INSERT INTO automotive_parts (reference_number, name, brand, description, unit_value) 
values('M65432','Vela de Ignição','Denso','As velas de ignição Denso são feitas de cerâmica isolante e possuem uma resistência de 0,8 ohms, garantindo ignição eficaz e redução do consumo de combustível.', 10.00);

INSERT INTO automotive_parts (reference_number, name, brand, description, unit_value) 
values('M12345','Filtro de Ar','K&N','Os filtros de ar K&N possuem uma capacidade de fluxo de ar de 1.000 CFM (pés cúbicos por minuto) a uma restrição de 1 polegada de água, proporcionando um aumento significativo no fluxo de ar.', 80.00);

INSERT INTO automotive_parts (reference_number, name, brand, description, unit_value) 
values('M87654','Pneu Traseiro','Michelin','O pneu traseiro Michelin possui uma construção radial com uma classificação de velocidade de até 180 km/h, oferecendo aderência excepcional em uma variedade de condições de pilotagem.', 50.00);

INSERT INTO `maintenance` (`reason`, `description`, `status`, `initial_date`, `final_date`, `vehicles_customer_license_plate`) VALUES ('Carro não liga', 'Quando giro a chave ele faz tantaaaatan', '0', NULL, NULL, 'IAK7872');


INSERT INTO services(name, description, estimatedTime, cost, auto_vehicle_workstops_id) 
values('Troca de Pneu','Troca basica','20',20.00,1);

INSERT INTO services(name, description, estimatedTime, cost, auto_vehicle_workstops_id) 
values('Troca de retrovisor','Troca basica','10',10,1);

INSERT INTO services(name, description, estimatedTime, cost, auto_vehicle_workstops_id) 
values('Lampada do farol','Troca basica','15',20.5,1);

DROP VIEW IF EXISTS v_users;
CREATE VIEW v_users
AS 
SELECT users.id as user_id, users.username, users.password, users.status, users.employees_id,  employees.name as employee_name ,  employees.cpf, employees.positions_id, positions.name as position_name FROM users 
INNER JOIN employees 
on users.employees_id = employees.id
INNER JOIN positions 
on employees.positions_id = positions.id; 

DROP VIEW IF EXISTS v_permissions_features;
CREATE VIEW v_permissions_features 
AS SELECT positions_id, positions.name as position_name, features_id, features.name as features_name, permissions_id
FROM permissions_features 
INNER JOIN positions 
on permissions_features.positions_id = positions.id
INNER JOIN features 
on permissions_features.features_id = features.id; 

DROP VIEW IF EXISTS v_vehicles_customers;
CREATE VIEW v_vehicles_customers
AS  
SELECT customers.id AS customers_id, customers.cpf, customers.name, customers.address, customers.phone_number, customers.email, vehicles.brand, vehicles.model, vehicles_customer.license_plate, 
vehicles_customer.vehicles_id  
FROM customers
INNER JOIN vehicles_customer
ON customers.id  = vehicles_customer.customers_id
INNER JOIN vehicles
ON vehicles.id  = vehicles_customer.vehicles_id;

DROP VIEW IF EXISTS v_employees;
CREATE VIEW v_employees
AS  
SELECT employees.id, employees.cpf, employees.name, employees.address, employees.phone_number, employees.email, employees.auto_vehicle_workshops_id, employees.positions_id,
positions.name AS position_name
FROM employees
INNER JOIN positions
ON  employees.positions_id  = positions.id;


DROP VIEW IF EXISTS v_maintenance_inventory;
CREATE VIEW v_maintenance_inventory
AS 
SELECT maintenance.id as maintenance_id, maintenance.reason, maintenance.description, maintenance.status, maintenance.initial_date, maintenance.final_date, maintenance.vehicles_customer_license_plate
FROM maintenance INNER JOIN maintenance_inventory ON maintenance.id = maintenance_inventory.maintenance_id;  

DROP VIEW IF EXISTS v_maintenance_inventory_parts;
CREATE VIEW v_maintenance_inventory_parts
AS 
SELECT maintenance_inventory.automotive_parts_id as automotive_parts_id,  maintenance_inventory.maintenance_id, maintenance_inventory.quantity,
automotive_parts.reference_number, automotive_parts.image_address , automotive_parts.name , automotive_parts.description, automotive_parts.unit_value,  automotive_parts.brand,  automotive_parts.status 
FROM maintenance_inventory 
INNER JOIN automotive_parts 
ON maintenance_inventory.automotive_parts_id = automotive_parts.id ;

DROP VIEW IF EXISTS v_services_provided_mechanics;
CREATE VIEW v_services_provided_mechanics
AS 
SELECT services_provided.id AS services_provided_id, 
services_provided.services_id,  
services_provided.quantity AS quantity_service, 
services_provided.maintenance_id,
services.name AS service_name,
employees.name AS mechanic_name,
employees.cpf
FROM services_provided 
INNER JOIN services 
ON services.id = services_provided.services_id 
INNER JOIN employees 
ON employees.id = services_provided.employees_id; 

DROP VIEW IF EXISTS v_inventory_automotive_parts ;
CREATE VIEW v_inventory_automotive_parts
AS 
SELECT automotive_parts.image_address , automotive_parts.reference_number,  automotive_parts.name , automotive_parts.description, automotive_parts.brand,  automotive_parts.unit_value, automotive_parts.status,  automotive_parts.id AS automotive_parts_id, inventory.quantity   
FROM automotive_parts 
INNER JOIN inventory 
ON automotive_parts.reference_number = inventory.reference_number; 

DROP PROCEDURE IF EXISTS sp_register_vehicle_costumer;
DELIMITER $$

CREATE PROCEDURE sp_register_vehicle_costumer(	 
	 cpf_p VARCHAR(50),
    name_p VARCHAR(50),
    address_p VARCHAR(50),
    phoneNumber_p VARCHAR(50),
    email_p VARCHAR(50),
    autoVehicleWorkstops_id_p INT,
    license_plate_p VARCHAR(50),
    model_p VARCHAR(50),
    brand_p VARCHAR(50)
  )

BEGIN    
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

END; $$

DELIMITER ;


DROP PROCEDURE IF EXISTS sp_update_vehicles_customer;
DELIMITER $$

CREATE PROCEDURE sp_update_vehicles_customer(
    cpf_new_p VARCHAR(50),
    cpf_old_p VARCHAR(50),
	  name_p VARCHAR(50),
    address_p VARCHAR(255),
    phone_number_p VARCHAR(50),
    email_p VARCHAR(50),
    license_plate_old_p VARCHAR(50),
    license_plate_new_p VARCHAR(50)
  )

BEGIN    
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

END; $$

DELIMITER ;


DROP PROCEDURE IF EXISTS sp_register_inventory;
DELIMITER $$

CREATE PROCEDURE sp_register_inventory(
	  image_address_P VARCHAR(255),
    reference_number_p VARCHAR(255),
    name_p VARCHAR(50),
    brand_p VARCHAR(50),
    description_p TEXT,
    unit_value_p DECIMAL,
    quantity_p INT
  )

BEGIN    
    
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

END; $$

DELIMITER ;

# CALL sp_inventory('caminho.jpg','23423423423','nome da peça','marca da peça',
# 'descrição da pela........',11, 200);

DROP PROCEDURE IF EXISTS sp_delete_part_inventory;
DELIMITER $$

CREATE PROCEDURE sp_delete_part_inventory(reference_number_p VARCHAR(255), automotive_parts_id_p INT)
BEGIN   
    
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

END; $$

DELIMITER ;


#  collation_server
DROP PROCEDURE IF EXISTS sp_delete_maintenance;
DELIMITER $$

CREATE PROCEDURE sp_delete_maintenance(id_p INT)
BEGIN   
    
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

END; $$

DELIMITER ;


DELIMITER ;

DROP PROCEDURE IF EXISTS sp_update_inventory;
DELIMITER $$

CREATE PROCEDURE sp_update_inventory(
    reference_number_old_p VARCHAR(255),
	  image_address_P VARCHAR(255),
    reference_number_p VARCHAR(255),
    name_p VARCHAR(50),
    brand_p VARCHAR(50),
    description_p TEXT,
    unit_value_p DECIMAL,
    quantity_p INT, 
    status_p tinyint 
  )

BEGIN    
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

END; $$

DELIMITER ;


DROP PROCEDURE IF EXISTS sp_delete_maintenance_inventory;

DELIMITER $$

CREATE PROCEDURE sp_delete_maintenance_inventory(
	 automotive_parts_id_p INT,
	 reference_number_p VARCHAR(50),
    quantity_p VARCHAR(50)
  )

BEGIN    
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

END; $$

DELIMITER ;


DROP PROCEDURE IF EXISTS sp_delete_employee;
DELIMITER $$

CREATE PROCEDURE sp_delete_employee(id_p INT)
BEGIN   
    
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

END; $$

DELIMITER ;


DROP PROCEDURE IF EXISTS sp_update_maintenance_inventory_inventory;
DELIMITER $$

CREATE PROCEDURE sp_update_maintenance_inventory_inventory(
    maintenance_id_p INT,
    automotive_parts_id_p INT,
    reference_number_p VARCHAR(50),
	  quantity_maintenance_inventory_p INT,
    quantity_inventory_p INT
  )

BEGIN    
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

END; $$

DELIMITER ;

# collation_connection 
DROP PROCEDURE IF EXISTS sp_register_maintenance_inventory;
DELIMITER $$

CREATE PROCEDURE sp_register_maintenance_inventory(	  
    automotive_parts_Id_p INT,
    reference_number_p VARCHAR(100),
    maintenance_id_p INT,
    inventory_quantity_p INT,
    maintenance_inventory_quantity_p INT
    
  )

BEGIN    
    
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

END; $$

DELIMITER ;


