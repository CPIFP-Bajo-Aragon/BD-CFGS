create schema empleados;
use empleados;
create table empleados( id int auto_increment primary key, nombre varchar(25), email varchar(50));
insert into empleados values('0','empleado1', 'email1'); 
insert into empleados values('0','empleado2', 'email2');
insert into empleados values('0','empleado3', 'email3');
insert into empleados values('0','empleado7', 'email7');
insert into empleados values('0','empleado8', 'email8');
insert into empleados values('0','empleado9', 'email9');
insert into empleados values('0','empleado4', 'email4');
insert into empleados values('0','empleado5', 'email5');
insert into empleados values('0','empleado6', 'email6');

select * from empleados;

/* PROCEDIMIENTO PARA OBTENER UNA LISTA CONCATENADA DE EMAILS */
DELIMITER //
DROP PROCEDURE construir_email_lista//
CREATE PROCEDURE construir_email_lista (INOUT email_lista VARCHAR(1000) )
BEGIN
DECLARE v_finished INTEGER DEFAULT 0;
DECLARE v_nombre varchar(50);
DECLARE v_email VARCHAR(255) DEFAULT "";

DECLARE email_cursor CURSOR FOR SELECT nombre, email FROM empleados;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;

OPEN email_cursor;
obtener_email: LOOP
	FETCH email_cursor INTO v_nombre, v_email;
	IF v_finished = 1 THEN
		LEAVE obtener_email;
	END IF;
	SET email_lista = CONCAT(v_email,"; ",email_lista);
END LOOP obtener_email;
CLOSE email_cursor;
END//

/* TESTEAMOS EL PROCEDIMIENTO */

SET @email_lista = "";
CALL construir_email_lista(@email_lista);
SELECT @email_lista;


/* PROCEDIMIENTO PARA OBTENER UNA LISTA CONCATENADA DE NOMBRE-EMAILS */

DELIMITER //
DROP PROCEDURE if exists construir_email_lista2//
CREATE PROCEDURE construir_email_lista2 (INOUT email_lista VARCHAR(1000) )
BEGIN
DECLARE v_finished INTEGER DEFAULT 0;
DECLARE v_nombre varchar(50);
DECLARE v_email VARCHAR(255) DEFAULT "";

DECLARE email_cursor CURSOR FOR SELECT nombre, email FROM empleados;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;

OPEN email_cursor;
obtener_email: LOOP
	FETCH email_cursor INTO v_nombre, v_email;
	IF v_finished = 1 THEN
		LEAVE obtener_email;
	END IF;
	SET email_lista = CONCAT(v_nombre,"-",v_email,"; ",email_lista);
END LOOP obtener_email;
CLOSE email_cursor;
END//

/* TESTEAMOS EL PROCEDIMIENTO */

SET @email_lista2 = "";
CALL construir_email_lista2(@email_lista2);
SELECT @email_lista2;