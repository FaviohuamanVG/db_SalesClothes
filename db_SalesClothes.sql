USE db_SalesClothes;

/* Crear tabla client */
CREATE TABLE client
(
	id int, 
	type_document char(3),
	number_document char(15),
	names varchar(60),
	last_name varchar(90),
	email varchar(80),
	cell_phone char(9),
	birthdate date,
	active bit
	CONSTRAINT client_pk PRIMARY KEY (id)
);


/* Ver estructura de tabla client */
EXEC sp_columns @table_name = 'client';


/* Listar tablas de la base de datos db_SalesClothes */
SELECT * FROM INFORMATION_SCHEMA.TABLES;

/* Eliminar tabla client */
DROP TABLE client;

/* Crear tabla sale */
CREATE TABLE sale
(
    id int,
    client_id int,
    date_time DATETIME,
    active bit,
    CONSTRAINT sale_pk PRIMARY KEY  (id)
);

/* Relacionar tabla sale con tabla client */
ALTER TABLE sale
	ADD CONSTRAINT sale_client FOREIGN KEY (client_id)
	REFERENCES client (id)
	ON UPDATE CASCADE 
      ON DELETE CASCADE
GO

/* Ver relaciones creadas entre las tablas de la base de datos */
SELECT 
    fk.name [Constraint],
    OBJECT_NAME(fk.parent_object_id) [Tabla],
    COL_NAME(fc.parent_object_id,fc.parent_column_id) [Columna FK],
    OBJECT_NAME (fk.referenced_object_id) AS [Tabla base],
    COL_NAME(fc.referenced_object_id, fc.referenced_column_id) AS [Columna PK]
FROM 
    sys.foreign_keys fk
    INNER JOIN sys.foreign_key_columns fc ON (fk.OBJECT_ID = fc.constraint_object_id)
GO

/* Eliminar una relación */
ALTER TABLE sale
	DROP CONSTRAINT sale_client
GO

/* Ver relaciones creadas entre las tablas de la base de datos */
SELECT 
    fk.name [Constraint],
    OBJECT_NAME(fk.parent_object_id) [Tabla],
    COL_NAME(fc.parent_object_id,fc.parent_column_id) [Columna FK],
    OBJECT_NAME (fk.referenced_object_id) AS [Tabla base],
    COL_NAME(fc.referenced_object_id, fc.referenced_column_id) AS [Columna PK]
FROM 
    sys.foreign_keys fk
    INNER JOIN sys.foreign_key_columns fc ON (fk.OBJECT_ID = fc.constraint_object_id)
GO

/* Crear tabla sale_detail */
CREATE TABLE sale_datail
(
    id int,
    sale_id int,
    clothes_id int,
    amounts int,
    CONSTRAINT sale_datail_pk PRIMARY KEY  (id)
);

/* Crear tabla seller */
CREATE TABLE seller
(
    id int,
    type_document char(3),
    nmber_document char(15),
    names varchar(60),
    last_names varchar(90),
    email Varchar(80),
    cell_phone Char(9),
    birthdate Date,
    active bit,
    CONSTRAINT seller_pk PRIMARY KEY  (id)
);

/* Crear tabla clothes */
CREATE TABLE clothes
(
    id int,
    description Varchar(60),
    brand Varchar(60),
    amount int,
    size Varchar(10),
    price decimal(8,2),
    active bit,
    CONSTRAINT clothes_pk PRIMARY KEY  (id)
);

ALTER TABLE sale
	ADD CONSTRAINT sale_seller FOREIGN KEY (id)
	REFERENCES seller (id)
	ON UPDATE CASCADE 
      ON DELETE CASCADE
GO

ALTER TABLE sale_datail
	ADD CONSTRAINT sale_detail_clothes FOREIGN KEY (id)
	REFERENCES clothes (id)
	ON UPDATE CASCADE 
      ON DELETE CASCADE
GO

ALTER TABLE sale_datail
	ADD CONSTRAINT sale_datail_sale FOREIGN KEY (id)
	REFERENCES sale (id)
	ON UPDATE CASCADE 
      ON DELETE CASCADE
GO


/* Ver SQL Collate en SQL Server */
SELECT SERVERPROPERTY('collation') AS ServerCollation
GO

/* Ver idioma de SQL Server */
SELECT @@language AS 'Idioma'
GO

/* Ver idiomas disponibles en SQL Server */
EXEC sp_helplanguage
GO

/* Configurar idioma español en el servidor */
SET LANGUAGE Español
GO
SELECT @@language AS 'Idioma'
GO

/* Ver formato de fecha y hora del servidor */
SELECT sysdatetime() as 'Fecha y  hora'
GO

/* Configurar el formato de fecha */
SET DATEFORMAT dmy
GO

/* Listar tablas de la base de datos db_SalesClothes */
SELECT * FROM INFORMATION_SCHEMA.TABLES
GO

/* Ver estructura de una tabla */
EXEC sp_help 'dbo.sale'
GO