-- DCL: Creación de  usuarios y permisos .
USE tcg_store_reyes;

-- Creamos un usuario para marketing, que solo pueda ver la tabla de ventas: 
DROP USER 'marketing'@'localhost';
CREATE USER 'marketing'@'localhost' IDENTIFIED BY 'marketing123';

-- Asignar permiso para hacer consultas a la tabla 'ventas':
GRANT SELECT ON tcg_store_reyes.ventas TO 'marketing'@'localhost';

-- Crearemos además un usuario para la jefa del local: 
DROP USER 'jefalocal'@'localhost';
CREATE USER 'jefalocal'@'localhost' IDENTIFIED BY 'Contraseñasegura123';

-- Asignaremos permisos completos a esta usuaria:
GRANT ALL ON tcg_store_reyes.* TO 'jefalocal'@'localhost';

-- Vemos si la creación fue exitosa:
SHOW GRANTS FOR 'jefalocal'@'localhost';
SHOW GRANTS FOR 'marketing'@'localhost';
