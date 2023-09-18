/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: activos
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `activos` (
  `idActivo` int(11) NOT NULL AUTO_INCREMENT,
  `idTipo` int(11) NOT NULL,
  `Imagen` varchar(200) NOT NULL,
  `Procedencia` varchar(50) NOT NULL,
  `Descripcion` text DEFAULT NULL,
  `FechaRegistro` datetime NOT NULL DEFAULT current_timestamp(),
  `ValorRegistro` decimal(11, 2) DEFAULT NULL,
  `ValorActual` decimal(11, 2) DEFAULT NULL,
  `VidaUtilActual` int(11) DEFAULT 0,
  `Observaciones` text DEFAULT NULL,
  `UfvInicial` decimal(11, 6) DEFAULT 0.000000,
  `Estado` varchar(50) DEFAULT 'Activo',
  `Anio` int(11) DEFAULT 0,
  `Mes` int(11) DEFAULT 0,
  `idCondicion` int(11) DEFAULT NULL,
  `idRubro` int(11) DEFAULT NULL,
  `idProveedor` int(11) DEFAULT NULL,
  PRIMARY KEY (`idActivo`),
  KEY `idCondicion` (`idCondicion`),
  KEY `idRubro` (`idRubro`),
  KEY `idProveedor` (`idProveedor`),
  CONSTRAINT `idCondicion` FOREIGN KEY (`idCondicion`) REFERENCES `condiciones` (`idCondicion`),
  CONSTRAINT `idProveedor` FOREIGN KEY (`idProveedor`) REFERENCES `proveedores` (`idProveedor`),
  CONSTRAINT `idRubro` FOREIGN KEY (`idRubro`) REFERENCES `rubros` (`idRubro`)
) ENGINE = InnoDB AUTO_INCREMENT = 16 DEFAULT CHARSET = utf8mb4;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: altaactivos
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `altaactivos` (
  `idAlta` int(11) NOT NULL AUTO_INCREMENT,
  `Codificacion` varchar(150) DEFAULT NULL,
  `FechaHora` datetime NOT NULL DEFAULT current_timestamp(),
  `Qr` text DEFAULT NULL,
  `idActiv` int(11) NOT NULL,
  `idEmpleado` int(11) DEFAULT NULL,
  `idProyecto` int(11) DEFAULT NULL,
  `idAmbiente` int(11) DEFAULT NULL,
  PRIMARY KEY (`idAlta`),
  KEY `idActiv` (`idActiv`),
  KEY `idProyecto` (`idProyecto`),
  KEY `idEmpleado` (`idEmpleado`),
  KEY `idAmbiente` (`idAmbiente`),
  CONSTRAINT `idActiv` FOREIGN KEY (`idActiv`) REFERENCES `activos` (`idActivo`),
  CONSTRAINT `idAmbiente` FOREIGN KEY (`idAmbiente`) REFERENCES `ambientes` (`idAmbiente`),
  CONSTRAINT `idEmpleado` FOREIGN KEY (`idEmpleado`) REFERENCES `empleados` (`idEmpleado`),
  CONSTRAINT `idProyecto` FOREIGN KEY (`idProyecto`) REFERENCES `proyectos` (`idProyecto`)
) ENGINE = InnoDB AUTO_INCREMENT = 21 DEFAULT CHARSET = utf8mb4;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: ambientes
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `ambientes` (
  `idAmbiente` int(11) NOT NULL AUTO_INCREMENT,
  `NombreAmb` varchar(150) NOT NULL,
  `DescripcionAmb` text DEFAULT NULL,
  `idEdificio` int(11) NOT NULL,
  PRIMARY KEY (`idAmbiente`),
  KEY `idEdificio` (`idEdificio`),
  CONSTRAINT `idEdificio` FOREIGN KEY (`idEdificio`) REFERENCES `edificios` (`idEdificio`)
) ENGINE = InnoDB AUTO_INCREMENT = 9 DEFAULT CHARSET = utf8mb4;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: bajas
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `bajas` (
  `idBaja` int(11) NOT NULL AUTO_INCREMENT,
  `FechaBaja` datetime NOT NULL DEFAULT current_timestamp(),
  `Motivo` varchar(400) DEFAULT NULL,
  `idActi` int(11) NOT NULL,
  PRIMARY KEY (`idBaja`),
  KEY `idActi` (`idActi`),
  CONSTRAINT `idActi` FOREIGN KEY (`idActi`) REFERENCES `activos` (`idActivo`)
) ENGINE = InnoDB AUTO_INCREMENT = 3 DEFAULT CHARSET = utf8mb4;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: condiciones
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `condiciones` (
  `idCondicion` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idCondicion`)
) ENGINE = InnoDB AUTO_INCREMENT = 7 DEFAULT CHARSET = utf8mb4;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: depreciaciones
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `depreciaciones` (
  `idDepreciacion` int(11) NOT NULL AUTO_INCREMENT,
  `UfvActual` decimal(11, 6) DEFAULT NULL,
  `UfvInicial` decimal(11, 6) DEFAULT NULL,
  `Fecha` datetime NOT NULL DEFAULT current_timestamp(),
  `ValorContabilizado` decimal(11, 2) DEFAULT NULL,
  `FactorActual` decimal(11, 6) DEFAULT NULL,
  `ValorActualizado` decimal(11, 2) DEFAULT NULL,
  `IncrementoActual` decimal(11, 2) DEFAULT NULL,
  `DepreciacionAcuAnt` decimal(11, 2) DEFAULT NULL,
  `IncrementoDepAcu` decimal(11, 2) DEFAULT NULL,
  `DepreciacionPeriodo` decimal(11, 2) DEFAULT NULL,
  `DepreciacionAcuAct` decimal(11, 2) DEFAULT NULL,
  `ValorNeto` decimal(11, 2) DEFAULT NULL,
  `PorcentajeDep` decimal(11, 2) DEFAULT NULL,
  `VidaUtilActual` int(11) DEFAULT NULL,
  `VidaUtilMes` int(11) DEFAULT NULL,
  `idActivo` int(11) NOT NULL,
  PRIMARY KEY (`idDepreciacion`),
  KEY `idActivo` (`idActivo`),
  CONSTRAINT `idActivo` FOREIGN KEY (`idActivo`) REFERENCES `activos` (`idActivo`)
) ENGINE = InnoDB AUTO_INCREMENT = 18 DEFAULT CHARSET = utf8mb4;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: devoluciones
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `devoluciones` (
  `idDevolucion` int(11) NOT NULL AUTO_INCREMENT,
  `CodActivo` int(11) DEFAULT NULL,
  `CodEmpleado` int(11) DEFAULT NULL,
  `idCondici` int(11) DEFAULT NULL,
  `Motivo` varchar(200) DEFAULT NULL,
  `FechaDevolucion` datetime NOT NULL DEFAULT current_timestamp(),
  `Proyecto` text DEFAULT NULL,
  `Observaciones` text DEFAULT NULL,
  PRIMARY KEY (`idDevolucion`),
  KEY `idCondici` (`idCondici`),
  CONSTRAINT `idCondici` FOREIGN KEY (`idCondici`) REFERENCES `condiciones` (`idCondicion`)
) ENGINE = InnoDB AUTO_INCREMENT = 14 DEFAULT CHARSET = utf8mb4;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: edificios
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `edificios` (
  `idEdificio` int(11) NOT NULL AUTO_INCREMENT,
  `NombreEdi` varchar(300) DEFAULT NULL,
  `Servicio` text DEFAULT NULL,
  `Direccion` varchar(100) DEFAULT NULL,
  `idUbicacion` int(11) NOT NULL,
  PRIMARY KEY (`idEdificio`),
  KEY `idUbicacion` (`idUbicacion`),
  CONSTRAINT `idUbicacion` FOREIGN KEY (`idUbicacion`) REFERENCES `ubicaciones` (`idUbicacion`)
) ENGINE = InnoDB AUTO_INCREMENT = 4 DEFAULT CHARSET = utf8mb4;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: empleados
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `empleados` (
  `idEmpleado` int(11) NOT NULL AUTO_INCREMENT,
  `Nombres` varchar(50) NOT NULL,
  `Apellidos` varchar(100) NOT NULL,
  `Cargo` varchar(100) NOT NULL,
  `Telefono` varchar(15) NOT NULL,
  `Direccion` varchar(200) DEFAULT NULL,
  `idAmbient` int(11) NOT NULL,
  PRIMARY KEY (`idEmpleado`),
  KEY `idAmbient` (`idAmbient`),
  CONSTRAINT `idAmbient` FOREIGN KEY (`idAmbient`) REFERENCES `ambientes` (`idAmbiente`)
) ENGINE = InnoDB AUTO_INCREMENT = 6 DEFAULT CHARSET = utf8mb4;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: mantenimiento
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `mantenimiento` (
  `idMant` int(11) NOT NULL AUTO_INCREMENT,
  `FechaMant` date NOT NULL,
  `Informe` varchar(400) DEFAULT NULL,
  `Costo` decimal(11, 2) DEFAULT NULL,
  `Estado` varchar(50) DEFAULT NULL,
  `idAct` int(11) NOT NULL,
  PRIMARY KEY (`idMant`),
  KEY `idAct` (`idAct`),
  CONSTRAINT `idAct` FOREIGN KEY (`idAct`) REFERENCES `activos` (`idActivo`)
) ENGINE = InnoDB AUTO_INCREMENT = 11 DEFAULT CHARSET = utf8mb4;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: programas
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `programas` (
  `idPrograma` int(11) NOT NULL AUTO_INCREMENT,
  `NombreProg` varchar(150) NOT NULL,
  PRIMARY KEY (`idPrograma`)
) ENGINE = InnoDB AUTO_INCREMENT = 9 DEFAULT CHARSET = utf8mb4;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: proveedores
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `proveedores` (
  `idProveedor` int(11) NOT NULL AUTO_INCREMENT,
  `NombreProv` varchar(70) DEFAULT NULL,
  `DireccionProv` varchar(200) DEFAULT NULL,
  `TelefonoProv` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`idProveedor`)
) ENGINE = InnoDB AUTO_INCREMENT = 6 DEFAULT CHARSET = utf8mb4;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: proyectos
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `proyectos` (
  `idProyecto` int(11) NOT NULL AUTO_INCREMENT,
  `NombrePro` text DEFAULT NULL,
  `FechaInicio` date DEFAULT NULL,
  `FechaFin` date DEFAULT NULL,
  `idPrograma` int(11) DEFAULT NULL,
  PRIMARY KEY (`idProyecto`),
  KEY `idPrograma` (`idPrograma`),
  CONSTRAINT `idPrograma` FOREIGN KEY (`idPrograma`) REFERENCES `programas` (`idPrograma`)
) ENGINE = InnoDB AUTO_INCREMENT = 6 DEFAULT CHARSET = utf8mb4;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: revalorizaciones
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `revalorizaciones` (
  `idRevalorizacion` int(11) NOT NULL AUTO_INCREMENT,
  `CodActivo` int(11) NOT NULL,
  `FechaRev` datetime NOT NULL DEFAULT current_timestamp(),
  `ValorNuevo` decimal(11, 2) DEFAULT NULL,
  `VidaUtilRev` int(11) DEFAULT NULL,
  `DescripcionRev` text DEFAULT NULL,
  PRIMARY KEY (`idRevalorizacion`),
  KEY `CodActivo` (`CodActivo`),
  CONSTRAINT `CodActivo` FOREIGN KEY (`CodActivo`) REFERENCES `activos` (`idActivo`)
) ENGINE = InnoDB AUTO_INCREMENT = 13 DEFAULT CHARSET = utf8mb4;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: rubros
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `rubros` (
  `idRubro` int(11) NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(50) DEFAULT NULL,
  `VidaUtil` int(11) DEFAULT NULL,
  `Depreciable` tinyint(1) DEFAULT NULL,
  `CoeficienteD` float DEFAULT NULL,
  `Actualiza` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`idRubro`)
) ENGINE = InnoDB AUTO_INCREMENT = 13 DEFAULT CHARSET = utf8mb4;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: tiposactivos
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `tiposactivos` (
  `idTipo` int(11) NOT NULL AUTO_INCREMENT,
  `NombreActivo` varchar(80) DEFAULT NULL,
  `DescripcionMant` text DEFAULT NULL,
  PRIMARY KEY (`idTipo`)
) ENGINE = InnoDB AUTO_INCREMENT = 14 DEFAULT CHARSET = utf8mb4;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: ubicaciones
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `ubicaciones` (
  `idUbicacion` int(11) NOT NULL AUTO_INCREMENT,
  `NombreLugar` varchar(150) NOT NULL,
  PRIMARY KEY (`idUbicacion`)
) ENGINE = InnoDB AUTO_INCREMENT = 10 DEFAULT CHARSET = utf8mb4;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: usuarios
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `usuarios` (
  `idUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `idEmplead` int(11) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Password` varchar(70) DEFAULT NULL,
  `Rol` varchar(50) DEFAULT NULL,
  `Estado` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idUsuario`),
  KEY `idEmplead` (`idEmplead`),
  CONSTRAINT `idEmplead` FOREIGN KEY (`idEmplead`) REFERENCES `empleados` (`idEmpleado`)
) ENGINE = InnoDB AUTO_INCREMENT = 3 DEFAULT CHARSET = utf8mb4;

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: activos
# ------------------------------------------------------------

