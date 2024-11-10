-- Crear la base de datos y usarla
CREATE DATABASE Balanceeasy;
USE Balanceeasy;

-- Crear la tabla herramientas para referencia foránea en prestamos
CREATE TABLE herramientas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT
);

-- Crear la tabla usuarios
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(255) NOT NULL,
    tipo_documento VARCHAR(20) NOT NULL,
    documento VARCHAR(20) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    numero_de_telefono VARCHAR(15) NOT NULL,
    rol VARCHAR(20) NOT NULL,
    estado VARCHAR(20) NOT NULL,
    correo_electronico VARCHAR(255) UNIQUE
);

-- Crear la tabla pagos
CREATE TABLE pagos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    banco VARCHAR(255) NOT NULL,
    cantidad DECIMAL(10, 2) NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    estado VARCHAR(20) NOT NULL
);

-- Crear la tabla prestamos con llaves foráneas a usuarios y herramientas
CREATE TABLE prestamos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fecha_prestamo DATE NOT NULL,
    fecha_devolucion DATE,
    estado VARCHAR(20) NOT NULL,
    id_usuario INT NOT NULL,
    id_herramienta INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id),
    FOREIGN KEY (id_herramienta) REFERENCES herramientas(id)
);
