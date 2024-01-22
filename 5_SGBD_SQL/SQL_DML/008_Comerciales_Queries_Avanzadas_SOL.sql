2.1 Consultas multitabla (Composición interna)
    Devuelve un listado con el identificador, nombre y los apellidos de todos los clientes que han realizado algún pedido. El listado debe estar ordenado alfabéticamente y se deben eliminar los elementos repetidos.
    Devuelve un listado que muestre todos los pedidos que ha realizado cada cliente. El resultado debe mostrar todos los datos de los pedidos y del cliente. El listado debe mostrar los datos de los clientes ordenados alfabéticamente.
    Devuelve un listado que muestre todos los pedidos en los que ha participado un comercial. El resultado debe mostrar todos los datos de los pedidos y de los comerciales. El listado debe mostrar los datos de los comerciales ordenados alfabéticamente.
    Devuelve un listado que muestre todos los clientes, con todos los pedidos que han realizado y con los datos de los comerciales asociados a cada pedido.
    Devuelve un listado de todos los clientes que realizaron un pedido durante el año 2017, cuya cantidad esté entre 300 € y 1000 €.
    Devuelve el nombre y los apellidos de todos los comerciales que ha participado en algún pedido realizado por María Santana Moreno.
    Devuelve el nombre de todos los clientes que han realizado algún pedido con el comercial Daniel Sáez Vega.

2.2 Consultas multitabla (Composición externa - LEFT JOIN y RIGHT JOIN).
    Devuelve un listado con todos los clientes junto con los datos de los pedidos que han realizado. Este listado también debe incluir los clientes que no han realizado ningún pedido. El listado debe estar ordenado alfabéticamente por el primer apellido, segundo apellido y nombre de los clientes.
    Devuelve un listado con todos los comerciales junto con los datos de los pedidos que han realizado. Este listado también debe incluir los comerciales que no han realizado ningún pedido. El listado debe estar ordenado alfabéticamente por el primer apellido, segundo apellido y nombre de los comerciales.
    Devuelve un listado que solamente muestre los clientes que no han realizado ningún pedido.
    Devuelve un listado que solamente muestre los comerciales que no han realizado ningún pedido.
    Devuelve un listado con los clientes que no han realizado ningún pedido y de los comerciales que no han participado en ningún pedido. Ordene el listado alfabéticamente por los apellidos y el nombre. En en listado deberá diferenciar de algún modo los clientes y los comerciales.
    ¿Se podrían realizar las consultas anteriores con NATURAL LEFT JOIN o NATURAL RIGHT JOIN? Justifique su respuesta.

create view dosdosuno as
select c.* from cliente c left join pedido p on c.id=p.id_cliente 
order by apellido1, apellido2, nombre;

create view dosdosdos as
select c.* from comercial c left join pedido p on c.id=p.id_comercial 
order by apellido1, apellido2, nombre;

create view dosdostres as
select c.* from cliente c left join pedido p on c.id=p.id_cliente 
where p.id is null;

create view dosdoscuatro as
select c.* from comercial c left join pedido p on c.id=p.id_comercial 
where p.id is null;

create view dosdoscinco as
select co.nombre, co.apellido1, co.apellido2, 'comercial' as tipo
from (comercial co left join pedido pe on co.id=pe.id_comercial) 
where pe.id is null
union 
select cl.nombre, cl.apellido1, cl.apellido2, 'cliente' as tipo
from (cliente cl left join pedido pe on cl.id=pe.id_cliente) 
where pe.id is null;


2.3 Consultas resumen
/* Calcula la cantidad total que suman todos los pedidos que aparecen en la tabla pedido.*/
create view dostresuno as
select sum(total) as valor_total from pedido;

/* Calcula la cantidad media de todos los pedidos que aparecen en la tabla pedido.*/
create view dostresdos as
select avg(total) as valor_medio from pedido;

/* Calcula el número total de comerciales distintos que aparecen en la tabla pedido.*/
create view dostrestres as
select count(distinct id_comercial) as total_comerciales from pedido;

/* Calcula el número total de clientes que aparecen en la tabla cliente.*/
create view dostrescuatro as
select count(id) as total_clientes from cliente;

