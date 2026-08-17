CREATE DATABASE proyecto_eventos_premier;
USE proyecto_eventos_premier;

CREATE TABLE clientes(
	id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(100),
    identificacion VARCHAR(20),
    telefono VARCHAR(20),
    correo_electronico VARCHAR(100),
    tipo_cliente ENUM('Individual', 'Corporativo')
);

CREATE TABLE salones(
	id_salon INT AUTO_INCREMENT PRIMARY KEY,
    nombre_salon VARCHAR(50),
    capacidad_personas INT,
    precio_por_hora DECIMAL(10,2),
    estado ENUM('Disponible', 'Ocupado', 'En mantenimiento'),
    encargado_responsable VARCHAR(50)
);

CREATE TABLE reservas(
	id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    fecha_hr_inicio DATETIME,
    fecha_hr_fin DATETIME,
    id_cliente INT,
    id_salon INT,
    total_horas DECIMAL(5,2),
    valor_total DECIMAL(10,2),
    FOREIGN KEY (id_salon) REFERENCES salones(id_salon),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE pagos(
	id_pago INT AUTO_INCREMENT PRIMARY KEY,
    fecha_pago DATE,
    monto_pagado DECIMAL(10,2),
    metodo_pago ENUM('Efectivo', 'Tarjeta', 'Transferencia'),
    id_reserva INT,
    FOREIGN KEY (id_reserva) REFERENCES reservas(id_reserva)
);

CREATE TABLE auditoria_precios(
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    id_salon INT,
    usuario VARCHAR(100),
    fecha_cambio DATETIME,
    valor_anterior DECIMAL(10,2),
    valor_nuevo DECIMAL(10,2),
    FOREIGN KEY (id_salon) REFERENCES salones(id_salon)
);

INSERT INTO clientes (nombre_completo, identificacion, telefono, correo_electronico, tipo_cliente) VALUES
('Laura Gómez', '1098765432', '3001234567', 'laura.gomez@gmail.com', 'Individual'),
('Carlos Rodríguez', '1098765433', '3012345678', 'carlos.rodriguez@gmail.com', 'Individual'),
('Mariana López', '1098765434', '3023456789', 'mariana.lopez@gmail.com', 'Individual'),
('Empresa Soluciones SAS', '900123456-1', '3104567890', 'contacto@soluciones.com', 'Corporativo'),
('Corporación Eventos del Norte', '900234567-2', '3115678901', 'eventos@corporacionnorte.com', 'Corporativo'),
('Andrés Martínez', '1098765435', '3126789012', 'andres.martinez@gmail.com', 'Individual'),
('Innovaciones Tecnológicas SAS', '900345678-3', '3137890123', 'contacto@innovaciones.com', 'Corporativo'),
('Paula Sánchez', '1098765436', '3148901234', 'paula.sanchez@gmail.com', 'Individual'),
('Grupo Empresarial Santander', '900456789-4', '3159012345', 'eventos@gesantander.com', 'Corporativo'),
('Diego Ramírez', '1098765437', '3160123456', 'diego.ramirez@gmail.com', 'Individual');

INSERT INTO salones (nombre_salon, capacidad_personas, precio_por_hora, estado, encargado_responsable) VALUES
('Salón Imperial', 200, 180000.00, 'Disponible', 'Ana Torres'),
('Salón Real', 150, 150000.00, 'Disponible', 'Carlos Pérez'),
('Salón Diamante', 100, 120000.00, 'Disponible', 'Laura Martínez'),
('Salón Esmeralda', 80, 95000.00, 'En mantenimiento', 'Jorge Ramírez'),
('Salón Rubí', 60, 75000.00, 'Disponible', 'María González'),
('Salón Ejecutivo', 40, 60000.00, 'Disponible', 'Andrés Castro'),
('Salón Empresarial', 120, 130000.00, 'Disponible', 'Sandra López');

INSERT INTO reservas (fecha_hr_inicio, fecha_hr_fin, id_cliente, id_salon, total_horas, valor_total) VALUES
('2026-08-18 08:00:00', '2026-08-18 12:00:00', 1, 1, 4.00, 856800.00),
('2026-08-20 14:00:00', '2026-08-20 18:00:00', 4, 2, 4.00, 714000.00),
('2026-08-22 09:00:00', '2026-08-22 13:00:00', 5, 3, 4.00, 571200.00),
('2026-08-25 18:00:00', '2026-08-25 22:00:00', 4, 1, 4.00, 856800.00),
('2026-08-28 08:00:00', '2026-08-28 12:00:00', 5, 5, 4.00, 357000.00),
('2026-09-01 14:00:00', '2026-09-01 18:00:00', 7, 2, 4.00, 714000.00),
('2026-09-05 09:00:00', '2026-09-05 15:00:00', 4, 7, 6.00, 928200.00),
('2026-09-10 08:00:00', '2026-09-10 12:00:00', 9, 1, 4.00, 856800.00),
('2026-09-15 14:00:00', '2026-09-15 18:00:00', 4, 3, 4.00, 571200.00),
('2026-09-20 18:00:00', '2026-09-20 22:00:00', 5, 2, 4.00, 714000.00),
('2026-09-25 09:00:00', '2026-09-25 13:00:00', 7, 5, 4.00, 357000.00),
('2026-10-01 08:00:00', '2026-10-01 12:00:00', 4, 1, 4.00, 856800.00);

INSERT INTO pagos (fecha_pago, monto_pagado, metodo_pago, id_reserva) VALUES
('2026-08-15', 856800.00, 'Transferencia', 1),
('2026-08-16', 400000.00, 'Tarjeta', 2),
('2026-08-18', 314000.00, 'Efectivo', 2),
('2026-08-18', 571200.00, 'Transferencia', 3),
('2026-08-20', 500000.00, 'Tarjeta', 4),
('2026-08-22', 357000.00, 'Transferencia', 5),
('2026-08-25', 714000.00, 'Efectivo', 6),
('2026-08-28', 500000.00, 'Transferencia', 7),
('2026-09-01', 428400.00, 'Tarjeta', 8),
('2026-09-05', 571200.00, 'Transferencia', 9),
('2026-09-10', 714000.00, 'Efectivo', 10),
('2026-09-15', 357000.00, 'Transferencia', 11),
('2026-09-20', 856800.00, 'Tarjeta', 12);