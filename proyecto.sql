-- ======================================================
-- PROYECTO: KFC_Pedidos
-- DESCRIPCIÓN: Base de datos para gestión de pedidos KFC
-- ======================================================

-- ======================================================
-- 1. CREACIÓN DE LA BASE DE DATOS
-- FUNCIÓN: Elimina la base si existe, la crea nuevamente y la selecciona
-- ======================================================
DROP DATABASE IF EXISTS KFC_Pedidos;
CREATE DATABASE KFC_Pedidos;
USE KFC_Pedidos;

-- ======================================================
-- 2. ELIMINACIÓN DE TABLAS (por orden de dependencias)
-- FUNCIÓN: Evita conflictos al volver a ejecutar el script
-- ======================================================
DROP TABLE IF EXISTS Detalle_Pedido;
DROP TABLE IF EXISTS Pedido;
DROP TABLE IF EXISTS Producto;
DROP TABLE IF EXISTS Metodo_Pago;
DROP TABLE IF EXISTS Cliente;

-- ======================================================
-- 3. CREACIÓN DE TABLAS
-- ======================================================

-- ------------------------------------------------------
-- TABLA: Cliente
-- FUNCIÓN: Almacena información de los clientes
-- ------------------------------------------------------
CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY, -- Identificador único
    nombre VARCHAR(100) NOT NULL,               -- Nombre del cliente
    telefono VARCHAR(20) UNIQUE,                -- Teléfono único
    direccion VARCHAR(150),                     -- Dirección del cliente
    recomendado_por INT,                        -- Cliente que lo recomendó
    CHECK (CHAR_LENGTH(nombre) >= 3)            -- Nombre mínimo 3 caracteres
);

-- ------------------------------------------------------
-- TABLA: Metodo_Pago
-- FUNCIÓN: Almacena los métodos de pago disponibles
-- ------------------------------------------------------
CREATE TABLE Metodo_Pago (
    id_metodo INT AUTO_INCREMENT PRIMARY KEY, -- Identificador del método
    metodo VARCHAR(50) NOT NULL               -- Nombre del método
);

-- ------------------------------------------------------
-- TABLA: Producto
-- FUNCIÓN: Catálogo de productos KFC
-- ------------------------------------------------------
CREATE TABLE Producto (
    id_producto INT AUTO_INCREMENT PRIMARY KEY, -- Identificador del producto
    nombre VARCHAR(100) NOT NULL,               -- Nombre del producto
    categoria VARCHAR(50) NOT NULL,             -- Categoría (Combos, Bebidas, etc.)
    precio DECIMAL(7,2) NOT NULL CHECK (precio > 0) -- Precio mayor que 0
);

-- ------------------------------------------------------
-- TABLA: Pedido
-- FUNCIÓN: Registro de pedidos realizados
-- ------------------------------------------------------
CREATE TABLE Pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY, -- Identificador del pedido
    id_cliente INT NOT NULL,                  -- Cliente que realiza el pedido
    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Fecha del pedido
    total DECIMAL(9,2) NOT NULL CHECK (total >= 0),    -- Total del pedido
    canal_venta VARCHAR(50) NOT NULL,         -- Canal: Local, App, Delivery
    estado VARCHAR(20) NOT NULL DEFAULT 'Pendiente', -- Estado del pedido
    id_metodo INT NOT NULL,                   -- Método de pago usado
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_metodo) REFERENCES Metodo_Pago(id_metodo)
);

