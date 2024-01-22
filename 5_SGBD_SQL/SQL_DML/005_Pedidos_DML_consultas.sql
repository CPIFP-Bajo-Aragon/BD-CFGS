create schema pract10;
use pract10;

create table clientes(
	numclie int primary key,
	nombre varchar(20) not null,
	repclie varchar (20) not null,
	limitecredito float	
);

create table oficinas(
	oficina int primary key,
	ciudad varchar(20), 
	region varchar(20),
	dir varchar(20),
	objetivo varchar(20),
	ventas float
);

create table empleados(
	numemp int primary key,
	nombre varchar(20),
	edad int,
	oficina int,
	titulo varchar(15), 
	contrato varchar(20),
	jefe int not null,
	cuota float, 
	ventas float,
	constraint fk_oficinas foreign key (oficina) references oficinas(oficina)
);

create table productos(
	fab int not null,
	producto int not null,
	descripcion varchar(20),
	precio float not null,
	existencias int not null,
	constraint pk_productos primary key (fab,producto)
);

create table pedidos(
	numpedido int primary key,
	fechapedido date,
	clie int not null,
	rep int not null,
	fab int not null,
	producto int not null,
	cant int not null,
	importe float not null,
	constraint fk_clientes foreign key (clie) references clientes(numclie),
	constraint fk_empleado foreign key (rep) references empleados(numemp),
	constraint fk_productos foreign key (fab,producto) references productos(fab, producto)
);
/******************  CONSULTAS A RESOLVER *********************/
1 ¿Cuál es la cuota media y las ventas medias de todos los empleados?
2 Hallar el importe medio de pedidos, el importe total de pedidos y el precio medio de venta (el precio de venta es el precio unitario en cada pedido).
3 Hallar el precio medio de los productos del fabricante ACI.
4 ¿Cuál es el importe total de los pedidos realizados por el empleado Vicente Pantalla?
5 Hallar en qué fecha se realizó el primer pedido (suponiendo que en la tabla de pedidos tenemos todos los pedidos realizados hasta la fecha).
6 Hallar cuántos pedidos hay de más de 25000 euros.
7 Listar cuántos empleados están asignados a cada oficina, indicar el número de oficina y cuántos hay asignados.
8 Para cada empleado, obtener su número, nombre, e importe vendido por ese empleado a cada cliente indicando el número de cliente.
9 Para cada empleado cuyos pedidos suman más de 30.000 euros, hallar su importe medio de pedidos. En el resultado indicar el número de empleado y su importe medio
de pedidos.
10 Listar de cada producto, su descripción, precio y cantidad total pedida, incluyendo sólo los productos cuya cantidad total pedida sea superior al 75% del stock, y ordenado
por cantidad total pedida.
11 Saber cuántas oficinas tienen empleados con ventas superiores a su cuota, no queremos saber cuales sino cuántas hay.
