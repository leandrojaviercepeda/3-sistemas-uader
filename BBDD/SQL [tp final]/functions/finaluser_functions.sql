/**
=====================================================================================================================
@function: getWeatherdataBetweenDates
@param {double precision} lat: latitude
@param {double precision} lon: longitude
@param {varchar} startdate: start date (YYYY-MM-DD HH:MM:SS.mm)
@param {varchar} enddate: end date (YYYY-MM-DD HH:MM:SS.mm)
@whatdoes: devuelve todas las mediciones registradas entre fecha de inicio y de fin en una determinada geolocalizacion.
@return: record
=====================================================================================================================
**/

CREATE OR REPLACE FUNCTION getWeatherdataBetweenDates(lat double precision, lon double precision, startdate varchar, enddate varchar)
RETURNS SETOF measurement AS $BODY$
DECLARE
	weatherdata measurement%ROWTYPE;
	stationlocated station.id_station%TYPE;
	idlocationreq location.id_location%TYPE;
BEGIN
	idlocationreq := (SELECT location.id_location FROM location WHERE location.latitude=lat AND location.longitude=lon);
	-- raise notice 'idlocationreq: %', idlocationreq;
	
	if (idlocationreq is null) then
		raise exception 'No poseemos datos de mediciones en la latitude: % y longitude: %', lat, lon;
	else
		stationlocated := (SELECT station.id_station FROM station WHERE station.id_location=idlocationreq);
		-- raise notice 'stationlocated: %', stationlocated;
		
		for weatherdata in (SELECT * FROM measurement 
					  	WHERE measurement.id_station=stationlocated 
					  	AND measurement.date_measurement 
					  	BETWEEN TO_TIMESTAMP(startdate, 'YYYY-MM-DD HH24:MI:SS') 
					  	AND  TO_TIMESTAMP(enddate, 'YYYY-MM-DD HH24:MI:SS'))
		loop
			return next weatherdata;
		end loop;
	end if;
	
	if(weatherdata is null) then
		raise exception 'No poseemos mediciones en el intervalo de fechas especificado [%, %]', startdate, enddate;
	end if;
	
	RETURN;
END; $BODY$ LANGUAGE 'plpgsql';

/*
=============================================================================================================================
test: getWeatherdataBetweenDates
=============================================================================================================================

SELECT * FROM location WHERE location.country='Argentina';
SELECT * FROM getWeatherdataBetweenDates(-33.0333, -59.0167, '2019-01-01 14:00.00', '2019-12-31 21:00.00');
*/

/**
=====================================================================================================================
@function: getWeatherdataByStationId
@param {varchar} idstation: id station
@whatdoes: devuelve la ultima medicion registrada por una determinada estacion.
@return: record
=====================================================================================================================
**/

CREATE OR REPLACE FUNCTION getWeatherdataByStationId(idstation varchar)
RETURNS SETOF measurement AS $BODY$
DECLARE
	weatherdata measurement%ROWTYPE;
	stationlocated station.id_station%TYPE;
BEGIN
	stationlocated := (SELECT station.id_location FROM station WHERE station.id_station=idstation);
	-- raise notice 'stationlocated: %', stationlocated;
	if (stationlocated is null) then
		raise exception 'No poseemos datos de mediciones para este id: % de estacion', idstation;
	else
		for weatherdata in (SELECT * FROM measurement 
						WHERE measurement.id_station=idstation 
						ORDER BY measurement.date_measurement 
						DESC LIMIT 1)
		loop
			return next weatherdata;
		end loop;
	end if;
					
	RETURN;
END; $BODY$ LANGUAGE 'plpgsql';

/*
=============================================================================================================================
test: getWeatherdataByStationId
=============================================================================================================================

SELECT station.id_station FROM station;
SELECT * FROM getWeatherdataByStationId('5bbc02adc8f4');
*/

/**
=====================================================================================================================
@function: getWeatherdataByPlace
@param {varchar} regionname: region
@param {varchar} cityname: city name
@whatdoes: devuelve la ultima medicion realizada en una region y ciudad.
@return: record
=====================================================================================================================
**/

CREATE OR REPLACE FUNCTION getWeatherdataByPlace(regionname varchar, cityname varchar)
RETURNS SETOF measurement AS $BODY$
DECLARE
	weatherdata measurement%ROWTYPE;
	stationlocated station.id_station%TYPE;
	idlocationreq location.id_location%TYPE;
