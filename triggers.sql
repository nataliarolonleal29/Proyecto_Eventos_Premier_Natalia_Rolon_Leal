-- Trigger para que al registrar una nueva reserva, el estado del salón cambia a “Ocupado”.

DELIMITER //
CREATE TRIGGER actualizar_estado_salon_trigger
AFTER INSERT ON reservas
FOR EACH ROW
BEGIN
	UPDATE salones SET estado = 'Ocupado' WHERE id_salon = NEW.id_salon;
END //
DELIMITER ;

-- Incersion de datos de una reserva para probar el trigger
INSERT INTO reservas (fecha_hr_inicio, fecha_hr_fin, id_cliente, id_salon, total_horas, valor_total)
VALUES('2026-10-10 10:00:00', '2026-10-10 14:00:00', 1, 3, 4.00, 571200.00);

-- Consultas para comprobar que el trigger funciona
SELECT * FROM salones;
SELECT * FROM reservas;


-- Trigger para que cuando se elimine una reserva, el salón se actualice a “Disponible”

DELIMITER //
CREATE TRIGGER liberar_salon_trigger
AFTER DELETE ON reservas
FOR EACH ROW
BEGIN
	UPDATE salones SET estado = 'Disponible' WHERE id_salon = OLD.id_salon;
END //
DELIMITER ;

-- Verificar el id de la reserva
SELECT * FROM reservas WHERE id_reserva = 13;

-- Verificar que el salón está ocupado
SELECT id_salon, nombre_salon, estado FROM salones WHERE id_salon = 3;

--  Eliminar la reserva de prueba
DELETE FROM reservas WHERE id_reserva = 13;

-- Comprobar el resultado del trigger
SELECT id_salon, nombre_salon, estado FROM salones WHERE id_salon = 3;


-- Trigger para registrar el cambio del precio por hora en la tabla auditoria_precios

DELIMITER //
CREATE TRIGGER auditoria_precios_trigger
AFTER UPDATE ON salones
FOR EACH ROW
BEGIN
	IF OLD.precio_por_hora <> NEW.precio_por_hora THEN
		INSERT INTO auditoria_precios (id_salon, usuario, fecha_cambio, valor_anterior, valor_nuevo) VALUES
		(
			NEW.id_salon,
			CURRENT_USER(),
			NOW(),
			OLD.precio_por_hora,
			NEW.precio_por_hora
		);
	END IF;
END //
DELIMITER ;

-- Consultar primero el precio por hora de un salon
SELECT id_salon, nombre_salon, precio_por_hora FROM salones WHERE id_salon = 1;

-- Se cambia el precio por hora y se ejecuta el trigger
UPDATE salones SET precio_por_hora = 200000.00 WHERE id_salon = 1;

-- Comprobar si se cambió en la tabla
SELECT * FROM auditoria_precios;

-- Este caso ocurre cuando no se ejecuta el trigger, es decir, no se actualiza la tabla
UPDATE salones SET precio_por_hora = 200000.00 WHERE id_salon = 1;
SELECT * FROM auditoria_precios;

SHOW TRIGGERS;