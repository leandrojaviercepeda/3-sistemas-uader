/**
=====================================================================================================================
@function: registerMeasurement
@param {double precision} temp: temperature
@param {double precision} hum: humidity
@param {double precision} pres: pressure
@param {double precision} uvrad: ultraviolet radiation
@param {double precision} windvel: wind velocity
@param {double precision} winddir: wind direction
@param {double precision} rainmm: rain milimeters
@param {integer} rainintensity: rain intensity
@param {varchar} namestation: name station
@whatdoes: registra una medicion realizada por una estacion.
@return: void
=====================================================================================================================
**/

CREATE OR REPLACE FUNCTION registerMeasurement(temp double precision, hum double precision, pres double precision, uvrad double precision, windvel double precision, winddir double precision, rainmm double precision, rainintensity integer, namestation varchar)
RETURNS void AS $BODY$
DECLARE
	idstation station.id_station%TYPE;
BEGIN
	namestation := trim(initcap(namestation));
	idstation := (SELECT station.id_station FROM station WHERE station.name_station=namestation);
	RAISE NOTICE 'idstation: %', idstation;
	
	if (idstation is not null) then
		INSERT INTO measurement(temperature, humidity, pressure, uv_radiation, wind_vel, wind_dir, rain_mm, rain_intensity, id_station)
			VALUES(temp, hum, pres, uvrad, windvel, winddir, rainmm, rainintensity, idstation);
	else
		raise exception 'Revise que la estacion "%" exista', namestation;
	end if;

	RETURN;
END; $BODY$ LANGUAGE 'plpgsql';

/*
=============================================================================================================================
test: registerMeasurement()
=============================================================================================================================

SELECT registerStation('Base Uader', -33.0333, -59.0167, 'ARGENTINA', 'ENTRE RIOS', 'LARROQUE', '2854');
SELECT * FROM station WHERE station.name_station='Base Uader';
SELECT registerMeasurement(21.22, 67.96, 67.96, 38.88, 87.93, 89.63, 10.96, 9, 'Base Uader');
SELECT * FROM measurement WHERE measurement.id_station=SOME(SELECT station.id_station FROM station WHERE station.name_station='Base Uader');
DELETE FROM station WHERE station.name_station='Base Uader';
*/
