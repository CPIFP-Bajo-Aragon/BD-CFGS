create table cuota(
	cuota_id int,
	cuota float(7,2),
	mayores int,
	menores int
);
create table actividades(
	actividades_id int,
	actividades varchar(300)
);
create table area_recreativa(
	area_recreativa_id int,
	area_recreativa varchar(300),
	tipo_id int,
	descripcion varchar(300)
);
create table facilidades(
	facilidades_id int,
	facilidades varchar(300)
);
create table reservacion_grupo(
	persona_id int,
	nombre varchar(300),
	apellido_paterno varchar(300),
	apellido_materno varchar(300),
	edad int
);
create table area_designada(
	area_designada_id int,
	area_designada varchar(300),
	capacidad_personas int,
	capacidad_casetas int
);
create table reservacion_diaria(
	res_diaria_id int,
	fecha datetime,
	num_res_personas int,
	num_res_casetas int
);
create table reservacion_lugar(
	reservacion_id int,
	fecha_comienzo datetime,
	fecha_final datetime,
	num_personas int
);
create table peticionario(
	peticionario_id int,
	nombre varchar(300),
	apellido_paterno varchar(300),
	apellido_materno varchar(300),
	telefono varchar(9),
	celular varchar(9),
	edad int
);
create table funcionario(
	funcionario_id int,
	nombre varchar(300),
	apellido_paterno varchar(40),
	apellido_materno varchar(40)
);
create table estatus_permiso(
	estatus_id int,
	estatus varchar(15)
);
create table recibo_permiso(
	recibo_permiso_id int
);
create table permisos(
	permisos_id int,
	fecha_inicial datetime,
	fecha_final datetime
);
create table manejador(
	manejador_id int,
	nombre varchar(300)
	apellido_paterno varchar(40),
	apellido_materno varchar(40),
	telefono varchar(9)
);
create table reglamento(
	reglamento_id int,
	reglamento varchar(300),
	actividad_id int
);

ALTER table cuota add constraint cuota_id PRIMARY KEY (cuota_id),
add constraint fk_actividades_id FOREIGN KEY actividades_id REFERENCES actividades (actividades_id);

ALTER table actividades add constraint actividades_id PRIMARY KEY (actividades_id),
add constraint fk_area_designada_id FOREIGN KEY area_designada_id REFERENCES area_designada (area_designada_id);

ALTER table area_recreativa add constraint area_recreativa_id PRIMARY KEY (area_recreativa_id),
add constraint fk_facilidades_id FOREIGN KEY facilidades_id REFERENCES facilidades (facilidades_id);

ALTER table facilidades add constraint facilidades_id PRIMARY KEY (facilidades_id);

ALTER table reservacion_grupo add constraint persona_id PRIMARY KEY (persona_id),
add constraint fk_peticionario_id FOREIGN KEY peticionario_id REFERENCES peticionario (peticionario_id);

ALTER table reservacion_diaria add constraint res_diaria_id (res_diaria_id),
add constraint fk_area_designada_id1 FOREIGN KEY area_designada_id REFERENCES area_designada (area_designada_id);

ALTER table area_designada add constraint area_designada_id (area_designada_id),
add constraint fk_area_recreativa_id FOREIGN KEY area_recreativa_id REFERENCES area_recreativa (area_recreativa_id),
add constraint fk_facilidades_id1 FOREIGN KEY facilidades_id REFERENCES facilidades (facilidades_id);

ALTER table reservacion_lugar add constraint reservacion_id PRIMARY KEY (reservacion_id),
add constraint fk_area_designada_id2 FOREIGN KEY area_designada_id REFERENCES area_designada (area_designada_id),
add constraint fk_peticionario_id1 FOREIGN KEY peticionario_id REFERENCES peticionario (peticionario_id);

ALTER table peticionario add constraint peticionario_id PRIMARY KEY (peticionario_id);

ALTER table funcionario add constraint funcionario_id PRIMARY KEY (funcionario_id);

ALTER table estatus_permiso add constraint estatus_id PRIMARY KEY (estatus_id);

ALTER table recibo_permiso add constraint recibo_permiso_id PRIMARY KEY (recibo_permiso_id),
add constraint fk_peticionario_id2 FOREIGN KEY peticionario_id REFERENCES peticionario (peticionario_id),
add constraint fk_reservacion_id FOREIGN KEY reservacion_id REFERENCES reservacion_lugar (reservacion_id),
add constraint fk_area_designada_id3 FOREIGN KEY area_designada_id REFERENCES area_designada (area_designada_id),
add constraint fk_manejador_id FOREIGN KEY manejador_id REFERENCES manejador (manejador_id),
add constraint fk_reglamento_id FOREIGN KEY reglamento_id REFERENCES reglamento (reglamento_id);

ALTER table permisos add constraint permisos_id PRIMARY KEY (permisos_id),
add constraint fk_funcionario_id FOREIGN KEY funcionario_id REFERENCES funcionario (funcionario_id),
add constraint fk_estatus_id FOREIGN KEY estatus_id REFERENCES estatus_permiso (estatus_id), 
add constraint fk_reservacion_id1 FOREIGN KEY reservacion_id REFERENCES reservacion_lugar (reservacion_id);

ALTER table manejador add constraint manejador_id PRIMARY KEY(manejador_id),
add constraint fk_area_designada_id4 FOREIGN KEY area_designada_id REFERENCES area_designada (area_designada_id);

ALTER table reglamento add constraint reglamento_id PRIMARY KEY (reglamento_id),
add constraint fk_area_designada_id5 FOREIGN KEY area_designada_id REFERENCES area_designada (area_designada_id),
add constraint fk_area_recreativa_id1 FOREIGN KEY area_recreativa_id REFERENCES area_recreativa (area_recreativa_id),
add constraint fk_actividades_id1 FOREIGN KEY actividades_id REFERENCES actividades (actividades_id);