-- Función para calcular el valor total de la reserva con IVA 19%

DELIMITER //
CREATE FUNCTION calcular_total_reserva(
	precio_por_hora DECIMAL(10,2),
	total_horas DECIMAL(5,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
	RETURN (precio_por_hora * total_horas) * 1.19;
END //
DELIMITER ;

SELECT calcular_total_reserva(150000, 4);


-- Función para verificar la disponibilidad de una reserva, se retorna 1 si está disponible y 0 si no está disponible
DELIMITER //
CREATE FUNCTION verificar_disponibilidad(
    id_salon INT,
    fecha_hr_inicio DATETIME,
    fecha_hr_fin DATETIME
)
RETURNS INT
NOT DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE cantidad_reservas INT;
    
    SELECT COUNT(*)
    INTO cantidad_reservas
    FROM reservas
    WHERE reservas.id_salon = id_salon
    AND reservas.fecha_hr_inicio < fecha_hr_fin
    AND reservas.fecha_hr_fin > fecha_hr_inicio;

    IF cantidad_reservas = 0 THEN
        RETURN 1;
    ELSE
        RETURN 0;
    END IF;

END //
DELIMITER ;

SELECT verificar_disponibilidad(1, '2026-08-18 10:00:00', '2026-08-18 14:00:00');

SELECT verificar_disponibilidad(1, '2026-08-18 14:00:00', '2026-08-18 18:00:00');