/************* IMPLEMENTACION DE UN SISTEMA DE FUNICIONES Y PROCEDMIENTOS ****/
/*********** INCORPORAR LA GESTION DE EXCEPCIONES QUE SE PUEDAN PRODUCIR *****/

/* Procedimiento para crear el esquema de la base de datos */
delimiter //
drop procedure if exists crear_schema //
create procedure crear_schema ()
begin
	declare exit handler for sqlexception
	begin
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='ERROR EN EL PROCEDIMIENTO CREAR SCHEMA';
	end;
	CREATE TABLE IF NOT EXISTS  TIPO_HABITACION(
		CATEGORIA INT, 
		CAMAS INT NOT NULL,
		EXTERIOR VARCHAR(2) NOT NULL,
		SALON VARCHAR(2) NOT NULL,
		TERRAZA VARCHAR(2) NOT NULL,
		CONSTRAINT PK_HABITACION PRIMARY KEY(CATEGORIA) );

	CREATE TABLE IF NOT EXISTS HABITACIONES(
		NUMHABITACION INT, 
		TIPO_HABITACION INT NOT NULL,
		PRECIO FLOAT NOT NULL,
		CONSTRAINT PK_HABITACIONES PRIMARY KEY(NUMHABITACION),
		CONSTRAINT FK_TIPOHABITACION FOREIGN KEY(TIPO_HABITACION) 
		REFERENCES TIPO_HABITACION(CATEGORIA) ON UPDATE CASCADE ON DELETE CASCADE );

	CREATE TABLE IF NOT EXISTS  PAISES(
		PAIS VARCHAR(20),
		CONSTRAINT PK_PAISES PRIMARY KEY(PAIS));

	CREATE TABLE IF NOT EXISTS  CLIENTES(
		IDENTIFICACION VARCHAR(12),
		PAIS VARCHAR(20),
		NOMBRE VARCHAR(25) NOT NULL,
		APELLIDO1 VARCHAR(20) NOT NULL,
		APELLIDO2 VARCHAR(20),
		DIRECCION VARCHAR(30) NOT NULL,
		TELEFONO VARCHAR(12) NOT NULL,
		OBSERVACIONES VARCHAR(50),
		CONSTRAINT PK_CLIENTES PRIMARY KEY(IDENTIFICACION),
		CONSTRAINT FK_PAISES FOREIGN KEY(PAIS) REFERENCES PAISES(PAIS) ON UPDATE CASCADE ON DELETE CASCADE );

	CREATE TABLE IF NOT EXISTS  RESERVA_HABITAC(
		IDRESERVA INT,
		FECHAENTRADA DATE NOT NULL,
		FECHASALIDA DATE NOT NULL,
		IVA FLOAT NOT NULL,
		NUMHABITACION INT NOT NULL,
		CLIENTE VARCHAR(12) NOT NULL,
		CONSTRAINT PK_RESERVA_HABITAC PRIMARY KEY(IDRESERVA),
		CONSTRAINT FK_HABITACION FOREIGN KEY(NUMHABITACION) REFERENCES HABITACIONES(NUMHABITACION) ON UPDATE CASCADE ON DELETE CASCADE,
		CONSTRAINT FK_CLIENTE FOREIGN KEY(CLIENTE) REFERENCES CLIENTES(IDENTIFICACION) ON UPDATE CASCADE ON DELETE CASCADE );

	CREATE TABLE IF NOT EXISTS TIPO_SERVICIO(
		NOMBRESERVICIO VARCHAR(10),
		CONSTRAINT PK_TIPOSERVICIO PRIMARY KEY(NOMBRESERVICIO));

	CREATE TABLE IF NOT EXISTS SERVICIOS(
		IDSERVICIOS INT,
		NOMBRESERVICIO VARCHAR(10) NOT NULL,
		DESCRIPCION VARCHAR(30) NOT NULL,
		PRECIO FLOAT NOT NULL,
		IVA DECIMAL(5,2) NOT NULL,
		FECHA DATE,
		CONSTRAINT PK_SERVICIOS PRIMARY KEY(IDSERVICIOS),
		CONSTRAINT FK_TIPOSERVICIO FOREIGN KEY(NOMBRESERVICIO) REFERENCES TIPO_SERVICIO(NOMBRESERVICIO) ON UPDATE CASCADE ON DELETE CASCADE );

	CREATE TABLE IF NOT EXISTS GASTOS(
		IDGASTOS INT,
		IDRESERVA INT NOT NULL,
		IDSERVICIOS INT NOT NULL,
		FECHA DATETIME NOT NULL,
		CANTIDAD INT NOT NULL,
		PRECIO FLOAT,
		CONSTRAINT PK_GASTOS PRIMARY KEY(IDGASTOS),
		CONSTRAINT FK_RESERVAS FOREIGN KEY(IDRESERVA) REFERENCES RESERVA_HABITAC(IDRESERVA) ON UPDATE CASCADE ON DELETE CASCADE,
		CONSTRAINT FK_SERVICIOS FOREIGN KEY(IDSERVICIOS) REFERENCES SERVICIOS(IDSERVICIOS) ON UPDATE CASCADE ON DELETE CASCADE );
