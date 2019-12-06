--a) ¿Qué modelos de PC tienen una velocidad de al menos 150?
-- SELECT pc.cod, pc.veloc FROM pc WHERE(pc.veloc>=150);

--b) ¿Qué fabricantes hacen laptops con un disco duro de al menos un gigabyte?
-- SELECT DISTINCT pr.fabricante FROM producto pr, laptop la WHERE(pr.cod=la.cod AND la.hd>=1.00);

--c) Hallar el número de modelo y el precio de todos los productos (de cualquier tipo) hechos por el fabricante B.
/*
(SELECT im.cod, im.precio FROM impresora im INNER JOIN producto pr ON(pr.cod=im.cod AND pr.fabricante='B'))
UNION (SELECT la.cod, la.precio FROM laptop la INNER JOIN producto pr ON(pr.cod=la.cod AND pr.fabricante='B'))
UNION (SELECT pc.cod, pc.precio FROM pc INNER JOIN producto pr ON(pr.cod=pc.cod AND pr.fabricante='B'));
*/

--d) Hallar el número de modelo de todas las impresoras color.
-- SELECT im.cod FROM impresora im WHERE(im.color=true);

--e) Hallar los fabricantes que venden laptops pero no PCs.
/*
(SELECT pr.fabricante FROM producto pr INNER JOIN laptop la ON(pr.cod=la.cod))
UNION (SELECT pr.fabricante FROM producto pr INNER JOIN pc ON(pr.cod=pc.cod))
EXCEPT (SELECT pr.fabricante FROM producto pr INNER JOIN pc ON(pr.cod=pc.cod));
*/

-- SELECT DISTINCT pr.fabricante FROM producto pr WHERE(pr.tipo='Laptop' AND pr.fabricante NOT IN(SELECT pr.fabricante FROM producto pr WHERE pr.tipo='Pc'));

--f) Hallar aquellos tamaños de discos que ocurren en dos o más PCs.
-- SELECT DISTINCT pc.hd FROM pc INNER JOIN pc pc_c ON(pc.cod!=pc_c.cod AND pc.hd=pc_c.hd);

--g) Hallar pares de modelos de PC tales que ambos posean la misma velocidad y RAM. Un par debe ser listado una sola vez: (i,j) pero no (j,i)
-- SELECT (pc.cod, pc.veloc, pc.ram), (pc_c.cod, pc_c.veloc, pc_c.ram) FROM pc INNER JOIN pc pc_c ON(pc.cod!=pc_c.cod AND pc.cod<pc_c.cod AND pc.veloc=pc_c.veloc AND pc.ram=pc_c.ram);

--h) Hallar aquellos fabricantes que ofrezcan computadoras (sean PC o laptop) con velocidades de al menos 133.
/*
(SELECT pr.fabricante FROM producto pr, pc WHERE(pr.cod=pc.cod AND pc.veloc>=133))
UNION (SELECT pr.fabricante FROM producto pr, laptop la WHERE(pr.cod=la.cod AND la.veloc>=133));
*/

--i) Hallar los fabricantes de la computadora (PC o laptop) con la máxima velocidad disponible.
/*
CREATE VIEW fabPcOrLapEqVeloc AS (SELECT pr.fabricante FROM producto pr INNER JOIN pc ON(pr.cod=pc.cod AND pc.veloc=ALL(SELECT MAX(pc.veloc) FROM pc)))
UNION (SELECT pr.fabricante FROM producto pr INNER JOIN laptop la ON(pr.cod=la.cod AND la.veloc=ALL(SELECT MAX(la.veloc) FROM laptop la)));
*/

-- Crear una vista para la consulta anterior
-- SELECT* FROM fabPcOrLapEqVeloc

