USE Nomadate;
GO

--Insertar algunos datos para testing


INSERT INTO Usuario (Nombre, Apellido, Email, Contrasenna)
VALUES
('Luis', 'Ram�rez', 'luisr@email.com', '12345'),
('Andrea', 'Soto', 'andrea.soto@email.com', '12345'),
('Pedro', 'Jim�nez', 'pedro.jimenez@email.com', '12345'),
('Valeria', 'Campos', 'valeriac@email.com', '12345'),
('Sof�a', 'Araya', 'sofia.araya@email.com', '12345'),
('Mario', 'Salas', 'mariosalas@email.com', '12345'),
('C�sar', 'Rojas', 'cesar.rojas@email.com', '12345'),
('Fernanda', 'Alfaro', 'fernanda.alfaro@email.com', '12345');


INSERT INTO Habitacion (Numero_Habitacion, Capacidad, Precio, Descripcion, Tiene_Aire, Tiene_TV, Ruta_Imagen)
VALUES
('103', 2, 80.00, 'Habitaci�n doble moderna con balc�n', 1, 1, '/img/habitacion103.jpg'),
('104', 4, 120.00, 'Suite familiar amplia', 1, 1, '/img/habitacion104.jpg'),
('105', 1, 45.00, 'Habitaci�n econ�mica sin aire', 0, 0, '/img/habitacion105.jpg');

EXEC CrearReservacion 2, 3, '2025-12-01', '2025-12-03', 150.00;
EXEC CrearReservacion 4, 5, '2025-11-25', '2025-11-28', 360.00;

