
--Ejercicio 3
CREATE TABLE departamento(
	codigo int,
	nombre varchar(20),
	PRIMARY KEY (codigo)
);

--Ejercicio 4
INSERT INTO departamento VALUES(1,'PRODUCCION'),
	(2,'COMPUTOS'),
	(3,'VENTAS'),
	(4,'DEPOSITO');

--Ejercicio 5
DELETE FROM departamento WHERE LIKE(nombre, 'VENTAS');