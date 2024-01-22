 /**** Consulas a realizar  **/
 
 /*Listar los datos de las peliculas ordenado por nombre de protagonista y genero. **/
 select * from peliculas order by protagonista, idgenero;
 
 /*Listar el nombre de las películas disponibles. **/ 
 select * from peliculas where estado='disponible';
 
 /* Listar el codigo de las peliculas que nunca se han alquilado **/
 select idpelicula from peliculas 
 where idpelicula not in (select distinct idpelicula from alquileres);
 
 /* listar los generos que no tienen peliculas asociadas. **/
 select idgenero from generos 
 where idgenero not in (select distinct idgenero from peliculas);
 
 /* Listar el numero de alquileres realizado por cada usuario. **/
 select usuarios_idusuario, count(*) from alquileres group by usuarios_idusuario;
 
 /* Listar el numero de clientes dados de baja. **/
 select count(*) from clientes 
 where estado<>'ACTIVO';
 
 /* Listar el numero de clientes dados de baja y que nunca han alquilado una película. **/
  select count(*) from clientes 
  where estado<>'ACTIVO' and idcliente not in (select distinct idcliente from alquileres);
  
 /* Listar los clientes que han alquilado peliculas de genero drama e infantil. **/
 select idcliente from alquileres 
 where idgenero in (select idgenero from genero where nomgenero in('drama','infantil'));
 
 /* Obtener aquellas peliculas que han recibido un Oscar. **/
 select idpelicula from peliculas 
 where upper(detalle) like '%OSCAR%';
 
 /* Listar importe medio de las peliculas alquiladas. **/
 select avg(precio) from alquileres;
 
 /* Listar importe total por peliculas alquiladas, por precio descendentemente. **/
  select sum(precio) from alquileres order by precio desc;
  
 /* Calcular el numero de peliculas y su valor medio.**/
  select count(*), avg(precio) from peliculas;
  
 /* Listar los clientes que han superado los 80€ en alquiler de peliculas. **/
 select idcliente from alquileres group by idcliente having sum(precio)>80;