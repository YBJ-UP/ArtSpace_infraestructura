DROP ROLE IF EXISTS app;

CREATE ROLE app WITH 
LOGIN 
PASSWORD 'ARTSPACE_APP'
NOSUPERUSER
NOCREATEDB
NOCREATEROLE
NOINHERIT;

-- Permisos sobre tablas
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO app;

-- Permisos sobre secuencias (necesario para los SERIAL/autoincrement)
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO app;

-- Permisos sobre vistas
GRANT SELECT ON vw_detalles_obra TO app;
GRANT SELECT ON vw_detalles_perfil TO app;