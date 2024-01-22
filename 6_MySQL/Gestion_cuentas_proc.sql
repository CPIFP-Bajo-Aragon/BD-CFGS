drop database if exists banco_proc;
create database banco_proc;
use banco_proc;

DELIMITER $$
drop procedure if exists ALTA_SCHEMA$$
CREATE PROCEDURE ALTA_SCHEMA (OUT MENSAJE int) 
BEGIN
	DROP TABLE IF EXISTS APUNTES;
	DROP TABLE IF EXISTS CUENTA;
	
    CREATE TABLE CUENTA (
	 CUENTA CHAR(20) default '',
	 TITULAR CHAR(20) NOT NULL,
	TITULAR2 CHAR(20) NOT NULL,
	 IMPORTE_INICIAL DOUBLE(10,2) DEFAULT 0,
	IMPORTE_ACTUAL DOUBLE(10,2) DEFAULT 0,
	 PRIMARY KEY (CUENTA) )
	ENGINE=InnoDB; 

	CREATE TABLE APUNTES (
	 ASIENTO INT(8) auto_increment,
	 LINEA SMALLINT(5) DEFAULT 0,
	 FECHA DATE DEFAULT '2020-01-01',
	 CONCEPTO VARCHAR(40) default '',
	 CUENTA CHAR(20) default '',
	 IMPORTE DOUBLE(10,2) DEFAULT 0,
	 CONSTRAINT PK_APUNTES PRIMARY KEY (ASIENTO,FECHA),
	CONSTRAINT FK_CUENTA foreign key(CUENTA) REFERENCES CUENTA(CUENTA))
	ENGINE=InnoDB;
    
    SET MENSAJE=1;
END $$

DROP PROCEDURE IF EXISTS ALTA_DATOS_EJEMPLO;
CREATE PROCEDURE ALTA_DATOS_EJEMPLO (OUT MENSAJE VARCHAR(50))
BEGIN
	insert into CUENTA values('ES948443432842945938', 'Paco', 'Luis', 0,5923.32);
	insert into CUENTA values('ES958131232223425122', 'Mateo', 'Lewis', 0,542);
	insert into CUENTA values('ES242342284225667743', 'Chis', 'Kiss', 520,1354);
	insert into Apuntes values(0, 1, '2020-02-03', 'Ingreso', 'ES948443432842945938', 942);
	insert into Apuntes values(0, 2, '2020-02-03', 'Retirada', 'ES948443432842945938', 50);
	SET MENSAJE="DATOS DE EJEMPLO DADOS DE ALTA CORRECTAMENTE";
END $$

DELIMITER ;

call alta_schema(@mensaje_estructura);
select @mensaje_estructura;
call ALTA_DATOS_EJEMPLO(@mensaje_altadatos);
select  @mensaje_altadatos;