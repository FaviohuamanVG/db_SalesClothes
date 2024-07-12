CREATE DATABASE hackaton2;

USE VENTAS2;


CREATE TABLE CLIENTE
( 
	idcliente            int IDENTITY ( 1,1 ) ,
	tipodoc              int  NOT NULL ,
	documento            varchar(15)  NOT NULL ,
	nombre               varchar(150)  NULL ,
	direccion            varchar(150)  NOT NULL ,
	CONSTRAINT XPKCLIENTE PRIMARY KEY (idcliente ASC)
)
go

SET IDENTITY_INSERT dbo.cliente ON;  
GO  
  
INSERT INTO cliente(tipodoc,documento,nombre,direccion) 
VALUES(1,'89324567','Carlos Ramos','Lima');

INSERT INTO cliente(tipodoc,documento,nombre,direccion) 
VALUES(2,'20694586321','Alfa','Lima');

INSERT INTO cliente(tipodoc,documento,nombre,direccion) 
VALUES(1,'45362158','Alejandra Carrasco','Callao');

INSERT INTO cliente(tipodoc,documento,nombre,direccion) 
VALUES(2,'2069453265','Delia Garcia','Callao');
GO

CREATE TABLE CATEGORIA
( 
	idcat                int  NOT NULL ,
	nombre               VARCHAR(50)  NOT NULL ,
	CONSTRAINT XPKCATEGORIA PRIMARY KEY (idcat ASC)
)
go

INSERT INTO CATEGORIA (idcat, nombre)VALUES(1, 'Impresoras');
INSERT INTO CATEGORIA(idcat, nombre)VALUES(2, 'Computadoras');
INSERT INTO CATEGORIA(idcat, nombre) VALUES(3, 'Zona Gamer');
INSERT INTO CATEGORIA(idcat, nombre)VALUES(4, 'Partes de PC');
INSERT INTO CATEGORIA(idcat, nombre)VALUES(5, 'Monitores');
INSERT INTO CATEGORIA(idcat, nombre)VALUES(6, 'Accesorios');
INSERT INTO CATEGORIA(idcat, nombre)VALUES(7, 'Licencias Originales');
INSERT INTO CATEGORIA(idcat, nombre)VALUES(8, 'Routers');
INSERT INTO CATEGORIA(idcat, nombre)VALUES(9, 'Tablets');


CREATE TABLE PRODUCTO
( 
	idprod               int IDENTITY ,
	idcat                int  NOT NULL ,
	nombre               VARCHAR(100)  NOT NULL ,
	precio               NUMERIC(10,2)  NOT NULL ,
	stock                int  NOT NULL ,
	CONSTRAINT XPKPRODUCTO PRIMARY KEY (idprod ASC),
	CONSTRAINT FK_PRODUCTO_CATEGORIA FOREIGN KEY (idcat) REFERENCES CATEGORIA(idcat)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
)
go

SET IDENTITY_INSERT dbo.PRODUCTO ON;  
GO
-- =============================================
-- CREACION DE TABLAS DEL CATALOGO
-- =============================================
INSERT INTO PRODUCTO (idcat, nombre, precio, stock)
VALUES (1, 'Impresora HP LaserJet Pro M402dw', 799.0, 15);

INSERT INTO PRODUCTO (idcat, nombre, precio, stock)
VALUES (2, 'Laptop Lenovo Ideapad 3', 999.0, 10);

INSERT INTO PRODUCTO (idcat, nombre, precio, stock)
VALUES (3, 'Monitor Gaming ASUS ROG Swift PG279Q', 699.0, 12);

INSERT INTO PRODUCTO (idcat, nombre, precio, stock)
VALUES (4, 'Teclado Mecánico Razer BlackWidow', 149.99, 25);

INSERT INTO PRODUCTO (idcat, nombre, precio, stock)
VALUES (5, 'Tarjeta Gráfica NVIDIA GeForce RTX 3060', 699.0, 12);

INSERT INTO PRODUCTO (idcat, nombre, precio, stock)
VALUES (6, 'Monitor LG 27GL850-B 27 Pulgadas', 449.0, 10);

INSERT INTO PRODUCTO (idcat, nombre, precio, stock)
VALUES (7, 'Licencia Microsoft Office 365 Personal', 69.0, 100);

