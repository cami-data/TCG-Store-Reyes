-- Informes: Corroboramos que la información en Power Bi sea la misma que en SQL: 

-- Clientes con más compras en CLP ($):
SELECT c.mail_cliente, SUM(v.PrecioFinal_venta) as suma_ventas
FROM ventas v 
INNER JOIN clientes c on v.id_cliente = c.id_cliente
GROUP BY c.id_cliente
ORDER BY suma_ventas DESC;

-- Ventas totales: 
SELECT SUM(PrecioFinal_venta) 
FROM ventas;

-- Cantidad de transacciones: 
SELECT COUNT(id_venta) 
FROM ventas;

-- Cantidad de productos vendidos: 
SELECT SUM(cantidad_producto) 
FROM ventas;

-- Porcentaje de épersonas por género que compraron en la tienda: 
SELECT c.genero_cliente, SUM(v.PrecioFinal_venta) as suma_ventas
FROM ventas v 
INNER JOIN clientes c on v.id_cliente = c.id_cliente
GROUP BY c.genero_cliente
ORDER BY suma_ventas DESC;

