CREATE DATABASE procedim;
USE procedim;
/* CREACION DE LA ESTRUCTURA DE TABLAS */ 
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

DROP TABLE IF EXISTS log;
CREATE TABLE log (id INT PRIMARY KEY AUTO_INCREMENT,
error_desc VARCHAR(50) NOT NULL,
origen VARCHAR(20) NOT NULL,
fecha timestamp
);

SET RESULTADO='TABLAS CREADAS CORRECTAMENTE';
END //

/* FUNCIONES PARA DATOS EJEMPLO */ 
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
CALL ESTRUCTURA_BD (@RESULTADO);
CALL VALORES_DEFECTO (@RESULTADO1);

SELECT @RESULTADO, ' - ', @RESULTADO1;

/* Ejercicio 1:
Crea un procedimiento llamado busqueda que busque todos los alumnos que su apellido contengan la cadena indicada.
Ejemplo: CALL busqueda('R%');*/
DELIMITER //
CREATE PROCEDURE busqueda(IN param VARCHAR(20))
BEGIN 
	declare exit handler for sqlexception
    begin
		insert into log values(0,'ERRROR EN EL PROCEDIMIENTO DE BUSQUEDA','PROC_BUSQUEDA', sysdate());
    end;
    SELECT * FROM alumnos WHERE apellidos LIKE param;
END //
DELIMITER ;

/*Ejercicio 2:
Crea un procedimento que busque los profesores por nombre y apellido. Tener en cuenta que si dejamos alguno
 de los dos parámetros vacios busque por otros.
ejemplo: CALL busqueda2(NULL,'Ribas');*/

DELIMITER //
CREATE PROCEDURE busqueda2(IN param VARCHAR(20), IN param2 VARCHAR(20))
BEGIN 
	declare exit handler for sqlexception
    begin
		insert into log values(0,'ERRROR EN EL PROCEDIMIENTO DE BUSQUEDA','PROC_BUSQUEDA 2', sysdate());
    end;
    IF (param IS NULL) THEN
    	SELECT * FROM profesor WHERE apellidos LIKE param2;
    ELSEIF (param2 IS NULL)THEN
		SELECT * FROM profesor WHERE nom LIKE param;
    ELSEIF (param2 IS NULL and param IS NULL) THEN
    	SELECT * FROM profesor;
    ELSE
    	SELECT * FROM profesor WHERE nom LIKE param AND apellidos LIKE param2;
    END IF;
END //
DELIMITER ;
CALL busqueda2(NULL, 'R%');

/* Ejercicio 3: 
Crea un procedimento que incremente el valor del codigo en un valor que nosotros le indiquemos.
ejemplo: CALL actualiza(20);*/

DELIMITER //
CREATE PROCEDURE actualiza(IN par INT)    
BEGIN 
	declare exit handler for sqlexception
    begin
		insert into log values(0,'ERRROR EN EL PROCEDIMIENTO DE ACTUALIZACION','PROC_ACTUALIZA', sysdate());
    end;
    UPDATE alumnos SET codigo=(codigo+par);
    UPDATE profesor SET codigo = (codigo+par);
END //
DELIMITER ;

CALL actualiza(5);

/* Ejercicio 4: 
Crea un procedimento que dado un nombre, apellido, fecha_nacimiento y si es profesor o alumno, lo añada en su tabla correspondiente. 
Si no, que no haga nada
ejemplo: CALL inserta('Javier','Vila ','1975/02/03','profesor');
*/
 DELIMITER //
CREATE PROCEDURE insertar(IN par_nombre VARCHAR(20), IN par_apellidos VARCHAR(20), IN par_fecha_nac DATE, IN par_tipo VARCHAR(20))
BEGIN 
	declare exit handler for sqlexception
    begin
		insert into log values(0,'ERRROR EN EL PROCEDIMIENTO DE INSERCION','PROC_INSERTAR', sysdate());
    end;
    CASE par_tipo
    WHEN 'profesor' THEN INSERT INTO profesor VALUES (NULL,par_nombre,par_apellidos,par_dat,NULL);
    WHEN 'alumnos' THEN INSERT INTO alumnos VALUES (NULL,par_nombre,par_apellidos,par_dat,NULL);
    END CASE;
END //
DELIMITER ;   

/* Ejercicio 5:
Crea un procedimento que añada la fecha de naciemiento a los alumnos que no la tienen asignada.
Para ello indidicaremos el codigo del alumno y la fecha de nacimiento.
ejemplo:  CALL fecha_nac(21,'1995/03/19');*/
DELIMITER //
CREATE PROCEDURE fecha_nac(IN cod INT, IN dat DATE)
BEGIN 
	declare exit handler for sqlexception
    begin
		insert into log values(0,'ERRROR EN EL PROCEDIMIENTO DE ACTUALIZAR FECHA NAC','PROC_FECHA_NAC', sysdate());
    end;
    UPDATE alumnos SET fecha_nac= dat WHERE codigo = cod LIMIT 1;
END //
DELIMITER ;

CALL fecha_nac(6,'1999/03/19');

/* Ejercicio 6:
Crea un procedimento que, dada la tabla que le indiquemos y el código de la persona calcule la 
edad a partir de la fecha de nacimiento ejemplo:  CALL edad('profesor',20);*/
 
DELIMITER //
CREATE PROCEDURE edad(IN tabla VARCHAR(20), IN cod INT)
BEGIN 
	declare exit handler for sqlexception
    begin
		insert into log values(0,'ERRROR EN EL PROCEDIMIENTO DE EDAD','PROC_EDAD', sysdate());
    end;
	IF (tabla = 'profesor') THEN  
		begin
			SELECT YEAR(NOW())-YEAR(fecha_nac) FROM profesor WHERE codigo = cod;
			update profesor set edad=(YEAR(NOW())-YEAR(fecha_nac))  WHERE codigo = cod;
		end
    ELSEIF (tabla = 'alumnos') THEN 
		begin
			SELECT YEAR(NOW())-YEAR(fecha_nac)FROM alumnos WHERE codigo = cod;
			update alumnos set edad=(YEAR(NOW())-YEAR(fecha_nac))  WHERE codigo = cod;
		end
    END IF;
END //
DELIMITER ;

CALL edad('profesor',6);

/* Ejercicio 7:
Crear un procedimento para eliminar los registros de la tabla alumnos que tienen su código 
entre los indicados (incluidos).
ejemplo:  CALL eliminar(20,22);*/
DELIMITER //
CREATE PROCEDURE elimina(IN par1 INT, IN par2 INT)

BEGIN
    DECLARE par3 INT DEFAULT par1;
	declare exit handler for sqlexception
    begin
		insert into log values(0,'ERRROR EN EL PROCEDIMIENTO DE EDAD','PROC_EDAD', sysdate());
    end; 
    WHILE (par3<=par2) DO
    	DELETE FROM alumnos WHERE codigo = par3 LIMIT 1;
    	SET par3=par3+1;
    END WHILE;
	
	
	/* otra opcion      DELETE FROM alumnos WHERE codigo between par1 and par2;    */ 
	
	
END //
DELIMITER ;

CALL elimina(6,8);