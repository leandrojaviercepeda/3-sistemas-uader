/*==================== Table ====================*/

CREATE TABLE persona(
	dni integer Primary Key,
	apellido varchar(30),
	nombre varchar(30),
	fecnac date,
	estado_civil varchar(10),
	Constraint check_estado_civil Check (estado_civil in
	('SOLTERO','CASADO','VIUDO','DIVORCIADO'))
);


/*==================== Functions ====================*/

CREATE OR REPLACE FUNCTION apellidoNoNuloYEdadMayorQueDieciocho() RETURNS TRIGGER AS $funcemp$
DECLARE
	edad smallint ;
	estado_civil varchar(10);
BEGIN
	NEW.estado_civil := UPPER(NEW.estado_civil);
	edad := date_part('year',age(NEW.fecnac));
	
	IF NEW.apellido = '' THEN
		RAISE EXCEPTION 'Error, no puede tener apellido vacío';
	END IF;
	
	IF edad <= '18' THEN
		RAISE EXCEPTION 'Error, no puede ser menor de 18 años';
	END IF;
	
	RETURN NEW;
END; $funcemp$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION controlTransisionesEstadoCivil() RETURNS TRIGGER AS $funcemp$
DECLARE
BEGIN
	NEW.estado_civil := UPPER(NEW.estado_civil);
	
	if OLD.estado_civil = 'SOLTERO' AND (NEW.estado_civil = 'VIUDO' or
		NEW.estado_civil='DIVORCIADO') THEN
		RAISE EXCEPTION 'ERROR de transición en estado civil';
	END IF;
	
	if (OLD.estado_civil = 'CASADO' or OLD.estado_civil = 'DIVORCIADO' OR OLD.estado_civil =
		'VIUDO') AND (NEW.estado_civil = 'SOLTERO') THEN
		RAISE EXCEPTION 'ERROR de transición en estado civil';
	END IF;
	
	if OLD.estado_civil = 'DIVORCIADO' AND (NEW.estado_civil = 'VIUDO') THEN
		RAISE EXCEPTION 'ERROR de transición en estado civil';
	END IF;

	if OLD.estado_civil = 'VIUDO' AND (NEW.estado_civil = 'DIVORCIADO') THEN
		RAISE EXCEPTION 'ERROR de transición en estado civil';
	END IF;
	
	RETURN NEW;
END; $funcemp$ LANGUAGE plpgsql;


/*==================== Triggers ====================*/

CREATE TRIGGER trigger_apellido_edad BEFORE INSERT OR UPDATE ON persona
	FOR EACH ROW EXECUTE PROCEDURE apellidoNoNuloYEdadMayorQueDieciocho();

CREATE TRIGGER trigger_estado_civil BEFORE UPDATE ON persona
	FOR EACH ROW EXECUTE PROCEDURE controlTransisionesEstadoCivil();


/*==================== Insetrs ====================*/

INSERT INTO persona(dni, apellido, nombre, fecnac, estado_civil) VALUES
	(13334401,'','JOAQUIN' ,'10/10/1999','CASADO'), -- Dado el apellido vacio, levantara un error
    (36318737,'CEPEDA','LEANDRO' ,'10/10/2000','soltero'), -- Dada la edad menor que 18, levantara un error
    (25100000,'PEREZ','PABLO','01/01/1991',''), -- Dado el estado civil vacio, levantara un error
	(29332501,'SLOTOWIAZDA','MARIA','02/02/1992','SOLTERO'), 
	(19302500,'TENEMBAUN','ENRNESTO','03/03/1993','SOLTERO'),
	(33001321,'RINEIRI','EVANGELINA','04/04/1994','CASADO'),
	(22958543,'DIAZ','XIMENA', '05/05/1995','DIVORCIADO'),
	(35254310,'PEREZ LINDO','MATIAS','06/06/1996','VIUDO'),
	(33387695,'RICCA','JAVIER', '07/07/1997','viudo'),
	(25321542,'SIGNORINI','ESTELA' ,'08/08/1998','DIVORCIADO'),
	(27123456,'REZONICO','CONSTANZA' ,'09/09/1998','VIUDO')
;


/*==================== Updates ====================*/

UPDATE persona SET estado_civil = 'VIUDO' WHERE(persona.dni=29332501); -- Levantara error de transicion
UPDATE persona SET estado_civil = 'DIVORCIADO' WHERE(persona.dni=29332501); -- Levantara error de transicion
UPDATE persona SET estado_civil = 'SOLTERO' WHERE(persona.dni=33001321); -- Levantara error de transicion
UPDATE persona SET estado_civil = 'SOLTERO' WHERE(persona.dni=22958543); -- Levantara error de transicion
UPDATE persona SET estado_civil = 'SOLTERO' WHERE(persona.dni=35254310); -- Levantara error de transicion
UPDATE persona SET estado_civil = 'VIUDO' WHERE(persona.dni=25321542); -- Levantara error de transicion
UPDATE persona SET estado_civil = 'DIVORCIADO' WHERE(persona.dni=27123456); -- Levantara error de transicion

