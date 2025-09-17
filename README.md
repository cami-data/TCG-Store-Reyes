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
11. [Transacciones](#transacciones-y-dcl)
12. [Informes](#Informes)
13. [DCL](#DCL)

## Introducción

Se realizará una base de datos con tablas, correspondientes a una tienda ficticia dedicada a la venta de cartas, modelos, juegos de mesa y otros artículos, relacionados con algunas franquicias reconocibles y otras, inventadas. 


## Objetivo

El objetivo del trabajo es poder descubrir insights del negocio, que puedan ayudar al crecimiento de éste. Además, extraer estrategias que puedan aumentar la satisfacción tanto de nuestros consumidores, como de nuestros empleados. Por último, la administración espera conocer más a sus consumidores y poder reafirmar o cambiar algunas concepciones que tienen de ellos: edad, género, comportamientos de compra, etc. 


## Situación Problemática

Actualmente, la tienda ha crecido exponencialmente, debido a la creciente popularidad de las cartas y los juegos de mesa. Por tanto, queremos tener un control más riguroso de los datos que se recolectan de la tienda día a día, tales como: ventas, datos de clientes, etc. Con esto, la administración espera tener un mejor manejo del negocio y seguir creciendo. 


## Diagrama E-R

<p align="center">
<img width="600" height="600" alt="image" src="https://github.com/user-attachments/assets/c8c4b0d7-1b11-40c7-ac02-e7138f1d59e7" />
</p>

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

| Campo             | Tipo de dato     | NOT NULL | Primary Key | Foreign Key | Unique | Descripción                                                                 |
|-------------------|-----------------|----------|-------------|-------------|--------|-----------------------------------------------------------------------------|
| id_empleado       | INT AUTO_INCREMENT | SI    | SI          | NO          | SI     | Identifica al empleado. Relacionada a las tablas 'ventas' y 'suscripciones'. |
| nombre_empleado   | VARCHAR(40)     | SI       | NO          | NO          | NO     | Nombre del empleado.                                                        |
| apellido_empleado | VARCHAR(40)     | SI       | NO          | NO          | NO     | Apellido del empleado.                                                      |
| mail_empleado     | VARCHAR(50)     | SI       | NO          | NO          | SI     | Mail del empleado.                                                          |
| telefono_empleado | VARCHAR(8)      | SI       | NO          | NO          | SI     | Teléfono del empleado.                                                      |
| cargo_empleado    | VARCHAR(20)     | SI       | NO          | NO          | NO     | Cargo en la empresa del empleado.                                           |
| sueldo_empleado   | DECIMAL(10,0)   | SI       | NO          | NO          | NO     | Sueldo en CLP (pesos chilenos) del empleado.                                |

### 🟣 Tabla 'franquicia':

| Campo            | Tipo de dato | NOT NULL | Primary Key | Foreign Key | Unique | Descripción                                                                 |
|------------------|--------------|----------|-------------|-------------|--------|-----------------------------------------------------------------------------|
| id_franquicia    | INT AUTO_INCREMENT| SI  | SI          | NO          | SI     | Identifica la franquicia a la que pertenece el artículo. Relacionada a la tabla 'productos'. |
| nombre_franquicia| VARCHAR(40)  | SI       | NO          | NO          | NO     | Nombre de la franquicia. Ejemplo: Pokémon, Yu-Gi-Oh, etc.                   |


### 🟣 Tabla 'promociones':
| Campo             | Tipo de dato       | NOT NULL | Primary Key | Foreign Key | Unique | Descripción                                                               |
|-------------------|--------------------|----------|-------------|-------------|--------|---------------------------------------------------------------------------|
| id_promo          | INT AUTO_INCREMENT | SI       | SI          | NO          | SI     | Identifica a la promoción. Relacionada a la tabla 'ventas'.               |
| nombre_promo      | VARCHAR(40)        | SI       | NO          | NO          | NO     | Nombre de la promoción. Ejemplo: Black Friday.                            |
| porcentaje_promo  | DECIMAL(3,2)       | NO       | NO          | NO          | NO     | Porcentaje de la promoción Ejemplo: 0.50 para 50%.                      |
| fechainicio_promo | DATE               | SI       | NO          | NO          | NO     | Fecha de inicio de la promoción.                                          |
| fechafinal_promo  | DATE               | SI       | NO          | NO          | NO     | Fecha de finalización de la promoción.                                    |
| estado            | BOOL               | SI       | NO          | NO          | NO     | Estado de la promoción. True = activa, False = inactiva.                  |


### 🟣 Tabla 'formadepago':

| Campo       | Tipo de dato       | NOT NULL | Primary Key | Foreign Key | Unique | Descripción                                           |
|-------------|--------------------|----------|-------------|-------------|--------|-------------------------------------------------------|
| id_pago     | INT AUTO_INCREMENT | SI       | SI          | NO          | SI     | Identifica al pago. Relacionada a la tabla 'ventas'.      |
| nombre_pago | VARCHAR(40)        | SI       | NO          | NO          | NO     | Nombre del método de pago. Ejemplo: 'Efectivo', 'Débito', etc. |


  ### 🟣 Tabla 'clientes':
| Campo                  | Tipo de dato       | NOT NULL | Primary Key | Foreign Key | Unique | Descripción                                                          |
|------------------------|--------------------|----------|-------------|-------------|--------|----------------------------------------------------------------------|
| id_cliente             | INT AUTO_INCREMENT | SI       | SI          | NO          | SI     | Identifica al cliente. Relacionada a la tabla 'suscripciones' y 'ventas'. |
| nombre_cliente         | VARCHAR(40)        | SI       | NO          | NO          | NO     | Nombre del cliente.                                                  |
| apellido_cliente       | VARCHAR(40)        | SI       | NO          | NO          | NO     | Apellido del cliente.                                                |
| edad_cliente           | INT                | NO       | NO          | NO          | NO     | Edad del cliente como número entero y sin la palabra 'años'.         |
| genero_cliente         | VARCHAR(1)         | SI       | NO          | NO          | NO     | Género del cliente: 'M', 'F' u 'Otros'.                              |
| mail_cliente           | VARCHAR(50)        | SI       | NO          | NO          | SI     | Mail del cliente.|
| telefono_cliente       | VARCHAR(8)         | NO       | NO          | NO          | SI     | Teléfono del cliente.                           |
| suscrito               | BOOL               | SI       | NO          | NO          | NO     | Identifica si el cliente está suscrito a comunicaciones comerciales. |
| id_empleado_sus        | INT                | SI       | NO          | SI          | NO     | Identifica qué empleado suscribió al cliente al newsletter.          |
| cumpleanos_cliente_ss  | DATE               | NO       | NO          | NO          | NO     | Contiene el cumpleaños del cliente.                                  |

### 🟣 Tabla 'productos':

| Campo             | Tipo de dato       | NOT NULL | Primary Key | Foreign Key | Unique | Descripción                                                               |
|-------------------|--------------------|----------|-------------|-------------|--------|---------------------------------------------------------------------------|
| id_producto       | INT AUTO_INCREMENT | SI       | SI          | NO          | SI     | Clave primaria. Identifica al artículo.                                   |
| nombre_producto   | VARCHAR(40)        | SI       | NO          | NO          | NO     | Nombre del artículo.                                                      |
| precio_producto   | DECIMAL(10,0)      | SI       | NO          | NO          | NO     | Precio del artículo.                                                      |
| tipo_producto     | VARCHAR(40)        | SI       | NO          | NO          | NO     | Tipo del artículo. Ejemplo: Cartas individuales, figuras, etc. |
| id_franquicia     | INT                | NO       | NO          | SI          | NO     | Identifica a la franquicia (o marca) a la que pertenece el artículo. |
| imagen_URL        | VARCHAR(2000)      | NO       | NO          | NO          | NO     | URL de la imagen del producto.                                            |
| costo_producto    | DECIMAL(10,0)      | SI       | NO          | NO          | NO     | El costo del producto (en $ CLP).                                         |
| cantidad_producto | INT DEFAULT 0      | SI       | NO          | NO          | NO     | Cantidad del producto en stock.                                           |


### 🟣 Tabla 'historial_stock':

| Campo                 | Tipo de dato       | NOT NULL | Primary Key | Foreign Key | Unique | Descripción                                                           |
|------------------------|--------------------|----------|-------------|-------------|-------|----------------------------------------------------------------------|
| id_stock              | INT AUTO_INCREMENT | SI       | SI          | NO          | SI     | Identifica el movimiento de stock. Relacionada a la tabla 'productos'.|
| id_producto           | INT                | NO       | NO          | SI          | NO     | Identifica el artículo al que pertenece el movimiento de stock. |
| tipoMovimiento_stock  | VARCHAR(40)        | SI       | NO          | NO          | NO     | Movimiento de entrada o salida de stock. Sólo puede ser 'entrada' o 'salida'. |
| cantidad_stock        | INT                | SI       | NO          | NO          | NO     | Cantidad de stock del producto en existencia.                         |
| fechaMovimiento_stock | DATE               | SI       | NO          | NO          | NO     | Fecha en que entró o salió el producto.                               |


### 🟣 Tabla 'ventas':

| Campo               | Tipo de dato       | NOT NULL | Primary Key | Foreign Key | Unique | Descripción                                                             |
|----------------------|--------------------|----------|-------------|-------------|--------|------------------------------------------------------------------------|
| id_venta            | INT AUTO_INCREMENT | SI       | SI          | NO          | SI     | Identifica a la venta.                                  |
| id_cliente          | INT                | SI       | NO          | SI          | NO     | Identifica al cliente. Relacionada a la tabla 'clientes'.|
| id_producto         | INT                | SI       | NO          | SI          | NO     | Identifica al producto. Relacionada a la tabla 'productos'.  |
| cantidad_producto   | INT                | SI       | NO          | NO          | NO     | Cantidad de productos del mismo tipo vendidos.                          |
| precioOriginal_venta| DECIMAL(10,0)      | SI       | NO          | NO          | NO     | Precio de venta sin la promoción.                                       |
| precioFinal_venta   | DECIMAL(10,0)      | SI       | NO          | NO          | NO     | Precio final de la venta. Considera cantidad y promoción aplicada.|
| id_promo            | INT                | NO       | NO          | SI          | NO     | Identifica qué promoción se aplicó a la venta. |
| fecha_venta         | DATE               | SI       | NO          | NO          | NO     | Fecha en que se realizó la venta.                                       |
| id_pago             | INT                | SI       | NO          | SI          | NO     | Identifica el tipo de pago. Relacionada a la tabla 'formadepago'. |
| id_empleado         | INT                | NO       | NO          | SI          | NO     | Identifica al empleado que asistió la venta. |
| descuento_aplicado  | DECIMAL(3,2)       | NO       | NO          | NO          | NO     | Descuento aplicado en caso de promoción. Ejemplo: 10% = 0.10.           |


### 🟣 Tabla 'suscripciones':

| Campo              | Tipo de dato       | NOT NULL | Primary Key | Foreign Key | Unique | Descripción                                                              |
|---------------------|--------------------|----------|-------------|-------------|--------|-------------------------------------------------------------------------|
| id_cliente          | INT                | SI       | SI          | SI          | SI     | Identifica al cliente que está suscrito. Relacionada a la tabla 'clientes'. |
| fecha_suscripcion   | DATE               | SI       | NO          | NO          | NO     | Fecha en que el cliente se suscribió.                                   |
| mail_cliente_sus    | VARCHAR(50)        | SI       | NO          | NO          | SI     | Email donde se enviarán correos corporativos, descuentos y promociones. |
| cumpleanos_cliente  | DATE               | NO       | NO          | NO          | NO     | Fecha de cumpleaños del cliente.                                        |
| id_empleado         | INT                | NO       | NO          | SI          | NO     | Identifica al empleado que inscribió al cliente.         |

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

## Transacciones

```sh
En el archivo 'transacciones.sql', se adiciona una transacción para reversar inserciones en la tabla de 'ventas',
con un ejemplo interactivo.
```

## Informes: 

Se realizó una exportación de los datos a Power BI, con lo que se armó un dashboard muy simple.
Podemos encontrar el respaldo de las consultas en el archivo 'informes.sql', en el repositorio.
<p align="center">
<img width="1145" height="636" alt="image" src="https://github.com/user-attachments/assets/35fa9d24-cae0-41dd-9076-69ebf8dd147c" />
</p>

## DCL

```sh
Se adjunta además en el archivo 'DCL_permisos_usuarios.sql', donde se crean dos usuarios, que cumplen roles distintos.
El primero de 'marketing', donde solo tiene permisos para consultar la tabla de 'ventas'.
Y el otro, de 'jefa de local', donde tiene permisos absolutos, al tener una mayor responsabilidad.
```

## Backup

```sh
Se adjunta en el repositorio un archivo, donde se encuentra el backup de la información. Su nombre es 'backup.sql'.
```

