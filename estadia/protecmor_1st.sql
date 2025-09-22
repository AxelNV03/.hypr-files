
-- SCRIPT SQL FINAL PARA TESIS: PROTECMOR - REPRESENTACIÓN VISUAL COMPLETA

DROP DATABASE IF EXISTS protecmor;
CREATE DATABASE protecmor;
USE protecmor;

-- Tabla de usuarios base de Laravel
CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    email_verified_at TIMESTAMP NULL,
    password VARCHAR(255) NOT NULL,
    remember_token VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de roles (Laravel / Spatie)
CREATE TABLE roles (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(191) NOT NULL,
    guard_name VARCHAR(191) NOT NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL
);

-- Tabla de permisos (Laravel / Spatie)
CREATE TABLE permissions (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(191) NOT NULL,
    guard_name VARCHAR(191) NOT NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL
);

-- Pivot: modelo tiene roles
CREATE TABLE model_has_roles (
    role_id BIGINT NOT NULL,
    model_type VARCHAR(191) NOT NULL,
    model_id BIGINT NOT NULL,
    PRIMARY KEY (role_id, model_id, model_type),
    FOREIGN KEY (role_id) REFERENCES roles(id),
    FOREIGN KEY (model_id) REFERENCES users(id)
);

-- Pivot: modelo tiene permisos
CREATE TABLE model_has_permissions (
    permission_id BIGINT NOT NULL,
    model_type VARCHAR(191) NOT NULL,
    model_id BIGINT NOT NULL,
    PRIMARY KEY (permission_id, model_id, model_type),
    FOREIGN KEY (permission_id) REFERENCES permissions(id),
    FOREIGN KEY (model_id) REFERENCES users(id)
);

-- Pivot: permisos por rol
CREATE TABLE role_has_permissions (
    permission_id BIGINT NOT NULL,
    role_id BIGINT NOT NULL,
    PRIMARY KEY (permission_id, role_id),
    FOREIGN KEY (permission_id) REFERENCES permissions(id),
    FOREIGN KEY (role_id) REFERENCES roles(id)
);

-- Tabla de grupos
CREATE TABLE grupos (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    clave VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(100),
    generacion VARCHAR(50),
    observaciones TEXT
);

-- Tabla de alumnos
CREATE TABLE alumnos (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    matricula VARCHAR(20) UNIQUE,
    grupo_id BIGINT,
    fecha_nacimiento DATE NOT NULL,
    telefono VARCHAR(20), -- opcional
    sexo ENUM('Masculino', 'Femenino', 'Otro') NULL, -- opcional
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (grupo_id) REFERENCES grupos(id)
);

-- Tabla de profesores
CREATE TABLE profesores (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    especialidad VARCHAR(100) NOT NULL,
    fecha_ingreso DATE,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Tabla de campos formativos
CREATE TABLE campos_formativos (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    tipo ENUM('materia', 'taller') NOT NULL
);

-- Tabla de clases
CREATE TABLE clases (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    grupo_id BIGINT NOT NULL,
    profesor_id BIGINT NOT NULL,
    campo_formativo_id BIGINT NOT NULL,
    fecha_inicio DATE,
    fecha_fin DATE,
    FOREIGN KEY (grupo_id) REFERENCES grupos(id),
    FOREIGN KEY (profesor_id) REFERENCES profesores(id),
    FOREIGN KEY (campo_formativo_id) REFERENCES campos_formativos(id)
);

-- Tabla de calificaciones
CREATE TABLE calificaciones (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    alumno_id BIGINT NOT NULL,
    clase_id BIGINT NOT NULL,
    calificacion DECIMAL(5,2),
    nivel_desempeno ENUM('Bajo','Regular','Bueno','Excelente'),
    FOREIGN KEY (alumno_id) REFERENCES alumnos(id),
    FOREIGN KEY (clase_id) REFERENCES clases(id)
);

-- Tabla de materiales y pase de lista
CREATE TABLE materiales (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    clase_id BIGINT NOT NULL,
    titulo VARCHAR(100),
    archivo_url VARCHAR(255),
    tipo ENUM('material', 'pase_lista') NOT NULL DEFAULT 'material',
    fecha_subida TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (clase_id) REFERENCES clases(id)
);

-- Tabla de mensajes por clase
CREATE TABLE mensajes (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    clase_id BIGINT NOT NULL,
    usuario_id BIGINT NOT NULL,
    contenido TEXT NOT NULL,
    fecha_envio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (clase_id) REFERENCES clases(id),
    FOREIGN KEY (usuario_id) REFERENCES users(id)
);

-- Tabla de constancias generadas
CREATE TABLE constancias (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    alumno_id BIGINT NOT NULL,
    taller_id BIGINT NOT NULL,
    archivo_url VARCHAR(255),
    fecha_emision DATE,
    FOREIGN KEY (alumno_id) REFERENCES alumnos(id),
    FOREIGN KEY (taller_id) REFERENCES campos_formativos(id)
);

-- Tabla de eventos
CREATE TABLE eventos (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    tipo VARCHAR(50),
    fecha DATE,
    hora TIME,
    duracion VARCHAR(50),
    costo DECIMAL(10,2),
    lugar VARCHAR(100),
    descripcion TEXT,
    publico ENUM('alumnos','general','ambos'),
    requiere_inscripcion BOOLEAN,
    visible BOOLEAN DEFAULT TRUE,
    incluido_mensualidad BOOLEAN DEFAULT FALSE
);

-- Productos
DROP TABLE IF EXISTS productos;
CREATE TABLE productos (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL,
    costo DECIMAL(10,2),
    proveedor VARCHAR(100),
    categoria VARCHAR(100),
    disponible BOOLEAN DEFAULT TRUE,
    imagen VARCHAR(255),
    visible BOOLEAN DEFAULT TRUE
);

-- Tabla de pagos
CREATE TABLE pagos (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    alumno_id BIGINT NOT NULL,
    tipo ENUM('inscripcion','mensualidad'),
    monto DECIMAL(10,2),
    fecha_pago DATE,
    estado ENUM('pendiente','pagado','atrasado'),
    FOREIGN KEY (alumno_id) REFERENCES alumnos(id)
);

-- Tabla de respaldos
CREATE TABLE respaldos (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre_archivo VARCHAR(100),
    usuario_id BIGINT NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ruta TEXT,
    FOREIGN KEY (usuario_id) REFERENCES users(id)
);

-- Tabla de notificaciones
CREATE TABLE notificaciones (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    usuario_id BIGINT NOT NULL,
    tipo ENUM('informativa','recordatorio','advertencia'),
    titulo VARCHAR(100) NOT NULL,
    mensaje TEXT NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES users(id)
);
