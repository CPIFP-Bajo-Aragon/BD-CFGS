/* IMPLEMENTAR UN SISTEMA DE LOGS DONDE QUEDAN REGISTRADO LA BAJA DE RESERVAS Y QUIEN LA HA REALIZADO*/

CREATE TABLE  logs_reservas (
   id   int primary key ,
   descripcion varchar(50)  NOT NULL,
   fecha_mov  date not null,
  usuario varchar(20));

/* control y actualización dle valor total de cada reserva */
delimiter $$
drop trigger if exists baja_reserva $$
create trigger baja_reserva before delete  on reserva_habitac for each row
    begin
    	declare cont_res, cont_gas, cont_logs int; 
		select ifnull(count(idreserva),0) into cont_res from reserva_habitac where idreserva=old.idreserva;
        select ifnull(count(idgastos),0) into cont_gas from gastos where idreserva=old.idreserva;
        if (cont_res=1) then
			if(cont_gas>0) then
					delete from gastos where idreserva=old.idreserva;
			end if;
			select IFNULL(max(id),0)+1 into cont_logs from logs_reservas ;
            insert into  logs_reservas values (cont_logs,concat('Se ha borrado la reserva con id ', old.idreserva) ,CURDATE() ,CURRENT_USER() );
            end if;
	end;
$$

/* COMO HAY UN TRIGGER PREVIAMENTE DEFINIDO SOBRE GASTOS QUE TIENE INFLUYENCIA SOBRE LA TABLA DE RESERVAS EN LA QUE DEFINO
OTRO DISPARADOR --> PROBLEMAS DE REDUNDANCIA CICLICA --> HAY QUE ELIMINAR EL TRIGER ANTERIOR */
drop trigger baja_gasto;