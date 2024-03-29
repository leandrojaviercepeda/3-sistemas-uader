(DEFUN LISTANumFrec(L) (ORDENAR (ELIMparesREPETIDOS(LISTAdePARES (APLANARLISTA L)))))

(DEFUN ORDENAR (L)
  (COND
  ((NULL L) NIL)
  (T (CONS (VALOR L (LAMBDA (X Y) (OR (< (SEGUNDO X) (SEGUNDO Y)) (= (SEGUNDO X) (SEGUNDO Y))))) 
           (ORDENAR (ELIM L (VALOR L (LAMBDA (X Y)(OR (< (SEGUNDO X) (SEGUNDO Y)) (= (SEGUNDO X) (SEGUNDO Y)))))))))))

(DEFUN IGUALDAD (N1 N2)
  (COND
   ((AND (= (PRIMERO N1) (PRIMERO N2)) (= (SEGUNDO N1)) (SEGUNDO N2)))
   (T NIL)))

(DEFUN ELIM (L N)
  (COND
   ((NULL L) NIL)
   ((IGUALDAD (FIRST L) N) (ELIM (REST L) N))
   (T (CONS (FIRST L) (ELIM (REST L) N)))))

(DEFUN VALOR(L CONDICION)
  (COND
  ((NULL (REST L)) (FIRST L))
  ((FUNCALL CONDICION (FIRST L) (FIRST (REST L))) (VALOR (CONS (FIRST L) (REST (REST L))) CONDICION))
  (T (VALOR (REST L) CONDICION))))

(DEFUN ELIMparesREPETIDOS(L)
  (COND
   ((NULL L) NIL)
   (T (CONS (FIRST L) (ELIMparesREPETIDOS (ELIMINAR L (PRIMERO (FIRST L))))))))

(DEFUN ELIMINAR(L N)
  (COND
   ((NULL L) NIL)
   ((= (PRIMERO (FIRST L)) N) (ELIM (REST L) N))
   (T (CONS (FIRST L) (ELIM (REST L) N)))))

(DEFUN LISTAdePARES (L)
  (COND
   ((NULL L) NIL)
   (T (CONS (PAROnumFRECUENCIA L (FIRST L)) (LISTAdePARES (REST L))))))

;PARES ORDENADOS
(DEFUN PAROnumFRECUENCIA(L N) (CONS N (CONS (FRECUENCIA L N) NIL)))
(DEFUN PRIMERO(PARO) (FIRST PARO))
(DEFUN SEGUNDO(PARO) (FIRST (REST PARO)))
;LISTAS
(DEFUN APLANARLISTA(L)
  (COND
   ((NULL L) NIL)
   ((ATOM (FIRST L)) (CONS (FIRST L) (APLANARLISTA (REST L))))
   (T (CONCATENAR (APLANARLISTA (FIRST L)) (APLANARLISTA (REST L))))))
(DEFUN CONCATENAR(N L)
  (COND
   ((NUMBERP N) (CONS N L))
   (T (APPEND N L))))
;FRECUENCIA
(DEFUN FRECUENCIA (L N)
  (COND
   ((NULL L) 0)
   ((= (FIRST L) N) (+ 1 (FRECUENCIA (REST L) N)))
   (T (FRECUENCIA (REST L) N))))
