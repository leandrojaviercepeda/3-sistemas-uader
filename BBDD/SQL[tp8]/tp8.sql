/*
=============================================================================================================================
a) Crear dos usuarios: 
	User1 passw 111
	User2 passw 222
=============================================================================================================================
*/

-- CREATE USER user1 PASSWORD '111'
-- CREATE USER user2 PASSWORD '222'

/*
=============================================================================================================================
b) Crear dos tablas: 
	Tabla1 (id, nombre, apellido, sueldo, nrodpto)
	Tabla2 (nrodpto, nombdepto)
=============================================================================================================================
*/

/*
CREATE TABLE tabla2(
	nrodepto serial NOT NULL,
	nomdepto varchar(30),
	CONSTRAINT FK_tabla2 PRIMARY KEY (nrodepto)
)

CREATE TABLE tabla1(
	id serial NOT NULL,
	nombre varchar(30),
	apellido varchar(30),
	sueldo numeric,
	nrodepto int,
	CONSTRAINT PK_tabla1 PRIMARY KEY (id),
	CONSTRAINT FK_tabla2 FOREIGN KEY (nrodepto) REFERENCES tabla2(nrodepto) ON DELETE cascade ON UPDATE cascade
)
*/


/*
=============================================================================================================================
c) Otorgar los siguientes permiso: 
	ALL al usuario root de postgres sobre ambas tablas
	User1 Insert, select sobre tabla1 
	User2 todos los permisos sobre tabla2
=============================================================================================================================
*/

-- GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA PUBLIC TO postgres
-- GRANT INSERT, SELECT ON TABLE tabla1 TO user1
-- GRANT USAGE, SELECT ON SEQUENCE tabla1_id_seq TO user1
-- GRANT ALL PRIVILEGES ON TABLE tabla2 TO user2
-- GRANT ALL PRIVILEGES ON SEQUENCE tabla2_nrodepto_seq TO user2


/*
=============================================================================================================================
d) Insertar datos (3 tuplas) en ambas tablas
=============================================================================================================================
*/

-- INSERT INTO tabla2(nomdepto) VALUES ('Concepcion del Uruguay'), ('Gualeguaychú'), ('Concordia')
-- INSERT INTO tabla1(nombre, apellido, sueldo, nrodepto) VALUES ('Leandro', 'Cepeda', 30000, 1), ('Gonzalo', 'Cepeda', 40000, 2),	('Valentina', 'Cepeda', 50000, 3)

/*
=============================================================================================================================
e) Logearse como User1 y realizar las siguientes operaciones:
	Insert y select en tabla1
	Select en tabla2
	Registrar lo que pasa en el DBMS
=============================================================================================================================
*/

-- INSERT INTO tabla1(nombre, apellido, sueldo, nrodepto) VALUES ('Javier', 'Cepeda', 35000, 1)
-- SELECT * FROM tabla2

/*
=============================================================================================================================
f) Logearse como User2 y realizar las siguientes operaciones
	Update en tabla2
	Select en tabla1
	Registrar lo que pasa en el DBMS
=============================================================================================================================
*/

-- UPDATE tabla2 SET nombdpto='nuevodepartamento3' WHERE nrodpto=1;
--Funciono correctamente

-- SELECT * FROM tabla1
--El user2 no tiene permiso para hacer un select en la tabla1

/*
=============================================================================================================================
g) Modifique los permisos de User2 para que pueda realizar select en tabla1
=============================================================================================================================
*/

-- GRANT SELECT ON tabla1 TO user2

/*
=============================================================================================================================
h) Logearse como User2 y probar realizar Select sobre tabla1
	Registrar lo que pasa en el DBMS
=============================================================================================================================
*/

-- SELECT * FROM tabla1
--Funciono correctamente

/*
=============================================================================================================================
i) Investigue y prueba funciones de criptografía en PostgreSql
=============================================================================================================================
*/

--Pgcrypto es una extensión para encriptar datos en Postgresql, se la agrega de la siguiente forma:

-- CREATE EXTENSION pgcrypto

--Ejemplo de uso:
/*
CREATE TABLE usuario
(
 ID serial NOT NULL,
 usuario character varying(15) NOT NULL,
 clave bytea
);
*/

--Ingresamos datos, utilizando la funcion "encrypt" para realizar la encriptacion, el primer parametro es la clave 
--a encriptar, el segundo es la clave de encriptacion y el tercero el algoritmo utilizado:
-- INSERT INTO usuario (usuario, clave) VALUES ('alex', encrypt('11112222', 'password','3des'));

--Hacemos un select para ver el dato cifrado en la tabla
-- SELECT * FROM usuario;

--Para desencriptar el valor se utiliza la funcion decrypt
-- SELECT usuario, encode(decrypt(clave,'password','3des'::text), 'escape'::text) AS clave FROM usuario

/*
=============================================================================================================================
j) Realizar dos funciones de criptografía:
	Primero elija alguno de los siguientes atributos para realizar criptografía sobre sus valores: nombre, apellido, sueldo.
	Realice la función de criptografía para encriptar los valores del atributo elegido
	Realice la función para desencriptar los valores del mismo atributo
	Probar ambas funciones realizando insert, update y select
	Nota: utilice los criterios de criptografía que crea conveniente.
=============================================================================================================================
*/

/*
CREATE OR REPLACE FUNCTION encriptar(nombre varchar) RETURNS varchar AS $$
DECLARE
	nomb varchar;
	aux integer;
	i integer;
	cadena varchar;
BEGIN
	FOR i IN 1..length(nombre)
	loop
		nomb=(SELECT substring(nombre FROM i for i));
		aux= (SELECT(ascii(nomb)));
		aux= aux+length(nombre);
		cadena= (SELECT(concat(cadena,chr(aux))));
	END loop;
	RETURN cadena;
END; 
$$ LANGUAGE plpgsql;
*/

/*
CREATE OR REPLACE FUNCTION desencriptar(nombre varchar) RETURNS varchar AS $$
DECLARE
	nomb varchar;
	aux integer;
	i integer;
	cadena varchar;
BEGIN
	FOR i IN 1..length(nombre)
	loop
		nomb=(SELECT substring(nombre FROM i for i));
		aux= (SELECT(ascii(nomb)));
		aux= aux-length(nombre);
		cadena= (SELECT(concat(cadena,chr(aux))));
	END loop;
	RETURN cadena;
END; 
$$ LANGUAGE plpgsql;
*/

-- INSERT INTO tabla1(nombre,apellido,sueldo,nrodpto) VALUES((SELECT encriptar('Pedro')),'Gimenez',7000,2);
-- SELECT nombre FROM tabla1 WHERE id=8;
-- SELECT desencriptar(nombre) FROM tabla1 WHERE id=8;

-- UPDATE tabla1 set nombre=encriptar('Alejandro') WHERE id=8;
-- SELECT * FROM tabla1 WHERE id=8;
-- SELECT desencriptar(nombre) FROM tabla1 WHERE id=8;




