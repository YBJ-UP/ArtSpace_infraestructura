ALTER TABLE obras ENABLE ROW LEVEL SECURITY;

CREATE POLICY lectura_obras ON obras FOR SELECT USING (true);

CREATE POLICY edicion_obras ON obras FOR UPDATE USING (id_usuario = get_current_id()) WITH CHECK (id_usuario = get_current_id());