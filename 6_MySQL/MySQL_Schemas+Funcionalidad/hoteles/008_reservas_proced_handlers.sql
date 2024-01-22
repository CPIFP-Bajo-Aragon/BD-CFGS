Create schema hotel;
/*	Escribir el procedimento o funcion que permita incrementar un 15% el precio de las habitaciones 
que tengan Terraza y sean Exteriores. */

DELIMITER ---
DROP PROCEDURE IF exists incrementar_TE ---
CREATE PROCEDURE incrementar_TE(in porcentaje int)
	BEGIN
		declare exit handler for sqlexception
		update precio_habitacion set precio=precio*(1+(porcentaje/100)) 
        where TIPO_HABITACION in (
        SELECT Categoria from tipo_habitacion where Terraza='si' and Exterior='si');
		
	end---

/* Escribir el procedimiento o funcion que permita dar de baja todos aquellos servicios que no han sido
 nunca utilizados por ningún cliente. */

DELIMITER ---
DROP PROCEDURE IF EXISTS servicios_no_usados ---
CREATE PROCEDURE servicios_no_usados()
	BEGIN
	declare exit handler for sqlexception
        DELETE  FROM servicios where idservicios not in (SELECT distinct idservicios from gastos); 
	END---
 DELIMITER ;
 
/* Escribir el procedimiento o funcion que permita pasando como parámetro el tipo de servicio obtener el 
importe total facturado*/ 

DELIMITER ---
/*CREATE PROCEDURE servicio_imp_total( IN nombre VARCHAR(20), OUT TOTAL FLOAT)*/
CREATE FUNCTION servicio_imp_total( nombre VARCHAR(20)) RETURNS FLOAT
	BEGIN
		DECLARE TOTAL FLOAT;
		SELECT sum(precio*cantidad) into total 
        from gastos where idservicios in (Select idservicios from servicio where nombreServicio like nombre);
        RETURN TOTAL;
	END---	
DELIMITER ;

/* Escribir el procedimiento o funcion que permita pasando como parámetro el nombre del cliente obtener
 importe total facturado*/ 
DELIMITER ---
CREATE PROCEDURE total_fact_cliente(IN nombre_cli VARCHAR(20), out total float)
	BEGIN
		SELECT sum(precio*cantidad) into total
        FROM gastos where idreserva in 
        (select idreserva from reserva_habitac where cliente in (select Identificacion from cliente where Nombre like nombre_cli));
	END---
DELIMITER ;

/* Escribir el procedimiento o funcion que permita pasando como parámetro el nombre de un pais obtener
el numero total de reservas realizadas*/ 

DELIMITER ---

CREATE PROCEDURE reserva_pais(IN nom_pais VARCHAR(20), out total_reservas int)
	BEGIN
		SELECT count(idreserva) into total_reservas
        from reserva_habitac where cliente in(Select Identificacion from clientes where Pais like nom_pais);
	END---
DELIMITER ;

/* Escribir el procedimiento o funcion que permita pasando como parámetro el tipo de servicio actualizar 
el precio de los servicios del mismo tipo, debo poder obtener al final cuantos servicios se han actualizado*/  

DELIMITER ---

CREATE PROCEDURE actualizar_precio(in tipo_serv int, in actua INT, out num_actualizados int)
	BEGIN		
		declare exit handler for sqlexception
		UPDATE servicios set precio=precio*actua where idSERVICIOS=tipo_serv;
		SELECT count(idservicios) into num_actualizados from servicios where idSERVICIOS=tipo_serv;
	END---
DELIMITER ;