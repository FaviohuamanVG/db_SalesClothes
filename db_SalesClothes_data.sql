/* Insertar 6 registros */
INSERT INTO client 
(type_document, number_document, names, last_name, email, cell_phone, birthdate)
VALUES
('DNI', '78451233', 'Fabiola', 'Perales Campos', 'fabiolaperales@gmail.com', '991692597', '19/01/2005'),
('DNI', '14782536', 'Marcos', 'Dávila Palomino', 'marcosdavila@gmail.com', '982514752', '03/03/1990'),
('DNI', '78451236', 'Luis Alberto', 'Barrios Paredes', 'luisbarrios@outlook.com', '985414752', '03/10/1995'),
('CNE', '352514789', 'Claudia María', 'Martínez Rodríguez', 'claudiamartinez@yahoo.com', '995522147', '23/09/1992'),
('CNE', '142536792', 'Mario Tadeo', 'Farfán Castillo', 'mariotadeo@outlook.com', '973125478', '25/11/1997'),
('DNI', '58251433', 'Ana Lucrecia', 'Chumpitaz Prada', 'anachumpitaz@gmail.com', '982514361', '17/10/1992')
GO



/* Listar apellidos, nombres, celular y fecha de nacimiento */
SELECT
	last_name as 'APELLIDOS',
	names as 'NOMBRES',
	cell_phone as 'CELULAR',
	format(birthdate, 'd', 'es-ES') as 'FEC. NACIMIENTO'
FROM
	client
GO

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
	type_document = 'DNI'
GO

/* Listar apellidos, nombres, edad, email y fecha de cumpleaños */
SELECT
	id as 'ITEM',
	CONCAT(UPPER(last_name), ',', names) as 'CLIENTE',
	(YEAR(GETDATE()) - YEAR(birthdate)) as 'EDAD',
	email as 'EMAIL',
	FORMAT(birthdate, 'dd-MMM', 'es-ES') as 'CUMPLEAÑOS'
FROM
	client 
GO

UPDATE (modificar ó actualizar)

/* Eliminar lógicamente el cliente cuyo DNI es 58251433  */
UPDATE client
SET active = '0' 
WHERE number_document = '58251433'
GO

/* Listar clientes */
SELECT * FROM client
GO

/* La fecha de nacimiento de Marcos Dávila Palomino es el 16/06/1989 */
UPDATE client 
SET birthdate = '16/06/1989'
WHERE names = 'Marcos' and last_name = 'Dávila Palomino'
GO

/* Listar los nuevos datos de Marcos Dávila Palomino */
SELECT * FROM client 
WHERE names = 'Marcos' AND last_name = 'Dávila Palomino'
GO

/* El nuevo número de celular del cliente de CNE # 142536792 es 977815352 */
UPDATE client
SET cell_phone = '977815352'
WHERE type_document = 'CNE' AND number_document = '142536792'
GO

/* Verificar que el cambio de celular se ha realizado */
SELECT 
       * 
FROM CLIENT
WHERE cell_phone = '977815352'
GO
DELETE (eliminar registros)

/* Eliminar físicamente los clientes nacidos en el año 1992 */
 DELETE FROM client 
 WHERE YEAR (birthdate) = '1992'
 GO

/* Listar clientes y verificar */
 SELECT * FROM client
 GO

/* Eliminar cliente de número de celular 991692597 */
DELETE FROM client
WHERE cell_phone = '991692597'
GO

/* Verificar la eliminación listando los registros */
SELECT * FROM client
GO

/* Eliminar los registros de la tabla cliente */
DELETE FROM client
GO

/* Listar los registros de la tabla cliente */
SELECT * FROM client
GO