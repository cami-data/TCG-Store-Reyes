

/* Por favor, considerar que antes de poblar las tablas, hay que accionar los triggers y los stored procedures, ya que por simpleza, se optó por usar los triggers para hacer las inserciones.
Luego de poblar las tablas, se pueden probar los triggers, stored procedures, vistas y funciones con los ejemplos que se proveen. */

USE tcg_store_reyes;

-- Población de la tabla 'empleados':
INSERT INTO empleados (nombre_empleado, apellido_empleado, mail_empleado, telefono_empleado, cargo_empleado, sueldo_empleado)
VALUES 
('Liz', 'Sherman', 'lizS@gmail.com', 99997766, 'Jefa de local', 2000000),
('Hiddeo', 'Kojima', 'hideo@gmail.com', 99657777, 'Trabajor', 1000000),
('Ash', 'Ketchum', 'ashk@gmail.com', 97893346, 'Trabajador', 1000000),
('Bruce', 'Wayne', 'notbatman@gmail.com', 88779867, 'Trabajador', 1000000),
('Laios', 'Tounden', 'tabemasu@gmail.com', 77658890, 'Bodeguero', 800000);

-- Población tabla 'franquicia':
INSERT INTO franquicia (nombre_franquicia)
VALUES
('Sanrio'),
('Pokemon'),
('YuGiOh'),
('Magic'),
('MitosYLeyendas'),
('Warhammer'),
('Anime');

SELECT *
FROM franquicia;

-- Población tabla 'productos':
-- Sanrio (1):
INSERT INTO productos (nombre_producto, precio_producto, tipo_producto, id_franquicia, imagen_URL, costo_producto)
VALUES
('Peluche Cinnamoroll', 10000, 'Peluche', 1, 'https://www.sanrio.com/cdn/shop/files/zz-2503835293_CN_--1_800x.jpg?v=1741901342',5000),
('Peluche Cinnamoroll Matcha', 15000, 'Peluche', 1, 'https://www.sanrio.com/cdn/shop/files/839426-Zoom.1_800x.jpg?v=1750896124', 10000),
('Peluche Cinnamoroll', 10000, 'Peluche', 1, 'https://www.sanrio.com/cdn/shop/files/zz-2503835293_CN_--1_800x.jpg?v=1741901342', 5000),
('Figura Cinnamoroll', 15000, 'Figura', 1, 'https://www.sanrio.com/cdn/shop/files/zz-2501123528_CN_--1_800x.jpg?v=1743734595', 4000),
('Peluche Pompompurin', 12000, 'Peluche', 1, 'https://www.sanrio.com/cdn/shop/files/4550624300582-2_800x.jpg?v=1749246623', 5000),
('Peluche Pompompurin', 9000, 'Peluche', 1, 'https://www.sanrio.com/cdn/shop/files/zz-2407513989_PN_--1_800x.jpg?v=1721938586', 4000),
('Hello Kitty and Friends', 20000, 'Figura', 1, 'https://www.sanrio.com/products/hello-kitty-and-friends-4-ultra-premier-6-pc-figure-set', 10000),
('Figura Kuromi', 25000, 'Figura', 1, 'https://www.sanrio.com/cdn/shop/files/zz-2403874027_KU_--1_800x.jpg?v=1719937077', 10000),
('Dobble Sanrio', 14990, 'Figura', 1, NULL, 8000);

-- Pokemon: (2)
INSERT INTO productos (nombre_producto, precio_producto, tipo_producto, id_franquicia, imagen_URL, costo_producto)
VALUES
('Surging Sparks Cartas Pokemon', 5000, 'Sobres de cartas', 2, 'https://sidedeck.cl/cdn/shop/files/Pokemon_TCG_Scarlet_Violet_Surging_Sparks_Booster_Wrap_Pikachu_1.png?v=1754447175', 2000),
('Black Bolt Cartas Pokemon', 60000, 'Pack cartas', 2, 'https://http2.mlstatic.com/D_NQ_NP_2X_764487-MLC86738296853_062025-F-pokemon-black-bolt-etb-espanol-elite-trainer-box.webp', 30000),
('Obsidian Flames Cartas Pokemon', 4000, 'Sobres de cartas', 2, 'https://sidedeck.cl/cdn/shop/files/Pokemon_TCG_Scarlet_Violet_Obsidian_Flames_Booster_Wrap_Charizard_1.png?v=1754442307', 2000),
('Alakazam-Ex', 50000, 'Single', 2, 'https://images.pokemontcg.io/xy10/125_hires.png', 40000),
('Mudkip', 2000, 'Single', 2, 'https://images.pokemontcg.io/ex14/58_hires.png', 1000),
('Porta Mazos Pokemon', 9990, 'Portamazo', 2, 'https://www.magicsur.cl/29358-large_default/portamazo-ultra-pro-gallery-series-trick-room-full-view-deck-box.jpg', 14550),
('Playmat Eeve Pokemon', 19990, 'Playmat', 2, 'https://www.pokemoncenter.com/images/DAMRoot/High/10014/P11488_10-10227-101_01.jpg', 14990),
('Dobble Pokemon', 14990, 'Juego de mesa', 2, NULL, 10000);

