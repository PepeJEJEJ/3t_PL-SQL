/*BLOQUES ANÓNIMOS*/

/*1 Mostrar el nombre de la marca dado su id.*/
declare
    v_id marcas_coche.id_marca%type := &id_marca1;
    v_marca marcas_coche.marca%type;
begin
    select marca into v_marca from marcas_coche
    where id_marca=v_id;
    dbms_output.put_line('La marca con id '|| v_id ||  ' es '|| v_marca);
end;
/

/*2 Mostrar el nombre y teléfono de un cliente dado su dni. 
(al tratarse de un varchar2 tenéis que poner el dni entre comillas simples)*/
declare
    v_dni cliente.dni%type := '&dni';
    v_nombre cliente.nombre%type;
    v_tlf cliente.telef%type;
begin
    select nombre, telef into v_nombre, v_tlf from cliente
    where dni = v_dni;
    dbms_output.put_line('La persona con dni '|| v_dni ||  ' es '|| v_nombre || ' y telefono: ' || v_tlf);
end;
/

/*3 Igual que le anterior pero capturando una excepcion en caso 
de que no existan datos(no_data_found)*/
declare
    v_dni cliente.dni%type := '&dni';
    v_nombre cliente.nombre%type;
    v_tlf cliente.telef%type;
begin
    select nombre, telef into v_nombre, v_tlf from cliente
    where dni = v_dni;
    dbms_output.put_line('La persona con dni '|| v_dni ||  ' es '|| v_nombre || ' y telefono: ' || v_tlf);
exception
    when no_data_found then
    dbms_output.put_line('NO HAY DATOS');
end;
/

/*4 Mostrar el nombre y teléfono de un cliente dado su dni. 
(lo mismo que el ejercicio anterior pero ahora utilizando %rowtype)*/
declare
    v_cliente cliente%rowtype;
    v_dni cliente.dni%type := '&dni';
begin
    select * into v_cliente from cliente
    where dni = v_dni;
    dbms_output.put_line('La persona con dni '|| v_dni ||  ' es '|| v_nombre || ' y telefono: ' || v_tlf);
exception
    when no_data_found then
    dbms_output.put_line('NO HAY DATOS');
end;
/

/*5 Mostrar toda la información de un coche dada la matrícula (MATRICULA, ID_MODELO, PRECIO_COMPRA)*/
declare
    v_coche coche%rowtype;
    v_matricula coche.matricula%type := '&matricula'; 
begin
    select * into v_coche from coches
    where matricula = v_mat;
    dbms_output.put_line('El coche con matricula '|| v_coche.matricula ||  ' es un '|| v_coche.id_modelo || ' y su precio de compra es de: ' || v_coche.precio_compra);
exception
    when no_data_found then
    dbms_output.put_line('NO HAY DATOS');
end;
/

/*6 Mostrar toda la información del modelo de un coche dado un id, incluida el nombre de la marca.*/
declare
    v_id modelo_coche.id_modelo%type := &id_modelo;
    v_nombre_modelo modelo_coche.descripcion%type;
    v_id_marca modelo_coche.id_marca%type;
    v_marca marcas_coche.marca%type;
begin
    select descripcion, id_marca
    into v_nombre_modelo, v_id_marca
    from modelo_coche
    where id_modelo = v_id;

    select marca
    into v_marca
    from marcas_coche
    where id_marca = v_id_marca;

    dbms_output.put_line('ID MODELO: ' || v_id || 'NOMBRE MODELO: ' || v_nombre_modelo || 'ID MARCA: ' || v_id_marca || 'MARCA: ' || v_marca);
exception
    when no_data_found then
        dbms_output.put_line('NO HAY DATOS');
end;
/

/*7 Mostrar la suma de ventas. Pasa el dni del empleado por parámetro.*/
declare
    v_dni empleado.dni%type := '&dni';
    v_suma number;
