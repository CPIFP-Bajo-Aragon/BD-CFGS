create schema gest_eventos;
use gest_eventos;

/* creacion de las tablas */ 
create table t2(
    s1 int,
    primary key (s1)
)engine=innodb;

create table t3 (
    s1 int primary key,
    foreign key (s1) references t2 (s1)
)engine=innodB;

/* sentencia inicial */
insert into t3 values(5);


/* 1- modificamos creando un procedimiento que se encarga de hacer el insert*/
delimiter //
drop procedure if exists alta_t31//
create procedure alta_t31 (in valor_s int)
begin
    insert into t3 values(valor_s);	
end;
//

call alta_t31 (5);

/* 2- modificamos el procedimiento añadiendo la gestion de excepción*/
delimiter //
drop procedure if exists alta_t32//
create procedure alta_t32 (in valor_s int)
begin
	declare exit handler for 1452 /* solo gestiona este error*/
    begin
		/* signal -> manda a consola estado de BD y coloca un mensaje personalizado */
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='DA DE ALTA EN LA TABLA PADRE';
    end;
    insert into t3 values(valor_s);	
end;
//

call alta_t32 (5);


/* 3.0- creamos una tabla de log donde almacenar mensajes de la base de datos*/
drop table if exists log_error;
create table log_error (id int auto_increment primary key, mensaje varchar(50), tabla varchar(25), fecha_hora timestamp);

/* 3.1 - modificamos el procedimiento para que en lugar de mostrar error lo almacena en log */
delimiter //
drop procedure if exists alta_t33//
create procedure alta_t33 (in valor_s int)
begin
	declare exit handler for 1452
    begin
		insert into log_error values(0,'ERRROR EN EL PROCEDIMIENTO DE ALTA EN LA TABLA','t3', sysdate());
    end;
	declare exit handler for sqlwarning begin end;
    insert into t3 values(valor_s);	
end;
//

call alta_t33 (5);
select * from log_error;

/* 4- creamos el procedimiento que en lugar de mostrar error lo almacena en log */
delimiter //
drop procedure if exists alta_t34//
create procedure alta_t34 (in valor_s int)
begin
	declare exit handler for sqlexception
    begin
		rollback;
		insert into log_error values(0,'ERRROR EN EL PROCEDIMIENTO DE ALTA EN LA TABLA','t3', sysdate());
    end;
	start transaction; /* automáticamente coloca el autocommit=0 */
    insert into t2 values(valor_s);	
    insert into t3 values(valor_s);	
	insert into t1 values(valor_s);	
    insert into t4 values(valor_s);
	commit;
end;
//

call alta_t34(7);
select * from log_error;
SELECT * from t2;
SELECT * from t3;

/* 5- modificamos el procedimiento que gestione warnings (continua) y errores (sale) y los almacene en log */
delimiter //
drop procedure if exists alta_t35//
create procedure alta_t35 (in valor_s int)
begin
	declare exit handler for sqlexception
    begin
		rollback;
		insert into log_error values(0,'ERRROR EN EL PROCEDIMIENTO DE ALTA EN LA TABLA','t3', sysdate());
    end;
	declare continue handler for sqlwarning
    begin
		insert into log_error values(0,'MENSAJE DE ADVERTENCIA EN EL PROCEDIMIENTO DE ALTA','t3', sysdate());
    end;
	start transaction;
    insert into t2 values(valor_s);	
    insert into t3 values(valor_s);	
	insert into t1 values(valor_s);	
    insert into t4 values(valor_s);
	commit;
end;
//

call alta_t35 (9);
select * from log_error;
SELECT * from t2;
SELECT * from t3;