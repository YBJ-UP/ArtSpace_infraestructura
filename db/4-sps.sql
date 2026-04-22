CREATE OR REPLACE FUNCTION obtener_feed_usuario(p_id_usuario INT, p_limite INT DEFAULT 20)
RETURNS TABLE (
    id_obra INT,
    titulo VARCHAR,
    autor VARCHAR,
    fecha_publicacion TIMESTAMP
) AS $$
BEGIN
    RETURN QUERY
    SELECT o.id_obra, o.titulo, u.nombre, o.fecha_publicacion
    FROM obras o
    JOIN usuarios u ON o.id_usuario = u.id_usuario
    JOIN seguidores s ON o.id_usuario = s.usuario_destino
    WHERE s.usuario_origen = p_id_usuario
    ORDER BY o.fecha_publicacion DESC
    LIMIT p_limite;
END;
$$ LANGUAGE plpgsql;

-- obtiene un feed de usuario

CREATE OR REPLACE FUNCTION get_current_id() 
RETURNS int AS $$
    -- Devuelve el ID de la variable de sesión, o NULL si no está definida
    SELECT current_setting('app.current_user_id', true)::int;
$$ LANGUAGE sql STABLE;