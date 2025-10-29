USE Nomadate;
GO

CREATE PROCEDURE InsertarUsuario
    @Nombre NVARCHAR(100),
    @Apellido NVARCHAR(100),
    @Email NVARCHAR(200),
    @Contrasenna NVARCHAR(255)
AS
BEGIN
    INSERT INTO Usuario (Nombre, Apellido, Email, Contrasenna)
    VALUES (@Nombre, @Apellido, @Email, @Contrasenna);

    PRINT 'Usuario insertado correctamente.';
END;
GO
--Comando para crear usuarios por medio de SP(Store procedures)
EXEC InsertarUsuario 'Mar�a', 'G�mez', 'maria.gomez@email.com', '12345';
EXEC InsertarUsuario 'Carlos', 'Fern�ndez', 'carlosf@email.com', '12345';


--Creaci�n de consulta de usuarios segun su ID
USE Nomadate;
GO
CREATE PROCEDURE ObtenerUsuarioPorID
    @Id_Usuario INT
AS
BEGIN
    SELECT * FROM Usuario WHERE Id_Usuario = @Id_Usuario;
END;
GO


--Ejecurci�n del comando para obtener/consultar los usuarios segun dsu ID o cedula por ejemplo
EXEC ObtenerUsuarioPorID 3;


--Creaci�n del procedimiento almacenado para la actualizaci�n de datos

USE Nomadate;
GO

CREATE PROCEDURE ActualizarEmailUsuario
    @Id_Usuario INT,
    @NuevoEmail NVARCHAR(200)
AS
BEGIN
    UPDATE Usuario
    SET Email = @NuevoEmail
    WHERE Id_Usuario = @Id_Usuario;

    PRINT 'Correo actualizado correctamente.';
END;
GO

--Ejecuci�n del procedimiento almacenado para actualizar el email de los usuarios

EXEC ActualizarEmailUsuario 2, 'nuevo.carlos@email.com';

USE Nomadate;
GO

--Creaci�n de procedimiento almacenado para eliminar usuarios seg�n su c�dula o ID del usuario
CREATE PROCEDURE EliminarUsuario
    @Id_Usuario INT
AS
BEGIN
    DELETE FROM Usuario WHERE Id_Usuario = @Id_Usuario;
    PRINT 'Usuario eliminado correctamente.';
END;
GO
--Ejecuci�n del procedimiento almacenado para la eliminaci�n del ID
--EXEC EliminarUsuario 3;

--Creaci�n de procedimiento almacenado para crear una reservaci�n
CREATE PROCEDURE CrearReservacion
    @Id_Habitacion INT,
    @Id_Usuario INT,
    @CheckIn DATE,
    @CheckOut DATE,
    @Precio DECIMAL(10,2)
AS
BEGIN
    DECLARE @Id_Reservacion INT;

    -- Crear la reservaci�n principal
    INSERT INTO Reservacion (Id_Habitacion, Id_Usuario, Estado)
    VALUES (@Id_Habitacion, @Id_Usuario, 'vigente');

    SET @Id_Reservacion = SCOPE_IDENTITY();

    -- Crear el detalle
    INSERT INTO Reservacion_Detalle (Id_Reservacion, CheckIn, CheckOut, Precio)
    VALUES (@Id_Reservacion, @CheckIn, @CheckOut, @Precio);

    PRINT 'Reservaci�n creada correctamente.';
END;
GO

--Ejecuci�n del procedimeinto almacenado para crear una reservaci�n(esto deberia ir o llamarse desde la app)

EXEC CrearReservacion 1, 2, '2025-11-10', '2025-11-12', 150.00;

USE Nomadate;
GO

--Creaci�n de procedimiento almacenado para obtener o consultar habitaciones disponibles
CREATE PROCEDURE ObtenerHabitacionesDisponibles
AS
BEGIN
    SELECT H.Id_Habitacion, H.Numero_Habitacion, H.Capacidad, H.Precio, H.Descripcion
    FROM Habitacion H
    WHERE H.Id_Habitacion NOT IN (
        SELECT R.Id_Habitacion
        FROM Reservacion R
        JOIN Reservacion_Detalle D ON R.Id_Reservacion = D.Id_Reservacion
        WHERE D.CheckOut > GETDATE()
    );
END;
GO
--Ejecuci�n del procedimeinto almacenado para obtener o consultar las habitaciones disponibles
--(esto deberia ir o llamarse desde la app)
EXEC ObtenerHabitacionesDisponibles;

USE Nomadate;
GO
--Creaci�n de procedimiento almacenado para agregar rese�as
CREATE PROCEDURE AgregarResenna
    @Id_Habitacion INT,
    @Id_Usuario INT,
    @Calificacion INT,
    @Comentario NVARCHAR(500)
AS
BEGIN
    INSERT INTO Resenna (Id_Habitacion, Id_Usuario, Calificacion, Comentario)
    VALUES (@Id_Habitacion, @Id_Usuario, @Calificacion, @Comentario);

    PRINT 'Rese�a registrada correctamente.';
END;
GO
--Ejecuci�n del procedimiento almacenado para agregar rese�as
--(esto deberia ir o llamarse desde la app en el apartado de rese�as para llenar los parametros correspondientes)
EXEC AgregarResenna 1, 2, 5, 'Excelente servicio y limpieza.';










