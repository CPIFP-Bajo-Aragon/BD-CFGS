-- CREATE DATABASE ejercicio_embarques;
USE ejercicio_embarques;

/* ELIMINACION DE LAS TABLAS EXISTENTES */
DROP TABLE IF EXISTS embarque;
DROP TABLE IF EXISTS cliente;
DROP TABLE IF EXISTS camion;
DROP TABLE IF EXISTS ciudad;


/* CREACION DE LAS TABLAS DEL EJERCICIO */
CREATE TABLE cliente(cli_id int primary key, nomb_cli varchar(50) not null default '', renta_anual float);
CREATE TABLE camion(cam_id int, cam_nombre_chofer varchar(50), PRIMARY KEY (cam_id) );
CREATE TABLE ciudad(ciu_id int primary key, ciu_nombre varchar(50), poblacion int);
CREATE TABLE embarque(emb_id int primary key, emb_id_cli int, emb_id_cam int, emb_destino int, emb_peso float, 
constraint fk1 foreign key (emb_id_cli) references cliente(cli_id), 
constraint fk2 foreign key (emb_id_cam) references camion(cam_id),
constraint fk3 foreign key (emb_destino) references ciudad(ciu_id)
);

/* INSERCION DE DATOS EN LAS TABLAS */
INSERT INTO cliente VALUES(1, 'cliente 1', 30);
INSERT INTO cliente VALUES(2, 'cliente 2', 13);
INSERT INTO cliente VALUES(3, 'cliente 3', 23);
INSERT INTO cliente VALUES(4, 'cliente 4', 33);
INSERT INTO cliente VALUES(5, 'cliente 5', 15);

INSERT INTO camion VALUES(1,'chofer camion 1');
INSERT INTO camion VALUES(2,'chofer camion 2');
INSERT INTO camion VALUES(3,'chofer camion 3');
INSERT INTO camion VALUES(4,'chofer camion 4');

INSERT INTO ciudad VALUES(44600, 'ALCAÑIZ',1250001);
INSERT INTO ciudad VALUES(44000, 'TERUEL',6000);
INSERT INTO ciudad VALUES(44580, 'VALDERROBRES',1200);
INSERT INTO ciudad VALUES(58000, 'LA CORUÑA',3250001);

INSERT INTO embarque VALUES (1,1,4,44600,'19.80');
INSERT INTO embarque VALUES (2,2,2,44000,'29.80');
INSERT INTO embarque VALUES (3,3,3,44000,'139.80');
INSERT INTO embarque VALUES (4,4,4,44600,'97.80');
INSERT INTO embarque VALUES (5,5,2,44000,'69.80');
INSERT INTO embarque VALUES (6,5,4,44000,'429.80');
INSERT INTO embarque VALUES (7,3,2,44600,'96.80');
INSERT INTO embarque VALUES (8,3,4,44580,'98.80');
INSERT INTO embarque VALUES (9,3,3,44580,'119.80');
INSERT INTO embarque VALUES (10,1,1,44580,'29.80');
INSERT INTO embarque VALUES (11,5,1,44580,'129.80');
INSERT INTO embarque VALUES (12,5,2,58000,'69.80');
INSERT INTO embarque VALUES (13,5,4,58000,'459.80');
INSERT INTO embarque VALUES (14,3,2,58000,'96.80');
INSERT INTO embarque VALUES (15,5,2,44000,'69.80');
INSERT INTO embarque VALUES (16,5,4,44000,'429.80');
INSERT INTO embarque VALUES (17,3,2,44000,'96.80');
INSERT INTO embarque VALUES (18,3,4,44580,'98.80');
INSERT INTO embarque VALUES (19,3,3,44580,'119.80');
INSERT INTO embarque VALUES (20,5,1,44580,'29.80');
INSERT INTO embarque VALUES (21,4,1,44580,'129.80');
INSERT INTO embarque VALUES (22,3,2,58000,'69.80');
INSERT INTO embarque VALUES (23,4,4,44000,'459.80');
INSERT INTO embarque VALUES (24,1,2,58000,'96.80');
INSERT INTO embarque VALUES (25,2,2,44000,'69.80');
INSERT INTO embarque VALUES (26,3,4,44000,'429.80');
INSERT INTO embarque VALUES (27,4,2,44600,'96.80');
INSERT INTO embarque VALUES (28,5,4,44000,'98.80');
INSERT INTO embarque VALUES (29,3,3,44000,'119.80');

/* SOLUCION DE QUERYS */
/*1*/
create view ejercicio1 as
select distinct nomb_cli from cliente, embarque, ciudad 
where cli_id=emb_id_cli and emb_destino=ciu_id and ciu_nombre='LA CORUÑA';

/*2*/
create view ejercicio2 as
select distinct cam_nombre_chofer from cliente, embarque, camion, ciudad 
where renta_anual>20 and poblacion>1000000 and cli_id=emb_id_cli and cam_id=emb_id_cam and ciu_id=emb_destino;

/*3*/
create view ejercicio3 as
select distinct nomb_cli, renta_anual from cliente 
where cli_id in (select emb_id_cli from embarque where emb_peso>100);

/*4*/

/*5*/
create view ejercicio5_1 as
select nomb_cli from cliente 
where 1 in(select count(distinct emb_destino) from embarque where emb_id_cli=cli_id);

create view ejercicio5_2 as
select nomb_cli from cliente, embarque where emb_id_cli=cli_id
group by cli_id, nomb_cli having count(distinct emb_destino)=1;

/*6*/
create view ejercicio6 as
select emb_destino, avg(emb_peso) from embarque group by emb_destino having count(*)>10;

USE ejercicio_embarques;
select * from ejercicio1;
select * from ejercicio2;
select * from ejercicio3;
select * from ejercicio5_1;
select * from ejercicio5_2;
select * from ejercicio6;













