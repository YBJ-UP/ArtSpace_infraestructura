CREATE OR REPLACE FUNCTION crear_perfil()
RETURNS TRIGGER AS $$
BEGIN
    RAISE NOTICE "Creando perfil..."
    INSERT INTO perfiles (id_usuario) VALUES (NEW.id_usuario);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_crear_perfil_usuario
AFTER INSERT ON usuarios
FOR EACH ROW
EXECUTE FUNCTION crear_perfil_automatico();