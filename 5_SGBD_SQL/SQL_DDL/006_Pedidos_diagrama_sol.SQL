/**************** OPCION 1 - ESTRUCTURA Y RESTRICCIONES **************/
CREATE SCHEMA DDL;
USE DDL;

DROP TABLE provincias;
DROP TABLE clientes;
DROP TABLE pedidos;
DROP TABLE productos;
DROP TABLE pedidos_detalle;
DROP TABLE categorias;
DROP TABLE fotos;
DROP TABLE videos;

CREATE TABLE provincias (
	cod_provincia integer,
	nomber varchar(100)
);
CREATE TABLE clientes(
	cod_cliente integer,
	cod_provincia integer,
	nombre varchar(100),
	apellidos varchar (300),
	cif varchar(12),
	direccion varchar(300),
	cp varchar(5),
	poblacion varchar(300),
	email varchar(300),
	telefono varchar(30),
	activado tinyint
);
CREATE TABLE pedidos(
	cod_pedido int,
	cod_cliente int,
	fecha datetime,
	pagado tinyint,
	servidor tinyint,
	portes float(8,2)
);
CREATE TABLE productos(
	cod_producto int,
	cod_categoria int,
	alta datetime,
	nombre varchar(100),
	descripcion varchar(500),
	precio float(10,2),
	activado tinyint,
	peso float(6,2),
	iva float(6,2)
);
CREATE TABLE pedidos_detalle(
	cod_detalle int,
	cod_pedido int,
	cod_producto int,
	unidades int,
	precio float(12,2),
	iva int
);
CREATE TABLE categorias(
	cod_categoria int,
	nombre varchar(100),
	descripcion varchar(500),
	activado tinyint
);
CREATE TABLE fotos(
	cod_foto int,
	fecha datetime,
	imagen varchar(300),
	titulo varchar(300),
	cod_producto int
);
CREATE TABLE videos(
	cod_video int,
	fecha datetime,
	video varchar(300),
	titulo varchar(300),
	cod_producto int
);

 Alter table provincias add CONSTRAINT pk_provincias PRIMARY Key (cod_provincia);
 
 Alter table clientes add CONSTRAINT pk_clientes PRIMARY Key (cod_cliente),
 add CONSTRAINT fk_cliprov FOREIGN KEY (cod_provincia) REFERENCES provincias(cod_provincia);
 
 Alter table pedidos add CONSTRAINT pk_pedidos PRIMARY Key (cod_pedido),
 add CONSTRAINT fk_cliente FOREIGN KEY (cod_cliente) REFERENCES clientes(cod_cliente);
 
 Alter table categorias add CONSTRAINT pk_categorias PRIMARY Key (cod_categoria);
 
 Alter table productos add CONSTRAINT pk_productos PRIMARY Key (cod_producto),
 add CONSTRAINT fk_categoria FOREIGN KEY (cod_categoria) REFERENCES categorias(cod_categoria);
 
 Alter table pedidos_detalle add CONSTRAINT pk_pedidos_det PRIMARY Key (cod_detalle),
 add CONSTRAINT fk_pedidos FOREIGN KEY (cod_pedido) REFERENCES pedidos(cod_pedido),
 add CONSTRAINT fk_productos FOREIGN KEY (cod_producto) REFERENCES productos(cod_producto);
  
 Alter table fotos add CONSTRAINT pk_fotos PRIMARY Key (cod_foto),
 add CONSTRAINT fk_productos1 FOREIGN KEY (cod_producto) REFERENCES productos(cod_producto);
 
 Alter table videos add CONSTRAINT pk_videos PRIMARY Key (cod_video),
 add CONSTRAINT fk_productos2 FOREIGN KEY (cod_producto) REFERENCES productos(cod_producto);


/**************** OPCION 2 - ESTRUCTURA CON RESTRICCIONES **************/
DROP TABLE provincias;
DROP TABLE clientes;
DROP TABLE pedidos;
DROP TABLE productos;
DROP TABLE pedidos_detalle;
DROP TABLE categorias;
DROP TABLE fotos;
DROP TABLE videos;

CREATE TABLE provincias (
	cod_provincia integer,
	nomber varchar(100),
	CONSTRAINT pk_provincias PRIMARY Key (cod_provincia)
);
CREATE TABLE clientes(
	cod_cliente integer,
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
	CONSTRAINT pk_clientes PRIMARY Key (cod_cliente),
	CONSTRAINT fk_cliprov FOREIGN Key (cod_provincia) references provincias(cod_provincia)
);
CREATE TABLE pedidos(
	cod_pedido int,
	cod_cliente int,
	fecha datetime,
	pagado tinyint,
	servidor tinyint,
	portes float(8,2),
	CONSTRAINT pk_pedidos PRIMARY Key (cod_pedido),
	CONSTRAINT fk_cliente FOREIGN KEY (cod_cliente) REFERENCES clientes(cod_cliente)
 
);
CREATE TABLE categorias(
	cod_categoria int,
	nombre varchar(100),
	descripcion varchar(500),
	activado tinyint,
	CONSTRAINT pk_categorias PRIMARY Key (cod_categoria)
);

CREATE TABLE productos(
	cod_producto int,
	cod_categoria int,
	alta datetime,
	nombre varchar(100),
	descripcion varchar(500),
	precio float(10,2),
	activado tinyint,
	peso float(6,2),
	iva float(6,2),
	CONSTRAINT pk_productos PRIMARY Key (cod_producto),
	CONSTRAINT fk_categoria FOREIGN KEY (cod_categoria) REFERENCES categorias(cod_categoria)
);
CREATE TABLE pedidos_detalle(
	cod_detalle int,
	cod_pedido int,
	cod_producto int,
	unidades int,
	precio float(12,2),
	iva int,
	CONSTRAINT pk_pedidos_det PRIMARY Key (cod_detalle),
	CONSTRAINT fk_pedidos FOREIGN KEY (cod_pedido) REFERENCES pedidos(cod_pedido),
	CONSTRAINT fk_productos FOREIGN KEY (cod_producto) REFERENCES productos(cod_producto)	
);

CREATE TABLE fotos(
	cod_foto int,
	fecha datetime,
	imagen varchar(300),
	titulo varchar(300),
	cod_producto int,
	CONSTRAINT pk_fotos PRIMARY Key (cod_foto),
	CONSTRAINT fk_productos1 FOREIGN KEY (cod_producto) REFERENCES productos(cod_producto)
);
CREATE TABLE videos(
	cod_video int,
	fecha datetime,
	video varchar(300),
	titulo varchar(300),
	cod_producto int,
	CONSTRAINT pk_videos PRIMARY Key (cod_video),
	CONSTRAINT fk_productos2 FOREIGN KEY (cod_producto) REFERENCES productos(cod_producto)
);

/**************** OPCION 3 - ESTRUCTURA CON RESTRICCIONES **************/
DROP TABLE provincias;
DROP TABLE clientes;
DROP TABLE pedidos;
DROP TABLE productos;
DROP TABLE pedidos_detalle;
DROP TABLE categorias;
DROP TABLE fotos;
DROP TABLE videos;

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


/****** SETENCIAS DCL ***/
CREATE USER 'alumno'@'%' IDENTIFIED BY 'alumno';
GRANT ALL PRIVILEGES ON DDL. * TO 'alumno'@'%';


