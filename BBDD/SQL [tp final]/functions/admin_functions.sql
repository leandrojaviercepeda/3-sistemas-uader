/**
==============================================================================================================================
function: clientsSuscribedAtPlan(planname varchar)
@param {varchar} planname: plan name
@whatdoes: devuelve todos los usuarios suscriptosa un determinado plan.
@return: record
==============================================================================================================================
**/

CREATE OR REPLACE FUNCTION clientsSuscribedAtPlan(planname varchar)
RETURNS SETOF record AS $BODY$
DECLARE clients record%TYPE;
BEGIN
	planname := trim(initcap(planname));
	for clients in (SELECT client.id_client, finaluser.first_name, finaluser.last_name
						FROM client, finaluser 
							WHERE client.suscribed_to_plan=planname
								and client.id_finaluser=finaluser.id_finaluser)
	LOOP
		RETURN NEXT clients;
	END LOOP;

	if(clients is null) THEN
		RAISE EXCEPTION 'No existen clientes suscriptos al plan: %.', planname;
	END IF;
	RETURN;
END;
$BODY$ LANGUAGE plpgsql;

/*
=============================================================================================================================
test: clientsSuscribedAtPlan(planname varchar)
=============================================================================================================================

SELECT * FROM clientsSuscribedAtPlan('basic') AS clients(id_client varchar, first_name varchar, last_name varchar);
*/