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
        return dbms_output.put_line('NO HAY DATOS');
end;
/

declare
    v_result number;
begin
    v_result := suma_ventas_empleado('&dni_empleado');
    dbms_output.put_line('La Suma de las ventas: ' || v_result);
end;
/
