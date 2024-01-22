/* CREACION DE LAS TABLAS */
DROP TABLE IF EXISTS usuarios;
CREATE TABLE usuarios(
id int auto_increment primary key, 
user varchar(50) not null default '', 
password varchar(25)
);

DROP TABLE IF EXISTS log_usuarios;
CREATE TABLE log_usuarios(
id int auto_increment primary key,
fecha timestamp, 
action varchar(255) not null default '', 
event varchar(15));

/* CREACION TRIGGER PARA INSERCION */
drop trigger IF exists LOG_USER_INSERT;
CREATE TRIGGER LOG_USER_INSERT after insert ON usuarios FOR EACH ROW 
INSERT INTO log_usuarios VALUES('0', sysdate(),CONCAT('Alta del ususario ', NEW.user ,' ',NEW.password), 'INSERT');


/* CREACION TRIGGER PARA ELIMINACION */
drop trigger IF exists LOG_USER_DELETE;
CREATE TRIGGER LOG_USER_DELETE after delete ON usuarios FOR EACH ROW 
INSERT INTO log_usuarios VALUES('0', sysdate(),concat('Baja del ususario ', OLD.user), 'DELETE');

/* CREACION TRIGGER PARA ACTUALIZACION PASSWORD */
drop trigger IF exists LOG_USER_UPDATE;
CREATE TRIGGER LOG_USER_UPDATE after update ON usuarios FOR EACH ROW 
INSERT INTO log_usuarios VALUES('0', sysdate(),concat('Actualizacion password del ususario ', NEW.user , ' de ', OLD.password , ' a ', NEW.password), 'UPDATE');

delete from usuarios;
SELECT * FROM log_usuarios;
SELECT * FROM usuarios;
INSERT INTO usuarios VALUES(1, 'usuario 1', 'pass 1');
INSERT INTO usuarios VALUES(2, 'usuario 2', 'pass 2');
INSERT INTO usuarios VALUES(3, 'usuario 3', 'pass 3');
INSERT INTO usuarios VALUES(4, 'usuario 4', 'pass 4');
INSERT INTO usuarios VALUES(5, 'usuario 5', 'pass 5');
INSERT INTO usuarios VALUES(6, 'usuario 6', 'pass 6');
SELECT * FROM log_usuarios;

DELETE FROM usuarios where id='3';
UPDATE usuarios SET password='nuevo password';
SELECT * FROM log_usuarios;