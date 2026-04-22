CREATE POLICY lectura_obras ON obras FOR SELECT USING (true);

CREATE POLICY edicion_obras ON obras FOR UPDATE, DELETE USING (auth.uid() = id_usuario);