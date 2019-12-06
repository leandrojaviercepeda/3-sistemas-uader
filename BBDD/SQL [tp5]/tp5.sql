-- a) Aquellos ejemplares que jamás hayan sido retirados.
-- SELECT DISTINCT  l.titulo, l.isbn FROM libro l, ejemplar e WHERE e.isbn=l.isbn AND e.idinventario NOT IN (SELECT idinventario FROM prestamo) ORDER BY l.titulo


-- b) Los libros pertenecientes a la categoría Marketing para los que haya habido pedidos insatisfechos.
-- SELECT l.titulo, l.isbn FROM libro l, categoria c, categorialibro cl, pedidoinsatisfecho pi WHERE c.categoria='Marketing' AND c.idcategoria=cl.idcategoria AND l.isbn=cl.isbn AND l.isbn=pi.isbn


-- c) Los alumnos de Concepción del Uruguay que hayan retirado al menos dos libros durante los años 1988 al 1991.
-- CREATE VIEW alumnos_cprestamos_e88y91 AS SELECT  a.dni, p.fechaprestamo FROM alumno a, prestamo p, ejemplar e WHERE a.dni=p.dni AND e.idinventario=p.idinventario AND p.fechaprestamo BETWEEN '1988-01-01' AND '1991-12-31'
-- SELECT dni, fechaprestamo FROM alumnos_cprestamos_e88y91 WHERE (SELECT COUNT(dni) FROM alumnos_cprestamos_e88y91 AS a WHERE alumnos_cprestamos_e88y91.dni=a.dni)>=2 ORDER BY dni


-- d) Listar los departamentos de los cuales dependen todos aquellos investigadores que hayan retirado libros editados por 'Sudamericana'.
-- CREATE VIEW investigadores_cprestamos_libros_editados_xsudamericana AS (SELECT DISTINCT i.dni FROM investigador i, libro l, ejemplar e, prestamo p, editorial ed WHERE ed.editorial='Sudamericana' AND l.editorial=ed.editorial AND l.isbn=e.isbn AND e.idinventario=p.idinventario AND i.dni=p.dni)
-- SELECT de.departamento FROM investigadores_cprestamos_libros_editados_xsudamericana iplexs, participa pa, proyecto pr, departamento de WHERE iplexs.dni=pa.dni AND pa.idproyecto=pr.idproyecto AND pr.iddepartamento=de.iddepartamento


-- e) El título de aquellos libros que hayan sido retirados tanto por docentes que dictan una determinada materia como por alumnos que cursan la misma.
-- CREATE VIEW libros_retirados_xdocentes_xalumnos_demateria AS (SELECT DISTINCT li.titulo, li.isbn, ma.materia FROM dicta di, cursa cu, materia ma, libro li, ejemplar ej, prestamo pr WHERE ma.idmateria=di.idmateria AND ma.idmateria=cu.idmateria AND di.idmateria=cu.idmateria AND li.isbn=ej.isbn AND ej.idinventario=pr.idinventario AND (di.dni=pr.dni OR cu.dni=pr.dni) ORDER BY ma.materia)

/*
CREATE OR REPLACE FUNCTION librosRetiradosxDocentesxAlumnosDeMateria(m char)
RETURNS SETOF libros_retirados_xdocentes_xalumnos_demateria AS $BODY$
DECLARE
    tb libros_retirados_xdocentes_xalumnos_demateria%rowtype;
BEGIN
	for tb in SELECT DISTINCT titulo, isbn FROM libros_retirados_xdocentes_xalumnos_demateria lrxdxadm
		WHERE (lrxdxadm.materia=m) ORDER BY titulo
	loop
		return next tb;
	end loop;
	
	RETURN;
END; $BODY$ LANGUAGE 'plpgsql';
*/

-- SELECT librosRetiradosxDocentesxAlumnosDeMateria('Álgebra')


-- f) El nombre de los usuarios a los que se les ha vencido el plazo para devolver algún libro, y que con posterioridad a la fecha de vencimiento hayan retirado algún otro.
-- CREATE VIEW usuarios_cplazo_devolucion_vencido AS SELECT DISTINCT u.nombre, u.dni, p.fechalimite FROM usuario u, prestamo p  WHERE u.dni=p.dni AND p.fechadevolucion>p.fechalimite
-- SELECT DISTINCT ucpdv.nombre, ucpdv.dni FROM usuarios_cplazo_devolucion_vencido ucpdv, prestamo p WHERE ucpdv.fechalimite<p.fechaprestamo AND ucpdv.dni=p.dni ORDER BY ucpdv.nombre


-- g) Los docentes que dictan alguna materia en todas las carreras a las que dicha materia pertenece.
-- SELECT DISTINCT doc.dni FROM docente doc, dicta dic, carrera car, materia mat WHERE doc.dni=dic.dni AND dic.idmateria=mat.idmateria AND mat.materia='Derecho Penal' AND dic.idcarrera IN (SELECT d.idcarrera FROM dicta d, materia m WHERE d.idmateria=m.idmateria AND m.materia='Derecho Penal') ORDER BY doc.dni


-- h) Aquellos libros para los que existe más de un ejemplar, tal que al menos dos de esos ejemplares se hayan encontrado prestados
--	en forma simultánea en un determinado momento. Para simplificar, considerar solamente aquellos préstamos en los que el libro ya haya sido devuelto.

-- CREATE VIEW libros_variose_jemplares AS SELECT DISTINCT e1.idInventario id1, e2.idInventario id2 FROM ejemplar e1, ejemplar e2  WHERE e1.idInventario<>e2.idInventario AND e1.isbn=e2.isbn
-- CREATE VIEW libros_devueltos AS SELECT fechaprestamo, idinventario, fechadevolucion FROM prestamo WHERE fechadevolucion IS NOT null
-- CREATE VIEW ejemplares_prestados_simultaneamente AS SELECT ld1.idinventario AS id1,ld2.idinventario AS id2 FROM libros_devueltos ld1, libros_devueltos ld2 WHERE ld1.idinventario<>ld2.idinventario AND ld1.fechaprestamo<ld2.fechadevolucion AND ld2.fechaprestamo<ld1.fechaprestamo
-- CREATE view varios_ejemplares_prestados_simultaneamente AS SELECT lve.id1, lve.id2 FROM libros_variose_jemplares lve, ejemplares_prestados_simultaneamente es WHERE lve.id1=es.id1 and lve.id2=es.id2
-- SELECT l.isbn, l.titulo FROM libro l, varios_ejemplares_prestados_simultaneamente ves, ejemplar e WHERE ves.id1=e.idInventario AND e.isbn=l.isbn


