 Estas son las consultas que debes resolver:
1.	Código y nombre de todos los departamentos.
create or replace view uno as select codigo, nombre from departamentos;
2.	Mes y ejercicio de los justificantes de nómina pertenecientes al empleado cuyo código es 1.
create or replace view dos as select mes, ejercicio from just_nominas where cod_emp=1;
3.	Número de cuenta y nombre de los empleados cuya retención es mayor o igual que 10.
create or replace view tres as select nombre, cuenta from empleados where retencion >=10;
4.	Código y nombre de los empleados ordenados ascendentemente por nombre.
create or replace view cuatro as select codigo, nombre from empleados order by nombre asc;
5.	Nombre de los empleados que tienen más de 2 hijos.
create or replace view cinco as select nombre from empleados where hijos>2;
6.	Código y número de cuenta de los empleados cuyo nombre empieze por 'A' o por 'J'.
create or replace view seis as select codigo, cuenta from empleados where upper(nombre) like 'A%' or  upper(nombre) like 'J%';
7.	Número de empleados que hay en la base de datos.
create or replace view siete as select count(codigo) as total_empleados from empleados;
8.	Nombre del primer y último empleado en términos alfabéticos.
create or replace view ocho as
 (select nombre from empleados order by nombre asc limit 0,1)
 union 
 (select nombre from empleados order by nombre desc limit 0,1);

9.	Nombre y número de hijos de los empleados cuya retención es: 8, 10 o 12.
create or replace view nueve as select nombre, hijos from empleados where retencion in (8,10,12) order by nombre;
10.	Número de hijos y número de empleados agrupados por hijos, mostrando sólo los grupos cuyo número de empleados sea mayor que 1.
create or replace view diez as select hijos, count(codigo) total_empleados 
from empleados group by hijos having count(codigo)>1;

11.	Número de hijos, retención máxima, mínima y media de los empleados agrupados por hijos.
12.	Nombre y función de los empleados que han trabajado en el departamento 1.
13.	Nombre del empleado, nombre del departamento y función que han realizado de los empleados que tienen 1 hijo.
14.	Nombre del empleado y nombre del departamento en el que han trabajado empleados que no tienen hijos.
15.	Nombre del empleado, mes y ejercicio de sus justificantes de nómina, número de línea y cantidad de las líneas de los justificantes para el empleado cuyo código=1.
16.	Nombre del empleado, mes y ejercicio de sus justificantes de nómina para los empleados que han trabajado en el departamento de Ventas.
17.	Nombre del empleado e ingresos totales percibidos agrupados por nombre.
18.	Nombre de los empleados que han ganado más de 2000 € en el año 2006.
19.	Número de empleados cuyo número de hijos es superior a la media de hijos de los empleados.
20.	Nombre de los empleados que más hijos tienen o que menos hijos tienen.
21.	Nombre de los empleados que no tienen justificante de nóminas.
22.	Nombre y fecha de nacimiento de todos los empleados.
23.	Nombre y fecha de nacimiento con formato "1 de Enero de 2000" y etiquetada la columna como fecha, de todos los empleados.
24.	Nombre de los empleados, nombre de los departamentos en los que ha trabajado y función en mayúsculas que ha realizado en cada departamento.
25.	Nombre, fecha de nacimiento y nombre del día de la semana de su fecha de nacimiento de todos los empleados.
26.	Nombre y edad de los empleados.
27.	Nombre, edad y número de hijos de los empleados que tienen menos de 40 años y tienen hijos.
28.	Nombre, edad de los empleados y nombre del departamento de los empleados que han trabajado en más de un departamento.
29.	Nombre, edad y número de cuenta de aquellos empleados cuya edad es múltiplo de 3.
30.	Nombre e ingresos percibidos empleado más joven y del más longevo.
