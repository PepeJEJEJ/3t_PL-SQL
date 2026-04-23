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

