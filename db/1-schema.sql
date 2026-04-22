-- ============================================================
--  ArtSpace — Schema PostgreSQL
--  Proyecto: AWOS 5B | Universidad Politécnica de Chiapas
--  Encargado DB: Yael Betanzos Jiménez (243678)
-- ============================================================

-- Limpiar si ya existe (útil al resetear en dev)
DROP TABLE IF EXISTS respuestas_comentario CASCADE;
DROP TABLE IF EXISTS comentarios CASCADE;
DROP TABLE IF EXISTS likes CASCADE;
DROP TABLE IF EXISTS media CASCADE;
DROP TABLE IF EXISTS obra_subcategoria CASCADE;
DROP TABLE IF EXISTS subcategorias CASCADE;
DROP TABLE IF EXISTS categorias CASCADE;
DROP TABLE IF EXISTS obras CASCADE;
DROP TABLE IF EXISTS seguidores CASCADE;
DROP TABLE IF EXISTS perfiles CASCADE;
DROP TABLE IF EXISTS usuarios CASCADE;

-- ============================================================
-- 1. USUARIOS
-- ============================================================
CREATE TABLE usuarios (
    id_usuario   SERIAL PRIMARY KEY,
    nombre       VARCHAR(100)        NOT NULL,
    correo       VARCHAR(150)        NOT NULL UNIQUE,
    password     VARCHAR(255)        NOT NULL,  -- guardar hash bcrypt
    rol          VARCHAR(20)         NOT NULL DEFAULT 'artista'
                                    CHECK (rol IN ('artista', 'admin')),
    fecha_registro TIMESTAMP         NOT NULL DEFAULT NOW()
);

-- ============================================================
-- 2. PERFILES (1:1 con usuarios)
-- ============================================================
CREATE TABLE perfiles (
    id_perfil    SERIAL PRIMARY KEY,
    biografia    TEXT,
    avatar       VARCHAR(500),        -- URL de Cloudinary
    id_usuario   INT NOT NULL UNIQUE
                REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

-- ============================================================
-- 3. SEGUIDORES (self-referencia en usuarios)
-- ============================================================
CREATE TABLE seguidores (
    id_seguidor      SERIAL PRIMARY KEY,
    usuario_origen   INT NOT NULL REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    usuario_destino  INT NOT NULL REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    fecha            TIMESTAMP NOT NULL DEFAULT NOW(),
    UNIQUE (usuario_origen, usuario_destino),
    CHECK (usuario_origen <> usuario_destino)
);

-- ============================================================
-- 4. CATEGORÍAS Y SUBCATEGORÍAS
-- ============================================================
CREATE TABLE categorias (
    id_categoria SERIAL PRIMARY KEY,
    nombre       VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE subcategorias (
    id_subcategoria SERIAL PRIMARY KEY,
    nombre          VARCHAR(100) NOT NULL,
    id_categoria    INT NOT NULL REFERENCES categorias(id_categoria) ON DELETE CASCADE
);

-- ============================================================
-- 5. OBRAS
-- ============================================================
CREATE TABLE obras (
    id_obra           SERIAL PRIMARY KEY,
    titulo            VARCHAR(200)  NOT NULL,
    descripcion       TEXT,
    fecha_publicacion TIMESTAMP     NOT NULL DEFAULT NOW(),
    id_usuario        INT           NOT NULL REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

-- ============================================================
-- 6. TABLA INTERMEDIA obra_subcategoria (N:M)
-- ============================================================
CREATE TABLE obra_subcategoria (
    id_obra         INT NOT NULL REFERENCES obras(id_obra) ON DELETE CASCADE,
    id_subcategoria INT NOT NULL REFERENCES subcategorias(id_subcategoria) ON DELETE CASCADE,
    PRIMARY KEY (id_obra, id_subcategoria)
);

-- ============================================================
-- 7. MEDIA (imágenes/archivos de una obra)
-- ============================================================
CREATE TABLE media (
    id_media   SERIAL PRIMARY KEY,
    archivo    VARCHAR(500) NOT NULL,  -- URL de Cloudinary
    tipo       VARCHAR(50)  NOT NULL DEFAULT 'imagen'
                CHECK (tipo IN ('imagen', 'video', 'audio')),
    id_obra    INT          NOT NULL REFERENCES obras(id_obra) ON DELETE CASCADE
);

-- ============================================================
-- 8. LIKES
-- ============================================================
CREATE TABLE likes (
    id_like    SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    id_obra    INT NOT NULL REFERENCES obras(id_obra) ON DELETE CASCADE,
    fecha      TIMESTAMP NOT NULL DEFAULT NOW(),
    UNIQUE (id_usuario, id_obra)  -- un usuario no puede likear dos veces la misma obra
);

-- ============================================================
-- 9. COMENTARIOS
-- ============================================================
CREATE TABLE comentarios (
    id_comentario SERIAL PRIMARY KEY,
    contenido     TEXT      NOT NULL,
    fecha         TIMESTAMP NOT NULL DEFAULT NOW(),
    id_usuario    INT       NOT NULL REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    id_obra       INT       NOT NULL REFERENCES obras(id_obra) ON DELETE CASCADE
);

-- ============================================================
-- 10. RESPUESTAS A COMENTARIOS
-- ============================================================
CREATE TABLE respuestas_comentario (
    id_respuesta   SERIAL PRIMARY KEY,
    contenido      TEXT      NOT NULL,
    fecha          TIMESTAMP NOT NULL DEFAULT NOW(),
    id_usuario     INT       NOT NULL REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    id_comentario  INT       NOT NULL REFERENCES comentarios(id_comentario) ON DELETE CASCADE
);

-- ============================================================
-- ÍNDICES (mejoran velocidad de las queries más comunes)
-- ============================================================
CREATE INDEX idx_obras_usuario      ON obras(id_usuario);
CREATE INDEX idx_likes_obra         ON likes(id_obra);
CREATE INDEX idx_comentarios_obra   ON comentarios(id_obra);
CREATE INDEX idx_media_obra         ON media(id_obra);
CREATE INDEX idx_seguidores_origen  ON seguidores(usuario_origen);
CREATE INDEX idx_seguidores_destino ON seguidores(usuario_destino);

-- ============================================================
-- DATOS SEMILLA (seed) — para pruebas iniciales
-- ============================================================

-- Categorías base
INSERT INTO categorias (nombre) VALUES
    ('Pintura'),
    ('Fotografía'),
    ('Ilustración Digital'),
    ('Escultura'),
    ('Música'),
    ('Literatura');

-- Subcategorías de Pintura
INSERT INTO subcategorias (nombre, id_categoria) VALUES
    ('Acuarela', 1),
    ('Óleo', 1),
    ('Acrílico', 1),
    ('Arte abstracto', 1);

-- Subcategorías de Ilustración Digital
INSERT INTO subcategorias (nombre, id_categoria) VALUES
    ('Arte conceptual', 3),
    ('Pixel art', 3),
    ('Fan art', 3);

-- Subcategorías de Fotografía
INSERT INTO subcategorias (nombre, id_categoria) VALUES
    ('Retrato', 2),
    ('Paisaje', 2),
    ('Urbana', 2);

-- Usuario admin de prueba (password: admin123 hasheado con bcrypt)
INSERT INTO usuarios (nombre, correo, password, rol) VALUES
    ('Admin ArtSpace', 'admin@artspace.com',
    '$2b$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LPZp.OdEGmC',
    'admin');

-- ============================================================
-- VERIFICACIÓN RÁPIDA
-- ============================================================
-- Ejecuta esto para confirmar que todo quedó bien:
SELECT table_name FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;