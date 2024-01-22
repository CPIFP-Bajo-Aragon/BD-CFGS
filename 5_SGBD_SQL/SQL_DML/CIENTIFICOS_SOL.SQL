/*7.1.Sacar una relación completa de los cient´ıficos asignados a cada proyecto.
Mostrar DNI, Nombre del cient´ıfico, Identificador del proyecto y nombre del proyecto.*/

/* PRODUCTO CARTESIANO */
SELECT DNI, NomApels, Id, Nombre
FROM CIENTIFICOS C, ASIGNADO_A A, PROYECTO P
WHERE C.DNI = A.Cientifico AND A.Proyecto = P.Id

/* Con JOIN */
SELECT DNI, NomApels, Id, Nombre 
FROM CIENTIFICOS C INNER JOIN (ASIGNADO_A A INNER JOIN PROYECTO P
ON A.Proyecto = P.Id) ON C.DNI = A.Cientifico


/*7.2.Obtener el numero de proyectos al que est´a asignado cada cient´ıfico (mostrar el DNI y el nombre)*/.

SELECT DNI, NomApels, COUNT(Proyecto) 
FROM CIENTIFICOS LEFT JOIN ASIGNADO_A ON CIENTIFICOS.DNI = ASIGNADO_A.Cientifico
GROUP BY DNI, NomApels

 
/*7.3.Obtener el numero de cient´ıficos asignados a cada 
proyecto (mostrar el identificador de proyecto y el nombre del proyecto).*/

SELECT Id, Nombre, COUNT(Cientifico) 
FROM PROYECTO LEFT JOIN ASIGNADO_A ON PROYECTO.Id = ASIGNADO_A.Proyecto
GROUP BY Id, Nombre


/*7.4.Obtener el numero de horas de dedicaci´on de cada cientifico.*/

SELECT DNI,NomApels, SUM(Horas) 
FROM CIENTIFICOS C LEFT JOIN (ASIGNADO_A A INNER JOIN PROYECTO P 
ON A.Proyecto = P.Id) ON C.DNI = A.Cientifico 
GROUP BY DNI,NomApels


/*7.5.Obtener el DNI y nombre de los cient´ıficos que se dedican a m´as de un proyecto y 
cuya dedicaci´on media a cada proyecto sea superior a las 80 horas.*/

/* Juntando tablas y con HAVING */ 
SELECT DNI, NomApels
FROM CIENTIFICOS C JOIN (ASIGNADO_A A INNER JOIN PROYECTO P ON A.Proyecto = P.Id) ON C.DNI = A.Cientifico
GROUP BY DNI, NomApels
HAVING COUNT(Proyecto)>1 AND AVG(Horas)>80


/* Con dos subconsultas ENLAZADAS */ 
SELECT DNI, NomApels
FROM CIENTIFICOS C 
WHERE 1<(SELECT COUNT(*) FROM ASIGNADO_A WHERE Cientifico = C.DNI) 
AND 80<(SELECT AVG(Horas) FROM PROYECTO INNER JOIN ASIGNADO_A ON PROYECTO.Id = ASIGNADO_A.Proyecto
WHERE Cientifico = C.DNI)