end;
//

/* Procedimiento para borrar el esquema de la base de datos */
delimiter //
drop procedure if exists borrar_schema//
create procedure borrar_schema ()
begin
	declare exit handler for sqlexception
	begin
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='ERROR EN EL PROCEDIMIENTO BORRAR SCHEMA';
	end;
	drop TABLE IF EXISTS GASTOS;
	drop TABLE IF EXISTS RESERVA_HABITAC;
	drop TABLE IF EXISTS SERVICIOS;
	drop TABLE IF EXISTS HABITACIONES;
	drop TABLE IF EXISTS CLIENTES;
	drop TABLE IF EXISTS TIPO_HABITACION;
	drop TABLE IF EXISTS TIPO_SERVICIO;
	drop TABLE IF EXISTS PAISES;
end;
//

/* Procedimiento para dar de alta datos de ejemplo en la base de datos */
delimiter //
drop procedure if exists datos_ejemplo//
create procedure datos_ejemplo ()
begin
	declare exit handler for sqlexception
	begin
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='ERROR EN EL PROCEDIMIENTO ALTA DATOS EJEMPLO';
	end;

INSERT INTO  tipo_servicio  VALUES ('COMEDOR');
	INSERT INTO  tipo_servicio  VALUES ('LAVANDERIA');

	INSERT INTO  paises  VALUES ('ALEMANIA');
	INSERT INTO  paises  VALUES ('ESPAÑA');
	INSERT INTO  paises  VALUES ('FRANCIA');
	INSERT INTO  paises  VALUES ('PORTUGAL');
	 
	INSERT INTO  clientes  VALUES ('12345', 'ESPAÑA', 'Felipe', 'Iglesias', 'López', 'Avda Los Castros, 44', '942344444', 'Buen cliente');
	INSERT INTO  clientes  VALUES ('44444', 'ESPAÑA', 'Luis', 'García', 'García', 'Calle Mayor, 67 ', '942456444', null);
	INSERT INTO  clientes  VALUES ('456789', 'FRANCIA', 'Ludovic', 'Giuly', 'Bourquin', '18 avenue Alsacen Cour', '37890194', null);

	INSERT INTO  tipo_habitacion  VALUES (1, 1, 'SI', 'NO', 'NO');
	INSERT INTO  tipo_habitacion  VALUES (2, 2, 'SI', 'NO', 'NO');
	INSERT INTO  tipo_habitacion  VALUES (3, 3, 'SI', 'NO', 'NO');
	INSERT INTO  tipo_habitacion  VALUES (4, 1, 'SI', 'SI', 'NO');

	INSERT INTO  habitaciones  VALUES (101, 1,30);
	INSERT INTO  habitaciones  VALUES (102, 1,30);
	INSERT INTO  habitaciones  VALUES (103, 1,30);
	INSERT INTO  habitaciones  VALUES (104, 2,30);
	INSERT INTO  habitaciones  VALUES (105, 2,30);
	INSERT INTO  habitaciones  VALUES (106, 3,30);
	INSERT INTO  habitaciones  VALUES (107, 4,30);

	INSERT INTO  servicios  VALUES (1, 'COMEDOR', '1 menu del Dia', 10, 7, '2009-01-01');
	INSERT INTO  servicios  VALUES (2, 'LAVANDERIA', 'Lavado de Camisa', 2, 7, '2009-01-01');
	INSERT INTO  servicios  VALUES (3, 'LAVANDERIA', 'Lavado de pantalon', 1, 7, '2009-01-01');

	INSERT INTO  reserva_habitac (IDRESERVA, FechaENTRADA , FechaSALIDA  , IVA , NumHABITACION  , CLIENTE) VALUES (1, '2009-03-15', '2009-03-25', 0.07,101, '12345');
	INSERT INTO  reserva_habitac (IDRESERVA, FechaENTRADA , FechaSALIDA  , IVA , NumHABITACION  , CLIENTE) VALUES (2, '2009-03-15', '2009-03-25', 0.07, 102, '12345');
	INSERT INTO  reserva_habitac (IDRESERVA, FechaENTRADA , FechaSALIDA  , IVA , NumHABITACION  , CLIENTE)  VALUES (3, '2009-02-16', '2009-02-21', 0.07,103, '12345');
	INSERT INTO  reserva_habitac (IDRESERVA, FechaENTRADA , FechaSALIDA  , IVA , NumHABITACION  , CLIENTE) VALUES (4, '2009-03-16', '2009-03-21', 0.07,104, '44444');
	INSERT INTO  reserva_habitac (IDRESERVA, FechaENTRADA , FechaSALIDA  , IVA , NumHABITACION  , CLIENTE)  VALUES (5, '2009-03-16', '2009-03-21', 0.07,105, '44444');
	INSERT INTO  reserva_habitac (IDRESERVA, FechaENTRADA , FechaSALIDA  , IVA , NumHABITACION  , CLIENTE) VALUES (6, '2009-03-16', '2009-03-21', 0.07,106, '44444');
	INSERT INTO  reserva_habitac (IDRESERVA, FechaENTRADA , FechaSALIDA  , IVA , NumHABITACION  , CLIENTE)  VALUES (7, '2009-03-16', '2009-03-21', 0.07,107, '44444');

	INSERT INTO  gastos  ( idgastos,idRESERVA  , idSERVICIOS  ,Fecha ,Cantidad ,Precio) VALUES (1,1,1, '2009-03-15 12:00', 1,10);
	INSERT INTO  gastos  ( idgastos,idRESERVA  , idSERVICIOS  ,Fecha ,Cantidad ,Precio) VALUES (2, 1,1,  '2009-03-15 11:00', 1,10);
	INSERT INTO  gastos  (idgastos, idRESERVA  , idSERVICIOS  ,Fecha ,Cantidad ,Precio) VALUES (3, 4, 2, '2009-03-15 09:30', 1,2);

