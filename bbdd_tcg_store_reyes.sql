CREATE SCHEMA IF NOT EXISTS `tcg_store_reyes`;

-- Creación de tablas:

USE tcg_store_reyes;

-- Tabla 'empleados':

CREATE TABLE empleados (
id_empleado INT PRIMARY KEY AUTO_INCREMENT,
nombre_empleado VARCHAR (40) NOT NULL,
apellido_empleado VARCHAR (40) NOT NULL,
mail_empleado VARCHAR(50) NOT NULL UNIQUE, 
telefono_empleado VARCHAR(8) UNIQUE NOT NULL,
cargo_empleado VARCHAR(20) NOT NULL,
sueldo_empleado DECIMAL (10,0) NOT NULL
);

-- Tabla 'franquicia':

CREATE TABLE franquicia (
	id_franquicia INT PRIMARY KEY AUTO_INCREMENT,
    nombre_franquicia VARCHAR(40) NOT NULL
);

-- Tabla 'promociones':
CREATE TABLE promociones (
	id_promo INT PRIMARY KEY AUTO_INCREMENT,
    nombre_promo VARCHAR(40) NOT NULL,
    porcentaje_promo DECIMAL(3,2),
    fechainicio_promo DATE NOT NULL,
    fechafinal_promo DATE NOT NULL,
    estado BOOL NOT NULL
);

-- Regla: en el campo 'estado': True/1: Promoción activa. False/0: promoción inactiva.

-- Tabla 'formadepago':
CREATE TABLE formadepago(
	id_pago INT PRIMARY KEY AUTO_INCREMENT,
    nombre_pago VARCHAR(40) 
);

-- Regla: en el campo 'formadepago' solo se pueda ingresar una de cuatro palabras: 'debito', 'credito', 'efectivo', 'deposito'
ALTER TABLE formadepago ADD CONSTRAINT chkNombre_pago CHECK (nombre_pago IN('debito', 'credito', 'efectivo', 'deposito'));

-- Tabla 'clientes':

CREATE TABLE clientes (
	id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre_cliente VARCHAR(40) NOT NULL,
    apellido_cliente VARCHAR(40) NOT NULL,
    edad_cliente INT NOT NULL,
    genero_cliente VARCHAR(1) NOT NULL,
    mail_cliente VARCHAR(50) NOT NULL UNIQUE,
    telefono_cliente VARCHAR(8) UNIQUE DEFAULT NULL
);

-- Regla: en el campo 'genero' solo se pueda ingresar uno de cuatro caracteres: 'M', 'H' u 'O'.
ALTER TABLE clientes ADD CONSTRAINT chkgenero CHECK (genero_cliente IN('M', 'H', 'O'));

-- Tabla 'productos':
CREATE TABLE productos (
	id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre_producto VARCHAR(40) NOT NULL,
    precio_producto DECIMAL (10,0) NOT NULL,
    tipo_producto VARCHAR (40) NOT NULL,
    id_franquicia INT,
    imagen_URL VARCHAR(2000),
    
	FOREIGN KEY (id_franquicia) REFERENCES franquicia (id_franquicia)
);

-- Tabla 'historial_stock':

CREATE TABLE historial_stock (
	id_stock INT PRIMARY KEY AUTO_INCREMENT,
	id_producto INT,
	tipoMovimiento_stock VARCHAR(40) NOT NULL,
	cantidad_stock INT NOT NULL,
	fechaMovimiento_stock DATE NOT NULL,
    
	FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- Regla: en el campo 'tipoMovimiento_stock' solo se pueda ingresar una de dos palabras: 'entrada' o 'salida'.
ALTER TABLE historial_stock ADD CONSTRAINT chkTipoMovimiento_stock CHECK (tipoMovimiento_stock IN('entrada', 'salida'));

-- Tabla 'ventas':
CREATE TABLE ventas (
	id_venta INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    id_producto INT,
    cantidad_producto INT NOT NULL,
    precioOriginal_venta DECIMAL (10,0) NOT NULL,
    precioFinal_venta DECIMAL (10,0) NOT NULL,
    id_promo INT,
    fecha_venta DATE NOT NULL,
    id_pago INT,
	id_empleado INT,
    
	FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
	FOREIGN KEY (id_promo) REFERENCES promociones(id_promo),
    FOREIGN KEY (id_pago) REFERENCES formadepago(id_pago),
	FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);

-- Tabla 'suscripciones':
   
CREATE TABLE suscripciones(
    id_cliente INT PRIMARY KEY,
    fecha_suscripcion DATE NOT NULL,
    mail_cliente_sus VARCHAR(50) NOT NULL UNIQUE, 
    cumpleanos_cliente DATE NOT NULL,
    id_empleado INT,
    
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);


