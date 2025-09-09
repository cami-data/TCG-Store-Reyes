-- Stored procedures:

/* Por favor, considerar que antes de poblar las tablas, hay que accionar los triggers y los stored procedures, ya que por simpleza, se optó por usar los triggers para hacer las inserciones.
Luego de poblar las tablas, se pueden probar los triggers, stored procedures, vistas y funciones con los ejemplos que se proveen. */

/*1. Stored procedure para saber cuánto ha comprado un cliente. 
Nos sirve cuando queremos saber cuáles son nuestros clientes más valiosos o que han comprado poco, para realizar acciones comerciales con ellos.
Usa las tablas 'ventas' y 'clientes.'*/

DELIMITER //
CREATE PROCEDURE sp_historial_cliente (IN p_id_cliente INT)
BEGIN
	SELECT c.id_cliente, CONCAT(c.nombre_cliente, ' ', c.apellido_cliente) as 'Nombre_completo', SUM(v.PrecioFinal_venta) as suma_ventas
	FROM ventas v 
	INNER JOIN clientes c on v.id_cliente = c.id_cliente
    WHERE c.id_cliente = p_id_cliente
	GROUP BY c.id_cliente;
END//
DELIMITER ;

CALL sp_historial_cliente (5);

/*2. Stored procedure que nos permita cambiar todos los precios de una franquicia.
Funciona tanto para aumentar precios, como para descontarlos, siempre y cuando sean números enteros.
Útil cuando tenemos descuentos en una sola línea de franquicias y no queremos cambiar todos los precios manualmente.
Usa las tablas 'productos' y 'franquicias.'*/

DELIMITER //
CREATE PROCEDURE sp_cambiar_precios (IN cambio_precio DECIMAL(10,0), IN franquicia_seleccionada_id INT)
BEGIN
	UPDATE productos p
    SET precio_producto = precio_producto + cambio_precio
    WHERE p.id_franquicia = franquicia_seleccionada_id
;
END//
DELIMITER ;

SELECT id_producto, id_franquicia, precio_producto
FROM productos
WHERE id_franquicia = 7;

CALL sp_cambiar_precios(200000,7);

SELECT id_franquicia, id_producto, precio_producto
FROM productos
WHERE id_franquicia = 7;

-- Si queremos devolver los precios a su valor anterior, con un descuento:
CALL sp_cambiar_precios(-200000,7);

SELECT id_franquicia, id_producto, precio_producto
FROM productos
WHERE id_franquicia = 7;

/*3. Stored procedure para ingresar productos, a través de la ventana interactiva. También se puede hacer con CALL (procedure). 
Hace más fácil el ingreso de nuevos productos a la tabla 'productos'.
*/

DELIMITER // 
CREATE PROCEDURE sp_ingresar_nuevo_producto (IN p_nombre_producto VARCHAR(40), IN p_precio_producto DECIMAL (10,0), p_tipo_producto VARCHAR (40), p_id_franquicia INT, p_imagen_URL VARCHAR(2000), p_costo_producto DECIMAL (10,0), IN p_cantidad_producto INT)
BEGIN
	INSERT INTO productos (nombre_producto, precio_producto, tipo_producto, id_franquicia, imagen_URL, costo_producto, cantidad_producto)
    VALUES
    (p_nombre_producto, p_precio_producto, p_tipo_producto, p_id_franquicia, p_imagen_URL, p_costo_producto, p_cantidad_producto)
;
END//
DELIMITER ;

-- Nos aseguramos de que el producto no existe: 
SELECT id_producto
FROM prodcutos
WHERE nombre_producto = 'Carta Articuno';

CALL sp_ingresar_nuevo_producto ('Carta Articuno', 1000, 'Single', 2, NULL, 500, 10);

-- Chequeamos que la inserción se hizo correctamente:
SELECT *
FROM productos
WHERE nombre_producto = 'Carta Articuno';

/*4. Stored procedure para agregar stock a productos existentes.
Hace más fácil el ingreso de nuevo stock en productos ya existentes.
*/

DELIMITER //
CREATE PROCEDURE sp_ingresar_stock (IN p_cantidad_producto INT, IN p_id_producto INT)
BEGIN
UPDATE productos p
SET cantidad_producto = cantidad_producto + p_cantidad_producto
WHERE id_producto = p_id_producto
; 
END//
DELIMITER ;

SELECT id_producto, cantidad_producto
FROM productos
WHERE id_producto = 1;

-- Usamos el SP para ingresar productos y comparamos con el resultado anterior:
CALL sp_ingresar_stock (10, 1);

SELECT id_producto, cantidad_producto
FROM productos
WHERE id_producto = 1;


