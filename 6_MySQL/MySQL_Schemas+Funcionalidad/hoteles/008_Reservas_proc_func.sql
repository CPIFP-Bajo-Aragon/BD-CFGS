
/************* IMPLEMENTACION DE UN SISTEMA DE FUNICIONES Y PROCEDMIENTOS ****/
/*********** INCORPORAR LA GESTION DE EXCEPCIONES QUE SE PUEDAN PRODUCIR *****/
/* Procedimiento que gestione el alta de gastos de una reserva según lo siguiente:
- si el servicio ya existe dentro de la reserva, solo incrementamos las unidades.
- sino existe dicho servicio, creamos el alta del gasto correspondiente.*/


/* Procedmiento que gestione el alta de reservas de habitacion
sólo se podrá hacer la reserva si la habitacion indicada está disponible en las fechas requeridas.*/


/* procedmiento para toda las reservas dentro de un rango de fechas permita
aplicar una reducción de precio a todos los servicios gastados correspondientes a un tipo de servicio*/


/* procedimiento que al pasarle como parámetro el nombre de un servicio, nos devuelve la diferencia entre 
el importe real de los gastos imputados a reservas y el importe teórico según el precio del servicio*/ 



/*	5- SOLUCION NO VALIDA PUES NO EXISTE LA TABLA PRECIO_HABITACION EN EL ESQUEMA
procedimento o funcion que permita incrementar un 15% el precio de las habitaciones 
que tengan Terraza y sean Exteriores. */


/* procedimiento o funcion que permita dar de baja todos aquellos servicios que no han sido
 nunca utilizados por ningún cliente. */

 
/*  procedimiento o funcion que permita pasando como parámetro el tipo de servicio obtener el 
importe total facturado*/ 



/* procedimiento o funcion que permita pasando como parámetro el nombre del cliente obtener
 importe total facturado*/ 


/* procedimiento o funcion que permita pasando como parámetro el nombre de un pais obtener
el numero total de reservas realizadas*/ 


/* procedimiento o funcion que permita pasando como parámetro el tipo de servicio actualizar 
el precio de los servicios del mismo tipo, debo poder obtener al final cuantos servicios se han actualizado*/  


/* funcion que dada una habitación y unas fechas de entrada y salida nos devuelta si está disponible o ocupada */


/* función que al pasarle como parámetro el nombre de un servicio, nos devuelve la diferencia entre 
el importe real de los gastos imputados a reservas y el importe teórico según el precio del servicio*/ 

/* función a la que le puedo pasar como parámetro el numero de habitación y me devuelve si algúna vez ha sido ocupada */

/* función a la que si le paso como parámetro1 el string:
 'habitaciones' me devuelve el numero de habitaciones diferentes reservadas,
 'clientes' me devuelve el numero de clientes diferentes que han hecho reservas,
 'servicios' me devuelve el numero de servicios diferentes reservados.
 Si como parámetro dos recibe el valor de un elemento referenciado en el parámetro1 entonces filtra por dicho valor
 Posibles ejemplos de esta función serían:
 select identificacion, nombre, apellido1, reservas('clientes',identificacion) from clientes;
 select numhabitacion, tipohabitacion, reservas('habitaciones','') from habitaciones;
 select nombreservicio, reservas('servicios',nombreservicio), sum(cantidad*precio)
 from gastos g, servicios s where g.idservicios=s.idservicios;