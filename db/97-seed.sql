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

-- Subcategorías de Escultura
INSERT INTO subcategorias (nombre, id_categoria) VALUES
    ('Arcilla', 4),
    ('Madera', 4),
    ('Metal', 4);

-- Subcategorías de Música
INSERT INTO subcategorias (nombre, id_categoria) VALUES
    ('Composición', 5),
    ('Producción', 5),
    ('Instrumental', 5);

-- Subcategorías de Literatura
INSERT INTO subcategorias (nombre, id_categoria) VALUES
    ('Poesía', 6),
    ('Cuento', 6),
    ('Ensayo', 6);

-- Usuario admin de prueba (password: admin123 hasheado con bcrypt)
INSERT INTO usuarios (nombre, correo, password, rol) VALUES
    ('Admin ArtSpace', 'admin@artspace.com',
    '$2b$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LPZp.OdEGmC',
    'admin');