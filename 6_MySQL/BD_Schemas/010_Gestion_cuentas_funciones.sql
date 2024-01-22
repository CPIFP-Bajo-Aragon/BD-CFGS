DELIMITER $$
DROP FUNCTION IF EXISTS SUMA_APUNTES$$
CREATE FUNCTION SUMA_APUNTES (CTA VARCHAR(20)) RETURNS float
BEGIN
	DECLARE AUX FLOAT;
    SELECT SUM(IMPORTE) INTO AUX FROM apuntes WHERE CUENTA = CTA;
    RETURN AUX;
END$$

delimiter $$
drop function if exists valor_ingresos $$
create function valor_ingresos (cta varchar(20)) returns float
begin
    declare valorIngresos float;
    select sum(IMPORTE) into valorIngresos 
	from CUENTA, APUNTES 
	where CUENTA.CUENTA = APUNTES.CUENTA and cuenta=cta and IMPORTE>0;
    return valorIngresos;
end $$

SELECT cuenta, SUMA_APUNTES(cuenta) AS Suma_Valores FROM cuenta;
SELECT cuenta, valor_ingresos(cuenta) AS Suma_Valores FROM cuenta;


Delimiter $$
Drop function if exists total_apunte$$
Create function total_apunte (cta varchar(20)) returns int
begin
	declare aux int;
    Select count(CUENTA) into aux from apuntes where CUENTA=cta;
    return aux;
end$$

Select CUENTA, total_apunte(CUENTA) n_apuntes from cuenta;


delimiter $$
drop function if exists diferencia_min_max_apuntes $$
create function diferencia_min_max_apuntes(cuent varchar(20)) returns double
begin
        declare diferencia double;
        select (max(importe) - min(importe)) into diferencia from apuntes where CUENTA = cuent; 
        return diferencia;
end $$

select CUENTA, diferencia_min_max_apuntes(cuenta) as diferencia from cuenta;

DELIMITER $$
drop function if exists concepto_apuntes$$
create function concepto_apuntes (concept varchar(20)) returns int
begin
	declare con int;
	select count(concepto) into con from apuntes where concepto like '*'+concept+'*';
    return con;
end$$
select concepto_apuntes(concepto) from apuntes;

delimiter $$
DROP FUNCTION IF EXISTS ESTADO_OK$$
CREATE FUNCTION ESTADO_OK (CTA VARCHAR(20)) RETURNS varchar(12)
BEGIN
DECLARE AUX FLOAT;
DECLARE AUX2 FLOAT;
SELECT SUM(IMPORTE) INTO AUX FROM APUNTES WHERE CUENTA=CTA;
SELECT (IMPORTE_ACTUAL) INTO AUX2 FROM CUENTA WHERE CUENTA=CTA;

IF (AUX=AUX2) THEN 
RETURN 'ESTADO____OK';
ELSE
RETURN 'ESTADO_NO_OK';
END IF;
END$$

select cuenta, estado_ok(cuenta) from cuenta;

delimiter $$
drop function if exists total_time $$
create function total_time(n_cuenta char(20)) returns double
begin
    declare tiempo_existencia double;
    declare fecha_creacion date;
    select min(fecha) into fecha_creacion from apuntes where cuenta = n_cuenta;
    set tiempo_existencia = curdate() - fecha_creacion;
    return tiempo_existencia;
end $$
delimiter ;
select cuenta, total_time(cuenta) from cuenta;