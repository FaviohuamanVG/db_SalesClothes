/* crear la base de datos db_SalesClothes*/
CREATE DATABASE db_SalesClothes;
/*Poner en uso la base de datos db_SalesClothes*/
USE db_SalesClothes;
/*Configurar idioma español en el servidor*/
SET LANGUAGE Español
GO
SELECT @@language AS 'Idioma'
GO


/* Crear la tabla client */
CREATE TABLE client
(
    id INT PRIMARY KEY IDENTITY(1,1), 
    type_document CHAR(3) CHECK (type_document IN ('DNI', 'CNE')),
    number_document CHAR(9),
    names VARCHAR(60),
    last_name VARCHAR(90),
    email VARCHAR(80) CHECK (email LIKE '%_@__%.__%'),
    cell_phone CHAR(9),
    birthdate DATE CHECK (DATEDIFF(YEAR, birthdate, GETDATE()) >= 18),
    active BIT DEFAULT 1
);

ALTER TABLE client
    ADD CONSTRAINT CK_number_document CHECK 
    (
        (type_document = 'DNI' AND LEN(number_document) = 8 AND ISNUMERIC(number_document) = 1) OR
        (type_document = 'CNE' AND LEN(number_document) = 9 AND ISNUMERIC(number_document) = 1)
    );

GO

/* Crear la tabla seller */
CREATE TABLE seller
(
    id INT PRIMARY KEY IDENTITY(1,1), 
    type_document CHAR(3) CHECK (type_document IN ('DNI', 'CNE')),
    number_document CHAR(15),
    names VARCHAR(60),
    last_names VARCHAR(90),
    email VARCHAR(80) CHECK (email LIKE '%_@__%.__%'),
    cell_phone CHAR(9),
    birthdate DATE CHECK (DATEDIFF(YEAR, birthdate, GETDATE()) >= 18),
    active BIT DEFAULT 1,
    salary DECIMAL(10, 2) DEFAULT 1025
);

ALTER TABLE seller
    ADD CONSTRAINT CK_number_document CHECK 
    (
        (type_document = 'DNI' AND LEN(number_document) = 8 AND ISNUMERIC(number_document) = 1) OR
        (type_document = 'CNE' AND LEN(number_document) = 9 AND ISNUMERIC(number_document) = 1)
    );

GO


/* Crear la tabla clothes */
CREATE TABLE clothes
(
    id INT PRIMARY KEY IDENTITY(1,1), 
    description VARCHAR(60),
    brand VARCHAR(60),
    amount INT,
    size VARCHAR(10),
    price DECIMAL(8,2),
    active BIT DEFAULT 1
);

/* Crear la tabla sale */
CREATE TABLE sale
(
    id INT PRIMARY KEY IDENTITY(1,1), 
    client_id INT,
    date_time DATETIME DEFAULT GETDATE(),
    active BIT DEFAULT 1
);

/* Relacionar tabla sale con tabla client */
ALTER TABLE sale
	ADD CONSTRAINT sale_client FOREIGN KEY (client_id)
	REFERENCES client (id)
	ON UPDATE CASCADE 
      ON DELETE CASCADE
GO

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

