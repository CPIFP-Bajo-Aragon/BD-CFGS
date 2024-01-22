/************* IMPLEMENTACION DE UN SISTEMA DE FUNICIONES Y PROCEDMIENTOS ****/
/*********** INCORPORAR LA GESTION DE EXCEPCIONES QUE SE PUEDAN PRODUCIR *****/

/* 1- Procedimiento que gestione el alta de gastos de una reserva según lo siguiente:
- si el servicio ya existe dentro de la reserva, solo incrementamos las unidades.
- sino existe dicho servicio, creamos el alta del gasto correspondiente.*/
delimiter $$
drop procedure if exists alta_gasto$$
create procedure alta_gasto (in nreserva int, in nservicio int, 
in fecha datetime, in cantidad int, in precio float, 
out mensaje varchar(20))
begin
	declare ngasto, alta int;
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
$$

/* 2- Procedmiento que gestione el alta de reservas de habitacion
sólo se podrá hacer la reserva si la habitacion indicada está disponible en las fechas requeridas.*/
delimiter ;
drop  procedure if exists nueva_reserva;
delimiter $$
create procedure nueva_reserva (in nreserva int, in fecha_e date, in fecha_s date, in iva float, in nhabitacion int,  
in ncliente varchar(12), out mensaje varchar(20))
begin
	declare reservada, reserva int;

	select IFNULL(idreserva,0) into reservada from RESERVA_HABITAC 
	where NUMHABITACION=nhabitacion and ((fechaentrada between fecha_e AND fecha_s) or (fechasalida between fecha_e AND fecha_s));
	
	if (reservada<>0) then
		select IFNULL(idreserva,0)+1 into reserva from RESERVA_HABITAC; 
		insert into RESERVA_HABITAC values(reserva, fecha_e, fecha_s, iva, nhabitacion,ncliente);
		set mensaje='Reserva realizada';
	else
		set mensaje='Habitacion ya reservada';
	end if;	
end;
$$

/* 3- procedmiento para toda las reservas dentro de un rango de fechas permita
aplicar una reducción de precio a todos los servicios gastados correspondientes a un tipo de servicio*/
delimiter ;
drop procedure if exists dto_gasto;
delimiter $$
create procedure dto_gasto(in n_nombreservicio varchar(10),in n_fechainicio date, in n_fechafin date,in descuento float(5))
begin
	declare ser varchar(10);
	
	update gastos set precio=precio*(descuento/100) where idServicio=n_nombreservicio and fecha between n_fechainicio and n_fechafin;
end $$

/* 4- procedimiento que al pasarle como parámetro el nombre de un servicio, nos devuelve la diferencia entre 
el importe real de los gastos imputados a reservas y el importe teórico según el precio del servicio*/ 
delimiter ;
DROP PROCEDURE IF exists calcular_diferencia ;
delimiter $$

CREATE PROCEDURE calcular_diferencia(in servicio varchar(30), out diferencia float)
BEGIN
	declare valor_r, valor_t float; 
	
	/* calculo el real que esta en gastos*/
	select ifnull(g.cantidad*g.precio,0) into valor_r from servicios s, gastos g
	where s.nombreservicio=servicio and s.idservicios=g.idservicios;
	
	/* calculo el teórico que esta en servicios*/
	select ifnull(g.cantidad*s.precio,0) into valor_t from servicios s, gastos g
	where s.nombreservicio=servicio and s.idservicios=g.idservicios;
	
	set diferencia=valor_r-valor_t;

end $$

/*5- Escribir el procedimento o funcion que permita incrementar un 15% el precio de las habitaciones 
que tengan Terraza y sean Exteriores. */
delimiter ;
DROP PROCEDURE IF exists incrementar_TE ;
delimiter $$

CREATE PROCEDURE incrementar_TE(in porcentaje int)
BEGIN
	
	update precio_habitacion set precio=precio*(1+(porcentaje/100)) 
	where TIPO_HABITACION in (SELECT Categoria from tipo_habitacion where Terraza='si' and Exterior='si');
	
end $$

/*6- Escribir el procedimiento o funcion que permita dar de baja todos aquellos servicios que no han sido
 nunca utilizados por ningún cliente. */
delimiter ;
DROP PROCEDURE IF EXISTS servicios_no_usados;
delimiter $$

CREATE PROCEDURE servicios_no_usados()
BEGIN
	
    DELETE  FROM servicios where idservicios not in (SELECT distinct idservicios from gastos); 
	
end $$
 
/* 7- Escribir el procedimiento o funcion que permita pasando como parámetro el tipo de servicio obtener el 
importe total facturado*/ 
delimiter ;
drop function if exists servicio_imp_total;
delimiter $$
 
CREATE function servicio_imp_total( nombre VARCHAR(20)) returns float READS SQL DATA
BEGIN
	declare total float;
	SELECT sum(precio*cantidad) into total 
	from gastos where idservicios in (Select idservicios from servicio where nombreServicio like nombre);
	
	return total;
end $$

/* 8- Escribir el procedimiento o funcion que permita pasando como parámetro el nombre del cliente obtener
 importe total facturado*/ 
