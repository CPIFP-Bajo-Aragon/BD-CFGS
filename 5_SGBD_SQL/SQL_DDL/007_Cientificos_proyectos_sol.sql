--CREATE DATABASE DAI;
USE ANDI;
DROP TABLE IF EXISTS `empleados`;
CREATE TABLE `empleados` (
  `empleado` int(10) unsigned NOT NULL auto_increment,
  `nombre` varchar(45) NOT NULL default '',
  `apellidos` varchar(45) NOT NULL default '',
  `DNI` varchar(9) NOT NULL default '',
  PRIMARY KEY  (`empleado`)
);
/* ELIMINACION DE LAS TABLAS EXISTENTES */
DROP TABLE IF EXISTS `ASIGNADOS`;
DROP TABLE IF EXISTS `CIENTIFICOS`;
DROP TABLE IF EXISTS `PROYECTOS`;

/* CREACION DE LAS TABLAS DEL EJERCICIO */
CREATE TABLE `CIENTIFICOS`(
       `DNI` varchar(9) not null default '',
       `NOMBRE` varchar(50) not null default '',
       PRIMARY KEY  (`DNI`)
);

CREATE TABLE `PROYECTOS`(
       `IDPROYECTO` varchar(4),
       `NOMBRE` varchar(50) not null default '',
       `HORAS` int(2) not null default '0',
       PRIMARY KEY  (`IDPROYECTO`)
);

CREATE TABLE `ASIGNADOS`(
       `CIENTIFICO` varchar(9) default '',
       `PROYECTO` varchar(4) default '',
       PRIMARY KEY  (`CIENTIFICO`,`PROYECTO`),
       FOREIGN KEY (`CIENTIFICO`) REFERENCES CIENTIFICOS (`DNI`),
       FOREIGN KEY (`PROYECTO`) REFERENCES PROYECTOS(`IDPROYECTO`)
);

/* INSERCION DE VALORES DE PRUEBA PARA EL EJERCICIO*/
INSERT INTO `CIENTIFICOS` VALUES('12345678Z','MIGUEL ANGEL BORRAZ');
INSERT INTO `CIENTIFICOS` VALUES('87654321Z','OMAR CESTER');
INSERT INTO `CIENTIFICOS` VALUES('23456789X','CAIUS DRAGOTA');
INSERT INTO `CIENTIFICOS` VALUES('34567891S','JOSE MICOLAU');
INSERT INTO `CIENTIFICOS` VALUES('45678901Z','DAVID POLO');
INSERT INTO `CIENTIFICOS` VALUES('56789012L','DANIEL JURADO');
INSERT INTO `CIENTIFICOS` VALUES('87654356Z','ELENA MAGALLON');
INSERT INTO `CIENTIFICOS` VALUES('45768932Z','MIGEL ALQUEZAR');
INSERT INTO `CIENTIFICOS` VALUES('12348567Y','MARIA GRAU');

INSERT INTO `PROYECTOS` VALUES ('DISA','DISEÑO APLICACIONES INFORMATICAS','320');
INSERT INTO `PROYECTOS` VALUES ('PROG','INICIOS DE PROGRAMACION','258');
INSERT INTO `PROYECTOS` VALUES ('SIST','SISTEMAS OPERATIVOS','180');
INSERT INTO `PROYECTOS` VALUES ('REDE','REDES Y COMUNICACIONES','360');

INSERT INTO `ASIGNADOS` VALUES ('12345678Z','PROG');
INSERT INTO `ASIGNADOS` VALUES ('45678901Z','DISA');
INSERT INTO `ASIGNADOS` VALUES ('23456789X','SIST');
INSERT INTO `ASIGNADOS` VALUES ('56789012L','DISA');
INSERT INTO `ASIGNADOS` VALUES ('45678901Z','SIST');
INSERT INTO `ASIGNADOS` VALUES ('45768932Z','DISA');
INSERT INTO `ASIGNADOS` VALUES ('23456789X','PROG');
INSERT INTO `ASIGNADOS` VALUES ('87654356Z','DISA');
INSERT INTO `ASIGNADOS` VALUES ('45678901Z','REDE');
INSERT INTO `ASIGNADOS` VALUES ('56789012L','SIST');
INSERT INTO `ASIGNADOS` VALUES ('45678901Z','PROG');
INSERT INTO `ASIGNADOS` VALUES ('45768932Z','REDE');
INSERT INTO `ASIGNADOS` VALUES ('12345678Z','SIST');
INSERT INTO `ASIGNADOS` VALUES ('23456789X','DISA');
INSERT INTO `ASIGNADOS` VALUES ('87654356Z','REDE');
INSERT INTO `ASIGNADOS` VALUES ('45768932Z','PROG');
INSERT INTO `ASIGNADOS` VALUES ('12345678Z','REDE');

/*7.1.Sacar una relación completa de los cientificos asignados a cada proyecto.
Mostrar DNI, Nombre del cientifico, Identificador del proyecto y nombre del proyecto.*/

/* PRODUCTO CARTESIANO */
SELECT DNI, C.NOMBRE, IDPROYECTO, P.NOMBRE 
FROM CIENTIFICOS C, ASIGNADOS A, PROYECTOS P
WHERE A.PROYECTO=P.IDPROYECTO and C.DNI=A.CIENTIFICO;

