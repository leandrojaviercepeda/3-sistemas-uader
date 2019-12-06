-- a) Porcentaje de mesas escrutadas.
-- SELECT CAST( (SELECT COUNT(nromesa) FROM votosxmesa) *100 / (SELECT COUNT(nromesa) FROM mesa) AS real)

/*
CREATE OR REPLACE FUNCTION porcentajeMesasEscrutadas() RETURNS real AS $$
	BEGIN
		RETURN (SELECT CAST( (SELECT COUNT(nromesa) FROM votosxmesa) *100 / (SELECT COUNT(nromesa) FROM mesa) AS real) );
	END;
$$ LANGUAGE plpgsql;

SELECT porcentajeMesasEscrutadas();
*/

-- a) Cantidad total de votos emitidos agrupados por escuela.
-- SELECT esc.nombreescuela, SUM(vpm.blancos + vpm.nulos + vpm.recurridos + vpm.impugnados) FROM escuela esc, mesa, votosxmesa vpm WHERE esc.idesc=mesa.idesc AND mesa.nromesa=vpm.nromesa GROUP BY(esc.nombreescuela);


-- b) Cantidad total de votos emitidos agrupados por Circuito.
-- SELECT c.nombrecirc, SUM(vpm.blancos + vpm.nulos + vpm.recurridos + vpm.impugnados) FROM escuela esc, mesa, votosxmesa vpm, circuito c WHERE esc.idesc=mesa.idesc AND esc.idcircuito=c.idcircuito AND mesa.nromesa=vpm.nromesa GROUP BY(c.nombrecirc);


-- c) Cantidad total de votantes masculinos y femeninos.
-- SELECT SUM(vpm.blancos + vpm.nulos + vpm.recurridos + vpm.impugnados) as votmasculinosfemeninos FROM mesa, votosxmesa vpm WHERE mesa.nromesa=vpm.nromesa;


-- d) % de votos obtenidos por una lista xx en el circuito “Suburbio norte”
-- CREATE VIEW escuelas_suburbio_norte AS (SELECT e.idesc as idesc FROM escuela e INNER JOIN circuito c ON e.idcircuito=c.idcircuito AND c.nombrecirc='SUBURBIO NORTE')
-- CREATE VIEW mesas_suburbio_norte AS (SELECT m.nromesa as nromesa FROM mesa m, escuelas_suburbio_norte esb WHERE m.idesc=esb.idesc)


/*
SELECT (
	(SELECT CAST(SUM(vmp.votospartido) AS REAL) AS votos_partido_xx FROM votosmesapartido vmp, mesas_suburbio_norte msn, partido p WHERE vmp.nropartido=p.nrop AND vmp.nromesa=msn.nromesa AND p.nombrep='PJ') *100
		/
	(SELECT CAST(SUM(vmp.votospartido) AS REAL) AS votos_suburbio_norte FROM votosmesapartido vmp, mesas_suburbio_norte msb WHERE vmp.nromesa=msb.nromesa)
)
*/

-- e) Cantidad de votos obtenidos por una lista xx en la escuela “92 Tucumán”
-- CREATE VIEW mesas_escuela_92tucuman AS (SELECT m.nromesa FROM mesa m INNER JOIN escuela e ON m.idesc=e.idesc AND e.nombreescuela='92 TUCUMAN')
-- SELECT SUM(vmp.votospartido) AS votos_partido_xx_escuela_92tucuman FROM votosmesapartido vmp, mesas_escuela_92tucuman met, partido p WHERE vmp.nromesa=met.nromesa AND vmp.nropartido=p.nrop AND p.nombrep='PRO'


-- f) Cantidad total de votos válidos (sin contar blancos, nulos, recurridos e impugnados).
-- CREATE VIEW votos_validos AS (SELECT SUM(vmp.votospartido) AS votos FROM votosmesapartido vmp)


-- g) % de votos no válidos.
-- CREATE VIEW votos_no_validos AS (SELECT SUM(vpm.blancos + vpm.nulos + vpm.recurridos + vpm.impugnados) AS votos FROM votosxmesa vpm)
-- SELECT ( (SELECT * FROM votos_no_validos) / (SELECT SUM(vnv.votos + vv.votos) FROM votos_no_validos vnv, votos_validos vv) ) *100 AS porcentaje_votos_no_validos


-- h) % total de votos obtenidos por cada lista, respecto de la totalidad de los votos.
-- CREATE VIEW votos_totales AS (SELECT SUM(vv.votos + vnv.votos) AS votos FROM votos_no_validos vnv, votos_validos vv)
-- CREATE VIEW votos_lista AS (SELECT p.nrop, p.nombrep, SUM(vmp.votospartido) AS votos FROM votosmesapartido vmp, partido p WHERE vmp.nropartido=p.nrop GROUP BY p.nrop, p.nombrep)
-- CREATE VIEW porcentaje_listas AS (SELECT vl.nombrep, ( CAST(vl.votos AS REAL) / CAST(vt.votos AS REAL) )*100 AS porcentaje FROM votos_lista vl, votos_totales vt)


