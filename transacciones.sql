-- Transacciones
USE tcg_store_reyes;

/* Por favor, considerar que antes de poblar las tablas, hay que accionar los triggers y los stored procedures, ya que por simpleza, se optó por usar los triggers para hacer las inserciones.
Luego de poblar las tablas, se pueden probar los triggers, stored procedures, vistas y funciones con los ejemplos que se proveen. */

-- Para agregar una nueva venta MANUALMENTE y queramos volver atrás. Además, de que al momento de hacer la transacción, se elimine del stock un producto: 

-- Desactivar los permisos: 
SELECT @@autocommit;
SET @@autocommit = 0;

SET foreign_key_checks = 0;
SET sql_safe_updates = 0;


-- Vision del stock del producto id_producto = 2:
SELECT * 
FROM productos
WHERE id_producto = 2;

-- Insertamos stock en el producto que queremos, con el stored procedure anteriormente creado:
CALL sp_ingresar_stock (10, 2);

SELECT * 
FROM historial_stock
WHERE fechaMovimiento_stock = CURDATE() AND id_producto = 2;

-- Chequeamos el stock del producto:
SELECT * 
FROM productos
WHERE id_producto = 2;

-- Hacemos una inserción de prueba, la que finalmente, borraremos y NO será considerada en los informes:
START TRANSACTION;
	INSERT INTO ventas (id_cliente, id_producto, cantidad_producto, id_promo, fecha_venta, id_pago, id_empleado, descuento_aplicado)
	VALUES (1, 2, 10, 0, CURDATE(), 1, 1, 0);
	UPDATE productos
	SET cantidad_producto = cantidad_producto - 10
	WHERE id_producto = 2;

-- Chequeamos si se realizó la transacción: 
SELECT * 
FROM ventas
WHERE fecha_venta = CURDATE() AND id_producto = 2 AND id_empleado = 1;

-- Chequeamos si bajó la cantidad de producto de 10 a 0.
SELECT * 
FROM productos
WHERE id_producto = 2;

-- Ahora, hacemos un ROLLBACK para deshacer la transacción:
ROLLBACK;

-- Chequeamos si la cantidad volvió a ser 10:
SELECT * 
FROM productos
WHERE id_producto = 2;

-- Y que la venta se borró del sistema:
SELECT * 
FROM ventas
WHERE fecha_venta = CURDATE() AND id_producto = 2 AND id_empleado = 1;

/* En este caso, como queremos que esta sea una inserción manual sin el stored procedure, dejamos fuera el commit, ya que queremos que si 
alguien se equivoca, use el rollback. Además, se deja fuera la transacción, ya que no queremos afectar los otros datos para los informes ya realizados.

COMMIT;
*/

-- Activar los permisos: 
SELECT @@autocommit;
SET @@autocommit = 1;

SET foreign_key_checks = 1;
SET sql_safe_updates = 1;