INSERT INTO PRODUCTO (idcat, nombre, precio, stock)
VALUES (8, 'Router ASUS RT-AC86U', 179.0, 25);

INSERT INTO PRODUCTO (idcat, nombre, precio, stock)
VALUES (9, 'iPad Air (2020)', 499.0, 20);



CREATE TABLE TIPO_PAGO
( 
	idtipopago           int  NOT NULL ,
	nombre               VARCHAR(50)  NOT NULL ,
	CONSTRAINT XPKTIPO_PAGO PRIMARY KEY (idtipopago ASC)
)
go

INSERT INTO TIPO_PAGO(idtipopago,nombre) VALUES(1,'EFECTIVO');
INSERT INTO TIPO_PAGO(idtipopago,nombre) VALUES(2,'TRANSFERENCIA');
INSERT INTO TIPO_PAGO(idtipopago,nombre) VALUES(3,'BANCA MOVIL');

CREATE TABLE TIPO_COMP
( 
	idtipocomp           int  NOT NULL ,
	nombre               varchar(20)  NOT NULL ,
	serie                varchar(3)  NOT NULL ,
	contador             int  NOT NULL ,
	porcentaje           numeric(5,2)  NOT NULL ,
	CONSTRAINT XPKTIPO_COMP PRIMARY KEY (idtipocomp ASC)
)
go

-- Inserción de ejemplo 1
INSERT INTO TIPO_COMP (idtipocomp, nombre, serie, contador, porcentaje)
VALUES (1, 'Boleta', 'B01', 1000, 0.00);

-- Inserción de ejemplo 2
INSERT INTO TIPO_COMP (idtipocomp, nombre, serie, contador, porcentaje)
VALUES (2, 'Factura', 'F01', 500, 18.00);

CREATE TABLE VENTA
( 
	idventa              int IDENTITY ,
	idcliente            int  NOT NULL ,
	documento            varchar(11),
	fecha                date  NOT NULL ,
	fecha_pago                date  NOT NULL ,
	importe              numeric(10,2)  NOT NULL ,
	idtipopago           int  NOT NULL ,
	idtipocomp           int  NOT NULL ,
	tipoEnvio            varchar(15) CHECK (tipoEnvio IN ('En tienda', 'Envio')) NOT NULL ,
	serie               varchar(20)  NULL ,
	descuento            numeric(10,2)  NOT NULL ,
	impuesto             numeric(10,2)  NOT NULL ,
	total                numeric(10,2)  NOT NULL ,
	CONSTRAINT XPKVENTA PRIMARY KEY (idventa ASC),
	CONSTRAINT FK_VENTA_CLIENTE FOREIGN KEY (idcliente) REFERENCES CLIENTE(idcliente)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
CONSTRAINT FK_VENTA_TIPO_PAGO FOREIGN KEY (idtipopago) REFERENCES TIPO_PAGO(idtipopago)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
CONSTRAINT FK_VENTA_TIPO_COMP FOREIGN KEY (idtipocomp) REFERENCES TIPO_COMP(idtipocomp)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
)
GO

CREATE TABLE DETALLE
( 
	iddetalle            int IDENTITY ,
	idventa              int  NOT NULL ,
	idprod               int  NOT NULL ,
	cant                 NUMERIC  NOT NULL ,
	precio               NUMERIC(10,2)  NOT NULL ,
	subtotal             NUMERIC(10,2)  NULL ,
	CONSTRAINT XPKDETALLE PRIMARY KEY (iddetalle ASC),
	CONSTRAINT FK_DETALLE_PRODUCTO FOREIGN KEY (idprod) REFERENCES PRODUCTO(idprod)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
CONSTRAINT FK_DETALLE_VENTA FOREIGN KEY (idventa) REFERENCES VENTA(idventa)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
)
GO


-- =============================================
-- Seleccionar la Base de Datos
-- =============================================

USE VENTAS2;


-- =============================================
-- DATOS D LA TABLA CLIENTE
-- =============================================











GO

SET IDENTITY_INSERT dbo.PRODUCTO OFF;  
GO







-- =============================================
-- CREACION DE TABLAS DE VENTAS
-- =============================================



CREATE UNIQUE INDEX U_DETALLE ON DETALLE
( 
	idventa               ASC,
	idprod                ASC
);
go