BEGIN
	regionname := trim(initcap(regionname));
	cityname := trim(initcap(cityname));
	idlocationreq := (SELECT location.id_location FROM location 
					  	WHERE location.region=regionname AND location.city=cityname
					  	ORDER BY location.id_location ASC LIMIT 1);
	-- raise notice 'idlocation: %', idlocationreq;
	
	if (idlocationreq is null) then
		raise exception 'No poseemos datos de mediciones en la region % y ciudad %.', regionname, cityname;
	else
		stationlocated := (SELECT station.id_station FROM station WHERE station.id_location=idlocationreq);
		-- raise notice 'stationlocated: %', stationlocated;
		
		for weatherdata in (SELECT * FROM measurement 
					WHERE measurement.id_station=stationlocated 
					ORDER BY measurement.date_measurement 
					DESC LIMIT 1)
		loop
			return next weatherdata;
		end loop;
	end if;
	
	RETURN;
END; $BODY$ LANGUAGE 'plpgsql';

/*
=============================================================================================================================
test: getWeatherdataByPlace
=============================================================================================================================

SELECT location.region, location.city from location;
SELECT * FROM getWeatherdataByPlace('ENTRE RIOS', 'GUALEGUAYCHU');
*/

/*
=====================================================================================================================
@function: getWeatherdataByGeolocation
@param {double precision} lat: latitude
@param {double precision} lon: longitude
@whatdoes: devuelve la ultima medicion registradas en una determinada geolocalizacion.
@return: record
=====================================================================================================================
*/

CREATE OR REPLACE FUNCTION getWeatherdataByGeolocation(lat double precision, lon double precision)
RETURNS SETOF measurement AS $BODY$
DECLARE
	weatherdata measurement%ROWTYPE;
	stationlocated station.id_station%TYPE;
	idlocationreq location.id_location%TYPE;
BEGIN
	idlocationreq := (SELECT location.id_location FROM location 
					  	WHERE location.latitude=lat AND location.longitude=lon);
	-- raise notice 'idlocationreq: %', idlocationreq;
	
	if (idlocationreq is null) then
		raise exception 'No poseemos datos de mediciones en la latitude: % y longitude: %', lat, lon;
	else
		stationlocated := (SELECT station.id_station FROM station WHERE station.id_location=idlocationreq);
		-- raise notice 'stationlocated: %', stationlocated;
		
		for weatherdata in (SELECT * FROM measurement 
					WHERE measurement.id_station=stationlocated 
					ORDER BY measurement.date_measurement 
					DESC LIMIT 1)
		loop
			return next weatherdata;
		end loop;
	end if;
	
	RETURN;
END; $BODY$ LANGUAGE 'plpgsql';

/*
=============================================================================================================================
test: getWeatherdataByGeolocation
=============================================================================================================================

SELECT location.latitude, location.longitude FROM location;
SELECT * FROM getWeatherdataByGeolocation(-33.0333, -59.0167);
*/

/*
=====================================================================================================================
@function: getWeatherdataByZipCode
@param {varchar} zipcode: zip code
@whatdoes: devuelve la ultima medicion realizada en una region segun su codigo de area.
@return: record
=====================================================================================================================
*/

CREATE OR REPLACE FUNCTION getWeatherdataByZipCode(zipcode varchar)
RETURNS SETOF measurement AS $BODY$
DECLARE
	weatherdata measurement%ROWTYPE;
	stationlocated station.id_station%TYPE;
	idlocationreq location.id_location%TYPE;
BEGIN
	zipcode := trim(upper(zipcode));
	idlocationreq := (SELECT location.id_location FROM location 
					  	WHERE location.zip_code=zipcode
					  	ORDER BY location.id_location ASC LIMIT 1);
	-- raise notice 'idlocationreq: %', idlocationreq;
	
	if (idlocationreq is null) then
		raise exception 'No poseemos datos de mediciones en la ciudad con el zipcode: %.', zipcode;
	else
		stationlocated := (SELECT station.id_station FROM station WHERE station.id_location=idlocationreq);
		-- raise notice 'stationlocated: %', stationlocated;
		
		for weatherdata in (SELECT * FROM measurement 
					WHERE measurement.id_station=stationlocated 
					ORDER BY measurement.date_measurement 
					DESC LIMIT 1)
		loop
			return next weatherdata;
		end loop;
	end if;
	
	RETURN;
END; $BODY$ LANGUAGE 'plpgsql';

/*
=============================================================================================================================
test: getWeatherdataByZipCode
=============================================================================================================================

SELECT location.zip_code FROM location;
SELECT * FROM getWeatherdataByZipCode('2820');
*/

