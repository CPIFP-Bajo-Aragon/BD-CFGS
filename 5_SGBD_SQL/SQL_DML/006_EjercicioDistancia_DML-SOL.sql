1.-  Obtener los nombres y salarios de los empleados que cobran más de 985 euros y tienen una 
comisión es superior al 5% de su salario.
select nombre,ape1,salario from empleado where salario > 985 and comision > salario * 0.05;

2.- Obtener el código de empleado, código de departamento, nombre y sueldo total en pesetas de 
aquellos empleados cuyo sueldo total (salario más comisión) supera los 1800 euros. 
Presentarlos ordenados por código de departamento y dentro de éstos por orden alfabético.
select coddpto,codemple,nombre,ape1,(salario+nvl(comision,0))*166.386
from empleado where salario+nvl(comision,0)>1350
order by coddpto,nombre,ape1;

3.-  Obtener un listado con los nombres, y apellidos de los empleados y sus años de antigüedad en la empresa, ordenado por años de antigüedad siendo los que más años llevan los primeros que deban aparecer.
SELECT nombre,ape1,ape2, (sysdate-fechaingreso)/365.20 as "Antigüedad" from empleado 
order by 4 desc;

4.- Obtener el nombre de los empleados que trabajan en un departamento con presupuesto superior a 50.000 euros pero menor de 60000 euros. Hay que usar predicado cuantificado
select ape1,nombre from empleado where coddpto= some(select coddpto from dpto 
where presupuesto>50000 and presupuesto<60000);

5.- Obtener en orden alfabético los nombres de empleado cuyo salario es inferior al mínimo de los empleados del departamento 1.
select nombre,ape1,salario from empleado
where salario < (select min(salario) from empleado where coddpto=1)

6.- Obtener los nombre de empleados que trabajan en el departamento del cuál es jefe el empleado con código 1.
select nombre,ape1 from empleado where coddpto = some (select coddpto from dpto 
where codemplejefe=1)

7.- Obtener los nombres de los empleados cuyo primer apellido empiece por las letras p, q, r, s.
select nombre,ape1 from empleado where substr(ape1,1,1) between 'P' and 'S';

8.- Obtener los nombres de los empleados que viven en ciudades en las que hay algún centro de trabajo
select ape1, nombre from empleado 
where upper(localidad) in (select upper(localidad) from centro);

9.- Obtener en orden alfabético los salarios y nombres de los empleados cuyo salario sea superior al 60% del máximo salario de la empresa.
select salario,nombre from empleado where salario >(select max(salario) * 0.6 from empleado) order by nombre;

10.-  Obtener el nombre y apellidos del empleado que más salario cobra
select nombre,ape1,ape2, salario from empleado 
where salario=(select MAX(salario) from empleado)

11.- Obtener las localidades y número de empleados de aquellas en las que viven más de 3 empleados
select localidad,count(*) from empleado group by localidad having count(*) > 3 order by 2;