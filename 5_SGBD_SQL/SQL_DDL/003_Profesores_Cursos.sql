create schema alumnado; 
use alumnado;

CREATE TABLE PROFESORADO
( Codigo int, 
  Nombre varchar(30), 
  Apellidos varchar(30), 
  DNI varchar(10), 
  Especialidad varchar(20),
  Fecha_Nac DATE,
  Antiguedad int,
  CONSTRAINT Cod_Profe_PK PRIMARY KEY (Codigo)
);  

CREATE TABLE CURSOS
( Codigo int, 
  Nombre varchar(20), 
  Cod_Profe int, 
  Max_Alumn int, 
  Fecha_Inic DATE, 
  Fecha_Fin DATE, 
  Num_Horas int,
  CONSTRAINT Cod_Curso_PK PRIMARY KEY (Codigo),    
  CONSTRAINT Cod_Profe_FK
    FOREIGN KEY (Cod_Profe)
    REFERENCES PROFESORADO(Codigo)
);
                   
----------------------------------------
CREATE SCHEMA if NOT exists CURSOS;
USE CURSOS;

DROP TABLE IF EXISTS CURSOS ;
DROP TABLE IF EXISTS PROFESORADO ;

CREATE TABLE PROFESORADO( 
  Codigo int, 
  Nombre varchar(30), 
  Apellidos varchar(30), 
  DNI varchar(10), 
  Especialidad varchar(20),
  Fecha_Nac DATE,
  Antiguedad int
);  
CREATE TABLE CURSOS(
  Codigo int, 
  Nombre varchar(20), 
  Cod_Profe int, 
  Max_Alumn int, 
  Fecha_Inic DATE, 
  Fecha_Fin DATE, 
  Num_Horas int
);
 
ALTER TABLE PROFESORADO ADD CONSTRAINT Cod_Profe_PK PRIMARY KEY (Codigo); 
ALTER TABLE CURSOS ADD CONSTRAINT Cod_Curso_PK PRIMARY KEY (Codigo);    
ALTER TABLE CURSOS ADD CONSTRAINT Cod_Profe_FK FOREIGN KEY (Cod_Profe) REFERENCES PROFESORADO(Codigo);



-------------------------------------

