/*
=====================================================================================================================
trigger: capitalizeFinaluser()
whatdoes: capitaliza los atributos firstname, lastname, email de la relacion finaluser.
=====================================================================================================================
*/

CREATE OR REPLACE FUNCTION capitalizeFinaluser() RETURNS TRIGGER AS $funcemp$
BEGIN
	new.email := trim(lower(new.email));
	new.username := trim(initcap(new.username));
	RETURN NEW;
END; $funcemp$ LANGUAGE plpgsql;

CREATE TRIGGER capitalizeFinaluser BEFORE INSERT OR UPDATE ON finaluser FOR EACH ROW EXECUTE PROCEDURE capitalizeFinaluser();

/*
=============================================================================================================================
test: capitalizeFinaluser()
=============================================================================================================================

INSERT INTO finaluser(email, first_name, last_name, birthdate) VALUES('asd@gmail.com', 'asd', 'asd', '06/08/1992');
SELECT * FROM finaluser WHERE finaluser.email=SOME(SELECT finaluser.email FROM finaluser WHERE finaluser.email='asd@gmail.com');
DELETE FROM finaluser WHERE email='asd@gmail.com';
*/

/*
=====================================================================================================================
trigger: deleteUserAfterClient()
whatdoes: luego de eliminar un cliente, elimina los datos de usuario del mismo.
=====================================================================================================================
*/

CREATE OR REPLACE FUNCTION deleteUserAfterClient() RETURNS TRIGGER AS $funcemp$
BEGIN
	DELETE FROM finaluser WHERE finaluser.id_finaluser=OLD.id_finaluser;
	RETURN NEW;
END; $funcemp$ LANGUAGE plpgsql;

CREATE TRIGGER deleteUserAfterClient AFTER DELETE ON client FOR EACH ROW EXECUTE PROCEDURE deleteUserAfterClient();

/*
=============================================================================================================================
test: deleteUserAfterClient()
=============================================================================================================================

INSERT INTO finaluser(email, first_name, last_name, birthdate) VALUES('asd@gmail.com', 'asd', 'asd', '06/08/1992');
SELECT * FROM client WHERE client.id_finaluser=SOME(SELECT finaluser.id_finaluser FROM finaluser WHERE finaluser.email='asd@gmail.com');
DELETE FROM client WHERE client.id_finaluser=SOME(SELECT finaluser.id_finaluser FROM finaluser WHERE finaluser.email='asd@gmail.com');
SELECT * FROM finaluser WHERE finaluser.email='asd@gmail.com';
*/

/*
=====================================================================================================================
trigger: deleteUserAfterAdmin()
whatdoes: luego de eliminar un cliente, elimina los datos de usuario del mismo.
=====================================================================================================================
*/

CREATE OR REPLACE FUNCTION deleteUserAfterAdmin() RETURNS TRIGGER AS $funcemp$
BEGIN
	DELETE FROM finaluser WHERE finaluser.id_finaluser=OLD.id_finaluser;
	RETURN NEW;
END; $funcemp$ LANGUAGE plpgsql;

CREATE TRIGGER deleteUserAfterAdmin AFTER DELETE ON administrator FOR EACH ROW EXECUTE PROCEDURE deleteUserAfterAdmin();

/*
=============================================================================================================================
test: deleteUserAfterClient()
=============================================================================================================================

INSERT INTO finaluser(email, first_name, last_name, birthdate) VALUES('asd@gmail.com', 'asd', 'asd', '06/08/1992');
SELECT * FROM administrator WHERE administrator.id_finaluser=SOME(SELECT finaluser.id_finaluser FROM finaluser WHERE finaluser.email='asd@gmail.com');
DELETE FROM administrator WHERE administrator.id_finaluser=SOME(SELECT finaluser.id_finaluser FROM finaluser WHERE finaluser.email='asd@gmail.com');
SELECT * FROM finaluser WHERE finaluser.email='asd@gmail.com';
*/