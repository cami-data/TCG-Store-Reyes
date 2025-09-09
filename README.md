# Proyecto Coderhouse Curso SQL - Com. 81830
## Tienda de TCG y otros
### Autora: Camila Reyes C. para curso Coderhouse.

<p align="center">
<img width="800" height="565" alt="8b1b00dc-a595-4ca6-9864-dc4e99d40b752" src="https://github.com/user-attachments/assets/7b2810bd-ca8b-4838-a53b-8215e65e07ff" />
</p>

## Índice

1. [Introducción](#introducción)
2. [Objetivo](#objetivo)
3. [Situación problemática](#situación-problematica)
4. [Diagrama E-R](#diagrama-e-r)
5. [Modelo de negocios](#modelo-de-negocios)
6. [Apartado Lista de tablas](#apartado-lista-de-tablas)
7. [Lista de funciones](#lista-de-funciones)
8. [Lista de triggers](#lista-de-triggers)
9. [Lista de vistas](#lista-de-vistas)
10. [Lista de Stored Procedures](#lista-de-stored-procedures)

## Introducción

Se realizará una base de datos con tablas, correspondientes a una tienda ficticia dedicada a la venta de cartas, modelos, juegos de mesa y otros artículos, relacionados con algunas franquicias reconocibles y otras, inventadas. 


## Objetivo

El objetivo del trabajo es poder descubrir insights del negocio, que puedan ayudar al crecimiento de éste. Además, extraer estrategias que puedan aumentar la satisfacción tanto de nuestros consumidores, como de nuestros empleados. Por último, la administración espera conocer más a sus consumidores y poder reafirmar o cambiar algunas concepciones que tienen de ellos: edad, género, comportamientos de compra, etc. 


## Situación Problemática

Actualmente, la tienda ha crecido exponencialmente, debido a la creciente popularidad de las cartas y los juegos de mesa. Por tanto, queremos tener un control más riguroso de los datos que se recolectan de la tienda día a día, tales como: ventas, datos de clientes, etc. Con esto, la administración espera tener un mejor manejo del negocio y seguir creciendo. 


## Diagrama E-R

Referirse al PDF 'diagrama_E_R_TCG_Store_Reyes.pdf' en el repositorio.

## Modelo de Negocios

El modelo de negocios corresponde a un tipo B2C. Principalmente, nos centramos en la venta de cartas y mercadería de distintas franquicias.

El target que la administración tiene en mente es desde los 12 años a los 30 años, y esperan que una porción significativa del target, pertenezca al género masculino.

En este momento, solo contamos con una locación, y por el momento, no tenemos ventas por internet, solo en tiendas.

Se cuenta con un modelo de suscripciones, donde mandamos correos electrónicos con ofertas y descuentos a los clientes que se hayan inscrito.

Éstos solo se pueden inscribir recurriendo a la tienda, y por la gestión de un empleado.

Entre las informaciones que enviamos por correo, existe el descuento de cumpleaños, por lo que es importante que este campo sea completado.

Los clientes pueden (o no) asociar sus compras a un empleado. La administración está pensando en implementar un sistema de comisiones.

En cuanto a promociones, la administración ha determinado que solo se puede aplicar UNA promoción a los artículos, por cada lapso de tiempo. Es decir, al comprar un artículo, no se le puede aplicar la promoción de 'Black Friday', junto con el 'Descuento de empleado'. Las promociones se aplican a todos los artículos por igual, dentro del periodo estipulado.

## Apartado lista de tablas

### 🟣 Tabla 'empleados': 
- id_empleado: Clave principal. Identifica al empleado. Relacionada a la tabla 'ventas' y 'suscripciones'
- nombre_empleado: Nombre del empleado.
- apellido_empleado: Apellido del empleado.
- mail_empleado: Mail del empleado.
- telefono_empleado: Teléfono del empleado.
- cargo_empleado: Cargo en la empresa del empleado. 
- sueldo_empleado: Sueldo en CLP (pesos chilenos) del empleado.

### 🟣 Tabla 'franquicia':
- id_franquicia: Clave primaria. Identifica la franquicia a la que pertenece el artículo. Relacionada a la tabla 'productos'.
- nombre_franquicia: Nombre de la franquicia. Ejemplo: Pokemon, Yugioh, etc.

### 🟣 Tabla 'promociones':
- id_promo: Identifica a la promoción. Relacionada a la tabla 'ventas'.
- nombre_promo: Nombre de la promoción. Ejemplo: Black friday.
- porcentaje_promo: Porcentaje de la promoción, expresado en decimales. Ejemplo: si es un 50% de dcto., se debe escribir como '0,5'.
- fechainicio_promo: Fecha de inicio de la promoción.
- fechafinal_promo: Fecha de finalización de la promoción.
- estado: De tipo booleano. True: Promoción activa. False: promoción inactiva.

### 🟣 Tabla 'formadepago':
- id_pago: Clave primaria. Relacionada a la tabla 'ventas'.
- nombre_pago: Nombre del método de pago: Ejemplo: 'Efectivo', 'Debito', etc.

  ### 🟣 Tabla 'clientes':
- id_cliente: Clave primaria. Identifica al cliente. Relacionada a la tabla 'suscripciones' y 'ventas'.
- nombre_cliente: Nombre del cliente.
- apellido_cliente: Apellido del cliente.
- edad_cliente: Edad del cliente como número entero y sin la palabra 'años'.
- genero_cliente: Género del cliente. Tres tipos de géneros: 'M', 'F' y 'Otros'. 
- mail_cliente: Mail del cliente. Puede estar vacío.
- telefono_cliente: Teléfono del cliente. Puede estar vacío.
- suscrito: Booleano. Identifica si el cliente está suscrito a comunicaciones comerciales.
- id_empleado_sus: INT. Identifica cuál fue el empleado que suscribió al cliente al newsletter.
- cumpleanos_cliente_ss: Contiene el cumpleaños del cliente.

### 🟣 Tabla 'productos':
- id_producto: Clave primaria. Identifica al artículo.  
- nombre_producto: Nombre del artículo.
- precio_producto: Precio del artículo.
- tipo_producto: Tipo del artículo. Ejemplo: Cartas individuales, juego de mesa, figuras, etc.
- id_franquicia: Clave foránea. Identifica a la franquicia (o marca) a la que pertenece el artículo. Relacionada a la tabla 'franquicia'. El artículo solo puede tener una franquicia asociada.
- imagen_URL: URL de la imagen del producto.
- costo_producto: El costo del producto (en $ CLP).
- cantidad_producto: Cantidad del producto en stock.

### 🟣 Tabla 'historial_stock':
- id_stock: Clave primaria. Identifica el movimiento de stock. Relacionada a la tabla 'productos'.
- id_producto: Clave foránea. Identifica el artículo al que pertenece el movimiento de stock. Relacionada a la tabla 'productos'.
- tipoMovimiento_stock: Movimiento de entrada o salida de stock. 
- cantidad_stock: Cantidad de stock del producto en existencia. 
- fechaMovimiento_stock: Fecha en que entró o salió el producto. 

### 🟣 Tabla 'ventas':
- id_venta: Clave primaria. Identifica a la venta. 
- id_cliente: Clave foránea. Identifica al cliente. Relacionada a la tabla 'clientes'.
- id_producto: Clave foránea. Identifica al producto. Relacionada a la tabla 'productos'.
- cantidad_producto: Cantidad de productos del mismo tipo vendidos. 
- precioOriginal_venta: Precio de venta sin la promoción.
- precioFinal_venta: Precio de venta con la promoción. Puede ser igual al precio de venta, si es que no hay promociones activas.
- id_promo: Clave foránea. Identifica que promoción se le aplica al precio de venta. Relacionada a la tabla 'promociones'. Puede ir vacío.
- fecha_venta: Fecha en que se realizó el artículo.
- id_Pago: Clave foránea. Identifica el tipo de pago. Relacionada a la tabla 'formadepago'.
- id_empleado: Clave foránea. Identifica al empleado que asistió a la venta. Puede estar vacío. Relacionada a la tabla 'empleados'.
- descuento_aplicado: Descuento aplicado en caso de haber una promoción. Se escribe en decimales. Ejemplo: 10% = 0.10.

### 🟣 Tabla 'suscripciones':
- id_suscripcion: Clave principal. Identifica a la suscripción. 
- id_cliente: Clave foránea. Identifica al cliente que está suscrito. Relacionada a la tabla 'clientes'.
- fecha_suscripcion: Fecha en que el cliente se suscribió.
- mail_cliente_sus: Email donde la empresa enviará correos corporativos, de descuentos y de promociones.
- cumpleanos_cliente: Fecha de cumpleaños del cliente.
- id_empleado: Clave foránea. Identifica al empleado que ha sido responsable de inscribir al cliente en la base de datos de la tienda.

## Lista de funciones
```sh
1. Función "fn_ingresos_totales_producto": 
- Descripción: Calcular los ingresos totales de un producto.
- Objetivo: Para evaluar las ventas o acciones comerciales a realizar, para productos específicos. 
- Tablas usadas: Trabaja en la tabla 'ventas'.

2. Función "fn_dias_ultima_compra":
- Descripción: Calcular los días que han transcurrido desde la compra de un cliente en específico.
- Objetivo: Para evaluar las ventas o acciones comerciales, para productos clientes en específicos, e ingresar a sus datos fácilmente.  
- Tablas usadas: Trabaja en la tabla 'ventas'.

3. Función "fn_ingresos_totales_dia":
- Descripción: Calcular ingresos de un día en específico.
- Objetivo: Útil para dias de alta venta, como Black Friday. 
- Tablas usadas: Trabaja en la tabla 'ventas'.

```

## Lista de Triggers
```sh
1. Trigger "buscar_descuento_aplicado":
- Descripción: Busca el descuento de la promoción, con el id_promo. Debe revisar si la promoción está o no activa. 
- Objetivo: Con el objetivo de corroborar que la promoción esté activa y evitar errores en los descuentos.
- Tablas usadas: Actúa al ingresar una venta en la tabla de 'ventas'.

2. Trigger "calcular_precios_venta":
- Descripción: Trigger para calcular el precio final de la compra, considerando el precio al que se vendió el producto y la cantidad comprada. Trigger que toma el precio del producto desde la tabla 'productos', identificando el id del producto.  
- Objetivo: Tiene el objetivo de evitar errores en el tipeo del importe total de las compras y en el precio de los productos.
- Tablas usadas: Se activa al registrar una venta en la tabla 'ventas'.

3. Trigger "calcular_edad_clientes":
- Descripción: Crear un trigger para que calcule la edad al momento de ingresar al cliente en el sistema. 
- Objetivo: Con el objetivo de no tener que calcular manualmente la edad de las personas e insertarlo automáticamente en la tabla de 'clientes'.
- Tablas usadas: Se activa al registrar a un cliente en la tabla 'clientes'.

4. Trigger "suscripcion_insercion_cliente":
- Descripción: Hacer una nueva inserción en la tabla 'suscripciones', si el cliente aceptó estar suscrito.
- Objetivo: Tener un registro de los clientes suscritos y acceder a sus datos.
- Tablas usadas: Se activa al registrar a un cliente en la tabla 'clientes' y suscrito = 1. 

5. Trigger "insercion_stock":
- Descripción: Trigger para llevar los registros de inserción de stock en nuevos productos.
- Objetivo: Con el fin de tener un control de los movimientos de stock y de nuevos productos que ingresa en la tabla 'productos'.
- Tablas usadas: Actúa en la tabla de 'historial_stock'.

6. Trigger "insercion_stock_existente":
- Descripción: Trigger que adiciona el registro de aumento en stock de productos existentes.
- Objetivo: Con el fin de tener un control de los movimientos de stock de productos existentes.
- Tablas usadas: Actúa en la tabla de 'historial_stock'
```

## Lista de Vistas
```sh
1. Vista "mejores_clientes":
- Descripción: Vista que nos muestra a los clientes que más han comprado.
- Objetivo: Para saber hacia que clientes podemos tomar ciertas acciones comerciales.
- Tablas usadas: Trabaja con la tabla 'ventas'.

2. Vista "resumen_comercial":
- Descripción: Vista donde nos da una vista comercial de los productos.
- Objetivo: Podemos observar los precios, los costos, los márgenes brutos (expresados en $ CLP) y margen porcentual (expresado en decimales).
- Tablas usadas: Ordenado por los márgenes porcentuales descendientemente.

3. Vista "franquicias_reporte":
- Descripción: Ventas agrupadas por franquicias, ordenado por las franquicias que más ventas tienen descendientemente.
- Objetivo: Vista comercial de cada una de las líneas de negocios.
- Tablas usadas: Trabaja con la tabla 'ventas' y 'franquicia'.

4. Vista "reporte_empleados":
- Descripción: Vistas las ventas atribuidas a los distintos trabajadores, cuántos artículos vendio, cuántas ventas y el ticket promedio.
- Objetivo: Para considerar incentivos para los empleados que más venden.
- Tablas usadas: Trabaja con la tabla 'ventas' y 'empleados'.

5. Vista "clientes_ultima_compra":
- Descripción: Ver la última vez que los clientes compraron, ordenados desde los clientes que compraron hace más tiempo.
- Objetivo: Para recuperar clientes que no han comprado hace mucho.
- Tablas usadas: Trabaja con la tabla 'ventas' y 'clientes'.
```

## Lista de Stored Procedures
```sh
1. Stored procedures "sp_historial_cliente":
- Descripción: Stored procedure para saber cuánto ha comprado un cliente. 
- Objetivo: Nos sirve cuando queremos saber cuáles son nuestros clientes más valiosos o que han comprado poco, para realizar acciones comerciales con ellos.
- Tablas usadas: Usa las tablas 'ventas' y 'clientes'.

2. Stored procedures "sp_cambiar_precios":
- Descripción: Stored procedure que nos permita cambiar todos los precios de una franquicia.
- Objetivo: Funciona tanto para aumentar precios, como para descontarlos, siempre y cuando sean números enteros. Útil cuando tenemos descuentos en una sola línea de franquicias y no queremos cambiar todos los precios manualmente.
- Tablas usadas: Usa las tablas 'productos' y 'franquicias'.

3. Stored procedures "sp_ingresar_nuevo_producto":
- Descripción: Stored procedure para ingresar productos, a través de la ventana interactiva. También se puede hacer con CALL (procedure).
- Objetivo: Hace más fácil el ingreso de nuevos productos a la tabla 'productos'.
- Tablas usadas: Trabaja con la tabla 'productos'.

```
