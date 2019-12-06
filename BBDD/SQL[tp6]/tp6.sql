/*
=============================================================================================================================
1. Crear una tabla empleado con los siguientes atributos:
	dni integer, apellido text, nombre text, salario integer default 15000, jefe integer)
	En la presente tabla algunos empleados tendrán o no un jefe definido en el atributo jefe, para hacer
	cumplir esta restricción se debe crear una foreign key que referencia al atributo dni de la misma tabla.
=============================================================================================================================
*/

/*
CREATE TABLE empleado(
	dni int NOT NULL,
	apellido varchar(40),
	nombre varchar(40),
	salario int DEFAULT(15000),
	jefe int,
	CONSTRAINT PK_empleado PRIMARY KEY (dni),
	CONSTRAINT FK_empleado FOREIGN KEY (jefe) REFERENCES empleado(dni) ON DELETE cascade ON UPDATE cascade
)
*/


/*
=============================================================================================================================
2. Crear los siguientes Triggers:
	a. Crear un trigger para que una persona no pueda tener más de 3 empleados a cargo.
	b. Crear un Trigger para que un empleado no gane más que su jefe.
	c. Crear un Trigger para que no se puede aumentar más del 15% del salario de ningún empleado.
=============================================================================================================================
*/

/*
CREATE OR REPLACE FUNCTION noMasDeTresSubordinados() RETURNS TRIGGER AS $funcemp$
DECLARE 
	cantidad_subordinados smallint;
BEGIN
	cantidad_subordinados := (SELECT COUNT(*) FROM empleado e WHERE e.jefe=NEW.jefe);
	IF (cantidad_subordinados = 3) THEN
		RAISE EXCEPTION 'Error, el empleado no puede tener mas de 3 personas a cargo.';
	END IF;
	RETURN NEW;
END; $funcemp$ LANGUAGE plpgsql;
*/

-- CREATE TRIGGER controlarCantidadSubordinados BEFORE INSERT OR UPDATE ON empleado FOR EACH ROW EXECUTE PROCEDURE noMasDeTresSubordinados();

/*
CREATE OR REPLACE FUNCTION noGaneMasQueSuJefe() RETURNS TRIGGER AS $funcemp$
DECLARE 
	sueldo_jefe int;
BEGIN
	sueldo_jefe := (SELECT e.salario FROM empleado e WHERE e.dni=NEW.jefe);
	IF (NEW.salario > sueldo_jefe) THEN
		RAISE EXCEPTION 'Error, el empleado no puede tener un salario mayor al de su jefe.';
	END IF;
	RETURN NEW;
END; $funcemp$ LANGUAGE plpgsql;

CREATE TRIGGER controlarSalario BEFORE INSERT OR UPDATE ON empleado FOR EACH ROW EXECUTE PROCEDURE noGaneMasQueSuJefe();
*/

/*
CREATE OR REPLACE FUNCTION aumentosNoMayoresAlQuincePorciento() RETURNS TRIGGER AS $funcemp$
DECLARE 
	salario_maximo int;
BEGIN
	salario_maximo := (SELECT (e.salario + (e.salario * 0.15)) FROM empleado e WHERE e.dni=NEW.dni);
	IF (NEW.salario > salario_maximo) THEN
		RAISE EXCEPTION 'Error, no se puede aumentar más del 15 porciento del salario de ningún empleado.';
	END IF;
	RETURN NEW;
END; $funcemp$ LANGUAGE plpgsql;

CREATE TRIGGER controlarAumentos BEFORE UPDATE ON empleado FOR EACH ROW EXECUTE PROCEDURE aumentosNoMayoresAlQuincePorciento();
*/


