

/*********************  OPCION 1 - DEFINIMOS LAS RESTRICCIONES A NIVEL DE CAMPO ***************************/
Create table CLIENTE (
	DNI Varchar(20) PRIMARY KEY,
	NOMBRE Varchar(50) NOT NULL,
	DIRECCION Varchar(20) NOT NULL
 ) ;
 
Create table VEHICULO (
	MATRICULA Varchar(7) PRIMARY KEY,
	MARCA Varchar(20) NOT NULL,
	MODELO Varchar(20) NOT NULL,
	COLOR Varchar(20) NOT NULL,
	POTENCIA Int NOT NULL,
	DNI Varchar(20) NOT NULL,
	Foreign Key (DNI) references CLIENTE (DNI) on delete  RESTRICT on update  CASCADE
 ) ;

 DROP TABLE VEHICULO;
 DROP TABLE CLIENTE;

 
 
 /*******************OPCION 2 - DEFINIMOS LAS RESTRICCIONES AL FINAL DE LA ESTRUCTURA DE LA TABLA **/

 Create table CLIENTE (
	DNI Varchar(20) NOT NULL,
	NOMBRE Varchar(50) NOT NULL,
	DIRECCION Varchar(20) NOT NULL,
	Primary Key (DNI)
 ) ;
 
 
 Create table VEHICULO (
	MATRICULA Varchar(7) NOT NULL,
	MARCA Varchar(20) NOT NULL,
	MODELO Varchar(20) NOT NULL,
	COLOR Varchar(20) NOT NULL,
	POTENCIA Int NOT NULL,
	DNI Varchar(20) NOT NULL,
	primary Key (MATRICULA),
	Foreign Key (DNI) references CLIENTE (DNI) on delete  RESTRICT on update  CASCADE
) ;

 
 /*******************OPCION 3 - ESTABLECEMOS UN NOMBRE A LAS RESTRICCIONES - SIEMPRE AL FINAL DE LA TABLA **/
 
 Create table CLIENTE (
	DNI Varchar(20) NOT NULL,
	NOMBRE Varchar(50) NOT NULL,
	DIRECCION Varchar(20) NOT NULL,
	CONSTRAINT PK_CLIENTE Primary Key (DNI)
) ;
 
 
Create table VEHICULO (
	MATRICULA Varchar(7) NOT NULL,
	MARCA Varchar(20) NOT NULL,
	MODELO Varchar(20) NOT NULL,
	COLOR Varchar(20) NOT NULL,
	POTENCIA Int NOT NULL,
	DNI Varchar(20) NOT NULL,
	CONSTRAINT PK_VEHICULO Primary Key (MATRICULA),
	CONSTRAINT FK_VEHICULO Foreign Key (DNI) references CLIENTE (DNI) on delete  RESTRICT on update  CASCADE
) ;


 /*******************OPCION 4 - AÑADIMOS LAS RESTRICCIONES UNA VEZ CREADA LA ESTRUCTURA DE CADA TABLA ***********/
Create table VEHICULO (
	MATRICULA Varchar(7) NOT NULL,
	MARCA Varchar(20) NOT NULL,
	MODELO Varchar(20) NOT NULL,
	COLOR Varchar(20) NOT NULL,
	POTENCIA Int NOT NULL,
	DNI Varchar(20) NOT NULL,
 Primary Key (MATRICULA));

Create table CLIENTE (
	DNI Varchar(20) NOT NULL,
	NOMBRE Varchar(50) NOT NULL,
	DIRECCION Varchar(20) NOT NULL,
 Primary Key (DNI));

 Alter table CLIENTE add CONSTRAINT PK_CLIENTE PRIMARY Key (DNI);
 Alter table VEHICULO add CONSTRAINT PK_VEHICULO PRIMARY Key (MATRICULA);
 Alter table VEHICULO add CONSTRAINT FK_CLIENTE Foreign Key (DNI) references CLIENTE (DNI) on delete  restrict on update  restrict;