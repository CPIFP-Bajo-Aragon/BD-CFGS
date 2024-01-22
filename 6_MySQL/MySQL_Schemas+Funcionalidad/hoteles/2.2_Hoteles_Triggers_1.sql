/* CONTROL AUTOMATIZADO DE TOTAL DE LAS RESERVAS - CAMPO CALCULADO A PARTIR DE LOS GASTOS*/

alter table reserva_habitac add column total_reserva float  default 0;
update reserva_habitac set total_reserva=0;

/* control y actualización dle valor total de cada reserva */
delimiter $$
drop trigger if exists alta_gasto $$
create trigger alta_gasto after insert  on gastos for each row
	begin
		update reserva_habitac set total_reserva=total_reserva+(new.cantidad*new.precio)  where idRESERVA=new.idRESERVA;
	end;
$$
delimiter $$
drop trigger if exists baja_gasto $$
create trigger baja_gasto after delete  on gastos for each row
	begin
		update reserva_habitac set total_reserva=total_reserva-(old.cantidad*old.precio) where idRESERVA=old.idRESERVA;
	end;
$$
delimiter $$
drop trigger if exists update_gasto$$
create trigger update_gasto before update  on gastos for each row
	begin
		if new.precio<> old.precio or new.cantidad<>old.cantidad then
		update reserva_habitac 
        set total_reserva=total_reserva-(old.cantidad*old.precio)+(new.cantidad*new.precio) where idRESERVA=new.idRESERVA;
        end if;
	end;
$$

INSERT INTO  gastos  ( idgastos,idRESERVA  , idSERVICIOS  ,Fecha ,Cantidad ,Precio) VALUES (4,1,1, '2009-03-15 12:00', 1,10);
INSERT INTO  gastos  ( idgastos,idRESERVA  , idSERVICIOS  ,Fecha ,Cantidad ,Precio) VALUES (5, 1,1,  '2009-03-15 11:00', 1,10);
INSERT INTO  gastos  (idgastos, idRESERVA  , idSERVICIOS  ,Fecha ,Cantidad ,Precio) VALUES (6, 4, 2, '2009-03-15 09:30', 1,2);
INSERT INTO  gastos  ( idgastos,idRESERVA  , idSERVICIOS  ,Fecha ,Cantidad ,Precio) VALUES (7,1,1, '2009-03-15 12:00', 1,10);
INSERT INTO  gastos  ( idgastos,idRESERVA  , idSERVICIOS  ,Fecha ,Cantidad ,Precio) VALUES (8, 1,1,  '2009-03-15 11:00', 1,10);
INSERT INTO  gastos  (idgastos, idRESERVA  , idSERVICIOS  ,Fecha ,Cantidad ,Precio) VALUES (9, 4, 2, '2009-03-15 09:30', 1,2);
INSERT INTO  gastos  ( idgastos,idRESERVA  , idSERVICIOS  ,Fecha ,Cantidad ,Precio) VALUES (10,1,1, '2009-03-15 12:00', 1,10);
INSERT INTO  gastos  ( idgastos,idRESERVA  , idSERVICIOS  ,Fecha ,Cantidad ,Precio) VALUES (11, 1,1,  '2009-03-15 11:00', 1,10);
INSERT INTO  gastos  (idgastos, idRESERVA  , idSERVICIOS  ,Fecha ,Cantidad ,Precio) VALUES (12.,4, 2, '2009-03-15 09:30', 1,2);

delete from gastos where idgastos in (4,8);