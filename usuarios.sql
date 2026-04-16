//
alter session set "_ORACLE_SCRIPT" = true;
// CREAR USUARIO
create user curso identified by "Med@c"
default tablespace users
temporary tablespace temp
quota 100M on users;
// BORRAR USUARIO
drop user curso cascade;
// 
grant connect, resource to curso;