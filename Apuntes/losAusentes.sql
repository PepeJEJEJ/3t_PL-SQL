/*Mostrar el nombre y teléfono de un cliente dado su dni. 
(lo mismo que el ejercicio anterior pero ahora utilizando %rowtype)*/
declare
    v_cliente cliente%rowtype;
    v_dni cliente.dni%type := '&dni';
begin
    select * into v_cliente
    from cliente
    where dni = v_dni;

    dbms_output.put_line('Nombre: ' || v_cliente.nombre ||
                         '  Telefono: ' || v_cliente.telef);
exception
    when no_data_found then
        dbms_output.put_line('NO HAY DATOS');
end;
/
/*BLOQUE 5 — Info coche por matrícula*/
declare
    v_coche coche%rowtype;
    v_mat coche.matricula%type := '&matricula';
begin
    select * into v_coche
    from coche
    where matricula = v_mat;

    dbms_output.put_line('MATRICULA: ' || v_coche.matricula ||
                         '  MODELO: ' || v_coche.id_modelo ||
                         '  PRECIO COMPRA: ' || v_coche.precio_compra);
exception
    when no_data_found then
        dbms_output.put_line('NO HAY DATOS');
end;
/
/*PROCEDIMIENTO 1 — Contar modelos Citroën*/
create or replace procedure contar_modelos_citroen is
    v_total number;
begin
    select count(*) into v_total
    from modelo_coche
    where id_marca = (select id_marca from marcas_coche where marca = 'Citroen');

    dbms_output.put_line('Modelos Citroen: ' || v_total);
end;
/
/*PROCEDIMIENTO 2 — Info venta por matrícula*/
create or replace procedure info_venta_matricula(p_mat coche.matricula%type) is
    v_nombre_cliente cliente.nombre%type;
    v_nombre_empleado empleado.nombre%type;
    v_precio vende.precio%type;
begin
    select c.nombre, e.nombre, v.precio
    into v_nombre_cliente, v_nombre_empleado, v_precio
    from vende v
    join cliente c on v.dni_cliente = c.dni
    join empleado e on v.dni_empleado = e.dni
    where v.matricula = p_mat;

    dbms_output.put_line('Cliente: ' || v_nombre_cliente);
    dbms_output.put_line('Empleado: ' || v_nombre_empleado);
    dbms_output.put_line('Precio venta: ' || v_precio);

exception
    when no_data_found then
        dbms_output.put_line('NO HAY DATOS');
end;
/

/*PROCEDIMIENTO 3 — ¿Empleado tiene ventas?*/
create or replace procedure tiene_ventas(p_dni empleado.dni%type) is
    v_total number;
begin
    select count(*) into v_total
    from vende
    where dni_empleado = p_dni;

    if v_total > 0 then
        dbms_output.put_line('TIENE VENTAS');
    else
        dbms_output.put_line('NO TIENE VENTAS');
    end if;
end;
/

/*FUNCIÓN 2 — Nº coches vendidos por empleado*/
create or replace function coches_vendidos(p_dni empleado.dni%type)
return number is
    v_total number;
begin
    select count(*) into v_total
    from vende
    where dni_empleado = p_dni;

    return v_total;
exception
    when no_data_found then
        return 0;
end;
/

/*FUNCIÓN 3 — Nombre cliente por DNI (con excepción)*/
create or replace function nombre_cliente(p_dni cliente.dni%type)
return varchar2 is
    v_nombre cliente.nombre%type;
begin
    select nombre into v_nombre
    from cliente
    where dni = p_dni;

    return v_nombre;

exception
    when no_data_found then
        raise_application_error(-20002, 'CLIENTE NO EXISTE');
end;
/

/*TRIGGER 2 — Insertar fecha actual automáticamente*/
create or replace trigger FechaInsercionCoche
before insert on coche
for each row
begin
    :new.fecha_insercion := sysdate;
end;
/

/*TRIGGER 3 — Impedir bajar precio_compra*/
create or replace trigger NoBajarPrecio
before update of precio_compra on coche
for each row
begin
    if :new.precio_compra < :old.precio_compra then
        raise_application_error(-20003, 'NO SE PUEDE BAJAR EL PRECIO DE COMPRA');
    end if;
end;
/