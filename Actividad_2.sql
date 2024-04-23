/* crear la base de datos db_SalesClothes*/
CREATE DATABASE db_SalesClothes;
/*Poner en uso la base de datos db_SalesClothes*/
USE db_SalesClothes;
/*Configurar idioma español en el servidor*/
SET LANGUAGE Español
GO
SELECT @@language AS 'Idioma'
GO

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

/* Insertar 6 registros */
INSERT INTO client 
(type_document, number_document, names, last_name, email, cell_phone, birthdate)
VALUES
('DNI', '78451233', 'Fabiola', 'Perales Campos', 'fabiolaperales@gmail.com', '991692597', '19/01/2005'),
('DNI', '14782536', 'Marcos', 'Dávila Palomino', 'marcosdavila@gmail.com', '982514752', '03/03/1990'),
('DNI', '78451236', 'Luis Alberto', 'Barrios Paredes', 'luisbarrios@outlook.com', '985414752', '03/10/1995'),
('CNE', '352514789', 'Claudia María', 'Martínez Rodríguez', 'claudiamartinez@yahoo.com', '995522147', '23/09/1992'),
('CNE', '142536792', 'Mario Tadeo', 'Farfán Castillo', 'mariotadeo@outlook.com', '973125478', '25/11/1997'),
('DNI', '58251433', 'Ana Lucrecia', 'Chumpitaz Prada', 'anachumpitaz@gmail.com', '982514361', '17/10/1992');



/* Listar apellidos, nombres, celular y fecha de nacimiento */
SELECT
	last_name as 'APELLIDOS',
	names as 'NOMBRES',
	cell_phone as 'CELULAR',
	format(birthdate, 'd', 'es-ES') as 'FEC. NACIMIENTO'
FROM
	client;

/* Listar apellidos, nombres, email y celular de clientes que tienen DNI y su respectivo número*/
SELECT
	last_name as 'APELLIDOS',
	names as 'NOMBRE',
	email as 'EMAIL',
	type_document as 'DOCUMENTO',
	number_document as '# DOC.'
FROM
	client
WHERE
	type_document = 'DNI';

/* Listar apellidos, nombres, edad, email y fecha de cumpleaños */
SELECT
	id as 'ITEM',
	CONCAT(UPPER(last_name), ',', names) as 'CLIENTE',
	(YEAR(GETDATE()) - YEAR(birthdate)) as 'EDAD',
	email as 'EMAIL',
	FORMAT(birthdate, 'dd-MMM', 'es-ES') as 'CUMPLEAÑOS'
FROM
	client;


/* Eliminar lógicamente el cliente cuyo DNI es 58251433  */
UPDATE client
SET active = '0' 
WHERE number_document = '58251433'
GO

/* Listar clientes */
SELECT * FROM client;

/* La fecha de nacimiento de Marcos Dávila Palomino es el 16/06/1989 */
UPDATE client 
SET birthdate = '16/06/1989'
WHERE names = 'Marcos' and last_name = 'Dávila Palomino';

/* Listar los nuevos datos de Marcos Dávila Palomino */
SELECT * FROM client 
WHERE names = 'Marcos' AND last_name = 'Dávila Palomino';

/* El nuevo número de celular del cliente de CNE # 142536792 es 977815352 */
UPDATE client
SET cell_phone = '977815352'
WHERE type_document = 'CNE' AND number_document = '142536792';

/* Verificar que el cambio de celular se ha realizado */
SELECT 
       * 
FROM CLIENT
WHERE cell_phone = '977815352';

/* Eliminar físicamente los clientes nacidos en el año 1992 */
 DELETE FROM client 
 WHERE YEAR (birthdate) = '1992';

/* Listar clientes y verificar */
 SELECT * FROM client;

/* Eliminar cliente de número de celular 991692597 */
DELETE FROM client
WHERE cell_phone = '991692597';

/* Verificar la eliminación listando los registros */
SELECT * FROM client;

