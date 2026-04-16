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
    exception 
    when zero_divide then
        dbms_output.Put_line('FALLO'|| sqlcode);
    when others then
            dbms_output.Put_line('CUALQUIER OTRO ERROR');
end;