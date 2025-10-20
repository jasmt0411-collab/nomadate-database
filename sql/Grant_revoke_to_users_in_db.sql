USE Nomadate;
GO

-- Crear roles (si no existen)
IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'rol_Administrador' AND type = 'R')
    CREATE ROLE rol_Administrador;

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'rol_Cliente' AND type = 'R')
    CREATE ROLE rol_Cliente;
GO

-- Asignar permisos
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Users TO rol_Administrador;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Rooms TO rol_Administrador;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Reservations TO rol_Administrador;

GRANT SELECT ON dbo.Rooms TO rol_Cliente;
GRANT SELECT, INSERT ON dbo.Reservations TO rol_Cliente;
GO

-- Asignar usuarios a los roles
EXEC sp_addrolemember 'rol_Administrador', 'nomadate_admin';
EXEC sp_addrolemember 'rol_Cliente', 'nomadate_cliente';
GO

-- minor update for commit test
