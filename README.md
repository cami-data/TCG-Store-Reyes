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

## Introducción

Se realizará una base de datos con tablas, correspondientes a una tienda ficticia dedicada a la venta de cartas, modelos, juegos de mesa y otros artículos, relacionados con algunas franquicias reconocibles y otras, inventadas. 


## Objetivo

El objetivo del trabajo es poder descubrir insights del negocio, que puedan ayudar al crecimiento de éste. Además, extraer estrategias que puedan aumentar la satisfacción tanto de nuestros consumidores, como de nuestros empleados. Por último, la administración espera conocer más a sus consumidores y poder reafirmar o cambiar algunas concepciones que tienen de ellos: edad, género, comportamientos de compra, etc. 


## Situación Problematica

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

### 🟣 Tabla 'productos':
- id_producto: Clave primaria. Identifica al artículo.  
- nombre_producto: Nombre del artículo.
- precio_producto: Precio del artículo.
- tipo_producto: Tipo del artículo. Ejemplo: Cartas individuales, juego de mesa, figuras, etc.
- id_franquicia: Clave foránea. Identifica a la franquicia (o marca) a la que pertenece el artículo. Relacionada a la tabla 'franquicia'. El artículo solo puede tener una franquicia asociada.
- imagen_URL: URL de la imagen del producto.

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

### 🟣 Tabla 'suscripciones':
- id_suscripcion: Clave principal. Identifica a la suscripción. 
- id_cliente: Clave foránea. Identifica al cliente que está suscrito. Relacionada a la tabla 'clientes'.
- fecha_suscripcion: Fecha en que el cliente se suscribió.
- mail_cliente_sus: Email donde la empresa enviará correos corporativos, de descuentos y de promociones.
- cumpleanos_cliente: Fecha de cumpleaños del cliente.
- id_empleado: Clave foránea. Identifica al empleado que ha sido responsable de inscribir al cliente en la base de datos de la tienda.
