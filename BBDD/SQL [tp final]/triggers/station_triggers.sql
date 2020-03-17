/*
=====================================================================================================================
trigger: capitalizeStation()
whatdoes: capitaliza el atributo name_station de la relacion station.
=====================================================================================================================
*/

CREATE OR REPLACE FUNCTION capitalizeStation() RETURNS TRIGGER AS $funcemp$
BEGIN
	new.name_station := trim(initcap(new.name_station));
	RETURN NEW;
END; $funcemp$ LANGUAGE plpgsql;

CREATE TRIGGER capitalizeStation BEFORE INSERT OR UPDATE ON station FOR EACH ROW EXECUTE PROCEDURE capitalizeStation();

/*
=============================================================================================================================
test: capitalizeStation()
=============================================================================================================================

SELECT registerStation('Base Asd', -33.0000, -59.0000, 'Argentina', 'Entre Rios', 'Larroque', '2820');
SELECT * FROM station WHERE station.name_station='Base Asd'
DELETE FROM station WHERE station.name_station='Base Asd';
*/

/*
=====================================================================================================================
trigger: stationStatusControl()
whatdoes: controla el estado fail de la estacion. Si una variable de medicion es nula o vacia se asume una falla.

=====================================================================================================================
*/

CREATE OR REPLACE FUNCTION stationStatusControl() RETURNS TRIGGER AS $funcemp$
DECLARE
	fail bool;
BEGIN
	fail := (SELECT station.fail FROM station WHERE station.id_station = NEW.id_station);
	
	if ((new.temperature is null) or (new.humidity is null) or (new.pressure is null)
			or (new.uv_radiation is null) or (new.wind_vel is null) or (new.wind_dir is null)
			or (new.rain_mm is null) or (new.rain_intensity is null)) then
		UPDATE station SET fail=true WHERE station.id_station = new.id_station;
	else
		UPDATE station SET fail=false WHERE station.id_station = NEW.id_station;
	end if;
    
	RETURN NEW;
END; $funcemp$ LANGUAGE plpgsql;

CREATE TRIGGER stationStatusControl BEFORE INSERT OR UPDATE ON measurement FOR EACH ROW EXECUTE PROCEDURE stationStatusControl();

/*
=============================================================================================================================
test: stationStatusControl()
=============================================================================================================================

SELECT registerStation('Base Asd', -33.0000, -59.0000, 'Argentina', 'Entre Rios', 'Larroque', '2820');
SELECT registerMeasurement(21.22, 67.96, 32.59, 38.88, 87.93, 89.63, 10.0, 9, 'Base Asd');
SELECT * FROM measurement WHERE measurement.id_station=SOME(SELECT station.id_station FROM station WHERE station.name_station='Base Asd');
SELECT station.fail FROM station WHERE station.name_station='Base Asd';
SELECT registerMeasurement(21.22, 67.96, 32.59, 38.88, 87.93, 89.63, 10.0, null, 'Base Asd');
SELECT * FROM measurement WHERE measurement.id_station=SOME(SELECT station.id_station FROM station WHERE station.name_station='Base Asd');
SELECT station.fail FROM station WHERE station.name_station='Base Asd';
DELETE FROM station WHERE station.name_station='Base Asd';
*/