INSERT INTO
  `activos` (
    `idActivo`,
    `idTipo`,
    `Imagen`,
    `Procedencia`,
    `Descripcion`,
    `FechaRegistro`,
    `ValorRegistro`,
    `ValorActual`,
    `VidaUtilActual`,
    `Observaciones`,
    `UfvInicial`,
    `Estado`,
    `Anio`,
    `Mes`,
    `idCondicion`,
    `idRubro`,
    `idProveedor`
  )
VALUES
  (
    2,
    3,
    'Do8UY1R5uptXpGbYaTkNOiok.jpg',
    'Compra',
    'Monitor LG Modelo: 004+PFAWPN serie NO:004+PX35088',
    '2022-01-01 00:00:00',
    16312.50,
    1.00,
    0,
    '',
    1.288835,
    'Activo',
    0,
    0,
    1,
    4,
    1
  );
INSERT INTO
  `activos` (
    `idActivo`,
    `idTipo`,
    `Imagen`,
    `Procedencia`,
    `Descripcion`,
    `FechaRegistro`,
    `ValorRegistro`,
    `ValorActual`,
    `VidaUtilActual`,
    `Observaciones`,
    `UfvInicial`,
    `Estado`,
    `Anio`,
    `Mes`,
    `idCondicion`,
    `idRubro`,
    `idProveedor`
  )
VALUES
  (
    3,
    3,
    'ERWr_P8-ZyD2jWotAsib86ig.jpg',
    'Dinación',
    'CPU: POWER DELUX',
    '2022-04-01 00:00:00',
    30276.00,
    1.00,
    0,
    '',
    2.340860,
    'Activo',
    0,
    0,
    3,
    4,
    1
  );
INSERT INTO
  `activos` (
    `idActivo`,
    `idTipo`,
    `Imagen`,
    `Procedencia`,
    `Descripcion`,
    `FechaRegistro`,
    `ValorRegistro`,
    `ValorActual`,
    `VidaUtilActual`,
    `Observaciones`,
    `UfvInicial`,
    `Estado`,
    `Anio`,
    `Mes`,
    `idCondicion`,
    `idRubro`,
    `idProveedor`
  )
VALUES
  (
    4,
    3,
    'mnVFA52yMIF0BPyRfK_eowgN.jpg',
    'Donación',
    'MONITOR LG MODELO: 17056FB/27',
    '2022-06-28 00:22:15',
    0.00,
    NULL,
    0,
    '',
    0.000000,
    'Activo',
    0,
    0,
    3,
    4,
    1
  );
INSERT INTO
  `activos` (
    `idActivo`,
    `idTipo`,
    `Imagen`,
    `Procedencia`,
    `Descripcion`,
    `FechaRegistro`,
    `ValorRegistro`,
    `ValorActual`,
    `VidaUtilActual`,
    `Observaciones`,
    `UfvInicial`,
    `Estado`,
    `Anio`,
    `Mes`,
    `idCondicion`,
    `idRubro`,
    `idProveedor`
  )
