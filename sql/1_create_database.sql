-- 1_create_database.sql
IF DB_ID(N'Nomadate') IS NULL
BEGIN
    CREATE DATABASE [Nomadate];
END
GO
