# Sistema de Reservas de Salones de Eventos Premier S.A.S.

## Descripción del proyecto

Eventos Premier S.A.S. es una empresa dedicada al alquiler de salones para reuniones, fiestas y conferencias.

Este proyecto consiste en el diseño y construcción de una base de datos relacional para digitalizar la gestión de salones, clientes, reservas y pagos.

El sistema permite administrar la disponibilidad de los salones, registrar clientes y reservas, controlar los pagos y realizar auditorías sobre los cambios de precios.

Además, se implementaron funciones personalizadas, triggers, una vista y consultas SQL para facilitar la gestión de la información y apoyar la toma de decisiones administrativas.

## Objetivo
Diseñar e implementar una base de datos relacional para gestionar las reservas de salones de eventos de Eventos Premier S.A.S., garantizando la integridad de los datos y automatizando diferentes procesos mediante SQL.


## Relaciones entre las tablas y Modelo Logico

Las principales relaciones implementadas son:

CLIENTES 1 ────────── N RESERVAS N ──────── 1 SALONES

Un cliente puede realizar muchas reservas, pero cada reserva pertenece a un solo cliente.

Un salón puede tener muchas reservas a lo largo del tiempo, pero cada reserva corresponde a un solo salón.

Además:

RESERVAS 1 ─────────── N PAGOS

Una reserva puede tener uno o varios pagos asociados.

Y también:

SALONES 1 ─────────── N AUDITORIA_PRECIOS

Un salón puede tener varios registros de cambios de precio a lo largo del tiempo.
![modelo_logico](/img/modelo%20logico%20draw.io.JPG)

## Funciones SQL
**1. calcular_total_reserva**

Esta función recibe precio por hora y cantidad de horas y calcula el valor total de la reserva incluyendo el 19 % de IVA.

**Ejemplo**

SELECT calcular_total_reserva(150000, 4);

Resultado:
![funcion_1](/img/funcion%201.JPG)


**2. verificar_disponibilidad**

La función consulta si existen reservas que se crucen con el período solicitado y verifica el estado correspondiente del salón.

Los resultados de la función debe ser:

1 → Disponible
0 → Ocupado

**Ejemplo**

SELECT verificar_disponibilidad(1, '2026-08-18 10:00:00', '2026-08-18 14:00:00');

![funcion_2a](/img/funcion%202a.JPG)

SELECT verificar_disponibilidad(1, '2026-08-18 14:00:00', '2026-08-18 18:00:00');

![funcion_2b](/img/funcion%202b.JPG)


## Triggers

**1. actualizar_estado_salon_trigger**

Cuando se registra una nueva reserva, el trigger obtiene el salón asociado mediante "NEW.id_salon" y cambia su estado a 'Ocupado'.

![trigger_1](/img/trigger%201.JPG)

![trigger_1b](/img/trigger%201b.JPG)


**2. liberar_salon_trigger**

Cuando se elimina una reserva, el trigger utiliza "OLD.id_salon" para identificar el salón asociado a la reserva eliminada y cambiar su estado a 'Disponible'.

![trigger_2a](/img/trigger%202a.JPG)

![trigger_2b](/img/trigger%202b.JPG)


**3. auditoria_precios_trigger**

Este trigger registra automáticamente los cambios realizados sobre el precio por hora de un salón. Utiliza "OLD.precio_por_hora" para obtener el precio anterior y "NEW.precio_por_hora" para obtener el nuevo precio.

También registra CURRENT_USER() para identificar el usuario y NOW() para almacenar la fecha y hora del cambio.

![trigger_3a](/img/trigger%203a.JPG)

![trigger_3b](/img/trigger%203b.JPG)

![trigger_3c](/img/trigger%203c.JPG)

## Consultas SQL
**1. Reservas realizadas en un rango de fechas**

Se utiliza BETWEEN para obtener las reservas realizadas dentro de un período determinado.

![consulta_1](/img/consulta%201.JPG)

**2. Salones con capacidad mayor a X y disponibles**

Esta consulta permite identificar salones que cumplen simultáneamente con una capacidad mínima y que actualmente se encuentran disponibles.

![consulta_2](/img/consulta%202.JPG)

**3. Clientes corporativos con más de 3 reservas**

Esta consulta utiliza INNER JOIN, COUNT(), GROUP BY, HAVING para encontrar clientes corporativos que hayan realizado más de tres reservas.

![consulta_3](/img/consulta%203.JPG)

## Vista vista_resumen_reservas

Se creó una vista para consultar de manera sencilla un resumen de las reservas.

La vista muestra nombre del cliente, nombre del salón, fecha y hora de inicio, fecha y hora de finalización, valor total, estado del salón.


## Tecnologías utilizadas
- MySQL Workbench
- SQL
- GitHub


## Instrucciones de ejecución
Abrir MySQL Workbench.
Crear o abrir una conexión al servidor MySQL.
Ejecutar el script de creación de la base de datos:
CREATE DATABASE proyecto_eventos_premier;
Seleccionar la base de datos:
USE proyecto_eventos_premier;
Ejecutar las instrucciones CREATE TABLE.
Ejecutar las inserciones de datos.
Ejecutar las funciones.
Ejecutar los triggers.
Crear la vista.
Ejecutar las consultas y realizar las pruebas correspondientes.

## Autor

# Natalia Rolón Leal


## Conclusión

El proyecto permitió diseñar e implementar una base de datos relacional para gestionar las operaciones principales de Eventos Premier S.A.S.

Durante el desarrollo se aplicaron conceptos fundamentales de SQL y bases de datos, como llaves primarias, llaves foráneas, relaciones entre tablas, funciones, triggers, vistas, consultas, JOIN, COUNT, GROUP BY, HAVING y BETWEEN.

La implementación de triggers permitió automatizar procesos importantes, como la actualización del estado de los salones y el registro de cambios en los precios. Las funciones permiten reutilizar operaciones específicas y la vista facilita la consulta consolidada de la información de las reservas.

De esta manera, el sistema proporciona una estructura organizada para administrar clientes, salones, reservas y pagos, manteniendo la integridad de la información y facilitando la gestión administrativa.