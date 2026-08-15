CREATE DATABASE proyecto_gaseosas_del_valle;
USE proyecto_gaseosas_del_valle;

CREATE TABLE clientes(
	id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(100),
    identificacion VARCHAR(20),
    direccion VARCHAR(50),
    telefono VARCHAR(20),
    correo_electronico VARCHAR(100)
);

CREATE TABLE sedes(
	id_sede INT AUTO_INCREMENT PRIMARY KEY,
    nombre_sede VARCHAR(50),
    ubicacion VARCHAR(50),
    capacidad_almacenamiento INT,
    encargado VARCHAR(100)
);

CREATE TABLE productos(
	id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    categoria VARCHAR(50),
    precio DECIMAL(10,2),
    volumen_ml FLOAT,
    stock_actual INT,
    stock_minimo INT
);

CREATE TABLE pedidos(
	id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    fecha_pedido DATE,
    id_cliente INT, -- FK
    id_sede INT, -- FK
    total_sin_iva DECIMAL(10,2),
    total_con_iva DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_sede) REFERENCES sedes(id_sede)
);

CREATE TABLE detalle_pedido(
	id_pedido INT,
    id_producto INT,
    cantidad INT,
    subtotal DECIMAL(10,2),
    PRIMARY KEY (id_pedido, id_producto),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

CREATE TABLE auditoria_precios(
	id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT, -- FK
    precio_anterior DECIMAL(10,2),
    precio_nuevo DECIMAL(10,2),
    fecha_cambio DATE,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);