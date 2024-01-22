CREATE database centroeducativo;
USE centroeducativo;

DELIMITER //
drop procedure if exists creacion_tablas//
CREATE procedure creacion_tablas()
begin
	declare exit HANDLER FOR SQLEXCEPTION
	begin
		rollback;
        GET DIAGNOSTICS CONDITION 1 @p2 = RETURNED_SQLSTATE, @p1 = MESSAGE_TEXT; -- statement enables applications to inspect sql information
        insert into log values(@p1, current_timestamp(), 'proc creacion tablas');
	end;
	START transaction;
		drop table if exists matricula;
        drop table if exists alumno;
        drop table if exists asignatura;
        drop table if exists log;
        create table alumno(
			dni integer(10),
			nombre varchar(50),
			apellidos varchar(100),
			telefono varchar(12),
			cp varchar(10),
			poblacion varchar(100),
			CONSTRAINT PK_alumno PRIMARY KEY (dni)
		);    
		create table asignatura(
			cod integer(10),
			nombre varchar(50),
			horas  varchar(100),
			creditos varchar(12),
			curso varchar(10),
			CONSTRAINT PK_asignatura PRIMARY KEY (cod)
		);
		create table matricula(
			dni integer(10),
			cod integer(10),
			curso varchar(50),
			nota  integer(10),
			CONSTRAINT PK_matricula PRIMARY KEY (dni,cod,curso),
			CONSTRAINT FK_matricula_alumno FOREIGN KEY (dni) references alumnos(dni1),
			CONSTRAINT FK_matricula_asignatura FOREIGN KEY (dni) references asignaturas(cod)
		);
		create table if not exists log (
			error varchar(50),
			fecha datetime,
			origen varchar(25)
		);
	COMMIT;  
END
//
DELIMITER ;

DELIMITER //
CREATE procedure inserta_val_ejemplo()
begin
	declare exit HANDLER FOR sqlexception
	begin
		rollback;
        GET DIAGNOSTICS CONDITION 1 @p2 = RETURNED_SQLSTATE, @p1 = MESSAGE_TEXT; -- statement enables applications to inspect sql information
		insert into log values(@p1, curdate(), 'proc inserta datos ejemplo');
    end;
    declare continue HANDLER FOR sqlwarning
	begin
        GET DIAGNOSTICS CONDITION 1 @p2 = RETURNED_SQLSTATE, @p1 = MESSAGE_TEXT; -- statement enables applications to inspect sql information
		insert into log values(@p1, curdate(), 'proc inserta datos ejemplo');
    end;
	start transaction;
		insert into alumno values (12354651,"alumno1","apellidos1 y 2","97887854","551221","hola");
        insert into alumno values (12354652,"alumno2","apellidos1 y 2","97887854","551221","hola");
        insert into alumno values (12354653,"alumno3","apellidos1 y 2","97887854","551221","hola");
        insert into alumno values (12354654,"alumno4","apellidos1 y 2","97887854","551221","hola");
        insert into alumno values (12354655,"alumno5","apellidos1 y 2","97887854","551221","hola");
		insert into alumno values (12354651,"alumno6 REPETIDO","apellidos1 y 2","97887854","551221","hola");
	COMMIT;
END
//
DELIMITER ;

call creacion_tablas();
CALL inserta_val_ejemplo();