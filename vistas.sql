-- Vistas: 

/* Por favor, considerar que antes de poblar las tablas, hay que accionar los triggers y los stored procedures, ya que por simpleza, se optó por usar los triggers para hacer las inserciones.
Luego de poblar las tablas, se pueden probar los triggers, stored procedures, vistas y funciones con los ejemplos que se proveen. */

/* 1. Vista que nos muestra a los clientes que más han comprado.
Para saber hacia quienes podemos tomar ciertas acciones comerciales.
Trabaja con la tabla 'ventas'. */

USE tcg_store_reyes;

CREATE VIEW mejores_clientes AS
SELECT c.id_cliente, CONCAT(c.nombre_cliente, ' ', c.apellido_cliente) as 'Nombre_completo', SUM(v.PrecioFinal_venta) as suma_ventas
FROM ventas v 
INNER JOIN clientes c on v.id_cliente = c.id_cliente
GROUP BY c.id_cliente
ORDER BY suma_ventas DESC;

SELECT * FROM mejores_clientes;

/* 2. Vista donde nos da una vista comercial de los productos.
Podemos observar los precios, los costos, los márgenes brutos (expresados en $ CLP) y margen porcentual (expresado en decimales).
Ordenado por los márgenes porcentuales descendientemente. */

CREATE VIEW resumen_comercial AS
SELECT id_producto, nombre_producto, CONCAT('$', FORMAT((precio_producto), 0, 'es_CL')) as precio_producto, CONCAT('$', FORMAT((costo_producto), 0, 'es_CL')) as costo_producto, CONCAT('$', FORMAT(((precio_producto - costo_producto)), 0, 'es_CL')) as margen_bruto, (((precio_producto - costo_producto)/precio_producto)) as Margen_porcentual
FROM productos
ORDER BY margen_bruto DESC;

SELECT * FROM resumen_comercial;

/* 3. Ventas agrupadas por franquicias, ordenado por las franquicias que más ventas tienen descendientemente.
Vista comercial de cada una de las líneas de negocios.
Trabaja con la tabla 'ventas' y 'franquicia'. */

CREATE VIEW franquicias_reporte AS
SELECT f.nombre_franquicia, CONCAT('$', FORMAT(SUM(v.precioFinal_venta), 0, 'es_CL')) as total_ventas_franquicia
FROM productos p
INNER JOIN ventas v ON v.id_producto = p.id_producto
INNER JOIN franquicia f ON p.id_franquicia = f.id_franquicia
GROUP BY f.nombre_franquicia
ORDER BY total_ventas_franquicia DESC;

SELECT * FROM franquicias_reporte;

/* 4. Vistas las ventas atribuidas a los distintos trabajadores, cuántos artículos vendio, cuántas ventas y el ticket promedio.
Para considerar incentivos para los empleados que más venden.
Trabaja con la tabla 'ventas' y 'empleados'. */

CREATE VIEW reporte_empleados AS
SELECT e.id_empleado, CONCAT(e.nombre_empleado, ' ', e.apellido_empleado) as Nombre_completo_empleado, e.cargo_empleado, SUM(v.precioFinal_venta) as ventas_totales_por_empleado, SUM(v.cantidad_producto) as Cantidad_productos, COUNT(v.id_venta) as Cantidad_ventas, CAST((SUM(v.precioFinal_venta)/COUNT(v.id_venta)) AS DECIMAL(10,0)) as Ticket_promedio
FROM empleados e
INNER JOIN ventas v ON e.id_empleado = v.id_empleado
GROUP BY v.id_empleado
ORDER BY ventas_totales_por_empleado DESC;

SELECT *
FROM reporte_empleados;

/* 5. Ver la última vez que los clientes compraron, ordenados desde los clientes que compraron hace más tiempo.
Para recuperar clientes que no han comprado hace mucho.
Trabaja con la tabla 'ventas' y 'clientes'. */

CREATE VIEW clientes_ultima_compra AS
SELECT c.id_cliente, CONCAT(c.nombre_cliente, ' ', c.apellido_cliente) as nombre_completo, MAX(v.fecha_venta) as fecha_ultima_compra
FROM clientes c
INNER JOIN ventas v ON c.id_cliente = v.id_cliente
GROUP BY v.id_cliente
ORDER BY fecha_ultima_compra ASC;

SELECT *
FROM clientes_ultima_compra;