VALUES
  (
    5,
    7,
    'm4fmMQh5wKAx-pa6Rh9vRdcU.jpg',
    'Donación',
    'Impresora laser HP JETP1102W',
    '2022-06-28 00:23:20',
    0.00,
    NULL,
    0,
    '.',
    0.000000,
    'En uso',
    0,
    0,
    3,
    4,
    1
  );
INSERT INTO
  `activos` (
    `idActivo`,
    `idTipo`,
    `Imagen`,
    `Procedencia`,
    `Descripcion`,
    `FechaRegistro`,
    `ValorRegistro`,
    `ValorActual`,
    `VidaUtilActual`,
    `Observaciones`,
    `UfvInicial`,
    `Estado`,
    `Anio`,
    `Mes`,
    `idCondicion`,
    `idRubro`,
    `idProveedor`
  )
VALUES
  (
    6,
    1,
    '7MXs-11VarM1uo7EabFLBK9j.jpg',
    'Donación',
    'Estante de madera de 6 diviciones',
    '2022-06-28 00:24:38',
    0.00,
    NULL,
    0,
    '\r\n',
    0.000000,
    'Activo',
    0,
    0,
    3,
    2,
    1
  );
INSERT INTO
  `activos` (
    `idActivo`,
    `idTipo`,
    `Imagen`,
    `Procedencia`,
    `Descripcion`,
    `FechaRegistro`,
    `ValorRegistro`,
    `ValorActual`,
    `VidaUtilActual`,
    `Observaciones`,
    `UfvInicial`,
    `Estado`,
    `Anio`,
    `Mes`,
    `idCondicion`,
    `idRubro`,
    `idProveedor`
  )
VALUES
  (
    8,
    7,
    'PeX1_4TBrZx7ReCohAbVjlou.jpg',
    'Compra',
    'Impresora HP Laser JET p1102w',
    '2022-07-05 14:07:18',
    2350.00,
    NULL,
    0,
    '',
    1.040640,
    'En uso',
    0,
    0,
    3,
    4,
    3
  );
INSERT INTO
  `activos` (
    `idActivo`,
    `idTipo`,
    `Imagen`,
    `Procedencia`,
    `Descripcion`,
    `FechaRegistro`,
    `ValorRegistro`,
    `ValorActual`,
    `VidaUtilActual`,
    `Observaciones`,
    `UfvInicial`,
    `Estado`,
    `Anio`,
    `Mes`,
    `idCondicion`,
    `idRubro`,
    `idProveedor`
  )
VALUES
  (
    9,
    1,
    'U4vfPiZ6gbyMyTmhbSAivJ-N.jpg',
    'Compra',
    'Estantes metálicos con cuatro divisiones color plomo',
    '2022-07-16 12:17:06',
    1.00,
    NULL,
    0,
    '',
    0.000000,
    'Activo',
    0,
    0,
    2,
    2,
    1
  );
INSERT INTO
  `activos` (
    `idActivo`,
    `idTipo`,
    `Imagen`,
    `Procedencia`,
    `Descripcion`,
    `FechaRegistro`,
    `ValorRegistro`,
    `ValorActual`,
    `VidaUtilActual`,
    `Observaciones`,
    `UfvInicial`,
    `Estado`,
    `Anio`,
    `Mes`,
    `idCondicion`,
    `idRubro`,
    `idProveedor`
  )
VALUES
  (
    10,
    1,
    '_ZEsVQhKSqJgLoUFqMY380be.jpg',
    'Compra',
    'Estantes metálicos con dos divisiones de color rojo',
    '2022-07-16 12:19:40',
    1.00,
    NULL,
    0,
    '',
    0.000000,
    'En uso',
    0,
    0,
    2,
    2,
    1
  );
INSERT INTO
  `activos` (
    `idActivo`,
    `idTipo`,
    `Imagen`,
    `Procedencia`,
    `Descripcion`,
    `FechaRegistro`,
    `ValorRegistro`,
    `ValorActual`,
    `VidaUtilActual`,
    `Observaciones`,
    `UfvInicial`,
    `Estado`,
    `Anio`,
    `Mes`,
    `idCondicion`,
    `idRubro`,
    `idProveedor`
  )
VALUES
  (
    11,
    12,
    'iSY-CX_oH6ZQ0IaQzuWGGpFC.jpg',
    'Compra',
    'Gabetero metálico con 4 cajones de color plomo',
    '2022-07-16 12:23:49',
    1.00,
    NULL,
    0,
    '',
    0.000000,
    'Activo',
    0,
    0,
    2,
    2,
    1
  );
INSERT INTO
  `activos` (
    `idActivo`,
    `idTipo`,
    `Imagen`,
    `Procedencia`,
    `Descripcion`,
    `FechaRegistro`,
    `ValorRegistro`,
    `ValorActual`,
    `VidaUtilActual`,
    `Observaciones`,
    `UfvInicial`,
    `Estado`,
    `Anio`,
    `Mes`,
    `idCondicion`,
    `idRubro`,
    `idProveedor`
  )
VALUES
  (
    12,
    13,
    'GcIFR4AE9b11jK9ZnoVPg2I_.jpg',
    'Compra',
    'Aparato telefónico Panasonic model KXT7080 Nº 2AAQBO17735',
    '2022-07-16 12:26:26',
    1.00,
    NULL,
    0,
    '',
    0.000000,
    'Activo',
    0,
    0,
    3,
    2,
    1
  );
INSERT INTO
  `activos` (
    `idActivo`,
    `idTipo`,
    `Imagen`,
    `Procedencia`,
    `Descripcion`,
    `FechaRegistro`,
    `ValorRegistro`,
    `ValorActual`,
    `VidaUtilActual`,
    `Observaciones`,
    `UfvInicial`,
    `Estado`,
    `Anio`,
    `Mes`,
    `idCondicion`,
    `idRubro`,
    `idProveedor`
  )
VALUES
  (
    13,
    3,
    'GqvyPCcJ8Ha8fSSgzcroOULQ.jpg',
    'Compra',
    'Monitor LG model: 004+PFAWPN serie NO:004+PX35088',
    '2022-07-16 12:31:11',
    1.00,
    NULL,
    0,
    '',
    0.000000,
    'En uso',
    0,
    0,
    2,
    4,
    1
  );
INSERT INTO
  `activos` (
    `idActivo`,
    `idTipo`,
    `Imagen`,
    `Procedencia`,
    `Descripcion`,
    `FechaRegistro`,
    `ValorRegistro`,
    `ValorActual`,
    `VidaUtilActual`,
    `Observaciones`,
    `UfvInicial`,
    `Estado`,
    `Anio`,
    `Mes`,
    `idCondicion`,
    `idRubro`,
    `idProveedor`
  )
VALUES
  (
    14,
    3,
    'NSLiP7inKMlDHz3LKhlkjio6.jpg',
    'Compra',
    'Teclado dell RT7050127',
    '2022-07-16 12:32:33',
    1.00,
    NULL,
    0,
    '',
    0.000000,
    'En uso',
    0,
    0,
    2,
    4,
    1
  );
INSERT INTO
  `activos` (
    `idActivo`,
    `idTipo`,
    `Imagen`,
    `Procedencia`,
    `Descripcion`,
    `FechaRegistro`,
    `ValorRegistro`,
    `ValorActual`,
    `VidaUtilActual`,
    `Observaciones`,
    `UfvInicial`,
    `Estado`,
    `Anio`,
    `Mes`,
    `idCondicion`,
    `idRubro`,
    `idProveedor`
  )
