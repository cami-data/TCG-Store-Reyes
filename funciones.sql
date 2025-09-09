-- Funciones: 

/* Por favor, considerar que antes de poblar las tablas, hay que accionar los triggers y los stored procedures, ya que por simpleza, se optó por usar los triggers para hacer las inserciones.
Luego de poblar las tablas, se pueden probar los triggers, stored procedures, vistas y funciones con los ejemplos que se proveen. */

/* 1. Calcular los ingresos totales de un producto.
Para evaluar las ventas o acciones comerciales, para productos específicos. 
Trabaja en la tabla 'ventas'. */

DROP FUNCTION fn_ingresos_totales_producto;

DELIMITER //
CREATE FUNCTION fn_ingresos_totales_producto(p_id_producto INT)
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE v_total_ingresos INT;
    SELECT 
		IFNULL(SUM(precioFinal_venta), 0)
        INTO v_total_ingresos
        FROM ventas
        WHERE 
        id_producto = p_id_producto;
	RETURN v_total_ingresos;
END //

DELIMITER ;

-- Usamos un producto como prueba:
SELECT fn_ingresos_totales_producto(1) AS ingresos_totales;

-- Corroboramos: 
SELECT id_producto, SUM(precioFinal_venta) as ingresos_totales
FROM ventas
WHERE id_producto = 1;

/* 2. Calcular los días que han transcurrido desde la compra de un cliente en específico.
Para evaluar las ventas o acciones comerciales, para productos clientes en específicos, e ingresar a sus datos fácilmente.
Trabaja en la tabla 'ventas'. */

DELIMITER //
CREATE FUNCTION fn_dias_ultima_compra(p_id_cliente INT)
RETURNS INT
DETERMINISTIC
BEGIN 
		DECLARE dias_ultima_compra INT;
		SELECT DATEDIFF(CURDATE(), MAX(fecha_venta))
		INTO dias_ultima_compra
		FROM ventas
		WHERE p_id_cliente = id_cliente;
    RETURN dias_ultima_compra;
 END //
 
-- Caso de prueba:
SELECT fn_dias_ultima_compra(2) AS dias_ultima_compra;

-- Corroboramos:
SELECT id_cliente, DATEDIFF(CURDATE(), MAX(fecha_venta)) as diferencia_fechas
FROM ventas
WHERE id_cliente = 2;

/* 3. Calcular ingresos de un día en específico.
Útil para dias de alta venta, como Black Friday. 
Trabaja en la tabla 'ventas'. */

DELIMITER //
CREATE FUNCTION fn_ingresos_totales_dia (p_fecha DATE)
RETURNS INT
DETERMINISTIC
BEGIN
		DECLARE ingresos_totales_dia INT;
        SELECT SUM(precioFinal_venta)
        INTO ingresos_totales_dia
        FROM ventas
        WHERE fecha_venta = p_fecha;
	RETURN ingresos_totales_dia;

END//

SELECT *
FROM ventas;
-- Probamos la función:
SELECT fn_ingresos_totales_dia('2025-01-10') AS ingresos_totales_dia;

-- Corroboramos: 
SELECT fecha_venta, SUM(precioFinal_venta)
FROM ventas
WHERE fecha_venta = '2025-01-10';

-- Si queremos ver las ventas de hoy:
SELECT fn_ingresos_totales_dia(CURDATE()) AS ingresos_totales_dia;
