create schema empleados2;
use empleados2;

CREATE TABLE Departamento (
codDepto varchar (4) PRIMARY KEY,
nombreDpto varchar (20) NOT NULL,
ciudad varchar (15),
codDirector varchar (12)
);

CREATE TABLE Empleado (
nDIEmp VARCHAR( 12 ) NOT NULL PRIMARY KEY,
nomEmp VARCHAR( 30 ) NOT NULL ,
sexEmp CHAR( 1 ) NOT NULL CHECK (sexEmp='F'or sexEmp='M') ),
fecNac DATE NOT NULL ,
fecIncorporacion DATE NOT NULL,
salEmp FLOAT NOT NULL,
comisionE FLOAT NOT NULL,
cargoE VARCHAR( 15 ) NOT NULL,
jefeID VARCHAR( 12 ),
codDepto VARCHAR( 4 ) NOT NULL,
CONSTRAINT FK_Empl FOREIGN KEY (jefeID) REFERENCES Empleado(nDIEmp),
CONSTRAINT FK_Dpto FOREIGN KEY (codDepto) REFERENCES Departamento(codDepto)
);


ALTER TABLE Empleado ADD CONSTRAINT sexoempleado CHECK(sexEmp IN ('F', 'M'));









INSERT INTO Departamento (codDepto, nombreDpto, ciudad, coddirector) VALUES
('1000', 'GERENCIA', 'ZARAGOZA', '31840269'),
('1500', 'PRODUCCIÓN', 'ZARAGOZA', '16211383'),
('2000', 'VENTAS', 'ZARAGOZA', '31178144'),
('3000', 'INVESTIGACIÓN', 'ZARAGOZA', '16759060'),
('3500', 'DISEÑO', 'ZARAGOZA', '22222222'),
('2100', 'VENTAS', 'TERUEL', '31751219'),
('2200', 'VENTAS', 'ALCAÑIZ', '768782'),
('2300', 'VENTAS', 'CALANDA', '737689'),
('4000', 'MANTENIMIENTO', 'TERUEL', '333333333'),
('4100', 'MANTENIMIENTO', 'ZARAGOZA', '888888'),
('4200', 'MANTENIMIENTO', 'ALCAÑIZ', '11111111'),
('4300', 'MANTENIMIENTO', 'CALANDA', '444444');

INSERT INTO Empleado (nDIEmp, nomEmp, sexEmp, fecNac, fecIncorporacion, salEmp, comisionE, cargoE, jefeID, codDepto)
VALUES
('31840269', 'María Rojas', 'F', '1959-01-15', '1990-05-16', 6250000, 1500000, 'Gerente', NULL, '1000'),
('16211383', 'Luis Pérez', 'M', '1956-02-25', '2000-01-01', 5050000, 0, 'Director', '31840269', '1500'),
('31178144', 'Rosa Angulo', 'F', '1957-03-15', '1998-08-16', 3250000, 3500000, 'Jefe Ventas', '31840269', '2000'),
('16759060', 'Darío Casas', 'M', '1960-04-05', '1992-11-01', 4500000, 500000, 'Investigador', '31840269', '3000'),
('22222222', 'Carla López', 'F', '1975-05-11', '2005-07-16', 4500000, 500000, 'Jefe Mercadeo', '31840269', '3500'),
('22222333', 'Carlos Rozo', 'M', '1975-05-11', '2001-09-16', 750000, 500000, 'Vigilante', '31840269', '3500') ,
('1751219', 'Melissa Roa', 'F', '1960-06-19', '2001-03-16', 2250000, 2500000, 'Vendedor', '31178144', '2100'),
('768782', 'Joaquín Rosas', 'M', '1947-07-07', '1990-05-16', 2250000, 2500000, 'Vendedor', '31178144', '2200'),
('737689', 'Mario Llano', 'M', '1945-08-30', '1990-05-16', 2250000, 2500000, 'Vendedor', '31178144', '2300'),
('333333333', 'Elisa Rojas', 'F', '1979-09-28', '2004-06-01', 3000000, 1000000, 'Jefe Mecánicos', '31840269', '4000'),
('888888', 'Iván Duarte', 'M', '1955-08-12', '1998-05-16', 1050000, 200000, 'Mecánico', '333333333', '4100'),
('11111111', 'Irene Díaz', 'F', '1979-09-28', '2004-06-01', 1050000, 200000, 'Mecánico', '333333333', '4200'),
('444444', 'Abel Gómez', 'M', '1939-12-24', '2000-10-01', 1050000, 200000, 'Mecánico', '333333333', '4300'),
('1130222', 'José Giraldo', 'M', '1985-01-20', '2000-11-01', 1200000, 400000, 'Asesor', '22222222', '3500'),
('19709802', 'William Daza', 'M', '1982-10-09', '1999-12-16', 2250000, 1000000,'Investigador', '16759060', '3000'),
('31174099', 'Diana Solarte', 'F', '1957-11-19', '1990-05-16', 1250000, 500000, 'Secretaria', '31840269', '1000'),
('1130777', 'Marcos Cortez', 'M', '1986-06-23', '2000-04-16', 2550000, 500000, 'Mecánico', '333333333', '4000'),
('1130782', 'Antonio Gil', 'M', '1980-01-23', '2010-04-16', 850000, 1500000, 'Técnico', '16211383', '1500'),
('333333334', 'Marisol Pulido', 'F', '1979-10-01', '1990-05-16', 3250000, 1000000, 'Investigador', '16759060', '3000'),
('333333335', 'Ana Moreno', 'F', '1992-01-05', '2004-06-01', 1200000, 400000, 'Secretaria', '16759060', '3000'),
('1130333', 'Pedro Blanco', 'M', '1987-10-28', '2000-10-01', 800000, 3000000, 'Vendedor', '31178144', '2000'),
('1130444', 'Jesús Alfonso', 'M', '1988-03-14', '2000-10-01', 800000, 3500000, 'Vendedor', '31178144', '2000'),
('333333336', 'Carolina Ríos', 'F', '1992-02-15', '2000-10-01', 1250000, 500000, 'Secretaria', '16211383', '1500'),
('333333337', 'Edith Muñoz', 'F', '1992-03-31', '2000-10-01', 800000, 3600000, 'Vendedor', '31178144', '2100'),
('1130555', 'Julián Mora', 'M', '1989-07-03', '2000-10-01', 800000, 3100000, 'Vendedor', '31178144', '2200'),
('1130666', 'Manuel Millán', 'M', '1990-12-08', '2004-06-01', 800000, 3700000, 'Vendedor', '31178144', '2300');