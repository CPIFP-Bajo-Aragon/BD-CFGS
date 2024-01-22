/* PROCEDIMIENTO DEFINIDOS POR USUARIO -ADMIN BD QUE FACILITAN AL PROGRAMADOR LOS PROCESOS BASICOS DE ALTA-ELIMINACION DE REGISTROS*/ 
use banco_proc;

create procedure alta_cuenta(IN CTA CHAR(20), IN TIT CHAR(20), IN TIT2 CHAR(20), IN IMP_INICIAL DOUBLE(10,2), OUT MENSAJE VARCHAR (50));

create procedure baja_cuenta(IN CTA CHAR(20), OUT MENSAJE VARCHAR (50));

create procedure alta_apunte();

create procedure baja_apunte();