-- YuGiOh: (3)
INSERT INTO productos (nombre_producto, precio_producto, tipo_producto, id_franquicia, imagen_URL, costo_producto)
VALUES
('Nexus Duelista YuGiOh', 4000, 'Sobres de cartas', 3, 'https://www.updown.cl/producto/yu-gi-oh-nexus-duelista-sobre-espanol/', 2000),
('Rompedores Valientes YuGiOh', 4000, 'Sobres de cartas', 3, 'https://www.updown.cl/producto/yu-gi-oh-rompedores-valientes-sobre-espanol/', 1000),
('Playmat YuGiOh', 11000, 'Playmat', 3, 'https://www.updown.cl/producto/playmat-yu-gi-oh-dark-magician-girl-game-mat/', 2000),
('Portamazo YuGiOh', 4490, 'Portamazo', 3, 'https://www.updown.cl/producto/yu-gi-oh-portamazo-albaz-eccleisa-tri-brigade-card-case/', 1000), 
('Crimson King YugiOh', 24990, 'Pack cartas', 3, NULL, 12000),
('Bestias de Cristal YuGiOh', 4990, 'Sobres de cartas', 3, NULL, 1000);

-- Magic: (4)
INSERT INTO productos (nombre_producto, precio_producto, tipo_producto, id_franquicia, imagen_URL, costo_producto)
VALUES
('Set Booster LOTR Cartas Magic', 8000, 'Sobres de cartas', 4, 'https://www.magicsur.cl/25597-large_default/mtg-set-boosters-sobres-de-edicion-the-lord-of-the-rings-tales-of-middle-earth.jpg', 4000),
('Sobre Phyrexia Cartas Magic', 5000, 'Pack cartas', 4, NULL, 1000),
('Necrogoyf', 1000, 'Single', 4, NULL, 500),
('Zell Dincht', 50000, 'Single', 4, 'https://cards.scryfall.io/large/front/2/5/25d28011-f0a6-4d7b-ab87-aae0fe354d9e.jpg?1748707525', 30000),
('Porta Mazo Magic', 9990, 'Porta Mazos', 4, 'https://www.magicsur.cl/portamazos/7514-portamazo-ultra-pro-outlaws-of-thunder-junction-jace-reawakened-alcove-flip-deck-box.html', 4500);

-- MitosYLeyendas: (5)
-- No tenemos inventario aún.

-- Warhammer: (6)
-- No tenemos inventario aún.

-- Anime: (7)
INSERT INTO productos (nombre_producto, precio_producto, tipo_producto, id_franquicia, imagen_URL, costo_producto)
VALUES 
('Rice Shower Figura', 39990, 'Figura', 7, 'https://cdnb.artstation.com/p/assets/images/images/042/168/735/large/kaoru-sakaki-img31001.jpg?1633925437', 30000), 
('Patamon Figura', 24990, 'Figura', 7, 'https://cdn11.bigcommerce.com/s-xs1cevxe43/images/stencil/960w/attribute_rule_images/16506_source_1752623615.jpg', 20000),
('Figura Miku Banpresto', 29990, 'Figura', 7, NULL, 20000),
('One Piece Monopoly', 39990, 'Juego de Mesa', 7,  NULL, 32000);


-- Población tabla 'formasdepago':
INSERT INTO formadepago(nombre_pago)
VALUES
('debito'),
('credito'),
('deposito'),
('efectivo');

SELECT *
FROM formadepago;

-- Tabla de stock: La usaremos para auditoría, por tanto no la poblaremos por el momento. 

-- Población Tabla Clientes: 
-- suscrito = 1 (Está suscrito a comunicaciones por correo). suscrito = 0 (No está suscrito)