-- =============================================
-- CREACION DE TABLAS DE PAGOS
-- =============================================

CREATE TABLE TIPO_PAGO
( 
	idtipo               int ,
	nombre               VARCHAR(50)  NOT NULL ,
	CONSTRAINT XPKTIPO_PAGO PRIMARY KEY (idtipo ASC)
);
GO

GO

SELECT * FROM CLIENTE;
SELECT * FROM PRODUCTO;
SELECT * FROM CATEGORIA;
SELECT * FROM TIPO_COMP;
SELECT * FROM TIPO_PAGO;
SELECT * FROM VENTA;
SELECT * FROM DETALLE;

DROP TABLE VENTA;

-- Inserción de ejemplo 3
INSERT INTO TIPO_COMP (idtipocomp, nombre, serie, contador, porcentaje)
VALUES (3, 'Ticket', 'T01', 200, 0.00);

insert into venta(idcliente, documento, fecha, fecha_pago, importe, idtipopago, idtipocomp, tipoEnvio, descuento, impuesto, total) values(1, '78965412','2024-07-11', '2024-07-14', 800.00, 2, 2, 'En tienda', 0.00, 0.00, 0.00);

SELECT stock FROM PRODUCTO WHERE idprod = 1;

--------------------------------------------------------------------------------
CREATE OR ALTER TRIGGER trg_GENERAR_NUMERO_VENTA
ON VENTA
AFTER INSERT
AS
BEGIN
    DECLARE @idventa int, @idtipocomp int, @serie varchar(20), @impuesto numeric(10,2), @importe numeric(10,2), @descuento numeric(10,2), @total numeric(10,2);

    -- Obtener el último idventa insertado y otros valores relevantes
    SELECT @idventa = idventa,
           @idtipocomp = idtipocomp,
           @importe = importe
    FROM inserted;

    -- Asignar el impuesto según idtipocomp
    IF @idtipocomp = 1
        SET @impuesto = 0.00;
    ELSE IF @idtipocomp = 2
        SET @impuesto = 0.18;

    -- Calcular el descuento según el importe
    IF @importe >= 1000
        SET @descuento = 0.10;  -- 10% de descuento si el importe es mayor o igual a 1000
    ELSE IF @importe >= 700
        SET @descuento = 0.05;  -- 5% de descuento si el importe es mayor o igual a 700 pero menor a 1000
    ELSE
        SET @descuento = 0.00;  -- Sin descuento si el importe es menor a 700

    -- Calcular el total incluyendo descuento e impuesto
    SET @total = @importe - (@importe * @descuento) + (@importe * @impuesto);

    -- Generar el número de serie basado en idtipocomp
    IF @idtipocomp = 1
        SET @serie = 'B01-' + RIGHT('00000' + CAST(@idventa AS varchar(5)), 5);
    ELSE IF @idtipocomp = 2
        SET @serie = 'F01-' + RIGHT('00000' + CAST(@idventa AS varchar(5)), 5);
    
    -- Actualizar el número generado, el impuesto, el descuento y el total en la tabla VENTA
    UPDATE VENTA
    SET serie = @serie,
        impuesto = @impuesto,
        descuento = @descuento,
        total = @total
    WHERE idventa = @idventa;
END;

DROP TRIGGER trg_GENERAR_NUMERO_VENTA;



CREATE TABLE PAGO
( 
	idpago               int IDENTITY ,
	idventa              int  NOT NULL ,
	idtipopago               int  NOT NULL ,
	detalle              VARCHAR(100)  NOT NULL ,
	importe              NUMERIC(10,2)  NOT NULL ,
	obs                  VARCHAR(1000)  NOT NULL ,
	CONSTRAINT XPKPAGO PRIMARY KEY (idpago ASC),
	CONSTRAINT FK_PAGO_VENTA FOREIGN KEY (idventa) REFERENCES VENTA(idventa),
	CONSTRAINT FK_PAGO_TIPO_PAGO FOREIGN KEY (idtipopago) REFERENCES TIPO_PAGO(idtipopago)
);
go


CREATE UNIQUE INDEX U_PAGO_UNIQUE ON PAGO
( 
	idventa               ASC,
	idtipopago                ASC
);
go