/* Eliminar los registros de la tabla cliente */
DELETE FROM client;

/* Listar los registros de la tabla cliente */
SELECT * FROM client;


SELECT @@LANGUAGE AS 'LANGUAJE';

CREATE DATABASE dbSalesClothes;

USE dbSalesClothes;

INSERT INTO client 
(type_document, number_document, names, last_name, email, cell_phone, birthdate)
VALUES
('DNI', '78451233', 'Fabiola', 'Perales Campos', 'fabiolaperales@gmail.com', '991692597', '19/01/2005'),
('DNI', '14782536', 'Marcos', 'Dávila Palomino', 'marcosdavila@gmail.com', '982514752', '03/03/1990'),
('DNI', '78451236', 'Luis Alberto', 'Barrios Paredes', 'luisbarrios@outlook.com', '985414752', '03/10/1995'),
('CNE', '352514789', 'Claudia María', 'Martínez Rodríguez', 'claudiamartinez@yahoo.com', '995522147', '23/09/1992'),
('CNE', '142536792', 'Mario Tadeo', 'Farfán Castillo', 'mariotadeo@outlook.com', '973125478', '25/11/1997'),
('DNI', '58251433', 'Ana Lucrecia', 'Chumpitaz Prada', 'anachumpitaz@gmail.com', '982514361', '17/10/1992'),
('DNI', '58251433', 'Humberto', 'Cabrera Tadeo', 'humbertocabrera@gmail.com', '977112234', '27/05/1990'),
('CNE', '58251433', 'Rosario', 'Prada Velásquez', 'rosarioprada@outlook.com', '971144782', '05/11/1990');


INSERT INTO seller
(type_document, number_document, names, last_name,salary,cell_phone,email)
VALUES
('DNI', '11224578', 'Oscar', 'Paredes Flores', 1025.00,'985566251','oparedes@miempresa.com'),
('CNE', '889922365', 'Azucena', 'Valle Alcazar', 1025.00,'966338874','avalle@miempresa.com'), 
('DNI','44771123', 'Rosario', 'Huarca Tarazona', 1025.00, '933665521', 'rhuaraca@miempresa.com');

INSERT INTO clothes
(description, brand, amount, size, price) 
VALUES 
('Polo Camisero', 'Adidas', 20, 'Medium', 40.50),
('Camisa playero', 'Nike', 30, 'Medium', 55.50),
('Camisa Sport', 'Adams', 60, 'Large', 60.80),
('Camisa Sport', 'Adams', 70, 'Medium', 58.75),
('buzo de verano', 'Reebok', 45, 'Small', 62.90),
('Pantalón Jean', 'Lewis', 35, 'Large', 73.60);

-- Listar todos los datos de los clientes (client) cuyo tipo de documento sea DNI:
SELECT *
FROM client
WHERE type_document = 'DNI';

--Listar todos los datos de los clientes (client) cuyo servidor de correo electrónico sea outlook.com:
SELECT *
FROM client
WHERE email LIKE '%@outlook.com';

--Listar todos los datos de los vendedores (seller) cuyo tipo de documento sea CNE:
SELECT *
FROM seller
WHERE type_document = 'CNE';

-- Listar todas las prendas de ropa (clothes) cuyo costo sea menor e igual que S/. 55.00:
SELECT *
FROM clothes
WHERE price <= 55.00;

-- Listar todas las prendas de ropa (clothes) cuya marca sea Adams:
SELECT *
FROM clothes
WHERE brand = 'Adams';

-- Eliminar lógicamente los datos de un cliente client de acuerdo a un determinado id:
UPDATE client
SET active = 0
WHERE id = 2;

-- Eliminar lógicamente los datos de un cliente seller de acuerdo a un determinado id:
UPDATE seller
SET active = 1
WHERE id = 1;

-- Eliminar lógicamente los datos de un cliente clothes de acuerdo a un determinado id:

UPDATE clothes
SET active = 1
WHERE id = 3;