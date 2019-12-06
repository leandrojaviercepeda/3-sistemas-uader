--a) Los nombres y los países de las clases que llevaban cañones de al menos 16 pulgadas de calibre.
-- SELECT DISTINCT cl.pais FROM clase cl WHERE(cl.calibre>=16);

--b) Hallar los barcos botados antes de 1921.
-- SELECT bc.nombre FROM barco bc WHERE(bc.botado<1921);

--c) Hallar los barcos hundidos en la batalla del Atlántico Norte.
-- SELECT pa.barco FROM participa pa WHERE(pa.batalla='Atlantico Norte' AND pa.resultado='Hundido');

--d) El tratado de Washington de 1921 prohibió los barcos de más de 35000 toneladas. Listar los barcos que violaron el tratado de Washington.
-- SELECT bc.nombre FROM barco bc, clase cl WHERE(bc.botado>=1921 AND bc.clase=cl.clase AND cl.desplazamiento>35000);

--e) Listar el nombre, el desplazamiento y el número de cañones de los barcos que participaron de la batalla de Guadalcanal.
-- SELECT bc.nombre, cl.desplazamiento, cl.caniones FROM barco bc, clase cl, participa pa WHERE(bc.clase=cl.clase AND pa.batalla='Guadalcanal' AND bc.nombre=pa.barco);

--f) Hallar los países que tuvieron tanto cruceros como acorazados.
-- SELECT clase.pais FROM clase WHERE(clase.tipo='Bc' AND clase.pais IN (SELECT clase.pais FROM clase WHERE(clase.tipo='Bb')));

--g) Hallar los barcos que, siendo dañados en alguna batalla, participaron posteriormente de alguna otra.
-- SELECT DISTINCT pa.barco FROM participa pa, participa pa_c, batalla ba, batalla ba_c WHERE(pa.barco=pa_c.barco AND pa.resultado='Dañado' AND pa.batalla!=pa_c.batalla AND ba.fecha<ba_c.fecha);

--h) ¿La base de datos presentada como ejemplo se encuentra en estado consistente? De no ser así, indique alguna inconsistencia que haya encontrado, y la expresión del álgebra relacionar que le permitió hallarla.
-- La base de datos no se encuentra consistente, la expresion que me permitio hallar tal inconsistencia es la siguiente: 
-- SELECT bc.nombre, cl.desplazamiento, cl.caniones FROM barco bc, clase cl, participa pa WHERE(bc.clase=cl.clase AND pa.batalla='Guadalcanal' AND bc.nombre=pa.barco);
-- Inconsistencias: 
--	En la relcion participa, falta FK Barco
--	clase
--	Dominio atributo
--	Batalla FK participa
--	Barco FK clase
					