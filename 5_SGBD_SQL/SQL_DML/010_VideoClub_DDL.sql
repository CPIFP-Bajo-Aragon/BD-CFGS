DROP SCHEMA IF EXISTS `videoclub` ;
CREATE SCHEMA IF NOT EXISTS `videoclub` ;
USE `videoclub` ;

DROP TABLE IF EXISTS `clientes` ;
CREATE TABLE IF NOT EXISTS `clientes` (
  `idcliente` INT NOT NULL,
  `nombre` VARCHAR(50)  NOT NULL,
  `apellido` VARCHAR(50)  NOT NULL,
  `telefono` VARCHAR(50)  NOT NULL,
  `direccion` VARCHAR(50)  NOT NULL,
  `dni` VARCHAR(50)  NOT NULL,
  `estado` VARCHAR(50)  NOT NULL DEFAULT 'ACTIVO',
  PRIMARY KEY (`idcliente`))
ENGINE = InnoDB;


DROP TABLE IF EXISTS `generos` ;
CREATE TABLE IF NOT EXISTS `generos` (
  `idgenero` INT NOT NULL,
  `nomgenero` VARCHAR(50)  NOT NULL,
  PRIMARY KEY (`idgenero`))
ENGINE = InnoDB;

DROP TABLE IF EXISTS `peliculas` ;
CREATE TABLE IF NOT EXISTS `peliculas` (
  `idpelicula` INT NOT NULL,
  `idgenero` INT NOT NULL,
  `nombrepeli` VARCHAR(50)  NOT NULL,
  `detalle` VARCHAR(200)  NOT NULL,
  `protagonista` VARCHAR(200)  NOT NULL,
  `precio` DOUBLE NOT NULL DEFAULT '30',
  `estado` VARCHAR(50)  NOT NULL DEFAULT 'DISPONIBLE',
  PRIMARY KEY (`idpelicula`),
  CONSTRAINT `fk_pel_gen` FOREIGN KEY (`idgenero`) REFERENCES `generos` (`idgenero`))
ENGINE = InnoDB;

DROP TABLE IF EXISTS `usuarios` ;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `idusuario` INT NOT NULL ,
  `nomusuario` VARCHAR(50)  NOT NULL,
  `password` VARCHAR(50)  NOT NULL,
  PRIMARY KEY (`idusuario`))
ENGINE = InnoDB;

DROP TABLE IF EXISTS `alquileres` ;
CREATE TABLE IF NOT EXISTS `alquileres` (
  `idalquiler` INT NOT NULL AUTO_INCREMENT,
  `idcliente` INT NOT NULL,
  `idpelicula` INT NOT NULL,
  `precio` DOUBLE NOT NULL DEFAULT '30',
  `fechaalquiler` TIMESTAMP NOT NULL,
  `usuarios_idusuario` INT NOT NULL,
  PRIMARY KEY (`idalquiler`),
  CONSTRAINT `FK_alquileres_clientes`
    FOREIGN KEY (`idcliente`)
    REFERENCES `clientes` (`idcliente`),
  CONSTRAINT `FK_alquileres_peliculas` FOREIGN KEY (`idpelicula`) REFERENCES `peliculas` (`idpelicula`),
  CONSTRAINT `fk_alquileres_usuarios1` FOREIGN KEY (`usuarios_idusuario`) REFERENCES `usuarios` (`idusuario`))
ENGINE = InnoDB;

--
-- Volcado de datos para la tablas
--

INSERT INTO `clientes` (`idcliente`, `nombre`, `apellido`, `telefono`, `direccion`, `dni`, `estado`) VALUES
(1, 'DIEGO', 'PENNISI', '4584463', 'PROVINCIAS UNIDAS 921 BIS', '29415803', 'ACTIVO'),
(2, 'BIANCA', 'ANIDUZZI', '152203458', 'PROVINCIAS UNIDAD 921 BIS', '37525717', 'ACTIVO'),
(3, 'TOMAS  ', 'PENNISI', '3414592446', 'POLONIA 1440', '51587903', 'ACTIVO'),
(4, 'SILVIA HERMINIA  ', 'CORDA', '13478900', 'CORRIENTES 567', '12525885', 'ACTIVO'),
(5, 'EMANUEL', 'DO', '14325678', 'POLONIA 1440', '28765340', 'ACTIVO'),
(6, 'GERARDO', 'MUÑOZ', '13478900', 'puig roig 8 ', '24322674', 'ACTIVO'),
(7, 'BELEN', 'ALVAREZ', '13478901', 'puig roig 18 ', '24322678', 'ACTIVO');


