Create schema hotel;
use hotel;

CREATE TABLE  tipo_servicio  (
  NombreSERVICIO  varchar(10) NOT NULL,
  PRIMARY KEY  ( NombreSERVICIO )
) ;

CREATE TABLE  paises  (
  pais  varchar(20) NOT NULL,
  PRIMARY KEY  ( pais )
) ;

CREATE TABLE clientes (
   Identificacion  varchar(12) NOT NULL,
   Pais  varchar(20) NOT NULL,
   Nombre  varchar(25) NOT NULL,
   Apellido1  varchar(20) NOT NULL,
   Apellido2  varchar(20) ,
   Direccion  varchar(30) NOT NULL,
   Telefono  varchar(12) NOT NULL,
   Observaciones  varchar(50) ,
  PRIMARY KEY  ( Identificacion ),
  FOREIGN KEY  (Pais) references paises (pais) );

CREATE TABLE  tipo_habitacion  (
   Categoria   int NOT NULL ,
   Camas  int  NOT NULL,
   Exterior  varchar(2) NOT NULL check (Exterior in ('SI', 'NO')),
   Salon  varchar(2) NOT NULL check (Salon in ('SI', 'NO')),
   Terraza  varchar(2) NOT NULL check (Terraza in ('SI', 'NO')),
  PRIMARY KEY  ( Categoria )
) ;

CREATE TABLE  habitaciones  (
  NumHABITACION  int  NOT NULL,
  TIPO_HABITACION  int NOT NULL,
  PRIMARY KEY  ( NumHABITACION ),
  Foreign key (tipo_habitacion) references tipo_habitacion ( Categoria )
) ;

CREATE TABLE  servicios  (
   idSERVICIOS  int NOT NULL ,
   NombreSERVICIO  varchar(10) NOT NULL,
   Descripcion  varchar(30) NOT NULL,
   Precio  float NOT NULL,
   IVA  numeric (5,2) NOT NULL,
   Fecha  date NOT NULL,
  PRIMARY KEY  ( idSERVICIOS ),
  foreign key (nombreServicio) references tipo_servicio ( NombreSERVICIO )
) ;

CREATE TABLE  temporada  (
   TEMPORADA  int NOT NULL ,
   FechaINICIO  date NOT NULL,
   FechaFINAL  date NOT NULL,
   Tipo  varchar(1) not null check (tipo in ('B','M','A')) ,
  PRIMARY KEY  ( TEMPORADA )
) ;

CREATE TABLE  precio_habitacion  (
   idPrecio  int NOT NULL ,
   Precio  float NOT NULL,
   TEMPORADA int NOT NULL,
   TIPO_HABITACION  int NOT NULL,
  PRIMARY KEY  ( idPrecio ),
  foreign key (temporada) references temporada(temporada),
  foreign key (tipo_habitacion) references tipo_habitacion(categoria )
) ;

CREATE TABLE  reserva_habitac  (
   idRESERVA  int auto_increment NOT NULL ,
   FechaENTRADA  date NOT NULL,
   FechaSALIDA  date NOT NULL,
   IVA  float NOT NULL,
   NumHABITACION  int NOT NULL,
   CLIENTE  varchar(12) NOT NULL,
   PRIMARY KEY  ( idRESERVA )  ,
   foreign KEY  (cliente) references CLIENTES (Identificacion ),
  foreign key (numHabitacion) references HABITACIONES (NumHABITACION )
) ;

CREATE TABLE  gastos  (
   idGASTOS  int auto_increment NOT NULL ,
   idRESERVA  int NOT NULL,
   idSERVICIOS  int NOT NULL,
   Fecha  datetime NOT NULL,
   Cantidad  int NOT NULL, 
   Precio float  not null,
  PRIMARY KEY  (idGASTOS ),
  foreign KEY  (idreserva) references reserva_habitac  (idREserva ),
  foreign key (idservicios ) references SERVICIOS (idSERVICIOS )
)  ;

/*	Escribir el procedimento o funcion que permita incrementar un 15% el precio de las habitaciones 
que tengan Terraza y sean Exteriores. */

/* Escribir el procedimiento o funcion que permita dar de baja todos aquellos servicios que no han sido
 nunca utilizados por ningún cliente. */

/* Escribir el procedimiento o funcion que permita pasando como parámetro el tipo de servicio obtener el 
importe total facturado*/ 

/* Escribir el procedimiento o funcion que permita pasando como parámetro el nombre del cliente obtener
 importe total facturado*/ 

/* Escribir el procedimiento o funcion que permita pasando como parámetro el nombre de un pais obtener
el numero total de reservas realizadas*/ 

/* Escribir el procedimiento o funcion que permita pasando como parámetro el tipo de servicio actualizar 
el precio de los servicios del mismo tipo, debo poder obtener al final cuantos servicios se han actualizado*/  