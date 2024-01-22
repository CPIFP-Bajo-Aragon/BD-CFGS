DELIMITER $$
drop procedure if exists ALTA_DATOS;
CREATE PROCEDURE `ALTA_DATOS`()
BEGIN
declare cont_tser, cont_pais, cont_clientes,cont_thab, cont_hab, 
cont_serv, cont_res, cont_gas, cont_logs integer;

select ifnull(count(idreserva),0) into cont_res from reserva_habitac;
select ifnull(count(idgastos),0) into cont_gas from gastos;
select ifnull(count(NombreSERVICIO),0) into cont_tser from tipo_servicio;
select ifnull(count(pais),0) into cont_pais from paises;
select ifnull(count(Identificacion),0) into cont_clientes from clientes;
select ifnull(count(idSERVICIOS),0) into cont_serv from servicios;
select ifnull(count(Categoria),0) into cont_thab from tipo_habitacion;
select ifnull(count(NumHABITACION),0) into cont_hab from habitaciones;

if (cont_res=0 and cont_gas=0 and cont_tser=0 and cont_pais=0 and cont_clientes=0
 and cont_serv=0 and cont_thab=0 and cont_hab=0) then 
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

INSERT INTO  habitaciones  VALUES (101, 1);
INSERT INTO  habitaciones  VALUES (102, 1);
INSERT INTO  habitaciones  VALUES (103, 1);
INSERT INTO  habitaciones  VALUES (104, 2);
INSERT INTO  habitaciones  VALUES (105, 2);
INSERT INTO  habitaciones  VALUES (106, 3);
INSERT INTO  habitaciones  VALUES (107, 4);

INSERT INTO  servicios  VALUES (1, 'COMEDOR', '1 menu del Dia', 10, 7, '2009-01-01');
INSERT INTO  servicios  VALUES (2, 'LAVANDERIA', 'Lavado de Camisa', 2, 7, '2009-01-01');
INSERT INTO  servicios  VALUES (3, 'LAVANDERIA', 'Lavado de pantalon', 1, 7, '2009-01-01');

INSERT INTO  reserva_habitac   (FechaENTRADA , FechaSALIDA  , IVA , NumHABITACION  , CLIENTE) VALUES ( '2009-03-15', '2009-03-25', 0.07,101, '12345');
INSERT INTO  reserva_habitac (FechaENTRADA , FechaSALIDA  , IVA , NumHABITACION  , CLIENTE) VALUES ( '2009-03-15', '2009-03-25', 0.07, 102, '12345');
INSERT INTO  reserva_habitac (FechaENTRADA , FechaSALIDA  , IVA , NumHABITACION  , CLIENTE)  VALUES ( '2009-02-16', '2009-02-21', 0.07,103, '12345');
INSERT INTO  reserva_habitac  (FechaENTRADA , FechaSALIDA  , IVA , NumHABITACION  , CLIENTE) VALUES ( '2009-03-16', '2009-03-21', 0.07,104, '44444');
INSERT INTO  reserva_habitac (FechaENTRADA , FechaSALIDA  , IVA , NumHABITACION  , CLIENTE)  VALUES ( '2009-03-16', '2009-03-21', 0.07,105, '44444');
INSERT INTO  reserva_habitac  (FechaENTRADA , FechaSALIDA  , IVA , NumHABITACION  , CLIENTE) VALUES ( '2009-03-16', '2009-03-21', 0.07,106, '44444');
INSERT INTO  reserva_habitac (FechaENTRADA , FechaSALIDA  , IVA , NumHABITACION  , CLIENTE)  VALUES ( '2009-03-16', '2009-03-21', 0.07,107, '44444');

INSERT INTO  gastos  ( idgastos,idRESERVA  , idSERVICIOS  ,Fecha ,Cantidad ,Precio) VALUES (1,1,1, '2009-03-15 12:00', 1,10);
INSERT INTO  gastos  ( idgastos,idRESERVA  , idSERVICIOS  ,Fecha ,Cantidad ,Precio) VALUES (2, 1,1,  '2009-03-15 11:00', 1,10);
INSERT INTO  gastos  (idgastos, idRESERVA  , idSERVICIOS  ,Fecha ,Cantidad ,Precio) VALUES (3, 4, 2, '2009-03-15 09:30', 1,2);
else 
	select IFNULL(max(id),0)+1 into cont_logs from logs_reservas ;
	 insert into  logs_reservas values (cont_logs,concat('NO PUEDO REGISTRAR DATOS EJEMPLO') ,CURDATE() ,CURRENT_USER() );
end if;
END$$
