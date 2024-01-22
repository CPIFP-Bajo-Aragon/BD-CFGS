create database alquiler;
use alquiler;

create table garaje(
cod_g varchar(20) NOT NULL,
constraint PK_garaje PRIMARY KEY (cod_g)
);

create table agencia(
cod_a varchar(20) not null,
constraint PK_agencia PRIMARY KEY (cod_a)
);

create table cliente(
cod_cli varchar(20) not null,
dni varchar(20) not null,
direccion varchar(20) not null,
tf varchar(20) not null,
aval varchar(20),
constraint PK_cliente PRIMARY KEY (cod_cli),
constraint FK_cliecli FOREIGN KEY (aval) references cliente(cod_cli) on update cascade on delete restrict
);

create table coche(
matricula varchar(20) not null,
marca varchar(20) not null,
modelo varchar(20) not null,
garaje varchar(20) not null,
constraint PK_coche PRIMARY KEY (matricula),
constraint FK_cochgar FOREIGN KEY (garaje) references garaje(cod_g) on update cascade on delete restrict
);

create table reserva(
cod_r varchar(20) not null,
f_i varchar(20) not null,
f_f varchar(20) not null,
libro varchar(20) not null,
indicador varchar(20) not null,
precio_t varchar(20) not null,
cod_cli varchar(20) not null,
cod_a varchar(20) not null,
constraint PK_reserva PRIMARY KEY (cod_r),
constraint FK_resecli FOREIGN KEY (cod_cli) references cliente(cod_cli) on update cascade on delete restrict,
constraint FK_reseage FOREIGN KEY (cod_a) references agencia(cod_a) on update cascade on delete restrict
);

create table involucra(
cod_r varchar(20) not null,
matricula varchar(20) not null,
p_alquiler varchar(20) not null,
constraint PK_involucra PRIMARY KEY (cod_r,matricula),
constraint FK_invococ FOREIGN KEY (cod_r) references coche(matricula) on update cascade on delete restrict,
constraint FK_invores FOREIGN KEY (cod_r) references reserva(cod_r) on update cascade on delete restrict
);