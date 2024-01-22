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

/****************** SOLUCION CONSULTAS *********************/
Ejercicio 1
	SELECT AVG(cuota) AS cuota_media, AVG(ventas) AS ventas_media 
	FROM empleados

Ejercicio 2
	SELECT AVG(importe) AS importe_medio, SUM(importe) AS importe_total, 
	AVG(importe/cant) AS precio_venta_medio  
	FROM pedidos

Ejercicio 3
	SELECT AVG(precio) AS p_medio_ACI FROM productos WHERE idfab = 'ACI'

Ejercicio 4
	SELECT SUM(importe) AS total_pedidos_V_Pantalla 
	FROM empleados INNER JOIN pedidos ON empleados.numemp = pedidos.rep
	WHERE nombre = 'Vicente Pantalla'

Ejercicio 5
	SELECT MIN(fechapedido) AS primer_pedido FROM pedidos 

Ejercicio 6
	SELECT COUNT(*) AS cuantos_pedidos_mayores FROM pedidos WHERE importe > 25000

Ejercicio 7
	SELECT oficina, COUNT(*) AS cuantos_empleados FROM empleados GROUP BY oficina

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