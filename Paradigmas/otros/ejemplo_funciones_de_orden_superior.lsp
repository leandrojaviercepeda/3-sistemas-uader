(DEFUN CONTARSI(L CONDICION)
  (COND
   ((NULL L) 0)
   ((FUNCALL CONDICION (FIRST L)) (+ 1 (CONTARSI (REST L) CONDICION)))
   (T (CONTARSI (REST L) CONDICION))))