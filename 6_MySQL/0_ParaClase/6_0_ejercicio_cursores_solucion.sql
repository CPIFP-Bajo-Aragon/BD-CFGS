create schema comisiones;
use comisiones;

CREATE TABLE ventas (idvta int auto_increment primary key, vendedor int, producto int, fecha date, importe float, tipo_venta int, procesada int(1) default 0 );
CREATE TABLE comisiones (vendedor int, comision float );

/* Valores de ejemplo */
insert into ventas values (0,1,10,'2017-03-11',900,1,0);
insert into ventas values (0,2,11,'2018-01-01',800,2,0);
insert into ventas values (0,3,12,'2017-02-08',9800,1,0);
insert into ventas values (0,2,13,'2018-04-03',90,3,0);
insert into ventas values (0,4,12,'2017-05-05',400,3,1);
insert into ventas values (0,1,11,'2018-04-06',94,2,0);
insert into ventas values (0,5,10,'2017-02-23',350,3,0);
insert into ventas values (0,3,12,'2018-09-19',9800,1,1);
insert into ventas values (0,2,13,'2018-08-12',90,3,0);
insert into ventas values (0,4,12,'2018-07-11',400,3,0);
insert into ventas values (0,1,11,'2017-06-26',94,2,1);
insert into ventas values (0,2,10,'2018-05-29',350,3,0);
insert into ventas values (0,1,12,'2017-08-13',9800,1,0);
insert into ventas values (0,3,13,'2017-05-16',90,3,1);
insert into ventas values (0,4,12,'2018-04-14',400,3,0);
insert into ventas values (0,6,11,'2018-03-09',94,2,0);
insert into ventas values (0,5,10,'2017-02-11',350,3,0);
insert into ventas values (0,3,12,'2018-03-22',9800,1,0);
insert into ventas values (0,1,13,'2018-05-23',90,3,1);
insert into ventas values (0,2,12,'2018-06-24',400,3,0);
insert into ventas values (0,6,11,'2017-04-21',94,2,1);
insert into ventas values (0,2,10,'2018-01-12',350,3,0);


/*Las comisiones se calculan de una forma especial, le corresponde un porcentaje de las ventas
 según el tipo de venta, y es importante para los vendedores el que se sepa en cada momento
 qué comisiones lleva ganadas (esto es una justificación para no usar un cron o algo parecido).

Para calcular qué comisión le corresponde a un vendedor, calcularemos los porcentajes para cada
tipo de venta realizada y luego lo añadiremos/actualizaremos en la tabla de comisiones. Todo 
se realizará en un procedimiento almacenado.

La comisión varía en función del tipo de venta, de forma que si el producto es:

•	Tipo_Venta= 1 la comisión es del 15% del importe
•	Tipo_Venta= 2 la comisión es del 10% del importe
•	Tipo_Venta= 3 la comisión es del 20% del importe*/


/*          SOLUCION BÁSICA    - erronea- no controlo errores*/
delimiter //
drop procedure if exists calcula_comisiones //
create procedure calcula_comisiones () 
begin 
	DECLARE amount float;
    DECLARE v_finished, vta, vendor, sales_type INTEGER DEFAULT 0;
    
    DECLARE comisiones CURSOR FOR SELECT idvta,vendedor, importe, tipo_venta FROM ventas where procesada=0;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;
	
	OPEN comisiones;
    calcula_comisiones: LOOP
		FETCH comisiones INTO vta, vendor, amount, sales_type;
		IF v_finished = 1 THEN
			LEAVE calcula_comisiones;
		else
			case sales_type
				when '1' then UPDATE COMISIONES SET COMISION=COMISION+(amount*0.15) WHERE vendedor=vendor;  
				when '2' then UPDATE COMISIONES SET COMISION=COMISION+(amount*0.10) WHERE vendedor=vendor; 
				when '3' then UPDATE COMISIONES SET COMISION=COMISION+(amount*0.20) WHERE vendedor=vendor; 
            end case;            
        END IF;
	END LOOP calcula_comisiones;
    CLOSE comisiones;
    update ventas set procesada=1 WHERE procesada=0;    
