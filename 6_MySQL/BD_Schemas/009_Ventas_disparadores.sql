/*
IMPLEMENTAR UN DISPARADOR PARA CONTROLAR LA INSERCION DE DATOS TENIENDO EN CUENTA:
- PRECIO DE VTA > PRECIO COSTE
- STOCK NUNCA PUEDE SER NEGATIVO.
*/
delimiter //
create trigger alta_producto before insert on productos for each row
begin
 if new.precio_vta<new.precio_coste then 
     SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'VALOR DE PRECIO VENTA BAJO';
 end if;
  if new.cantidad_stock<0 then 
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'STOCK NO VALIDO';
 end if;
 end;
//
/*
VERIFICAR EL FUNCIONAMIENTO MEDIANTE LA INSERCION DE REGISTROS
*/
delimiter ;
insert into productos values (1,'PRODUCTO 1', 10, 5, 6, 15); 
insert into productos values (2,'PRODUCTO 2', 10, 8, 10, 20); 
insert into productos values (3,'PRODUCTO 3', 10, 7, 13, 50); 
insert into productos values (4,'PRODUCTO 4', 10, 7, 6, 15); 
insert into productos values (5,'PRODUCTO 5', 10, 11, 16, 0); 
insert into productos values (6,'PRODUCTO 6', 10, 15, 26, 150); 

/*
ESTABLECEMOS CONTROL PARA LA ACTUALIZACION DE REGISTROS.
*/

delimiter //
create trigger update_producto before update on productos for each row
begin
 if (new.precio_vta<new.precio_coste) then 
     SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'VALOR DE PRECIO VENTA BAJO';
 end if;
  if new.cantidad_stock<=0 then 
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'STOCK NO VALIDO';
 end if;
 end;
//

delimiter ;
/*
VERIFICAR EL FUNCIONAMIENTO MEDIANTE LA ACTUALIZACIÓN DE REGISTROS
*/
update productos set nombre='PRODUCTO nuevo 1' where codigo=1; 
update productos set nombre='PRODUCTO nuevo 2', precio_coste=9 where codigo=2; 
update productos set nombre='PRODUCTO nuevo 2', precio_vta=8 where codigo=2; 
update productos set nombre='PRODUCTO nuevo 3', precio_coste=18 where codigo=3; 
update productos set nombre='PRODUCTO nuevo 4', cantidad_stock=0 where codigo=6; 


INSERT INTO `ventas` (`nventas`, `fecha`, `cliente`, `pagado`) 
VALUES ('1', '2023-03-29', 'antonio', '0') , ('2', '2023-03-29', 'ana', '1'),
('3', '2023-03-29', 'juan', '0'), ('4', '2023-03-29', 'alberto', '1');

/*
ESTABLECEMOS CONTROL PARA LA ELIMINACION DE LINEAS DE VENTA
- VERIFICAR EXISTENCIA DEL PRODUCTO, EN LA TABLA DE PRODUCTOS
- VERIFICAR DIPONIBILIDAD DE STOCK 
- SI HAY STOCK DISPONIBLE DECREMENTO LA CANTIDAD DE STOCK
*/

delimiter //
drop trigger if exists alta_linea_vta //
create trigger alta_linea_vta before insert on lin_ventas for each row
begin
 declare existe, stock int;
 
 select count(codigo) into existe 
 from productos where codigo=new.cod_producto;
 
 select cantidad_stock into stock 
 from productos where codigo=new.cod_producto;
 
 if (existe) and (stock > new.cantidad) then 
    update productos set cantidad_stock=stock-new.cantidad where codigo=new.cod_producto;
 else
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'PRODUCTO INEXISTENTE O STOCK DE PRODUCTO NO VALIDO';
 end if;
 end;
//

/*
VERIFICAR EL FUNCIONAMIENTO MEDIANTE LA INSERCION DE LINEAS DE VENTA - FALLAN VARIAS POR NO EXISTIR EL PRODUCTO 
Y OTRAS POR EXISTENCIAS
*/
delimiter ;
INSERT INTO LIN_VENTAS VALUES (1,1,1,100,5) ;
INSERT INTO LIN_VENTAS VALUES (2,1,3,20,5) ;
INSERT INTO LIN_VENTAS VALUES (3,1,2,30,6) ;
INSERT INTO LIN_VENTAS VALUES (4,1,6,35,30) ;
INSERT INTO LIN_VENTAS VALUES (1,2,1,100,5) ;
INSERT INTO LIN_VENTAS VALUES (4,2,16,35,30) ;
INSERT INTO LIN_VENTAS VALUES (1,3,1,100,15) ;
INSERT INTO LIN_VENTAS VALUES (2,3,13,20,5) ;
INSERT INTO LIN_VENTAS VALUES (3,3,2,30,6) ;
INSERT INTO LIN_VENTAS VALUES (4,3,16,35,100) ;


