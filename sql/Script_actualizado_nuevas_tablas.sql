-- =========================================================
-- Script: create_tables.sql
-- Base de datos: Nomadate
-- Descripción: Crea las tablas según el modelo del usuario
-- =========================================================


USE [Nomadate];
GO

PRINT 'Creando tablas del modelo original...';
-- ================================================
-- Tabla: Usuario
-- ================================================
IF OBJECT_ID('dbo.Usuario','U') IS NULL
BEGIN
    CREATE TABLE dbo.Usuario (
        Id_Usuario INT IDENTITY(1,1) PRIMARY KEY,
        Nombre NVARCHAR(100) NOT NULL,
        Apellido NVARCHAR(100) NOT NULL,
        Email NVARCHAR(200) NOT NULL UNIQUE,
        Contrasenna NVARCHAR(255) NOT NULL
    );
    PRINT 'Tabla [Usuario] creada.';
END
GO

-- ================================================
-- Tabla: Habitacion
-- ================================================
IF OBJECT_ID('dbo.Habitacion','U') IS NULL
BEGIN
    CREATE TABLE dbo.Habitacion (
        Id_Habitacion INT IDENTITY(1,1) PRIMARY KEY,
        Numero_Habitacion NVARCHAR(20) NOT NULL UNIQUE,
        Capacidad INT NOT NULL,
        Precio DECIMAL(10,2) NOT NULL,
        Descripcion NVARCHAR(500) NULL,
        Tiene_Aire BIT NOT NULL DEFAULT (0),
        Tiene_TV BIT NOT NULL DEFAULT (0),
        Ruta_Imagen NVARCHAR(300) NULL
    );
    PRINT 'Tabla [Habitacion] creada.';
END
GO

-- ================================================
-- Tabla: Reservacion
-- ================================================
IF OBJECT_ID('dbo.Reservacion','U') IS NULL
BEGIN
    CREATE TABLE dbo.Reservacion (
        Id_Reservacion INT IDENTITY(1,1) PRIMARY KEY,
        Id_Habitacion INT NOT NULL,
        Id_Usuario INT NOT NULL,
        Estado NVARCHAR(20) NOT NULL DEFAULT ('vigente'),

        CONSTRAINT FK_Reservacion_Habitacion FOREIGN KEY (Id_Habitacion)
            REFERENCES dbo.Habitacion (Id_Habitacion)
            ON DELETE CASCADE ON UPDATE CASCADE,

        CONSTRAINT FK_Reservacion_Usuario FOREIGN KEY (Id_Usuario)
            REFERENCES dbo.Usuario (Id_Usuario)
            ON DELETE CASCADE ON UPDATE CASCADE
    );

    CREATE INDEX IX_Reservacion_Habitacion ON dbo.Reservacion (Id_Habitacion);
    CREATE INDEX IX_Reservacion_Usuario ON dbo.Reservacion (Id_Usuario);
    PRINT 'Tabla [Reservacion] creada.';
END
GO

-- ================================================
-- Tabla: Reservacion_Detalle
-- ================================================
IF OBJECT_ID('dbo.Reservacion_Detalle','U') IS NULL
BEGIN
    CREATE TABLE dbo.Reservacion_Detalle (
        Id_Reservacion_Detalle INT IDENTITY(1,1) PRIMARY KEY,
        Id_Reservacion INT NOT NULL,
        CheckIn DATE NOT NULL,
        CheckOut DATE NOT NULL,
        Precio DECIMAL(10,2) NOT NULL,
        Fecha_Creacion DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),

        CONSTRAINT FK_Reservacion_Detalle_Reservacion FOREIGN KEY (Id_Reservacion)
            REFERENCES dbo.Reservacion (Id_Reservacion)
            ON DELETE CASCADE ON UPDATE CASCADE,

        CONSTRAINT CHK_Reservacion_Detalle_Fechas CHECK (CheckOut > CheckIn)
    );

    CREATE INDEX IX_Reservacion_Detalle_Reservacion ON dbo.Reservacion_Detalle (Id_Reservacion);
    PRINT 'Tabla [Reservacion_Detalle] creada.';