/* Calcula cuál es la mayor cantidad que aparece en la tabla pedido.*/
create view dostrescinco as
select max(cantidad) as cantidad_max from pedido;

/* Calcula cuál es la menor cantidad que aparece en la tabla pedido.*/
create view dostresseis as
select min(cantidad) as cantidad_min from pedido;

/* Calcula cuál es el valor máximo de categoría para cada una de las ciudades que aparece en la tabla cliente.*/
create view dostressiete as
select ciudad, max(categoria) as categoria_max from cliente;

/* Calcula cuál es el máximo valor de los pedidos realizados durante el mismo día para cada uno de los clientes.
Es decir, el mismo cliente puede haber realizado varios pedidos de diferentes cantidades el mismo día. Se pide que 
se calcule cuál es el pedido de máximo valor para cada uno de los días en los que un cliente ha realizado un pedido. 
Muestra el identificador del cliente, nombre, apellidos, la fecha y el valor de la cantidad.*/
create view dostresocho as
select c.id, nombre, apellido1, apellido2, fecha, max(total)
from cliente c inner join pedido p where p.id_cliente=c.id
group by id, nombre, apellido1, apellido2, fecha
order by p.fecha desc, c.id;

/* Calcula cuál es el máximo valor de los pedidos realizados durante el mismo día para cada uno de los clientes, 
teniendo en cuenta que sólo queremos mostrar aquellos pedidos que superen la cantidad de 2000 €.*/
create view dostresnueve as
select c.id, nombre, apellido1, apellido2, fecha, MAX(p.total)
from cliente c inner join pedido p where p.id_cliente=c.id
group by id, nombre, apellido1, apellido2, fecha
having MAX(p.total) > 2000 order by fecha desc;
	 

/* Calcula el máximo valor de los pedidos realizados para cada uno de los comerciales durante la fecha 2016-08-17. 
Muestra el identificador del comercial, nombre, apellidos y total.*/
create view dostresdiez as
select c.id, c.nombre, c.apellido1, MAX(total) 
from pedido p RIGHT JOIN comercial c ON p.id_comercial = c.id 
where fecha = '2016-08-17' 
GROUP BY c.id;

/* Devuelve un listado con el identificador de cliente, nombre y apellidos y el número total de pedidos que ha realizado 
cada uno de clientes. Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido. Estos clientes 
también deben aparecer en el listado indicando que el número de pedidos realizados es 0.*/
create view dostresonce as
select c.id, nombre, apellido1, apellido2, count(p.id) as total_pedidos
from cliente c left join pedido p on p.id_cliente=c.id
group by c.id, nombre, apellido1, apellido2 ;

/* Devuelve un listado con el identificador de cliente, nombre y apellidos y el número total de pedidos que ha 
realizado cada uno de clientes durante el año 2017.*/
create view dostresdoce as
select c.id, c.nombre, c.apellido1, c.apellido2, count(p.id) as total_pedidos
from cliente c left join pedido p on p.id_cliente=c.id
where year(p.fecha)='2017'
group by c.id, c.nombre, c.apellido1, c.apellido2 ;

/* Devuelve un listado que muestre el identificador de cliente, nombre, primer apellido y el 
valor de la máxima cantidad del pedido realizado por cada uno de los clientes. El resultado debe mostrar 
aquellos clientes que no han realizado ningún pedido indicando que la máxima cantidad de sus pedidos realizados 
es 0. Puede hacer uso de la función IFNULL.*/
create view dostrestrece as
select c.id, c.nombre, c.apellido1, IFNULL(MAX(pedido.total),0) as cantidad_max
from cliente c left join pedido p on p.id_cliente=c.id
group by c.id, c.nombre, c.apellido1;

/* Devuelve cuál ha sido el pedido de máximo valor que se ha realizado cada año.*/
create view dostrescatorce as
select year(fecha), MAX(total) 
from pedido 
GROUP BY YEAR(fecha) ;

/* Devuelve el número total de pedidos que se han realizado cada año. */
create view dostresquince as
select year(fecha) as anyo, count(id) as total_pedidos from pedido 
group by anyo
order by anyo desc;

