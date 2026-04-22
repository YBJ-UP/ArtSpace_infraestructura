CREATE OR REPLACE VIEW vw_detalles_obra AS
SELECT
    o.id_obra,
    o.titulo,
    o.descripcion,
    o.fecha_publicacion,

    u.nombre AS usuario,
    p.avatar,

    cat.nombre AS categoria,
    sub.nombre AS Subcategoria,

    (SELECT COUNT(*) FROM media m WHERE m.id_obra = o.id_obra) AS archivos_totales,
    (SELECT COUNT(*) FROM likes l WHERE l.id_obra = o.id_obra) AS likes_totales,
    (SELECT COUNT(*) FROM comentarios c WHERE c.id_obra = o.id_obra) AS comentarios_totales

FROM obras o
LEFT JOIN usuarios u ON o.id_usuario = u.id_usuario
LEFT JOIN perfiles p ON u.id_usuario = p.id_usuario
LEFT JOIN obra_subcategoria os ON o.id_obra = os.id_obra
LEFT JOIN subcategorias sub ON o.id_obra = os.id_obra
LEFT JOIN categorias cat ON sub.id_categoria = cat.id_categoria;

SELECT * FROM vw_detalles_obra;