/************* IMPLEMENTACION DE UN SISTEMA DE FUNICIONES Y PROCEDMIENTOS ****/
/*********** INCORPORAR LA GESTION DE EXCEPCIONES QUE SE PUEDAN PRODUCIR *****/

/* Procedimiento para crear el esquema de la base de datos */

delimiter //
drop procedure if exists crear_schema //
create procedure crear_schema ()
begin

end
//

/* Procedimiento para dar de alta datos de ejemplo en la base de datos */

delimiter //
drop procedure if exists datos_ejemplo//
create procedure datos_ejemplo ()
begin
	
end
//

/* 1- Procedimiento que gestione el alta de gastos de una reserva según lo siguiente:
- si el servicio ya existe dentro de la reserva, solo incrementamos las unidades.
- sino existe dicho servicio, creamos el alta del gasto correspondiente.*/
delimiter //
drop procedure if exists alta_gasto//
create procedure alta_gasto (in nreserva int, in nservicio int, in fecha datetime, in cantidad int, in precio float, out mensaje varchar(20))
begin
	
end
//

/* 2- Procedmiento que gestione el alta de reservas de habitacion
sólo se podrá hacer la reserva si la habitacion indicada está disponible en las fechas requeridas.*/

delimiter //
drop  procedure if exists nueva_reserva //
create procedure nueva_reserva (in nreserva int, in fecha_e date, in fecha_s date, in iva float, in nhabitacion int, in ncliente varchar(12), out mensaje varchar(20))
begin
	
end
//

/* 3- procedmiento para toda las reservas dentro de un rango de fechas permita
aplicar una reducción de precio a todos los servicios gastados correspondientes a un tipo de servicio*/
delimiter //
drop procedure if exists dto_gasto//
create procedure dto_gasto(in n_nombreservicio varchar(10),in n_fechainicio date, in n_fechafin date,in descuento float(5))
begin
	
end 
//

/* 4- procedimiento que al pasarle como parámetro el nombre de un servicio, nos devuelve la diferencia entre 
el importe real de los gastos imputados a reservas y el importe teórico según el precio del servicio*/ 
delimiter //
DROP PROCEDURE IF exists calcular_diferencia //
CREATE PROCEDURE calcular_diferencia(in servicio varchar(30), out diferencia float)
BEGIN
	

end 
//

/*5- Escribir el procedimento o funcion que permita incrementar un % el precio de las habitaciones 
que tengan Terraza y sean Exteriores. */

delimiter //
DROP PROCEDURE IF exists incrementar_TE //
CREATE PROCEDURE incrementar_TE(in porcentaje int)
BEGIN
	
end 
//

/*6- Escribir el procedimiento o funcion que permita dar de baja todos aquellos servicios que no han sido
 nunca utilizados por ningún cliente. */

delimiter //
DROP PROCEDURE IF EXISTS servicios_no_usados //
CREATE PROCEDURE servicios_no_usados()
BEGIN
	
end 
//
 
/* 7- Escribir el procedimiento o funcion que permita pasando como parámetro el tipo de servicio obtener el 
importe total facturado*/ 

delimiter //
drop function if exists servicio_imp_total //
CREATE function servicio_imp_total( nombre VARCHAR(20)) returns float READS SQL DATA
BEGIN
	
end 
//

/* 8- Escribir el procedimiento o funcion que permita pasando como parámetro el nombre del cliente obtener
 importe total facturado*/ 
delimiter //
drop function if exists total_fact_cliente //
CREATE function total_fact_cliente(nombre_cli VARCHAR(20)) returns float READS SQL DATA
BEGIN
	
	
end 
//

/*9- Escribir el procedimiento o funcion que permita pasando como parámetro el nombre de un pais obtener
el numero total de reservas realizadas*/ 

delimiter //
drop function if exists reserva_pais //
CREATE function reserva_pais(nom_pais VARCHAR(20)) returns int READS SQL DATA
BEGIN
	
end 
//

/*10 - Escribir el procedimiento o funcion que permita actualizar el precio de los servicios correspondientes
al tipo de servicio pasado como parámetro. El precio nuevo, se pasará también como parámetro.
El procedimento debe permitir obtener el numero de servicios que se han actualizado*/  

delimiter //
drop procedure if exists actualizar_precio //
CREATE PROCEDURE actualizar_precio(in tipo_serv varchar(25), in actua INT, out num_actualizados int)
BEGIN		
	
end 
//


/*11- funcion que dada una habitación y unas fechas de entrada y salida nos devuelta si está disponible o ocupada */
delimiter //
drop function if exists disponible //
create function disponible(n_numhabitacion int(11), n_fechaentrada date, n_fechasalida date) returns boolean READS SQL DATA
begin
	
end 
//

/*12 - función que al pasarle como parámetro el nombre de un servicio, nos devuelve la diferencia entre 
el importe real de los gastos imputados a reservas y el importe teórico según el precio del servicio*/ 

delimiter //
DROP function IF exists diferencias //
CREATE function diferencias(servicio varchar(30)) returns float READS SQL DATA
BEGIN
	

end 
//


/*13 - función a la que le puedo pasar como parámetro el numero de habitación y me devuelve si algúna vez ha sido ocupada */

delimiter //
drop function if exists ocupada //
create function ocupada(n_numhabitacion int(11)) returns varchar(25) READS SQL DATA
begin	
	
end 
//

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
	
end 
//