delimiter ;
drop function if exists total_fact_cliente;
delimiter $$
CREATE function total_fact_cliente(nombre_cli VARCHAR(20)) returns float READS SQL DATA
BEGIN
	declare total float;
	
	select sum(precio*cantidad) into total
	from gastos where idreserva in 
	(select idreserva from reserva_habitac where cliente in (select Identificacion from cliente where Nombre like nombre_cli));
	
	return total;
	
end $$

/*9- Escribir el procedimiento o funcion que permita pasando como parámetro el nombre de un pais obtener
el numero total de reservas realizadas*/ 
delimiter ;
drop function if exists reserva_pais;
delimiter $$
CREATE function reserva_pais(nom_pais VARCHAR(20)) returns int READS SQL DATA
BEGIN
	declare total_reservas int;
	
	select count(idreserva) into total_reservas
	from reserva_habitac where cliente in(Select Identificacion from clientes where Pais like nom_pais);
	return total_reservas;
	
end $$

/*10 - Escribir el procedimiento o funcion que permita pasando como parámetro el tipo de servicio actualizar 
el precio de los servicios del mismo tipo, debo poder obtener al final cuantos servicios se han actualizado*/ 
delimiter ;
drop procedure if exists actualizar_precio;
delimiter $$
CREATE PROCEDURE actualizar_precio(in tipo_serv int, in actua INT, out num_actualizados int)
BEGIN		
	declare exit handler for sqlexception
	
	update servicios set precio=precio*actua where idSERVICIOS=tipo_serv;
	select count(idservicios) into num_actualizados from servicios where idSERVICIOS=tipo_serv;
end $$


/*11- funcion que dada una habitación y unas fechas de entrada y salida nos devuelta si está disponible o ocupada */
delimiter ;
drop function if exists disponible;
delimiter $$
create function disponible(n_numhabitacion int(11), n_fechaentrada date, n_fechasalida date) returns boolean READS SQL DATA
begin
	declare reservada boolean;
	
	select ifnull(idreserva,0) into reservada from reserva_habitac
	where numhabitacion=n_numhabitacion and ((n_fechaentrada between fechaentrada and fechasalida) 
	or (n_fechasalida between fechaentrada and fechasalida));
	
	if reservada <> 0 then
		return true;
	else 
		return false;
	end if;
end $$

/*12 - función que al pasarle como parámetro el nombre de un servicio, nos devuelve la diferencia entre 
el importe real de los gastos imputados a reservas y el importe teórico según el precio del servicio*/ 
delimiter ;
DROP function IF exists diferencias ;
delimiter $$

CREATE function diferencias(servicio varchar(30)) returns float READS SQL DATA
BEGIN
	declare valor_r, valor_t float;

	/* calculo el real a partir de la suma de todos los gastos*/
	select ifnull(sum(g.cantidad*g.precio),0) into valor_r from tipo_servicio ts, servicios s, gastos g
	where ts.nombreservicio=s.nombreservicio and s.idservicios=g.idservicios;
	
	/* calculo el teórico a partir de las cantidades de gastos y el precio teórico del servicio*/
	select ifnull(sum(g.cantidad*s.precio),0) into valor_t from tipo_servicio ts, servicios s, gastos g
	where ts.nombreservicio=s.nombreservicio and s.idservicios=g.idservicios;
	
	return(valor_r-valor_t);

end $$


/*13 - función a la que le puedo pasar como parámetro el numero de habitación y me devuelve si algúna vez ha sido ocupada */
delimiter ;
drop function if exists ocupada;
delimiter $$
create function ocupada(n_numhabitacion int(11)) returns varchar(25) READS SQL DATA
begin	
	declare ocupada int;
	select ifnull(count(idreserva),0) into ocupada from reserva_habitac where numhabitacion=n_numhabitacion;
	if suma=0 then
		return 'Hab. Nunca ocupada';
	else 
		return concat('Hab. ocupada ', ocupada, 'veces');
	end if;
end $$

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
delimiter ;
drop function if exists reservas;
delimiter $$
create function reservas(tipo varchar(20), valor varchar(15)) returns int READS SQL DATA
begin	
	declare resultado int;
 
	CASE tipo
		WHEN  'clientes' THEN
			if length(valor)=0 then
				select count(distinct cliente) into resultado from reserva_habitac; 
			else
				select count(idreserva) into resultado from reserva_habitac where cliente=valor; 
			end if;
		WHEN 'habitaciones' THEN
			if (valor='' or valor is null) then
				select count(distinct numhabitacion) into resultado from reserva_habitac; 
			else
				select count(idreserva) into resultado from reserva_habitac where numhabitacion=valor; 
			end if;
		WHEN 'servicios' THEN
			if (valor='' or valor is null) then
				select count(distinct idservicios) into resultado from gastos; 
			else
				select count(idgastos) into resultado from gastos g, servicios s where s.idservicios=g.idservicios 
				and nombreservicio=valor; 
			end if;
	END CASE;
	return resultado;
end $$