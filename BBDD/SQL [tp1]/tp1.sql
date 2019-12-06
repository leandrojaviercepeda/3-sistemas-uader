
--Ejercicio 8

--a SELECT nombre, apellido FROM empleado;
--b SELECT apellido, nombre, genero FROM empleado WHERE(genero='M');
--c SELECT MAX(sueldo), MIN(sueldo), CAST(AVG(sueldo) as DECIMAL(10,2)) FROM empleado;
--d SELECT apellido, nombre, sueldo FROM empleado WHERE(sueldo>20000);
--e SELECT AVG(sueldo) FROM empleado, departamento, trabajapara WHERE(departamento.nombre='COMPUTOS' AND trabajapara.codigo=departamento.codigo AND empleado.dni=trabajapara.dni);
--f SELECT SUM(trabajapara.horas) FROM trabajapara, departamento WHERE(departamento.nombre='PRODUCCION' AND trabajapara.codigo=departamento.codigo);
--g SELECT empleado.nombre FROM empleado, departamento, trabajapara WHERE(empleado.dni=trabajapara.dni AND departamento.nombre='DEPOSITO' AND departamento.codigo=trabajapara.codigo AND trabajapara.horas>6);
--h SELECT DISTINCT em.nombre, em.apellido, em.dni, de.nombre FROM empleado em, trabajapara tr, departamento de WHERE(em.dni=tr.dni AND tr.codigo=de.codigo);

-------------------- Otros ejercicios --------------------

--Listar dni, apellio, nombre, sueldo de los empleados que ganan entre 20000 y 32000.
--i SELECT em.dni, em.apellido, em.nombre, em.sueldo FROM empleado em WHERE(em.sueldo BETWEEN 2000 AND 32000);
--Listar empleados cuyos apellidos comiencen con "R"
--j SELECT* FROM empleado WHERE(empleado.apellido LIKE 'R%');
-- Ordenar la consulta del ejercicio "i" por apellido, nombre en forma ascendente (por defecto) y descendente.
--k a SELECT em.dni, em.apellido, em.nombre, em.sueldo FROM empleado em WHERE(em.sueldo BETWEEN 20000 AND 32000) ORDER BY(em.apellido, em.nombre);
--k b SELECT em.dni, em.apellido, em.nombre, em.sueldo FROM empleado em WHERE(em.sueldo BETWEEN 20000 AND 32000) ORDER BY(em.apellido, em.nombre) DESC;
--Promedio de sueldo de empleados por genero.
--l SELECT AVG(sueldo), genero FROM empleado GROUP BY(genero);
--Cantidad de horas trabajadas por departamento
--ll SELECT SUM(tr.horas) FROM trabajapara tr, departamento de GROUP BY(tr.codigo=de.codigo);
