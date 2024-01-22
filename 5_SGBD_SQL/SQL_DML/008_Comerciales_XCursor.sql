
DELIMITER //
DROP PROCEDURE if exists crear_estadistica_basico//
CREATE PROCEDURE crear_estadistica_basico (INOUT resultado VARCHAR(100))
BEGIN
DECLARE v_finished, existe, pcliente, panyo, contador INTEGER DEFAULT 0;
DECLARE ptotal float;
DECLARE cpedidos CURSOR FOR SELECT id_cliente, year(fecha) as anyo, total FROM pedido;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;
DECLARE exit handler for sqlexception
	begin
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='ERROR EN EL PROCEDIMIENTO CREAR ESTADÍSTICAS';
	end;

CREATE TABLE IF NOT EXISTS ESTADISTICAS(
	CLIENTE INT, ANYO INT, TOTAL FLOAT default 0, PRIMARY KEY(CLIENTE,ANYO) );

OPEN cpedidos;
revisar_pedidos: LOOP
	FETCH cpedidos INTO pcliente, panyo, ptotal;
	IF v_finished = 1 THEN
		LEAVE revisar_pedidos;
	END IF;
	/* revisamos si cada cliente ya existe en estadisticas para el año actual*/
    /* si existe sólo actualizo el total, si no existe lo damos de alta*/
    SELECT ifnull(count(pcliente),0) into existe FROM ESTADISTICAS where cliente=pcliente and anyo=panyo;
	IF existe = 0 THEN
		INSERT INTO ESTADISTICAS VALUES (pcliente,panyo,ptotal);
	else
		update ESTADISTICAS set total=total+ptotal where cliente=pcliente and anyo=panyo ;
	END IF;
    set contador = contador +1;
END LOOP revisar_pedidos;
set resultado = concat("se han gestionado ", contador, " pedidos");
CLOSE cpedidos;
END//

delete from estadisticas;
call crear_estadistica_basico (@estadisticas);
select @estadisticas;
select * from estadisticas;


/* CREAMOS UNO SIMILAR PASANDO COMO PARÁMETRO EL AÑO PARA EL QUE CREAR LAS ESTADÍSTICAS */

DELIMITER //
DROP PROCEDURE if exists crear_estadistica//
CREATE PROCEDURE crear_estadistica (IN P_ANYO INT, INOUT resultado VARCHAR(100))
BEGIN
DECLARE v_finished, existe, pcliente, contador INTEGER DEFAULT 0;
DECLARE ptotal float;
DECLARE cpedidos CURSOR FOR SELECT id_cliente, total FROM pedido where year(fecha)=P_ANYO;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;
DECLARE exit handler for sqlexception
	begin
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='ERROR EN EL PROCEDIMIENTO CREAR ESTADÍSTICAS';
	end;

CREATE TABLE IF NOT EXISTS ESTADISTICAS(
	CLIENTE INT, ANYO INT, TOTAL FLOAT default 0,
	PRIMARY KEY(CLIENTE,ANYO) );

OPEN cpedidos;
revisar_pedidos: LOOP
	FETCH cpedidos INTO pcliente, ptotal;
	IF v_finished = 1 THEN
		LEAVE revisar_pedidos;
	END IF;
	/* revisamos si cada cliente ya existe en estadisticas para el año actual*/
    /* si existe sólo actualizo el total, si no existe lo damos de alta*/
    SELECT ifnull(count(pcliente),0) into existe FROM ESTADISTICAS where cliente=pcliente and anyo=P_ANYO;
	IF existe = 0 THEN
		INSERT INTO ESTADISTICAS VALUES (pcliente,P_ANYO,ptotal);
	else
		update ESTADISTICAS set total=total+ptotal where cliente=pcliente and anyo=P_ANYO ;
	END IF;
    set contador = contador +1;
END LOOP revisar_pedidos;
set resultado = concat("se han gestionado ", contador, " pedidos");
CLOSE cpedidos;
END//

/* TESTEAMOS EL CÓDIGO GENERADO */

delete from estadisticas;
call crear_estadistica (2017, @estadisticas);
select @estadisticas;
select * from estadisticas;