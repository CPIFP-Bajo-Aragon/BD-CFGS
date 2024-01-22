
DELIMITER //
DROP PROCEDURE IF EXISTS ALTA_CLIENTE //
CREATE PROCEDURE ALTA_CLIENTE (IN COD INT(11), IN NOMBRE VARCHAR(50), IN RENTA FLOAT, OUT MSG VARCHAR(50))
BEGIN
	DECLARE existe,ncod int;
    select count(*) into existe from cliente where nomb_cli=NOMBRE;
    IF existe=0 then 
		select (max(cli_id)+1) into ncod from cliente;
		INSERT INTO CLIENTE VALUES (ncod, NOMBRE, RENTA);
        SET MSG='EL CLIENTE SE HA DADO DE ALTA CORRECTAMENTE';
	else
		SET MSG='EL CLIENTE YA EXISTE';
        /*SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = MSG; */
    end if;	
END;
//

DELIMITER ;

CALL ALTA_CLIENTE(151,'CLIENTE2 23/03/2017', 125.69,@resultado);
SELECT @resultado;
SELECT * FROM CLIENTE;

DELIMITER //
DROP procedure if exists ACTUALIZA_RENTA //
create procedure ACTUALIZA_RENTA (IN PORCENTAJE FLOAT)
BEGIN
	UPDATE CLIENTE SET renta_anual=renta_anual*(1+(PORCENTAJE/100));
END;
//

CALL ACTUALIZA_RENTA(20.14);

DELIMITER //
DROP procedure if exists ACTUALIZA_RENTA2 //
create procedure ACTUALIZA_RENTA2 (IN CODIGO INT(11), IN PORCENTAJE FLOAT)
BEGIN
	IF CODIGO=0 THEN
    	UPDATE CLIENTE SET renta_anual=renta_anual*(1+(PORCENTAJE/100));
	else
		UPDATE CLIENTE SET renta_anual=renta_anual*(1+(PORCENTAJE/100)) WHERE cli_id=CODIGO;
    END IF;    
END;
//
DELIMITER ;
CALL ACTUALIZA_RENTA2(151,20.14);
CALL ACTUALIZA_RENTA2(0,20.14);

DELIMITER //
DROP procedure if exists ACTUALIZA_RENTA2 //
create procedure ELIMINA_CLIENTE (IN CODIGO INT(11))
BEGIN
	DECLARE existe int;
    select count(*) into existe from embarque where emb_id_cli=codigo;
    IF EXISTE>0 THEN
		DELETE FROM EMBARQUE WHERE emb_id_cli=codigo;
    	DELETE FROM CLIENTE WHERE CLI_ID=codigo;
	else
		DELETE FROM CLIENTE WHERE CLI_ID=codigo;
    END IF;    
END;
//