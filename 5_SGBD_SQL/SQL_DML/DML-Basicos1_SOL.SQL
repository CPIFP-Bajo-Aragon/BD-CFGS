SOLUCION CONSULTAS EJERCICIO 1

1. select apellido, oficio, dept_no from emple;
2. select dept_no, dnombre, loc from depart;
3. select * from emple;
4. select * from emple order by apellido;
5. select * from emple order by dept_no desc;
6. select * from emple order by dept_no desc, apellido;
8. select * from emple where salario>2000000;
9. select * from emple where oficio='ANALISTA';
10. select apellido, oficio from emple where dept_no=20;
11. select * from emple order by apellido;
12.select * from emple where oficio='VENDEDOR' order by apellido.
13. select * from emple where dept_no=10 and oficio='ANALISTA'.
14. select * from emple where salario>200000 or dept_no=20;
15. select * from emple order by oficio, apellido.
16. select * from emple where apellido like 'A*';
17. select * from emple where apellido like '*Z';
18. select * from emple where apellido like 'A*' and oficio like '*E*';
19. select * from emple where salario between 100000 and 200000;
20. select * from emple where oficio='VENDEDOR' and comision>100000;
21. select * from emple order by dept_no, apellido;
22. select emp_no, apellido from emple where apellido like 'Z*' and salario>300000;
23. select * from emple where loc like 'B*';
24. select * from emple where oficio='EMPLEADO' and salario>100000 and dept_no=10;
25. select apellido from emple where comision is null;
26. select apellido from emple where comision is null and apellido like 'J*';
27. select apellido from emple where oficio in ('VENDEDOR','ANALISTA','EMPLEADO');
28. select apellido from emple where oficion not in ('ANALISTA','EMPLEADO') and salario>200000;
29. select * from emple where salario between 200000 and 300000;
30. select apellido, salario, dept_no from emple where salario>200000 and (dept_no=10 or dept_no=30);
31. select apellido, emp_no from emple where salario not between 100000 and 200000;
32. select lower(apellido) from emple;
33. select concat(apellido,oficio) from emple;
34. select apellido,length(apellido) from emple order by length(apellido) desc;
35. select year(fecha_alt) from emple;
36. select * from emple where year(fecha_alt)=1992;
37. select * from emple where monthname(fecha_alt)='February';
38. select apellido,greatest(apellido,salario) from emple;
39. select apellido from emple where apellido like 'A*' and year(fecha_alt)=1990;
40. select * from emple where dept_no=10 and comision is null;