INSERT INTO clientes (nombre_cliente, apellido_cliente, genero_cliente, mail_cliente, telefono_cliente, cumpleanos_cliente_ss, suscrito, id_empleado_sus)
VALUES
('Rafael', 'Sana', 'H', 'rafael@gmail.com', '99778888', NULL, 1, 3),
('Pablo', 'Manuel', 'H', 'Pablo@gmail.com', '17798888', '1995-05-26', 1, 3),
('Camila', 'Kings', 'M', 'camila@gmail.com', '99997777', NULL, 1, 2),
('Paola', 'Panda', 'O', 'p.panda@gmail.com', '97778888', NULL, 1, 4),
('Anita', 'Banana', 'M', 'bananas@gmail.com', '99911122', NULL,  0, 4),
('Lucia', 'Jonas', 'M', 'l.jonas@gmail.com', '97718888', NULL, 1, 3),
('Caterina', 'Varas', 'M', 'ana@gmail.com', '99999888', '1980-10-11', 1, 3),
('Manuel', 'Montt', 'H', 'm.montt@gmail.com', '99781111', '1986-11-10', 0, 2),
('Antonio', 'Varas', 'H', 'a.varas@gmail.com', '99991717', '1970-10-09', 1, 3),
('Robin', 'Hood', 'H', 'r.hood@gmail.com', '91199998', '1990-04-20', 0, 2),
('Judy', 'Hops', 'H', 'juydh@gmail.com', '91166888', '1989-01-30', 1, 3),
('Bruce', 'Willis', 'H', 'brucy@gmail.com', '99977777', '1980-11-30', 1, 3);

-- Población tabla 'Promociones':
INSERT INTO promociones (nombre_promo, porcentaje_promo, fechainicio_promo, fechafinal_promo, estado)
VALUES 
('Black Friday', 0.50, '2025-11-20', '2025-11-30', FALSE),
('Cyber Monday', 0.20, '2025-05-20', '2025-05-30', FALSE),
('Primera Compra', 0.10, '2024-01-01', '2030-12-30', TRUE),
('Cumpleaños', 0.30, '2024-01-01', '2030-12-30', TRUE);

SELECT *
FROM promociones;

-- Población de la tabla 'ventas' CON LOS TRIGGERS YA SETEADOS:

-- Para poder insertar estas ventas, por el momento vamos a activar todas las promociones: 
UPDATE promociones
SET estado = 1
WHERE id_promo BETWEEN 1 AND 4;

SELECT id_promo, estado
FROM promociones;

INSERT INTO ventas (id_cliente, id_producto, cantidad_producto, id_promo, fecha_venta, id_pago, id_empleado)
VALUES 
(5, 20, 1, 3, CURDATE(), 3, 4),
(5, 11, 1, NULL, CURDATE(), 1, 3),
(3, 18, 1, 3, '2025-11-30', 1, 3),
(3, 19, 1, NULL, '2025-01-10', 1, 3),
(3, 26, 10, NULL, '2025-05-30', 2, 2),
(12, 20, 1, 3, '2025-01-10', 1, 3),
(12, 11, 2, 3, '2024-02-15', 1, 4),
(2, 8, 1, NULL, '2024-03-21', 2, 2),
(4, 22, 3, 1, '2024-04-10', 4, 3),
(6, 11, 1, NULL, '2024-05-05', 3, 5),
(7, 5, 1, 4, '2024-06-18', 2, 2),
(8, 19, 2, NULL, '2024-07-29', 1, 4),
(9, 19, 1, NULL, '2024-08-01', 4, 3),
(10, 2, 5, 3, '2024-09-14', 1, 5),
(11, 22, 1, 1, '2024-10-22', 2, 2),
(1, 7, 2, NULL, '2024-11-03', 4, 3),
(2, 1, 1, 2, '2024-12-09', 3, 4),
(4, 11, 4, 3, '2025-01-12', 1, 5),
(6, 28, 1, NULL, '2025-02-20', 2, 2),
(7, 22, 1, 4, '2025-03-01', 1, 3),
(8, 16, 2, 1, '2025-04-15', 3, 4),
(9, 9, 1, 4, '2025-05-28', 1, 5),
(10, 25, 3, NULL, '2025-06-08', 2, 2),
(11, 3, 1, NULL, '2025-07-19', 4, 3),
(1, 22, 1, 3, '2025-08-25', 3, 4),
(4, 14, 2, 2, '2025-09-01', 1, 5);

SELECT *
FROM ventas;

-- Devolvemos los valores de la tabla 'promociones' a su estado anterior:
UPDATE promociones
SET estado = 0
WHERE id_promo BETWEEN 1 AND 2;

UPDATE promociones
SET estado = 1
WHERE id_promo BETWEEN 3 AND 4;

SELECT *
FROM promociones;