end;
//

call borrar_schema ();
call crear_schema();
call datos_ejemplo();

/* 1- Procedimiento que gestione el alta de gastos de una reserva según lo siguiente:
- si el servicio ya existe dentro de la reserva, solo incrementamos las unidades.
- sino existe dicho servicio, creamos el alta del gasto correspondiente.*/
delimiter //
drop procedure if exists alta_gasto//
create procedure alta_gasto (in nreserva int, in nservicio int, 
in fecha datetime, in cantidad int, in precio float, 
out mensaje varchar(20))
begin
	declare ngasto, alta int;
	declare exit handler for sqlexception
	begin
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='ERROR EN EL PROCEDIMIENTO ALTA GASTO';
	end;
	
	select IFNULL(IDGASTOS,0) into alta from gastos where IDRESERVA=nreserva and IDSERVICIOS=nservicio;
	
	if (alta<>0) then
		update gastos set cantidad=cantidad+ncantidad where IDRESERVA=nreserva and IDSERVICIOS=nservicio;
		set mensaje='Actualización realizada';
	else
		select ifnull(max(IDGASTOS),0)+1 into ngasto from gastos;
		insert into gastos values (ngasto, nreserva,nservicio, fecha, cantidad, precio);
		set mensaje='Inserción realizada';
	end if;	
