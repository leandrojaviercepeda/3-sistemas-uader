/*
=====================================================================================================================
trigger: capitalizeApikey()
whatdoes: capitaliza el atributo name_apikey de la relacion apikey.
=====================================================================================================================
*/

CREATE OR REPLACE FUNCTION capitalizeApikey() RETURNS TRIGGER AS $funcemp$
BEGIN
	new.name_apikey := trim(initcap(new.name_apikey));
	RETURN NEW;
END; $funcemp$ LANGUAGE plpgsql;

CREATE TRIGGER capitalizeApikey BEFORE INSERT OR UPDATE ON apikey FOR EACH ROW EXECUTE PROCEDURE capitalizeApikey();

/*
=============================================================================================================================
test: capitalizeApikey()
=============================================================================================================================

INSERT INTO finaluser (email, first_name, last_name, birthdate) VALUES('asd@gmail.com', 'asd', 'asd', '06/08/1992');
UPDATE apikey SET name_apikey = 'weatherstation-app' WHERE apikey.id_client=SOME(SELECT c.id_client FROM client c, finaluser f WHERE c.id_finaluser=f.id_finaluser AND f.email='asd@gmail.com');
SELECT * FROM apikey WHERE apikey.id_client=SOME(SELECT c.id_client FROM client c, finaluser f WHERE c.id_finaluser=f.id_finaluser AND f.email='asd@gmail.com');
DELETE FROM finaluser WHERE email='asd@gmail.com';
*/

/*
=====================================================================================================================
trigger: generateDefaultApikey()
whatdoes: genera un apikey por defecto al dar de alta un cliente y se asocia al mismo.
=====================================================================================================================
*/

CREATE OR REPLACE FUNCTION generateDefaultApikey() RETURNS TRIGGER AS $funcemp$
DECLARE
BEGIN	
	INSERT INTO apikey(id_client) VALUES(NEW.id_client);
	RETURN NEW;
END; $funcemp$ LANGUAGE plpgsql;

CREATE TRIGGER generateDefaultApikey AFTER INSERT ON client FOR EACH ROW EXECUTE PROCEDURE generateDefaultApikey();

/*
=============================================================================================================================
test: generateDefaultApikey()
=============================================================================================================================

INSERT INTO finaluser (email, first_name, last_name, birthdate) VALUES('asd@gmail.com', 'asd', 'asd', '06/08/1992');
SELECT * FROM apikey WHERE apikey.id_client=SOME(SELECT c.id_client FROM client c, finaluser f WHERE c.id_finaluser=f.id_finaluser AND f.email='asd@gmail.com');
DELETE FROM finaluser WHERE email='asd@gmail.com';
*/