# 3t_PL-SQL
PL/SQL
⭐ RESUMEN GENERAL — TEMAS 15, 16 y 17 (PL/SQL)

(Todo lo que necesitas para examen, sin nada extra)

📘 TEMA 15 — El lenguaje PL/SQL

1. Qué es PL/SQL

Lenguaje procedimental de Oracle.

Basado en bloques: DECLARE – BEGIN – EXCEPTION – END.

Permite usar SQL + estructuras de programación.

2. Unidades léxicas

Delimitadores: + - * / = < > <= >= != := || ; ()

Identificadores: nombres de variables, funciones, etc.

Literales: números, texto 'texto', booleanos.

Comentarios:

-- una línea

/* ... */ varias líneas

3. Tipos de datos simples

Numéricos: NUMBER, PLS_INTEGER, BINARY_FLOAT, BINARY_DOUBLE.

Texto: CHAR, VARCHAR2, NCHAR, LONG.

Fecha: DATE, TIMESTAMP, INTERVAL.

LOB: CLOB, BLOB.

4. Variables y constantes

Sintaxis:

nombre [CONSTANT] tipo [:= valor];

%TYPE: mismo tipo que un campo.

%ROWTYPE: misma estructura que una fila.

5. Operadores

Aritméticos: + - * / **

Comparación: = < > <= >= !=

Lógicos: AND OR NOT

Concatenación: ||

6. Estructuras de control

IF

IF condición THEN
ELSIF condición THEN
ELSE
END IF;

CASE

CASE variable
  WHEN valor THEN ...
  ELSE ...
END CASE;

7. Bucles

WHILE

LOOP … EXIT WHEN … END LOOP

REPEAT UNTIL

FOR (muy usado con cursores)

8. Excepciones

Bloque:

EXCEPTION
  WHEN nombre THEN ...
  WHEN OTHERS THEN ...

Tipos:

Predefinidas Oracle

No definidas (SQLCODE, SQLERRM)

Definidas por usuario + RAISE

9. Librerías

UTL_FILE (archivos)

DBMS_LOCK

DBMS_SCHEDULER

DBMS_UTILITY

📘 TEMA 16 — Tipos de datos compuestos y cursores

1. Registros (RECORD)

Sintaxis:

TYPE nombre IS RECORD(
  campo tipo,
  campo tipo
);

Acceso: registro.campo

%TYPE y %ROWTYPE aplican igual.

2. Arrays (VARRAY)

TYPE nombre IS VARRAY(n) OF tipo;

Métodos:

EXTEND, COUNT, LIMIT, FIRST, LAST, PRIOR, NEXT

3. Arrays asociativos

TYPE tabla IS TABLE OF tipo INDEX BY VARCHAR2(100);

Clave → valor

Sin límite de tamaño

4. Tablas anidadas

TYPE nombre IS TABLE OF tipo;

Métodos:

EXTEND, COUNT, FIRST, LAST, DELETE, TRIM

5. Cursores

Implícitos

Oracle los crea automáticamente (cursor SQL).

Explícitos

CURSOR c IS SELECT ...;
OPEN c;
FETCH c INTO variables;
CLOSE c;

Propiedades

%FOUND

%NOTFOUND

%ROWCOUNT

%ISOPEN

Cursores con parámetros

CURSOR c(p NUMBER) IS SELECT ... WHERE campo = p;

Actualización con cursores

FOR UPDATE OF campo NOWAIT
WHERE CURRENT OF cursor;

📘 TEMA 17 — Subprogramas y disparadores

1. Procedimientos

CREATE OR REPLACE PROCEDURE nombre(parametros) IS
BEGIN
END;

No devuelven valor.

Se llaman con: EXEC nombre(...)

2. Funciones

CREATE OR REPLACE FUNCTION nombre(...) RETURN tipo IS
BEGIN
  RETURN valor;
END;

Devuelven valor.

Se pueden usar en SELECT (con limitaciones).

3. Paquetes

Dos partes:

Especificación (interfaz)

Cuerpo (implementación)

4. Triggers (disparadores)

CREATE OR REPLACE TRIGGER nombre
BEFORE | AFTER | INSTEAD OF
INSERT OR UPDATE OR DELETE ON tabla
FOR EACH ROW
BEGIN
END;

Restricciones

NO se permite: COMMIT, ROLLBACK, SAVEPOINT.

No LONG ni LONG RAW.

Orden de ejecución

BEFORE statement

BEFORE row

AFTER row

AFTER statement

Referencias

:OLD.campo

:NEW.campo

Cláusulas

IF INSERTING

IF UPDATING

IF DELETING

Triggers INSTEAD OF

Solo para vistas.

5. Automatización

DBMS_SCHEDULER

DBMS_JOB

CRON

SQLPlus + shell*

✔️ RESUMEN FINAL (ultracorto para examen)

PL/SQL = SQL + programación (bloques, variables, bucles, excepciones).

Tipos simples: NUMBER, VARCHAR2, DATE, BOOLEAN.

Control: IF, CASE, WHILE, LOOP, FOR.

Excepciones: WHEN … THEN, WHEN OTHERS.

Registros: RECORD, %TYPE, %ROWTYPE.

Colecciones: VARRAY, asociativos, tablas anidadas.

Cursores: implícitos y explícitos, OPEN–FETCH–CLOSE, %FOUND.

Procedimientos: no devuelven valor.

Funciones: devuelven valor.

Paquetes: especificación + cuerpo.

Triggers: BEFORE/AFTER/INSTEAD OF, row/statement, OLD/NEW.

Scheduler: automatización de tareas.

