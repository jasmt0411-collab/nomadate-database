USE [Nomadate];
GO

-- Habitaciones
IF NOT EXISTS (SELECT 1 FROM dbo.Rooms WHERE RoomNumber = '101')
    INSERT INTO dbo.Rooms (RoomNumber, RoomType, Price, IsAvailable)
    VALUES ('101','Single',50.00,1);

IF NOT EXISTS (SELECT 1 FROM dbo.Rooms WHERE RoomNumber = '102')
    INSERT INTO dbo.Rooms (RoomNumber, RoomType, Price, IsAvailable)
    VALUES ('102','Double',75.00,1);

IF NOT EXISTS (SELECT 1 FROM dbo.Rooms WHERE RoomNumber = '201')
    INSERT INTO dbo.Rooms (RoomNumber, RoomType, Price, IsAvailable)
    VALUES ('201','Suite',150.00,1);
GO

-- Reserva
DECLARE @RoomId INT;
SELECT @RoomId = RoomId FROM dbo.Rooms WHERE RoomNumber = '101';

IF @RoomId IS NOT NULL
AND NOT EXISTS (
    SELECT 1 FROM dbo.Reservations
    WHERE GuestName = 'María Pérez'
      AND CheckIn = '2025-10-10'
      AND CheckOut = '2025-10-12'
)
BEGIN
    INSERT INTO dbo.Reservations (RoomId, GuestName, GuestEmail, CheckIn, CheckOut, TotalPrice, Status)
    VALUES (@RoomId,'María Pérez','maria@example.com','2025-10-10','2025-10-12', 100.00, 'Booked');
END
GO