/*
=====================================================================================================================
@function: getStationdataBetweenDates
@param {varchar} startdate: start date (YYYY-MM-DD HH:MM:SS.mm)
@param {varchar} enddate: end date (YYYY-MM-DD HH:MM:SS.mm)
@param {integer} amount: amount rows
@whatdoes: devuelve todas las estaciones creadas en un intervalo de fechas [startdate; enddate].
@return: stationdata(id_station varchar, name_station varchar, fail bool, created_at timestamp, latitude double precision, 
		longitude double precision, country varchar, region varchar, city varchar, zip_code varchar)
=====================================================================================================================
*/

CREATE OR REPLACE FUNCTION getStationdataBetweenDates(startdate varchar, enddate varchar, amount integer default 10)
RETURNS SETOF record AS $BODY$
DECLARE
	stationdata record%TYPE;
BEGIN
	for stationdata in (SELECT station.id_station, station.name_station, 
						station.fail, station.created_at, location.latitude, 
						location.longitude, location.country, location.region, 
						location.city, location.zip_code
 			FROM station, location
				WHERE station.id_location=location.id_location 
					AND station.created_at 
						BETWEEN TO_TIMESTAMP(startdate, 'YYYY-MM-DD HH24:MI:SS') 
							AND  TO_TIMESTAMP(enddate, 'YYYY-MM-DD HH24:MI:SS') 
						ORDER BY station.created_at ASC
						LIMIT amount)
	loop
		return next stationdata;
	end loop;
	
	if (stationdata is null) then
		raise exception 'No poseemos estaciones creadas en el intervalo de fechas [%; %].', startdate, enddate;
	end if;
	
	RETURN;
END; $BODY$ LANGUAGE 'plpgsql';

/*
=============================================================================================================================
test: getStationdataBetweenDates
=============================================================================================================================

SELECT * FROM getStationdataBetweenDates('2019-01-01 00:00:00', '2019-12-31 23:59:00', 5) 
	AS stationdata(id_station varchar, name_station varchar, fail bool, created_at timestamp, 
	latitude double precision, longitude double precision, country varchar, region varchar, city varchar, zip_code varchar);
*/

/*
=====================================================================================================================
@function: getStationdataById
@param {varchar} idstation: id station
@whatdoes: devuelve la estacion con el id especificado.
@return: stationdata(id_station varchar, name_station varchar, fail bool, created_at timestamp, latitude double precision, 
		longitude double precision, country varchar, region varchar, city varchar, zip_code varchar)
=====================================================================================================================
*/

CREATE OR REPLACE FUNCTION getStationdataById(idstation varchar)
RETURNS SETOF record AS $BODY$
DECLARE
	stationdata record%TYPE;
BEGIN
	for stationdata in (SELECT station.id_station, station.name_station, 
						station.fail, station.created_at, location.latitude, 
						location.longitude, location.country, location.region, 
						location.city, location.zip_code
 			FROM station, location
				WHERE station.id_station=idstation 
					AND station.id_location=location.id_location)
	loop
		return next stationdata;
	end loop;
	
	if (stationdata is null) then
		raise exception 'No poseemos estaciones con el id: % especificado.', idstation;
	end if;
	
	RETURN;
END; $BODY$ LANGUAGE 'plpgsql';

/*
=============================================================================================================================
test: getStationdataById
=============================================================================================================================

SELECT station.id_station FROM station;

SELECT * FROM getStationdataById('92c588dd7de8')
	AS stationdata(id_station varchar, name_station varchar, fail bool, created_at timestamp, latitude double precision, 
	longitude double precision, country varchar, region varchar, city varchar, zip_code varchar);
*/

/*
=====================================================================================================================
@function: getStationdataByPlace
@param {varchar} regionname: region name
@param {varchar} cityname: city name
@param {integer} amount: amount rows
@whatdoes: devuelve todas las estaciones localizadas en la region y ciudad especificada.
@return: stationdata(id_station varchar, name_station varchar, fail bool, created_at timestamp, latitude double precision, 
		longitude double precision, country varchar, region varchar, city varchar, zip_code varchar)
=====================================================================================================================
*/

CREATE OR REPLACE FUNCTION getStationdataByPlace(regionname varchar, cityname varchar, amount integer default 10)
RETURNS SETOF record AS $BODY$
DECLARE
	stationdata record%TYPE;
