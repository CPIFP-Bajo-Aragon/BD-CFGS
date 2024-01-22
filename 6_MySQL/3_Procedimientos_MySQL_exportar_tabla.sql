delimiter ##
CREATE procedure EXPORTAR (IN ptabla VARCHAR(25))
BEGIN
	 if ptabla='alumno' then
     SELECT  codigo, IFNULL(nombre,""),IFNULL(apellidos,""), IFNULL(sexo,""),IFNULL(direccion,""), IFNULL(poblacion,""),
		IFNULL(cod_postal,""), IFNULL(fecha_alta,""),IFNULL(telefono,""),IFNULL(email,"")  FROM alumno INTO OUTFILE 'C:/exportacion/alumnos.csv' 
		FIELDS ENCLOSED BY '"' 
		TERMINATED BY ';' 
		ESCAPED BY '"' 
		LINES TERMINATED BY '\r\n';
	end if;
	if ptabla='modulo' then
		SELECT  codigo, IFNULL(nombre,""),IFNULL(horas_semana,""), IFNULL(horas_totales,""),IFNULL(es_llave,""),  
		IFNULL(nombre_ciclo,""), IFNULL(curso,""),IFNULL(codigo_prof,"") FROM modulo INTO OUTFILE 'C:/exportacion/cursos.csv' 
		FIELDS ENCLOSED BY '"' 
		TERMINATED BY ';' 
		ESCAPED BY '"' 
		LINES TERMINATED BY '\r\n';
	end if;
    	if ptabla='profesor' then
		SELECT codigo, IFNULL(nombre,""),IFNULL(apellidos,""), IFNULL(fecha_alta,""),IFNULL(telefono,""),  
		IFNULL(email,"") FROM profesor INTO OUTFILE 'C:/exportacion/profesores.csv' 
		FIELDS ENCLOSED BY '"' 
		TERMINATED BY ';' 
		ESCAPED BY '"' 
		LINES TERMINATED BY '\r\n';
	end if;
END ##
delimiter ;

call exportar('alumno');
call exportar('modulo');
call exportar('profesor');

call exportar_csv('alumno',10);

DROP PROCEDURE IF EXISTS exportar_csv ##
CREATE PROCEDURE exportar_csv (IN ptabla VARCHAR(50), IN filas INT)
BEGIN
	DECLARE x,y  INT;
	DECLARE total_filas INT;
	 
	SET x=0;
	SET y=1;
	 
	-- cuento el numero total de filas que devuelve la consulta y las guardo 
	SET @SQLString1 = CONCAT('SELECT COUNT(*) INTO @total_filas FROM ',ptabla);
	PREPARE test1 FROM @SQLString1;
	EXECUTE test1;
	 
	WHILE x <= @total_filas DO	 
		-- exporto las fillas del select estableciento un limite 
		SET @SQLString = CONCAT('SELECT * FROM ',ptabla,' LIMIT ',x,',',filas,' INTO OUTFILE "c:/exportacion/',ptabla,'-',y,'.csv" FIELDS TERMINATED BY '','' OPTIONALLY ENCLOSED BY ''"'' LINES TERMINATED BY ''\n''');
		PREPARE test2 FROM @SQLString;
		EXECUTE test2;
		 
		SET x=x+rows;
		SET y=y+1;
	END WHILE;
END ##
DELIMITER ;


LOAD DATA LOCAL INFILE 'C:/exportacion/alumnos.csv'
INTO TABLE alumno
FIELDS ENCLOSED BY '"' 
TERMINATED BY ';' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n' (campo1, campo2, campo3, campo4);