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


/****************** SOLUCION CONSULTAS *********************/
Ejercicio 1
	SELECT AVG(cuota) AS cuota_media, AVG(ventas) AS ventas_media FROM empleados

Ejercicio 2
	SELECT AVG(importe) AS importe_medio, SUM(importe) AS importe_total, 
	AVG(importe/cant) AS precio_venta_medio  FROM pedidos

Ejercicio 3
	SELECT AVG(precio) AS p_medio_ACI FROM productos WHERE idfab = 'ACI'

Ejercicio 4
	SELECT SUM(importe) AS total_pedidos_V_Pantalla 
	FROM empleados INNER JOIN pedidos ON empleados.numemp = pedidos.rep
	WHERE nombre = 'Vicente Pantalla'

Ejercicio 5
	SELECT MIN(fechapedido) AS primer_pedido FROM pedidos 

Ejercicio 6
	SELECT COUNT(*) AS cuantos_pedidos_mayores  FROM pedidos WHERE importe > 25000

 
Ejercicio 7
	SELECT oficina, COUNT(*) AS cuantos_empleados FROM empleados  GROUP BY oficina

Solución 2
	SELECT oficinas.oficina, COUNT(numemp) AS cuantos_empleados
	FROM empleados RIGHT JOIN oficinas ON empleados.oficina = oficinas.oficina
	GROUP BY oficinas.oficina


Ejercicio 8
	SELECT numemp, nombre, clie AS cliente, SUM(importe) AS total_vendido 
	FROM empleados INNER JOIN pedidos ON pedidos.rep = empleados.numemp
	GROUP BY numemp, nombre, clie

Solución 2
	SELECT numemp, nombre, clie AS cliente, SUM(importe) AS total_vendido 
	FROM empleados LEFT JOIN pedidos ON pedidos.rep = empleados.numemp
	GROUP BY numemp, nombre, clie

Ejercicio 9
	SELECT rep, AVG(importe) AS importe_medio FROM pedidos 
	GROUP BY rep HAVING SUM(importe) > 30000


Ejercicio 10
	SELECT descripcion, precio, SUM(cantidad) AS total_pedido
	FROM productos LEFT JOIN pedidos ON pedidos.fab = productos.idfab AND pedidos.producto = productos.idproducto
	GROUP BY idfab, idproducto, descripcion, precio
	HAVING SUM(cantidad)>existencias*0.75 
	ORDER BY 3

Ejercicio 11
	SELECT COUNT(DISTINCT OFICINA) FROM EMPLEADOS WHERE VENTAS>COUTA
	 
Solución 2
	SELECT COUNT(*) AS cuantas_oficinas 
	FROM (SELECT DISTINCT oficina FROM empleados WHERE ventas > cuota) TEMP
 
 
/* OBTENER EL NUMERO DE PRODUCTOS CON EXISTENCIA MAYOR QUE 50, QUE SE HAN VENDIDO EN 
CADA CIUDAD EN LA QUE LA EMPRESA TIENE EMPLEADOS*/

SELECT O.CIUDAD, COUNT(DISTINCT pr.idproducto) AS TOTAL_PROD, 
FROM OFICINAS O JOIN 
	(EMPLEADOS E JOIN 
		(PEDIDOS P JOIN PRODUCTOS PR on PR.idproducto=p.idproducto and pr.idfab=p.idfab)
		ON P.REP=E.NUMEMP)
	ON O.OFICINA=E.OFICINA
WHERE PR.EXISTENCIA>50
GROUP BY O.CIUDAD 
ORDER BY O.CIUDAD ASC;