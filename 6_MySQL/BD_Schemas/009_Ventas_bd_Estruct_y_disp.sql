create schema ventas_triggers; 
use ventas_triggers; 
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


/*TRIGER DAR DE ALTA LINEA*/
drop trigger if exists control_ventas;
create trigger control_ventas before insert on lin_ventas for each row
begin
    update productos set cantidad_stock=cantidad_stock-new.cantidad where codigo=new.cod_producto;
end

/*TRIGER DAR DE BAJA UNA LINEA*/
drop trigger if exists baja_pedido;
create trigger baja_pedido before delete on lin_ventas for each row
begin
    update productos set cantidad_stock=cantidad_stock+old.cantidad where codigo=old.cod_producto;
end;

/*TRIGER UPDATE */
drop trigger if exists mod_pedido;
create trigger mod_pedido before update on lin_ventas for each row
begin
    update productos set cantidad_stock=cantidad_stock-(new.cantidad-old.cantidad) where codigo=new.cod_producto ;
end;
