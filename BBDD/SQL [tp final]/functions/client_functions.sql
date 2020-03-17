/**
=====================================================================================================================
@function: upgradePlan
@param {varchar} idclient: id client
@param {varchar} plantosuscribe: plan to suscribe
@whatdoes: actualiza el plan actual al que esta suscripto el cliente. Incluye: actualizar suscribed_to_plan, acualizar available_consults.
@return: void
=====================================================================================================================
**/

CREATE OR REPLACE FUNCTION upgradePlan(idclient varchar, plantosuscribe varchar) 
RETURNS void AS $BODY$
DECLARE
	planselected plan%ROWTYPE;
	currentplan varchar;
BEGIN	
	plantosuscribe := trim(initcap(plantosuscribe));
	planselected := (SELECT plan FROM plan WHERE plan.description=plantosuscribe);
	if (planselected is null) then
		raise exception 'El plan % no esta disponible.', plantosuscribe;
	end if;
	
	currentplan := (SELECT client.suscribed_to_plan FROM client WHERE client.id_client=idclient);
	if(currentplan=plantosuscribe) then
		raise exception 'Usted ya posee el plan %.', plantosuscribe;
	end if;
	
	if (planselected is not null AND idclient is not null) then
		UPDATE client SET 
			suscribed_to_plan=planselected.description,
			available_consults=planselected.amount_consults
				WHERE client.id_client=idclient;
	end if;

	RETURN;
END; $BODY$ LANGUAGE plpgsql;

/*
=============================================================================================================================
test: upgradePlan()
=============================================================================================================================

INSERT INTO finaluser (email, first_name, last_name, birthdate) VALUES('asdasd@gmail.com', 'asd', 'asd', '06/08/1992');
SELECT client.id_client FROM client, finaluser WHERE client.id_finaluser=finaluser.id_finaluser AND finaluser.email='asdasd@gmail.com';
SELECT upgradePlan('', 'Premium');
SELECT client.suscribed_to_plan FROM client WHERE client.id_client='';
DELETE FROM finaluser WHERE finaluser.email='asdasd@gmail.com';
*/

/**
=====================================================================================================================
@function: generateApikey
@param {varchar} idclient: id client
@param {varchar} apikeyname: plan to suscribe
@whatdoes: genera una nueva apikey y la asocia al cliente especificado.
@return: void
=====================================================================================================================
**/

CREATE OR REPLACE FUNCTION generateApikey(idclient varchar, apikeyname varchar default 'Default') 
RETURNS void AS $BODY$
DECLARE
	apikeyid varchar;
BEGIN
	apikeyname := trim(initcap(apikeyname));
	if (idclient is not null AND apikeyname is not null) then
		INSERT INTO apikey(id_apikey, name_apikey, id_client) VALUES(gen_random_uuid(), apikeyname, idclient);
	else
		raise exception 'Cliente % no registrado.', idclient;
	end if;
	
	RETURN;
END; $BODY$ LANGUAGE plpgsql;

/*
=============================================================================================================================
test: generateApikey()
=============================================================================================================================

INSERT INTO finaluser (email, first_name, last_name, birthdate) VALUES('asdasd@gmail.com', 'asd', 'asd', '06/08/1992');
SELECT client.id_client FROM client, finaluser WHERE client.id_finaluser=finaluser.id_finaluser AND finaluser.email='asdasd@gmail.com';
SELECT generateApikey('', 'asdasd-app');
SELECT * FROM apikey WHERE apikey.id_client='';
DELETE FROM finaluser WHERE finaluser.email='asdasd@gmail.com';
*/
