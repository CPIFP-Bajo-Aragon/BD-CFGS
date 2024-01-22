CREATE SCHEMA CLASE1;
USE CLASE1;

/* CREACION DE LAS TABLAS */
DROP TABLE IF EXISTS usuarios;
CREATE TABLE usuarios(
id int primary key, 
user varchar(50) not null default '' UNIQUE, 
password varchar(25)
);

DROP TABLE IF EXISTS log_usuarios;NUEVO_USUARIO
CREATE TABLE log_usuarios(
id int auto_increment primary key,
fecha timestamp, 
action varchar(255) not null default '', 
event varchar(15));

/* CREACION TRIGGER PARA INSERCION */
drop trigger IF exists LOG_USER_INSERT;
CREATE TRIGGER LOG_USER_INSERT after insert ON usuarios FOR EACH ROW 
INSERT INTO log_usuarios VALUES('0', sysdate(),CONCAT('Alta del ususario ', NEW.user ,' ',NEW.password), 'INSERT');

/* CREACION TRIGGER PARA ELIMINACION */
drop trigger IF exists LOG_USER_DELETE;
CREATE TRIGGER LOG_USER_DELETE after delete ON usuarios FOR EACH ROW 
INSERT INTO log_usuarios VALUES('0', sysdate(),concat('Baja del ususario ', OLD.user), 'DELETE');

/* CREACION TRIGGER PARA ACTUALIZACION PASSWORD */
drop trigger IF exists LOG_USER_UPDATE;
CREATE TRIGGER LOG_USER_UPDATE after update ON usuarios FOR EACH ROW 
INSERT INTO log_usuarios VALUES('0', sysdate(),concat('Actualizacion password del ususario ', NEW.user , ' de ', OLD.password , ' a ', NEW.password), 'UPDATE');

delete from usuarios;
SELECT * FROM log_usuarios;
SELECT * FROM usuarios;
INSERT INTO usuarios VALUES(1, 'usuario 1', 'pass 1');
INSERT INTO usuarios VALUES(2, 'usuario 2', 'pass 2');
INSERT INTO usuarios VALUES(3, 'usuario 3', 'pass 3');
INSERT INTO usuarios VALUES(4, 'usuario 4', 'pass 4');
INSERT INTO usuarios VALUES(5, 'usuario 5', 'pass 5');
INSERT INTO usuarios VALUES(6, 'usuario 6', 'pass 6');
SELECT * FROM log_usuarios;

DELETE FROM usuarios where id='3';
UPDATE usuarios SET password='nuevo password';
SELECT * FROM log_usuarios;

/* ALTA DE PROCEDIMIENTOS Y FUNCIONES */

USE CLASE1;
DROP PROCEDURE IF EXISTS ALTA_USUARIO;
DELIMITER $$
CREATE PROCEDURE ALTA_USUARIO (IN PAR1 VARCHAR(25), IN PAR2 VARCHAR (25), OUT MSG VARCHAR(100))
BEGIN
	DECLARE NEW_ID, EXISTE INTEGER;
    
    SELECT IFNULL(max(ID),0) INTO EXISTE FROM USUARIOS WHERE USER=PAR1;
    
    IF EXISTE=0 THEN 
		select nuevo_usuario() into NEW_ID;
		INSERT INTO USUARIOS VALUES (NEW_ID, PAR1, PAR2);
		SET MSG='EL USUARIO SE HA DADO DE ALTA CORRECTAMENTE';
	else
		SET MSG='EL USUARIO YA EXISTE';
	end if;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS BAJA_USUARIO;
DELIMITER $$
CREATE PROCEDURE BAJA_USUARIO(IN PAR1 VARCHAR(25))
BEGIN
    DECLARE EXISTE INTEGER;
    DECLARE MSG VARCHAR(50);
    
    SELECT IFNULL(ID,0) INTO EXISTE FROM USUARIOS WHERE USER=PAR1;
	IF EXISTE<>0 THEN 
		DELETE FROM USUARIOS WHERE USUARIO=PAR1;
        SET MSG='EL USUARIO SE HA BORRADO CORRECTAMENTE';
    else
		SET MSG='EL USUARIO NO EXISTE';
    END IF;
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = MSG; 
END
$$
DELIMITER ;

SELECT * FROM usuarios;
SELECT * FROM log_usuarios;

CALL ALTA_USUARIO('usuario 1', 'pass 1', @mensaje);
select @mensaje;
CALL ALTA_USUARIO('usuario 2', 'pass 2', @mensaje);
select @mensaje;
CALL ALTA_USUARIO('usuario 3', 'pass 3', @mensaje);
select @mensaje;
CALL ALTA_USUARIO('usuario 4', 'pass 4', @mensaje);
select @mensaje;
CALL ALTA_USUARIO('usuario 5', 'pass 5', @mensaje);
select @mensaje;
CALL ALTA_USUARIO('usuario 6', 'pass 6', @mensaje);
select @mensaje;
CALL ALTA_USUARIO('usuario 7', 'pass 7', @mensaje);
select @mensaje;

CALL BAJA_USUARIO('usuario 7');

SELECT * FROM usuarios;
SELECT * FROM log_usuarios;

/* FUNCION NUEVO USUARIO */
DROP FUNCTION IF EXISTS NUEVO_USUARIO ;
DELIMITER $$
CREATE function NUEVO_USUARIO() returns INTEGER
BEGIN
	declare nuevo_id integer;
    
	SELECT IFNULL(MAX(ID),0) INTO nuevo_id FROM USUARIOS;
	SET nuevo_id= nuevo_id+1;
    
    return nuevo_id;
END;
$$
