-- Triggers: 

/* Por favor, considerar que antes de poblar las tablas, hay que accionar los triggers y los stored procedures, ya que por simpleza, se optó por usar los triggers para hacer las inserciones.
Luego de poblar las tablas, se pueden probar los triggers, stored procedures, vistas y funciones con los ejemplos que se proveen. */

/* 1. Creamos otro trigger para buscar el descuento de la promoción, con el id_promo. Debe revisar si la promoción está o no activa. 
Con el objetivo de corroborar que la promoción esté activa y evitar errores en los descuentos.
Actúa al ingresar una venta en la tabla de 'ventas'.
*/

USE tcg_store_reyes;

DROP TRIGGER buscar_descuento_aplicado;

DELIMITER //
CREATE TRIGGER buscar_descuento_aplicado
BEFORE INSERT ON ventas
FOR EACH ROW 
BEGIN
	DECLARE descuento_aplicado_promo DECIMAL (3,2);
    DECLARE v_estado_promo INT;

		SELECT porcentaje_promo, estado
		INTO descuento_aplicado_promo, v_estado_promo
		FROM promociones
		WHERE id_promo = NEW.id_promo;
        
        IF v_estado_promo = 0 THEN
        		SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'ERROR: promoción no activa';
		ELSE 
	SET NEW.descuento_aplicado = descuento_aplicado_promo;
	END IF;
END//
DELIMITER ;

-- Probamos con una promoción que no esté activa (id_promo = 1):
INSERT INTO ventas (id_cliente, id_producto, cantidad_producto, id_promo, fecha_venta, id_pago, id_empleado)
VALUES (1, 2, 2, 1, CURDATE(), 1, 4);

-- Corroboramos que la promoción no esté activa, donde Estado = 0, significa que no está activa.
SELECT id_promo, estado
FROM promociones
WHERE id_promo = 1;

-- Probamos con una promoción que esté activa, como id_promo = 3:
SELECT id_promo, estado
FROM promociones;

INSERT INTO ventas (id_cliente, id_producto, cantidad_producto, id_promo, fecha_venta, id_pago, id_empleado)
VALUES (1, 2, 2, 3, CURDATE(), 1, 4);

-- Corroboramos que se insertó: 
SELECT *
FROM ventas
WHERE fecha_venta = CURDATE() AND id_producto = 2;


/* 2. Trigger para calcular el precio final de la compra, considerando el precio al que se vendió el producto y la cantidad comprada.
Tiene el objetivo de evitar errores en el tipeo del importe total de las compras.
Se activa al registrar una venta en la tabla 'ventas'
*/

/* 3. Trigger que toma el precio del producto desde la tabla 'productos', identificando el id del producto. 
Tiene el objetivo de evitar errores de tipeo en los precios de los productos. 
Se activa al momento de ingresar una venta en la tabla 'ventas': */

/* Se combinan ambos triggers para asegurar el orden que queremos: */

DROP TRIGGER calcular_precios_venta;

DELIMITER //
CREATE TRIGGER calcular_precios_venta
BEFORE INSERT ON ventas
FOR EACH ROW
BEGIN 
	DECLARE precio_buscado DECIMAL (10,2);
    
    SELECT 	precio_producto
    INTO precio_buscado
    FROM productos
    WHERE id_producto = NEW.id_producto; 
    
    IF precio_buscado IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: No se puede registrar la venta porque el producto no existe.';
    ELSE
		SET NEW.precioOriginal_venta = precio_buscado;
        SET NEW.precioFinal_venta = (NEW.precioOriginal_venta * (1 - IFNULL(NEW.descuento_aplicado, 0)) * NEW.cantidad_producto);
	END IF; 
END //

-- Insertamos datos para comprobar:
INSERT INTO ventas (id_cliente, id_producto, cantidad_producto, id_promo, fecha_venta, id_pago, id_empleado)
VALUES (1, 1, 2, 3, CURDATE(), 1, 4); 

-- Corroboramos:
SELECT *
FROM ventas
WHERE id_producto = 1 AND fecha_venta = CURDATE();


/* 4. Crear un trigger para que calcule la edad al momento de ingresar al cliente en el sistema. 
Con el objetivo de no tener que calcular manualmente la edad de las personas e insertarlo automáticamente en la tabla de 'clientes'.
Comentario para el tutor: Notar que se activa correctamente y funciona, pero aun asi se activa nuevamente y aparece error de sintaxis. Intenté arreglarlo, pero no pude. */
DROP TRIGGER calcular_edad_clientes;

DELIMITER //
CREATE TRIGGER calcular_edad_clientes
BEFORE INSERT ON clientes 
FOR EACH ROW
-- Comprobar si la fecha de cumpleaños es nula o no
	IF NEW.cumpleanos_cliente_ss IS NOT NULL THEN
		SET NEW.edad_cliente = TIMESTAMPDIFF(YEAR, NEW.cumpleanos_cliente_ss, CURDATE());
	END IF;
