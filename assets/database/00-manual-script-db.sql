/*CREATE DATABASE 'workshopprime';*/

DROP TABLE IF EXISTS `auto_vehicle_workshops`;
CREATE TABLE IF NOT EXISTS `auto_vehicle_workshops` (
  `cnpj` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL unique,
  `business_name` varchar(50) NOT NULL unique,
  `address` varchar(255),  
  `phone_number` varchar(50) not null unique,
  `email` varchar(255) not null unique,  
  PRIMARY KEY (`cnpj`)  
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `employees`;
CREATE TABLE IF NOT EXISTS `employees` (
  `cpf` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL unique,  
  `address` varchar(255),  
  `phone_number` varchar(50) not null unique,
  `email` varchar(255) not null unique,  
  `position` varchar(255),  
  `cnpj_auto_vehicle_workshops_fk` varchar(50) not null,  
  
  PRIMARY KEY (`cpf`),
  FOREIGN KEY (`cnpj_auto_vehicle_workshops_fk`) REFERENCES `auto_vehicle_workshops`(`cnpj`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `manages`;
CREATE TABLE IF NOT EXISTS `manages` (
  `cpf` varchar(50) NOT NULL,  
  
  PRIMARY KEY (`cpf`),
  FOREIGN KEY (`cpf`) REFERENCES `employees`(`cpf`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `mechanics`;
CREATE TABLE IF NOT EXISTS `mechanics` (
  `cpf` varchar(50) NOT NULL,  
  
  PRIMARY KEY (`cpf`),
  FOREIGN KEY (`cpf`) REFERENCES `employees`(`cpf`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `attendants`;
CREATE TABLE IF NOT EXISTS `attendants` (
  `cpf` varchar(50) NOT NULL,  
  
  PRIMARY KEY (`cpf`),
  FOREIGN KEY (`cpf`) REFERENCES `employees`(`cpf`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `cpf` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL unique,   
  `password` varchar(255) NOT NULL, 
  `status` tinyint(1) default 1, 
	
  PRIMARY KEY (`cpf`),
  FOREIGN KEY (`cpf`) REFERENCES `employees`(`cpf`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `suppliers`;
CREATE TABLE IF NOT EXISTS `suppliers` (
  `cnpj` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL unique,
  `business_name` varchar(50) NOT NULL unique,
  `address` varchar(255),  
  `phone_number` varchar(50) not null unique,
  `email` varchar(255) not null unique,  
  `brachActivity` varchar(255) unique, 
  `cnpj_auto_vehicle_workstops_fk` varchar(50) not null,
  
  PRIMARY KEY (`cnpj`),
  FOREIGN KEY (`cnpj_auto_vehicle_workstops_fk`) REFERENCES `auto_vehicle_workshops`(`cnpj`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `customers`;
CREATE TABLE IF NOT EXISTS `customers` (
  `cpf` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,  
  `address` varchar(255),  
  `phone_number` varchar(50) not null unique,
  `email` varchar(255) unique,    
  `cnpj_auto_vehicle_workstops_fk` varchar(50) not null,
  
  PRIMARY KEY (`cpf`),
  FOREIGN KEY (`cnpj_auto_vehicle_workstops_fk`) REFERENCES `auto_vehicle_workshops`(`cnpj`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `vehicles`;
CREATE TABLE IF NOT EXISTS `vehicles` (
  `model` varchar(50) NOT NULL,
  `brand` varchar(50) NOT NULL,  
  
  PRIMARY KEY (`model`) 
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `vehicles_customer`;
CREATE TABLE IF NOT EXISTS `vehicles_customer` (
  `license_plate` varchar(50) NOT NULL,
  `cpf_customer_fk` varchar(50) NOT NULL,  
  `model_vehicles_fk` varchar(50) NOT NULL,
  
  PRIMARY KEY (`license_plate`).
  FOREIGN KEY (`cpf_customer_fk`) REFERENCES `customer`(`cpf`) ,
  FOREIGN KEY (`model_vehicles_fk`) REFERENCES `vehicles`(`model`) 

) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `automotive_parts`;
CREATE TABLE IF NOT EXISTS `automotive_parts` (
  `image_address` varchar(255),
  `reference_number` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text,    
  `unit_value` decimal NOT NULL,
  `brand` varchar(50) NOT NULL, 
  `status` tinyint default 1, 
  
  PRIMARY KEY (`reference_number`) 
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `vehicles_automotive_parts`;
CREATE TABLE IF NOT EXISTS `vehicles_automotive_parts` (
  `reference_number_automotive_parts` varchar(50) NOT NULL,
  `model_vehicles` varchar(50) NOT NULL,  
  
  PRIMARY KEY (`reference_number_automotive_parts`, `model_vehicles`),   
  FOREIGN KEY (`reference_number_automotive_parts`) REFERENCES `automotive_parts`(`reference_number`),
  FOREIGN KEY (`model_vehicles`) REFERENCES `vehicles`(`model`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `maintenance`;
CREATE TABLE IF NOT EXISTS `maintenance` (
  `id` int not null auto_increment,
  `reason` varchar(50) NOT NULL,
  `description` text,
  `status` tinyint default 0,  
  `initialDate` datetime,
  `finalDate` datetime,
  `license_plate_vehicles_customer_fk` varchar(50) NOT NULL
  
  PRIMARY KEY (`id`),   
  FOREIGN KEY (`license_plate_vehicles_customer_fk`) REFERENCES `vehicles_customer`(`license_plate`)  
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `inventory`;
CREATE TABLE IF NOT EXISTS `inventory` (
  `reference_number` varchar(50) NOT NULL,
  `quantity` int NOT NULL,  
  
  PRIMARY KEY (`reference_number`),   
  FOREIGN KEY (`reference_number`) REFERENCES `automotive_parts`(`reference_number`)  
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `maintenance_inventory`;
CREATE TABLE IF NOT EXISTS `maintenance_inventory` (
  `reference_number` varchar(50) NOT NULL,
  `id_maintenance` int NOT NULL,  
  
  PRIMARY KEY (`reference_number`,`id_maintenance`),   
  FOREIGN KEY (`reference_number`) REFERENCES `automotive_parts`(`reference_number`),  
  FOREIGN KEY (`id_maintenance`) REFERENCES `maintenance`(`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `services`;
CREATE TABLE IF NOT EXISTS `services` (
  `id` int not null auto_increment,   
  `name` varchar(50) unique not null,
  `description` text,
  `estimatedTime` varchar(50),
  `cost` decimal not null,
  `status` tinyint default 1, 
  `cnpj_auto_vehicle_workstops_fk` varchar(50) NOT NULL, 
  
  PRIMARY KEY (`id`),   
  FOREIGN KEY (`cnpj_auto_vehicle_workstops_fk`) REFERENCES `auto_vehicle_workshops`(`cnpj`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `services_provided`;
CREATE TABLE IF NOT EXISTS `services_provided` (
  `id` int not null auto_increment,   
  `initial_date` datetime,
  `final_date` datetime,
  `id_maintenance_fk` int NOT NULL,  
  `cpf_mechanics_fk` varchar(50) NOT NULL,
  `id_services_fk` int NOT NULL, 
  
  PRIMARY KEY (`id`),   
  FOREIGN KEY (`id_maintenance_fk`) REFERENCES `maintenance`(`id`),
  FOREIGN KEY (`cpf_mechanics_fk`) REFERENCES `mechanics`(`cpf`),
  FOREIGN KEY (`id_services_fk`) REFERENCES `services`(`id`)  
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4;

/*
DROP TABLE IF EXISTS `work_orders`;
CREATE TABLE IF NOT EXISTS `work_orders` (
  `id` int not null auto_increment,   
  `warranty` varchar(50) not null,
  `date` datetime,
  `total` decimal not null,
  `id_maintenance_fk` int NOT NULL unique, //I think this is wrong  
  `id_payment_fk` int NOT NULL, 
  
  PRIMARY KEY (`id`),   
  FOREIGN KEY (`id_maintenance_fk`) REFERENCES `maintenance`(`id`),  //I think this is wrong 
  FOREIGN KEY (`id_payment_fk`) REFERENCES `services`(`id`)  //I think this is wrong 
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4;

*/

DROP TABLE IF EXISTS `work_orders`;
CREATE TABLE IF NOT EXISTS `work_orders` (
  `id` int not null auto_increment,   
  `warranty` varchar(50) not null,
  `date` datetime default now(),
  `total` decimal not null,
  `id_maintenance_fk` int NOT NULL unique, 
  `status` tinyint default 0, 
  
  PRIMARY KEY (`id`) 
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4;

/* populating the database */

insert into auto_vehicle_workshops (cnpj, name, business_name,address, phone_number, email) values('01187817000183', 'Workshop Prime', 'Workshop Prime', 'Rua 24, n° 1234, Automóvel Central, Cidade dos Motores-CE, Brasil', '8587965433', 'workshopprime@gmail.com');

insert into employees (cpf, name, address, phone_number, email, position, cnpj_auto_vehicle_workshops_fk) 
values('62565411030', 'Cassio Malvarisco', 'Rua F, n° 1634, Parque das flores, Cidade dos Altos-CE, Brasil', 
'8588965833', 'cassiomalvarisco@hotmail.com', 'gerente', '01187817000183');

insert into employees (cpf, name, address, phone_number, email, position, cnpj_auto_vehicle_workshops_fk) 
values('82178774083', 'Angelo Tavares', 'Rua 22, n° 34, Bom Jardim, Cidade Baixa-CE, Brasil', 
'8599465833', 'angelotavares@outlook.com', 'atendente', '01187817000183');

insert into employees (cpf, name, address, phone_number, email, position, cnpj_auto_vehicle_workshops_fk) 
values('01069520055', 'Leticia Juliana', 'Rua 64, n° 03, Parque Jardim, Cidade Media-CE, Brasil', 
'8590765833', 'leticiajuliana@gmail.com', 'atendente', '01187817000183');

insert into employees (cpf, name, address, phone_number, email, position, cnpj_auto_vehicle_workshops_fk) 
values('41740738055', 'João Juliano', 'Rua 64, n° 03, Parque Jardim, Cidade Media-CE, Brasil', 
'8590665833', 'joaojuliano@gmail.com', 'mecânico', '01187817000183');

insert into employees (cpf, name, address, phone_number, email, position, cnpj_auto_vehicle_workshops_fk) 
values('46899032040', 'Pedro Gustavo', 'Rua A, n° 11, Parque Jardim, Cidade Media-CE, Brasil', 
'8597765833', 'pedrogustavo@gmail.com', 'mecânico', '01187817000183');

insert into employees (cpf, name, address, phone_number, email, position, cnpj_auto_vehicle_workshops_fk) 
values('31685403077', 'Antonio Ferreira', 'Rua Z, n° 98, Parque alvoras, Cidade Normal-CE, Brasil', 
'8597788833', 'antonioferreia@yahoo.com', 'mecânico', '01187817000183');

INSERT INTO `workshopprime`.`mechanics` (`cpf`) VALUES ('41740738055');
INSERT INTO `workshopprime`.`mechanics` (`cpf`) VALUES ('46899032040');
INSERT INTO `workshopprime`.`mechanics` (`cpf`) VALUES ('31685403077');

INSERT INTO `workshopprime`.`manages` (`cpf`) VALUES ('62565411030');

INSERT INTO `workshopprime`.`attendants` (`cpf`) VALUES ('01069520055');
INSERT INTO `workshopprime`.`attendants` (`cpf`) VALUES ('82178774083');

insert into users (cpf, username, password) 
values('62565411030', 'cassio00', '$2y$10$.0URBGQDyTW77ezc/iy.FOD9zVODmuQIE0HuRSeW9cocuEso3Uzye');

insert into users (cpf, username, password) 
values('82178774083', 'angelo24', '$2y$10$.0URBGQDyTW77ezc/iy.FOD9zVODmuQIE0HuRSeW9cocuEso3Uzye');

insert into users (cpf, username, password) 
values('01069520055', 'leticia66', '$2y$10$.0URBGQDyTW77ezc/iy.FOD9zVODmuQIE0HuRSeW9cocuEso3Uzye');

insert into users (cpf, username, password) 
values('41740738055', 'joao01', '$2y$10$.0URBGQDyTW77ezc/iy.FOD9zVODmuQIE0HuRSeW9cocuEso3Uzye');

insert into users (cpf, username, password) 
values('46899032040', 'pedro01', '$2y$10$.0URBGQDyTW77ezc/iy.FOD9zVODmuQIE0HuRSeW9cocuEso3Uzye');

insert into users (cpf, username, password) 
values('31685403077', 'antonioo01', '$2y$10$.0URBGQDyTW77ezc/iy.FOD9zVODmuQIE0HuRSeW9cocuEso3Uzye');

insert into suppliers (cnpj, name, business_name, address, phone_number, email, brachActivity, cnpj_auto_vehicle_workstops_fk) 
values('60655945000173','Bosch','Robert Bosch Ltda','Rua W, n° 98, Parque Tocas, Cidade Normal-CE, Brasil','8588873266',
'bosch@yahoo.com','Fabricante de equipamentos automotivos e peças','01187817000183');

insert into suppliers (cnpj, name, business_name, address, phone_number, email, brachActivity, cnpj_auto_vehicle_workstops_fk) 
values('82804111000115','3M','3M do Brasil Ltda','Rua Y, n° 55, Sola Aí, Cidade Fortaleza-CE, Brasil','8588776544',
'3M@yempresa.com','ornecedora de produtos automotivos, como lixas, adesivos e polidores','01187817000183');

insert into suppliers (cnpj, name, business_name, address, phone_number, email, brachActivity, cnpj_auto_vehicle_workstops_fk) 
values('12557378000170','Pirelli','Pirelli Pneus Ltda','Rua P, n° 11, Maga, Cidade Pacajus-CE, Brasil','8588006544',
'pirelli@yempresa.com','fabricante de pneus automotivos','01187817000183');

insert into customers (cpf, name, address, phone_number, email, cnpj_auto_vehicle_workstops_fk) 
values('03966183080','Juliano Pasquim','Rua T, n° 10,Chico da Doca, Cidade Paçoca-CE, Brasil','8588873217',
'julianopasquim@outlook.com','01187817000183');

insert into customers (cpf, name, address, phone_number, email, cnpj_auto_vehicle_workstops_fk) 
values('29012056071','Paula Abreu','Rua B, n° 10,Chico Tico, Cidade Paçoca-CE, Brasil','8588879917',
'paulaabreu@outlook.com','01187817000183');

insert into customers (cpf, name, address, phone_number, email, cnpj_auto_vehicle_workstops_fk) 
values('11924265095','Ivan Nildo','Rua C, n° 11, Tata Tico, Cidade Pamanha-CE, Brasil','8587779917',
'ivannildo@outlook.com','01187817000183');

insert into vehicles (model, brand) 
values('Grand Cherokee Limited LX 5.9','Jeep');
insert into vehicles_customer (license_plate, cpf_customer_fk, model_vehicles_fk) 
values('MXQ9131','03966183080','Grand Cherokee Limited LX 5.9');

insert into vehicles (model, brand) 
values('CT200h F-Sport 1.8 16V HIBRID Aut.','Lexus');
insert into vehicles_customer (license_plate, cpf_customer_fk, model_vehicles_fk) 
values('LST5307','29012056071','CT200h F-Sport 1.8 16V HIBRID Aut.');

insert into vehicles (model, brand) 
values('Mystique GS 2.5 V6 Mec.','Mercury');
insert into vehicles_customer (license_plate, cpf_customer_fk, model_vehicles_fk) 
values('HPP2304','11924265095','Mystique GS 2.5 V6 Mec.');

insert into automotive_parts (reference_number, name, brand, description, unit_value) 
values('12345','Filtro de Óleo','Fram','Este filtro de óleo Fram possui uma classificação de eficiência de filtração de 98%, com uma capacidade de retenção de partículas de até 10 micra, protegendo o motor contra desgaste prematuro.', 15.00);

insert into automotive_parts (reference_number, name, brand, description, unit_value) 
values('67890','Pastilhas de Freio','Brembo','Pastilhas de freio Brembo são componentes do sistema de freio que fornecem frenagem segura e eficaz.', 50.00);

insert into automotive_parts (reference_number, name, brand, description, unit_value) 
values('54321','Bateria de Carro','AC Delco','A bateria AC Delco é uma bateria de chumbo-ácido de 12 volts, com uma capacidade nominal de 60 ampères-hora (Ah) e uma resistência interna baixa, fornecendo uma corrente de partida confiável', 150.00);

insert into automotive_parts (reference_number, name, brand, description, unit_value) 
values('98765','Filtro de Ar','NGK', 'O filtro de ar K&N é um filtro de alto fluxo, projetado para aumentar a capacidade de fluxo de ar em até 50%, mantendo uma eficiência de filtração de 99%, com uma capacidade de retenção de partículas de até 2 micra.', 20.00);

insert into automotive_parts (reference_number, name, brand, description, unit_value) 
values('23456','Vela de Ignição','K&N', 'As velas de ignição NGK são fabricadas com eletrodos de níquel-cromo e possuem uma faixa térmica de calor médio, garantindo ignição precisa e confiável em uma ampla gama de temperaturas e condições.', 90.00);

insert into automotive_parts (reference_number, name, brand, description, unit_value) 
values('M78901','Corrente de Transmissão','DID','A corrente de transmissão DID é uma corrente de rolos selada com uma classificação de resistência à tração de 8.000 libras, projetada para transmitir potência eficientemente com uma vida útil prolongada.', 300.00);

insert into automotive_parts (reference_number, name, brand, description, unit_value) 
values('M23456','Disco de Freio','EBC','Os discos de freio EBC são feitos de aço inoxidável endurecido e possuem ranhuras para dissipação de calor, proporcionando um desempenho de frenagem consistente e eficiente.', 200.00);

insert into automotive_parts (reference_number, name, brand, description, unit_value) 
values('M65432','Vela de Ignição','Denso','As velas de ignição Denso são feitas de cerâmica isolante e possuem uma resistência de 0,8 ohms, garantindo ignição eficaz e redução do consumo de combustível.', 10.00);

insert into automotive_parts (reference_number, name, brand, description, unit_value) 
values('M12345','Filtro de Ar','K&N','Os filtros de ar K&N possuem uma capacidade de fluxo de ar de 1.000 CFM (pés cúbicos por minuto) a uma restrição de 1 polegada de água, proporcionando um aumento significativo no fluxo de ar.', 80.00);

insert into automotive_parts (reference_number, name, brand, description, unit_value) 
values('M87654','Pneu Traseiro','Michelin','O pneu traseiro Michelin possui uma construção radial com uma classificação de velocidade de até 180 km/h, oferecendo aderência excepcional em uma variedade de condições de pilotagem.', 50.00);

insert into maintenance(id, reason, description, status, initialDate, finalDate, license_plate_vehicles_customer_fk) 
values(default, 'Carro não liga','Quando giro a chave ele faz tantaaaatan',0, null, null, 'MXQ9131');

insert into maintenance(reason, description, status, license_plate_vehicles_customer_fk) 
values('Pneu vazio','Passei por cima de um prego',0,'LST5307');

insert into maintenance(reason, description, status, license_plate_vehicles_customer_fk) 
values('farol esquerdo piscando','uma bola bateu nele',0,'HPP2304');

insert into inventory(reference_number, quantity) 
values('12345',200);

insert into inventory(reference_number, quantity) 
values('67890',30);

insert into inventory(reference_number, quantity) 
values('54321',100);

insert into inventory(reference_number, quantity) 
values('98765',250);

insert into inventory(reference_number, quantity) 
values('23456',5);

insert into inventory(reference_number, quantity) 
values('M78901',1);

insert into inventory(reference_number, quantity) 
values('M23456',0);

insert into inventory(reference_number, quantity) 
values('M65432',35);

insert into inventory(reference_number, quantity) 
values('M12345',10);

insert into inventory(reference_number, quantity) 
values('M87654',13);

insert into maintenance_inventory(reference_number, id_maintenance) 
values('23456',35);

insert into maintenance_inventory(reference_number, id_maintenance) 
values('23456',35);

insert into maintenance_inventory(reference_number, id_maintenance) 
values('23456',36);

insert into maintenance_inventory(reference_number, id_maintenance) 
values('98765',37);

insert into services(name, description, estimatedTime, cost, cnpj_auto_vehicle_workstops_fk) 
values('Troca de vela de ingnição de carro','Pego a vela, tiro a antiga, coloco a nova','10',50.00,'01187817000183');

insert into services(name, description, estimatedTime, cost, cnpj_auto_vehicle_workstops_fk) 
values('Troca filtro de ar','Pego a filtro, tiro a antigo, coloco a novo','30',100.00,'01187817000183');

insert into services_provided(id_maintenance_fk, cpf_mechanics_fk, id_services_fk) 
values(35,'41740738055',35);

insert into services_provided(id_maintenance_fk, cpf_mechanics_fk, id_services_fk) 
values(36,'46899032040',35);

insert into services_provided(id_maintenance_fk, cpf_mechanics_fk, id_services_fk) 
values(37,'31685403077',36);

CREATE VIEW v_users 
AS SELECT users.cpf, users.username, users.password, employees.name, employees.position FROM users 
INNER JOIN employees on users.cpf = employees.cpf; 

CREATE VIEW v_inventory 
AS SELECT automotive_parts.reference_number, automotive_parts.image_address,  automotive_parts.name, inventory.quantity, automotive_parts.brand FROM automotive_parts 
INNER JOIN inventory on automotive_parts.reference_number = automotive_parts.reference_number; 

CREATE VIEW v_vehicles 
AS
SELECT customers.cpf, customers.name, customers.address, customers.phone_number, customers.email, vehicles_customer.model_vehicles_fk, vehicles_customer.license_plate, vehicles.brand FROM vehicles_customer
INNER JOIN vehicles 
on vehicles_customer.model_vehicles_fk = vehicles.model 
INNER JOIN customers 
on customers.cpf = vehicles_customer.cpf_customer_fk; 

DROP PROCEDURE IF EXISTS sp_vehicle_costumer;
DELIMITER $$

CREATE PROCEDURE sp_vehicle_costumer(
	 cpf_p VARCHAR(50),
    name_p VARCHAR(50),
    address_p VARCHAR(50),
    phoneNumber_p VARCHAR(50),
    email_p VARCHAR(50),
    cnpjAutoVehicleWorkstops_p VARCHAR(255),
    license_plate_p VARCHAR(50),
    model_p VARCHAR(50),
    brand_p VARCHAR(50)
  )

BEGIN    
    
	DECLARE num_model VARCHAR(100) DEFAULT '0';
    DECLARE track_no VARCHAR(10) DEFAULT '0/0';
    DECLARE EXIT HANDLER FOR SQLEXCEPTION, NOT FOUND, SQLWARNING
    
    BEGIN    
        GET DIAGNOSTICS CONDITION 1 @`errno` = MYSQL_ERRNO, @`sqlstate` = RETURNED_SQLSTATE, @`text` = MESSAGE_TEXT;
        SET @full_error = CONCAT('ERROR ', @`errno`, ' (', @`sqlstate`, '): ', @`text`);
        SELECT track_no, @full_error, num_model;

        ROLLBACK;    
    END;

    START TRANSACTION;
        SET track_no = '1/3';        
        INSERT INTO customers (cpf, name, address, phone_number, email, cnpj_auto_vehicle_workstops_fk) 
        VALUES(cpf_p, name_p, address_p, phoneNumber_p, email_p, cnpjAutoVehicleWorkstops_p);
              
        SET track_no = '2/3';  
        /* model_p COLLATE utf8mb4_0900_ai_ci --> aqui estou fazendo com que o valor da minha variavel tenha o msm  COLLATE da minha tabela, por consequencia dos meu campos, se eu nao forçar iss nao da certo */
        SELECT COUNT(model) INTO num_model FROM vehicles WHERE model_p COLLATE utf8mb4_0900_ai_ci = vehicles.model; 
        IF (num_model = '0') THEN
        	INSERT INTO vehicles(model, brand ) 
        	VALUES(model_p, brand_p);
    	  END IF;
        
        SET track_no = '3/3';
        INSERT INTO vehicles_customer (license_plate, cpf_customer_fk, model_vehicles_fk ) 
        VALUES(license_plate_p, cpf_p, model_p);
        
        SET track_no = '0/3';
        SELECT track_no, 'successfully executed.';
    COMMIT;

END; $$

DELIMITER ;


CALL sp_vehicle_costumer('85743380099','Julio Mautinho','Rua T, n° 33,Chico da Doca, Cidade Paçoca-CE, Brasil','8584473217',
'julio@outlook.com','01187817000183','NAY5700', 'Ranger XLS 3.0 PSE 163cv 4x2 CD TB Dies', 'Ford');

CALL sp_vehicle_costumer('09048491045','Mario Coiso','Rua T, n° 33,Chico da Doca, Cidade Paçoca-CE, Brasil','8584473211',
'mariocoiso@outlook.com','01187817000183','LRR3766', 'Chairman 3.2 V6 220cv Aut.', 'SSANGYONG');

CALL sp_vehicle_costumer('09048491555','Mariana Alta','Rua T, n° 33,Chico da Doca, Cidade Paçoca-CE, Brasil','8584773211',
'mariana@outlook.com','01187817000183','JKB9916', 'Sorento 3.5 V6 24V 278cv 4x2 Aut.', 'Kia Motors');


DROP PROCEDURE IF EXISTS sp_vehicle_costumer;
DELIMITER $$

CREATE PROCEDURE sp_vehicle_costumer(
	 cpf_p VARCHAR(50),
    name_p VARCHAR(50),
    address_p VARCHAR(50),
    phoneNumber_p VARCHAR(50),
    email_p VARCHAR(50),
    cnpjAutoVehicleWorkstops_p VARCHAR(255),
    license_plate_p VARCHAR(50),
    model_p VARCHAR(50),
    brand_p VARCHAR(50)
  )

BEGIN    
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

END; $$

DELIMITER ;