end;
//
call calcula_comisiones;
select * from comisiones;


/* SOLUCION CON HANDLER ADICIONAL Y TRANSACTIONS PARA GESTION DE EXCEPCIONES DURANTE EL PROCESO DE ACTUALIZACION*/
delimiter //
drop procedure if exists calcula_comisiones_v1 //
create procedure calcula_comisiones_v1 () 
begin 
	DECLARE amount float;
    DECLARE v_finished, vta, vendor, sales_type INTEGER DEFAULT 0;
    
    DECLARE comisiones CURSOR FOR SELECT idvta, vendedor, importe, tipo_venta FROM ventas where procesada=0;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;
    DECLARE EXIT HANDLER FOR sqlexception -- GESTIONO CUALQUIER ERROR QUE SE PUEDA PRODUCIR
    BEGIN
		ROLLBACK;
    END;
    
    START TRANSACTION; -- GESTIONO TODOS LOS CAMBIOS EN UNA TRANSACCION POR CONTROL ERRORES.
    OPEN comisiones;
    calcula_comisiones: LOOP
		FETCH comisiones INTO vta, vendor, amount, sales_type;
		IF v_finished = 1 THEN
			LEAVE calcula_comisiones;
		else
			case sales_type
				when '1' then UPDATE COMISIONES SET COMISION=COMISION+(amount*0.15) WHERE vendedor=vendor;  
				when '2' then UPDATE COMISIONES SET COMISION=COMISION+(amount*0.10) WHERE vendedor=vendor; 
				when '3' then UPDATE COMISIONES SET COMISION=COMISION+(amount*0.20) WHERE vendedor=vendor; 
            end case;            
        END IF;
	END LOOP calcula_comisiones;
    CLOSE comisiones;
    update ventas set procesada=1 WHERE procesada=0;
    COMMIT;
end;
//
call calcula_comisiones_v1();
select * from comisiones;


/* SOLUCION CON GESTION DE EXCEPCIONES Y VERIFICACION DE EXISTENCIA DEL VENDEDOR EN TABLA COMISIONES COMISIONES */
delimiter //
drop procedure if exists calcula_comisiones2 //
create procedure calcula_comisiones2 () 
begin 
	DECLARE amount float;
    DECLARE vta, v_finished,  vendor, sales_type, existe INTEGER DEFAULT 0;
    
    DECLARE comisiones CURSOR FOR SELECT idvta, vendedor, importe, tipo_venta FROM ventas where procesada=0;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;
    DECLARE EXIT HANDLER FOR sqlexception 
    BEGIN
		ROLLBACK;
    END;
    /* opcion 1 comprobacion vendedor */
	insert into comisiones select distinct vendedor,'0' from ventas where vendedor not in (select vendedor from comisiones);
	
    START TRANSACTION;
    OPEN comisiones;
    calcula_comisiones: LOOP
		FETCH comisiones INTO vta, vendor, amount, sales_type;
		IF v_finished = 1 THEN
			LEAVE calcula_comisiones;
		else
			/* opcion 2 comprobacion vendedor */
			select count(*) into existe from comisiones where vendedor=vendor;
            if existe =0 then
				insert into comisiones values (vendor,0);
            end if;
			case sales_type
				when '1' then UPDATE COMISIONES SET COMISION=COMISION+(amount*0.15) WHERE vendedor=vendor;  
				when '2' then UPDATE COMISIONES SET COMISION=COMISION+(amount*0.10) WHERE vendedor=vendor; 
				when '3' then UPDATE COMISIONES SET COMISION=COMISION+(amount*0.20) WHERE vendedor=vendor; 
            end case;            
        END IF;
	END LOOP calcula_comisiones;
    CLOSE comisiones;
    update ventas set procesada=1 WHERE procesada=0;
    COMMIT;
end;
//
call calcula_comisiones2();
select * from comisiones;
