1. select * from emple
   where dept_no=(select dept_no from emple where apellido='GIL');

2. select * from emple
   where oficio=(select oficio from emple where apellido='CEREZO');

3. select * from emple
   where oficio=(select oficio from emple where apellido='JIMENEZ')
  or salario>(select salario from emple where apellido='FERNANDEZ);

4. select apellido, oficio, salario
   from emple 
   where dept_no=(select oficio from emple where apellido='FERNANDEZ')
   and salario=(select salario from emple where apellido='FERNANDEZ);

5. select *
   from emple
   where salario>(select salario from emple where apellido='GIL')
   and dept_no=10;

6. select apellido, oficio, loc
   from emple, depart
   where emple.dept_no=depart.dept_no;

7. select apellido, oficio, loc 
   from emple, depart
   where oficio='ANALISTA' and emple.dept_no=depart.dept_no;

8. select apellido, oficio, salario
   from emple, depart
   where emple.dept_no=depart.dept_no and loc='Madrid';

9. select apellido, salario, loc
   from emple,depart
   where emple.dept_no=depart.dept_no and salario between 200000 and 300000;

10. select apellido, salario, dnombre
    from emple,depart
    where emple.dept_no=depart.dept_no and oficio=(select oficio from emple where apellido='GIL');

11. select apellido, salario, dnombre
    from emple,depart
    where emple.dept_no=depart.dept_no and oficio=(select oficio from emple where apellido='GIL')
    and comision is null;

12. select * from emple,depart
    where emple.dept_no=depart.dept_no
    and dnombre='Contabilidad'
    order by apellido;

13. select apellido
    from emple,depart
    where emple.dept_no=depart.dept_no and loc='Sevilla' 
    and oficio in ('analista','empleado');

14.select avg(salario) from emple;

15. select max(salario) from emple
    where dept_no=10;

16. select min(salario) from emple,depart
    where dnombre='VENTAS' and emple.dept_no=depart.dept_no;

17. select avg(salario) from emple,depart
    where emple.dept_no=depart.dept_no and dnombre='Contabilidad';

18. select *
    from emple
    where salario>(select avg(salario) from emple);

19. select count(*) from emple where dept_no=10;

20. select count(*) from emple,depart where dnombre='VENTAS';

21. select count(*) from emple where comision is null;

22. select apellido
    from emple
    where salario=(select max(salario) from emple);

23. select apellido
    from emple where salario=(select min(salario) from emple);

24. select apellido
    from emple,depart
    where emple.dept_no=depart.dept_no and dnombre='VENTAS' 
    and salario=(select max(salario) from emple,depart
    where emple.dept_no=depart.dept_no
    and dnombre='VENTAS');

25. select count(*) 
from emple where apellido like 'A*';

26. select avg(salario), count(comision), max(salario), min(salario)
    from emple
    where dept_no=30;

