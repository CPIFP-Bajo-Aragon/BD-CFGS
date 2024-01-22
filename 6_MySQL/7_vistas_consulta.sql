drop view log_fechas ;

create view log_fechas as 
select year(fecha) as año, month(fecha) as mes, count(id) as total from log_usuarios group by year(fecha), month(fecha);

select * from log_fechas;