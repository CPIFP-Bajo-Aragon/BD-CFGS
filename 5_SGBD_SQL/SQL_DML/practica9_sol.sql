create database grandes_almacenes;
use grandes_almacenes;

create table cajeros(
	codigo int not null,
	nomapels varchar(255),
	constraint pk_cajeros primary key(codigo)
);

create table productos(
	codigo int not null,
	nombre varchar(100) not null,
	precio int,
	constraint pk_productos primary key(codigo)
);

create table maquinas_registradoras(
	codigo int not null,
	piso int not null,
	constraint pk_maquinas primary key(codigo)
);

create table venta(
	cajero int not null,
	maquina int not null,
	producto int not null,
	constraint pk_venta primary key(cajero, maquina, producto),
	constraint fk_productos foreign key(producto) references productos(codigo),
	constraint fk_maquinas foreign key(maquina) references maquinas_registradoras(codigo),
	constraint fk_cajeros foreign key(cajero) references cajeros(codigo)
);

/**************** CUESTION 8.1 *******************/

SELECT CODIGO, NOMBRE, COUNT(V.PRODUCTO) 
FROM PRODUCTO P LEFT JOIN VENTA V ON P.CODIGO=V.PRODUCTO
GROUP BY P.CODIGO, P.NOMBRE ORDER BY COUNT(V.PRODUCTO) DESC;

/**************** CUESTION 8.2 *******************/

SELECT CAJEROS.NOMAPELS, PRODUCTOS.NOMBRE, PRODUCTOS.PRECIO, MAQUINAS_REGISTRADORES.PISO
FROM (CAJEROS C INNER JOIN 
		(PRODUCTOS P INNER JOIN 
			(MAQUINAS_REGISTRADORAS M INNER JOIN VENTA V ON V.MAQUINA=M.CODIGO) 
				ON V.PRODUCTO= P.CODIGO)
					ON V.CAJERO=C.CODIGO) 
					
/**************** CUESTION 8.3 *******************/

SELECT PISO, SUM(PRECIO)
FROM MAQUINAS_REGISTRADORAS M INNER JOIN (PRODUCTO P INNER JOIN VENTA V ON V.PRODUCTO=P.CODIGO) ON M.CODIGO=V.MAQUINA
GROUPO BY PISO;

//SOLUCION COMPLETA
select m.piso, sum(importe) as ventas_totales
from (maquinas_registradoras m left join (ventas v inner producto p on v.producto=p.codigo) on m.codigo=v.maquina)
Group by m.piso;

/**************** CUESTION 8.4 *******************/

SELECT C.CODIGO, C.NOMAPELS, SUM(P.PRECIO)
FROM CAJEROS C LEFT JOIN (PRODUCTOS P INNER JOIN VENTA V ON P.CODIGO=V.PRODUCTO) ON V.CAJERO=C.CODIGO
GROUP BY C.CODIGO, C.NOMAPELS;


/**************** CUESTION 8.5 *******************/

//OPCION 1
SELECT C.CODIGO, C.NOMAPELS FROM CAJEROS C 
WHERE CODIGO IN (
	SELECT CAJERO FROM VENTA
	WHERE MAQUINA IN (
		SELECT CODIGO FROM MAQUINAS_REGISTRADORAS
		WHERE PISO IN (
			SELECT PISO 
			FROM  MAQUINAS_REGISTRADORAS M INNER JOIN (PRODUCTOS P INNER JOIN VENTA V ON P.CODIGO=V.PRODUCTO) ON V.MAQUINA=M.CODIGO
			GROUP BY PISO
			HAVING SUM(PRECIO)<500
		)
	)
);

//OPCION 2
SELECT C.CODIGO, C.NOMAPELS 
FROM CAJEROS C, VENTA V, MAQUINAS_REGISTRADORAS M  
WHERE C.CODIGO=V.CAJERO AND V.MAQUINA=M.CODIGO 
AND PISO IN (
	SELECT PISO 
	FROM  MAQUINAS_REGISTRADORAS M INNER JOIN (PRODUCTOS P INNER JOIN VENTA V ON P.CODIGO=V.PRODUCTO) ON V.MAQUINA=M.CODIGO
	GROUP BY PISO
	HAVING SUM(PRECIO)<500
);
	
	
/**************** CUESTION 8.6 *******************/

UPDATE PRODUCTOS SET PRECIO=PRECIO*1.16 WHERE NOMBRE LIKE 'Prod%'

/**************** CUESTION 8.7 *******************/

ALTER TABLE PRODUCTOS ADD COLUMN STOCK_MINIMO INT NOT NULL DEFAULT 0;

/**************** CUESTION 8.8 *******************/

ALTER TABLE CAJEROS MODIFY COLUMN NOMAPELS VARCHAR(75) NOT NULL;