/*
=============================================================================================================================
--3. Crear ahora una tabla departamento con los siguientes datos:
		(id serial, nombre text, jefe integer)
	a. Cumplir las siguientes restricciones:
		Clave primaria id, nombre no acepta nulos y el nombre es único, jefe clave foránea de la tabla empleado.
	b. Crear los siguientes Trigger:
		i. Ningún empleado debe pertenecer a un departamento distinto de su jefe.
		ii. Crear una tabla bajaempleado que inserte los datos de los empleados que se dan de baja con los datos
			de la tabla empleado: (dni, apellido, nombre) agregarle fechabaja
=============================================================================================================================
*/

/*
CREATE TABLE departamento (
	id serial,
	nombre varchar(60) NOT NULL UNIQUE,
	jefe int,
	CONSTRAINT PK_departamento PRIMARY KEY (id)
)
*/

/*
CREATE TABLE trabajapara (
	dni int,
	id_departamento int,
	CONSTRAINT PK_trabajapara PRIMARY KEY (dni, id_departamento),
	CONSTRAINT FK_empleado FOREIGN KEY (dni) REFERENCES empleado,
	CONSTRAINT FK_departamento FOREIGN KEY (id_departamento) REFERENCES departamento
)
*/

/*
CREATE OR REPLACE FUNCTION perteneceAlDepartamentoDeSuJefe() RETURNS TRIGGER AS $funcemp$
DECLARE 
	departamento_jefe int;
BEGIN
	departamento_jefe := (SELECT DISTINCT d.id FROM empleado e, departamento d, trabajapara t WHERE NEW.dni=e.dni AND e.jefe=d.jefe);
	IF (NEW.id_departamento != departamento_jefe) THEN
		RAISE EXCEPTION 'Error, ningún empleado debe pertenecer a un departamento distinto de su jefe.';
	END IF;
	RETURN NEW;
END; $funcemp$ LANGUAGE plpgsql;

CREATE TRIGGER controlarDepartamentoDeTrabajo BEFORE INSERT OR UPDATE ON trabajapara FOR EACH ROW EXECUTE PROCEDURE perteneceAlDepartamentoDeSuJefe();
*/

/*
CREATE TABLE bajaempleado (
	dni int,
	apellido varchar(40),
	nombre varchar(40),
	fecha_baja timestamp
)
*/

/*
CREATE OR REPLACE FUNCTION auditarBajaEmpleado() RETURNS TRIGGER AS $funcemp$
DECLARE
BEGIN
	if (TG_OP = 'DELETE') THEN
		INSERT INTO bajaempleado(dni, apellido, nombre, fecha_baja) 
			VALUES(OLD.dni, OLD.apellido, OLD.nombre, clock_timestamp());
	END IF;
	RETURN NEW;
END; $funcemp$ LANGUAGE plpgsql;

CREATE TRIGGER auditarBajasDeEmpleados AFTER DELETE ON empleado FOR EACH ROW EXECUTE PROCEDURE auditarBajaEmpleado();
*/


/*
=============================================================================================================================
INSERTS Correctos en la relacion empleado
=============================================================================================================================
*/

/*
INSERT INTO empleado (dni, apellido, nombre, salario) VALUES 
	(25100000,'PEREZ','PABLO',18000),
    (29332501,'SLOTOWIAZDA','MARIA',35000),
    (19302500,'TENEMBAUN','ENRNESTO',22500),
    (22958543,'DIAZ','XIMENA',48000),
    (35254310,'PEREZ LINDO','MATIAS',29000),
    (33387695,'RICCA','JAVIER',29700),
    (25321542,'SIGNORINI','ESTELA',45000),
    (27123456,'REZONICO','CONSTANZA',31000),
	(36318737,'PAULETTI','JOAQUIN',35000),
    (13334401,'RETAMAR','JOAQUIN',35000),
	(33333333,'FIOROVIC,'GONZALO',15000)
	
	
INSERT INTO empleado (dni, apellido, nombre) VALUES(33001321,'RINEIRI','EVANGELINA');
*/

/*
=============================================================================================================================
INSERTS Correctos en la relacion departamento 
=============================================================================================================================
*/

