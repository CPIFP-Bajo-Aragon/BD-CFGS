CREATE DATABASE alumnos;
USE alumnos;


/* CREACION DE LA ESTRUCTURA DE TABLAS CON PROCEDIMIENTOS*/ 
DELIMITER //
DROP PROCEDURE IF EXISTS ESTRUCTURA_BD //
CREATE PROCEDURE ESTRUCTURA_BD(OUT RESULTADO VARCHAR(50)) 
BEGIN
SET RESULTADO='0';
DROP TABLE IF EXISTS ALUMNOS;
CREATE TABLE alumnos(
codigo INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(20) NOT NULL,
apellidos VARCHAR(20) NOT NULL,
fecha_nac DATE,
edad INT 
);
DROP TABLE IF EXISTS PROFESOR;
CREATE TABLE profesor (
codigo INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(20) NOT NULL,
apellidos VARCHAR(20) NOT NULL,
fecha_nac DATE,
edad INT
);
SET RESULTADO='TABLAS CREADAS CORRECTAMENTE';
END //

/* FUNCIONES PARA CARGA DE DATOS DE EJEMPLO CON PROCEDIMIENTOS*/ 
DELIMITER //
DROP PROCEDURE IF EXISTS procedim.VALORES_DEFECTO //
CREATE PROCEDURE procedim.VALORES_DEFECTO(OUT RESULTADO VARCHAR(50)) 
BEGIN
SET RESULTADO='0';
TRUNCATE TABLE ALUMNOS;
TRUNCATE TABLE PROFESOR;
INSERT INTO alumnos VALUES (NULL,'Guillermo','Garcia','1992/12/20',NULL);
INSERT INTO alumnos VALUES (NULL,'Marta','Ros','1993/01/21',NULL);
INSERT INTO alumnos VALUES (NULL,'Miguel','Rodriguez','1990/10/11',NULL);
INSERT INTO profesor VALUES (NULL,'Nuria','Ribas','1985/10/06',NULL);
INSERT INTO profesor VALUES (NULL,'Carlos','Puyol','1978/06/14',NULL);
SET RESULTADO='DATOS DE EJEMPLO CARGADOS';
END //

DELIMITER ;

/* EJECUCION DE LOS PROCEDIMIENTOS DE ESTRUCTURA Y DATOS */
CALL ESTRUCTURA_BD (@RESULTADO);
CALL VALORES_DEFECTO (@RESULTADO1);
SELECT @RESULTADO, ' - ', @RESULTADO1;

/* Ejercicio 1:
Crea un procedimiento llamado busqueda que busque todos los alumnos que su apellido contengan la cadena indicada.
Ejemplo: CALL busqueda('R%');*/


/*Ejercicio 2:
Crea un procedimento que busque los profesores por nombre y apellido. Tener en cuenta que si dejamos alguno
 de los dos parámetros vacios busque por otros.
ejemplo: CALL busqueda2(NULL,'Ribas');*/

/* Ejercicio 3: 
Crea un procedimento que incremente el valor del codigo en un valor que nosotros le indiquemos.
ejemplo: CALL actualiza(20);*/


/* Ejercicio 4: 
Crea un procedimento que dado un nombre, apellido, fecha_nacimiento y si es profesor o alumno, lo añada en su tabla correspondiente. 
Si no, que no haga nada
ejemplo: CALL inserta('Javier','Vila ','1975/02/03','profesor');
*/

/* Ejercicio 5:
Crea un procedimento que añada la fecha de naciemiento a los alumnos que no la tienen asignada o sea erronea.
Para ello indidicaremos el codigo del alumno y la fecha de nacimiento.
ejemplo:  CALL fecha_nac(21,'1995/03/19');*/

/* Ejercicio 6:
Crea un procedimento que, dada la tabla que le indiquemos y el código de la persona calcule la 
edad a partir de la fecha de nacimiento ejemplo:  CALL edad('profesor',20);*/
 
/* Ejercicio 7:
Crear un procedimento para eliminar los registros de la tabla alumnos que tienen su código 
entre los indicados (incluidos).
ejemplo:  CALL eliminar(20,22);*/
