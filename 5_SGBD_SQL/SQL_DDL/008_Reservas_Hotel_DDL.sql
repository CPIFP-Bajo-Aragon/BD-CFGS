/************** SCRIPT CREACION SCHEMA APARTADO A ***********************/
CREATE SCHEMA RESERVAS;
USE RESERVAS;

CREATE TABLE IF NOT EXISTS  TIPO_HABITACION(
	CATEGORIA INT, 
	CAMAS INT NOT NULL,
	EXTERIOR VARCHAR(2) NOT NULL,
	SALON VARCHAR(2) NOT NULL,
	TERRAZA VARCHAR(2) NOT NULL,
	CONSTRAINT PK_HABITACION PRIMARY KEY(CATEGORIA) );

CREATE TABLE IF NOT EXISTS  HABITACIONES(
	NUMHABITACION INT, 
	TIPO_HABITACION INT NOT NULL,
	CONSTRAINT PK_HABITACIONES PRIMARY KEY(NUMHABITACION),
	CONSTRAINT FK_TIPOHABITACION FOREIGN KEY(TIPO_HABITACION) 
	REFERENCES TIPO_HABITACION(CATEGORIA) ON UPDATE CASCADE ON DELETE CASCADE );

CREATE TABLE IF NOT EXISTS  PAISES(
	PAIS VARCHAR(20),
	CONSTRAINT PK_PAISES PRIMARY KEY(PAIS));

CREATE TABLE IF NOT EXISTS  CLIENTES(
	IDENTIFICACION VARCHAR(12),
	PAIS VARCHAR(20),
	NOMBRE VARCHAR(25) NOT NULL,
	APELLIDO1 VARCHAR(20) NOT NULL,
	APELLIDO2 VARCHAR(20),
	DIRECCION VARCHAR(30) NOT NULL,
	TELEFONO VARCHAR(12) NOT NULL,
	OBSERVACIONES VARCHAR(50),
	OBSERVACIONES2 INT,
	CONSTRAINT PK_CLIENTES PRIMARY KEY(IDENTIFICACION),
	CONSTRAINT FK_PAISES FOREIGN KEY(PAIS) REFERENCES PAISES(PAIS) ON UPDATE CASCADE ON DELETE CASCADE );

CREATE TABLE IF NOT EXISTS  RESERVA_HABITAC(
	IDRESERVA INT,
	FECHAENTRADA DATE NOT NULL,
	FECHASALIDA DATE NOT NULL,
	IVA FLOAT NOT NULL,
	NUMHABITACION INT NOT NULL,
	CLIENTE VARCHAR(12) NOT NULL,
	CONSTRAINT PK_RESERVA_HABITAC PRIMARY KEY(IDRESERVA),
	CONSTRAINT FK_HABITACION FOREIGN KEY(NUMHABITACION) REFERENCES HABITACIONES(NUMHABITACION) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_CLIENTE FOREIGN KEY(CLIENTE) REFERENCES CLIENTES(IDENTIFICACION) ON UPDATE CASCADE ON DELETE CASCADE );

CREATE TABLE IF NOT EXISTS TIPO_SERVICIO(
	NOMBRESERVICIO VARCHAR(10),
	CONSTRAINT PK_TIPOSERVICIO PRIMARY KEY(NOMBRESERVICIO));

CREATE TABLE IF NOT EXISTS SERVICIOS(
	IDSERVICIOS INT,
	NOMBRESERVICIO VARCHAR(10) NOT NULL,
	DESCRIPCION VARCHAR(30) NOT NULL,
	PRECIO FLOAT NOT NULL,
	IVA DECIMAL(5,2) NOT NULL,
	FECHA DATE,
	CONSTRAINT PK_SERVICIOS PRIMARY KEY(IDSERVICIOS),
	CONSTRAINT FK_TIPOSERVICIO FOREIGN KEY(NOMBRESERVICIO) REFERENCES TIPO_SERVICIO(NOMBRESERVICIO) ON UPDATE CASCADE ON DELETE CASCADE );

CREATE TABLE  IF NOT EXISTS GASTOS(
	IDGASTOS INT,
	IDRESERVA INT NOT NULL,
	IDSERVICIOS INT NOT NULL,
	FECHA DATETIME NOT NULL,
	CANTIDAD INT NOT NULL,
	PRECIO FLOAT,
	CONSTRAINT PK_GASTOS PRIMARY KEY(IDGASTOS),
	CONSTRAINT FK_RESERVAS FOREIGN KEY(IDRESERVA) REFERENCES RESERVA_HABITAC(IDRESERVA) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_SERVICIOS FOREIGN KEY(IDSERVICIOS) REFERENCES SERVICIOS(IDSERVICIOS) ON UPDATE CASCADE ON DELETE CASCADE );


/************** INSTRUCCIONES MODIFICACION SCHEMA APARTADO B ***********************/
/*** B.1 ****/
ALTER TABLE CLIENTES DROP COLUMN OBSERVACIONES2;

/*** B.2 ****/
ALTER TABLE RESERVA_HABITAC ADD COLUMN  PAGADO BOOLEAN NOT NULL; 

/************** DAR DE ALTA REGISTROS ***********************/
/**** CONSULTA 1  ****/
INSERT INTO PAISES VALUES ('PAIS 1'), ('PAIS 2'), ('PAIS 3');
INSERT INTO CLIENTES VALUES
('C1','PAIS 1','NOMBRE 1','APELLIDO11','APELLIDO21','DIR 1','666666666',''),
('C2','PAIS 1','NOMBRE 2','APELLIDO12','APELLIDO22','DIR 2','777777777',''),
('C3','PAIS 1','NOMBRE 3','APELLIDO13','APELLIDO23','DIR 3','888888888',''),
('C4','PAIS 1','NOMBRE 4','APELLIDO14','APELLIDO24','DIR 4','999999999',''),
('C5','PAIS 1','NOMBRE 5','APELLIDO15','APELLIDO25','DIR 5','555555555','');

insert into tipo_Servicio values('TIPO 1'),('TIPO 2');
insert into servicios values
(1,'TIPO 1','2 noches',100,21,'2020-01-01'),
(2,'TIPO 1','3 noches',200,21,'2020-01-01'),
(3,'TIPO 1','4 noches',300,21,'2020-01-01'),
(4,'TIPO 2','5 noches',400,21,'2020-01-01'),
(5,'TIPO 2','6 noches',500,21,'2020-01-01');