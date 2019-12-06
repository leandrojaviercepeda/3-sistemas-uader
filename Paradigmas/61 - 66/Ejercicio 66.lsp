; MANEJO ALUMNOS
;agregar alumno
(DEFUN AGREGARALUMNO (LISTA ALUMNO) (APPEND LISTA (LIST ALUMNO)))

;devolver info
(DEFUN ACODIGOALUMNO(ALUMNO) (nELEM (ALUMNO 1)))
(DEFUN ACARRERA(ALUMNO) (nELEM (ALUMNO 2)))
(DEFUN AANIOINGRESO(ALUMNO) (nELEM (ALUMNO 3)))
(DEFUN ACODIGOPERSONA(ALUMNO) (nELEM (ALUMNO 4)))

(DEFUN nELEM (L N)
  (COND
   ((NULL L) NIL)
   ((= N 1) (FIRST L))
   (T (nELEM (REST L) (- N 1)))))

;MANEJO CURSADAS
;agregar cursada
(DEFUN AGREGARCURSADA (LISTA CURSADA) (APPEND LISTA (LIST CURSADA)))

;devolver info
(DEFUN CCODIGOALUMNO(CURSADA) (nELEM (CURSADA 1)))
(DEFUN CCODIGOMATERIA(CURSADA) (nELEM (CURSADA 2)))
(DEFUN CESTADO(CURSADA) (nELEM (CURSADA 3)))
(DEFUN CFECHA(CURSADA) (nELEM (CURSADA 4)))
(DEFUN CULTIMANOTA(CURSADA) (nELEM (CURSADA 5)))

;FUNCIONES
;A
(DEFUN CantidadMateriasPromocionadas (ListaCursadas codigoAlumno)
  (COND
   ((NULL ListaCursadas) NIL)
   ((AND (= (CCODIGOALUMNO (FIRST L)) codigoAlumno) (= (CESTADO (FIRST L)) (FIRST '(PROMOCIONADA)))) (CONS (FIRST L) (CantidadMateriasPromocionadas (REST ListaCursadas) codigoAlumno)))
   (T (CantidadMateriasPromocionadas (REST ListaCursadas) codigoAlumno))))
;B
(DEFUN PROMEDIOalumno (ListaCursadas codigoAlumno) (PROMEDIO (CURSADASporALUMNO ListaCursadas codigoAlumno)))
(DEFUN CURSADASporALUMNO (ListaCursadas codigoAlumno)
  (COND
   ((NULL ListaCursadas) NIL)
   ((= (CCODIGOALUMNO (FIRST L)) codigoAlumno)  (CONS (CULTIMANOTA (FIRST L)) (CURSADASporALUMNO (REST ListaCursadas) codigoAlumno)))
   (T (CURSADASporALUMNO (REST ListaCursadas) codigoAlumno))))
;C
(DEFUN ALUMNOPROMEDIO (ListaCursadas codigoAlumno) (CONS (codigoalumno) (LIST(PROMEDIOalumno (ListaCursadas codigoAlumno)))))
(DEFUN LISTASALUMNOPROMEDIO (ListaCursadas ListaAlumnos)
  (COND
   ((NULL ListaAlumnos) NIL)
   (T (CONS (ALUMNOPORMEDIO ListaCursadas (ACODIGOALUMNO (FIRST L))) (LISTASALUMNOPROMEDIO ListaCursadas (REST ListaAlumnos))))))

(DEFUN NOMBREALUMNOMEJORPROMEDIO (ListaCursadas ListaAlumnos) 
  (COND
   ((NULL (BUSCARALUMNO ListaCursadas (MEJORPROMEDIO (LISTASALUMNOPROMEDIO ListaCursadas ListaAlumnos) (FIRST (LISTASALUMNOPROMEDIO ListaCursadas ListaAlumnos))))) NIL)
   (T (ACODIGOPERSONA (BUSCARALUMNO ListaCursadas (MEJORPROMEDIO (LISTASALUMNOPROMEDIO ListaCursadas ListaAlumnos)))))))

(DEFUN MEJORPROMEDIO (L ALUMNO)
  (COND
   ((NULL L) ALUMNO)
   ((> (FIRST (REST (FIRST L))) (FIRST (REST ALUMNO))) (MEJORPROMEDIO (REST L) (FIRST L)))
   (T (MEJORPROMEDIO (REST L) ALUMNO)))) 

(DEFUN BUSCARALUMNO (ListaAlumnos codigoAlumno)
  (COND
   ((NULL ListaAlumnos) NIL)
   ((= (ACODIGOALUMNO (FIRST L)) codigoAlumno) (FIRST L))
   (T (BUSCARALUMNO (REST ListaAlumnos) codigoAlumno))))

;EXTRAS
(DEFUN CANTIDAD (L)
  (COND
   ((NULL L) 0)
   (T (+ 1 (CANTIDAD (REST L))))))
(DEFUN PROMEDIO (L) (/ (SUMATORIA L) CANTIDAD L))
(DEFUN SUMATORIA (L)
  (COND
   ((NULL L) 0)
   (T (+ (FIRST L) (SUMATORIA (REST L))))))
