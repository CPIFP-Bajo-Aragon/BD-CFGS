DELIMITER //
DROP PROCEDURE IF EXISTS drop_schema//
CREATE PROCEDURE drop_schema  (inout mensaje varchar(50))
BEGIN
DROP TABLE  IF EXISTS  gastos  ;
DROP TABLE  IF EXISTS  reserva_habitac  ;
DROP TABLE  IF EXISTS clientes;
DROP TABLE  IF EXISTS  paises ;
DROP TABLE  IF EXISTS  habitaciones  ;
DROP TABLE  IF EXISTS  tipo_habitacion ;
DROP TABLE  IF EXISTS servicios  ;
DROP TABLE  IF EXISTS tipo_servicio ;
DROP TABLE  IF EXISTS logs_reservas ;
  
set mensaje="LAS TABLAS SE HAN ELIMINADO CORRECTAMENTE";
END;
//