INSERT INTO `generos` (`idgenero`, `nomgenero`) VALUES
(1, 'acción'),
(2, 'animación'),
(3, 'artes marciales'),
(4, 'aventura'),
(5, 'bélico'),
(6, 'biográficas'),
(7, 'ciencia ficción'),
(8, 'comedia'),
(9, 'dibujos animados'),
(10, 'documentales'),
(11, 'drama'),
(12, 'erótico'),
(13, 'fantasía'),
(14, 'histórico'),
(15, 'infantil'),
(16, 'intriga'),
(17, 'musical'),
(18, 'oeste'),
(19, 'policíaca'),
(20, 'Thriller'),
(21, 'religioso'),
(22, 'romántico'),
(23, 'terror'),
(24, 'clásicas'),
(25, 'guerra'),
(26, 'drama general'),
(27, 'drama suspenso'),
(28, 'animación computarizada'),
(29, 'drama romance'),
(30, 'horror'),
(31, 'drama comedia'),
(32, 'drama político'),
(33, 'suspense'),
(34, 'Gangsters'),
(35, 'Western'),
(36, 'deportes'),
(37, 'misterio'),
(38, 'drama judicial');

INSERT INTO `usuarios` (`idusuario`, `nomusuario`, `password`) VALUES
(1, 'ADMINISTRADOR', '1234admin'),
(2, 'DIEGO', '1501@Alt'),
(3, 'TOMASAdfmin', 'toto '),
(6, 'Pedro@hotmail.com', '1234@diego ');

INSERT INTO `peliculas` (`idpelicula`, `idgenero`, `nombrepeli`, `detalle`, `protagonista`, `precio`, `estado`) VALUES
(1, 2, 'El Capitan América', 'Muy Buena Película. Oscarizada', 'Jony Deep', 25, 'ALQUILADA'),
(2, 8, 'Tonto y Retonto', 'Exelente', 'Jim Carrey', 30, 'DISPONIBLE'),
(3, 32, 'La Redada', ' La Redada', 'Perry Henrry', 30, 'DISPONIBLE'),
(4, 15, 'Gato con Botas', 'Buena no solo para infantiles', 'Un gato', 25, 'DISPONIBLE'),
(5, 15, 'Toy Story', 'Oscarizada. Buena para niños', 'Un vaquero', 30, 'DISPONIBLE'),
(6, 5, 'Soldado universal', 'Es Un Soldado que se convirtio en Universal', 'Jan Con Van Dam', 30, 'DISPONIBLE'),
(7, 11, 'Rescatando al Soldado Ryan', 'exelente.', 'Tom Hanks', 30, 'DISPONIBLE'),
(8, 11, 'Forest Gump', 'Muy buena. Oscarizada', 'Tom Hanks', 30, 'DISPONIBLE'),
(9, 28, 'Terminator', 'exelente Actuacion', 'Arnol Shewseneger ', 30, 'DISPONIBLE'),
(10, 28, 'Alien', 'exelente Actuacion', 'Sigourney Weaver', 30, 'DISPONIBLE'),
(11, 28, 'Terminator 2', 'mediocre Actuacion', 'Arnol Shewseneger ', 15, 'DISPONIBLE'),
(12, 28, 'Alien: Octavo pasajero', 'exelente Actuacion', 'Sigourney Weaver', 30, 'DISPONIBLE'),
(13, 6, 'La pasión de cristo', 'Mucha sangre', 'ALVARO DAVIS', 30, 'ALQUILADA');

insert into alquileres values 
(1,1,1 ,30,'2022-01-10',6 ),(2,2,1 ,30,'2022-01-12',6 ),
(3,3,1 ,30,'2022-04-10',3 ),(4,6,1 ,20,'2022-04-13',6 ),
(5,5,1 ,30,'2022-06-10',6 ),(6,4,1 ,15,'2022-06-13',3 ),
(7,7,1 ,30,'2022-09-01',2 ),(8,7,1 ,20,'2022-09-10',6 ),
(9,2,1 ,30,'2022-09-12',6 ),(10,3,1 ,30,'2022-10-10',2 ),
(11,4,1 ,30,'2023-01-07',6 ),(12,5,1 ,20,'2022-02-10',3 ),
(13,6,1 ,30,'2023-01-09',3 ),(14,1,1 ,30,'2022-02-14',6 ),
(15,1,1 ,30,'2023-01-13',6 ),(16,4,1 ,15,'2022-02-19',2 ),
(17,3,1 ,30,'2022-11-10',3 ),(18,6,1 ,15,'2022-11-10',6 ),
(19,7,1 ,30,'2022-11-10',6 ),(20,2,1 ,30,'2022-11-10',3 );