end;
//

delimiter ;
call alta_gasto (2,1, '2009-03-18 19:00', 25,10,@resultado);
select @resultado;
call alta_gasto (2,1, '2009-03-18 19:00', 50,10,@resultado);
select @resultado;
call alta_gasto ( 2,3, '2009-03-30 15:00', 10,10,@resultado2);
select @resultado2;

/* 2- Procedmiento que gestione el alta de reservas de habitacion
sólo se podrá hacer la reserva si la habitacion indicada está disponible en las fechas requeridas.*/
delimiter //
drop  procedure if exists nueva_reserva //
create procedure nueva_reserva (in nreserva int, in fecha_e date, in fecha_s date, in iva float, in nhabitacion int,  
in ncliente varchar(12), out mensaje varchar(20))
begin
	declare reservada, reserva int;
	declare exit handler for sqlexception
	begin
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='ERROR EN EL PROCEDIMIENTO NUEVA_RESERVA';
	end;
	
	select IFNULL(idreserva,0) into reservada 
	from RESERVA_HABITAC where NUMHABITACION=nhabitacion 
    and ((fechaentrada between fecha_e AND fecha_s) or (fechasalida between fecha_e AND fecha_s)) limit 0,1;
	
	if (reservada=0) then
		select IFNULL(idreserva,0)+1 into reserva from RESERVA_HABITAC; 
		insert into RESERVA_HABITAC values(reserva, fecha_e, fecha_s, iva, nhabitacion,ncliente);
		set mensaje='Reserva realizada';
	else
		set mensaje='Selecciona otra Habitacion o fechas. Ya estaba reservada para esas fechas la habitación';
	end if;	
end;
//

/* 3- procedmiento para toda las reservas dentro de un rango de fechas permita
aplicar una reducción de precio a todos los servicios gastados correspondientes a un tipo de servicio*/
delimiter //
drop procedure if exists dto_gasto//
create procedure dto_gasto(in n_nombreservicio varchar(10),in n_fechainicio date, in n_fechafin date,in descuento float(5))
begin
	declare ser varchar(10);
	declare exit handler for sqlexception
	begin
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='ERROR EN EL PROCEDIMIENTO DTO GASTO';
	end;
	
	select idservicios into ser from servicios where nombreservicio=n_nombreservicio limit 0,1;
	update gastos set precio=precio-precio*descuento where idservicios=ser and gastos.fecha between n_fechainicio and n_fechafin;

end //

/* 4- procedimiento que al pasarle como parámetro el nombre de un servicio, nos devuelve la diferencia entre 
el importe real de los gastos imputados a reservas y el importe teórico según el precio del servicio*/ 
delimiter //
DROP PROCEDURE IF exists calcular_diferencia //
CREATE PROCEDURE calcular_diferencia(in servicio varchar(30), out diferencia float)
BEGIN
	declare valor_r, valor_t float;
 
	/* calculo el real que esta en gastos*/
	select ifnull(sum(g.cantidad*g.precio),0) into valor_r from servicios s, gastos g
	where s.idservicios=g.idservicios and s.NOMBRESERVICIO=servicio;
	
	/* calculo el teórico que esta en servicios*/
	select ifnull(sum(g.cantidad*s.precio),0) into valor_t from servicios s, gastos g
	where s.idservicios=g.idservicios and s.NOMBRESERVICIO=servicio;
	
	set diferencia=valor_t-valor_r;

end //
call calcular_diferencia('COMEDOR',@resultado);
select @resultado;

call calcular_diferencia('LAVANDERIA',@resultado);
select @resultado;

