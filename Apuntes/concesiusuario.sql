-- ESTO ES PARA PERMITIRNOS Crear usuarios y objetos
alter session set "_ORACLE_SCRIPT" = true;
-- BORRAR USUARIO
drop user concesionario cascade;
-- CREAR USUARIO
create user concesionario identified by "Med@c"
default tablespace users -- EL ESPACIO DE TABLA
temporary tablespace temp -- EL ESPACIO TEMPORAL
quota 100M on users; -- EL ESPACIO DE MEMORIA
-- GARANTIZAR LA CONEXION AL USUARIO
grant connect, resource to concesionario;