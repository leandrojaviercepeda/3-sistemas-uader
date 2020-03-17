/*
=====================================================================================================================
trigger: capitalizePlan()
whatdoes: capitaliza el atributo description de la relacion plan.
=====================================================================================================================
*/

CREATE OR REPLACE FUNCTION capitalizePlan() RETURNS TRIGGER AS $funcemp$
BEGIN
	new.description := trim(initcap(new.description));
	RETURN NEW;
END; $funcemp$ LANGUAGE plpgsql;

CREATE TRIGGER capitalizePlan BEFORE INSERT OR UPDATE ON plan FOR EACH ROW EXECUTE PROCEDURE capitalizePlan();

/*
=============================================================================================================================
test: capitalizePlan()
=============================================================================================================================

INSERT INTO plan(description, price, amount_consults) VALUES('full', 150.55, 100000000);
SELECT * FROM plan WHERE plan.description='Full';
DELETE FROM plan WHERE plan.description='Full ';
*/