/*5- Escribir el procedimento o funcion que permita incrementar un % el precio de las habitaciones 
que tengan Terraza y sean Exteriores. */

delimiter //
DROP PROCEDURE IF exists incrementar_TE //

CREATE PROCEDURE incrementar_TE(in porcentaje int)
BEGIN
	declare exit handler for sqlexception
	begin
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='ERROR EN EL PROCEDIMIENTO INCREMENTAR %';
	end;
	
	update HABITACIONES set precio=precio*(1+(porcentaje/100)) 
	where TIPO_HABITACION in (SELECT Categoria from tipo_habitacion where Terraza='si' and Exterior='si');
	
	/* update HABITACIONES set precio=precio+(precio*(porcentaje/100)) 
	 where TIPO_HABITACION in (SELECT Categoria from tipo_habitacion where Terraza='si' and Exterior='si');
	*/
	
end //
call incrementar_TE(25);
call incrementar_TE(30);

/*6- Escribir el procedimiento o funcion que permita dar de baja todos aquellos servicios que no han sido
 nunca utilizados por ningún cliente. */
delimiter //
DROP PROCEDURE IF EXISTS servicios_no_usados //

CREATE PROCEDURE servicios_no_usados()
BEGIN
	declare exit handler for sqlexception
	begin
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='ERROR EN EL PROCEDIMIENTO BORRAR SERVICIOS NO USADOS';
	end;
	
    DELETE  FROM servicios where idservicios not in (SELECT distinct idservicios from gastos); 
	
end //

call servicios_no_usados();
 
/* 7- Escribir el procedimiento o funcion que permita pasando como parámetro el TIPO (NOMBRE) del servicio obtener el 
importe total facturado*/ 
delimiter //
drop function if exists servicio_imp_total //
 
CREATE function servicio_imp_total( nombre VARCHAR(20)) returns float READS SQL DATA
BEGIN
	declare total float;
	SELECT sum(precio*cantidad) into total 
	from gastos where idservicios in (Select idservicios from servicio where nombreServicio like nombre);
	
	return total;
end //

SELECT NOMBRESERVICIO, servicio_imp_total(NOMBRESERVICIO) AS TOTAL FROM servicios;

/* 8- Escribir el procedimiento o funcion que permita pasando como parámetro el nombre del cliente obtener
 importe total facturado*/ 
delimiter //
drop function if exists total_fact_cliente //
CREATE function total_fact_cliente(nombre_cli VARCHAR(20)) returns float READS SQL DATA
BEGIN
	declare total float;
	
	select sum(precio*cantidad) into total
	from gastos 
	where idreserva in (select idreserva 
						from reserva_habitac 
						where cliente in (select Identificacion from cliente where Nombre like nombre_cli));
	
	return total;
	
end //

/*9- Escribir el procedimiento o funcion que permita pasando como parámetro el nombre de un pais obtener
el numero total de reservas realizadas*/ 
delimiter //
drop function if exists reserva_pais //
CREATE function reserva_pais(nom_pais VARCHAR(20)) returns int READS SQL DATA
BEGIN
	declare total_reservas int;
	
	select count(idreserva) into total_reservas
	from reserva_habitac where cliente in(Select Identificacion from clientes where Pais like nom_pais);
	return total_reservas;
	
end //

/*10 - Escribir el procedimiento o funcion que permita actualizar el precio de los servicios correspondientes
al tipo de servicio pasado como parámetro. El precio nuevo, se pasará también como parámetro.
El procedimento debe permitir obtener el numero de servicios que se han actualizado*/ 
delimiter //
drop procedure if exists actualizar_precio //
CREATE PROCEDURE actualizar_precio(in tipo_serv varchar(25), in actua INT, out num_actualizados int)
BEGIN		
	begin
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='ERROR EN LA ACTUALIZACIÓN DE PRECIOS DE SERVICIOS';
	end;
	
	select count(idservicios) into num_actualizados from servicios where NOMBRESERVICIO=tipo_serv;
	update servicios set precio=actua where NOMBRESERVICIO=tipo_serv;
	