/* Con JOIN */
SELECT DNI, C.NOMBRE, IDPROYECTO, P.NOMBRE 
FROM CIENTIFICOS C INNER JOIN (ASIGNADOS A INNER JOIN PROYECTOS P ON A.PROYECTO=P.IDPROYECTO) ON C.DNI=A.CIENTIFICO;

/* RESULTADO -> 17 proyectos con sus cientificos */

/*7.2.Obtener el numero de proyectos al que est´a asignado cada cient´ifico (mostrar el DNI y el nombre)*/

SELECT C.DNI, C.NOMBRE, COUNT(PROYECTO)
FROM CIENTIFICOS C LEFT JOIN ASIGNADOS A ON C.DNI = A.Cientifico
GROUP BY DNI, NOMBRE;

/* RESULTADO -> 3 +0 + 3 + 0 + 4+3 */
 
/*7.3.Obtener el numero de cientificos asignados a cada proyecto (mostrar el identificador de proyecto y el nombre del proyecto).*/

SELECT IDPROYECTO, NOMBRE, COUNT(Cientifico) 
FROM PROYECTOS LEFT JOIN ASIGNADOS ON PROYECTOS.IDPROYECTO=ASIGNADOS.PROYECTO 
GROUP BY IDPROYECTO;

/* RESULTADO -> 5 + 4 + 4 + 4*/


/*7.4.Obtener el numero total de horas de dedicacion de cada cientifico.*/

SELECT DNI, C.NOMBRE, SUM(HORAS)  
FROM CIENTIFICOS C LEFT JOIN (ASIGNADOS A INNER JOIN PROYECTOS P 
ON A.Proyecto = P.IDPROYECTO) ON C.DNI = A.Cientifico 
GROUP BY DNI,NOMBRE;
/* RESULTADO -> 798 + 0 + 758 + 0+ 1118 + 938 + 500 + 0 + 680*/


/*7.5.Obtener el DNI y nombre de los cient´ificos que se dedican a m´as de un proyecto 
y  dedicacion media a cada proyecto  superior a 80 horas.*/

/* Con PRODUCTO CARTESIANO  y con HAVING */ 
SELECT C.DNI, C.NOMBRE, COUNT(Proyecto),  AVG(Horas)
FROM CIENTIFICOS C , ASIGNADOS A , PROYECTOS P 
WHERE A.Proyecto = P.IDPROYECTO AND C.DNI = A.Cientifico
GROUP BY DNI, NOMBRE
HAVING COUNT(Proyecto)>1 AND AVG(Horas)>80;

/* Con JOIN  y con HAVING */ 
SELECT C.DNI, C.NOMBRE, COUNT(Proyecto),  AVG(Horas)
FROM CIENTIFICOS C JOIN (ASIGNADOS A INNER JOIN PROYECTOS P ON A.Proyecto = P.IDPROYECTO) ON C.DNI = A.Cientifico
GROUP BY DNI, NOMBRE
HAVING COUNT(Proyecto)>1 AND AVG(Horas)>80;

/* Con dos subconsultas ENLAZADAS */ 
SELECT DNI, NOMBRE
FROM CIENTIFICOS C 
WHERE 1<(SELECT COUNT(*) FROM ASIGNADOS WHERE Cientifico = C.DNI) 
AND 80<(SELECT AVG(Horas) FROM PROYECTOS INNER JOIN ASIGNADOS ON PROYECTOS.IDPROYECTO = ASIGNADOS.Proyecto
WHERE Cientifico = C.DNI);

/* RESULTADO -> 6 REGISTROS */


/*7.6. mover todos los cientificos del proyecto de redes al de sistemas operativos */
update asginados set proyecto='SIST' where proyecto='REDE';

/*7.7. renombrar el proyecto de sistemas operativos a sistemas informaticos*/
update proyectos set nombre='SISTEMAS INFORMATICOS' where NOMBRE='SISTEMAS OPERATIVOS';

/*7.8. incrementar el numero de horas dedicadas por los cientificos del proyecto de programación en un 15% */
update proyectos set horas=horas*1.15 where  nombre like '%programacion%';


/*7.9.Eliminar los cientificos que no hayan dedicado ninguna hora a algun proyecto*/ 

delete from cientificos where dni in (SELECT DNI  
FROM CIENTIFICOS C LEFT JOIN (ASIGNADOS A INNER JOIN PROYECTOS P ON A.Proyecto = P.IDPROYECTO) ON C.DNI = A.Cientifico 
GROUP BY DNI HAVING SUM(HORAS)=0);

delete from cientificos where dni NOT in (SELECT DNI FROM asginados);

/*7.10 Añadir los campos dirección, codigo postal y población a la tabla cientificos */ 
Alter table cientificos add column direccion varchar(20), add column  cp int,  add column poblacion varchar(20);

/*7.11 Añadir el campo presupuesto_proyecto (debe permitir almacenar decimales) a la tabla de proyectos */ 
Alter table proyectos add column presupuesto_proyecto float;