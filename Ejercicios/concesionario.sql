-- 1. Eliminación de tablas previas si existen
DROP TABLE vende CASCADE CONSTRAINTS;
DROP TABLE coche CASCADE CONSTRAINTS;
DROP TABLE modelo_coche CASCADE CONSTRAINTS;
DROP TABLE cliente CASCADE CONSTRAINTS;
DROP TABLE empleado CASCADE CONSTRAINTS;
DROP TABLE tipos_forma_pago CASCADE CONSTRAINTS;
DROP TABLE marcas_coche CASCADE CONSTRAINTS;
DROP TABLE tipos_puesto CASCADE CONSTRAINTS;

-- 2. Tablas base

CREATE TABLE tipos_puesto (
  id_puesto NUMBER(3) PRIMARY KEY,
  puesto VARCHAR2(30)
);

CREATE TABLE empleado (
  dni VARCHAR2(9) PRIMARY KEY,
  nombre VARCHAR2(60),
  id_puesto NUMBER(3),
  telef VARCHAR2(12),
  anio_incorporacion NUMBER(4),
  CONSTRAINT fk_empleado_tipos_puesto FOREIGN KEY (id_puesto) REFERENCES tipos_puesto
);

CREATE TABLE marcas_coche (
  id_marca NUMBER(3) PRIMARY KEY,
  marca VARCHAR2(30)
);

CREATE TABLE modelo_coche (
  id_modelo NUMBER PRIMARY KEY,
  descripcion VARCHAR2(60),
  id_marca NUMBER,
  CONSTRAINT fk_modelo_marcas FOREIGN KEY (id_marca) REFERENCES marcas_coche
);

CREATE TABLE coche (
  matricula VARCHAR2(7) PRIMARY KEY,
  id_modelo NUMBER,
  precio_compra NUMBER(6),
  CONSTRAINT fk_coche_modelo FOREIGN KEY (id_modelo) REFERENCES modelo_coche
);

CREATE TABLE cliente (
  dni VARCHAR2(9) PRIMARY KEY,
  nombre VARCHAR2(60),
  telef VARCHAR2(12)
);

CREATE TABLE tipos_forma_pago (
  id_forma_pago NUMBER(3) PRIMARY KEY,
  forma_pago VARCHAR2(20)
);

CREATE TABLE vende (
  dni_empleado VARCHAR2(9),
  dni_cliente VARCHAR2(9),
  matricula VARCHAR2(7),
  fecha DATE,
  id_forma_pago NUMBER(3),
  precio NUMBER(6),
  CONSTRAINT pk_vende PRIMARY KEY (dni_cliente, matricula),
  CONSTRAINT fk_vende_empleado FOREIGN KEY (dni_empleado) REFERENCES empleado,
  CONSTRAINT fk_vende_cliente FOREIGN KEY (dni_cliente) REFERENCES cliente,
  CONSTRAINT fk_vende_coche FOREIGN KEY (matricula) REFERENCES coche,
  CONSTRAINT fk_venta_tipos_forma_pago FOREIGN KEY (id_forma_pago) REFERENCES tipos_forma_pago
);

-- 3. Inserción de datos

-- Puestos
INSERT INTO tipos_puesto VALUES (1, 'Vendedor particulares');
INSERT INTO tipos_puesto VALUES (2, 'Coordinador ventas');
INSERT INTO tipos_puesto VALUES (3, 'Recepcionista');
INSERT INTO tipos_puesto VALUES (4, 'Mecánico');
INSERT INTO tipos_puesto VALUES (5, 'Vendedor empresas');

-- Empleados
INSERT INTO empleado VALUES ('05678245B','García Gómez, Andrés',3,'694532211', 2000);
INSERT INTO empleado VALUES ('90774536C','Pérez Pérez, Luisa',1,'676885643', 2016);
INSERT INTO empleado VALUES ('45327865A','Gómez Rubio, Ana',5,'654772134', 2014);
INSERT INTO empleado VALUES ('05789494D','Martínez Alberca, José',4,null, 2002);

-- Marcas
INSERT INTO marcas_coche VALUES (1,'Renault');
INSERT INTO marcas_coche VALUES (2,'Ford');
INSERT INTO marcas_coche VALUES (3,'Citroen');
INSERT INTO marcas_coche VALUES (4,'Audi');
INSERT INTO marcas_coche VALUES (5,'Mercedes');
INSERT INTO marcas_coche VALUES (6,'Kia');
INSERT INTO marcas_coche VALUES (7,'Volkswagen');
INSERT INTO marcas_coche VALUES (8,'Opel');

-- Modelos
INSERT INTO modelo_coche VALUES (1,'A5 modelo alta gama',4);
INSERT INTO modelo_coche VALUES (2,'Zafira Año 2015',8);
INSERT INTO modelo_coche VALUES (3,'Kangoo',3);
INSERT INTO modelo_coche VALUES (4,'Golf GTI',7);
INSERT INTO modelo_coche VALUES (5,'A4 básico',4);
INSERT INTO modelo_coche VALUES (6,'C4 Exclusive',3);
INSERT INTO modelo_coche VALUES (7,'C4 Gran Picasso',3);
INSERT INTO modelo_coche VALUES (10,'Kouga',2);
INSERT INTO modelo_coche VALUES (11,'DS C4',3);
INSERT INTO modelo_coche VALUES (12,'Astra Año 2014',8);

-- Coches
INSERT INTO coche VALUES ('3345GVF', 1, 6000);
INSERT INTO coche VALUES ('3346GVA', 6, NULL);
INSERT INTO coche VALUES ('4446GCN', 7, NULL);
INSERT INTO coche VALUES ('3287GVA', 2, 3000);
INSERT INTO coche VALUES ('1290ASX', 10, NULL);
INSERT INTO coche VALUES ('5487NDA', 11, NULL);
INSERT INTO coche VALUES ('8666KKK', 3, 9000);
INSERT INTO coche VALUES ('5689ADD', 4, 3000);
INSERT INTO coche VALUES ('7894AAA', 5, 3000);
INSERT INTO coche VALUES ('1212BAD', 12, NULL);
INSERT INTO coche VALUES ('4569GVA', 6, 5000);
INSERT INTO coche VALUES ('9876AFF', 6, 5000);

-- Clientes
INSERT INTO cliente VALUES ('07541212F','Fernández Arco, Cristina','926227345');
INSERT INTO cliente VALUES ('05478218A','Gracia Soler, Luis Alberto','676443789');
INSERT INTO cliente VALUES ('04787675D','Ruiz Morales, Fernando','654332211');

-- Formas de pago
INSERT INTO tipos_forma_pago VALUES (1,'Contado');
INSERT INTO tipos_forma_pago VALUES (2,'Tarjeta');
INSERT INTO tipos_forma_pago VALUES (3,'Talón');
INSERT INTO tipos_forma_pago VALUES (4,'Transferencia');
INSERT INTO tipos_forma_pago VALUES (5,'Financiado');

-- Ventas
INSERT INTO vende VALUES ('90774536C','07541212F','3345GVF',TO_DATE('19/03/18','DD/MM/RR'),1,7000);
INSERT INTO vende VALUES ('90774536C','07541212F','7894AAA',TO_DATE('09/03/16','DD/MM/RR'),5,12000);
INSERT INTO vende VALUES ('45327865A','04787675D','1290ASX',TO_DATE('06/02/18','DD/MM/RR'),5,9000);
INSERT INTO vende VALUES ('45327865A','04787675D','8666KKK',TO_DATE('12/12/17','DD/MM/RR'),3,16000);