/*
Crear un trigger que gestione el stock de los productos, cuando se borra una linea de venta. */
delimiter //
drop trigger if exists del_linea_vta //
create trigger del_linea_vta after delete on lin_ventas for each row
begin
    update productos set cantidad_stock=stock+old.cantidad 
	where codigo=old.cod_producto;

 end;
//

/*
Crear un trigger para impedir que el importe total de una venta (suma de las lineas de venta de cada
producto) sea superior a 10.000. Además se debe controlar que una venta NO tenga + de 10 lineas venta*/

delimiter //
drop trigger if exists alta_linea_vta //
create trigger alta_linea_vta before insert on lin_ventas for each row
begin
 declare existe, stock int, lineas, importe;
 
 select count(codigo) into existe 
 from productos where codigo=new.cod_producto;
 
 select cantidad_stock into stock 
 from productos where codigo=new.cod_producto;
 
 select count(n_lin_vta) into lineas 
 from lin_ventas where n_venta=new.n_venta;
 
 select sum(importe*cantidad) into importe
 from lin_ventas where n_venta=new.n_venta;
 
 if (existe) and (stock > new.cantidad) and (lineas<10) and (importe+(new.cantidad*new.importe)<10000)then 
    update productos set cantidad_stock=stock-new.cantidad where codigo=new.cod_producto;
 
 else
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'PRODUCTO INEXISTENTE O STOCK DE PRODUCTO NO VALIDO';
 end if;
 end;
//

delimiter //
drop trigger if exists alta_linea_vta //
create trigger alta_linea_vta before insert on lin_ventas for each row
begin
 declare existe, stock int, lineas, importe;
 
 select count(codigo) into existe 
 from productos where codigo=new.cod_producto;
 
 select cantidad_stock into stock 
 from productos where codigo=new.cod_producto;
 
 select count(n_lin_vta) into lineas 
 from lin_ventas where n_venta=new.n_venta;
 
 select sum(importe*cantidad) into importe
 from lin_ventas where n_venta=new.n_venta;
 
 if (lineas>=10) then 
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'LA VENTA YA TIENE 10 LINEAS';
 end if;
 
 if (importe+(new.cantidad*new.importe)>10000)then 
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'LA VENTA EXCEDE EL IMPORTE DE 10000€';
 end if;
 
 if (existe) and (stock > new.cantidad) then 
    update productos set cantidad_stock=stock-new.cantidad where codigo=new.cod_producto;
 
 else
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'PRODUCTO INEXISTENTE O STOCK DE PRODUCTO NO VALIDO';
 end if;
 end;
//

/* CONTROLO EL IMPORTE EN LA ACTULIZACION DE LINEAS DE VTA. NO PUEDE EXCEDER 10000€ */
delimiter //
drop trigger if exists act_linea_vta //
create trigger act_linea_vta before update on lin_ventas for each row
begin
 declare importe;
 
 select sum(importe*cantidad) into importe
 from lin_ventas where n_venta=new.n_venta;
 
 if (importe+(new.cantidad*new.importe)>10000)then 
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'LA VENTA EXCEDE EL IMPORTE DE 10000€';
 end if;
 end;
//

/* Crear un trigger que gestione la eliminacion de ventas. ¿Qué ocurre? */
delimiter //
drop trigger if exists del_vta //
create trigger del_linea_vta before delete on ventas for each row
begin

declare lineas;
 
 select count(n_lin_vta) into lineas 
 from lin_ventas where n_venta=old.n_venta;

 if (lineas>0) then 
      SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'LA VENTA TIENE LINEAS VINCULADAS. NO SE PUEDE BORRAR';
 end if;
 
 end;
//

/* Crear un trigger que gestione la eliminacion de ventas. ¿Qué ocurre? */
delimiter //
drop trigger if exists del_vta //
create trigger del_linea_vta before delete on ventas for each row
begin

 delete from lin_ventas where n_venta=old.n_venta;

 end;
//