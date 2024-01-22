insert into CUENTA values('ES948443432842945938', 'Paco', 'Luis', 0, 5923.32);
insert into CUENTA values('ES958131232223425122', 'Mateo', 'Lewis', 0, 542);
insert into CUENTA values('ES242342284225667743', 'Chis', 'Kiss', 520,1354);

insert into Apuntes values(0, 1, '2020-02-03', 'nomina', 'ES948443432842945938', 1000);
insert into Apuntes values(0, 2, '2020-02-03', 'pago luz ', 'ES948443432842945938', -50);

delimiter $$
create trigger nuevo_apunte after insert on APUNTES for each row
	begin
		update cuenta set importe_actual=importe_actual+new.importe where cuenta=new.cuenta;		
end; $$

delimiter $$
create trigger elimnacion_apunte after delete on APUNTES for each row
	begin
    
end; $$

delimiter $$
create trigger modif_apunte after update on APUNTES for each row
	begin
    
end; $$