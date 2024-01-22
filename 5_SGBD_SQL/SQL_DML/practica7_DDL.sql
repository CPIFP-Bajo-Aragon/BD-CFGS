CREATE DATABASE PRACTICA_7;
USE PRACTICA_7;

DROP TABLE IF EXISTS `edificio`;
CREATE TABLE `edificio` (
  `ID_E` int(11) NOT NULL,
  `DIR` char(15) NOT NULL,
  `TIPO` char(10) NOT NULL,
  `NIVEL_CALIDAD` int(11) NOT NULL,
  `CATEGORIA` int(11) NOT NULL,
  PRIMARY KEY (`ID_E`),
  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `trabajador`;
CREATE TABLE `trabajador` (
  `ID_T` int(11) NOT NULL,
  `NOMBRE` char(20) NOT NULL,
  `TARIFA` double NOT NULL,
  `OFICIO` char(15) NOT NULL,
  `ID_SUPV` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_T`),
  CONSTRAINT `FK_SUPERVISOR` FOREIGN KEY (`ID_SUPV`) REFERENCES `trabajador` (`ID_T`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `asignacion`;
CREATE TABLE `asignacion` (
  `ID_T` int(11) NOT NULL,
  `ID_E` int(11) NOT NULL,
  `FECHA_INICIO` datetime NOT NULL,
  `NUM_DIAS` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_T`,`ID_E`,`FECHA_INICIO`),
  CONSTRAINT `FK_EDIFICIO` FOREIGN KEY (`ID_E`) REFERENCES `edificio` (`ID_E`),
  CONSTRAINT `FK_TRABAJADOR` FOREIGN KEY (`ID_T`) REFERENCES `trabajador` (`ID_T`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- alta de registros para cada tabla
--
INSERT INTO `edificio` VALUES (111,'1213 ASPEN','OFICINA',4,1),(210,'1011 BIRCH','OFICINA',3,1),(312,'123 ELM','OFICINA',2,2),(435,'456 MAPLE','COMERCIO',1,1),(460,'1415 BEACH','ALMACEN',3,3),(515,'789 OAK','RESIDENCIA',3,2);
INSERT INTO `trabajador` VALUES (1311,'C. COULOMB',15.5,'ELECTRICISTA',1311),(1235,'M. FARADAY',12.5,'ELECTRICISTA',1311),(1520,'H. RICKOVER',11.75,'FONTANERO',1520),(1412,'C. NEMO',13.75,'FONTANERO',1520),(2920,'R. GARRET',10,'ALBANIL',2920),(3231,'P. MASON',17.4,'CARPINTERO',3231),(3001,'J. BARRISTER',8.2,'CARPINTERO',3231);
INSERT INTO `asignacion` VALUES (1235,312,'2018-02-21 00:00:00',5),(1235,515,'2018-02-21 00:00:00',22),(1311,435,'2018-02-21 00:00:00',12),(1311,460,'2018-02-21 00:00:00',24),(1412,111,'2018-02-21 00:00:00',4),(1412,210,'2018-02-21 00:00:00',12),(1412,312,'2018-02-21 00:00:00',10),(1412,435,'2018-02-21 00:00:00',15),(1412,460,'2018-02-21 00:00:00',18),(1412,515,'2018-02-21 00:00:00',8),(1520,312,'2018-02-21 00:00:00',17),(1520,515,'2018-02-21 00:00:00',14),(2920,210,'2018-02-21 00:00:00',15),(2920,435,'2018-02-21 00:00:00',10),(2920,460,'2018-02-21 00:00:00',18),(3001,111,'2018-02-21 00:00:00',14),(3001,210,'2018-02-21 00:00:00',14),(3231,111,'2018-02-21 00:00:00',8),(3231,312,'2018-02-21 00:00:00',20);
