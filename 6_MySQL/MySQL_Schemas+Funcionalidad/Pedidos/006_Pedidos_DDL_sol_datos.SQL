/**************** OPCION 1 - SENTENCIA INSERT LLENADO TABLAS **************/
create schema pedidos;
use pedidos;

DROP TABLE if exists provincias;
DROP TABLE if exists clientes;
DROP TABLE if exists pedidos;
DROP TABLE if exists productos;
DROP TABLE if exists pedidos_detalle;
DROP TABLE if exists categorias;
DROP TABLE if exists fotos;
DROP TABLE if exists videos;

CREATE TABLE provincias (
	cod_provincia integer PRIMARY Key,
	nomber varchar(100) 
);
CREATE TABLE clientes(
	cod_cliente integer PRIMARY Key,
	cod_provincia integer,
	nombre varchar(100),
	apellidos varchar (300),
	cif varchar(12),
	direccion varchar(300),
	cp varchar(5),
	poblacion varchar(300),
	email varchar(300),
	telefono varchar(30),
	activado tinyint,
	CONSTRAINT fk_cliprov FOREIGN KEY (cod_provincia) REFERENCES provincias(cod_provincia);
);
CREATE TABLE pedidos(
	cod_pedido int PRIMARY Key,
	cod_cliente int,
	fecha datetime,
	pagado tinyint,
	servidor tinyint,
	portes float(8,2),
	CONSTRAINT fk_cliente FOREIGN KEY (cod_cliente) REFERENCES clientes(cod_cliente)
);
CREATE TABLE categorias(
	cod_categoria int PRIMARY Key,
	nombre varchar(100),
	descripcion varchar(500),
	activado tinyint 
);
CREATE TABLE productos(
	cod_producto int PRIMARY Key,
	cod_categoria int,
	alta datetime,
	nombre varchar(100),
	descripcion varchar(500),
	precio float(10,2),
	activado tinyint,
	peso float(6,2),
	iva float(6,2),
	CONSTRAINT fk_categoria FOREIGN KEY (cod_categoria) REFERENCES categorias(cod_categoria)
);
CREATE TABLE pedidos_detalle(
	cod_detalle int PRIMARY Key,
	cod_pedido int,
	cod_producto int,
	unidades int,
	precio float(12,2),
	iva int,
	CONSTRAINT fk_pedidos FOREIGN KEY (cod_pedido) REFERENCES pedidos(cod_pedido),
	CONSTRAINT fk_productos FOREIGN KEY (cod_producto) REFERENCES productos(cod_producto)	
);

CREATE TABLE fotos(
	cod_foto int PRIMARY Key,
	fecha datetime,
	imagen varchar(300),
	titulo varchar(300),
	cod_producto int,
	CONSTRAINT fk_productos1 FOREIGN KEY (cod_producto) REFERENCES productos(cod_producto)
);
CREATE TABLE videos(
	cod_video int PRIMARY Key,
	fecha datetime,
	video varchar(300),
	titulo varchar(300),
	cod_producto int,
	CONSTRAINT fk_productos2 FOREIGN KEY (cod_producto) REFERENCES productos(cod_producto)
);

-- carga datos --

insert into provincias values (
44,'Teruel'),
(50,'Zaragoza'),
(22,'Huesca');
insert into categorias VALUES  
(1,'categoria1', 'descripcion categoria 1',1),
(2,'categoria2', 'descripcion categoria 2',1),
(3,'categoria3', 'descripcion categoria 3pedidos_detalle',1);
insert into clientes values 
(1,44,'cliente 1 nombre', 'apellidos cliente 1', '12345678z','direccion cliente 1', '44600','Alcañiz','cliente1@gmail.com','telf1',1),
(2,50,'cliente 2 nombre', 'apellidos cliente 2', '34567812z','direccion cliente 2', '50600','Alcañiz','cliente2@gmail.com','telf2',0),
(3,22,'cliente 3 nombre', 'apellidos cliente 1', '12125678z','direccion cliente 3', '22600','Alcañiz','cliente3@gmail.com','telf3',1);
insert into productos values
 (10,1,'2020-02-10','producto 1', 'descripcion del producto 1', 10.50, 1,20,21),
 (20,1,'2020-02-10','producto 2', 'descripcion del producto 2', 10.50, 1,20,21),
 (30,1,'2020-02-10','producto 3', 'descripcion del producto 3', 10.50, 1,20,21);
insert into fotos values 
(1,'2020-02-10',' foto 1 producto 1','',10),
(11,'2020-02-10',' foto 2 producto 1','',10),
(2,'2020-02-10',' foto 1 producto 2','',20),
(21,'2020-02-10',' foto 2 producto 2','',20),
(3,'2020-02-10',' foto 1 producto 3','',30);
insert into videos values 
(1,'2020-02-10',' video 1 producto 1','',10),
(11,'2020-02-10',' video 2 producto 1','',10),
(2,'2020-02-10',' video 1 producto 2','',20),
(3,'2020-02-10',' video 1 producto 3','',30),
(21,'2020-02-10',' video 2 producto 3','',20);
insert into pedidos values 
(1,1,'2020-02-10',0,1,40.65),
(2,3,'2020-02-11',0,1,25.65),
(3,3,'2020-02-16',0,1,13.65);
insert into pedidos_detalle values 
(1001,1,20,6,15,21),
(1002,1,30,8,3.45,21),
(2001,2,20,8,8.45,21),
(2002,2,30,8,14.45,21),
(2003,2,10,8,5.45,21),
(3001,3,30,8,19.45,21);

SELECT * FROM categorias;
SELECT * FROM provincias;
SELECT * FROM clientes;
SELECT * FROM fotos;
SELECT * FROM pedidos;
SELECT * FROM pedidos_detalle;
SELECT * FROM productos;
SELECT * FROM videos;