END//

DLEIMITER ; 

-- Inserción de prueba:
INSERT INTO clientes (nombre_cliente, apellido_cliente, genero_cliente, mail_cliente, telefono_cliente, cumpleanos_cliente_ss, suscrito, id_empleado_sus) 
VALUES
('Baity', 'Bait', 'H', 'baity@gmail.com', '11118888', '1985-06-30', 1, 4);

SELECT edad_cliente
FROM clientes
WHERE mail_cliente = 'baity@gmail.com';

/* 5. Creamos un trigger para hacer una nueva inserción en la tabla 'suscripciones', si el cliente aceptó estar suscrito.
*/

DROP TRIGGER IF EXISTS suscripcion_insercion_cliente;

DELIMITER //
CREATE TRIGGER suscripcion_insercion_cliente
AFTER INSERT ON clientes
FOR EACH ROW
BEGIN
	IF NEW.suscrito = 1 THEN
		INSERT INTO suscripciones (id_cliente, fecha_suscripcion, mail_cliente_sus, cumpleanos_cliente, id_empleado)
			VALUES
				(new.id_cliente, CURDATE(), NEW.mail_cliente, NEW.cumpleanos_cliente_ss, NEW.id_empleado_sus);
	END IF;
END //

INSERT INTO clientes (nombre_cliente, apellido_cliente, genero_cliente, mail_cliente, telefono_cliente, cumpleanos_cliente_ss, suscrito, id_empleado_sus)
VALUES
('Christine', 'Daae', 'M', 'christine@gmail.com', '99978888', '1970-11-30', 1, 4);

-- Chequeamos si la información pasó a la tabla de 'suscripciones':
SELECT *
FROM suscripciones
WHERE mail_cliente_sus = 'christine@gmail.com';

SELECT *
FROM suscripciones;

/* 6. Trigger para llevar los registros de inserción de stock en nuevos productos.
Con el fin de tener un control de los movimientos de stock y de nuevos productos que ingresa en la tabla 'productos'.
Actúa en la tabla de 'historial_stock'
*/

DROP TRIGGER insercion_stock;

CREATE TRIGGER insercion_stock
AFTER INSERT ON productos
FOR EACH ROW
	INSERT INTO historial_stock (id_stock, id_producto, tipoMovimiento_stock, cantidad_stock, fechaMovimiento_stock)
	VALUES
	(DEFAULT, NEW.id_producto, 'entrada', COALESCE(NEW.cantidad_producto, 0), CURDATE());


-- Agregamos un nuevo producto:
-- Recordar activar antes el SP:
DELIMITER // 
CREATE PROCEDURE sp_ingresar_nuevo_producto (IN p_nombre_producto VARCHAR(40), IN p_precio_producto DECIMAL (10,0), p_tipo_producto VARCHAR (40), p_id_franquicia INT, p_imagen_URL VARCHAR(2000), p_costo_producto DECIMAL (10,0), IN p_cantidad_producto INT)
BEGIN
	INSERT INTO productos (nombre_producto, precio_producto, tipo_producto, id_franquicia, imagen_URL, costo_producto, cantidad_producto)
    VALUES
    (p_nombre_producto, p_precio_producto, p_tipo_producto, p_id_franquicia, p_imagen_URL, p_costo_producto, p_cantidad_producto)
;
END//
DELIMITER ;

CALL sp_ingresar_nuevo_producto ('Carta Ditto', 10000, 'Single', 2, NULL, 500, 2);

-- Corroboramos los datos en la tabla 'historial_stock'
SELECT s.id_producto, p.nombre_producto, s.fechaMovimiento_stock, s.cantidad_stock
FROM historial_stock s
INNER JOIN productos p ON s.id_producto = p.id_producto
WHERE p.nombre_producto = 'Carta Ditto';

/* 7. Trigger que adiciona el registro de aumento en stock de productos existentes.
Con el fin de tener un control de los movimientos de stock de productos existentes.
Actúa en la tabla de 'historial_stock'
*/

DROP TRIGGER insercion_stock_existente;

CREATE TRIGGER insercion_stock_existente
AFTER UPDATE ON productos
FOR EACH ROW
	INSERT INTO historial_stock (id_stock, id_producto, tipoMovimiento_stock, cantidad_stock, fechaMovimiento_stock)
	VALUES
	(DEFAULT, NEW.id_producto, 'entrada', COALESCE(NEW.cantidad_producto, 0), CURDATE());

-- Vemos el historial stock para el producto:
SELECT * 
FROM historial_stock
WHERE id_producto = 3;

-- Adicionamos el stock, chequeamos que el cambio haya quedado registrado en la tabla:
CALL sp_ingresar_stock (3, 3);

SELECT * 
FROM historial_stock
WHERE id_producto = 3;



