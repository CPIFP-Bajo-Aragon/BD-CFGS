delimiter //
drop procedure if exists alta_gasto //
create procedure alta_gasto (in nreserva int, in nservicio int, in fecha datetime, 
in ncantidad int, in precio float, out mensaje varchar(30))
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
//
delimiter ;
call alta_gasto (2,1, '2009-03-18 19:00', 25,10,@resultado);
select @resultado;
call alta_gasto (2,1, '2009-03-18 19:00', 50,10,@resultado);
select @resultado;
call alta_gasto ( 2,3, '2009-03-30 15:00', 10,10,@resultado2);
select @resultado2;