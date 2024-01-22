create schema ventas; 
use ventas; 
drop table if exists lin_ventas; 
drop table if exists productos; 
drop table if exists ventas; 

create  table  productos(  
codigo  varchar(12)  primary key,  
nombre  varchar(30),  
porcent_bene float, 
precio_coste float, 
precio_vta float, cantidad_stock int ); 

Create table ventas( 
nventas int primary key, 
fecha date, 
cliente varchar(30), 
pagado tinyint ); 

Create table lin_ventas( 
n_lin_venta int, 
n_venta int, 
cod_producto varchar(12), 
importe float, cantidad  int,  
constraint  pk_lin_ventas  primary  key(n_lin_venta,  n_venta),  
constraint fk_linvtas_vta foreign key(n_venta) references ventas(nventas) on update cascade on delete cascade,  
constraint  fk_linvtas_prod  foreign  key(cod_producto) references  productos(codigo) on update cascade on delete cascade); 



insert into ventas values ( 1,'2021-04-04', 'Antonio', 0);
insert into ventas values ( 2,'2021-04-06', 'Juan', 0);
insert into ventas values ( 3,'2021-04-08', 'Ana', 0);
insert into ventas values ( 4,'2021-04-12', 'Pedro', 0);

insert into productos values ('0001', 'Producto 1', 11.3, 14, 18, 45);
insert into productos values ('0002', 'Producto 2', 21.3, 24, 28, 36);
insert into productos values ('0003', 'Producto 3', 31.3, 34, 38, 91);
insert into productos values ('0004', 'Producto 4', 41.3, 44, 48, 129);


drop procedure if exists alta_lin_venta;
delimiter //

create procedure alta_lin_venta (in n_venta int, in cod_producto varchar(12), 
in importe float, in cantidad int, out mensaje varchar(30))
begin
	declare ex_vta, linea , ex_prod int;
	
	select IFNULL(nventas,0) into ex_vta from ventas where nventas=n_venta;
	select IFNULL(codigo,0) into ex_prod from productos where codigo=cod_producto;
	
	if (ex_vta<>0) and (ex_prod <>0) then
		select IFNULL(MAX(n_lin_venta),0) into linea from lin_ventas;
		set linea= linea + 1;
		insert into lin_ventas values (linea, n_venta, cod_producto, importe, cantidad);
		set mensaje='Alta realizada correctamente';
	else
		set mensaje='Alta no se puede realizar';
	end if;
end;
//

call alta_lin_venta(2, '0002', 50, 4, @mensaje);
select @mensaje;


delimiter //
drop function if exists lin_vtas //
create function lin_vtas (num_vta int) returns int 
begin 
declare lineas int;
select count(n_lin_venta) into lineas  from lin_ventas where n_venta=num_vta;
return lineas; 
end
//

select nventas, lin_vtas(nventas) from ventas where nventas='1';