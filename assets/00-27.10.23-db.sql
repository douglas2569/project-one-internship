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
  `position` varchar(255) unique,  
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