BEGIN
	regionname := trim(initcap(regionname));
	cityname := trim(initcap(cityname));
	for stationdata in (SELECT station.id_station, station.name_station, 
						station.fail, station.created_at, location.latitude, 
						location.longitude, location.country, location.region, 
						location.city, location.zip_code
 			FROM station, location
				WHERE station.id_location=location.id_location 
					AND location.region=regionname
					AND location.city=cityname
						ORDER BY station.created_at ASC
						LIMIT amount)
	loop
		return next stationdata;
	end loop;
	
	if (stationdata is null) then
		raise exception 'No poseemos estaciones ubicadas en la region % y ciudad %.', regionname, cityname;
	end if;
	
	RETURN;
END; $BODY$ LANGUAGE 'plpgsql';

/*
=============================================================================================================================
test: getStationdataByPlace
=============================================================================================================================

SELECT location.region, location.city FROM location;

SELECT * FROM getStationdataByPlace('ENTRE RIOS', 'PARANA', 5)
	AS stationdata(id_station varchar, name_station varchar, fail bool, created_at timestamp, latitude double precision, 
	longitude double precision, country varchar, region varchar, city varchar, zip_code varchar);
*/

/*
=====================================================================================================================
@function: getStationdataByGeolocation
@param {double precision} lat: latitude
@param {double precision} lon: longitude
@whatdoes: devuelve la estacion localizazda en la geolocalizacion especificada.
@return: stationdata(id_station varchar, name_station varchar, fail bool, created_at timestamp, latitude double precision, 
		longitude double precision, country varchar, region varchar, city varchar, zip_code varchar)
=====================================================================================================================
*/

CREATE OR REPLACE FUNCTION getStationdataByGeolocation(lat double precision, lon double precision)
RETURNS SETOF record AS $BODY$
DECLARE
	stationdata record%TYPE;
BEGIN
	for stationdata in (SELECT station.id_station, station.name_station, 
						station.fail, station.created_at, location.latitude, 
						location.longitude, location.country, location.region, 
						location.city, location.zip_code
 			FROM station, location
				WHERE station.id_location=location.id_location 
					AND location.latitude=lat
					AND location.longitude=lon)
	loop
		return next stationdata;
	end loop;
	
	if (stationdata is null) then
		raise exception 'No poseemos ninguna estacion ubicada en las coordenadas latitude: % ; longitude: %.', lat, lon;
	end if;
	
	RETURN;
END; $BODY$ LANGUAGE 'plpgsql';

/*
=============================================================================================================================
test: getStationdataByGeolocation
=============================================================================================================================

SELECT location.latitude, location.longitude FROM location;

SELECT * FROM getStationdataByGeolocation(-32.4833, -58.2283)
	AS stationdata(id_station varchar, name_station varchar, fail bool, created_at timestamp, latitude double precision, 
	longitude double precision, country varchar, region varchar, city varchar, zip_code varchar);
*/

/*
=====================================================================================================================
@function: getStationdataByZipcode
@param {varchar} zipcode: zip code
@param {integer} amount: amount rows
@whatdoes: devuelve todas las estaciones localizadas en la region con el codigo de area especificado.
@return: stationdata(id_station varchar, name_station varchar, fail bool, created_at timestamp, latitude double precision, 
		longitude double precision, country varchar, region varchar, city varchar, zip_code varchar)
=====================================================================================================================
*/

CREATE OR REPLACE FUNCTION getStationdataByZipcode(zipcode varchar, amount integer default 10)
RETURNS SETOF record AS $BODY$
DECLARE
	stationdata record%TYPE;
BEGIN
	zipcode := trim(upper(zipcode));
	for stationdata in (SELECT station.id_station, station.name_station, 
						station.fail, station.created_at, location.latitude, 
						location.longitude, location.country, location.region, 
						location.city, location.zip_code
 			FROM station, location
				WHERE station.id_location=location.id_location 
					AND location.zip_code=zipcode
						ORDER BY station.created_at ASC
						LIMIT amount)
	loop
		return next stationdata;
	end loop;
	
	if (stationdata is null) then
		raise exception 'No poseemos estaciones ubicadas la region con el zipcode %.', zipcode;
	end if;
	
	RETURN;
END; $BODY$ LANGUAGE 'plpgsql';

/*
=============================================================================================================================
test: getStationdataByZipcode
=============================================================================================================================

SELECT location.zipcode FROM location;

SELECT * FROM getStationdataByZipcode('2820', 15)
	AS stationdata(id_station varchar, name_station varchar, fail bool, created_at timestamp, latitude double precision, 
	longitude double precision, country varchar, region varchar, city varchar, zip_code varchar);
*/