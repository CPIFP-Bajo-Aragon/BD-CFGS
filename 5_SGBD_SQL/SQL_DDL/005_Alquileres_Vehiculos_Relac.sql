/* listado de relaciones y restricciones */
garaje(cod_g)
PK: {cod_g}

agencia(cod_a) 
PK: {cod_a}

Cliente(cod_cli,dni,direccion,tf,aval)
PK: {cod_cli}
UNIQUE: {dni}
VNN: {direccion, tf}
FK31: {aval} references cliente(cod_cli) on update cascade on delete restrict

Coche(matricula ,marca ,modelo ,garaje)
PK: {matricula}
VNN: {marca, modelo, garaje}
FK41: {garaje} references garaje(cod_g) on update cascade on delete restrict

Reserva(cod_r ,f_i ,f_f ,libro ,indicador ,precio_t ,cod_cli ,cod_a )
PK: {cod_r}
VNN: {libro,indicador,precio_t, f_f, f_i, cod_a, cod_cli}
FK51: {cod_cli} references cliente(cod_cli) on update cascade on delete restrict
FK52: {cod_a} references agencia(cod_a) on update cascade on delete restrict

Involucra( cod_r ,matricula ,p_alquiler) 
PK: {cod_r,matricula}
VNN: {p_alquiler}
FK61: {matricula} references coche(matricula) on update cascade on delete restrict
FK62: {cod_r} references reserva(cod_r) on update cascade on delete restrict
