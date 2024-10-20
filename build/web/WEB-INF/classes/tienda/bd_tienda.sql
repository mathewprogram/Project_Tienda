-- ---------------------------
-- ESTRUCTURA DE LA BASE DATOS
-- ---------------------------

-- ACTIVAR LA BASE DE DATOS PRINCIPAL DE POSTGRESQL

\c postgres

-- CREAR UNA BASE DE DATOS

DROP DATABASE IF EXISTS Tienda;

CREATE DATABASE TIENDA;

-- USAR UNA BASE DE DATOS

\c tienda

-- Crear usuario
DROP TABLE IF EXISTS Usuario;
CREATE TABLE Usuario(
    id_usuario        SERIAL       PRIMARY KEY,
    nombre            VARCHAR(25)  NOT NULL,
    apellidos         VARCHAR(50)  NOT NULL,
    username          VARCHAR(25)  UNIQUE NOT NULL,   -- Unicidad
    password          VARCHAR(255) NOT NULL,         -- Mayor longitud para contraseñas hasheadas
    fecha_nacimiento  DATE         NOT NULL
);

-- Crear tabla Producto
DROP TABLE IF EXISTS Producto;
CREATE TABLE Producto(
    id_producto      SERIAL         PRIMARY KEY,
    nombre           VARCHAR(25)    NOT NULL,
    precio           NUMERIC(10, 2) NOT NULL,       -- Usar NUMERIC para precios
    departament      VARCHAR(25)    NOT NULL,   
    cantidad         INT            NOT NULL
);

-- -----
-- DATOS
-- -----

-- INSERTAR registros en Usuario
INSERT INTO Usuario (nombre, apellidos, username, password, fecha_nacimiento) VALUES
('Michael', 'Mathew', 'mathew', 'Passw0rd!', '1991-01-17'),
('Lavinia', 'Mathew', 'lavinia', 'Passw0rd!', '1983-12-28');

-- Insertar registros en Productos 
INSERT INTO Producto(nombre, precio, departament, cantidad) VALUES
('Camiseta deportiva', 25.99, 'Ropa', 50),
('Sudadera con capucha', 39.99, 'Ropa', 30),
('Laptop Gamer', 1200.00, 'Tecnología', 10),
('Smartphone', 800.00, 'Tecnología', 25),
('Cargador portátil', 19.99, 'Tecnología', 40),
('Silla ergonómica', 150.00, 'Muebles', 20),
('Mesa de comedor', 499.99, 'Muebles', 15),
('Armario de madera', 299.99, 'Muebles', 5),
('Libro de cocina', 19.99, 'Libros', 100),
('Libro de ciencia ficción', 14.99, 'Libros', 60),
('Juego de cuchillos', 59.99, 'Cocina', 50),
('Cafetera automática', 99.99, 'Cocina', 30),
('Tetera de vidrio', 24.99, 'Cocina', 40),
('Foco LED', 12.99, 'Iluminación', 80),
('Lámpara de mesa', 45.00, 'Iluminación', 25),
('Taladro inalámbrico', 89.99, 'Herramientas', 10),
('Llave ajustable', 14.99, 'Herramientas', 50),
('Martillo', 12.50, 'Herramientas', 75),
('Zapatos de cuero', 99.99, 'Calzado', 25),
('Botas de montaña', 120.00, 'Calzado', 15);

SELECT * FROM Usuario;
SELECT * FROM Producto;
