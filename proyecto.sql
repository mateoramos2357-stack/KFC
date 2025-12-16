-- ======================================================
--   CREACIÓN BASE DE DATOS
-- ======================================================
CREATE DATABASE IF NOT EXISTS KFC_Pedidos;
USE KFC_Pedidos;

-- ======================================================
--   RESETEAR TODAS LAS TABLAS CORRECTAMENTE
-- ======================================================
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS Detalle_Pedido;
DROP TABLE IF EXISTS Pedido;
DROP TABLE IF EXISTS Producto;
DROP TABLE IF EXISTS Metodo_Pago;
DROP TABLE IF EXISTS Cliente;

SET FOREIGN_KEY_CHECKS = 1;

-- ======================================================
--   TABLA: Cliente
-- ======================================================
CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(100),
    telefono VARCHAR(20),
    direccion VARCHAR(150)
);

INSERT INTO Cliente (nombre, telefono, direccion) VALUES
('Carlos Pérez', '0991234567', 'Av. Amazonas y Colón'),
('María López', '0987654321', 'Av. La Prensa'),
('Jorge Sánchez', '0975558884', 'Quito Norte'),
('Ana Torres', '0964442211', 'Carapungo'),
('Luis Medina', '0998765432', 'Cumbayá');

-- ======================================================
--   TABLA: Metodo_Pago
-- ======================================================
CREATE TABLE Metodo_Pago (
    id_metodo INT PRIMARY KEY,
    metodo VARCHAR(50)
);

INSERT INTO Metodo_Pago (metodo) VALUES
('Efectivo'),
('Tarjeta Débito'),
('Tarjeta Crédito'),
('PayPhone'),
('Transferencia Bancaria');

-- ======================================================
--   TABLA: Producto (MENÚ)
-- ======================================================
CREATE TABLE Producto (
    id_producto INT PRIMARY KEY,
    nombre VARCHAR(100),
    categoria VARCHAR(50),
    precio DECIMAL(5,2)
);

INSERT INTO Producto (nombre, categoria, precio) VALUES
('Combo 2 Presas + Papas + Bebida', 'Combos', 7.99),
('Combo 3 Presas + Papas + Bebida', 'Combos', 9.99),
('Bucket 12 Presas', 'Buckets', 22.50),
('Alitas Picantes 6 Unidades', 'Snacks', 6.50),
('Papas Grandes', 'Acompañantes', 2.50),
('Ensalada Coleslaw', 'Acompañantes', 2.00),
('Helado Sundae Caramelo', 'Postres', 1.80),
('Coca-Cola 500ml', 'Bebidas', 1.50),
('Nestea Durazno 500ml', 'Bebidas', 1.50);

-- ======================================================
--   TABLA: Pedido
-- ======================================================
CREATE TABLE Pedido (
    id_pedido INT PRIMARY KEY,
    id_cliente INT,
    fecha DATETIME,
    total DECIMAL(7,2),
    canal_venta VARCHAR(50),
    estado VARCHAR(20),
    id_metodo INT,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_metodo) REFERENCES Metodo_Pago(id_metodo)
);

INSERT INTO Pedido (id_cliente, fecha, total, canal_venta, estado, id_metodo) VALUES
(1, '2025-01-12 13:45:00', 17.48, 'Local', 'Pagado', 1),
(2, '2025-01-12 14:10:00', 22.50, 'Delivery', 'Pagado', 3),
(3, '2025-01-12 14:35:00', 11.49, 'App', 'Pendiente', 2),
(5, '2025-01-12 15:20:00', 9.49, 'Local', 'Pagado', 4);

-- ======================================================
--   TABLA: Detalle_Pedido
-- ======================================================
CREATE TABLE Detalle_Pedido (
    id_detalle INT PRIMARY KEY,
    id_pedido INT,
    id_producto INT,
    cantidad INT,
    precio_unit DECIMAL(5,2),
    subtotal DECIMAL(7,2),
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

INSERT INTO Detalle_Pedido (id_pedido, id_producto, cantidad, precio_unit, subtotal) VALUES
-- Pedido 1
(1, 1, 1, 7.99, 7.99),
(1, 8, 1, 1.50, 1.50),
(1, 5, 1, 2.50, 2.50),

-- Pedido 2
(2, 3, 1, 22.50, 22.50),

-- Pedido 3
(3, 4, 1, 6.50, 6.50),
(3, 9, 1, 1.50, 1.50),

-- Pedido 4
(4, 2, 1, 9.99, 9.99);

