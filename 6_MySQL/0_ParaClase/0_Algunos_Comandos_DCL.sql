CREATE USER 'NOMBRE'@'AMBITO' IDENTIFIED BY 'CONTRASEŅA'; 

CREATE USER 'pepe'@'localhost' IDENTIFIED BY 'pepe'; 
CREATE USER 'pepe'@'%' IDENTIFIED BY 'pepe'; 

GRANT SELECT,CREATE ON PP.* TO web@'%';
GRANT SELECT,CREATE,INSERT ON PP.* TO web@'%';
GRANT SELECT,CREATE,INSERT,DELETE ON PP.* TO web@'%';
GRANT SELECT,CREATE,INSERT,DELETE,UPDATE ON PP.* TO web@'%';
GRANT SELECT,CREATE,INSERT,DELETE,UPDATE,DROP ON PP.* TO web@'%';
GRANT ALL PRIVILEGES ON PP.* TO web@'%';

GRANT GRANT OPTION TO web@'%';

REVOKE DROP, CREATE ON PP.* TO web@'%';


VOLCAR EL CONTENIDO DE UNA BASE DE DATOS:
	MYSQLDUMP -h192.168.4.101 -u smr -p pp>pp_mysql.sql

RESTAURAR EL CONTENIDO DE UNA BASE DE DATOS:
	MYSQL -h192.168.4.101 -u smr -p pp<pp_mysql.sql