INSERT INTO CURSOS (Codigo, Nombre, Max_Alumn, Fecha_Inic, Fecha_Fin, Num_Horas) VALUES 
(1, 'Curso 1', 30, '01/01/2011', '31/12/2011', 100);
INSERT INTO CURSOS (Codigo, Nombre, Max_Alumn, Fecha_Inic, Fecha_Fin, Num_Horas) VALUES 
(2, 'Curso 2', 30, '01/01/2011', '31/12/2011', 100);
INSERT INTO CURSOS (Codigo, Nombre, Max_Alumn, Fecha_Inic, Fecha_Fin, Num_Horas) VALUES 
(3, 'Curso 3', 30, '01/01/2011', '31/12/2011', 100);
INSERT INTO CURSOS (Codigo, Nombre, Max_Alumn, Fecha_Inic, Fecha_Fin, Num_Horas) VALUES 
(4, 'Curso 4', 30, '01/01/2011', '31/12/2011', 100);
INSERT INTO CURSOS (Codigo, Nombre, Max_Alumn, Fecha_Inic, Fecha_Fin, Num_Horas) VALUES 
(5, 'Curso 5', 30, '01/01/2011', '31/12/2011', 100);
INSERT INTO CURSOS (Codigo, Nombre, Max_Alumn, Fecha_Inic, Fecha_Fin, Num_Horas) VALUES 
(6, 'Curso 6', 30, '01/01/2011', '31/12/2011', 100);
   
    
    
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('MANUELA','SUAREZ IBAÑEZ','M','30/6/1990',1);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('MILAGROSA','DIAZ PEREZ','M','28/10/1984',3);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('JOSE','CRESPO DE HERMOSO','H','2/3/1993',1);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('ANTONIO JESUS','MARTIN BOLLO','H','4/11/1999',1);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('BARBARA','PELAEZ VALENCIA','M','27/8/1967',4);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('JUAN PEDRO','GALVE GONZALEZ','H','10/11/1991',4);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('MARIA ISABEL','PEREZ GUILLEN','M','14/11/1962',2);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('PATRICIA','ROMAN GOMEZ','M','26/4/1979',3);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('DAVID','TAPIA SOLANS','H','5/6/1980',4);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('MARIA','FERREIRO SANTOS','M','29/1/1969',1);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('JAVIER','LAMA DEL REY','H','26/2/1977',2);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('ALEJANDRA','CALDERON VALDIVIA','M','16/11/1960',2);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('ANA DOLORES','ESCUDERO ENCISO','M','7/9/1975',4);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('JUAN CARLOS','RODRIGUEZ PADILLA','H','15/11/1963',5);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('CECILIO','SASTRE GONZALEZ','H','23/11/1969',3);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('JUAN','MARTINEZ SANCHEZ','H','23/10/1974',2);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('MARIA','LAFUENTE FERNANDEZ','M','21/11/1986',2);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('MANUELA','MARTINEZ ALBA','M','26/11/1962',1);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('ROSA NIEVES','SANCHEZ CANO','M','12/12/1979',5);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('BELEN','RAMOS ANGUITA','M','30/12/1967',2);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('JULIAN','GARCIA ZABALA','H','4/1/1963',3);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('DIEGO JESUS','CANO SALVADOR','H','18/5/1970',1);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('JOSE IGNACIO','HARO FANECA','H','8/5/1981',5);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('JOSEFA','CASTELLANOS DIEZ','M','1/5/1998',2);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('BEATRIZ','RUBIO BERMEJO','M','29/4/1970',5);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('JAVIER','CASTRO GOMEZ','H','20/8/1967',5);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('DAVID','GAY GARCIA DEL VALLE','H','22/7/1989',3);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('DAVID','TOCADOS GARCIA','H','18/1/1961',1);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('ELISA ISABEL','BRUNO CALVO','M','13/5/1998',4);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('DIANA','GUILLAMON POSADA','M','29/4/1980',2);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('DAVID','RANILLA URRUTIA','H','22/11/1964',2);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('JAVIER','LUENGO HERRERO','H','22/4/1963',3);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('DAVID','VALENCIA MEDINA','H','27/3/1981',2);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('RAFAEL','DIAZ LAMA','H','1/6/1979',1);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('CAROLINA','RIVAS MENDIA','M','30/7/1974',1);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('JOSE MANUEL','GARCIA ZAPICO','H','3/3/1963',5);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('MIGUEL','IBARROLA DIEZ','H','12/8/1985',4);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('ENCARNACION','ASENJO HERNANDO','M','3/4/1962',4);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('FRANCISCO','CALVO BONO','H','17/6/1974',5);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('JOSE ANTONIO','CALVO RODRIGUEZ','H','4/5/1989',5);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('ANTONIA','MORENO RAYA','M','4/8/1976',1);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('JOSE MARIA','FUENTEMILLA ALBERT','H','27/12/1979',4);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('BELEN','PORTERO GRACIA','M','28/10/1991',4);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('LUIS ANTONIO','SUAREZ GARCIA','H','24/10/1997',5);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('FRANCISCO ANTONIO','BAUTISTA LAMENCA','H','9/9/1992',3);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('SILVIA','PEÑA CASTAN','M','20/7/1977',5);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('CARMEN','KAAMOUCHI VICENTE','M','31/5/1990',3);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('MARIA','LASTRA MOLINA','M','29/9/1961',1);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('ROCIO EMILIA','IZQUIERDO BELTRAN','M','1/4/1981',5);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('OSCAR','DIEZ NAVARRO','H','17/6/1972',3);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('JULIAN ANDRES','MORALES RIERA','H','31/12/1998',5);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('MUJERES','ALCALA PEREZ','M','11/10/1970',5);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('JOSE ANTONIO','GONZALEZ ROY','H','19/6/1965',1);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('JOSEFA','GOMEZ EGIDO','M','27/9/1998',5);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('MYRIAM','MORALES ISAC','M','15/9/1984',5);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('EDURNE','MARTINEZ LASTRA','M','25/1/1976',3);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('JUAN JOSE','RIVAS RAMON','H','1/5/1994',4);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('DANIEL JOSE','BLANCO IZQUIERDO','H','5/2/1982',2);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('MIRIAN','MONTERO LAMENCA','M','6/5/1972',5);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('MARIA PAZ','BERTIZ SARMIENTO','M','1/4/1997',5);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('EMILIO','MORILLO RAMON','H','5/9/1986',5);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('ENRIQUE','FERNANDEZ DIEZ','H','6/10/1972',3);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('ANA TERESA','CASADO CRESPO','M','13/1/1971',4);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('JOSE IGNACIO','MARTIN BERDUN','H','18/8/1987',5);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('DAVID','PADILLA ORTEGA','H','29/8/1960',4);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('MIGUEL','GARCIA LARRETA','H','4/2/1982',5);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('LUIS MIGUEL','NAVARRO URRUTIA','H','20/4/1969',5);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('NURIA','AMOSTEGUI LUZURIAGA','M','25/10/1973',2);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('ANA MARIA','SANDE LAMENCA','M','31/10/1999',1);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('LEON JOSE','SARMIENTO RIVAS','H','11/4/1969',5);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('VICTOR','GARCIA GARCÍA','H','29/12/1999',4);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('NATALIA','TIMON ECHEPARE','M','19/1/1986',2);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('MELANIE','CAMPOY GOMEZ','M','24/2/1967',2);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('RAMIRO','LLOBREGAT ALONSO','H','14/5/1984',3);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('JULIAN','JIMENO DIEZ','H','27/2/1976',3);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('ISABEL','SORIANO MATAMOROS','M','7/7/1995',2);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('MIGUEL','SANCHEZ SANCHEZ','H','6/2/1998',4);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('NOEMI','BERRUEZO REQUENA','M','25/11/1973',4);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('IVAN ANGEL DE LA','GARCIA RUBIO','H','26/3/1979',4);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('LUTGARDA','GOÑI TIMON','M','17/10/1974',2);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('MARIA JESUS','RECOVER AGUILERA','M','20/3/1984',1);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('MARIA SOLEDAD','MORILLAS GUILLEN','M','30/4/1975',4);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('JUAN MANUEL','MARTIN ALEJANO','H','16/9/1980',2);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('MARIA DEL MAR','CASTRO CRUZ','M','8/11/1977',2);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('MARIA ISABEL','ECHAGUE GONZALEZ','M','30/3/1998',1);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('JUAN','TALEGON CORTES','H','12/7/1966',2);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('MIGUEL','ARAGUAS DE LA TORRE','H','12/8/1998',4);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('DAVID','ALONSO GIMENEZ','H','2/9/1995',4);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('NICOLAS','BLANCO GONZALEZ','H','8/3/1992',2);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('ALBERTO','VEGA GARCIA','H','29/8/1976',4);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('EVA MARIA','FENOY ORDOÑEZ','M','4/12/1989',2);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('ANA M.','GUERRERO LANZA','M','5/11/1963',1);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('ANA MARIA','FERREIRO DIEZ','M','1/7/1999',5);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('ARTURO','REVIRIEGO CERVANTES','H','2/8/1964',5);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('ALEJANDRO','CANO MORALES','H','13/5/1960',1);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('AZUCENA','BERENGUEL ROY','M','27/5/1998',4);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('PAZ DE','GARRALDA ARIAS','M','6/9/1972',3);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('PABLO CESAR','URBISTONDO GONZALEZ','H','12/2/1991',2);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('OSCAR','MARTIN GALINDO','H','3/8/1992',5);
INSERT INTO ALUMNADO (Nombre,Apellidos,Sexo,Fecha_Nac,Cod_Curso) VALUES 
('LUIS','MOLINA TAGARRO','H','16/1/1996',4);


INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('MARIA','GOMEZ ANDRES','M','4/5/1985');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('JOSE MANUEL','PADILLA VEGAS','H','19/5/1999');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('RICARDO','MARQUINA HERNANDO','H','20/2/1982');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('MIGUEL','DIAZ FABRE','H','17/4/1985');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('LUIS MIGUEL','AGURRUZA RODRIGUEZ','H','25/4/1983');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('NICOLAS','LOBATO BARRANCO','H','25/6/1961');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('MIGUEL','BURGOS ZAPICO','H','13/4/1986');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('JOSE JESUS','VALDIVIESO JIMENEZ','H','23/12/1985');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('ANA MARIA','BEAMONTE GOMEZ','M','25/7/1968');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('MARIA','LOPEZ CARREÑO','M','18/11/1963');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('MARIA DEL MAR','ASENSIO SEGURA','M','21/5/1984');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('ROSA NIEVES','LARRAÑETA LAZARO','M','10/6/1976');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('ELENA','DAZA FANECA','M','18/9/1960');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('GEMA','PASTOR ADELL','M','13/2/1983');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('MARIA CARMEN','CHECA CANO','M','11/8/1960');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('JOSE ANTONIO','GRACIA GONZALEZ','H','28/11/1962');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('AMALIA','GIL PER','M','10/1/1965');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('VICTOR','RAMON GARCIA','H','24/8/1991');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('ESPERANZA VICTORIA','PANIZO DEL AGUILA','M','7/12/1972');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('ANTONIO','ALONSO SORIANO','H','15/6/1985');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('JAVIER','BOTAZ HERNÁNDEZ','H','31/3/1999');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('FRANCISCO','CUTILLAS HERNANDEZ','H','30/3/1982');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('EDUARDO','LOPEZ RODRIGUEZ','H','20/11/1964');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('ADOLFO','LOPEZ EL AAKROUTI','H','16/10/1987');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('MARIA ROSA','MORA BAUTISTA','M','20/4/1969');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('GONZALO','IBAÑEZ PALENCIA','H','21/12/1965');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('ANA M.','DIEZ IZQUIERDO','M','7/10/1976');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('ALICIA MARIA','DIAZ GUERRERO','M','27/8/1968');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('MONTSERRAT','VELA SASTRE','M','29/1/1980');
INSERT INTO ALUMNADO_NUEVO (Nombre,Apellidos,Sexo,Fecha_Nac) VALUES 
('LUIS','BERMEJO GARCIA','H','7/11/1984'); 
CREATE TABLE ALUMNADO_NUEVO
( Nombre varchar(30), 
  Apellidos varchar(30), 
  Sexo varchar(1), 
  Fecha_Nac DATE
);
              
CREATE TABLE ALUMNADO
( Codigo int, 
  Nombre varchar(30), 
  Apellidos varchar(30), 
  Sexo varchar(1), 
  Fecha_Nac DATE, 
  Cod_Curso int,
  CONSTRAINT Cod_alum_PK PRIMARY KEY (Codigo),    
  CONSTRAINT Cod_Curso_FK
    FOREIGN KEY (Cod_Curso)
    REFERENCES CURSOS(Codigo)
);