/*
INSERT INTO departamento (nombre, jefe) VALUES
	('TESTING', 35254310), --PEREZ LINDO
    ('DESARROLLO', 29332501), --SLOTOWIAZDA
    ('EXPERIENCIA DE USUARIO', 19302500), --TENEMBAUN
    ('SOPORTE', 22958543) --DIAZ
*/

/*
=============================================================================================================================
INSERTS Correctos en la relacion trabajapara 
=============================================================================================================================
*/

/*
INSERT INTO trabajapara (dni, id_departamento) VALUES
	(25100000,1), PEREZ PABLO TRABAJAPARA EL DEPARTAMENTO TESTING
    (33387695,2), RICA JAVIER TRABAJAPARA EL DEPARTAMENTO DESARROLLO
    (25321542,3), SIGNORINI ESTELA TRABAJAPARA EL DEPARTAMENTO EXPERIENCIA DE USUARIO
    (13334401,1), RETAMAR JOAQUIN TRABAJAPARA EL DEPARTAMENTO TESTING
	(33001321,1)  RINEIRI EVANGELINA TRABAJA PARA TESTING
	
*/

/*
=============================================================================================================================
Una persona no puede tener más de 3 empleados a cargo.
=============================================================================================================================
*/

--UPDATE empleado SET jefe=35254310 WHERE empleado.dni=25100000 --PEREZ LINDO JEFE DE PEREZ PABLO
--UPDATE empleado SET jefe=35254310 WHERE empleado.dni=33001321 --PEREZ LINDO JEFE DE RICCA
--UPDATE empleado SET jefe=35254310 WHERE empleado.dni=38868133 --PEREZ LINDO JEFE DE PAULETTI
--UPDATE empleado SET jefe=29332501 WHERE empleado.dni=27123456 --SLOTOWIAZDA JEFE DE REZONICO

--INSERT INTO empleado (dni, apellido, nombre, salario, jefe) VALUES(22222222, 'ALVEAR', 'FEDERICO', 100000, 35254310) --PEREZ LINDO JEFE DE FEDERICO ALVEAR ¡¡¡ERROR!!!
--UPDATE empleado SET jefe=35254310 WHERE empleado.dni=13334401 --PEREZ LINDO JEFE DE RETAMAR ¡¡¡ERROR!!!

/*
=============================================================================================================================
Un empleado no gane más que su jefe.
=============================================================================================================================
*/

--INSERT INTO empleado (dni, apellido, nombre, salario, jefe) VALUES(22222222, 'ALVEAR', 'FEDERICO', 100000, 19302500) --FEDERICO ALVEAR EMPLEADO DE TENEMBAUN ¡¡¡Error!!!
--UPDATE empleado SET salario=70000 WHERE empleado.dni=38868133 --JOAQUIN PAULETTI ¡¡¡ERROR!!!

/*
=============================================================================================================================
No se puede aumentar más del 15% del salario de ningún empleado.
=============================================================================================================================
*/

--UPDATE empleado SET salario=90000 WHERE empleado.dni=38868133 -- PAULETTI JOAQUIN ¡¡¡ERROR!!!

/*
=============================================================================================================================
Ningún empleado debe pertenecer a un departamento distinto del de su jefe.
=============================================================================================================================
*/

--INSERT INTO trabajapara (dni, id_departamento) VALUES(27123456, 3) --SLOTOWIAZDA JEFE DE REZONICO TRABAJA PARA EXPERIENCIA DE USUARIO ¡¡¡Error!!!
--UPDATE trabajapara SET id_departamento=2 WHERE dni=33001321 --PEREZ LINDO JEFE DE RINEIRI EVANGELINA TRABAJA PARA TESTING ¡¡¡Error!!!

/*
=============================================================================================================================
Inserciones automaticas al realizar Bajas de empleados.
=============================================================================================================================
*/

--DELETE FROM empleado WHERE dni=33333333


