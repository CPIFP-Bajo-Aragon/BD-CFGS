'Una tabla con nombres de estados';
create table `nombre_db`.`estados` (
    `estado_id` int(11) unsigned not null auto_increment,
    `estado_nombre` varchar(15) not null,
    primary key (`estado_id`)
) engine = myisam character set utf8 collate utf8_general_ci ;

insert into `estados` (`estado_nombre`) values
( 'Jalisco'),
( 'Guanajuato'),
( 'Hidalgo');

'Una tabla con ciudades y sus poblaciones';
create table `nombre_db`.`ciudades` (
    `ciudad_id` int(11) unsigned not null auto_increment,
    `ciudad_nombre` varchar(20) not null,
    `ciudad_poblacion` int(8) unsigned not null,
    `estado_id` int(11) unsigned not null,
    primary key (`ciudad_id`),
    index (`estado_id`)
) engine = myisam character set utf8 collate utf8_general_ci ;

insert into `ciudades` (`ciudad_nombre`, `ciudad_poblacion`, `estado_id`) values
('Guadalajara', '1494134', '1'),
('Tequila', '33155', '1'),
('Zapopan', '1243538', '1'),
('Tonalá', '408729', '1'),
('Tlaquepaque', '563006', '1'),
('Guanajuato', '171709', '2'),
('Celaya', '468064', '2'),
('León', '1436733', '2'),
('Pachuca', '275578', '3'),
('Tizayuca', '100562', '3');

