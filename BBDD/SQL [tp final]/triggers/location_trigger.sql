/*
=====================================================================================================================
trigger: capitalizeLocation()
whatdoes: capitaliza los atributos country, region, city de la relacion location.
=====================================================================================================================
*/

CREATE OR REPLACE FUNCTION capitalizeLocation() RETURNS TRIGGER AS $funcemp$
BEGIN
	new.country := trim(initcap(new.country));
	new.region := trim(initcap(new.region));
	new.city := trim(initcap(new.city));
	new.zip_code := trim(upper(new.zip_code));
	RETURN NEW;
END; $funcemp$ LANGUAGE plpgsql;

CREATE TRIGGER capitalizeLocation BEFORE INSERT OR UPDATE ON location FOR EACH ROW EXECUTE PROCEDURE capitalizeLocation();

/*
=============================================================================================================================
test: capitalizeLocation()
=============================================================================================================================

INSERT INTO location (latitude, longitude, country, region, city, zip_code) VALUES (-33.0000, -59.0000, 'ARGENTINA', 'ENTRE RIOS', 'LARROQUE', '24a8');
SELECT * FROM location WHERE location.latitude=-33.0000 AND location.longitude=-59.0000;
DELETE FROM location WHERE location.latitude=-33.0000 AND location.longitude=-59.0000;
*/

/*
=====================================================================================================================
trigger: removeLocationAfterStation()
whatdoes: luego de eliminar una estacion, elimina la localizacion correspondiente a la misma.
=====================================================================================================================
*/

CREATE OR REPLACE FUNCTION removeLocationAfterStation() RETURNS TRIGGER AS $funcemp$
BEGIN
	DELETE FROM location WHERE location.id_location=OLD.id_location;
	RETURN NEW;
END; $funcemp$ LANGUAGE plpgsql;

CREATE TRIGGER removeLocationAfterStation AFTER DELETE ON station FOR EACH ROW EXECUTE PROCEDURE removeLocationAfterStation();

/*
=============================================================================================================================
test: removeLocationAfterStation()
=============================================================================================================================

SELECT registerStation('Base Asd', -33.0000, -59.0000, 'Argentina', 'Entre Rios', 'Larroque', '2820');
SELECT * FROM location WHERE latitude=-33.0000 AND longitude=-59.0000;
SELECT * FROM station WHERE station.name_station='Base Asd';
DELETE FROM station WHERE station.name_station='Base Asd';
*/