-- ------------------------------------------------------
-- TABLA: Detalle_Pedido
-- FUNCIÓN: Detalle de productos incluidos en cada pedido
-- ------------------------------------------------------
CREATE TABLE Detalle_Pedido (
    id_pedido INT NOT NULL,           -- Pedido asociado
    id_producto INT NOT NULL,         -- Producto comprado
    cantidad INT NOT NULL CHECK (cantidad > 0), -- Cantidad comprada
    precio_unit DECIMAL(7,2) NOT NULL CHECK (precio_unit > 0), -- Precio unitario
    subtotal DECIMAL(9,2) NOT NULL CHECK (subtotal > 0),       -- Subtotal
    PRIMARY KEY (id_pedido, id_producto),
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

-- ------------------------------------------------------
-- AUTORREFERENCIA: Cliente recomienda a otro cliente
-- ------------------------------------------------------
ALTER TABLE Cliente
ADD FOREIGN KEY (recomendado_por) REFERENCES Cliente(id_cliente);

-- ======================================================
-- 4. INSERCIÓN DE DATOS
-- ======================================================

-- CLIENTES
INSERT INTO Cliente (nombre, telefono, direccion) VALUES
('Carlos Pérez','0991234567','Av. Amazonas y Colón'),
('María López','0987654321','Av. La Prensa'),
('Jorge Sánchez','0975558884','Quito Norte'),
('Ana Torres','0964442211','Carapungo'),
('Luis Medina','0998765432','Cumbayá'),
('Pedro Andrade','0991112233','La Floresta'),
('Lucía Ramos','0982223344','El Inca'),
('Fernando Molina','0973334455','Valle de los Chillos'),
('Sofía Herrera','0964445566','Pomasqui'),
('Andrés Vega','0955556677','Tumbaco'),
('Valentina Cruz','0946667788','Guamaní'),
('Ricardo Salazar','0937778899','La Magdalena'),
('Paola Jiménez','0928889900','San Bartolo'),
('Diego Navarro','0919990011','Iñaquito'),
('Camila Ortiz','0900001122','Calderón');

-- MÉTODOS DE PAGO
INSERT INTO Metodo_Pago (metodo) VALUES
('Efectivo'),('Tarjeta Débito'),('Tarjeta Crédito'),('PayPhone'),('Transferencia Bancaria');

-- PRODUCTOS
INSERT INTO Producto (nombre, categoria, precio) VALUES
('Combo 2 Presas + Papas + Bebida','Combos',7.99),
('Combo 3 Presas + Papas + Bebida','Combos',9.99),
('Bucket 12 Presas','Buckets',22.50),
('Alitas Picantes 6 Unidades','Snacks',6.50),
('Papas Grandes','Acompañantes',2.50),
('Ensalada Coleslaw','Acompañantes',2.00),
('Helado Sundae Caramelo','Postres',1.80),
('Coca-Cola 500ml','Bebidas',1.50),
('Nestea Durazno 500ml','Bebidas',1.50);

-- ======================================================
-- 5. PEDIDOS Y DETALLES
-- ======================================================

-- PEDIDOS
INSERT INTO Pedido (id_cliente, fecha, total, canal_venta, estado, id_metodo) VALUES
(1,'2025-01-12 13:45:00',11.99,'Local','Pagado',5),
(2,'2025-01-12 14:10:00',22.50,'Delivery','Pagado',3),
(3,'2025-01-12 14:35:00',8.00,'App','Pendiente',2),
(5,'2025-01-12 15:20:00',9.99,'Local','Pagado',4),
(6,'2025-01-13 12:10:00',10.49,'Local','Pagado',1),
(7,'2025-01-13 12:35:00',24.00,'Delivery','Pagado',3),
(8,'2025-01-13 13:00:00',5.10,'App','Pendiente',2),
(9,'2025-01-13 13:20:00',4.50,'Local','Pagado',1),
(10,'2025-01-13 13:45:00',8.00,'App','Pagado',4),
(11,'2025-01-13 14:10:00',9.99,'Local','Pendiente',5),
(12,'2025-01-13 14:30:00',22.50,'Delivery','Pagado',3),
(13,'2025-01-13 15:00:00',4.00,'Local','Pagado',1),
(14,'2025-01-13 15:20:00',6.50,'App','Pagado',2),
(15,'2025-01-13 15:45:00',17.48,'Delivery','Pendiente',3),
(1,'2025-01-14 12:10:00',9.99,'App','Pagado',2),
(4,'2025-01-14 13:00:00',22.50,'Delivery','Pagado',3);

-- DETALLE DE PEDIDOS
INSERT INTO Detalle_Pedido VALUES
(1,1,1,7.99,7.99),(1,8,1,1.50,1.50),(1,5,1,2.50,2.50),
(2,3,1,22.50,22.50),
(3,4,1,6.50,6.50),(3,9,1,1.50,1.50),
(4,2,1,9.99,9.99),
(5,1,1,7.99,7.99),(5,8,1,1.50,1.50),(5,5,1,2.50,2.50),
(6,3,1,22.50,22.50),(6,8,1,1.50,1.50),
(7,2,1,9.99,9.99),
(8,7,2,1.80,3.60),(8,8,1,1.50,1.50),
(9,5,1,2.50,2.50),(9,6,1,2.00,2.00),
(10,4,1,6.50,6.50),(10,9,1,1.50,1.50),
(11,2,1,9.99,9.99),
(12,3,1,22.50,22.50),
(13,6,2,2.00,4.00),
(14,4,1,6.50,6.50),
(15,1,2,7.99,15.98),(15,8,1,1.50,1.50),
(16,2,1,9.99,9.99),
(17,3,1,22.50,22.50);

-- ======================================================
-- SELECT PARA VERIFICAR LOS INSERT
-- ======================================================

-- 1. Mostrar todos los CLIENTES insertados
-- FUNCIÓN: Verificar que los clientes se hayan guardado correctamente
SELECT * FROM Cliente;


-- 2. Mostrar todos los MÉTODOS DE PAGO
-- FUNCIÓN: Verificar los métodos de pago disponibles
SELECT * FROM Metodo_Pago;


-- 3. Mostrar todos los PRODUCTOS
-- FUNCIÓN: Verificar el catálogo de productos insertados
SELECT * FROM Producto;


-- 4. Mostrar todos los PEDIDOS
-- FUNCIÓN: Verificar los pedidos registrados
SELECT * FROM Pedido;


-- 5. Mostrar todos los DETALLES DE PEDIDOS
-- FUNCIÓN: Verificar los productos dentro de cada pedido
SELECT * FROM Detalle_Pedido;


-- 6. Mostrar pedidos con nombre del cliente y método de pago
-- FUNCIÓN: Ver información completa del pedido (cliente + forma de pago)
SELECT 
    p.id_pedido,
    c.nombre AS cliente,
    p.fecha,
    p.total,
    p.canal_venta,
    p.estado,
    m.metodo AS metodo_pago
FROM Pedido p
JOIN Cliente c ON p.id_cliente = c.id_cliente
JOIN Metodo_Pago m ON p.id_metodo = m.id_metodo;

-- 9. Mostrar cuántos pedidos tiene cada cliente
-- FUNCIÓN: Ver actividad de compra por cliente
SELECT 
    c.nombre,
    COUNT(p.id_pedido) AS cantidad_pedidos
FROM Cliente c
LEFT JOIN Pedido p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente;


-- 10. Mostrar pedidos pendientes
-- FUNCIÓN: Ver pedidos que aún no han sido pagados
SELECT * FROM Pedido
WHERE estado = 'Pendiente';


-- 11. Mostrar solo pedidos por canal Delivery
-- FUNCIÓN: Ver pedidos que fueron realizados por Delivery
SELECT * FROM Pedido
WHERE canal_venta = 'Delivery';


-- 12. Mostrar productos más caros primero
-- FUNCIÓN: Ver los productos ordenados por precio descendente
SELECT * FROM Producto
ORDER BY precio DESC;

-- ======================================================
-- 6. CONSULTAS CON FUNCIÓN Y REQUISITO
-- ======================================================

-- REQUISITO: Condición de igualdad sobre un atributo entero
-- FUNCIÓN: Buscar pedidos realizados por un cliente específico (id_cliente = 1)
SELECT * FROM Pedido
WHERE id_cliente = 1;

-- REQUISITO: Condición de igualdad sobre un atributo de tipo cadena
-- FUNCIÓN: Buscar un cliente por su nombre exacto
SELECT * FROM Cliente
WHERE nombre = 'Ana Torres';

-- REQUISITO: Condición mayor o igual sobre un atributo decimal
-- FUNCIÓN: Mostrar productos cuyo precio es mayor o igual a 5 dólares
SELECT * FROM Producto
WHERE precio >= 5;

-- REQUISITO: Condición distinto aplicado a cadena
-- FUNCIÓN: Mostrar pedidos que no están en estado 'Pagado'
SELECT * FROM Pedido
WHERE estado <> 'Pagado';

-- REQUISITO: Uso del operador IN
-- FUNCIÓN: Filtrar productos que pertenezcan a ciertas categorías
SELECT * FROM Producto
WHERE categoria IN ('Bebidas','Postres');

-- REQUISITO: Uso del operador AND
-- FUNCIÓN: Mostrar pedidos que estén pagados y además sean ventas locales
SELECT * FROM Pedido
WHERE estado = 'Pagado' AND canal_venta = 'Local';

-- REQUISITO: Uso del operador OR
-- FUNCIÓN: Mostrar pedidos que se realizaron por App o por Delivery
SELECT * FROM Pedido
WHERE canal_venta = 'App' OR canal_venta = 'Delivery';

-- REQUISITO: Uso del operador NOT
-- FUNCIÓN: Mostrar pedidos que no estén pagados
SELECT * FROM Pedido
WHERE NOT estado = 'Pagado';

-- REQUISITO: JOIN entre dos tablas
-- FUNCIÓN: Mostrar el nombre del cliente junto con el número de pedido
SELECT c.nombre, p.id_pedido
FROM Pedido p
JOIN Cliente c ON p.id_cliente = c.id_cliente;

-- REQUISITO: LEFT JOIN
-- FUNCIÓN: Mostrar todos los clientes aunque no tengan pedidos
SELECT c.nombre, p.id_pedido
FROM Cliente c
LEFT JOIN Pedido p ON c.id_cliente = p.id_cliente;

-- REQUISITO: ORDER BY
-- FUNCIÓN: Ordenar los productos desde el más caro al más barato
SELECT * FROM Producto
ORDER BY precio DESC;

-- REQUISITO: GROUP BY con función agregada
-- FUNCIÓN: Contar cuántos pedidos existen por cada canal de venta
SELECT canal_venta, COUNT(*) AS total_pedidos
FROM Pedido
GROUP BY canal_venta;

-- REQUISITO: Uso de CASE
-- FUNCIÓN: Clasificar pedidos según el monto total
SELECT id_pedido, total,
CASE
    WHEN total < 10 THEN 'Pedido Pequeño'
    WHEN total BETWEEN 10 AND 20 THEN 'Pedido Mediano'
    ELSE 'Pedido Grande'
END AS clasificacion
FROM Pedido;

-- REQUISITO: Subconsulta
-- FUNCIÓN: Obtener pedidos del cliente llamado 'Carlos Pérez'
SELECT * FROM Pedido
WHERE id_cliente = (
    SELECT id_cliente FROM Cliente WHERE nombre = 'Carlos Pérez'
);

-- REQUISITO: Uso de EXISTS
-- FUNCIÓN: Mostrar solo los clientes que tienen al menos un pedido registrado
SELECT * FROM Cliente c
WHERE EXISTS (
    SELECT 1 FROM Pedido p WHERE p.id_cliente = c.id_cliente
);
