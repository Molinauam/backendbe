-- Deshabilitar temporalmente las verificaciones de restricciones
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- Crear los esquemas si no existen
CREATE SCHEMA IF NOT EXISTS mydb DEFAULT CHARACTER SET utf8;
CREATE SCHEMA IF NOT EXISTS Balanceeasy;

-- Usar el esquema Balanceeasy
USE Balanceeasy;

-- Crear tabla usuarios
CREATE TABLE IF NOT EXISTS Balanceeasy.usuarios (
  id_usuario INT NOT NULL AUTO_INCREMENT,
  identificador INT NOT NULL,
  nombre_completo VARCHAR(255) NOT NULL,
  documento VARCHAR(255) NOT NULL,
  correo VARCHAR(255) NOT NULL,
  telefono VARCHAR(255) NOT NULL,
  contrasena VARCHAR(255) NOT NULL,
  privilegios VARCHAR(255) NOT NULL,
  estado TINYINT NOT NULL,
  usuarioscol VARCHAR(45) NULL,
  PRIMARY KEY (id_usuario)
);

-- Crear tabla herramientas
CREATE TABLE IF NOT EXISTS Balanceeasy.herramientas (
  id_herramienta INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(255) NOT NULL,
  descripcion TEXT,
  PRIMARY KEY (id_herramienta)
);

-- Crear tabla prestamos
CREATE TABLE IF NOT EXISTS Balanceeasy.prestamos (
  id_prestamo INT NOT NULL AUTO_INCREMENT,
  fecha_prestamo DATE NOT NULL,
  fecha_Fin DATE NOT NULL,
  fecha_devolucion DATE NOT NULL,
  estado TINYINT NOT NULL,
  usuarios_id_usuario INT NOT NULL,
  PRIMARY KEY (id_prestamo),
  CONSTRAINT fk_prestamos_usuarios1
    FOREIGN KEY (usuarios_id_usuario)
    REFERENCES Balanceeasy.usuarios (id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- Crear tabla pagos
CREATE TABLE IF NOT EXISTS Balanceeasy.pagos (
  id_pago INT NOT NULL AUTO_INCREMENT,
  banco VARCHAR(255) NOT NULL,
  cantidad DECIMAL(10, 2) NOT NULL,
  valor DECIMAL(10, 2) NOT NULL,
  estado TINYINT NOT NULL,
  PRIMARY KEY (id_pago)
);

-- Usar el esquema mydb
USE mydb;

-- Crear tabla detalle_prestamos
CREATE TABLE IF NOT EXISTS mydb.detalle_prestamos (
  id INT NOT NULL AUTO_INCREMENT,
  prestamos_id_prestamo INT NOT NULL,
  herramientas_id_herramienta INT NOT NULL,
  estado TINYINT NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_detalle_prestamos_prestamos1
    FOREIGN KEY (prestamos_id_prestamo)
    REFERENCES Balanceeasy.prestamos (id_prestamo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_detalle_prestamos_herramientas1
    FOREIGN KEY (herramientas_id_herramienta)
    REFERENCES Balanceeasy.herramientas (id_herramienta)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Volver a usar el esquema Balanceeasy
USE Balanceeasy;

-- Crear tabla paz_salvos
CREATE TABLE IF NOT EXISTS Balanceeasy.paz_salvos (
  id_pazysalvo INT NOT NULL AUTO_INCREMENT,
  fecha_generacion DATE NOT NULL,
  estado TINYINT NOT NULL,
  Usuario_id_usuario INT NOT NULL,
  PRIMARY KEY (id_pazysalvo),
  CONSTRAINT fk_pazYSalvo_Usuario1
    FOREIGN KEY (Usuario_id_usuario)
    REFERENCES Balanceeasy.usuarios (id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- Crear tabla penalizaciones
CREATE TABLE IF NOT EXISTS Balanceeasy.penalizaciones (
  id_pen INT NOT NULL AUTO_INCREMENT,
  fecha_pen DATE NOT NULL,
  estado_pen VARCHAR(255) NOT NULL,
  motivo_pen VARCHAR(255) NOT NULL,
  id_prestamo INT NOT NULL,
  PRIMARY KEY (id_pen)
);

-- Revertir cambios de modo SQL y verificaciones de restricciones
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- Insertar, actualizar y eliminar registros en cada tabla

-- Tabla usuarios
INSERT INTO Balanceeasy.usuarios (identificador, nombre_completo, documento, correo, telefono, contrasena, privilegios, estado, usuarioscol)
VALUES (1, 'Juan Pérez', '123456789', 'juan.perez@example.com', '555-1234', 'password123', 'admin', 1, NULL);

UPDATE Balanceeasy.usuarios
SET nombre_completo = 'Juan Pérez Gómez', telefono = '555-5678'
WHERE id_usuario = 1;

DELETE FROM Balanceeasy.usuarios
WHERE id_usuario = 1;

-- Tabla prestamos
INSERT INTO Balanceeasy.prestamos (fecha_prestamo, fecha_Fin, fecha_devolucion, estado, usuarios_id_usuario)
VALUES ('2024-01-01', '2024-02-01', '2024-01-15', 1, 1);

UPDATE Balanceeasy.prestamos
SET fecha_devolucion = '2024-01-20', estado = 0
WHERE id_prestamo = 1;

DELETE FROM Balanceeasy.prestamos
WHERE id_prestamo = 1;

-- Tabla pagos
INSERT INTO Balanceeasy.pagos (banco, cantidad, valor, estado)
VALUES ('Banco XYZ', 1000.00, 950.00, 1);

UPDATE Balanceeasy.pagos
SET cantidad = 1050.00, valor = 1000.00
WHERE id_pago = 1;

DELETE FROM Balanceeasy.pagos
WHERE id_pago = 1;

-- Tabla detalle_prestamos
INSERT INTO mydb.detalle_prestamos (prestamos_id_prestamo, herramientas_id_herramienta, estado)
VALUES (1, 1, 1);

UPDATE mydb.detalle_prestamos
SET estado = 0
WHERE id = 1;

DELETE FROM mydb.detalle_prestamos
WHERE id = 1;

-- Tabla paz_salvos
INSERT INTO Balanceeasy.paz_salvos (fecha_generacion, estado, Usuario_id_usuario)
VALUES ('2024-01-01', 1, 1);

UPDATE Balanceeasy.paz_salvos
SET estado = 0
WHERE id_pazysalvo = 1;

DELETE FROM Balanceeasy.paz_salvos
WHERE id_pazysalvo = 1;

-- Tabla penalizaciones
INSERT INTO Balanceeasy.penalizaciones (fecha_pen, estado_pen, motivo_pen, id_prestamo)
VALUES ('2024-01-05', 'Pendiente', 'Mora en pago', 1);

UPDATE Balanceeasy.penalizaciones
SET estado_pen = 'Pagada'
WHERE id_pen = 1;

DELETE FROM Balanceeasy.penalizaciones
WHERE id_pen = 1;
