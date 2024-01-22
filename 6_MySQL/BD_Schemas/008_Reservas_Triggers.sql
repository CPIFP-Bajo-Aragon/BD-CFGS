/************** SCRIPT CREACION DISPARADORES ***********************/
CREATE SCHEMA EJERCICIO3;
USE EJERCICIO3;

/************* IMPLEMENTACION DE UN SISTEMA DE TRACKING DE CAMBIOS ****/
/* CREO LA TABLA AUXILIAR PARA GUARDAR LOS DATOS DE LOS TRIGGERS*/
create table IF NOT EXISTS tracking(
id int auto_increment,
descripcion varchar(50),
tabla varchar(15),
fecha datetime,
constraint pk_tracking primary key (id)
);

/* CREACION DE LOS DISPARADORES PARA LAS TABLAS CLIENTES Y RESERVAS*/ 
drop trigger if exists alta_clientes;
create trigger alta_clientes after insert on clientes for each row
insert into tracking 
values(0,concat('ALTA DE CLIENTE ', new.identificacion, ' - ', new.nombre),'CLIENTES',now());

drop trigger if exists baja_reservas;
create trigger baja_reservas before delete on reserva_habitac for each row
insert into tracking 
values(0,'BAJA DE RESERVA', 'RESERVA_HABITAC',now());
