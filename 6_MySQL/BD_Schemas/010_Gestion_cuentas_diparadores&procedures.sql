insert into CUENTA values('ES948443432842945938', 'Paco', 'Luis', 0, 5923.32);
insert into CUENTA values('ES958131232223425122', 'Mateo', 'Lewis', 0, 542);
insert into CUENTA values('ES242342284225667743', 'Chis', 'Kiss', 520,1354);


insert into Apuntes values(0, 1, '2020-02-03', 'nomina', 'ES948443432842945938', 1000);
insert into Apuntes values(0, 2, '2020-02-03', 'pago luz ', 'ES948443432842945938', -50);
insert into Apuntes values(0, 3, '2020-02-03', 'nomina', 'ES958131232223425122', 1000);
insert into Apuntes values(0, 4, '2020-02-03', 'pago luz ', 'ES958131232223425122', -50);
insert into Apuntes values(0, 5, '2020-02-03', 'nomina', 'ES958131232223425122', -15000);
insert into Apuntes values(0, 6, '2020-02-03', 'pago luz ', 'ES958131232223425122', -50);

drop  trigger IF EXISTS nuevo_apunte;
delimiter $$
create trigger nuevo_apunte before insert on APUNTES for each row
	begin
		declare saldo FLOAT;
		select max(importe_actual) into saldo from cuenta where cuenta=new.cuenta;
		if (saldo + new.importe>0)then
			update cuenta set importe_actual=importe_actual+new.importe where cuenta=new.cuenta;
		end if;
end; $$

create trigger elimnacion_apunte after delete on APUNTES for each row
			update cuenta set importe_actual=importe_actual-old.importe where cuenta=old.cuenta; 

create trigger modif_apunte after update on APUNTES for each row
		update cuenta set importe_actual=importe_actual+(new.importe-old.importe) where cuenta=new.cuenta;
        

/******************************* PROCEDIMIENTOS ******************/
delimiter $$
DROP PROCEDURE IF EXISTS alta_apuntes;
create procedure alta_apuntes(IN par1 int, in par2 int, in par3 date, in par4 varchar(10), in par5 varchar(24), in par6 float, out MENSAJE VARCHAR(50))	 
begin
	declare existe int;
    /* comporbar que existe la cuenta */
    /* existe -> alta del apunte */
	insert into Apuntes values(par1, par2, par3, par4, par5, par6);
    /* no existe --> mensaje de que no existe cuenta */
    set MENSAJE='ALTA REALIZADA CORRECTAMENTE';
end;
$$

call alta_apuntes(0, 11, '2020-02-03', 'nomina', 'ES948443432842945938', 1000, @mensaje);
select @mensaje;

call alta_apuntes(0, 13, '2020-02-03', 'nomina', 'ES958131232223425122', 1000);
call alta_apuntes(0, 14, '2020-02-03', 'pago luz ', 'ES958131232223425122', -50);
call alta_apuntes(0, 15, '2020-02-03', 'nomina', 'ES958131232223425122', -15000);
call alta_apuntes(0, 16, '2020-02-03', 'pago luz ', 'ES958131232223425122', -50);

delimiter $$
create procedure baja_cuenta (in cta varchar(24))
begin
	delete from apuntes where cuenta=cta;
    delete from cuenta where cuenta=cta;
end;
$$
call baja_cuenta('ES958131232223425122');

