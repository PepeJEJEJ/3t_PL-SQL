/*1. Mostrar 'Hola Mundo' por pantalla */
declare
begin -- INICIAR EL CODIGO
    dbms_output.Put_line('HOLA MUNDO');
end;
/
/* 2. Declarar variable y multiplicarla por 2*/
declare
    numero number:=5; -- DECLARAR VARIABLES
begin -- INICIAR EL CODIGO
    numero := numero*2; -- CALCULO
    dbms_output.Put_line('El resultado es: ' || numero);
end;
/
-- / es para SEPARAR LOS BLOQUES
/*COMENTARIOS*/
-- EJEMPLO 1
/*EJEMPLO 2*/
/*3. Declarar una variable numérica y mostrar si es mayor que 10*/
declare
    numero number:=5; -- DECLARAR VARIABLES
begin -- INICIAR EL CODIGO
        IF numero>10 THEN -- SI NUMERO ES MAYOR QUE 10
            dbms_output.Put_line(numero || ' Es Mayor que 10');
        ELSIF numero<10 THEN -- PERO SI NUMERO ES MENOR QUE 10
            dbms_output.Put_line(numero || ' Es Menor que 10');
        END IF;-- FIN
end;
/
/*4. Mostrar los números del 1 al 10 con while*/
declare
    n number:=0; -- NUMERO QUE USAMOS
begin
    while n<10 loop -- ES LOOP, NO DO Y ES MIENTRAS SE CUMPLA ESTO, ENTONCES...
        n := n+1; -- SUMALE A N, UNO MAS
        dbms_output.Put_line(n);
    end loop; -- CERRAR EL BUCLE
end;
/
/*5. Mostrar los números del 1 al 10 con for*/
declare
    n number:=0;
begin
    for n in 1..10 loop -- ES COMO WHILE PERO PONEMOS QUE ES N DESDE X .. HASTA Y
        dbms_output.Put_line(n);
    end loop;
end;
/
/*6. Declarar variable númerica nota y mostrar con casi si aprobado o no */
declare
    nota number:=4;
begin
        IF nota<4 THEN -- SI...
            dbms_output.Put_line(nota || ' SUSPENSO');
        ELSIF nota=4 THEN -- PERO SI...
            dbms_output.Put_line(nota || ' casi');
        ELSIF nota<=10 THEN -- PERO SI...
            dbms_output.Put_line(nota || ' aprobado');
        ELSE -- SI NO ES NINGUNA...
            dbms_output.Put_line(nota || ' NEL');
        END IF;
end;
/
/*Excepciones*/
declare
    prueba number :=0;
    resultado number;
begin
    resultado := prueba/0; -- PA CAUSAR UN ERROR
        dbms_output.Put_line('El resultado es'|| resultado);
    exception -- SOLTAR EXCEPCION
    when zero_divide then -- SI SE DIVIDE POR 0
        dbms_output.Put_line('FALLO'|| sqlCODE); -- TB VALE SQL ERRM
    when others then
            dbms_output.Put_line('CUALQUIER OTRO ERROR');
end;
/
/*Excepciones Personalizadas*/
declare
    edad number :=-1;
    edad_exception exception;
begin
    if edad < 0 or edad > 120 then
    raise edad_exception; -- PA MOSTRAR UNA EXCEPCION
end if;
exception
    when edad_exception then
    dbms.output.put_line('Error en la variable error');
end;
/
/*BLOQUE ANONIMO*/
declare --%TYPE: ENCUENTRA EL MISMO TIPO QUE EL CAMPO QUE USEMOS
    v_id marcas_coche.id_marca%type := &id_marca1; -- := &id_marca1; es como el scanner de java
    v_marca marcas_coche.marca%type; -- v_xxxx = valor, marcas_coche = tabla .xxxx = campo de la tabla
begin
    select marca into v_marca from marcas_coche
    where id_marca=v_id;
    dbms_output.put_line('La marca con id '|| v_id ||  ' es '|| v_marca);
end;
/

declare
    v_dni cliente.dni%type := '&dni';
    v_nombre cliente.nombre%type;
    v_tlf cliente.telef%type;
begin -- SELECCIONAR CAMPOS DE LA TABLA Y PONERLOS EN LAS VARIABLES ANTERIORES SACADAS DE LA TABLA
    select nombre, telef into v_nombre, v_tlf from cliente
    where dni = v_dni; -- DNI IGUAL AL DE LA VARIABLE DNI
    dbms_output.put_line('La marca con dni '|| v_dni ||  ' es '|| v_nombre || '_' || v_tlf);
end;
/