end //


/*11- funcion que dada una habitación y unas fechas de entrada y salida nos devuelta si está disponible o ocupada */
delimiter //
drop function if exists disponible //
create function disponible(n_numhabitacion int(11), n_fechaentrada date, n_fechasalida date) returns boolean READS SQL DATA
begin
	declare reservada boolean;
	
	select ifnull(idreserva,0) into reservada from reserva_habitac
	where numhabitacion=n_numhabitacion and ((n_fechaentrada between fechaentrada and fechasalida) 
	or (n_fechasalida between fechaentrada and fechasalida));
	
	if reservada <> 0 then
		return false;
	else 
		return true;
	end if;
end //


/*12 - función que al pasarle como parámetro el nombre de un servicio, nos devuelve la diferencia entre 
el importe real de los gastos imputados a reservas y el importe teórico según el precio del servicio*/ 

delimiter //
DROP function IF exists diferencias //
CREATE function diferencias(servicio varchar(30)) returns float READS SQL DATA
BEGIN
	
	declare valor_r, valor_t float;
 
	/* calculo el real que esta en gastos*/
	select ifnull(sum(g.cantidad*g.precio),0) into valor_r from servicios s, gastos g
	where s.idservicios=g.idservicios and s.NOMBRESERVICIO=servicio;
	
	/* calculo el teórico que esta en servicios*/
	select ifnull(sum(g.cantidad*s.precio),0) into valor_t from servicios s, gastos g
	where s.idservicios=g.idservicios and s.NOMBRESERVICIO=servicio;
	
	set diferencia=valor_t-valor_r;
	return diferencia
	
end 
//

/*13 - función a la que le puedo pasar como parámetro el numero de habitación y me devuelve si algúna vez ha sido ocupada */
delimiter //
drop function if exists ocupada //
create function ocupada(n_numhabitacion int(11)) returns varchar(25) READS SQL DATA
begin	
	declare ocupada int;
	select ifnull(count(idreserva),0) into ocupada from reserva_habitac where numhabitacion=n_numhabitacion;
	if suma=0 then
		return 'Hab. Nunca ocupada';
	else 
		return concat('Hab. ocupada ', ocupada, 'veces');
	end if;
end //

/*14- función a la que si le paso como parámetro1 el string:
 'habitaciones' me devuelve el numero de habitaciones diferentes reservadas,
 'clientes' me devuelve el numero de clientes diferentes que han hecho reservas,
 'servicios' me devuelve el numero de servicios diferentes reservados.
 Si como parámetro dos recibe el valor de un elemento referenciado en el parámetro1 entonces filtra por dicho valor
 Posibles ejemplos de esta función serían:
 select identificacion, nombre, apellido1, reservas('clientes',identificacion) from clientes;
 select numhabitacion, tipohabitacion, reservas('habitaciones','') from habitaciones;
 select nombreservicio, reservas('servicios',nombreservicio), sum(cantidad*precio)
 from gastos g, servicios s where g.idservicios=s.idservicios;*/
delimiter //
drop function if exists reservas //
create function reservas(tipo varchar(20), valor varchar(15)) returns int READS SQL DATA
begin	
	declare resultado int;
 
	CASE tipo
		WHEN  'clientes' THEN
			if valor is null then
				select distinct cliente into resultado from reserva_habitac; 
			else
				select count(idreserva) into resultado from reserva_habitac where cliente=valor; 
			end if;
		WHEN 'habitaciones' THEN
			if valor is null then
				select distinct numhabitacion into resultado from reserva_habitac; 
			else
				select count(idreserva) into resultado from reserva_habitac where numhabitacion=valor; 
			end if;
		WHEN 'servicios' THEN
			if valor is null then
				select distinct idservicios into resultado from gastos; 
			else
				select count(idgastos) into resultado from gastos g, servicios s where s.idservicios=g.idservicios 
				and nombreservicio=valor; 
			end if;
	END CASE;
	return resultado;
end //