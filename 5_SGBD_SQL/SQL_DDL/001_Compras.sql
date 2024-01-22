create schema compras;
use compras;

DROP TABLE IF EXISTS articulo;
CREATE TABLE articulo (
  codart int NOT NULL,
  nombre varchar(25) NOT NULL,
  marca varchar(25) NOT NULL,
  modelo varchar(25) NOT NULL,
  vendible tinyint NOT NULL,
  precio float not null,
  PRIMARY KEY (codart)
) ENGINE=InnoDB ;

DROP TABLE IF EXISTS cliente;
CREATE TABLE cliente (
  dni varchar(9) NOT NULL,
  nombre varchar(25) NOT NULL,
  apellidos varchar(50) NOT NULL,
  direccion varchar(50) NOT NULL,
  cp int NOT NULL,
  poblacion varchar(25) NOT NULL,
  email varchar(35) DEFAULT NULL,
  PRIMARY KEY (dni)
) ENGINE=InnoDB ;

DROP TABLE IF EXISTS compra;
CREATE TABLE compra (
  dni_a varchar(9) NOT NULL,
  cod_articulo int NOT NULL,
  fecha_compra varchar(25) NOT NULL,
  pagado tinyint DEFAULT NULL,
  precio float NOT NULL,
  descuento int DEFAULT NULL,
  unidades int NOT NULL,
  CONSTRAINT pkcomp PRIMARY KEY (dni_a,cod_articulo,fecha_compra ),
  CONSTRAINT fkart FOREIGN KEY (cod_articulo) REFERENCES articulo (codart),
  CONSTRAINT fkcli FOREIGN KEY (dni_a) REFERENCES cliente (dni)
) ENGINE=InnoDB ;


use compras;
delete from compra;
delete from articulo;
delete from cliente;

insert into articulo (codart, nombre, marca, modelo, vendible, precio) 
values (1, 'zapatillas air jordan', 'nike', 'air', 1, 50); 
insert into articulo (codart, nombre, marca, modelo, vendible, precio) 
values (2, 'zapatillas air magic', 'addidas', 'magic', 1, 50); 
insert into articulo values (3, 'zapatillas messi', 'adidas', 'messi', 1, 50); 
insert into articulo values (4, 'zapatillas ronaldo', 'nike', 'ronaldo', 1, 50); 

INSERT INTO cliente 
VALUES ('13259192y','jose','varios','calle arriba',44600,'alcañiz','a@a.es'),
('73028814Z','Manuel','Diaz Melendez','Calle mar',50018,'Zaragoza','Manuel@email.com'),
('73029913Z','Alejandro','Artal Falcon','Calle Berenfue',50784,'Zaragoza','email@email.com'),
('73345913Z','Francisco','Gimenez Ramirez','Calle Luz',50017,'Zaragoza','fran@email.com'),
('73458145Z','Manolo','El del bombo','Calle Toledo',50018,'Zaragoza','Eldelbombo@email.com'),
('86458146Z','Julia','Marquez Pastor','Calle laguna',50018,'Logroño','julita@email.com');

INSERT INTO compra VALUES ('13259192y',1,'2022-02-02',0,70,0,2),
('13259192y',2,'2022-02-02',1,10,10,30),
('13259192y',3,'2022-02-15',1,12,3,10),
('13259192y',4,'2022-02-15',0,14,2,15),
('73029913Z',1,'2022-02-15',0,70,4,5),
('73029913Z',3,'2022-02-15',0,12,6,3),
('73458145Z',3,'2022-02-15',1,12,0,9),
('73458145Z',4,'2022-02-15',1,14,20,140);