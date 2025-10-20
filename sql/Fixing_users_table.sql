USE Nomadate;
GO

-- Verificar si la tabla Users existe
IF OBJECT_ID('dbo.Users', 'U') IS NOT NULL
BEGIN
    PRINT 'La tabla Users existe correctamente';
    
    -- Mostrar las columnas de la tabla Users para verificar
    SELECT 
        COLUMN_NAME, 
        DATA_TYPE, 
        IS_NULLABLE
    FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE TABLE_NAME = 'Users';
END
ELSE
BEGIN
    PRINT 'La tabla Users NO existe, creándola...';
    
    CREATE TABLE dbo.Users (
        UserId INT IDENTITY(1,1) PRIMARY KEY,
        Email NVARCHAR(200) NOT NULL UNIQUE,
        UserName NVARCHAR(50) NOT NULL,
        Passw NVARCHAR(255) NOT NULL,  -- Sin espacio extra
        BirthDate DATE NULL
    );
    
    PRINT 'Tabla Users creada exitosamente';
END
GO