VALUES
  (
    15,
    4,
    'eOkyEK4exuoogpY3kxJ0SbSi.jpg',
    'Compra',
    'Silla de madera con tapiz verde',
    '2022-07-16 12:34:04',
    1.00,
    NULL,
    0,
    '',
    0.000000,
    'Activo',
    0,
    0,
    2,
    2,
    1
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: altaactivos
# ------------------------------------------------------------

INSERT INTO
  `altaactivos` (
    `idAlta`,
    `Codificacion`,
    `FechaHora`,
    `Qr`,
    `idActiv`,
    `idEmpleado`,
    `idProyecto`,
    `idAmbiente`
  )
VALUES
  (
    13,
    'FYA_CH-01-02-01-05',
    '2022-07-12 18:13:28',
    'data:image/png;base64,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',
    5,
    1,
    2,
    2
  );
INSERT INTO
  `altaactivos` (
    `idAlta`,
    `Codificacion`,
    `FechaHora`,
    `Qr`,
    `idActiv`,
    `idEmpleado`,
    `idProyecto`,
    `idAmbiente`
  )
VALUES
  (
    17,
    'FYA_CH-01-05-02-014',
    '2022-07-16 12:38:15',
    'data:image/png;base64,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',
    14,
    2,
    5,
    1
  );
INSERT INTO
  `altaactivos` (
    `idAlta`,
    `Codificacion`,
    `FechaHora`,
    `Qr`,
    `idActiv`,
    `idEmpleado`,
    `idProyecto`,
    `idAmbiente`
  )
VALUES
  (
    18,
    'FYA_CH-01-05-02-010',
    '2022-07-16 12:38:23',
    'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAARQAAAEUCAYAAADqcMl5AAAAAklEQVR4AewaftIAABH+SURBVO3BQY4YybLgQDJR978yR0tfBZDIKLX+GzezP1hrrQse1lrrkoe11rrkYa21LnlYa61LHtZa65KHtda65GGttS55WGutSx7WWuuSh7XWuuRhrbUueVhrrUse1lrrkoe11rrkYa21LvnhI5W/qeILlaniX6ZyUjGpvFFxojJV3KQyVbyhMlWcqJxUnKi8UTGpnFRMKn9TxRcPa611ycNaa13ysNZal/xwWcVNKm+oTBUnKlPFicpUMalMFScqJxWTyqRyUjGpTConFZPKVDGp3KRyUvFGxRsq/5KKm1RuelhrrUse1lrrkoe11rrkh1+m8kbFGypTxUnFpHKiMlWcVJyofFExqUwVk8oXKicqJxVfVJyoTBWTylQxqbxRMalMFZPKb1J5o+I3Pay11iUPa611ycNaa13yw/8YlZOKqeImlZOKN1S+qJhUTipOVE4qTlRuqjipmFSmir+pYlL5X/Kw1lqXPKy11iUPa611yQ//n1OZKt5QmSpuqphUpooTlaliUplU/iUVb6i8oTJVvFHxhspU8b/kYa21LnlYa61LHtZa65IfflnF31QxqUwqb1RMKlPFicpJxaTyhcpUMamcVLyhMqm8UXGiMlW8UTGpnKi8UfFGxU0V/5KHtda65GGttS55WGutS364TOVfVjGpnKhMFZPKVHFSMalMFZPKVDGpTBWTylQxqZyoTBUnFZPKVDGpTBVvqEwVk8pUMalMFZPKVDGpTBVvqEwVJyr/soe11rrkYa21LnlYa61Lfvio4l9W8UXFScVJxaTyRsWkMlVMKlPFFxVvqEwVJxWTylQxqfwmlTcqJpWbKv4veVhrrUse1lrrkoe11rrkh49UpopJ5aaKqWJSeaPiROWNikllqphUTlSmiknlJpUvKiaV31RxUnFS8YbK36RyU8VvelhrrUse1lrrkoe11rrE/uAvUjmpOFGZKk5UpopJ5aRiUrmp4kTlpOJEZaqYVKaKSeWNihOVNyreUDmpmFROKiaVNyreUHmj4l/ysNZalzystdYlD2utdYn9wT9MZaqYVKaKSWWqOFE5qXhD5aaKL1ROKiaVk4pJ5TdVfKHymyomlaniJpWTiknlpOKLh7XWuuRhrbUueVhrrUt++MeoTBWTyhsVX1RMKl9UvKEyqUwVk8pUMVWcqHxR8TepTBWTyhcVk8qJyhcqU8WkclLxX3pYa61LHtZa65KHtda65IfLVE4qTiomlaniDZWpYlL5ouImlZOKm1SmikllqphUpopJ5Y2KNyq+qDhRuUnlpOKNiknlpGJSuelhrbUueVhrrUse1lrrkh9+WcWkclIxVUwqU8VJxRcqX6jcpDJVnKhMFX9TxaRyojJVTCpTxaTyhspUMVWcqEwVX6jcVDGpTBU3Pay11iUPa611ycNaa11if/AfUnmj4kTli4pJ5aRiUpkqTlROKt5QOamYVL6oOFGZKiaVmyomlZOKSeWkYlJ5o+JEZao4UZkqJpWpYlKZKr54WGutSx7WWuuSh7XWusT+4C9SmSr+JpWpYlKZKt5QeaPiRGWqeENlqjhROamYVKaKN1SmiknlpGJSmSreUDmpOFF5o+ILlaniv/Sw1lqXPKy11iUPa611if3BBypvVEwqb1ScqEwVX6hMFZPKVHGiMlV8oXJS8S9ROamYVKaKL1Smiknli4oTlS8qTlROKiaVqeKLh7XWuuRhrbUueVhrrUt++KjiROWLikllqnhD5Y2KSeVEZar4QuWk4kTlpGJSOamYVE4qTiomlaliUvmiYlKZKt5QmVSmiqniROUNlX/Jw1prXfKw1lqXPKy11iU/XKYyVbxRMalMFScVJxUnKpPKVPGGylQxqbxRMalMFVPFicpU8UbFpDKp/JcqblI5qZhUpoqTijcq3lD5TQ9rrXXJw1prXfKw1lqX2B9cpHJS8TepnFRMKlPFpDJV/JdUTiomlaliUnmj4kRlqrhJZaqYVKaKE5Wp4iaVk4pJZaqYVKaKN1Smii8e1lrrkoe11rrkYa21LrE/uEhlqjhRmSomlaniJpWp4guVNyomlaniRGWq+JeovFHxhcoXFZPK31QxqZxUTConFb/pYa21LnlYa61LHtZa6xL7g1+kMlWcqEwVk8pUMamcVEwqb1R8oTJVTCpTxYnKFxWTyknFpDJVvKFyUnGi8kbFicpUcaJyUvGGyknFpHJS8Tc9rLXWJQ9rrXXJw1prXWJ/8IHKVPGGyk0Vk8oXFScqU8WkMlW8oTJVnKicVEwqU8WJylRxojJVTCpTxaQyVUwqU8WJylQxqfymihOVqWJSmSomlS8qvnhYa61LHtZa65KHtda6xP7gIpWp4m9SmSpOVKaKSeWNiknlpOJE5TdVTCpvVEwqU8UbKr+pYlI5qfhC5aaKSeWk4kRlqvjiYa21LnlYa61LHtZa65IfPlKZKiaVqWJSmSomlaliUnlDZaqYVN6omFSmiknljYoTlaniDZWp4kTlpGJSuaniROVEZao4UXmj4ouKSWVSmSomlf/Sw1prXfKw1lqXPKy11iU//McqTipOKiaVk4pJ5Y2KSWWqOKl4Q+WkYlI5qfiiYlKZKqaKSWWqmFSmikllqnij4o2KSeVEZap4Q+WLiknlpOKmh7XWuuRhrbUueVhrrUvsDy5SmSpOVG6qmFSmikllqvhCZap4Q2Wq+ELljYpJ5aTiROWk4kRlqphUpoovVL6oOFF5o2JSmSreUDmp+OJhrbUueVhrrUse1lrrkh8+UnlD5Y2KE5WbVN6omCreUJkqJpWTikllqnhD5aRiUjmp+KJiUrlJ5aTiDZWbVKaKSWWqeKPipoe11rrkYa21LnlYa61Lfvio4kTlC5WbVKaKSeWkYlL5ouKNiptU3lA5qThReaNiqjhReaNiUjlROamYVG5SOVE5qZhUpoovHtZa65KHtda65GGttS6xP/hAZao4UTmpeENlqphUporfpHJScaIyVUwqv6niDZWTihOVk4pJ5TdV/CaVk4o3VN6omFSmii8e1lrrkoe11rrkYa21Lvnho4oTlaliUjlRmSpOVE5U3qg4UfmbKiaVqWJS+UJlqvhCZaqYVCaVqeI3qUwVJypvVEwqJypTxUnFicpvelhrrUse1lrrkoe11rrE/uADlaliUnmj4g2VNyomlanib1KZKiaVLypOVKaKN1ROKr5QualiUjmp+ELljYo3VKaK/9LDWmtd8rDWWpc8rLXWJT/8Y1RuqnhD5aaKk4pJ5aRiUnlD5UTlJpUvKr5QmVSmihOVqWJSmSq+ULlJZar4TQ9rrXXJw1prXfKw1lqX2B98oDJVnKhMFZPKVHGi8kXFpPKbKiaVqeJE5YuKSWWqOFGZKk5UTiq+UJkqJpWTijdU3qi4SWWqOFE5qbjpYa21LnlYa61LHtZa65IfLlN5Q2WqmFROKt5QmVSmiknljYrfVHGiMlVMKlPFicpUMamcVJyoTBWTyknFScWkcqLyRcUXKicVX1RMKlPFFw9rrXXJw1prXfKw1lqX/PDLKk5UTipOVKaKSWWqeKNiUpkqJpWTihOVqeI3qZxUTCpTxaTyRsVJxaTyhsqJyknFGypfVJyoTBUnFX/Tw1prXfKw1lqXPKy11iU/XFYxqZxUnKhMFVPF31QxqZxUTCpTxYnKVPFFxaRyojJVfKHym1SmijdUJpUvKiaVqWJSOamYVN6o+E0Pa611ycNaa13ysNZal9gffKByUjGpvFExqUwVX6hMFb9J5Y2KSeWLikllqjhRmSreUJkqJpWp4kTljYpJZar4QmWq+ELlpOJE5aTipoe11rrkYa21LnlYa61Lfvio4ouKSWVSmSomlanijYpJZap4Q2WqeKPijYo3VE5UpooTlZOKE5WpYlKZKk4qTlROVN6omComlaniROWk4kTlv/Sw1lqXPKy11iUPa611yQ9/WcUbFZPKTSpTxaTyhcpUcaJyUjGpTBVfVLxRMamcVLxRMamcqEwVX1RMKicqU8WJylRxojJVTBVvqEwVXzystdYlD2utdcnDWmtd8sNHKl9UTBWTym+qOKk4UZkqTlSmijdU/iaVNyomlaliUnmj4g2Vk4pJ5Q2VqeJE5SaVqWJSmSp+08Naa13ysNZalzystdYl9ge/SGWqmFSmijdUpopJ5YuKSWWqmFROKiaVqWJSmSomlaniN6lMFZPKVPGGylRxovJFxU0qU8VNKlPFpHJS8Zse1lrrkoe11rrkYa21LrE/+EDlpOILlaniN6m8UTGpTBWTyhsVk8obFZPKVPGFyhcVJyonFW+oTBWTyhsVJyonFZPKb6qYVKaKLx7WWuuSh7XWuuRhrbUusT/4QOWk4kTlpOILlTcqJpWTiptUpooTlTcqTlTeqLhJZaqYVP5LFTepTBUnKicVJyonFV88rLXWJQ9rrXXJw1prXfLDRxUnKicVJypTxaRyk8pUcaJyUjGp3FTxL1GZKiaVk4qTihOVNyreUPmbVKaKE5Wp4m96WGutSx7WWuuSh7XWuuSHy1S+UJkqvqj4QuULlaniROVE5aRiUpkqJpWTikllUpkqTiomlUllqphUblKZKt6omFSmii8qJpWp4o2K3/Sw1lqXPKy11iUPa611if3BByp/U8VvUnmj4guVk4oTlaniRGWq+ELli4oTlZOKm1ROKiaVqWJSOamYVP5LFV88rLXWJQ9rrXXJw1prXfLDZRW/SWWqOFE5qXijYlKZKiaVqWKquEnlpOJE5Y2KSeWk4kRlqphU3lD5omJSmSreqJhUpooTlZOKE5Xf9LDWWpc8rLXWJQ9rrXXJD79M5Y2KSeVvqnijYlKZKt5QOal4o+KmiknlDZUvKk5UTiomlaniDZWp4kTlROWkYlKZVE4qJpWbHtZa65KHtda65GGttS754aOKSWWqmFTeqJhUJpWbVE4qJpUTlaliUpkqJpU3KiaVqWJSmSpOVKaKN1S+UJkqpopJZVL5TSpTxYnKGypTxb/kYa21LnlYa61LHtZa65IfLquYVN5Q+aLiN6m8UTGpTBWTylQxqbxRMam8oXKiclIxVUwqU8Wk8kXFGyonFf8ylZOK3/Sw1lqXPKy11iUPa611yQ8fqbxRMalMFV+oTBU3VZyo/KaKSWVSOak4UXmjYlI5UZkqTiomlROVqeJE5SaVqeKk4guVqeJE5Tc9rLXWJQ9rrXXJw1prXWJ/8IHKFxUnKlPFicobFScqU8WkMlWcqEwVN6lMFZPKb6qYVN6o+E0qU8UbKicVJyr/pYpJZar44mGttS55WGutSx7WWusS+4P/w1R+U8UbKlPFpHJScaJyUjGpvFHxhspvqphUpooTlaniDZWp4kRlqjhRmSreUJkqJpWTipse1lrrkoe11rrkYa21LvnhI5W/qWKqeEPlN1VMKlPFpDKpTBVfVEwqb6hMFV9U/E0Vk8obFZPKScWkMlW8oTJVnKhMFScqU8UXD2utdcnDWmtd8rDWWpf8cFnFTSonKlPFpDJVnKhMKm9UTBVfqEwVk8qkclIxqZxUvFHxN6lMFZPKVDGpTBUnFW9UfFHxRsUbFTc9rLXWJQ9rrXXJw1prXfLDL1N5o+I3qZxUvKEyqUwVJxWTylQxqUwVb6icqHyhMlVMKm9UTBUnKicqU8UbKm9UvKHyhcpJxaQyVXzxsNZalzystdYlD2utdckP/2NUpoo3VKaKSeWk4iaVqWJSmSomlZOKE5WTir9J5SaVqeKNiknli4o3VE4q/qaHtda65GGttS55WGutS374/5zKicpvUpkqJpVJZaqYVL5QmSpOVKaKSWWqeENlqphUpooTlTdU3qiYVE4qJpU3Kk5Uporf9LDWWpc8rLXWJQ9rrXXJD7+s4jdVvKEyVfxNKlPFScWkclIxqUwVk8pU8YXKVPGGyonKFxWTyhsVb1T8lyr+poe11rrkYa21LnlYa61LfrhM5W9SmSpOKiaVk4pJ5Y2KqWJSOamYKiaVLypOVE4qJpUTlS8qTlTeqDipmFTeqHij4kTlDZW/6WGttS55WGutSx7WWusS+4O11rrgYa21LnlYa61LHtZa65KHtda65GGttS55WGutSx7WWuuSh7XWuuRhrbUueVhrrUse1lrrkoe11rrkYa21LnlYa61LHtZa65L/BwkQS43L7a0TAAAAAElFTkSuQmCC',
    10,
    2,
    5,
    1
  );
INSERT INTO
  `altaactivos` (
    `idAlta`,
    `Codificacion`,
    `FechaHora`,
    `Qr`,
    `idActiv`,
    `idEmpleado`,
    `idProyecto`,
    `idAmbiente`
  )
VALUES
  (
    19,
    'FYA_CH-01-02-01-08',
    '2022-07-22 16:53:24',
    'data:image/png;base64,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',
    8,
    1,
    2,
    2
  );
INSERT INTO
  `altaactivos` (
    `idAlta`,
    `Codificacion`,
    `FechaHora`,
    `Qr`,
    `idActiv`,
    `idEmpleado`,
    `idProyecto`,
    `idAmbiente`
  )
VALUES
  (
    20,
    'FYA_CH-01-01-03-013',
    '2022-07-22 19:15:06',
    'data:image/png;base64,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TConFZPKVDGp/KaHtda65GGttS55WGutS374ZRWTylQxqUwV/5KK36TyRsWk8ptUpoo/SeVEZaqYKiaVL1Smii9UpooTlanijYqbHtZa65KHtda65GGttS754ZepvFExqZxUTConFZPKScWJylRxonJSMamcqLxRMalMKicVk8pUMalMFZPKVDGpTBWTylQxqUwVJxWTyhsqN6lMFScqJxWTylTxxcNaa13ysNZalzystdYlP3xUcVIxqbxR8UbFGxWTyk0qb6j8JpWp4kRlUvmbVKaKLyreUJkqTlROKiaVqWJSeaPiT3pYa61LHtZa65KHtda65IfLVKaKE5WpYlKZKk5U3qg4qZhUbqqYVN6omFSmihOVNyomlUllqphUpoqTikllUpkqpoovKiaVE5U3VKaKk4o3VKaK3/Sw1lqXPKy11iUPa611if2HX6QyVUwqU8UbKlPFpDJVTConFScqU8Wk8kbFicobFZPKVDGpTBWTylTxhcpU8YbKVDGpTBWTylTxhsobFZPKScWJyknFpDJV3PSw1lqXPKy11iUPa611yQ8fqdykclPFpPKGylQxVZxUTCpTxYnKScWJylQxqZyonKhMFZPKVPGGylTxm1ROKt6o+ELljYo3VKaKLx7WWuuSh7XWuuRhrbUu+eGXVbxR8YbKicobFScqb1T8SSonKicVb6icVJxUTCpTxRsqU8Wk8kbFGxUnKicVb6hMKm9U3PSw1lqXPKy11iUPa611yQ8fVZyoTBVvqEwVb1RMKlPFTRVvqEwVX1S8oXKiMlWcqJxUnFT8S1RuqphUTlSmipOKN1Smii8e1lrrkoe11rrkYa21LvnhD1N5o+INlaliqnhD5Q2VqWKqOFGZKt5QOal4o+KNijdUpopJZar4omJSmSreUDlRmSreqHhDZar4kx7WWuuSh7XWuuRhrbUu+eEylaliUjlRuUnljYqp4g2VSeWk4kRlqjipmFTeUPlCZar4m1Smii9UTlSmijdUvqg4UZkqbnpYa61LHtZa65KHtda65IePVL6omFSmiknlpGJSmSpOVKaKE5WTikllUjmpmFSmijdUpooTlS9UvqiYVE4qTlSmikllqjipmFROVKaKE5WTiknlDZWp4ouHtda65GGttS55WGutS364rOINlROVqWJS+UJlqjhRmSreqJhU3qiYVG5SeaNiUvlC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',
    13,
    3,
    1,
    5
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: ambientes
# ------------------------------------------------------------

INSERT INTO
  `ambientes` (
    `idAmbiente`,
    `NombreAmb`,
    `DescripcionAmb`,
    `idEdificio`
  )
VALUES
  (
    1,
    'Almacen',
    'Ambiente de almacenamineto de equipos y materiales',
    1
  );
INSERT INTO
  `ambientes` (
    `idAmbiente`,
    `NombreAmb`,
    `DescripcionAmb`,
    `idEdificio`
  )
VALUES
  (
    2,
    'Contabilidad y Administración',
    'Área de contabilidad y admintración',
    1
  );
INSERT INTO
  `ambientes` (
    `idAmbiente`,
    `NombreAmb`,
    `DescripcionAmb`,
    `idEdificio`
  )
VALUES
  (
    5,
    'Área Regular Tecnicos',
    'Área  de trabajo de  los tecnicos',
    1
  );
INSERT INTO
  `ambientes` (
    `idAmbiente`,
    `NombreAmb`,
    `DescripcionAmb`,
    `idEdificio`
  )
VALUES
  (6, 'Dirección', 'Dirección de la institución', 1);
INSERT INTO
  `ambientes` (
    `idAmbiente`,
    `NombreAmb`,
    `DescripcionAmb`,
    `idEdificio`
  )
VALUES
  (7, 'Capilla', 'Sector de la capilla ', 1);
INSERT INTO
  `ambientes` (
    `idAmbiente`,
    `NombreAmb`,
    `DescripcionAmb`,
    `idEdificio`
  )
VALUES
  (8, 'Salon auditorio', 'Salon auditorio', 1);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: bajas
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: condiciones
# ------------------------------------------------------------

INSERT INTO
  `condiciones` (`idCondicion`, `Nombre`)
VALUES
  (1, 'Nuevo');
INSERT INTO
  `condiciones` (`idCondicion`, `Nombre`)
VALUES
  (2, 'Bueno');
INSERT INTO
  `condiciones` (`idCondicion`, `Nombre`)
VALUES
  (3, 'Regular');
INSERT INTO
  `condiciones` (`idCondicion`, `Nombre`)
VALUES
  (4, 'Malo');
INSERT INTO
  `condiciones` (`idCondicion`, `Nombre`)
VALUES
  (5, 'Obsoleto y/o Pesimo');
INSERT INTO
  `condiciones` (`idCondicion`, `Nombre`)
VALUES
  (6, 'Perdido');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: depreciaciones
# ------------------------------------------------------------

INSERT INTO
  `depreciaciones` (
    `idDepreciacion`,
    `UfvActual`,
    `UfvInicial`,
    `Fecha`,
    `ValorContabilizado`,
    `FactorActual`,
    `ValorActualizado`,
    `IncrementoActual`,
    `DepreciacionAcuAnt`,
    `IncrementoDepAcu`,
    `DepreciacionPeriodo`,
    `DepreciacionAcuAct`,
    `ValorNeto`,
    `PorcentajeDep`,
    `VidaUtilActual`,
    `VidaUtilMes`,
    `idActivo`
  )
VALUES
  (
    6,
    1.085930,
    1.040640,
    '2022-12-31 23:54:32',
    16312.50,
    0.043521,
    17022.44,
    709.94,
    0.00,
    0.00,
    4255.61,
    4255.61,
    12766.83,
    0.25,
    3,
    0,
    2
  );
INSERT INTO
  `depreciaciones` (
    `idDepreciacion`,
    `UfvActual`,
    `UfvInicial`,
    `Fecha`,
    `ValorContabilizado`,
    `FactorActual`,
    `ValorActualizado`,
    `IncrementoActual`,
    `DepreciacionAcuAnt`,
    `IncrementoDepAcu`,
    `DepreciacionPeriodo`,
    `DepreciacionAcuAct`,
    `ValorNeto`,
    `PorcentajeDep`,
    `VidaUtilActual`,
    `VidaUtilMes`,
    `idActivo`
  )
VALUES
  (
    7,
    2.172590,
    2.147620,
    '2022-12-31 19:17:28',
    30276.00,
    0.011627,
    30628.01,
    352.01,
    0.00,
    0.00,
    5742.75,
    5742.75,
    24885.26,
    0.25,
    3,
    3,
    3
  );
INSERT INTO
  `depreciaciones` (
    `idDepreciacion`,
    `UfvActual`,
    `UfvInicial`,
    `Fecha`,
    `ValorContabilizado`,
    `FactorActual`,
    `ValorActualizado`,
    `IncrementoActual`,
    `DepreciacionAcuAnt`,
    `IncrementoDepAcu`,
    `DepreciacionPeriodo`,
    `DepreciacionAcuAct`,
    `ValorNeto`,
    `PorcentajeDep`,
    `VidaUtilActual`,
    `VidaUtilMes`,
    `idActivo`
  )
VALUES
  (
    8,
    2.236940,
    2.172590,
    '2023-12-31 19:19:16',
    30628.01,
    0.029619,
    31535.18,
    907.17,
    5742.75,
    170.09,
    7883.80,
    13796.64,
    17738.54,
    0.25,
    2,
    3,
    3
  );
INSERT INTO
  `depreciaciones` (
    `idDepreciacion`,
    `UfvActual`,
    `UfvInicial`,
    `Fecha`,
    `ValorContabilizado`,
    `FactorActual`,
    `ValorActualizado`,
    `IncrementoActual`,
    `DepreciacionAcuAnt`,
    `IncrementoDepAcu`,
    `DepreciacionPeriodo`,
    `DepreciacionAcuAct`,
    `ValorNeto`,
    `PorcentajeDep`,
    `VidaUtilActual`,
    `VidaUtilMes`,
    `idActivo`
  )
VALUES
  (
    9,
    2.290760,
    2.236940,
    '2024-12-31 19:20:26',
    31535.18,
    0.024060,
    32293.91,
    758.73,
    13796.64,
    331.94,
    8073.48,
    22202.06,
    10091.85,
    0.25,
    1,
    3,
    3
  );
INSERT INTO
  `depreciaciones` (
    `idDepreciacion`,
    `UfvActual`,
    `UfvInicial`,
    `Fecha`,
    `ValorContabilizado`,
    `FactorActual`,
    `ValorActualizado`,
    `IncrementoActual`,
    `DepreciacionAcuAnt`,
    `IncrementoDepAcu`,
    `DepreciacionPeriodo`,
    `DepreciacionAcuAct`,
    `ValorNeto`,
    `PorcentajeDep`,
    `VidaUtilActual`,
    `VidaUtilMes`,
    `idActivo`
  )
VALUES
  (
    10,
    2.331870,
    2.290760,
    '2025-12-31 19:20:57',
    32293.91,
    0.017946,
    32873.46,
    579.55,
    22202.06,
    398.44,
    8218.37,
    30818.87,
    2054.59,
    0.25,
    0,
    3,
    3
  );
INSERT INTO
  `depreciaciones` (
    `idDepreciacion`,
    `UfvActual`,
    `UfvInicial`,
    `Fecha`,
    `ValorContabilizado`,
    `FactorActual`,
    `ValorActualizado`,
    `IncrementoActual`,
    `DepreciacionAcuAnt`,
    `IncrementoDepAcu`,
    `DepreciacionPeriodo`,
    `DepreciacionAcuAct`,
    `ValorNeto`,
    `PorcentajeDep`,
    `VidaUtilActual`,
    `VidaUtilMes`,
    `idActivo`
  )
VALUES
  (
    11,
    2.340860,
    2.331870,
    '2026-12-31 19:21:39',
    32873.46,
    0.003855,
    33000.20,
    126.74,
    30818.87,
    118.82,
    2062.51,
    33000.20,
    1.00,
    0.25,
    0,
    0,
    3
  );
INSERT INTO
  `depreciaciones` (
    `idDepreciacion`,
    `UfvActual`,
    `UfvInicial`,
    `Fecha`,
    `ValorContabilizado`,
    `FactorActual`,
    `ValorActualizado`,
    `IncrementoActual`,
    `DepreciacionAcuAnt`,
    `IncrementoDepAcu`,
    `DepreciacionPeriodo`,
    `DepreciacionAcuAct`,
    `ValorNeto`,
    `PorcentajeDep`,
    `VidaUtilActual`,
    `VidaUtilMes`,
    `idActivo`
  )
VALUES
  (
    12,
    1.144430,
    1.085930,
    '2023-12-31 23:38:43',
    17022.44,
    0.053871,
    17939.45,
    917.01,
    4255.61,
    229.25,
    4484.86,
    8969.72,
    8969.73,
    0.25,
    2,
    0,
    2
  );
INSERT INTO
  `depreciaciones` (
    `idDepreciacion`,
    `UfvActual`,
    `UfvInicial`,
    `Fecha`,
    `ValorContabilizado`,
    `FactorActual`,
    `ValorActualizado`,
    `IncrementoActual`,
    `DepreciacionAcuAnt`,
    `IncrementoDepAcu`,
    `DepreciacionPeriodo`,
    `DepreciacionAcuAct`,
    `ValorNeto`,
    `PorcentajeDep`,
    `VidaUtilActual`,
    `VidaUtilMes`,
    `idActivo`
  )
VALUES
  (
    13,
    1.193260,
    1.144430,
    '2022-07-22 19:22:51',
    17939.45,
    0.042668,
    18704.88,
    765.43,
    8969.72,
    382.72,
    4676.22,
    14028.66,
    4676.22,
    0.25,
    1,
    0,
    2
  );
INSERT INTO
  `depreciaciones` (
    `idDepreciacion`,
    `UfvActual`,
    `UfvInicial`,
    `Fecha`,
    `ValorContabilizado`,
    `FactorActual`,
    `ValorActualizado`,
    `IncrementoActual`,
    `DepreciacionAcuAnt`,
    `IncrementoDepAcu`,
    `DepreciacionPeriodo`,
    `DepreciacionAcuAct`,
    `ValorNeto`,
    `PorcentajeDep`,
    `VidaUtilActual`,
    `VidaUtilMes`,
    `idActivo`
  )
VALUES
  (
    14,
    1.288835,
    1.193260,
    '2022-07-22 19:23:22',
    18704.88,
    0.080096,
    20203.06,
    1498.18,
    14028.66,
    1123.64,
    5050.77,
    20203.07,
    1.00,
    0.25,
    0,
    0,
    2
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: devoluciones
# ------------------------------------------------------------

INSERT INTO
  `devoluciones` (
    `idDevolucion`,
    `CodActivo`,
    `CodEmpleado`,
    `idCondici`,
    `Motivo`,
    `FechaDevolucion`,
    `Proyecto`,
    `Observaciones`
  )
VALUES
  (
    13,
    6,
    1,
    3,
    'Gestión concluida',
    '2022-07-25 21:24:53',
    '2',
    'Sin observaciones'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: edificios
# ------------------------------------------------------------

INSERT INTO
  `edificios` (
    `idEdificio`,
    `NombreEdi`,
    `Servicio`,
    `Direccion`,
    `idUbicacion`
  )
VALUES
  (
    1,
    'Dirección D. Fe y Alegría Chuquisaca',
    'Dirección departamental de Chuquisaca',
    'Hospital Universitario',
    1
  );
INSERT INTO
  `edificios` (
    `idEdificio`,
    `NombreEdi`,
    `Servicio`,
    `Direccion`,
    `idUbicacion`
  )
VALUES
  (
    2,
    'Jose Maria Velaz',
    'Colegio',
    'Zona Sagrada Familia',
    1
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: empleados
# ------------------------------------------------------------

INSERT INTO
  `empleados` (
    `idEmpleado`,
    `Nombres`,
    `Apellidos`,
    `Cargo`,
    `Telefono`,
    `Direccion`,
    `idAmbient`
  )
VALUES
  (
    1,
    'Alvaro Froilan',
    'Condori Zamora',
    'Jefe de Administracion y Contabilidad',
    '67543212',
    'Junin Nª231',
    2
  );
INSERT INTO
  `empleados` (
    `idEmpleado`,
    `Nombres`,
    `Apellidos`,
    `Cargo`,
    `Telefono`,
    `Direccion`,
    `idAmbient`
  )
VALUES
  (
    2,
    'Salome',
    'Duran Loaysa',
    'Jefe de Almacenes',
    '67543213',
    'Loa N°4',
    1
  );
INSERT INTO
  `empleados` (
    `idEmpleado`,
    `Nombres`,
    `Apellidos`,
    `Cargo`,
    `Telefono`,
    `Direccion`,
    `idAmbient`
  )
VALUES
  (
    3,
    'Weimar',
    'Alata Carmona',
    'Jefe de Area de Valores Humano Cristiano',
    '78654234',
    'Calle Ravelo S/N',
    5
  );
INSERT INTO
  `empleados` (
    `idEmpleado`,
    `Nombres`,
    `Apellidos`,
    `Cargo`,
    `Telefono`,
    `Direccion`,
    `idAmbient`
  )
VALUES
  (
    4,
    'Dunia',
    'Aguirre',
    'Jefe de Yacha Wasi',
    '987654321',
    'Calle Bustillos N°23',
    5
  );
INSERT INTO
  `empleados` (
    `idEmpleado`,
    `Nombres`,
    `Apellidos`,
    `Cargo`,
    `Telefono`,
    `Direccion`,
    `idAmbient`
  )
VALUES
  (
    5,
    'Margaret',
    'López Grágeda',
    'Directora',
    '5643245',
    'Mercado Campesino N°123',
    6
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: mantenimiento
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: programas
# ------------------------------------------------------------

INSERT INTO
  `programas` (`idPrograma`, `NombreProg`)
VALUES
  (1, 'Educacion Regular');
INSERT INTO
  `programas` (`idPrograma`, `NombreProg`)
VALUES
  (2, 'Educacion Especial');
INSERT INTO
  `programas` (`idPrograma`, `NombreProg`)
VALUES
  (3, 'Educacion en Valores');
INSERT INTO
  `programas` (`idPrograma`, `NombreProg`)
VALUES
  (4, 'Educacion Desescolarizada');
INSERT INTO
  `programas` (`idPrograma`, `NombreProg`)
VALUES
  (5, 'Educacion Tecnica');
INSERT INTO
  `programas` (`idPrograma`, `NombreProg`)
VALUES
  (6, 'Contabilidad y Administracion');
INSERT INTO
  `programas` (`idPrograma`, `NombreProg`)
VALUES
  (7, 'Recursos Humanos y Estadisticas');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: proveedores
# ------------------------------------------------------------

INSERT INTO
  `proveedores` (
    `idProveedor`,
    `NombreProv`,
    `DireccionProv`,
    `TelefonoProv`
  )
VALUES
  (1, 'Sin proveedor', NULL, NULL);
INSERT INTO
  `proveedores` (
    `idProveedor`,
    `NombreProv`,
    `DireccionProv`,
    `TelefonoProv`
  )
VALUES
  (
    2,
    'Muebles Don Juan',
    'Hernando siles Nª345',
    '78654321'
  );
INSERT INTO
  `proveedores` (
    `idProveedor`,
    `NombreProv`,
    `DireccionProv`,
    `TelefonoProv`
  )
VALUES
  (3, 'ElectroFex', 'Jinin Nª876', '78654309');
INSERT INTO
  `proveedores` (
    `idProveedor`,
    `NombreProv`,
    `DireccionProv`,
    `TelefonoProv`
  )
VALUES
  (
    4,
    'ServiTex',
    'Marcelo Quiroga Santa Cruz Nª980',
    '6578543'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: proyectos
# ------------------------------------------------------------

INSERT INTO
  `proyectos` (
    `idProyecto`,
    `NombrePro`,
    `FechaInicio`,
    `FechaFin`,
    `idPrograma`
  )
VALUES
  (
    1,
    'Cultura de paz desde los valores del Evangelio ',
    '2022-07-06',
    '2022-12-31',
    3
  );
INSERT INTO
  `proyectos` (
    `idProyecto`,
    `NombrePro`,
    `FechaInicio`,
    `FechaFin`,
    `idPrograma`
  )
VALUES
  (
    2,
    'Contabilida y administracion',
    '2022-01-01',
    '2022-12-16',
    6
  );
INSERT INTO
  `proyectos` (
    `idProyecto`,
    `NombrePro`,
    `FechaInicio`,
    `FechaFin`,
    `idPrograma`
  )
VALUES
  (
    4,
    'Incercion laboral sermeño',
    '2022-07-06',
    '2022-11-30',
    5
  );
INSERT INTO
  `proyectos` (
    `idProyecto`,
    `NombrePro`,
    `FechaInicio`,
    `FechaFin`,
    `idPrograma`
  )
VALUES
  (
    5,
    'Gestion de almacenes',
    '2022-07-16',
    '2022-12-16',
    6
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: revalorizaciones
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: rubros
# ------------------------------------------------------------

INSERT INTO
  `rubros` (
    `idRubro`,
    `Nombre`,
    `VidaUtil`,
    `Depreciable`,
    `CoeficienteD`,
    `Actualiza`
  )
VALUES
  (1, 'Edificios', 40, 1, 0.025, 1);
INSERT INTO
  `rubros` (
    `idRubro`,
    `Nombre`,
    `VidaUtil`,
    `Depreciable`,
    `CoeficienteD`,
    `Actualiza`
  )
VALUES
  (2, 'Mueblesy Enseres', 10, 1, 0.1, 1);
INSERT INTO
  `rubros` (
    `idRubro`,
    `Nombre`,
    `VidaUtil`,
    `Depreciable`,
    `CoeficienteD`,
    `Actualiza`
  )
VALUES
  (3, 'Vehiculos', 5, 1, 0.2, 1);
INSERT INTO
  `rubros` (
    `idRubro`,
    `Nombre`,
    `VidaUtil`,
    `Depreciable`,
    `CoeficienteD`,
    `Actualiza`
  )
VALUES
  (4, 'Equipos de Computacion', 4, 1, 0.25, 1);
INSERT INTO
  `rubros` (
    `idRubro`,
    `Nombre`,
    `VidaUtil`,
    `Depreciable`,
    `CoeficienteD`,
    `Actualiza`
  )
VALUES
  (5, 'Equipo y Maquinaria', 8, 1, 0.125, 1);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: tiposactivos
# ------------------------------------------------------------

INSERT INTO
  `tiposactivos` (`idTipo`, `NombreActivo`, `DescripcionMant`)
VALUES
  (1, 'Estante', 'Cada 3 meses');
INSERT INTO
  `tiposactivos` (`idTipo`, `NombreActivo`, `DescripcionMant`)
VALUES
  (2, 'Escritorio', 'Cada 3 meses');
INSERT INTO
  `tiposactivos` (`idTipo`, `NombreActivo`, `DescripcionMant`)
VALUES
  (3, 'Computadora', 'Cada 3 meses');
INSERT INTO
  `tiposactivos` (`idTipo`, `NombreActivo`, `DescripcionMant`)
VALUES
  (4, 'Silla', 'Cada 3 meses');
INSERT INTO
  `tiposactivos` (`idTipo`, `NombreActivo`, `DescripcionMant`)
VALUES
  (5, 'Mesa', 'Cada 3 meses');
INSERT INTO
  `tiposactivos` (`idTipo`, `NombreActivo`, `DescripcionMant`)
VALUES
  (6, 'Vehiculo', 'Cada 3 meses');
INSERT INTO
  `tiposactivos` (`idTipo`, `NombreActivo`, `DescripcionMant`)
VALUES
  (7, 'Impresora', 'Cada 3 meses');
INSERT INTO
  `tiposactivos` (`idTipo`, `NombreActivo`, `DescripcionMant`)
VALUES
  (12, 'Gabetero', 'cada 1 año');
INSERT INTO
  `tiposactivos` (`idTipo`, `NombreActivo`, `DescripcionMant`)
VALUES
  (13, 'Telefono', 'cada 12 años');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: ubicaciones
# ------------------------------------------------------------

INSERT INTO
  `ubicaciones` (`idUbicacion`, `NombreLugar`)
VALUES
  (1, 'Sucre');
INSERT INTO
  `ubicaciones` (`idUbicacion`, `NombreLugar`)
VALUES
  (2, 'Tarabuco');
INSERT INTO
  `ubicaciones` (`idUbicacion`, `NombreLugar`)
VALUES
  (3, 'Tomina');
INSERT INTO
  `ubicaciones` (`idUbicacion`, `NombreLugar`)
VALUES
  (4, 'Presto');
INSERT INTO
  `ubicaciones` (`idUbicacion`, `NombreLugar`)
VALUES
  (5, 'Zudañes');
INSERT INTO
  `ubicaciones` (`idUbicacion`, `NombreLugar`)
VALUES
  (6, 'Mojocoya');
INSERT INTO
  `ubicaciones` (`idUbicacion`, `NombreLugar`)
VALUES
  (7, 'Padilla');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: usuarios
# ------------------------------------------------------------

INSERT INTO
  `usuarios` (
    `idUsuario`,
    `idEmplead`,
    `Email`,
    `Password`,
    `Rol`,
    `Estado`
  )
VALUES
  (
    1,
    1,
    'alvaro@gmail.com',
    '$2a$10$U7NekTv0PYpWBpGC0FfLS.P6hJubVoa3tmR7bYRKWbHhXojOz5YPq',
    'ADMIN',
    'ACTIVO'
  );
INSERT INTO
  `usuarios` (
    `idUsuario`,
    `idEmplead`,
    `Email`,
    `Password`,
    `Rol`,
    `Estado`
  )
VALUES
  (
    2,
    2,
    'salome@gmail.com',
    '$2a$10$wRt2UmwJry/RSxEuzH378uI3.jKZzg.IWLxFNSswk6PRmGzLvI/xm',
    'R.ALAMACEN',
    'ACTIVO'
  );

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
