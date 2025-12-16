-- ======================================================
-- CREACIÓN BASE DE DATOS
-- ======================================================
CREATE DATABASE KFC_Pedidos;

SHOW DATABASES;

USE KFC_Pedidos;

-- ======================================================
-- ELIMINAR TABLAS
-- ======================================================
DROP TABLE IF EXISTS Detalle_Pedido;
DROP TABLE IF EXISTS Pedido;
DROP TABLE IF EXISTS Producto;
DROP TABLE IF EXISTS Metodo_Pago;
DROP TABLE IF EXISTS Cliente;

-- ======================================================
-- TABLA: Cliente
-- ======================================================
CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(100),
    telefono VARCHAR(20),
    direccion VARCHAR(150)
);

INSERT INTO Cliente VALUES
(1,'Carlos Pérez','0991234567','Av. Amazonas y Colón'),
(2,'María López','0987654321','Av. La Prensa'),
(3,'Jorge Sánchez','0975558884','Quito Norte'),
(4,'Ana Torres','0964442211','Carapungo'),
(5,'Luis Medina','0998765432','Cumbayá');

-- ======================================================
-- TABLA: Metodo_Pago
-- ======================================================
CREATE TABLE Metodo_Pago (
    id_metodo INT PRIMARY KEY,
    metodo VARCHAR(50)
);

INSERT INTO Metodo_Pago VALUES
(1,'Efectivo'),
(2,'Tarjeta Débito'),
(3,'Tarjeta Crédito'),
(4,'PayPhone'),
(5,'Transferencia Bancaria');

-- ======================================================
-- TABLA: Producto
-- ======================================================
CREATE TABLE Producto (
    id_producto INT PRIMARY KEY,
    nombre VARCHAR(100),
    categoria VARCHAR(50),
    precio DECIMAL(5,2)
);

-- Validación de precio
ALTER TABLE Producto
ADD CONSTRAINT producto_precio_ck
CHECK (precio > 0);

INSERT INTO Producto VALUES
(1,'Combo 2 Presas + Papas + Bebida','Combos',7.99),
(2,'Combo 3 Presas + Papas + Bebida','Combos',9.99),
(3,'Bucket 12 Presas','Buckets',22.50),
(4,'Alitas Picantes 6 Unidades','Snacks',6.50),
(5,'Papas Grandes','Acompañantes',2.50),
(6,'Ensalada Coleslaw','Acompañantes',2.00),
(7,'Helado Sundae Caramelo','Postres',1.80),
(8,'Coca-Cola 500ml','Bebidas',1.50),
(9,'Nestea Durazno 500ml','Bebidas',1.50);

-- ======================================================
-- TABLA: Pedido
-- ======================================================
CREATE TABLE Pedido (
    id_pedido INT PRIMARY KEY,
    id_cliente INT,
    fecha DATETIME,
    total DECIMAL(7,2),
    canal_venta VARCHAR(50),
    estado VARCHAR(20),
    id_metodo INT
);

-- Claves foráneas
ALTER TABLE Pedido
ADD CONSTRAINT pedido_cliente_fk
FOREIGN KEY (id_cliente)
REFERENCES Cliente(id_cliente);

ALTER TABLE Pedido
ADD CONSTRAINT pedido_metodo_fk
FOREIGN KEY (id_metodo)
REFERENCES Metodo_Pago(id_metodo);

-- Validación de total
ALTER TABLE Pedido
ADD CONSTRAINT pedido_total_ck
CHECK (total >= 0);

INSERT INTO Pedido VALUES
(1,1,'2025-01-12 13:45:00',17.48,'Local','Pagado',5),
(2,2,'2025-01-12 14:10:00',22.50,'Delivery','Pagado',3),
(3,3,'2025-01-12 14:35:00',11.49,'App','Pendiente',2),
(4,5,'2025-01-12 15:20:00',9.49,'Local','Pagado',4);

-- ======================================================
-- TABLA: Detalle_Pedido
-- ======================================================
CREATE TABLE Detalle_Pedido (
    id_pedido INT,
    id_producto INT,
    cantidad INT,
    precio_unit DECIMAL(5,2),
    subtotal DECIMAL(7,2)
);

-- Clave primaria compuesta
ALTER TABLE Detalle_Pedido
ADD PRIMARY KEY (id_pedido, id_producto);

-- Claves foráneas
ALTER TABLE Detalle_Pedido
ADD CONSTRAINT detalle_pedido_fk
FOREIGN KEY (id_pedido)
REFERENCES Pedido(id_pedido);

ALTER TABLE Detalle_Pedido
ADD CONSTRAINT detalle_producto_fk
FOREIGN KEY (id_producto)
REFERENCES Producto(id_producto);

-- Validaciones
ALTER TABLE Detalle_Pedido
ADD CONSTRAINT detalle_cantidad_ck
CHECK (cantidad > 0);

ALTER TABLE Detalle_Pedido
ADD CONSTRAINT detalle_precio_ck
CHECK (precio_unit > 0);

INSERT INTO Detalle_Pedido VALUES
(1,1,1,7.99,7.99),
(1,8,1,1.50,1.50),
(1,5,1,2.50,2.50),
(2,3,1,22.50,22.50),
(3,4,1,6.50,6.50),
(3,9,1,1.50,1.50),
(4,2,1,9.99,9.99);

-- ======================================================
-- CONSULTAS
-- ======================================================
SHOW TABLES;

SELECT * FROM Cliente;
SELECT * FROM Producto;
SELECT * FROM Pedido;
SELECT * FROM Detalle_Pedido;
