/*
=============================================================================================================================
a) % de votos obtenidos por una lista xx en el circuito “Suburbio norte”
=============================================================================================================================
*/

/*
CREATE OR REPLACE FUNCTION porcentajeVotosLista(lista varchar)
RETURNS real AS $BODY$
DECLARE
	votoslistacircuitosb real;
	totalvotoscircuitosb real;
	porcentaje real;
BEGIN
	votoslistacircuitosb := (SELECT SUM(vmp.votospartido) FROM escuela e, circuito c, mesa m, votosmesapartido vmp, partido p WHERE e.idcircuito=c.idcircuito AND c.nombrecirc='SUBURBIO NORTE' AND m.idesc=e.idesc AND vmp.nropartido=p.nrop AND vmp.nromesa=m.nromesa AND p.nombrep=lista);
	--RAISE NOTICE 'Votos lista % circuito Suburbio Norte: %', lista, votoslistacircuitosb;
	totalvotoscircuitosb := (SELECT SUM(vmp.votospartido) FROM escuela e, circuito c, mesa m, votosmesapartido vmp WHERE e.idcircuito=c.idcircuito AND c.nombrecirc='SUBURBIO NORTE' AND m.idesc=e.idesc AND vmp.nromesa=m.nromesa);
	--RAISE NOTICE 'Total votos circuito Suburbio Norte: %', totalvotoscircuitosb;
	porcentaje := votoslistacircuitosb*100 / totalvotoscircuitosb;
	RAISE NOTICE 'Porcentaje: %', porcentaje;
	
	IF (porcentaje IS NULL) THEN
		RAISE EXCEPTION 'Error, la lista "%" no es valida', lista;
	END IF;
	
	RETURN porcentaje;
END; $BODY$ LANGUAGE 'plpgsql';
*/

--SELECT porcentajeVotosLista('PRO')


/*
=============================================================================================================================
b) Modifique la función anterior para que se le pueda pasar por parámetro un circuito.
=============================================================================================================================
*/


/*
CREATE OR REPLACE FUNCTION porcentajeVotosListaxCircuitox(lista varchar, circuito varchar)
RETURNS real AS $BODY$
DECLARE
	votoslistaxcircuitox real;
	totalvotoscircuitox real;
	porcentaje real;
BEGIN
	votoslistaxcircuitox := (SELECT SUM(vmp.votospartido)
							 	FROM escuela e, circuito c, mesa m, votosmesapartido vmp, partido p
							 		WHERE e.idcircuito=c.idcircuito AND c.nombrecirc=circuito AND m.idesc=e.idesc
							 			AND vmp.nropartido=p.nrop AND vmp.nromesa=m.nromesa AND p.nombrep=lista);
	--RAISE NOTICE 'Votos lista "%" circuito "%": %', lista, circuito, votoslistaxcircuitox;
	
	totalvotoscircuitox := (SELECT SUM(vmp.votospartido)
							 	FROM escuela e, circuito c, mesa m, votosmesapartido vmp
							 		WHERE e.idcircuito=c.idcircuito AND c.nombrecirc=circuito AND m.idesc=e.idesc
							 			AND vmp.nromesa=m.nromesa);
										
	--RAISE NOTICE 'Total votos circuito "%": %', circuito, totalvotoscircuitox;
	porcentaje := votoslistaxcircuitox*100 / totalvotoscircuitox;
	RAISE NOTICE 'Porcentaje: %', porcentaje;
	
	IF (porcentaje IS NULL) THEN
		RAISE EXCEPTION 'Error, la lista "%" o el circuito "%" no es valida', lista, circuito;
	END IF;
	
	RETURN porcentaje;
END; $BODY$ LANGUAGE 'plpgsql';
*/

--SELECT porcentajeVotosListaxCircuitox('PRO', 'SUBURBIO NORTE')

/*
=============================================================================================================================
c) Lista ganadora por circuito
=============================================================================================================================
*/