begin
    select sum(precio) into v_suma from vende
    where dni_empleado = v_dni;
    dbms_output.put_line('La suma de las ventas del empleado con el dni:' || v_dni || ' es: ' || v_suma);
exception
    when no_data_found then
        dbms_output.put_line('NO HAY DATOS');
end;
/
/*PROCEDIMIENTOS*/
/*1 Mostrar cuantos modelos de coches hay de la marca 'Citroen'.*/
declare
    v_total number;
begin
    select count(*) into v_total
    from modelo_coche
    where id_marca = ( select id_marca from marcas_coche where marca = 'Citroen');
    dbms_output.put_line('Modelos de Citroen: ' || v_total);
exception
    when no_data_found then
        dbms_output.put_line('NO HAY DATOS');
end;
/

/*FUNCIONES*/

/*1 Realizar una función que devuelva la suma de ventas. Pasa el dni del empleado por parámetro.*/
create or replace function suma_ventas_empleado(p_dni empleado.dni%type)
return number
is
    v_total number;
begin
    select sum(precio) into v_total from vende
    where dni_empleado = p_dni;

    return v_total;
exception
    when no_data_found then
        dbms_output.put_line('NO HAY DATOS');
end;
/

declare
    v_result number;
begin
    v_result := suma_ventas_empleado('&dni_empleado');
    dbms_output.put_line('La Suma de las ventas: ' || v_result);
end;
/
/*2 Función que devuelve el número de coches vendidos por un empleado*/
create or replace function suma_ventas_empleado(p_dni empleado.dni%type)-- Crear (o reemplazar) la funcion
return number-- DEVOLVER NUMERO
is -- VA A DEVOLVER SOLO UN NUMERO
    v_total number;-- ESTE NUMERO
begin
    select sum(precio) into v_total from vende -- SELECCIONA Y SUMA TODOS LOS PRECIOS, PONLOS EN V_TOTAL, DE LA TABLA VENDE
    where dni_empleado = p_dni; -- SI EL DNI DEL EMPLEADO ES EL MISMO QUE EL DNI QUE TU PASES POR TECLADO

    return v_total; -- DEVUELVES EL VALOR TOTAL
exception
    when no_data_found then
        return dbms_output.put_line('NO HAY DATOS');
end;
/
/*LLAMAR A LA FUNCION*/
declare
    v_result number;-- DECLARAR LA VARIABLE RESULTADO
begin
    v_result := suma_ventas_empleado('&dni_empleado');-- LA VARIABLE ES ESTA:
    dbms_output.put_line('La Suma de las ventas: ' || v_result);
end;
/

/*DISPARADORES O TRIGGERS*/
/*1. Crear un trigger que verifique el precio de compra de un coche antes de insertarlo en la tabla coche. 
Si el precio es nulo o cero, el trigger debe evitar la inserción y lanzar una excepción.*/
create or replace trigger VerPrecioCompra -- Crear o reemplazar
before insert on coche -- EJECUTAR BEFORE (ANTES) o AFTER (DESPUES)
for each row
begin
    if :new.precio_compra is null or :new.precio_compra <=0 then
    raise_application_error(-20001, 'PRECIO COMPRA NO CORRECTO');
    END if;
end;
/*los campos de la tabla*/
insert into coche (matricula, id_modelo, precio_compra) values ('1234AA', 1, 0);

/*Crear un trigger que automáticamente inserte la fecha actual en la columna 
fecha_insercion cada vez que se añade un nuevo registro en la tabla coche.*/
create or replace trigger FechaInsercionCoche
before insert on coche
for each row
begin
    :new.fecha_insercion := sysdate;
end;
/

/*Crear un trigger que impida actualizar
el precio de compra de un coche si el nuevo precio es menor que el precio anterior.*/
create or replace trigger NoBajarPrecio
before update of precio_compra on coche
for each row
begin
    if :new.precio_compra < :old.precio_compra then
        raise_application_error(-20003, 'NO SE PUEDE BAJAR EL PRECIO DE COMPRA');
    end if;
end;
/
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