-- i) % total de votos obtenidos por cada lista, sólo de los votos válidos, esto sin tener en cuenta votos en blanco, nulos, recurridos e impugnados.
-- SELECT vl.nombrep, ( CAST(vl.votos AS REAL) / CAST(vv.votos AS REAL) )*100 AS porcentaje FROM votos_lista vl, votos_validos vv


-- j) Cantidad total de votos obtenidos por cada lista
-- SELECT * FROM votos_lista


-- k) Lista ganadora por circuito
-- CREATE VIEW mesas_xcircuito AS SELECT c.nombrecirc, m.nromesa FROM circuito c, mesa m, escuela e WHERE c.idcircuito=e.idcircuito AND e.idesc=m.idesc
-- CREATE VIEW votos_xmesa_xpartido AS (SELECT vmp.nromesa, vmp.nropartido, SUM(vmp.votospartido) AS votos FROM votosmesapartido vmp GROUP BY vmp.nromesa, vmp.nropartido)
-- CREATE VIEW votos_xpartido_xcircuito AS (SELECT mxc.nombrecirc, vxmxc.nropartido, SUM(vxmxc.votos) AS votos FROM mesas_xcircuito mxc, votos_xmesa_xpartido vxmxc WHERE mxc.nromesa=vxmxc.nromesa GROUP BY mxc.nombrecirc, vxmxc.nropartido)
-- CREATE VIEW votos_xcircuito AS (SELECT vxpxc.nombrecirc, MAX(vxpxc.votos) AS votos FROM votos_xpartido_xcircuito vxpxc, partido p WHERE vxpxc.nropartido=p.nrop GROUP BY vxpxc.nombrecirc)
-- SELECT vxc.nombrecirc, p.nombrep FROM votos_xcircuito vxc, votos_xpartido_xcircuito vxpxc, partido p WHERE vxc.nombrecirc=vxpxc.nombrecirc AND vxpxc.nropartido=p.nrop AND vxpxc.votos=vxc.votos


-- l) Primeras cuatro fuerzas por escuela
-- CREATE VIEW votos_xescuela_xpartido AS (SELECT e.nombreescuela, SUM(vmp.votospartido) votos, p.nombrep nombre, p.nrop FROM escuela e, votosmesapartido vmp, mesa m, partido p WHERE e.idesc=m.idesc AND vmp.nromesa=m.nromesa AND p.nrop = vmp.nropartido GROUP BY e.nombreescuela, p.nombrep, p.nrop)
-- SELECT nombre, votos, nombreescuela	FROM votos_xescuela_xpartido WHERE ( SELECT COUNT(*) FROM votos_xescuela_xpartido AS v WHERE v.nombreescuela = votos_xescuela_xpartido.nombreescuela AND v.votos >= votos_xescuela_xpartido.votos ) <= 4 ORDER BY nombreescuela, votos DESC


-- m) Diferencia en votos y en porcentaje entre las dos primeras fuerzas
-- CREATE VIEW votos_xpartido AS (SELECT p.nombrep, SUM(vmp.votospartido) votos FROM votosmesapartido vmp, partido p WHERE vmp.nropartido=p.nrop GROUP BY p.nombrep)
-- CREATE VIEW dos_primeras_fuerzas_votporc AS (SELECT vxp.nombrep, SUM(vxp.votos) votos, SUM(vxp.votos)*100/(SELECT SUM(votos) FROM votos_xmesa_xpartido) porcentaje FROM votos_xpartido vxp GROUP BY vxp.nombrep ORDER BY votos DESC FETCH FIRST 2 ROW ONLY)
-- SELECT (d1.votos - d2.votos) dif_votos,(d1.porcentaje - d2.porcentaje) dif_por FROM dos_primeras_fuerzas_votporc d1, dos_primeras_fuerzas_votporc d2 WHERE d1.nombrep != d2.nombrep AND d1.votos > d2.votos


-- n) Partidos que hayan ganado una escuela
-- SELECT DISTINCT nombre FROM votos_xescuela_xpartido WHERE ( SELECT COUNT(*) FROM votos_xescuela_xpartido AS v WHERE v.nombreescuela=votos_xescuela_xpartido.nombreescuela and v.votos>=votos_xescuela_xpartido.votos) <= 1


-- o) Partidos que hayan ganado un circuito
-- SELECT DISTINCT p.nombrep FROM votos_xpartido_xcircuito vxpxc, partido p, votos_xcircuito vxc WHERE vxpxc.nropartido=p.nrop AND vxpxc.votos =vxc.votos AND vxpxc.nombrecirc=vxc.nombrecirc;


-- p) Partidos que hayan alcanzado al menos el x% de los votos

/*
CREATE OR REPLACE FUNCTION xPorcentajeAlcanzadoPartido(prc float)
RETURNS SETOF porcentaje_listas AS $BODY$
DECLARE
    tb porcentaje_listas%rowtype;
BEGIN
	for tb in SELECT nombrep FROM porcentaje_listas pl
		WHERE (pl.porcentaje>=prc)
	loop
		return next tb;
	end loop;
	
	RETURN;
END; $BODY$ LANGUAGE 'plpgsql';
*/

-- SELECT * FROM porcentaje_listas
-- SELECT xPorcentajeAlcanzadoPartido(26.0)
-- SELECT xPorcentajeAlcanzadoPartido(5.0)



