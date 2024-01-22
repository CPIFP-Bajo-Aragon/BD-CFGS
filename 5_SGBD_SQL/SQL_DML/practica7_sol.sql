1. select nombre from trabajador where tarifa between 10 and 12;

2. select oficio from trabajador where id_t in (select id_t from asignacion where id_e = 435);

3. select t.nombre as trabajador, (select nombre from trabajador where id_t = t.id_supv) as supervisor from trabajador t;

4. select nombre from trabajador 
	where id_t in (select distinct id_t from asignacion where id_e in (select id_e from edificio where tipo='Oficina')) order by nombre;

5. select t.nombre from trabajador t where t.tarifa > (select t2.tarifa from trabajador t2 where t2.id_t = t.id_supv);

6. select a.num_dias from asignacion a where a.id_e = 435 and a.id_t in (select t.id_t from trabajador t where t.oficio = 'Fontanero');

7. select count(distinct oficio) as oficios from trabajador;

8. select t.id_supv, max(t.tarifa) as tarifa from trabajador t where t.id_t <> t.id_supv group by 1;

9. select t.id_supv, max(t.tarifa) as tarifa from trabajador t group by 1 having count(*) > 1;

10. select ed.tipo, avg(ed.nivel_calidad) from edificio ed where ed.categoria = 1 and ed.nivel_calidad < 3 group by tipo;

11. select t.nombre from trabajador t where t.tarifa < (select avg(t1.tarifa) from trabajador t1);

12. select t.nombre from trabajador t where t.tarifa < (select avg(t1.tarifa) from trabajador t1 where t1.oficio = t.oficio) ;

13. select t.nombre from trabajador t where t.tarifa < (select avg(tarifa) from trabajador where id_supv = t.id_supv);

14. select t.nombre, a.fecha_inicio from trabajador t, asignacion a where t.oficio = 'Electricista' and a.id_t = t.id_t and a.id_e = 435;

15. select nombre from trabajador t, trabajador s where s.id_t=id_supv and tarifa >= 12;

16. select id_t,nombre,oficio,id_supv from trabajador;

17. select t.nombre, e.dir, a.fecha_inicio from trabajador t, asignacion a, edificio e 
	where t.oficio = 'electricista' and a.id_t = t.id_t and e.id_e = a.id_e;
	
18. select id_e, tipo, nivel_calidad from edificio where nivel_calidad = 2;

19. update trabajador set tarifa=tarifa*1.05 where id_supv = 1311;