END
GO

-- ================================================
-- Tabla: Resenna
-- ================================================
IF OBJECT_ID('dbo.Resenna','U') IS NULL
BEGIN
    CREATE TABLE dbo.Resenna (
        Id_Resenna INT IDENTITY(1,1) PRIMARY KEY,
        Id_Habitacion INT NOT NULL,
        Id_Usuario INT NOT NULL,
        Calificacion INT NOT NULL CHECK (Calificacion BETWEEN 1 AND 5),
        Comentario NVARCHAR(500) NULL,
        Fecha_Creacion DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),

        CONSTRAINT FK_Resenna_Habitacion FOREIGN KEY (Id_Habitacion)
            REFERENCES dbo.Habitacion (Id_Habitacion)
            ON DELETE CASCADE ON UPDATE CASCADE,

        CONSTRAINT FK_Resenna_Usuario FOREIGN KEY (Id_Usuario)
            REFERENCES dbo.Usuario (Id_Usuario)
            ON DELETE CASCADE ON UPDATE CASCADE
    );

    CREATE INDEX IX_Resenna_Habitacion ON dbo.Resenna (Id_Habitacion);
    CREATE INDEX IX_Resenna_Usuario ON dbo.Resenna (Id_Usuario);
    PRINT 'Tabla [Resenna] creada.';
END
GO


-- =========================================================
--  Asignación de permisos según roles
-- =========================================================
PRINT 'Asignando permisos a roles...';

-- Rol Administrador: acceso total a todas las tablas
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Usuario TO rol_Administrador;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Habitacion TO rol_Administrador;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Reservacion TO rol_Administrador;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Reservacion_Detalle TO rol_Administrador;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Resenna TO rol_Administrador;
PRINT 'Permisos asignados a rol_Administrador.';

-- Rol Cliente: acceso restringido
GRANT SELECT ON dbo.Habitacion TO rol_Cliente;
GRANT SELECT, INSERT, UPDATE ON dbo.Reservacion TO rol_Cliente;
GRANT SELECT, INSERT ON dbo.Reservacion_Detalle TO rol_Cliente;
GRANT SELECT, INSERT ON dbo.Resenna TO rol_Cliente;
PRINT 'Permisos asignados a rol_Cliente.';
GO


-- =========================================================
--  Datos iniciales para pruebas
-- =========================================================
PRINT 'Insertando datos base...';

-- Usuarios
IF NOT EXISTS (SELECT 1 FROM dbo.Usuario WHERE Email = 'admin@nomadate.com')
    INSERT INTO dbo.Usuario (Nombre, Apellido, Email, Contrasenna)
    VALUES ('Admin', 'General', 'admin@nomadate.com', '12345');

IF NOT EXISTS (SELECT 1 FROM dbo.Usuario WHERE Email = 'cliente@nomadate.com')
    INSERT INTO dbo.Usuario (Nombre, Apellido, Email, Contrasenna)
    VALUES ('Juan', 'Pérez', 'cliente@nomadate.com', '12345');

-- Habitaciones
IF NOT EXISTS (SELECT 1 FROM dbo.Habitacion WHERE Numero_Habitacion = '101')
    INSERT INTO dbo.Habitacion (Numero_Habitacion, Capacidad, Precio, Descripcion, Tiene_Aire, Tiene_TV, Ruta_Imagen)
    VALUES ('101', 2, 75.00, 'Habitación doble con vista al mar', 1, 1, '/img/habitacion101.jpg');

IF NOT EXISTS (SELECT 1 FROM dbo.Habitacion WHERE Numero_Habitacion = '102')
    INSERT INTO dbo.Habitacion (Numero_Habitacion, Capacidad, Precio, Descripcion, Tiene_Aire, Tiene_TV, Ruta_Imagen)
    VALUES ('102', 1, 50.00, 'Habitación sencilla sin aire acondicionado', 0, 1, '/img/habitacion102.jpg');

PRINT 'Datos base insertados correctamente.';
GO

PRINT 'Script completado con éxito.';