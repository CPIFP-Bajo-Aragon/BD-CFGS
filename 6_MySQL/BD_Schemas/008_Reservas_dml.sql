
INSERT INTO  tipo_servicio  VALUES ('COMEDOR');
	INSERT INTO  tipo_servicio  VALUES ('LAVANDERIA');

	INSERT INTO  paises  VALUES ('ALEMANIA');
	INSERT INTO  paises  VALUES ('ESPAÑA');
	INSERT INTO  paises  VALUES ('FRANCIA');
	INSERT INTO  paises  VALUES ('PORTUGAL');
	 
	INSERT INTO  clientes  VALUES ('12345', 'ESPAÑA', 'Felipe', 'Iglesias', 'López', 'Avda Los Castros, 44', '942344444', 'Buen cliente');
	INSERT INTO  clientes  VALUES ('44444', 'ESPAÑA', 'Luis', 'García', 'García', 'Calle Mayor, 67 ', '942456444', null);
	INSERT INTO  clientes  VALUES ('456789', 'FRANCIA', 'Ludovic', 'Giuly', 'Bourquin', '18 avenue Alsacen Cour', '37890194', null);

	INSERT INTO  tipo_habitacion  VALUES (1, 1, 'SI', 'NO', 'NO');
	INSERT INTO  tipo_habitacion  VALUES (2, 2, 'SI', 'NO', 'NO');
	INSERT INTO  tipo_habitacion  VALUES (3, 3, 'SI', 'NO', 'NO');
	INSERT INTO  tipo_habitacion  VALUES (4, 1, 'SI', 'SI', 'NO');

	INSERT INTO  habitaciones  VALUES (101, 1,30);
	INSERT INTO  habitaciones  VALUES (102, 1,45);
	INSERT INTO  habitaciones  VALUES (103, 1,30);
	INSERT INTO  habitaciones  VALUES (104, 2,60);
	INSERT INTO  habitaciones  VALUES (105, 2,50);
	INSERT INTO  habitaciones  VALUES (106, 3,25);
	INSERT INTO  habitaciones  VALUES (107, 4,30);

	INSERT INTO  servicios  VALUES (1, 'COMEDOR', '1 menu del Dia', 10, 7, '2009-01-01');
	INSERT INTO  servicios  VALUES (2, 'LAVANDERIA', 'Lavado de Camisa', 2, 7, '2009-01-01');
	INSERT INTO  servicios  VALUES (3, 'LAVANDERIA', 'Lavado de pantalon', 1, 7, '2009-01-01');

	INSERT INTO  reserva_habitac (IDRESERVA, FechaENTRADA , FechaSALIDA  , IVA , NumHABITACION  , CLIENTE) VALUES (1, '2009-03-15', '2009-03-25', 0.07,101, '12345');
	INSERT INTO  reserva_habitac (IDRESERVA, FechaENTRADA , FechaSALIDA  , IVA , NumHABITACION  , CLIENTE) VALUES (2, '2009-03-15', '2009-03-25', 0.07, 102, '12345');
	INSERT INTO  reserva_habitac (IDRESERVA, FechaENTRADA , FechaSALIDA  , IVA , NumHABITACION  , CLIENTE)  VALUES (3, '2009-02-16', '2009-02-21', 0.07,103, '12345');
	INSERT INTO  reserva_habitac (IDRESERVA, FechaENTRADA , FechaSALIDA  , IVA , NumHABITACION  , CLIENTE) VALUES (4, '2009-03-16', '2009-03-21', 0.07,104, '44444');
	INSERT INTO  reserva_habitac (IDRESERVA, FechaENTRADA , FechaSALIDA  , IVA , NumHABITACION  , CLIENTE)  VALUES (5, '2009-03-16', '2009-03-21', 0.07,105, '44444');
	INSERT INTO  reserva_habitac (IDRESERVA, FechaENTRADA , FechaSALIDA  , IVA , NumHABITACION  , CLIENTE) VALUES (6, '2009-03-16', '2009-03-21', 0.07,106, '44444');
	INSERT INTO  reserva_habitac (IDRESERVA, FechaENTRADA , FechaSALIDA  , IVA , NumHABITACION  , CLIENTE)  VALUES (7, '2009-03-16', '2009-03-21', 0.07,107, '44444');

	INSERT INTO  gastos  ( idgastos,idRESERVA  , idSERVICIOS  ,Fecha ,Cantidad ,Precio) VALUES (1,1,1, '2009-03-15 12:00', 1,10);
	INSERT INTO  gastos  ( idgastos,idRESERVA  , idSERVICIOS  ,Fecha ,Cantidad ,Precio) VALUES (2, 1,1,  '2009-03-15 11:00', 1,10);
	INSERT INTO  gastos  (idgastos, idRESERVA  , idSERVICIOS  ,Fecha ,Cantidad ,Precio) VALUES (3, 4, 2, '2009-03-15 09:30', 1,2);