--CREATE VIEW votosxpartidoxcircuito AS (SELECT c.nombrecirc, vmp.nropartido, SUM(vmp.votospartido) votos FROM circuito c, mesa m, escuela e, votosmesapartido vmp WHERE c.idcircuito=e.idcircuito AND e.idesc=m.idesc AND vmp.nromesa=m.nromesa GROUP BY c.nombrecirc, vmp.nropartido);
--CREATE VIEW votosxcircuito AS (SELECT vxpxc.nombrecirc, MAX(vxpxc.votos) votos FROM votosxpartidoxcircuito vxpxc, partido p WHERE vxpxc.nropartido=p.nrop GROUP BY vxpxc.nombrecirc);

/*
CREATE OR REPLACE FUNCTION listaGanadoraxCircuito()
RETURNS TABLE(nombrecirc varchar(30), nombrep varchar(30)) AS $BODY$
DECLARE
BEGIN	
	RETURN QUERY (SELECT vxc.nombrecirc, p.nombrep FROM votosxcircuito vxc, votosxpartidoxcircuito vxpxc, partido p WHERE vxc.nombrecirc=vxpxc.nombrecirc AND vxpxc.nropartido=p.nrop AND vxpxc.votos=vxc.votos);
END; $BODY$ LANGUAGE 'plpgsql';
*/

--SELECT listaGanadoraxCircuito()

/*
=============================================================================================================================
d) Primeras cuatro fuerzas por escuela
=============================================================================================================================
*/

--CREATE VIEW votosxescuelaxpartido AS (SELECT e.nombreescuela, SUM(vmp.votospartido) votos, p.nombrep nombre, p.nrop FROM escuela e, votosmesapartido vmp, mesa m, partido p WHERE e.idesc=m.idesc AND vmp.nromesa=m.nromesa AND p.nrop = vmp.nropartido GROUP BY e.nombreescuela, p.nombrep, p.nrop)

/*
CREATE OR REPLACE FUNCTION primerasCuatroFuerzasxEscuela()
RETURNS TABLE(nombrepartido varchar(30), votos bigint, nombreescuela varchar(30)) AS $BODY$
DECLARE
BEGIN	
	RETURN QUERY SELECT vxexp.nombre, vxexp.votos, vxexp.nombreescuela FROM votosxescuelaxpartido vxexp WHERE ( SELECT COUNT(*) FROM votosxescuelaxpartido AS v WHERE v.nombreescuela = vxexp.nombreescuela AND v.votos >= vxexp.votos ) <= 4 ORDER BY nombreescuela, votos DESC;
END; $BODY$ LANGUAGE 'plpgsql';
*/

--SELECT primerasCuatroFuerzasxEscuela()

/*
=============================================================================================================================
e) Partidos que hayan alcanzado al menos el x% de los votos
=============================================================================================================================
*/

--CREATE VIEW votosnovalidos AS (SELECT SUM(vpm.blancos + vpm.nulos + vpm.recurridos + vpm.impugnados) AS votos FROM votosxmesa vpm)
--CREATE VIEW votostotales AS (SELECT SUM(vv.votos + vnv.votos) AS votos FROM votosnovalidos vnv, votos_validos vv)
--CREATE VIEW votoslistas AS (SELECT p.nrop, p.nombrep, SUM(vmp.votospartido) AS votos FROM votosmesapartido vmp, partido p WHERE vmp.nropartido=p.nrop GROUP BY p.nrop, p.nombrep)
--CREATE VIEW porcentajelistas AS (SELECT vl.nombrep, ( CAST(vl.votos AS REAL) / CAST(vt.votos AS REAL) )*100 AS porcentaje FROM votos_lista vl, votostotales vt)


/*
CREATE OR REPLACE FUNCTION xPorcentajeAlcanzadoPartido(pct float)
RETURNS SETOF porcentajelistas AS $BODY$
DECLARE
    tb porcentajelistas%rowtype;
BEGIN
	for tb in SELECT nombrep FROM porcentajelistas pl
		WHERE (pl.porcentaje>=pct)
	loop
		return next tb;
	end loop;
	
	RETURN;
END; $BODY$ LANGUAGE 'plpgsql';
*/

--SELECT xPorcentajeAlcanzadoPartido(26.0)
