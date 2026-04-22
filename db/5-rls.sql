ALTER TABLE obras ENABLE ROW LEVEL SECURITY;

CREATE POLICY lectura_obras ON obras FOR SELECT USING (true);
CREATE POLICY edicion_obras ON obras FOR UPDATE USING (id_usuario = get_current_id()) WITH CHECK (id_usuario = get_current_id());
CREATE POLICY borrado_obras ON obras FOR DELETE USING (id_usuario = get_current_id());


ALTER TABLE perfiles ENABLE ROW LEVEL SECURITY;

CREATE POLICY edicion_perfil ON perfiles FOR UPDATE USING (id_usuario = get_current_id());
CREATE POLICY borrado_perfil ON perfiles FOR DELETE USING (id_usuario = get_current_id());


ALTER TABLE comentarios ENABLE ROW LEVEL SECURITY;

CREATE POLICY edicion_comentario ON comentarios FOR UPDATE USING (id_usuario = get_current_id());
CREATE POLICY borrado_comentario ON comentarios FOR DELETE USING (id_usuario = get_current_id());


ALTER TABLE respuestas_comentario ENABLE ROW LEVEL SECURITY;

CREATE POLICY edicion_respuesta ON respuestas_comentario FOR UPDATE USING (id_usuario = get_current_id());
CREATE POLICY borrado_respuesta ON respuestas_comentario FOR DELETE USING (id_usuario = get_current_id());