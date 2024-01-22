
CREATE SCHEMA IF NOT EXISTS banco_proc_commit;
USE banco_proc;

DELIMITER $$
DROP PROCEDURE if exists  ALTA_LOG$$
CREATE PROCEDURE ALTA_LOG()
BEGIN
	declare exit HANDLER FOR sqlexception
	begin
		GET diagnostics condition 1 @var1 = message_text, @var2=returned_sqlstate;
		rollback;  -- deshago todas las acciones realizadas en la transaction.
        insert into LOG_SCRIPT values (0,'alta tabla log',concat('ERROR ', @var1 , ' - ',@var2),current_timestamp());
	end;
    	
	start transaction;
	CREATE TABLE LOG_SCRIPT (
		ID_LOG int auto_increment primary key,
		proc_name VARCHAR(60) default '',
		mensaje VARCHAR(100) default '',
		FECHA timestamp DEFAULT current_timestamp)
		ENGINE=InnoDB;
	commit;
end$$
DELIMITER ;	

DELIMITER $$
DROP PROCEDURE if exists  ALTA_SCHEMA$$
CREATE PROCEDURE ALTA_SCHEMA()
BEGIN
	declare exit HANDLER FOR sqlexception
	begin
		GET diagnostics condition 1 @var1 = message_text, @var2=returned_sqlstate;
		rollback;  -- deshago todas las acciones realizadas en la transaction.
        insert into LOG_SCRIPT values (0,'alta esquema',concat('ERROR ', @var1 , ' - ',@var2),current_timestamp());
	end;
    	
	start transaction;
	DROP TABLE IF EXISTS APUNTES;
	DROP TABLE IF EXISTS CUENTA;
    DROP TABLE IF EXISTS LOG_SCRIPT;
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
    commit;
	insert into LOG_SCRIPT values (0,'alta ejemplos',concat('DATOS DE EJEMPLO DATOS DE ALTA CORRECTAMENTE - ',@filas),current_timestamp());
END$$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE if exists ALTA_DATOS_EJEMPLO$$
CREATE PROCEDURE ALTA_DATOS_EJEMPLO()
BEGIN
	declare exit HANDLER FOR sqlexception
	begin
		GET diagnostics condition 1 @var1 = message_text, @var2=returned_sqlstate;
		rollback;  -- deshago todas las acciones realizadas en la transaction.
        insert into LOG_SCRIPT values (0,'alta ejemplos',concat('ERROR ', @var1 , ' - ',@var2),current_timestamp());
	end;
    	
	start transaction;
    insert into CUENTA values('ES948443432842945938', 'Paco', 'Luis', 0,5923.32);
	insert into CUENTA values('ES958131232223425122', 'Mateo', 'Lewis', 0,542);
	insert into CUENTA values('ES242342284225667743', 'Chis', 'Kiss', 520,1354);
    insert into CUENTA values('ES948443432842945939', 'Paco-1', 'Luis', 0,5923.32);
	insert into CUENTA values('ES958131232223425123', 'Mateo-1', 'Lewis', 0,542);
	insert into CUENTA values('ES242342284225667741', 'Chis-1', 'Kiss', 520,1354); 
    insert into CUENTA values('ES948443432842945937', 'Paco-2', 'Luis', 0,5923.32);
	insert into CUENTA values('ES958131232223425125', 'Mateo-2', 'Lewis', 0,542);
	insert into CUENTA values('ES242342284225667746', 'Chis-2', 'Kiss', 520,1354);
    insert into Apuntes values(0, 1, '2020-02-03', 'Ingreso', 'ES948443432842945938', 942);
	insert into Apuntes values(0, 2, '2020-02-03', 'Retirada', 'ES948443432842945938', 50);
	insert into Apuntes values(0, 3, '2020-02-03', 'Ingreso', 'ES948443432842945938', 8942);
	insert into Apuntes values(0, 4, '2020-02-03', 'Retirada', 'ES948443432842945938', 150);
    insert into Apuntes values(0, 1, '2020-02-03', 'Ingreso', 'ES242342284225667743', 1942);
	insert into Apuntes values(0, 2, '2020-02-03', 'Retirada', 'ES242342284225667743', 510);
	insert into Apuntes values(0, 3, '2020-02-03', 'Ingreso', 'ES242342284225667743', 9142);
	insert into Apuntes values(0, 4, '2020-02-03', 'Retirada', 'ES242342284225667743', 5110);
    commit;
	insert into LOG_SCRIPT values (0,'alta ejemplos',concat('DATOS DE EJEMPLO DATOS DE ALTA CORRECTAMENTE - ',@filas),current_timestamp());
END$$
DELIMITER ;



declare exit HANDLER FOR sqlexception
	begin
		rollback;  
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='DA DE ALTA EN LA TABLA PADRE';
	end; 	
start transaction;
CALL ALTA_LOG();
CALL ALTA_SCHEMA();
CALL ALTA_DATOS_EJEMPLO();
commit;




