1. select dni from cliente;

2. select * from programa;

3. select nombre from programa;

4. select * from comercio;

5. select distinct ciudad from comercio;

6. select distinct nombre from programa;

7. select dni+4 from cliente;

8. select codigo*7 from programa;

9. select * from programa where codigo<10;

10. select * from programa where codigo=11;

11. select * from fabricante where pais='Estados Unidos';

12. select * from fabricante where pais not in('España');

13 select * from programa where nombre='Windows';

14 select ciudad from comercio where nombre='El corte inglés';

15 select * from comercio where nombre not in ('El corte inglés');

16 select codigo from programa where nombre in('Windows','Access');

17 select * from cliente where edad between 10 and 25 or edad>50;
17 select * from cliente where (edad >10 and edad<25) or edad>50;

18 select distinct nombre from comercio where ciudad in('Madrid','Sevilla');

19 select * from cliente where nombre like '%o';

20 select * from cliente where nombre like '%o' and edad>30;

21 select * from programa where version like '%i' or nombre like 'a%' or nombre like 'w%';

22 select * from programa where version like '%i' or (nombre like 'a%' and nombre like '%s');

23 select * from programa where version like '%i' and nombre not like 'a%';

24 select * from fabricante order by nombre asc;

25 select * from fabricante order by nombre desc;

26 select * from programa order by version;

27 select programa.nombre from fabricante, programa, desarrolla
where fabricante.id_fab=desarrolla.id_fab and programa.codigo=desarrolla.codigo and fabricante.nombre='Oracle';

28 select comercio.nombre 
from comercio,programa,distribuye
where comercio.cif=distribuye.cif and programa.codigo=distribuye.codigo and programa.nombre='Windows';

29 select programa.nombre,cantidad
from programa,comercio,distribuye
where programa.codigo=distribuye.codigo and comercio.cif=distribuye.cif and comercio.nombre='El corte inglés';

30 select fabricante.nombre
   from fabricante,programa,desarrolla
   where programa.codigo=desarrolla.codigo and desarrolla.id_fab=fabricante.id_fab and programa.nombre='Freddy Hardest';

31 select programa.nombre
   from programa,registra
   where programa.codigo=registra.codigo and medio='Internet';

32 select cliente.nombre
   from cliente,registra
   where cliente.dni=registra.dni and medio='Internet';

33 select medio
   from cliente,registra
   where cliente.dni=registra.dni and cliente.nombre='Pepe Pérez';

34 select cliente.nombre
   from cliente,registra
   where cliente.dni=registra.dni and medio='Internet';

35 select programa.nombre
   from programa,registra
   where programa.codigo=registra.codigo and medio='Tarjeta postal';

36 select distinct ciudad
   from comercio,distribuye,registra
   where comercio.cif=distribuye.cif and registra.cif=comercio.cif and medio='Internet';

37 select programa.nombre,cliente.nombre
   from programa,cliente,registra
   where programa.codigo=registra.codigo and cliente.dni=registra.dni and medio='Internet';

38 select cliente.nombre,programa.nombre,medio,comercio.nombre
   from programa,cliente,registra,comercio
   where programa.codigo=registra.codigo and cliente.dni=registra.dni and comercio.cif=registra.cif;

40 select cliente.nombre
   from cliente,programa,registra
   where cliente.dni=registra.dni and programa.codigo=registra.codigo and programa.nombre='Access' and version='XP';

41 select nombre
   from fabricante
   where pais=(select pais from fabricante where nombre='Oracle');

42 select *
   from cliente
   where edad=(select edad from cliente where nombre='Pepe Pérez');

43 select * from comercio
   where ciudad in (select ciudad from comercio where nombre=’FNAC’);

44 select cliente.nombre
from cliente,registra
where cliente.dni=registra.dni and medio in (select medio
from registra,cliente
where registra.dni=cliente.dni´and cliente.nombre=’Pepe Perez’);

45 select count(*) from programas;

46 select count(*) from clientes where edad>40;

47 select sum(cantidad)
   from distribuye
   where distribuye.cif =1;

48 select avg(cantidad)
   from distribuye
   where codigo=7;

49 select min(cantidad)
   from distribuye
   where codigo=7;

50 select max(cantidad)
   from distribuye
   where codigo=7;

51 select count(*)
   from comercio,distribuye
   where comercio.cif=distribuye.cif and codigo=7;

52 select count(*)
   from registra
   where medio='Internet';

53 select count(*)
   from comercio,distribuye
   where comercio.cif=distribuye.cif and ciudad='Sevilla';

54 select count(*)
   from fabricante,desarrolla
   where fabricante.id_fab=desarrolla.id_fab and pais='Estados Unidos';
