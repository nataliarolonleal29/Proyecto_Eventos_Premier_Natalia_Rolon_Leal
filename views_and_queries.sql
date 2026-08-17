-- Consulta 1: Reservas con un rango de fechas
SELECT * FROM reservas WHERE fecha_hr_inicio BETWEEN '2026-09-01 00:00:00' AND '2026-09-30 23:59:59';


-- Consulta 2: Listado de salones con capacidad mayor a X personas y estado = ‘Disponible’
SELECT * FROM salones WHERE capacidad_personas > 100 AND estado = 'Disponible';


-- Consulta 3: Clientes corporativos que hayan hecho más de 3 reservas
SELECT clientes.id_cliente, clientes.nombre_completo, COUNT(reservas.id_reserva) AS cantidad_reservas
FROM clientes INNER JOIN reservas ON clientes.id_cliente = reservas.id_cliente
WHERE clientes.tipo_cliente = 'Corporativo' GROUP BY clientes.id_cliente, clientes.nombre_completo
HAVING COUNT(reservas.id_reserva) > 3;


-- Consulta 4: Vista con nombre del cliente, nombre del salón, fecha de inicio, fecha fin, total y estado
CREATE VIEW vista_resumen_reservas AS
SELECT
	clientes.nombre_completo AS cliente,
	salones.nombre_salon AS salon,
    reservas.fecha_hr_inicio,
    reservas.fecha_hr_fin,
    reservas.valor_total AS total,
    salones.estado
FROM reservas INNER JOIN clientes ON reservas.id_cliente = clientes.id_cliente
INNER JOIN salones ON reservas.id_salon = salones.id_salon;

SELECT * FROM vista_resumen_reservas;