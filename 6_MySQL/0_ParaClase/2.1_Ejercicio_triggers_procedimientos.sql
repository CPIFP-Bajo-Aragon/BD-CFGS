CREATE TABLE clientes(
	id_cliente int not null auto_increment,
	nombre varchar(100),
	seccion varchar(20),
	accion varchar(10) default 'nada',
	PRIMARY KEY(id_cliente),
	KEY(nombre)
)ENGINE=InnoDB;

CREATE TABLE auditoria_clientes(
	id int not null auto_increment,
	nombre_anterior varchar(100),
	seccion_anterior varchar(20),
	nombre_nuevo varchar(100),
	seccion_nueva varchar(20),
	usuario varchar(40),
	modificado datetime,
	proceso varchar(10),
	id_cliente int(4),
	primary key(id)
)ENGINE=InnoDB;

DROP TRIGGER IF EXISTS AUDITORIA_CLIENTES_INSERT;
CREATE TRIGGER AUDITORIA_CLIENTES_INSERT AFTER INSERT ON clientes
FOR EACH ROW 
INSERT INTO auditoria_clientes
VALUES('0','', '',NEW.nombre,NEW.seccion,current_user(),sysdate(),'INSERT',NEW.id_cliente);

DROP TRIGGER IF EXISTS AUDITORIA_CLIENTES_DELETE;
CREATE TRIGGER AUDITORIA_CLIENTES_DELETE AFTER DELETE ON clientes
FOR EACH ROW 
INSERT INTO auditoria_clientes
VALUES('0',OLD.nombre,OLD.seccion,'','',current_user(),sysdate(),'DELETE',OLD.id_cliente);

DROP TRIGGER IF EXISTS AUDITORIA_CLIENTES_UPDATE;
CREATE TRIGGER AUDITORIA_CLIENTES_UPDATE AFTER UPDATE ON clientes
FOR EACH ROW
INSERT INTO auditoria_clientes
VALUES('0',OLD.nombre, OLD.seccion, NEW.nombre,NEW.seccion,current_user(),sysdate(),'UPDATE',new.id_cliente);

INSERT INTO clientes VALUES('0','nombre1','seccion1','accion1');
INSERT INTO clientes VALUES('0','nombre2','seccion2','accion2');
INSERT INTO clientes VALUES('0','nombre3','seccion3','accion3');
INSERT INTO clientes VALUES('0','nombre4','seccion4','accion4');

UPDATE clientes SET nombre='PARA BORRAR' WHERE nombre in( 'nombre1', 'nombre4');

DELETE FROM clientes WHERE nombre='PARA BORRAR';

/* PROCEDIMIENTOS SOBRE LA BASE DE DATOS */

DROP PROCEDURE IF EXISTS ALTA_CLIENTES;
DELIMITER $$
CREATE PROCEDURE ALTA_CLIENTES (IN PAR1 VARCHAR(100), IN PAR2 VARCHAR (20), IN PAR3 VARCHAR (10), OUT MSG VARCHAR(100))
BEGIN
	DECLARE NEW_ID, EXISTE INTEGER;    
    SELECT IFNULL(max(id_cliente),0) INTO EXISTE FROM CLIENTES WHERE nombre=PAR1;
    
    IF EXISTE=0 THEN 
		INSERT INTO CLIENTES VALUES (NEW_ID, PAR1, PAR2, PAR2);
		SET MSG='EL CLIENTE SE HA DADO DE ALTA CORRECTAMENTE';
	else
		SET MSG='EL CLIENTE YA EXISTE';
	end if;
END$$
DELIMITER ;

CALL ALTA_CLIENTES('nombre1','seccion1','accion1', @mensaje);
select @mensaje;

CALL ALTA_CLIENTES('nombre11','seccion11','accion11', @mensaje);
select @mensaje;

DROP PROCEDURE IF EXISTS BAJA_CLIENTE;
DELIMITER $$
CREATE PROCEDURE BAJA_CLIENTE (IN PAR1 VARCHAR(100), OUT MSG VARCHAR(100))
BEGIN
	DECLARE EXISTE INTEGER;    
    SELECT IFNULL(max(id_cliente),0) INTO EXISTE FROM CLIENTES WHERE nombre=PAR1;
    
    IF EXISTE<>0 THEN 
		DELETE FROM CLIENTES WHERE NOMBRE=PAR1;
		SET MSG='EL CLIENTE SE HA ELIMINADO';
	else
		SET MSG='EL CLIENTE NO EXISTE';
	end if;
END$$
DELIMITER ;

CALL BAJA_CLIENTE('nombre16', @mensaje);
select @mensaje;

CALL BAJA_CLIENTE('nombre1', @mensaje);
select @mensaje;