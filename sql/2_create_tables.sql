-- 2_create_tables.sql
USE [Nomadate];
GO

IF OBJECT_ID('dbo.Rooms','U') IS NULL
BEGIN
    CREATE TABLE dbo.Rooms (
        RoomId INT IDENTITY(1,1) PRIMARY KEY,
        RoomNumber NVARCHAR(20) NOT NULL UNIQUE,
        RoomType NVARCHAR(50) NOT NULL,
        Price DECIMAL(10,2) NOT NULL,
        IsAvailable BIT NOT NULL DEFAULT (1),
        CreatedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
    );
END
GO

IF OBJECT_ID('dbo.Users','U') IS NULL
BEGIN
    CREATE TABLE dbo.Users (
        UserId INT IDENTITY(1,1) PRIMARY KEY,
        Email NVARCHAR(200) NOT NULL UNIQUE,
        UserName NVARCHAR(50) NOT NULL,
        Passw NVARCHAR (255) NOT NULL,
        BirthDate DATE NULL
    );
END
GO
    
IF OBJECT_ID('dbo.Reservations','U') IS NULL
BEGIN
    CREATE TABLE dbo.Reservations (
        ReservationId INT IDENTITY(1,1) PRIMARY KEY,
        RoomId INT NOT NULL,
        GuestName NVARCHAR(150) NOT NULL,
        GuestEmail NVARCHAR(150) NULL,
        CheckIn DATE NOT NULL,
        CheckOut DATE NOT NULL,
        TotalPrice DECIMAL(10,2) NOT NULL DEFAULT (0.00),
        Status NVARCHAR(20) NOT NULL DEFAULT ('Booked'),
        CreatedAt DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        CONSTRAINT FK_Reservations_Rooms FOREIGN KEY (RoomId) REFERENCES dbo.Rooms(RoomId),
        CONSTRAINT CHK_Reservations_Dates CHECK (CheckOut > CheckIn)
    );
    CREATE INDEX IX_Reservations_RoomId ON dbo.Reservations(RoomId);
END
GO
